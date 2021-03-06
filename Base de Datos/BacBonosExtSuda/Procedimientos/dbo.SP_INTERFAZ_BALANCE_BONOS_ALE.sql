USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_BALANCE_BONOS_ALE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_BALANCE_BONOS_ALE]
AS
BEGIN


SET NOCOUNT ON 

DECLARE   @tip_oper      CHAR(4)
         ,@mascara       CHAR (25)         
         ,@numdocu       NUMERIC (10,0)    
         ,@numoper       NUMERIC (10,0)    
         ,@corre         NUMERIC (03,0)    
         ,@codigo        NUMERIC (5)       
         ,@tir           NUMERIC (19,4)    
         ,@moneda        NUMERIC (5)       
         ,@seriado       CHAR (1)          
         ,@tipoper       CHAR (4)          
         ,@tabla         CHAR (4)                  
         ,@cuenta        CHAR(20) 
         ,@fecha_compra  DATETIME                  
         ,@dias_dife     NUMERIC(6)                
         ,@campo_26      DATETIME                  
         ,@interes       NUMERIC(19,4)
         ,@vDolar_obs    NUMERIC(19,4)     
         ,@dias          NUMERIC(1)
         ,@nIntasb       NUMERIC(5)
         ,@tip_tasa      CHAR(3)
         ,@inst_variable CHAR(1)
         ,@Ccuenta       CHAR(5)
         ,@dfecfmes      DATETIME
         ,@dFecFMesProx  DATETIME
         ,@acfecprox     DATETIME
         ,@fecpro        DATETIME 
         ,@NumCuenta     CHAR(1)
         ,@monto_origen  NUMERIC(19,4)
         ,@indicador     CHAR(1)
         ,@NumValor      CHAR(1)
         ,@NumReajuste   CHAR(1)
         ,@NumInteres    CHAR(1)
         ,@Max           INTEGER
         ,@Monto         NUMERIC(18,2)
         ,@cMoneda       NUMERIC(5)
         ,@monto_oper    NUMERIC(18,2)
         ,@TipoLinea     CHAR(1)
	 ,@Mto_orig	 NUMERIC(18,2)
	 ,@vDolar_obs_dia NUMERIC(19,4)
	 ,@Mto_local     NUMERIC(18,2)
         
DECLARE @PrimerDiaMes	CHAR(12),
	@UltimoDiaMes	CHAR(12)


 SELECT @fecpro      	= acfecproc ,
        @acfecprox   	= acfecprox
 FROM TEXT_ARC_CTL_DRI

 IF  month (@fecpro )<> month( @acfecprox ) BEGIN
	SELECT @PrimerDiaMes   = SUBSTRING( ( convert(char(8), @acfecprox , 112))  ,1,6)  + '01'
	SELECT @UltimoDiaMes   = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@PrimerDiaMes)),112)
        SELECT @fecpro = CONVERT(DATETIME,  @UltimoDiaMes ,112)
        
 END 

---SELECT * FROM TEXT_ARC_CTL_DRI

CREATE TABLE #CARTERA
    (
        tip_oper     CHAR(4)                                   --  0
       ,mascara      CHAR (25)                                 --  1    
       ,numdocu      NUMERIC (10,0)                            --  2
       ,numoper      NUMERIC (10,0)                            --  3
       ,corre        NUMERIC (03,0)                            --  4
       ,codigo       NUMERIC (5)                               --  5
       ,tir          NUMERIC (19,4)                            --  6
       ,moneda       NUMERIC (5)                               --  7
       ,tipoper      CHAR (4)                                  --  9
       ,tabla        CHAR (4)                                  --  10
       ,cuenta       CHAR(20) 			               --  11
       ,fecha_compra DATETIME                                  --  12
       ,dias_dife    NUMERIC(6)                                --  13
       ,campo_26     DATETIME                                  --  14  
       ,interes      NUMERIC(19,4)
       ,cMoneda      NUMERIC(5)
       ,monto_oper   NUMERIC(18,2)
       ,TipoLinea    CHAR(1)
       ,Mto_orig     NUMERIC(18,2)
      )

