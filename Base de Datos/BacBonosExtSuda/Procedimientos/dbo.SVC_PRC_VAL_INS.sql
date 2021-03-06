USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_PRC_VAL_INS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SVC_PRC_VAL_INS]  
   (  
  @dFecPro DATETIME  ,  
  @TipFomulas CHAR(1)   ,  
  @tipo_cal FLOAT   ,  
  @cod_familia NUMERIC(04)  ,  
  @cod_nemo CHAR(20)  ,  
  @fecha_vcto DATETIME  ,  
  @TR  FLOAT  OUTPUT ,  
  @TE  FLOAT  OUTPUT ,  
  @TV  FLOAT  OUTPUT ,  
  @TT  FLOAT  OUTPUT ,  
  @BA  FLOAT  OUTPUT ,  
  @BF  FLOAT  OUTPUT ,  
  @NOM  FLOAT  OUTPUT ,  
  @MT  FLOAT  OUTPUT ,  
  @VV  FLOAT  OUTPUT ,  
  @VP  FLOAT  OUTPUT ,  
  @PVP  FLOAT  OUTPUT ,  
  @VAN  FLOAT  OUTPUT ,  
  @FP  DATETIME OUTPUT ,  
  @FE  DATETIME OUTPUT ,  
  @FV  DATETIME OUTPUT ,  
  @FU  DATETIME OUTPUT ,  
  @FX  DATETIME OUTPUT ,  
  @FC  DATETIME OUTPUT ,  
  @CI  FLOAT  OUTPUT ,  
  @CT  FLOAT  OUTPUT ,  
  @INDEV  FLOAT  OUTPUT ,  
  @PRINC  FLOAT  OUTPUT ,  
  @FIP  DATETIME OUTPUT ,  
  @CAP  FLOAT  OUTPUT ,  
  @INCTR  FLOAT  OUTPUT ,  
  @SPREAD  FLOAT  OUTPUT ,  
  @Retorno CHAR(1)   ,  
  @cod_moneda NUMERIC(03)  ,  
  @PX_IN  FLOAT = 0 OUTPUT  ,  
  @PX_AM  FLOAT = 0  OUTPUT  ,  
  @FACTOR  FLOAT  = 0   OUTPUT  ,  
                @DUR_MAC        FLOAT  = 0   OUTPUT  ,  
                @DUR_MOD        FLOAT  = 0   OUTPUT  ,  
		@CONVEXI        FLOAT  = 0   OUTPUT  ,
		@ESVENTA		CHAR(1)   = 'N'
  )  
