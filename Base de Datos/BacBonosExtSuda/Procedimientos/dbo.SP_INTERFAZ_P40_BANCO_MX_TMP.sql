USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_P40_BANCO_MX_TMP]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create  PROCEDURE [dbo].[SP_INTERFAZ_P40_BANCO_MX_TMP]  
 ( @Fecha_Interfaz DATETIME )  
AS    
BEGIN     
    
   -- SP_INTERFAZ_P40_BANCO_MX_TMP '20200615'  
  
   SET NOCOUNT ON  
  
 DECLARE @Fecha_Proceso   DATETIME  
 DECLARE @rut_entidad     VARCHAR(12)  
 DECLARE @RutCorpBanca    VARCHAR(12)  
 DECLARE @fecha_desde     DATETIME  
 DECLARE @fecha_hasta     DATETIME  
 DECLARE @codigo_banco    VARCHAR(3)  
 DECLARE @dFechaProxima   DATETIME  
    
 SELECT  @Fecha_Proceso   = acfecproc    
 ,  @rut_entidad     = acrutprop    
    ,  @RutCorpBanca    = LTRIM(RTRIM(acrutprop)) + LTRIM(RTRIM(Clie.cldv))    
 FROM    TEXT_ARC_CTL_DRI with(nolock)  
   INNER JOIN ( SELECT clrut, cldv, clcodigo, clnombre, cltipcli  
       FROM BacParamSuda.dbo.CLIENTE with(nolock)   
      ) Clie ON Clie.clrut = acrutprop and Clie.clcodigo = 1    
  
  
 CREATE TABLE #TABLA_P40     
 (  Tipo_Registro          varchar(2)  NOT NULL ,       --1    
   Codigo_Tenedor         char(3)  NOT NULL ,       --2    
   Fecha_Proceso          char(8)    NULL ,       --3    
   Fecha_Compra           char(10)    NULL ,       --4    
   Tipo_Cartera           numeric(5, 0)   NOT NULL ,       --5    
   Emisor                 varchar (10)   NULL ,       --6    
   Pais_Emisor            int    NOT NULL ,       --7    
   Familia_Instrumento    VARCHAR(2)  NOT NULL ,       --8    
   Nemotecnico            char (20)   NULL ,       --9    
   Tipo_Rendimiento       int    NOT NULL ,       --10    
   Periodicidad_Cupon     decimal(5, 0)  NULL ,       --11    
   Fecha_Ultimo_Cupon     char (8)    NULL ,       --12    
   Fecha_Proximo_Cupon    char (8)    NULL ,       --13    
   Fecha_Vcto_Instr       char (8)    NULL ,       --14    
   Derivado_Incrust_Opc   char(2)   NOT NULL ,       --15    
   Nominal_Inicial        numeric(19, 4)  NULL ,       --16    
   Nominal_Actual         numeric(19, 4)  NULL ,       --17    
   Moneda_Emision         numeric(3, 0) NOT NULL ,       --18    
   Moneda_Reajuste        VARCHAR(3)  NOT NULL ,       --19    
   Tipo_Tasa_Emision      char(7)    NULL ,       --20    
   Tasa_Emision           numeric(9, 4) NOT NULL ,       --21    
   Tera                   decimal(8, 4)  NULL ,       --22    
   Valor_Par              numeric(18,4)  NULL ,       --23    
   Tipo_Tasa_Compra       char(7)    NULL ,       --24    
   Tasa_Compra            numeric(9, 4) NOT NULL ,       --25    
   Costo_Adquisicion      numeric(19, 4) NOT NULL ,       --26    
   Costo_Amortizado       numeric(14, 0)  NULL ,       --27    
   Valor_Razonable        numeric(19, 4)  NULL ,       --28    
   Tipo_Tasa_Valoriza     char(7)    NULL ,       --29    
   Tasa_Valorizacion      numeric(19, 4)  NULL ,       --30    
   Tipo_valorizacion      int    NOT NULL ,       --31    
   Precio_Instrumento     float,-- numeric(6, 2) NOT NULL ,       --32 (19, 8)    
  
   Duracion_Modificada    numeric(24,8)   NOT NULL ,       --33    
   Convexidad             numeric(24,8)   NOT NULL ,       --34    
  
   Valor_Deterioro        numeric(14, 0)  NULL ,       --35    
   Condicion_Instrumento  int    NOT NULL ,       --36    
   Fecha_Inicio_Cond      char (8)    NULL ,       --37    
   Fecha_Final_Cond       char (8)    NULL ,       --38    
    
   iCantidad      INT     NULL ,  
   signoTCmp      CHAR(1)   NOT NULL,    
   signoTVal      CHAR(1)   NOT NULL,  
  
   Cartera     numeric(5, 0)  NOT NULL ,       --39            
   numero_Documento       numeric(10, 0) NOT NULL ,   --40  
   Correlativo            numeric(10, 0) NOT NULL ,   --41  
  
   Numero_Operacion       numeric(10, 0) NOT NULL ,       --42  
  
   Seriado                CHAR(1)   NOT NULL ,       --43  
   Codigo                 INT    NOT NULL ,       --44  
   Serie                  VARCHAR(20)  NOT NULL ,       --45  
   FecCupVen              DATETIME   NOT NULL ,       --46  
   FechaEmision           DATETIME   NOT NULL ,       --47  
   NomOriginal            NUMERIC(21,4) NOT NULL ,    
   RsIdentCod_Id          NUMERIC(10)      NOT NULL ,  
   Familia         NUMERIC(10)      NOT NULL ,  
   IdFila                 INT    Identity(1, 1)    
  
     
    ------@iCantidad  ,        
    ------signoTCmp,  
    ------signoTVal,  
  
    ------Filler,  
    ------numero_Documento  ,    --40  
    ------Correlativo              
  
   /*  
   ,  iCantidad    = dbo.Fx_ReplicaId(Ret.iCantidad, ROW_NUMBER() over( order by Ret.iCantidad desc )) --39  
   ,  signoTCmp    = Ret.signoTCmp              --40  
   ,  signoTVal    = Ret.signoTVal              --41  
   ,  cartera     = ret.cartera  
   ,  numdocu     = ret.numdocu  
   ,  numoper     = ret.numoper  
   ,  estado     = ret.estado  
   ,  Seriado     = convert(char(1), Ret.Seriado)  
   ,  Valor_mercado   = convert(numeric(19,4),Ret.Valor_mercado)  
   -----  
   ,   signoTCmp     = CASE WHEN TmpP40.Tasa_Compra       >= 0 THEN '+' ELSE '-' END                                                        -- 35. Signo Tasa Compra      
   ,   signoTVal     = CASE WHEN TmpP40.Tasa_Valorizacion >= 0 THEN '+' ELSE '-' END    
       
   */  
 )     
  
 INSERT INTO  #TABLA_P40    
 SELECT 'Tipo_Registro'   = '01'                        --  1  
  ,   'Codigo_Tenedor'  = '039'-- @RutCorpBanca                      --  2  
  ,   'Fecha_Proceso'   = CONVERT(CHAR(8),@Fecha_Interfaz, 112)                --  3  
  ,   'Fecha_Compra'   = CONVERT(CHAR(8), rsu.rsfeccomp,  112)                --  4  
  ,   'Tipo_Cartera'   = ISNULL( CASE WHEN rsu.codigo_carterasuper = 'A' THEN 3  
             WHEN rsu.codigo_carterasuper = 'P' THEN 2  
             WHEN rsu.codigo_carterasuper = 'T' THEN 1  
             WHEN rsu.codigo_carterasuper = 'R' THEN 1  
             ELSE                                     2  
            END,0)          -- (5)tipo_cartera   
    
    
                         --  5  
  ,   'Emisor'    = LTRIM(RTRIM( rsu.rsrutemis )) + LTRIM(RTRIM( emi.digito_ver))          --  6  
  ,   'Pais_Emisor'   = 160                        --  7  
  
  ,   'Familia_Instrumento' = case when cli.clpais <> 6 then  
            case when cli.cltipcli = 1 then '52'  
              when cli.cltipcli = 2 then '52'  
              when cli.cltipcli = 10 then '51'  
              else       '99'  
             end  
           else   
            case when cli.cltipcli = 1 then '08'  
              else       '99'  
             end  
          end  
  