---------------------------------------------------------------------------------------------
CREATE TABLE #TABLA_INTERFAZ2
   (
       COD_PAIS      CHAR(3)
      ,FEC_INTERFAZ  DATETIME
      ,NRO_IDEN      CHAR(4)
      ,COD_EMP       CHAR(3)
      ,FAM_PROD      CHAR(4)
      ,TIP_PROD      CHAR(4)
      ,COD_PRO       CHAR(4)
      ,CLS_PROD      CHAR(1)
      ,TIPO_PROD     CHAR(1)
      ,NRO_OPER      CHAR(20)
      ,FEC_CTBL      CHAR(8)
      ,MDA_CTBLE     NUMERIC(5)
      ,COD_CTAC      CHAR(20)
      ,IND_DECR      CHAR(1)
      ,COD_CTBL      CHAR(3)
      ,SIG_MDO       CHAR(1)
      ,MDA_ORI       NUMERIC(19,4)
      ,SIG_MDL       CHAR(1)
      ,MDA_LOC       NUMERIC(19,4)
      ,SIG_LAG       CHAR(1)
      ,MDA_AGR       NUMERIC(19,4)
      ,COD_INT_SUC   CHAR(3)
      ,COD_INT_CEN   CHAR(10)
   )      

---------------------------------------------------------------------------------------------
-- DEVENGO
 INSERT #CARTERA 
 SELECT 'MDIR'
        ,cod_nemo 	
        ,rsnumdocu 	
        ,rsnumdocu 	
        ,rscorrelativo  
        ,cod_familia    
 	,rstir 		
	,rsmonemi	
        ,'MD01' 	
  	,'MDCP'    	
	,CtaContable	
        ,rsfeccomp      
        ,datediff(day,@fecpro,rsfecvcto)
        ,rsfecvcto 
        ,rsinteres_acum --+ rsinteres
        ,(SELECT mncodfox FROM view_moneda WHERE moneda = mncodmon) 
        , ValorPresentePeso    
        ,TipoLinea
	,rsvppresen 
 FROM TEXT_rsu,CARTERA_CUENTA
 WHERE rsnominal   > 0 AND rsrutcart > 0    
       AND Correla   = rscorrelativo -- 1
       AND NumOper   = rsnumdocu
       and rsfecpro  = @fecpro 
       and rsfecpago < @fecpro 	
       AND variable  = 'valor_compra'
       AND t_operacion = 'CP'
       AND rstipoper = 'DEV' 	

-- sp_helptext Sp_interfaz_Balance_Bonos

--COMPRAS
 INSERT #CARTERA 
 SELECT 'MDIR'
        ,cod_nemo 	
        ,rsnumdocu 	
        ,rsnumdocu 	
        ,rscorrelativo  
        ,cod_familia    
 	,rstir 		
	,rsmonemi	
        ,'MD01' 	
  	,'MDCP'    	
	,CtaContable	
        ,rsfeccomp      
        ,datediff(day,@fecpro,rsfecvcto)
        ,rsfecvcto 
        ,rsinteres_acum 
        ,(SELECT mncodfox FROM view_moneda WHERE moneda = mncodmon) 
        , ValorPresentePeso  
        ,TipoLinea
	,rsvppresen  
 FROM TEXT_rsu,CARTERA_CUENTA
 WHERE rsnominal   > 0 AND rsrutcart > 0    
       AND Correla   = rscorrelativo -- 1
       AND NumOper   = rsnumdocu
       and rsfecpro  = @fecpro 
       and rsfecpago = @fecpro 	
       AND variable  = 'valor_compra'
       AND t_operacion = 'CP'
       AND rstipoper = 'DEV' 	



 INSERT #CARTERA 
 SELECT 'MDIR' 		--1
	,cod_nemo 	--2
        ,monumdocu 	--3
        ,monumdocu 	--4
        ,mocorrelativo  --5
	,cod_familia    --6
        ,motir	 	--7
	,momonemi	--8
        ,'MD01' 	--9     
        ,'MDVP'    	--10
	,CtaContable	--11
        ,mofecpro       --12
        ,datediff(day,@fecpro,mofecven)--13
        ,mofecven 	--14
        ,mointeres      --15
        ,(SELECT mncodfox FROM view_moneda WHERE moneda = mncodmon) --16
        ,CAPITALPESO							    --17
        ,TipoLinea
	,movpresen
 FROM TEXT_MVT_DRI,CARTERA_CUENTA
 WHERE monominal   > 0 AND morutcart > 0    
       AND NumDocu   = monumdocu
       AND Correla   = mocorrelativo
       AND NumOper   = monumoper 
       AND variable  = 'valor_venta'
       AND motipoper = 'VP'
       AND mofecpago  = @fecpro	  	
       AND mostatreg	<> 'A'  


DECLARE CURSOR_INTER CURSOR FOR 
SELECT     tip_oper     ,mascara       ,  numdocu   , numoper , corre   ,codigo
         , tir          ,moneda        ,  tipoper   , tabla   ,cuenta
         , fecha_compra ,dias_dife     ,  campo_26  , interes ,cmoneda   ,monto_oper
	 , Mto_orig	,TipoLinea	