AS  
BEGIN  
/*  
Modificadas lineas 368 y 386, JBH, 04-12-2009  
*/  
  
 SET NOCOUNT ON  
  
  DECLARE @cVariab CHAR(10)  
 DECLARE @cFormu  CHAR(100)  
  
 DECLARE @cTipForm CHAR(1)  ,  
  @param1  CHAR(15)  ,  
  @param2  CHAR(15) ,  
  @param3  CHAR(15)  ,  
  @param4  CHAR(15) ,  
  @Fecvcto_For DATETIME ,  
  @Redondeo NUMERIC(03)  
  
 DECLARE @fecini  DATETIME ,  
  @fecvto  DATETIME ,  
  @DIFDIAS INTEGER  
  
 DECLARE @TD_SUMINT FLOAT  ,  
  @TD_SUMAMO FLOAT  ,  
  @TD_SUMFLU FLOAT  ,  
  @TD_SUMSAL FLOAT  ,  
  @TD_SUMFDE FLOAT  ,  
  --@PX_IN  FLOAT  ,  
  --@PX_AM  FLOAT  ,  
  @DIFDPR  FLOAT  ,  
  @V001  FLOAT  ,  
  @V002  FLOAT  ,  
  @V003  FLOAT  ,  
  @V004  FLOAT  ,  
  @V005  FLOAT  ,  
  @V006  FLOAT  ,  
  @V007  FLOAT  ,  
  @V008  FLOAT  ,  
  @V009  FLOAT  ,  
  @V010  FLOAT  
  
 DECLARE @cont  INTEGER  ,  
  @cont_For INTEGER  ,  
  @NCUP  FLOAT   ,  
  @FVCP   DATETIME ,  
  @INTE  FLOAT   ,  
  @AMOR   FLOAT   ,  
  @FLUJ   FLOAT   ,  
  @SALD  FLOAT   ,  
  @DIFD   FLOAT     
    
        SELECT  @DUR_MAC = convert(float,0) , @DUR_MOD = convert(float,0) , @CONVEXI = convert(float,0)  
 DECLARE @nError  INTEGER  
  
 DECLARE @Cup_ini FLOAT  
 DECLARE @Cup_Fin FLOAT  
  
 DECLARE @Precis  FLOAT   ,  
  @z_TR  FLOAT   ,  
  @z_Pvp  FLOAT   ,  
  @z_MT  FLOAT   ,  
  @xMA  FLOAT   ,  
  @xME  FLOAT   ,  
  @xx  FLOAT  
  
 SELECT @nError        = 0  
 SELECT  @Redondeo      = MNREDONDEO  
 FROM VIEW_MONEDA  
 WHERE mncodmon       = @cod_moneda  
  
 DECLARE @SQLString NVARCHAR(1000)  
 DECLARE @SQLString_Pru NVARCHAR(1000)  
 DECLARE @ParmDefinition NVARCHAR(1000)  
  
 CREATE TABLE #TABLA_DESARROLLO  
 ( NCUP INTEGER ,  
  FVCP DATETIME,  
  INTE FLOAT ,  
  AMOR FLOAT ,  
  FLUJ FLOAT ,  
  SALD FLOAT ,  
  DIFD FLOAT ,  
  FLDE FLOAT ,  
  FACTOR  FLOAT     
         )  
  
 INSERT INTO #TABLA_DESARROLLO  
 SELECT num_cupon  ,  
  fecha_vcto_cupon ,  
  interes   ,  
  amortizacion  ,  
  flujo   ,  
  saldo   ,  
  DATEDIFF(DAY,@dFecPro,fecha_vcto_cupon),  
  0   ,  
  Factor  
 FROM TEXT_dsa  
 WHERE cod_familia = @cod_familia  
 AND cod_nemo    = @cod_nemo  
  
 SELECT @FU = @FE  
 SELECT @FX = @FV  
  
 IF EXISTS(SELECT FVCP FROM #TABLA_DESARROLLO WHERE FVCP <= @dFecPro )  
    SELECT @FU = MAX(FVCP) FROM #TABLA_DESARROLLO WHERE FVCP <= @dFecPro  
  
  
 IF (SELECT COUNT(1)  FROM #TABLA_DESARROLLO) > 0  
 BEGIN  
  SELECT @Fx = MIN(FVCP) FROM #TABLA_DESARROLLO WHERE FVCP > @dFecPro  
  SELECT @CI = MIN(NCUP) FROM #TABLA_DESARROLLO WHERE FVCP > @dFecPro  
  SELECT @CT = MAX(NCUP) FROM #TABLA_DESARROLLO   
 END  
 ELSE  
  SELECT @FU = @FE ,  
   @FX = @FV ,  
   @CI = 1  ,  
   @CT = 1    
  
 SELECT @PX_IN  = 0,  
  @PX_AM  = 0  
  
 SET ROWCOUNT 1  
  
 IF @dFecPro = @FU  
 BEGIN  
  SELECT @PX_IN  = FACTOR * (INTE * (@Nom / 100)),  
   @PX_AM  = FACTOR * (AMOR * (@Nom / 100))  
--   @FACTOR  = FACTOR  
  FROM #TABLA_DESARROLLO   
  WHERE FVCP = @dFecPro  
  ORDER  
  BY FVCP  
  
                -- factor de cupon que inicia  
                SELECT @FACTOR  = ISNULL (FACTOR, 1.0)  
  FROM #TABLA_DESARROLLO   
  WHERE FVCP > @dFecPro  
  ORDER  
  BY FVCP  
  
  
 END  
 ELSE   
        BEGIN  
  
  SELECT @PX_IN  = FACTOR * (INTE * (@Nom / 100)),  
   @PX_AM  = FACTOR * (AMOR * (@Nom / 100)),  
   @FACTOR  = FACTOR  
  FROM #TABLA_DESARROLLO   
  WHERE FVCP > @dFecPro  
  ORDER  
  BY FVCP  
  
       END    
  
  
 SELECT @vv = @PX_IN + @PX_AM  
  
 SET ROWCOUNT 0  
  
 IF @FIP < @FU   
  SELECT @FIP = @FU  
  
 SELECT @V001 =  0 ,  
  @V002 =  0 ,  
  @V003 =  0 ,  
  @V004 =  0 ,  
  @V005 =  0 ,  
  @V006 =  0 ,  
  @V007 =  0 ,  
  @V008 =  0 ,  
  @V009 =  0 ,  
  @V010 =  0  
  
 SELECT @TD_SUMINT = ISNULL(SUM(INTE),0),  
  @TD_SUMAMO = ISNULL(SUM(AMOR),0),  
  @TD_SUMFLU = ISNULL(SUM(FLUJ),0),  
  @TD_SUMSAL = ISNULL(SUM(SALD),0),  
  @TD_SUMFDE = ISNULL(SUM(FLDE),0)  
 FROM #tabla_desarrollo  
 WHERE FVCP > @dFecPro  
  
 CREATE TABLE #TMP_VALORIZACION  
 ( TR  FLOAT  ,    
                TE  FLOAT  ,  
  TV  FLOAT  ,  
  TT  FLOAT  ,  
  BA  FLOAT  ,  
  BF  FLOAT  ,  
  NOM  FLOAT  ,  
  MT  FLOAT  ,  
  VV  FLOAT  ,  
  VP  FLOAT  ,  
  PVP  FLOAT  ,  
  VAN  FLOAT  ,  
  FP  DATETIME ,  
  FE  DATETIME ,  
  FV  DATETIME ,  
  FU  DATETIME ,  
  FX  DATETIME ,  
  FC  DATETIME ,  
  CI  FLOAT  ,  
  CT  FLOAT  ,  
  INDEV  FLOAT  ,  
  PRINC  FLOAT  ,  
  FIP  DATETIME ,  
  CAP  FLOAT  ,  
  INCTR  FLOAT  ,  
  SPREAD  FLOAT  ,  
  TD_SUMINT FLOAT  ,  
  TD_SUMAMO FLOAT  ,  
  TD_SUMFLU FLOAT  ,  
  TD_SUMSAL FLOAT  ,  
  TD_SUMFDE FLOAT  ,  
         PX_IN  FLOAT  ,  
  PX_AM  FLOAT  ,  
  V001  FLOAT  ,  
  V002  FLOAT  ,  
  V003  FLOAT  ,  
  V004  FLOAT  ,  
  V005  FLOAT  ,  
  V006  FLOAT  ,  
  V007  FLOAT  ,  
  V008  FLOAT  ,  
  V009  FLOAT  ,  
  V010  FLOAT  ,  
  FACTOR  FLOAT  ,  
                DUR_MAC         FLOAT           ,  
                DUR_MOD         FLOAT           ,  
                CONVEXI         FLOAT           )  
  
 INSERT INTO #TMP_VALORIZACION  
 SELECT @TR,  
  @TE,  
  @TV,  
  @TT,  
  @BA,  
  @BF,  
  @NOM,  
  @MT,  
  @VV,  
  @VP,  
  @PVP,  
  @VAN,  
  @FP,  
  @FE,  
  @FV,  
  @FU,  
  @FX,  
  @FC,  
  @CI,  
  @CT,  
  @INDEV,  
  @PRINC,  
  @FIP,  
  @CAP,  
  @INCTR,  
  @SPREAD,  
  @TD_SUMINT,  
  @TD_SUMAMO,  
  @TD_SUMFLU,  
  @TD_SUMSAL,  
  @TD_SUMFDE,  
  @PX_IN,  
  @PX_AM,  
  @V001,  
  @V002,  
  @V003,  
  @V004,  
  @V005,  
  @V006,  
  @V007,  
  @V008,  
  @V009,  
  @V010,  
  @FACTOR,  
                @DUR_MAC,  
                @DUR_MOD,  
                @CONVEXI  
  
 SELECT @cont = 0  
  
        CREATE TABLE #TMP_FORMULA  
        (    Fecha_vcto   DATETIME   NOT NULL DEFAULT('')  
        ,    Num_linea    NUMERIC(5) NOT NULL DEFAULT(0)  
        ,    variable     CHAR(15)   NOT NULL DEFAULT('')  
        ,    formula      CHAR(100)  NOT NULL DEFAULT('')  
        ,    Tipo_formula CHAR(1)    NOT NULL DEFAULT('')  
        ,    Parametro1   CHAR(15)   NOT NULL DEFAULT('')  
        ,    Parametro2   CHAR(15)   NOT NULL DEFAULT('')  
        ,    Parametro3   CHAR(15)   NOT NULL DEFAULT('')  
        ,    Parametro4   CHAR(15)   NOT NULL DEFAULT('')  
        --+++jcamposd 20161003 valorizacion CDT
        ,	 FamiliaCod	  NUMERIC(9) NOT NULL DEFAULT(0) 
        -----jcamposd 20161003 valorizacion CDT
        )  
/*  
 SELECT Fecha_vcto ,  
  Num_linea ,  
  variable ,  
  formula  ,  
  Tipo_formula ,  
  Parametro1 ,  
  Parametro2 ,  
  Parametro3 ,  
  Parametro4        
 INTO #TMP_FORMULA  
 FROM TEXT_FRM  
*/  
  
 SELECT @Fecvcto_For = @fecha_vcto  
  
 IF @cod_familia <> 2000   
           SELECT @Fecvcto_For = ''  
  
--      DELETE #TMP_FORMULA  
  
 IF @TipFomulas = 'P'  
        BEGIN  
  INSERT INTO #TMP_FORMULA  
                SELECT Fecha_vcto  
  , CONVERT(NUMERIC(5),Num_linea)  
  , CONVERT(CHAR(15),variable)  
  , CONVERT(CHAR(100),formula)  
  , CONVERT(CHAR(1),Tipo_formula)  
  , CONVERT(CHAR(15),Parametro1)  
  , CONVERT(CHAR(15),Parametro2)  
  , CONVERT(CHAR(15),Parametro3)  
  , CONVERT(CHAR(15),ISNULL(Parametro4,' '))  -- era CONVERT(CHAR(15), PArametro4), JBH, 04-12-2009  
		--+++jcamposd 20161003 valorizacion CDT
		, @cod_familia	
		--+++jcamposd 20161003 valorizacion CDT
     FROM text_val_frm  
  WHERE cod_familia = @cod_familia  
  AND cod_nemo    = @cod_nemo  
  AND Tipo_cal    = @tipo_cal  
  AND fecha_vcto  = @Fecvcto_For  
  
 END ELSE     
        BEGIN  
  INSERT INTO #TMP_FORMULA  
  SELECT Fecha_vcto  
  , CONVERT(NUMERIC(5),Num_linea)  
  , CONVERT(CHAR(15),variable)  
  , CONVERT(CHAR(100),formula)  
  , CONVERT(CHAR(1),Tipo_formula)  
  , CONVERT(CHAR(15),Parametro1)  
  , CONVERT(CHAR(15),Parametro2)  
  , CONVERT(CHAR(15),Parametro3)  
  , CONVERT(CHAR(15),ISNULL(Parametro4,' '))  ---era CONVERT(CHAR(15),Parametro4), JBH, 04-12-2009  
		--+++jcamposd 20161003 valorizacion CDT
		, @cod_familia	
		--+++jcamposd 20161003 valorizacion CDT		
  FROM text_frm  
  WHERE cod_familia = @cod_familia  
  AND cod_nemo    = @cod_nemo  
  AND Tipo_cal    = @tipo_cal  
  AND fecha_vcto  = @Fecvcto_For  
         END   
  --+++jcamposd 20161003 valorizacion CDT
  --Controlo si esta cerrada la mesa para aplicar calculo sobre base 365, si no esta cerrada
  --y la colocacion es de primera emision esta sera base 360
  IF @cod_familia = 2006	
  BEGIN
	DECLARE @EstadodevengoRealizado INT
	DECLARE @FormulaBaseCDT   CHAR(20)
	
	SELECT @EstadodevengoRealizado = acsw_dv --= 1 devengo realizado
		FROM text_arc_ctl_dri (NOLOCK)
	--set @EstadoCierremesa = 1
	
	IF @EstadodevengoRealizado = 0 AND @FE = @FP -->fecha de emision = fecha valorizacion 
	BEGIN 
		SELECT @FormulaBaseCDT = 'DIFDIA_BASE30()'
		--select 'DIFDIA_BASE30()',@FE ,@FP
	END
	ELSE
	BEGIN
		--select  'DIFDIA_REALES()',@FE ,@FP
		SELECT @FormulaBaseCDT = 'DIFDIA_REALES()'
	END
	
	
	
	--UPDATE #TMP_FORMULA
	--SET	formula = @FormulaBaseCDT
	--WHERE 
	--	@cod_familia	= 2006
	--	AND Num_linea	= 1
	--	AND variable	= 'V001'
  END
  --+++jcamposd 20161003 valorizacion CDT
  
 SELECT @cont_For = 0   
        
 WHILE 1 = 1  
 BEGIN  
  
  SELECT @cVariab = '*'  
  
  SET ROWCOUNT 1  
  
  SELECT @cont_For = Num_linea ,  
   @cVariab = variable ,  
   @cFormu  = formula ,  
   @cTipForm = Tipo_formula ,  
   @param1  = Parametro1 ,  
   @param2  = Parametro2 ,  
   @param3  = Parametro3 ,  
   @param4  = Parametro4       
  FROM  #TMP_FORMULA  
  WHERE Num_linea       > @cont_For  
  ORDER BY Num_linea  
  
  SET ROWCOUNT 0  
  
  IF @cVariab = '*'   
                   BREAK  
  
 IF @cTipForm = 'D'  
 BEGIN  
  
  CREATE TABLE #TMP_Cupones  
  ( Cup_ini  FLOAT  ,  
   Cup_Fin  FLOAT  )  
  
  INSERT INTO #TMP_Cupones SELECT 0, 0  
  
  SET @SQLString = 'UPDATE #TMP_Cupones SET Cup_ini = ' + @param3  
  SET @ParmDefinition = N'@CI FLOAT,@CT FLOAT, @Cup_ini FLOAT'  
  EXECUTE sp_executesql @SQLString , @ParmDefinition, @CI, @CT, @Cup_ini  
  
  
  SET @SQLString = 'UPDATE #TMP_Cupones SET Cup_Fin = ' + @param4  
  SET @ParmDefinition = N'@CI FLOAT,@CT FLOAT,@Cup_Fin FLOAT'  
  EXECUTE sp_executesql @SQLString ,   
     @ParmDefinition,   
     @CI,   
     @CT,   
     @Cup_Fin  
  
  SELECT @Cup_ini = Cup_ini,  
   @Cup_fin = Cup_Fin  
  FROM #TMP_Cupones  
  
  SELECT @cont = 0  
  
  WHILE 1=1  
  BEGIN  
   SELECT @nError = 0  
  
   SET ROWCOUNT 1  
  
   SELECT @nError = 100,  
    @NCUP = NCUP,  
    @FVCP = FVCP,  
    @INTE = INTE,  
    @AMOR = AMOR,  
    @FLUJ = FLUJ,  
    @SALD = SALD,  
    @DIFD = DIFD,  
    @cont = NCUP  
   FROM #tabla_desarrollo  
   WHERE NCUP > @cont  
   AND NCUP >= @Cup_Ini  
   AND NCUP <= @Cup_Fin  
   ORDER BY NCUP  
  
   SET ROWCOUNT 0  
  
   IF @nError = 0 BREAK  
  
  
   IF @cFormu = 'DIFDIA_REALES()'   
   BEGIN  
    IF @param1 = '@FC,@FU' BEGIN  
     SELECT @param1 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)  
    END  
  
    IF @param2 = '@FC,@FU' BEGIN  
     SELECT @param2 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)  
    END   
  
    SET @SQLString = 'UPDATE #tabla_desarrollo SET ' + @cVariab + ' = DATEDIFF(DAY, ' + @param1 + ',' + @param2 + ') WHERE NCUP = @NCUP'  
  
   END  
   ELSE  
   IF @cFormu = 'DIFDIA_BASE30()'  
   BEGIN  
    SELECT @fecini = CASE WHEN @param1 = '@FP' THEN @fp  
       WHEN @param1 = '@FE' THEN @fe  
       WHEN @param1 = '@FV' THEN @fV  
       WHEN @param1 = '@FU' THEN @fu  
       WHEN @param1 = '@FX' THEN @fx  
       WHEN @param1 = '@FC' THEN @fc  
       WHEN @param1 = 'FVCP' THEN @FVCP  
       WHEN @param1 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)  
       END  
  
    SELECT @fecvto = CASE WHEN @param2 = '@FP' THEN @fp  
       WHEN @param2 = '@FE' THEN @fe  
       WHEN @param2 = '@FV' THEN @fV  
       WHEN @param2 = '@FU' THEN @fu  
       WHEN @param2 = '@FX' THEN @fx  
       WHEN @param2 = '@FC' THEN @fc         
                                                        WHEN @param2 = 'FVCP' THEN @FVCP  
       WHEN @param2 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)  
       END  
  
    EXECUTE Svc_fmu_dif_d30 @fecini, @fecvto, @DIFDIAS OUTPUT  
  
    SET @SQLString = 'UPDATE #tabla_desarrollo SET ' + @cVariab + ' = ' + @DIFDIAS + 'WHERE NCUP = ' + @NCUP  
    --' = @DIFDIAS WHERE NCUP = @NCUP'  
  
   END  
   ELSE  
   BEGIN  
    SET @SQLString = 'UPDATE #tabla_desarrollo SET ' + @cVariab + ' = ' + @cFormu + ' WHERE NCUP = @NCUP'  
  
   END  
  
   SET @ParmDefinition = N'@TR FLOAT , @TE FLOAT ,@TV FLOAT ,@TT FLOAT ,@BA FLOAT ,@BF FLOAT ,@NOM FLOAT ,@MT FLOAT ,@VV FLOAT ,@VP FLOAT ,@PVP FLOAT ,@VAN FLOAT ,@FP DATETIME ,  
                                                @FE DATETIME ,@FV DATETIME ,@FU DATETIME ,@FX DATETIME ,@FC DATETIME ,  
                                               @CI FLOAT ,@CT FLOAT ,@INDEV FLOAT,@FIP DATETIME,@CAP FLOAT,@INCTR FLOAT,@TD_SUMINT FLOAT ,@TD_SUMAMO FLOAT ,@TD_SUMFLU FLOAT ,@TD_SUMSAL FLOAT   
                                                ,@TD_SUMFDE FLOAT ,@PX_IN FLOAT,@PX_AM FLOAT,@V001 FLOAT ,@V002 FLOAT ,@V003 FLOAT ,@V004 FLOAT ,@V005 FLOAT ,@V006 FLOAT ,  
                                                @V007 FLOAT ,@V008 FLOAT ,@V009 FLOAT ,@V010 FLOAT ,@NCUP INTEGER,@FVCP DATETIME,@INTE FLOAT,@AMOR FLOAT,@FLUJ FLOAT,@SALD FLOAT,  
                                                @DIFD FLOAT,@DIFDIAS INTEGER,@SPREAD FLOAT,@FACTOR FLOAT,@DUR_MAC FLOAT,@DUR_MOD FLOAT,@CONVEXI FLOAT,@cod_nemo CHAR(20)' -- MAP 20180103  
  
  
  
   EXECUTE sp_executesql @SQLString ,   
    @ParmDefinition,   
    @TR,  
    @TE,  
    @TV,  
    @TT,  
    @BA,  
    @BF,  
    @NOM,  
    @MT,  
    @VV,  
    @VP,  
    @PVP,  
    @VAN,  
    @FP,  
    @FE,  
    @FV,  
    @FU,  
    @FX,  
    @FC,  
    @CI,  
    @CT,  
    @INDEV,  
    @FIP,  
    @CAP,  
    @INCTR,  
    @TD_SUMINT,  
    @TD_SUMAMO,  
    @TD_SUMFLU,  
    @TD_SUMSAL,  
    @TD_SUMFDE,  
    @PX_IN,  
    @PX_AM,  
    @V001,  
    @V002,  
    @V003,  
    @V004,  
    @V005,  
    @V006,  
    @V007,  
    @V008,  
    @V009,  
    @V010,   
    @NCUP,  
    @FVCP,  
    @INTE,  
    @AMOR,  
    @FLUJ,  
    @SALD,  
    @DIFD,  
    @DIFDIAS,  
    @SPREAD,  
    @FACTOR,  
                                @DUR_MAC,  
                                @DUR_MOD,  
                                @CONVEXI,
								@cod_nemo -- MAP 20180103 
  
  
  
   UPDATE #tabla_desarrollo  
   SET FLUJ = INTE + AMOR  
  
   SELECT @TD_SUMINT = ISNULL(SUM(INTE),0),  
    @TD_SUMAMO = ISNULL(SUM(AMOR),0),  
    @TD_SUMFLU = ISNULL(SUM(FLUJ),0),  
    @TD_SUMSAL = ISNULL(SUM(SALD),0),  
    @TD_SUMFDE = ISNULL(SUM(FLDE),0)  
   FROM #tabla_desarrollo  
  
   UPDATE #TMP_VALORIZACION  
   SET TD_SUMINT = @TD_SUMINT,  
    TD_SUMAMO = @TD_SUMAMO,  
    TD_SUMFLU = @TD_SUMFLU,  
    TD_SUMSAL = @TD_SUMSAL,  
    TD_SUMFDE = @TD_SUMFDE  
  
  END  
  
  SET ROWCOUNT 1  
  
  IF @dFecPro = @FU  
  BEGIN  
   
   SELECT @PX_IN  = FACTOR * (INTE * (@Nom / 100)),  
    @PX_AM  = FACTOR * (AMOR * (@Nom / 100)),  
    @FACTOR  = FACTOR  
   FROM #TABLA_DESARROLLO   
   WHERE FVCP = @dFecPro  
   ORDER  
   BY FVCP  
  
  END  
  ELSE BEGIN  
  
   SELECT @PX_IN  = FACTOR * (INTE * (@Nom / 100)),  
    @PX_AM  = FACTOR * (AMOR * (@Nom / 100))  
   FROM #TABLA_DESARROLLO   
   WHERE FVCP > @dFecPro  
   ORDER  
   BY FVCP  
  END  
  
  SET ROWCOUNT 0  
  
  SELECT @vv = @PX_IN + @PX_AM  
  
  UPDATE #TMP_VALORIZACION  
  SET PX_IN  = @PX_IN,  
   PX_AM  = @PX_AM,  
   vv   = @vv  
 END  
           
 IF @cTipForm = 'C'  
 BEGIN  
                IF @cFormu = 'DUR_MAC()'   
  BEGIN  
                   EXECUTE Svc_Prc_val_DurMac @dFecPro , @TipFomulas , @cod_familia , @cod_nemo , @NOM , @TR , 1 , @DUR_MAC OUTPUT   
                   -- ' = @DUR_MAC' -- + @cVariab  
                   IF @cod_familia <> 2000 -- @cod_familia = 2001
                      SET @DUR_MAC = ROUND( DATEDIFF(DAY, @FP, @FV ) / 365.0, 8)

                   SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = ' + CONVERT(VARCHAR(50),@DUR_MAC) 
                END ELSE  
                IF @cFormu = 'DUR_MOD()'   
  BEGIN  
                   EXECUTE Svc_Prc_val_DurMac @dFecPro , @TipFomulas , @cod_familia , @cod_nemo , @NOM , @TR , 2 , @DUR_MOD OUTPUT   
                   --' = @DUR_MOD' -- + @cVariab  
                   IF @cod_familia <> 2000 -- @cod_familia = 2001
                      SET @DUR_MOD = ROUND( ROUND( DATEDIFF(DAY, @FP, @FV ) / 365.0, 8) / (1.0 + ( @TR / 100.0 )),2)

                   SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = ' + CONVERT(VARCHAR(50),@DUR_MOD) 
                END ELSE  
                IF @cFormu = 'CONVEXI()'   
  BEGIN  
                   EXECUTE Svc_Prc_val_DurMac @dFecPro , @TipFomulas , @cod_familia , @cod_nemo , @NOM , @TR , 3 , @CONVEXI OUTPUT   
                   --' = @CONVEXI' --+ @cVariab  
                   IF @cod_familia <> 2000 -- @cod_familia = 2001
                      SET @CONVEXI = ROUND( POWER( ROUND( DATEDIFF( DAY, @FP, @FV ) / 365.0, 8),2) / POWER( 1.0 +( @TR / 100.0) * round(DATEDIFF(DAY, @FP, @FV ) / 365.0, 8), 2), 2)

                   SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = ' + CONVERT(VARCHAR(50),@CONVEXI) 
                END ELSE  
  IF @cFormu = 'DIFDIA_REALES()'   
  BEGIN  
   IF @param1 = '@FC,@FU' BEGIN  
    SELECT @param1 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)  
   END  
   IF @param2 = '@FC,@FU' BEGIN  
    SELECT @param2 = (CASE WHEN @fc > @fu THEN convert(char(10),@fc,110) ELSE convert(char(10),@fu,110) END)  
   END   
   SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = DATEDIFF(DAY, ' + @param1 + ',' + @param2 + ')'  
  END  
  ELSE  
  IF @cFormu = 'DIFDIA_BASE30()'  
  BEGIN  
   -- CACULO DE @Var_DIFDIA_30  
   SELECT @fecini = CASE WHEN @param1 = '@FP' THEN @fp  
      WHEN @param1 = '@FE' THEN @fe  
      WHEN @param1 = '@FV' THEN @fV  
      WHEN @param1 = '@FU' THEN @fu  
      WHEN @param1 = '@FX' THEN @fx  
      WHEN @param1 = '@FC' THEN @fc  
      WHEN @param1 = '@FIP' THEN @fip  
      WHEN @param1 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)  
  
      END  
  
   SELECT @fecvto = CASE WHEN @param2 = '@FP' THEN @fp  
      WHEN @param2 = '@FE' THEN @fe  
      WHEN @param2 = '@FV' THEN @fV  
      WHEN @param2 = '@FU' THEN @fu  
      WHEN @param2 = '@FX' THEN @fx  
      WHEN @param2 = '@FC' THEN @fc        
                                                WHEN @param2 = '@FIP' THEN @fip  
      WHEN @param2 = '@FC,@FU' THEN (CASE WHEN @fc > @fu THEN @fc ELSE @fu END)  
      END  
  
   EXECUTE Svc_fmu_dif_d30 @fecini, @fecvto, @DIFDIAS OUTPUT  
   SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = ' + CONVERT(VARCHAR(12),@DIFDIAS)  
   --' = @DIFDIAS'  
  
  END  
  ELSE  
  IF @cFormu = 'CALCULO_TIR()'  
  BEGIN  
  
                  
   SELECT @TR = @TV ,  
    @Precis = 4 ,  
    @z_TR = 0 ,  
    @z_Pvp = @PVP ,  
    @z_MT = @MT ,  
    @xMA = 50 ,  
    @xME = 0 ,  
    @xx = 1  
  
   WHILE @xx < 51   
   BEGIN  
  
   EXECUTE Svc_Prc_val_cti  
      @dFecPro ,  
      @TipFomulas ,  
      2  ,  
      @cod_familia ,  
      @cod_nemo ,  
      @fecha_vcto ,  
      @TR   OUTPUT ,  
      @TE  ,  
      @TV  ,  
      @TT  ,  
      @BA  ,  
      @BF  ,  
      @NOM  ,  
      @MT  OUTPUT ,  
      @VV  ,  
      @VP  ,  
      @PVP  ,  
      @VAN  ,  
      @FP  ,  
      @FE  ,  
      @FV  ,  
      @FU  ,  
      @FX  ,  
      @FC  ,  
      @CI  ,  
      @CT  ,  
      @INDEV  ,  
      @PRINC  ,  
      @FIP  ,  
      @CAP  ,  
      @INCTR  ,  
      @SPREAD  ,  
      @FACTOR         ,  
                                                @DUR_MAC        ,  
                                                @DUR_MOD        ,  
                                                @CONVEXI           
  
  
    SELECT @z_TR = ROUND(@TR,@Precis)  
  
    IF ROUND(@MT,2) <> ROUND(@z_MT,2)  
    BEGIN  
     IF ROUND(@MT,2) < ROUND(@z_MT,2)  
     BEGIN  
      SELECT @xMA = @TR  
      SELECT @TR  = ( @xMA - @xME ) / 2 + @xME  
     END  
     ELSE  
     BEGIN  
      SELECT @xME = @TR  
      SELECT @TR  = ( @xMA - @xME ) / 2 + @xME  
     END  
    END  
  
    IF @z_TR = ROUND(@TR,@Precis)   
                                 BREAK  
  
    SELECT @xx = @xx + 1  
  
   END  
  
   SELECT @Pvp = @z_PVP,  
    @MT = @z_MT  
  
   SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' = @' + @cVariab  
  
  END  
  ELSE  
  BEGIN  
   --SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' =  ' + @cFormu  
   --+++jcamposd COP toma la tasa digitada post devengo.
   	--IF @cod_familia = 2006 and  @EstadodevengoRealizado = 1 and @cVariab = 'INDEV' --+++jcamposd 20161229
   	IF @cod_familia = 2006 and @cVariab = 'INDEV' and (@EstadodevengoRealizado = 1 OR @ESVENTA = 'S')
	BEGIN 
		SET @cFormu = 'ROUND(  ROUND( ((((POWER((1+ (@TE/100)),(@V001/360))-1)*(360/@V001))*@V001)/360),6)   *@nom , 0 )'
		SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' =  ' + @cFormu			
	END
	ELSE
	BEGIN
		SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' =  ' + @cFormu   --linea original	
	END
   
	--IF @cod_familia = 2006 and  @EstadodevengoRealizado = 1 and @cVariab = 'MT' ---+++jcamposd 20161229
	IF @cod_familia = 2006 and @cVariab = 'MT' and (@EstadodevengoRealizado = 1 OR @ESVENTA = 'S') 
	BEGIN 
			--select ROUND(POWER((1 + (7.4720/100.00)),(116/365.00)),0)
			--set @TR =  7.4720
			--select ( (@INDEV +  @PRINC) /ROUND(POWER((1 + (@TR/100)),(@V001/365.00)),0))
			SET @cFormu = 'ROUND((@INDEV +  @PRINC) /POWER((1 + (@TR/100)),(@V002/365.00)),6)'
			SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' =  ' + @cFormu			
	END
	ELSE
	BEGIN
		SET @SQLString = 'UPDATE #TMP_VALORIZACION SET ' + @cVariab + ' =  ' + @cFormu   --linea original	
	END
	-----jcamposd COP
   
  END  
  
  
  SET @ParmDefinition = N'@TR FLOAT, @TE FLOAT , @TV FLOAT , @TT FLOAT , @BA FLOAT , @BF FLOAT , @NOM FLOAT ,  
                 @MT FLOAT , @VV FLOAT , @VP FLOAT , @PVP FLOAT , @VAN FLOAT ,@FP DATETIME , @FE DATETIME ,@FV DATETIME ,   
                 @FU DATETIME ,@FX DATETIME ,@FC DATETIME, @CI FLOAT ,@CT FLOAT ,@INDEV FLOAT,@PRINC FLOAT,@FIP DATETIME ,  
                 @CAP FLOAT,@INCTR FLOAT,@TD_SUMINT FLOAT ,@TD_SUMAMO FLOAT ,@TD_SUMFLU FLOAT ,@TD_SUMSAL FLOAT ,  
                 @TD_SUMFDE FLOAT ,@PX_IN FLOAT,@PX_AM FLOAT,@V001 FLOAT ,@V002 FLOAT ,@V003 FLOAT ,@V004 FLOAT ,  
                 @V005 FLOAT, @V006 FLOAT ,@V007 FLOAT ,@V008 FLOAT ,@V009 FLOAT ,@V010 FLOAT ,@DIFDIAS INTEGER ,  
                 @SPREAD FLOAT,@FACTOR FLOAT,@DUR_MAC FLOAT,@DUR_MOD FLOAT,@CONVEXI FLOAT,@cod_nemo CHAR(20)'   -- MAP 20180103
                EXECUTE sp_executesql   @SQLString     ,   
     @ParmDefinition,  
     @TR,  
     @TE,  
     @TV,  
     @TT,  
     @BA,  
     @BF,  
     @NOM,  
     @MT,  
     @VV,  
     @VP,  
     @PVP,  
     @VAN,  
     @FP,  
     @FE,  
     @FV,  
     @FU,  
     @FX,  
     @FC,  
     @CI,  
     @CT,  
     @INDEV,  
     @PRINC,  
     @FIP,  
     @CAP,  
     @INCTR,  
     @TD_SUMINT,  
     @TD_SUMAMO,  
     @TD_SUMFLU,  
     @TD_SUMSAL,  
     @TD_SUMFDE,  
     @PX_IN,  
     @PX_AM,  
     @V001,  
     @V002,  
     @V003,  
     @V004,  
     @V005,  
     @V006,  
     @V007,  
     @V008,  
     @V009,  
     @V010,  
     @DIFDIAS,  
     @SPREAD,  
     @FACTOR,  
                                        @DUR_MAC,  
     @DUR_MOD,  
                                        @CONVEXI,
										@cod_nemo -- MAP 20180103  
  
 END  
  
  UPDATE #TMP_VALORIZACION  
  SET MT = ROUND(MT,@Redondeo),  
   VV = ROUND(VV,@Redondeo),  
   INDEV = ROUND(INDEV,@Redondeo),  
   PRINC = ROUND(PRINC,@Redondeo)  
  
  SELECT @TR  = TR  ,  
   @TE  = TE  ,  
   @TV  = TV  ,  
   @TT  = TT  ,  
   @BA  = BA  ,  
   @BF  = BF  ,  
   @NOM  = NOM  ,  
   @MT  = MT  ,  
   @VV  = VV  ,  
   @VP  = VP  ,  
   @PVP  = PVP  ,  
   @VAN  = VAN  ,  
   @FP  = FP  ,  
   @FE  = FE  ,  
   @FV  = FV  ,  
   @FU  = FU  ,  
   @FX  = FX  ,  
   @FC  = FC  ,  
   @CI  = CI  ,  
   @CT  = CT  ,  
   @INDEV  = INDEV  ,  
   @PRINC  = PRINC  ,  
   @FIP  = FIP  ,  
   @CAP  = CAP  ,  
   @INCTR  = INCTR  ,  
   @TD_SUMINT = TD_SUMINT ,  
   @TD_SUMAMO = TD_SUMAMO ,  
   @TD_SUMFLU = TD_SUMFLU ,  
   @TD_SUMSAL = TD_SUMSAL ,  
   @TD_SUMFDE = TD_SUMFDE ,  
   @PX_IN  = PX_IN  ,  
   @PX_AM  = PX_AM  ,  
   @V001  = V001  ,  
   @V002  = V002  ,  
   @V003  = V003  ,  
   @V004  = V004  ,  
   @V005  = V005  ,  
   @V006  = V006  ,  
   @V007  = V007  ,     
   @V008  = V008  ,  
   @V009  = V009  ,  
   @V010  = V010  ,  
   @SPREAD  = SPREAD ,  
   @FACTOR  = FACTOR        ,  
                        @DUR_MAC        = DUR_MAC       ,  
                        @DUR_MOD        = DUR_MOD       ,  
                        @CONVEXI        = CONVEXI  
  FROM #TMP_VALORIZACION  
  
 END  
  
  
 UPDATE #TMP_VALORIZACION  
 SET MT = ROUND(MT,@Redondeo),  
  VV = ROUND(VV,@Redondeo),  
  INDEV = ROUND(INDEV,@Redondeo),  
  INCTR = ROUND(INCTR,@Redondeo),  
  PRINC = ROUND(PRINC,@Redondeo)  
  
 SELECT @TR  = TR  ,  
  @TE  = TE  ,  
  @TV  = TV  ,  
  @TT  = TT  ,  
  @BA  = BA  ,  
  @BF  = BF  ,  
  @NOM  = NOM  ,  
  @MT  = ISNULL ( MT , 0 ) ,  
  @VV  = ISNULL ( VV , 0 ) ,  
  @VP  = ISNULL ( VP , 0 ) ,  
  @PVP  = ISNULL ( PVP , 0 ) ,  
  @VAN  = ISNULL ( VAN , 0 ) ,  
  @FP  = FP  ,  
  @FE  = FE  ,  
  @FV  = ISNULL ( FV , '') ,  
  @FU  = ISNULL ( FU , ''),  
  @FX  = ISNULL ( FX , ''),  
  @FC  = ISNULL ( FC , ''),  
  @CI  = CI  ,  
  @CT  = CT  ,  
  @INDEV  = ISNULL ( INDEV, 0 )  ,  
  @PRINC  = ISNULL ( PRINC, 0 )  ,  
  @FIP  = FIP  ,  
  @CAP  = CAP  ,  
  @INCTR  = ISNULL ( INCTR, 0 )  ,  
  @TD_SUMINT = TD_SUMINT ,  
  @TD_SUMAMO = TD_SUMAMO ,  
  @TD_SUMFLU = TD_SUMFLU ,  
  @TD_SUMSAL = TD_SUMSAL ,  
  @TD_SUMFDE = TD_SUMFDE ,  
  @PX_IN  = PX_IN  ,  
  @PX_AM  = PX_AM  ,  
  @V001  = V001  ,  
  @V002  = V002  ,  
  @V003  = V003  ,  
  @V004  = V004  ,  
  @V005  = V005  ,  
  @V006  = V006  ,  
  @V007  = V007  ,  
  @V008  = V008  ,  
  @V009  = V009  ,  
  @V010  = V010  ,  
  @SPREAD  = SPREAD ,  
                @FACTOR  = FACTOR        ,   
                @DUR_MAC        = DUR_MAC       ,  
                @DUR_MOD        = DUR_MOD       ,  
                @CONVEXI        = CONVEXI  
 FROM #TMP_VALORIZACION  
  
 IF @Retorno = 'S' BEGIN  
  SELECT   
  TR  ,  
  TE  ,  
  TV  ,  
  TT  ,  
  BA  ,  
  BF  ,  
  NOM  ,  
  'MT' = ISNULL ( MT , 0 ) ,  
  'VV' = ISNULL ( VV , 0 ) ,  
  'VP' = ISNULL ( VP , 0 ) ,  
  'PVP' = ISNULL ( PVP , 0 ) ,  
  'VAN' = ISNULL ( VAN , 0 ) ,  
  FP  ,  
  FE  ,  
  'FV' = ISNULL ( FV , '') ,  
  'FU' = ISNULL ( FU , ''),  
  'FX' = ISNULL ( FX , ''),  
  'FC' = ISNULL ( FC , ''),  
  'CI' = ISNULL ( CI , 0 ),  
  CT  ,  
  'INDEV' = ISNULL ( INDEV, 0 ),  
  'PRINC' = ISNULL ( PRINC, 0 ),  
  FIP  ,  
  CAP  ,  
  'INCTR' = ISNULL ( INCTR, 0 )  ,  
  SPREAD           ,                                       
  TD_SUMINT         ,                                      
  TD_SUMAMO         ,                                      
  TD_SUMFLU         ,                                      
  TD_SUMSAL         ,                                      
  TD_SUMFDE         ,                                      
  PX_IN             ,             
  PX_AM             ,                                      
  'V001' = ISNULL ( V001 ,0)              ,                                      
  'V002' = ISNULL ( V002 ,0)             ,                                      
  'V003' = ISNULL ( V003 ,0)         ,                                    
  'V004' = ISNULL ( V004 ,0)             ,        
  'V005' = ISNULL ( V005 ,0)             ,                                      
  'V006' = ISNULL ( V006 ,0)   ,                                      
  'V007' = ISNULL ( V007 ,0)             ,                                      
  'V008' = ISNULL ( V008 ,0)             ,                                      
  'V009'    = ISNULL ( V009 ,0)             ,                                      
  'V0010'    = ISNULL ( V010 ,0)             ,                                      
  FACTOR                                  ,  
                'DUR_MAC'  = ISNULL(@DUR_MAC,0.0) ,  
             'DUR_MOD'  = ISNULL(@DUR_MOD,0.0) ,  
                'CONVEXI'  = ISNULL(@CONVEXI,0.0)  
  FROM #TMP_VALORIZACION  
   
 END  
  
      DROP TABLE #TMP_FORMULA  
  
 SET NOCOUNT OFF  
  
END  
GO
