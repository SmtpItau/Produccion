USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_ARTICULO84]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from ART84_DERIVADOS_TRASPASO    


CREATE PROCEDURE [dbo].[SP_INTERFAZ_ARTICULO84]  
AS  
BEGIN  
  
     SET NOCOUNT ON   
  
  
          DECLARE  @fecha_sal    DATETIME  
                  ,@fecproc      DATETIME   
                  ,@PrimerDiaMes DATETIME  
                  ,@RutDeudor    CHAR(10)   
                  ,@Modulo       CHAR(03)   
                  ,@Tipoper      CHAR(10)   
                  ,@Moneda       NUMERIC (05)     
                  ,@Monto        NUMERIC (19,4)   
                  ,@Fec_Proc     DATETIME   
                  ,@DolarObsFMes NUMERIC(19,4)  
                  ,@UFFMes       NUMERIC(19,4)  
                  ,@OtraMonMes   NUMERIC(19,4)                    
                  ,@DigVerif     CHAR (01)   
    
  
  
  
          SELECT @fecproc = acfecproc  
          FROM   MDAC  

	 
  
          SELECT @PrimerDiaMes = SUBSTRING( ( convert(char(8), @fecproc , 112))  ,1,6)  + '01'  
  
          EXECUTE  SP_BACKHABIL @PrimerDiaMes,6,@fecha_sal output,'S'  
  
          --> 06 Junio 2008 (Solicitado por Carlos Basterrica)  
          --> SELECT  @DolarObsFMes = vmvalor FROM view_valor_moneda WHERE vmfecha = @fecha_sal and vmcodigo = 994  
                 SET  @DolarObsFMes = ( SELECT Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Fecha = @fecha_sal AND Codigo_Moneda = 994 )  
          --> 06 Junio 2008 (Solicitado por Carlos Basterrica)  
  
          SELECT  @UFFMes       = vmvalor FROM view_valor_moneda WHERE vmfecha = @fecha_sal and vmcodigo = 998  
  
--**********************************************************************************************************************************************************************  
            TRUNCATE TABLE  Margen_Articulo84  
  
            EXECUTE SP_CARGA_TABLA_ART84BTR        
            EXECUTE BacBonosExtSuda..SP_CARGA_TABLA_ART84BEX   
			EXECUTE BacBonosExtNY..SP_CARGA_TABLA_ART84BEX  --> prd-21039 Bonex NY
			     
--            EXECUTE BacFwdSuda..Sp_Carga_Tabla_Art84BFW   20090114 - Req. Modificación Cálculo Art84 y Reporte Basilea Derivados(Normativo)  
--            EXECUTE BacSwapSuda..Sp_Carga_Tabla_Art84PCS  20090114 - Req. Modificación Cálculo Art84 y Reporte Basilea Derivados(Normativo)      
--**********************************************************************************************************************************************************************  
  
  
          CREATE TABLE #TempArt84  
          (  
          RutDeudor     CHAR (15)      ,                        -- 1  
          Modulo        CHAR (10)      ,                        -- 2  
          Tipoper       CHAR (10)      ,                        -- 3    
          Moneda        NUMERIC (05)   ,                        -- 4  
          Monto         NUMERIC(18) NULL DEFAULT (0),           -- 5  
          Fec_Proc      CHAR (08) --DATETIME                                   -- 6   
          )  
  
              
  
          
  
          DECLARE CURSOR_INTER CURSOR FOR   
           SELECT   RutDeudor  
                   ,Modulo  
                   ,Tipoper  
                   ,Moneda    
                   ,Monto  
                   ,Fec_Proc  
           FROM Margen_Articulo84  
  
            OPEN CURSOR_INTER  
            FETCH NEXT FROM CURSOR_INTER  
            INTO       @RutDeudor  
                      ,@Modulo  
                      ,@Tipoper  
                      ,@Moneda    
                      ,@Monto  
                      ,@Fec_Proc  
  
   WHILE @@FETCH_STATUS  = 0  
   BEGIN   
  
            IF  @Modulo <> 'BFW' and @Modulo <> 'PCS'  
               IF  @Moneda <> 999 AND @Moneda <> 994 --> Para Corregir Bono Reajustable 994 . 31-05-2011  
  
                  IF  @Moneda = 13  
                      SELECT @Monto = @Monto * @DolarObsFMes  
                          
                  ELSE IF @Moneda = 998 AND @Modulo <> 'BTR'  
                       BEGIN                       
                         SELECT @Monto = @Monto * @UFFMes         
                       END  
                  ELSE IF @Moneda <> 998 AND @Moneda <> 13 AND (@Modulo <> 'BTR' AND @Moneda <> 994) --> Para Corregir Bono Reajustable 994 . 31-05-2011  
                       BEGIN  
                           SELECT @OtraMonMes =  vmvalor FROM view_valor_moneda WHERE vmfecha = @fecha_sal and vmcodigo = @Moneda  
                           --> 06 Junio 2008 (Solicitado por Carlos Basterrica)  
                           IF @Moneda <> 999 AND @Moneda <> 998  
                              SET @OtraMonMes = (SELECT tipo_cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE fecha = @fecha_sal AND codigo_moneda = @Moneda)  
                           --> 06 Junio 2008 (Solicitado por Carlos Basterrica)  
                           SELECT @Monto = @Monto * @OtraMonMes  
                        END  
  
                  SELECT @RutDeudor = RTRIM(CONVERT(CHAR(9), clrut )) + cldv FROM VIEW_CLIENTE WHERE Clrut = @RutDeudor   
  
                  IF  @Modulo='BTR' AND @Tipoper ='CP'   
                           SELECT @Tipoper ='PropiaML'          
    
                  IF  @Modulo='BTR' AND @Tipoper ='CI'   
                           SELECT @Tipoper ='Pactos'             
           
                  IF  @Modulo='BTR' AND @Tipoper ='IB'   
                           SELECT @Tipoper ='InterbIcol'             
     
                  IF  @Modulo='BEX'   
                           SELECT @Tipoper ='PropiaMx'             
                                                                    
  