FROM #CARTERA

OPEN CURSOR_INTER
FETCH NEXT FROM CURSOR_INTER
INTO       @tip_oper      , @mascara      , @numdocu    , @numoper , @corre   , @codigo
         , @tir           , @moneda       , @tipoper , @tabla   , @cuenta
         , @fecha_compra  , @dias_dife    , @campo_26   , @interes, @cMoneda  , @monto_oper
	 , @Mto_orig	  , @TipoLinea
WHILE @@FETCH_STATUS  = 0
BEGIN 

   IF @TipoLinea = 'D' 
      SELECT @indicador = 'D'
   ELSE
  SELECT @indicador = 'C'

   SELECT @NumCuenta    = ''
   SELECT @Ccuenta      = '0'
   SELECT @Monto    = 0
   SELECT @NumValor     = ''    
   SELECT @NumReajuste  = ''
   SELECT @NumInteres   = ''  


   SELECT @vDolar_obs = ISNULL((SELECT vmvalor FROM view_valor_moneda WHERE vmcodigo = @moneda and vmfecha = @fecha_compra),0)


   IF @cuenta <>'0' and @cuenta <>''
   BEGIN

      SELECT @monto_origen = @Mto_orig

      IF @cuenta <> '0' AND @cuenta <> ''
         BEGIN

	SELECT @Mto_local = @monto_oper
      	INSERT #TABLA_INTERFAZ2 VALUES ( 'CL'
					,CONVERT(CHAR(8),GETDATE(),112) 
					,'BO51' 
					,'001' 
					,'MDIR'
					,@tip_oper  
					,@tipoper
					,SPACE(1)
					,'M'
					,CAST(@numdocu AS VARCHAR(5)) +  cast(@corre AS VARCHAR(3))+ CAST( @numoper AS VARCHAR(5) )
                              		,convert(char(8),@fecpro,112)
					,@cuenta
					,@cMoneda
					,@indicador
					,'0'
                              		,CASE WHEN @Mto_orig < 0 THEN '-' ELSE '+' END
					,ABS(@Mto_orig)
					,CASE WHEN @Mto_local < 0 THEN '-' ELSE '+' END
					,ABS(@Mto_local)
					,CASE WHEN @interes < 0 THEN '-' ELSE '+' END
					,ABS(@interes)
					,'1' 
					,SPACE(10) )

      END
  END    

  SELECT @Ccuenta = CtaContable  , 
         @Monto = Monto  
    FROM cartera_cuenta 
   WHERE NumDocu = @numdocu 
     AND Correla = @Corre  
     AND NumOper = @numoper 
     AND Variable  = 'Reajuste_papel'


   SELECT @monto_origen = @Mto_orig

   IF @Ccuenta <> '0' AND @Ccuenta <> ''
   BEGIN

        INSERT #TABLA_INTERFAZ2 VALUES ( 'CL'
					,CONVERT(CHAR(8),GETDATE(),112) 
					,'BO51'
					,'001'
					,'MDIR'
					,@tip_oper
					,@tipoper
					,SPACE(1)
					,'M'
                              		,CAST(@numdocu AS VARCHAR(5)) +  cast(@corre AS VARCHAR(3))+ CAST( @numoper AS VARCHAR(5))
                              		,convert(char(8),@fecpro,112)
					,@Ccuenta
					,@cMoneda
					,@indicador
					,'1'
	                              	,CASE WHEN @monto_origen < 0 THEN '-' ELSE '+' END 
					,ABS(@monto_origen)
					,CASE WHEN @Mto_local < 0 THEN '-' ELSE '+' END 
					,ABS(@Mto_local)
					,CASE WHEN @interes < 0 THEN '-' ELSE '+' END 
					,ABS(@interes)
					,'1'
					,SPACE(10))

   END   

                       
FETCH NEXT FROM CURSOR_INTER
INTO       @tip_oper      , @mascara      , @numdocu    , @numoper , @corre   , @codigo
         , @tir           , @moneda       , @tipoper 	, @tabla   , @cuenta
         , @fecha_compra  , @dias_dife    , @campo_26   , @interes ,@cMoneda   , @monto_oper
	 , @Mto_orig	  , @TipoLinea
      
END
CLOSE CURSOR_INTER
DEALLOCATE  CURSOR_INTER

SELECT @Max = COUNT(*) FROM #TABLA_INTERFAZ2
SELECT @Max,* FROM #TABLA_INTERFAZ2

END

GO