--  ,   'Familia_Instrumento' = CASE WHEN cli.clpais <> 6 THEN '51' ELSE '50' END          --  8  
             
  ,   'Nemotecnico'   = CONVERT(CHAR(20), ' ') --> ide.scusip                --  9  
  ,   'Tipo_Rendimiento'  = 2                         -- 10  
  ,   'Periodicidad_Cupon' = CASE WHEN per_cupones = 1  THEN 1  
           WHEN per_cupones = 3  THEN 2  
           WHEN per_cupones = 4  THEN 3  
           WHEN per_cupones = 6  THEN 4  
           WHEN per_cupones = 12 THEN 5  
           ELSE                       6  
          END                        -- 11    
  ,   'Fecha_Ultimo_Cupon' = CONVERT(CHAR(08), rsu.rsfecucup, 112)                -- 12    
    ,   'Fecha_Proximo_Cupon' = CASE WHEN rsu.cod_familia = 2001 THEN CONVERT(CHAR(08), rsu.rsfecvcto, 112)  
           WHEN rsu.cod_familia = 2003 THEN CONVERT(CHAR(08), rsu.rsfecvcto, 112)  
           ELSE                             CONVERT(CHAR(08), rsu.rsfecpcup, 112)      -- 13    
          END    
    
  ,   'Fecha_Vcto_Instr'  = CONVERT(CHAR(08), rsu.rsfecvcto, 112)                -- 14    
  ,   'Derivado_Incrust_Opc' = '01'                        -- 15    
  ,   'Nominal_Inicial'  = CONVERT(NUMERIC(19,4), rsu.rsnominal)                -- 16    
  ,   'Nominal_Actual'  = CONVERT(NUMERIC(19,4), rsu.rsnominal)                -- 17    
  ,   'Moneda_Emision'  = rsu.rsmonemi                      -- 18    
  ,   'Moneda_Reajuste'  = rsu.rsmonemi                      -- 19    
  ,   'Tipo_Tasa_Emision'  = CASE WHEN DATEDIFF(DAY, ser.fecha_emis, ser.fecha_vcto) > 365 THEN '12PC000' ELSE '11PC000' END -- 20    
  ,   'Tasa_Emision'   = rsu.rstasemi             -- 21    
  ,   'Tera'     = 0.0                                                                                               -- 22    
  ,   'Valor_Par'    = (rsnominal + rsinteres_acum)                                                                      -- 23    
  ,   'Tipo_Tasa_Compra'  = CASE WHEN DATEDIFF(DAY, ser.fecha_emis, ser.fecha_vcto) > 365 THEN '12PC000' ELSE '11PC000' END  -- 24     
  ,   'Tasa_Compra'   = rsu.rstir                                                                                         -- 25    
  ,   'Costo_Adquisicion'  = ROUND( (rsu.rsvalcomu * vcom.vmvalor), 0)               -- 26    
  ,   'Costo_Amortizado'  = CASE WHEN rsu.codigo_carterasuper = 'A' THEN ROUND((rsu.rsvalcomu * vcom.vmvalor), 0)    
           ELSE                                  0     
          END                                                                                             -- 27    
  ,   'Valor_Razonable'  = ROUND( (rsu.rsvalmerc * vmon.Tipo_Cambio), 0)              -- 28    
  ,   'Tipo_Tasa_Valoriza' = CASE WHEN DATEDIFF(DAY, ser.fecha_emis, ser.fecha_vcto) > 365 THEN '12PC000' ELSE '11PC000' END   -- 29    
  ,   'Tasa_Valorizacion'  = ISNULL(rsu.rstirmerc, 0)                                                                          -- 30    
  ,   'Tipo_valorizacion'  = 2                                                                                                 -- 31    
  , 'Precio_Instrumento' = isnull( round(rsu.rspvp, 2), round(rsu.rstir, 2))                                                 -- 32  
  ,   'Duracion_Modificada' = round(isnull(rsu.DurModificada, 0), 8)               -- 33   
  ,   'Convexidad'   = round(isnull(rsu.Convexidad,    0), 8)               -- 34    
  ,   'Valor_Deterioro'  = CONVERT(NUMERIC(14),0)                                                                            -- 35    
  ,   'Condicion_Instrumento' = 1                                                                                                 -- 36    
  ,   'Fecha_Inicio_Cond'  = '        '                                                                                        -- 37    
  ,   'Fecha_Final_Cond'  = '        '                                                                                        -- 38    
  , 'iCantidad'    = 0  
  ,   'signoTCmp'     = CASE WHEN rsu.rstir     >= 0 THEN '+' ELSE '-' END                                                        -- 35. Signo Tasa Compra      
  ,   'signoTVal'     = CASE WHEN RSU.rstirmerc >= 0 THEN '+' ELSE '-' END    
  
  ,   'Cartera'     = rsu.rscartera                                                                                              -- 39    
  ,   'Numero_Documento'   = rsu.rsnumdocu                                                                                     -- 40    
  ,   'Correlativo'    = rsu.rscorrelativo                                                                                 -- 41    
   
  ,   'Numero_Operacion'   = rsu.rsnumoper                                                                                     -- 42    
   -->>>> Agregado para su uso mas adelante <<<<--    
  ,   'Seriado'    = 'S'                                                                                               -- 43    
  ,   'Codigo'    = rsu.cod_familia                                                                                       -- 44    
  ,   'Serie'     = rsu.cod_nemo                                                                                          -- 45    
  ,   'FecCupVen'    = rsu.rsfecucup                                                                                         -- 46    
  ,   'FechaEmision'   = rsu.rsfecemis                                                                                         -- 47    
  , 'NomOriginal'   = rsu.rsnominal      
  ,   'RsIdentCod_Id'         = Car.cusip                                                                      -- 48   
  ,   'Familia'               = rsu.cod_familia   
   -->>>> Agregado para su uso mas adelante <<<<--    
   FROM   BacBonosExtSuda..TEXT_RSU                       rsu    
          INNER JOIN BacBonosExtSuda..TEXT_EMI_ITL        emi ON emi.rut_emi   = rsu.rsrutemis    
          LEFT  JOIN BacParamSuda..CLIENTE                cli ON cli.clrut     = rsu.rsrutemis    
          LEFT  JOIN BacBonosExtSuda..TEXT_SER            ser ON rsu.cod_nemo  = ser.cod_nemo    
          LEFT  JOIN BacParamSuda..VALOR_MONEDA_CONTABLE vmon ON vmon.fecha    = @Fecha_Interfaz     
               AND  Codigo_Moneda  = CASE WHEN rsu.rsmonemi = 13 THEN 994 ELSE  rsu.rsmonemi /*rstasemi */ END    
          LEFT  JOIN BacParamSuda..VALOR_MONEDA          vcom ON vcom.vmfecha  = rsfeccomp    
                                                            AND  vcom.vmcodigo = CASE WHEN rsu.rsmonemi = 13 THEN 994 ELSE rsu.rsmonemi /*rstasemi */ END    
          LEFT  JOIN BacBonosExtSuda..text_ctr_inv       Car ON Car.cpnumdocu  = rsu.rsnumdocu -- 20160805 MNAVARRO  
        
   WHERE  rsfecpro  = @Fecha_Interfaz    
   AND   ( rsfecpago < @Fecha_Interfaz  )  
   AND    rsnominal > 0    
   AND   (  rstipoper = 'DEV'   )  
  
  
  /*  
select*   FROM BacBonosExtSuda..TEXT_IDENT  
   select * from BacBonosExtSuda..TEXT_SER  
   select * from BacBonosExtSuda..text_ctr_inv       
   select 'sacar',  cusip, c.cpnumdocu, cpnominal, cpfeccomp, cpfecven, * from BacBonosExtSuda..text_ctr_inv c order by convert( numeric(10),  c.cpnumdocu )  
  */  
   DECLARE @iFilas      NUMERIC(9)    
   DECLARE @iContador   NUMERIC(9)    
   DECLARE @Cod_id      NUMERIC(9)  -- 20160805 MNAVARRO  
  
       SET @iFilas      = (SELECT MAX(IdFila) FROM #TABLA_P40)    
       SET @iContador   = 1    
    
   DECLARE @Cod_Nemo    CHAR(20)    
       SET @Cod_Nemo    = ''    
   DECLARE @sCusip      VARCHAR(15)    
       SET @sCusip      = ''    
    
   WHILE @iFilas >= @iContador    
   BEGIN    
      SET @Cod_Nemo = (SELECT DISTINCT Serie              FROM #TABLA_P40                  WHERE IdFila   = @iContador)    
   SET @Cod_id   = (SELECT DISTINCT RsIdentCod_Id      FROM #TABLA_P40                  WHERE IdFila   = @iContador)    
      -- SET @sCusip   = isnull((SELECT MAX(scusip)  FROM BacBonosExtSuda..TEXT_IDENT WHERE cod_nemo = @Cod_Nemo AND scusip <> ''), '')    
      -- usar ahora RsIdentCod_Id  
      SET @sCusip   = isnull((SELECT MAX(sIsin)  FROM BacBonosExtSuda..TEXT_IDENT WHERE cod_Id = @Cod_id AND scusip <> ''), @Cod_Nemo)  --isnull((SELECT MAX(scusip)  FROM BacBonosExtSuda..TEXT_IDENT WHERE cod_Id = @Cod_id AND scusip <> ''), '')    
  
      UPDATE #TABLA_P40 SET Nemotecnico = @sCusip WHERE IdFila = @iContador    
    
      SET @iContador = @iContador + 1    
   END    
    
    
   /*    
   ***********************************    
      Actualiza    
   ***********************************    
   */    
         
      UPDATE #TABLA_P40     
         SET Moneda_Reajuste = CASE WHEN Moneda_Reajuste = 998 THEN '2'    
         WHEN Moneda_Reajuste = 997 THEN '3'    
                                    WHEN Moneda_Reajuste = 994 THEN '4'    
                                    WHEN Moneda_Reajuste = 994 THEN '4'    
                                    WHEN Moneda_Reajuste = 999 THEN 'CLP'    
                                    ELSE                          '13'---  mnnemo    
                               END    
       FROM  BacParamSuda..MONEDA    
      WHERE  mncodmon        = Moneda_Reajuste    
    
      UPDATE #TABLA_P40     
         SET Tipo_Tasa_Emision = REPLACE(Tipo_Tasa_Emision, 'PC' ,   
   CASE WHEN per_cupones   = 1   THEN '1'    
    WHEN per_cupones   = 3   THEN '2'    
    WHEN per_cupones   = 4   THEN '3'    
    WHEN per_cupones   = 6   THEN '4'    
    WHEN per_cupones   = 12  THEN '5'    
    ELSE                          '9'    
    END    
    + CASE WHEN base_tasa_emi = 360 THEN '1'    
    WHEN base_tasa_emi = 365 THEN '2'    
    WHEN base_tasa_emi = 30  THEN '3'    
    ELSE                          '9'    
    END),  
   Tipo_Tasa_Compra  = REPLACE(Tipo_Tasa_Compra,  'PC' ,   
   CASE WHEN per_cupones   = 1   THEN '1'    
    WHEN per_cupones   = 3   THEN '2'    
    WHEN per_cupones   = 4   THEN '3'    
    WHEN per_cupones   = 6   THEN '4'    
    WHEN per_cupones   = 12  THEN '5'    
    ELSE                          '9'    
    END     
         + CASE WHEN base_tasa_emi = 360 THEN '1'    
    WHEN base_tasa_emi = 365 THEN '2'    
    WHEN base_tasa_emi = 30  THEN '3'    
    ELSE '9'    
    END)    
         ,Tipo_Tasa_Valoriza = REPLACE(Tipo_Tasa_Valoriza,'PC' ,   
   CASE WHEN per_cupones   = 1   THEN '1'    
     WHEN per_cupones   = 3   THEN '2'    
     WHEN per_cupones   = 4   THEN '3'    
     WHEN per_cupones   = 6   THEN '4'    
     WHEN per_cupones   = 12  THEN '5'    
     ELSE                          '9'    
     END     
     + CASE WHEN base_tasa_emi = 360 THEN '1'    
     WHEN base_tasa_emi = 365 THEN '2'    
     WHEN base_tasa_emi = 30  THEN '3'    
     ELSE                          '9'    
     END)    
      FROM   BacBonosExtSuda..TEXT_SER    
      WHERE  cod_nemo            = Serie    
        
   --20201029.CORRECCIÓN PERIODICIDAD NOTEX  
   UPDATE #TABLA_P40 SET Periodicidad_Cupon='4' WHERE Nemotecnico='NOTEX'  
    --20201029.CORRECCIÓN TIPO TASAS NOTEX  
   UPDATE #TABLA_P40 SET Tipo_Tasa_Emision='1241000',Tipo_Tasa_Valoriza='1241000',Tipo_Tasa_Compra='1241000' WHERE Nemotecnico='NOTEX'  
   --20201029.CORRECCIÓN PAIS EMISOR  
   UPDATE #TABLA_P40 SET Pais_Emisor='828' WHERE Emisor='2000129790'  
  
      UPDATE #TABLA_P40       
         SET Tipo_Tasa_Emision  = REPLACE(Tipo_Tasa_Emision,  'PC', '94')    
         ,   Tipo_Tasa_Compra   = REPLACE(Tipo_Tasa_Compra,   'PC', '94')    
         ,   Tipo_Tasa_Valoriza = REPLACE(Tipo_Tasa_Valoriza, 'PC', '94')    
         ,   Nemotecnico        = CASE WHEN LTRIM(RTRIM( Nemotecnico )) = '' THEN  LTRIM(RTRIM( Serie ))  + LTRIM(RTRIM( Fecha_Proximo_Cupon ))    
                                       ELSE Nemotecnico    
                                  END    
       WHERE (Codigo            = 2001    
        OR    Codigo            = 2003)    
    
    
    -- select 'debug', Nemotecnico, Familia, Familia_Instrumento, * from #TABLA_P40 where familia not in ( 2000 )   
  
  
      CREATE TABLE #FINAL (INTERFAZ_P40 VARCHAR (414))    
      /**********************************************************************************************************************************************************    
                                                         FIN ACTUALIZACIONES DE CARTERA    
    
                                                FIN ACTUALIZACIONES DE DATOS DE LA SERIE Y CARTERA    
      **********************************************************************************************************************************************************/    
    
      UPDATE #TABLA_P40 SET Fecha_Inicio_Cond = CONVERT(CHAR(08), Fecha_Inicio_Cond, 112)    
      UPDATE #TABLA_P40 SET Fecha_Final_Cond  = CONVERT(CHAR(08), Fecha_Final_Cond,  112)    
      UPDATE #TABLA_P40 SET Fecha_Inicio_Cond = '00000000' WHERE Fecha_Inicio_Cond = ''    
      UPDATE #TABLA_P40 SET Fecha_Final_Cond  = '00000000' WHERE Fecha_Final_Cond  = ''    
    
      -->>>> Recalculo de los nominales    
      UPDATE #TABLA_P40    
         SET NOMINAL_ACTUAL  = (NOMINAL_ACTUAL * tda.saldo) / 100.0    
         ,   NOMINAL_INICIAL = (NOMINAL_ACTUAL * tda.saldo) / 100.0    
        FROM #TABLA_P40    
             INNER JOIN BacBonosExtSuda..TEXT_DSA tda ON tda.cod_nemo = Serie AND tda.fecha_vcto_cupon = FecCupVen    
      -->>>> Recalculo de los nominales    
    
      DECLARE @iCantidad      NUMERIC(9)    
          SET @iCantidad      = (SELECT COUNT(1) FROM #TABLA_P40)    
    
      DECLARE @TOTALNOMINAL   FLOAT    
          SET @TOTALNOMINAL   = ISNULL((SELECT SUM(NOMINAL_ACTUAL) FROM #TABLA_P40), 0)    
    
    
      SELECT   
  /* 'CL '                                   -- 01. Código ISO de País    
      ,      CONVERT(CHAR(08),Fecha_Proceso,112)                                     -- 02. Fecha de la Interfase    
      ,      'ND51'+ SPACE(10)                                                                                             -- 03. Numero de identificador de la Fuente    
      ,      '001'                                                                                                         -- 04. Codigo de empresa    
      ,      LEFT('MD01' + SPACE(16),16)                                                                                   -- 05. Codigo interno de producto    
      ,      CONVERT(CHAR(08),Fecha_Proceso,112)                                                                           -- 06. Fecha Contable    
      ,      NUMERO_OPERACION                                                                                              --     
      ,      NUMERO_DOCUMENTO                                                                                              --     
      ,      CORRELATIVO                                                                                                   -- 07. Número de la operación     
      ,      CODIGO_TENEDOR                                                                                                -- 08. Identificacion del tenedor    
      ,      TIPO_REGISTRO                                                                                 -- 09. Tipo de Registro    
      ,      FAMILIA_INSTRUMENTO                                                                                           -- 10. Familia de instrumentos    
      ,      TIPO_RENDIMIENTO                                                                   -- 11. Tipo Rendimiento    
      ,      CONVERT(CHAR(08),FECHA_PROXIMO_CUPON,112)                                                                     -- 12. FECHA DE PRóXIMO CORTE CUPóN    
      ,      DERIVADO_INCRUST_OPC                                                              -- 13. DERIVADOS INCRUSTADOS U OPCIONALIDAD    
      ,      NOMINAL_ACTUAL                                                                                                -- 14. NOMINAL ACTUAL    
      ,      MONEDA_REAJUSTE                                                                                               -- 15. MONEDA DE REAJUSTE    
      ,      TIPO_TASA_EMISION                                                                                             -- 16. TIPO DE TASA DE EMISIóN    
      ,      TERA                                                                                                          -- 17. TERA    
      ,      VALOR_PAR                                                                                                     -- 18. VALOR PAR    
      ,      TIPO_TASA_COMPRA         -- 19. TIPO DE TASA DE COMPRA    
      ,      TASA_COMPRA                        -- 20. TASA DE COMPRA    
      ,      COSTO_ADQUISICION                                                                                             -- 21. COSTO DE ADQUISICIóN    
      ,      COSTO_AMORTIZADO                                                                                              -- 22. COSTO AMORTIZADO    
      ,      Tipo_Tasa_Valoriza                                                                                            -- 23. TIPO DE TASA DE VALORACIóN    
      ,      Tasa_Valorizacion                                                                      -- 24. TASA DE VALORACIóN    
      ,      Tipo_valorizacion                                                                                             -- 25. TIPO DE VALORACIóN    
      ,      PRECIO_INSTRUMENTO                                                                                            -- 26. PRECIO DEL INSTRUMENTO    
      ,      DURACION_MODIFICADA                                                                                           -- 27. DURACIóN MODIFICADA    
      ,      CONVEXIDAD                                         -- 28. CONVEXIDAD    
      ,      VALOR_DETERIORO                                                                                               -- 29. VALOR DE DETERIORO    
      ,      CONDICION_INSTRUMENTO                                                                                   -- 30. CONDICIóN DEL INSTRUMENTO    
      ,      CONVERT(CHAR(08),Fecha_Inicio_Cond,112)           -- 31. FECHA INICIO CONDICION    
      ,      CONVERT(CHAR(08),Fecha_Final_Cond,112)           -- 32. FECHA FINAL DE CONDICION    
      ,      CONVERT(VARCHAR(20),RTRIM(LTRIM(NEMOTECNICO)) + REPLICATE(' ', 20 - LEN(RTRIM(LTRIM(NEMOTECNICO))) ))         -- 33. NEOTECNICO DE INSTRUMENTO    
   -- ,      CAST(NUMERO_DOCUMENTO AS VARCHAR(5)) +  CAST(CORRELATIVO AS VARCHAR(3))+ CAST(NUMERO_DOCUMENTO AS VARCHAR(5)) -- 34. Numero de Operacion REEMPLAZA 7    
      ,      CAST(NUMERO_DOCUMENTO AS VARCHAR(5)) +  CAST(CORRELATIVO AS VARCHAR(3))+ CAST(NUMERO_OPERACION AS VARCHAR(5)) -- 34. Numero de Operacion REEMPLAZA 7    
      ,      @iCantidad    
      ,      CASE WHEN TASA_COMPRA       >= 0 THEN '+' ELSE '-' END                                                        -- 35. Signo Tasa Compra    
      ,      CASE WHEN Tasa_Valorizacion >= 0 THEN '+' ELSE '-' END                                                        -- 36. Signo Tasa Valorizacion    
      ,      @TOTALNOMINAL    
   */  
     Tipo_Registro          ,       --1    
   Codigo_Tenedor         ,       --2    
   Fecha_Proceso          ,       --3    
   Fecha_Compra           ,       --4    
   Tipo_Cartera           ,       --5    
   Emisor                 ,       --6    
   Pais_Emisor            ,       --7    
   Familia_Instrumento    ,       --8    
   Nemotecnico            ,       --9    
   Tipo_Rendimiento       ,       --10    
   Periodicidad_Cupon     ,       --11    
   Fecha_Ultimo_Cupon     ,       --12    
   Fecha_Proximo_Cupon    ,       --13    
   Fecha_Vcto_Instr       ,       --14    
   Derivado_Incrust_Opc   ,       --15    
   Nominal_Inicial        ,       --16    
   Nominal_Actual         ,       --17    
   Moneda_Emision         ,       --18    
   Moneda_Reajuste        ,       --19    
   Tipo_Tasa_Emision      ,       --20    
   Tasa_Emision           ,       --21    
   Tera                   ,       --22    
   Valor_Par              ,       --23    
   Tipo_Tasa_Compra       ,       --24    
   Tasa_Compra            ,       --25    
   Costo_Adquisicion      ,       --26    
   Costo_Amortizado       ,       --27    
   Valor_Razonable        ,       --28    
   Tipo_Tasa_Valoriza     ,       --29    
   Tasa_Valorizacion      ,       --30    
   Tipo_valorizacion      ,       --31    
   Precio_Instrumento     ,       --32 (19, 8)    
   Duracion_Modificada    ,       --33    
   Convexidad             ,       --34    
   Valor_Deterioro        ,       --35    
   Condicion_Instrumento  ,       --36    
   Fecha_Inicio_Cond      ,       --37    
   Fecha_Final_Cond       ,       --38  
  
    @iCantidad  iCantidad,        
    signoTCmp,  
    signoTVal,  
  
    Cartera,  
    numero_Documento  ,    --40  
    Correlativo,  
    Numero_Operacion,  
   'S',  
   serie,  
   familia  
  
      FROM   #TABLA_P40    
      ORDER BY Fecha_Proceso     
      ,   CONDICION_INSTRUMENTO    
      ,   FAMILIA_INSTRUMENTO    
      ,   NUMERO_OPERACION  
      ,   NUMERO_DOCUMENTO    
      ,   CORRELATIVO    
  
      
 /*  
   SELECT  'CL '                                                                                                         -- 01. Código ISO de País    
      +   CONVERT(CHAR(08),Fecha_Proceso,112)                                                                           -- 02. Fecha de la Interfase    
      +   'ND51'+ SPACE(10)                                                                                             -- 03. Numero de identificador de la Fuente    
      +   '001'                                                                     -- 04. Codigo de empresa    
      +   LEFT('MD01' + SPACE(16),16)                                                                                   -- 05. Codigo interno de producto    
      +   CONVERT(CHAR(08),Fecha_Proceso,112)                                                                           -- 06. Fecha Contable    
      +   NUMERO_OPERACION                                                                                              --     
      +   NUMERO_DOCUMENTO                                                                                              --     
      +   CORRELATIVO                                                                                                   -- 07. Número de la operación     
      +   CODIGO_TENEDOR                                                                                                -- 08. Identificacion del tenedor    
      +   TIPO_REGISTRO                                                                                 -- 09. Tipo de Registro    
      +   FAMILIA_INSTRUMENTO                                                                                           -- 10. Familia de instrumentos    
      +   TIPO_RENDIMIENTO                                                                   -- 11. Tipo Rendimiento    
      +   CONVERT(CHAR(08),FECHA_PROXIMO_CUPON,112)                                                                     -- 12. FECHA DE PRóXIMO CORTE CUPóN    
      +   DERIVADO_INCRUST_OPC                                                              -- 13. DERIVADOS INCRUSTADOS U OPCIONALIDAD    
      +   NOMINAL_ACTUAL                                                                                                -- 14. NOMINAL ACTUAL    
      +   MONEDA_REAJUSTE                                                                                               -- 15. MONEDA DE REAJUSTE    
      +   TIPO_TASA_EMISION                                                                                             -- 16. TIPO DE TASA DE EMISIóN    
      +   TERA                                                                                                          -- 17. TERA    
      +   VALOR_PAR                                                                                                     -- 18. VALOR PAR    
      +   TIPO_TASA_COMPRA         -- 19. TIPO DE TASA DE COMPRA    
      +   TASA_COMPRA                        -- 20. TASA DE COMPRA    
      +   COSTO_ADQUISICION                                                                                             -- 21. COSTO DE ADQUISICIóN    
      +   COSTO_AMORTIZADO                                                                                              -- 22. COSTO AMORTIZADO    
      +   Tipo_Tasa_Valoriza                                                                                            -- 23. TIPO DE TASA DE VALORACIóN    
      +   Tasa_Valorizacion                                                                      -- 24. TASA DE VALORACIóN    
      +   Tipo_valorizacion                                                                                             -- 25. TIPO DE VALORACIóN    
      +   PRECIO_INSTRUMENTO                                                                                            -- 26. PRECIO DEL INSTRUMENTO    
      +   DURACION_MODIFICADA                                                                                           -- 27. DURACIóN MODIFICADA    
      +   CONVEXIDAD                                                                                                    -- 28. CONVEXIDAD    
      +   VALOR_DETERIORO                                                                                               -- 29. VALOR DE DETERIORO    
      +   CONDICION_INSTRUMENTO                                                                                   -- 30. CONDICIóN DEL INSTRUMENTO    
      +   CONVERT(CHAR(08),Fecha_Inicio_Cond,112)           -- 31. FECHA INICIO CONDICION    
      +   CONVERT(CHAR(08),Fecha_Final_Cond,112)           -- 32. FECHA FINAL DE CONDICION    
      +   CONVERT(VARCHAR(20),RTRIM(LTRIM(NEMOTECNICO)) + REPLICATE(' ', 20 - LEN(RTRIM(LTRIM(NEMOTECNICO))) ))         -- 33. NEOTECNICO DE INSTRUMENTO    
   --    CAST(NUMERO_DOCUMENTO AS VARCHAR(5)) +  CAST(CORRELATIVO AS VARCHAR(3))+ CAST(NUMERO_DOCUMENTO AS VARCHAR(5)) -- 34. Numero de Operacion REEMPLAZA 7    
      +   CAST(NUMERO_DOCUMENTO AS VARCHAR(5)) +  CAST(CORRELATIVO AS VARCHAR(3))+ CAST(NUMERO_OPERACION AS VARCHAR(5)) -- 34. Numero de Operacion REEMPLAZA 7    
      +  CONVERT(CHAR(08), @iCantidad  )  
      +   CASE WHEN TASA_COMPRA       >= 0 THEN '+' ELSE '-' END                                                        -- 35. Signo Tasa Compra    
   --   +   CASE WHEN Tasa_Valorizacion >= 0 THEN '+' ELSE '-' END                                                        -- 36. Signo Tasa Valorizacion    
   --   +   @TOTALNOMINAL    
      FROM   #TABLA_P40    
      ORDER BY Fecha_Proceso     
      ,   CONDICION_INSTRUMENTO    
      ,   FAMILIA_INSTRUMENTO    
      ,   NUMERO_OPERACION  
      ,   NUMERO_DOCUMENTO    
      ,   CORRELATIVO    
   */   
  -- SET NOCOUNT OFF    
    
END  
  
GO