-- 20090114 - Se comenta por Req. Modificación Cálculo Art84 y Reporte Basilea Derivados(Normativo)                
/*                                                      
                  IF  @Modulo='BFW'   
                     SELECT @Tipoper ='FWD'             
    
                  IF  @Modulo='PCS'   
                           SELECT @Tipoper ='SWAP'             
  
*/                        
                        
  
                  INSERT #TempArt84   
                  VALUES (  
                          @RutDeudor  
                         ,CASE WHEN @Modulo='BTR' AND @Moneda <>13 THEN 'BonosML'  
                               WHEN @Modulo='BEX' OR (@Modulo='BTR' AND @Moneda =13)THEN 'BonosMX'  
                               WHEN @Modulo='BFW' THEN 'Forward'  
                               ELSE 'Swap' END  
                         ,@Tipoper    
                         ,@Moneda   
                         ,ROUND(ISNULL(@Monto,0),0)  
                         ,CONVERT( CHAR(08),@Fec_Proc,112)  
                         )                                        
  
            FETCH NEXT FROM CURSOR_INTER  
            INTO       @RutDeudor  
                      ,@Modulo  
                      ,@Tipoper  
                      ,@Moneda    
                      ,@Monto  
                      ,@Fec_Proc  
  
  
            END  
            CLOSE CURSOR_INTER  
            DEALLOCATE  CURSOR_INTER  
  
  
-- 20090114 - Req. Modificación Cálculo Art84 y Reporte Basilea Derivados(Normativo)  
  
-- 30/04/2009  ' Se modifica para agregar módulo Opciones a Artículo 84    
  
         EXECUTE SP_CALCULA_ART84_DERIVADOS @fecproc  
  
         INSERT INTO #TempArt84  
         SELECT  RutDeudor         
                ,Modulo        
                ,Tipoper      
                ,Moneda    
                ,Monto                  
                ,Fec_Proc   
         FROM ART84_DERIVADOS_TRASPASO  
-- 30/04/2009  ' Se modifica para agregar módulo Opciones a Artículo 84    
       
         SELECT RutDeudor  
               ,Modulo  
               ,Tipoper  
               ,RIGHT('000000000000000000'+CONVERT(VARCHAR(118),SUM(Monto)),18)-- SUM(Monto)  
               ,Fec_Proc  
         FROM #TempArt84      
         GROUP BY  RutDeudor  
                  ,Modulo  
                  ,Tipoper  
                  ,Fec_Proc   
         ORDER BY RutDeudor  
  
         DELETE FROM RESUMEN_ART84_DERIVADOS  
         WHERE  Fecha_Proc = @fecproc      
         
  
         INSERT INTO RESUMEN_ART84_DERIVADOS  
         SELECT Fec_Proc     
              , CONVERT(NUMERIC(09),SUBSTRING (RutDeudor,1,len(RutDeudor)-1)) --RutDeudor  
              , ClCodigo  
   , (CASE WHEN  Cltipcli = 1 THEN 3 ELSE 5 END)   
              , Modulo  
              , SUM(Monto)  
              , (CASE WHEN Cltipcli = 1 THEN SUM(Monto) ELSE 0 END)  
              , (CASE WHEN Cltipcli <> 1 THEN SUM(Monto) ELSE 0 END)  
         FROM #TempArt84      
          ,   BacParamSuda..cliente  
  
         WHERE CONVERT(NUMERIC(09),SUBSTRING (RutDeudor,1,len(RutDeudor)-1)) = clrut  
         AND   clcodigo = 1  
         GROUP BY  RutDeudor  
                  ,ClCodigo  
                  ,Cltipcli  
                  ,Fec_Proc   
                  ,Modulo  
  
  
     SET NOCOUNT OFF  
  
END

GO
