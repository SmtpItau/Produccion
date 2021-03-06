USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAECODIFICACION_PV03]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAECODIFICACION_PV03]
                     (  @parsistema CHAR(03) ,
   @pareplazo INTEGER  ,
   @paremoneda  CHAR(03) ,
   @partype CHAR(02) ,
   @paroper CHAR(02) ,
   @parpasivo CHAR(01) ,
          @parvalue FLOAT  ,
   @parduration FLOAT  ,
   @parmonto FLOAT  ,
   @parcodmon INTEGER  )
AS
BEGIN
 DECLARE @fmontoUFp FLOAT ,
  @fdurUFp FLOAT ,
  @fmontoUF FLOAT ,
  @fdurUF  FLOAT ,
  @fmontoUSp FLOAT ,
  @fdurUSp FLOAT ,
  @fmontoUS FLOAT ,
  @fdurUS  FLOAT ,
   @fmontoCLp FLOAT ,
  @fdurCLp FLOAT ,
  @fmontoCL FLOAT ,
  @fdurCL  FLOAT ,
  @fvalueUFp FLOAT ,
  @fvalueUSp FLOAT ,
  @fvalueCLp FLOAT ,
  @fvalueUF FLOAT ,
  @fvalueUS FLOAT ,
  @fvalueCL FLOAT 
 DECLARE @cllave0  CHAR(10) ,
  @cllave  CHAR(20) ,
  @cperiodo CHAR(01) ,
  @frango  NUMERIC(10,0) ,
  @crango  CHAR(20)
 SELECT  @fmontoUFp = 0.0 ,
  @fdurUFp = 0.0 ,
  @fvalueUFp = 0.0 ,
  @fmontoUF = 0.0 ,
  @fdurUF  = 0.0 ,
  @fvalueUF = 0.0 ,
  @fmontoUSp = 0.0 ,
  @fdurUSp = 0.0 ,
  @fvalueUSp = 0.0 ,
  @fmontoUS = 0.0 ,
  @fdurUS  = 0.0 ,
  @fvalueUS = 0.0 ,
   @fmontoCLp = 0.0 ,
  @fdurCLp = 0.0 ,
  @fvalueCLp = 0.0 ,
  @fmontoCL = 0.0 ,
  @fdurCL  = 0.0 ,
  @fvalueCL = 0.0 
     /* Se redondean montos */
 SELECT  @parmonto  = ROUND( @parmonto,4) ,
  @parvalue = ROUND( @parvalue,4) ,
  @parduration  = ROUND( @parduration,4)
 IF @parsistema = 'BTR'      
 BEGIN
  IF @paroper = 'CP'  
   SELECT @cllave0 = @partype + CASE @paremoneda WHEN  'CL' THEN 'VT' ELSE @paremoneda END  
  IF @paroper = 'IB'
   SELECT @cllave0 = @partype + CASE @paremoneda WHEN  'CL' THEN 'KT' ELSE @paremoneda END
  IF @paroper = 'VI'  OR  @paroper = 'CI' 
   SELECT @cllave0 = 'RE'+ CASE @paremoneda WHEN 'CL' THEN 'PO' ELSE @paremoneda END
  IF @paroper = 'IC' 
   SELECT @cllave0 = 'DE' + CASE @paremoneda WHEN 'CL' THEN 'P' ELSE @paremoneda END
 END 
 ELSE 
  SELECT @cllave0 = RTRIM('ND' + CASE @paremoneda WHEN 'CL' THEN 'F ' ELSE @paremoneda END)
 SELECT @crango   = descripcion  FROM BAC_PLAZOS_INTER WHERE codigo_inter ='PV01' AND  @pareplazo >= dia_inicial AND @pareplazo <= dia_final  
 IF @pareplazo < 22 BEGIN
  IF @pareplazo < 8  SELECT @cperiodo = 'A'
  IF @pareplazo >= 8 SELECT @cperiodo = 'B' 
 END 
 ELSE BEGIN
  IF CONVERT(INTEGER,(@pareplazo/30))<= 21  SELECT @cperiodo = 'M'
  IF CONVERT(INTEGER,(@pareplazo/30)) > 21  SELECT @cperiodo = 'Y'
 END
 IF @parpasivo = 'S'  BEGIN
  SELECT @parvalue = @parvalue*-1
--  SELECT @parmonto = @parmonto*-1
  IF @paremoneda = 'CL'  OR @paremoneda = 'VT' OR @paremoneda = 'KT'   
   SELECT  @fmontoCLp = @parvalue ,
    @fdurCLp = @parduration*@parmonto  ,
    @fvalueCLp = @parmonto
  IF @paremoneda = 'UF'  
   SELECT  @fmontoUFp = @parvalue ,
    @fdurUFp = @parduration*@parmonto,
    @fvalueUFp = @parmonto  
  IF @paremoneda = 'US'  
   SELECT  @fmontoUSp = @parvalue ,
    @fdurUSp = @parduration*@parmonto,
    @fvalueUSp = @parmonto  
 END ELSE
 BEGIN 
  IF @paremoneda = 'CL'  OR @paremoneda = 'VT' OR @paremoneda = 'KT'   
   SELECT  @fmontoCL = @parvalue ,
    @fdurCL  = @parduration*@parmonto,
    @fvalueCL = @parmonto
  IF @paremoneda = 'UF'  
   SELECT  @fmontoUF = @parvalue ,
    @fdurUF  = @parduration*@parmonto,
    @fvalueUF = @parmonto  
  IF @paremoneda = 'US'
   SELECT  @fmontoUS = @parvalue ,
    @fdurUS  = @parduration*@parmonto,
    @fvalueUS = @parmonto  
 END
--SELECT @crango, @cllave0,@parvalue, @parduration, @parmonto,@parcodmon
 IF NOT EXISTS(SELECT * FROM BAC_INTER_PV03 WHERE id_sistema = @parsistema AND rango = @crango AND periodo = @cperiodo )   
 BEGIN  
  INSERT INTO 
  BAC_INTER_PV03(
   id_sistema  ,
   rango  ,
   periodo  ,
   mto_act_UF ,
   dur_act_UF ,
   pv01_act_UF ,
   mto_act_CLP ,
   dur_act_CLP ,
   pv01_act_CLP ,
   mto_act_USD ,
dur_act_USD ,
   pv01_act_USD ,
   mto_pas_UF ,
   dur_pas_UF ,
   pv01_pas_UF ,
   mto_pas_CLP ,
   dur_pas_CLP ,
   pv01_pas_CLP ,
   mto_pas_USD ,
   dur_pas_USD ,
   pv01_pas_USD 
   )
  VALUES( 
   @parsistema ,
   @crango  ,
   @cperiodo ,
   @fvalueUF ,
          @fdurUF  ,
   @fmontoUF ,
   @fvalueCL ,
          @fdurCL  ,
   @fmontoCL ,
   @fvalueUS ,
          @fdurUS  ,
   @fmontoUS ,
   @fvalueUFp ,
          @fdurUFp ,
   @fmontoUFp ,
   @fvalueCLp ,
          @fdurCLp ,
   @fmontoCLp ,
   @fvalueUSp ,
          @fdurUSp ,
   @fmontoUSp 
   )
 END  
 ELSE
                UPDATE BAC_INTER_PV03
                SET
                        mto_act_UF      = mto_act_UF    + @fvalueUF ,
                        dur_act_UF      = dur_act_UF    + @fdurUF ,
                        pv01_act_UF     = pv01_act_UF   + @fmontoUF ,
                        mto_act_CLP     = mto_act_CLP   + @fvalueCL ,
                        dur_act_CLP     = dur_act_CLP   + @fdurCL ,
                        pv01_act_CLP    = pv01_act_CLP  + @fmontoCL ,
                        mto_act_USD     = mto_act_USD   + @fvalueUS ,
                        dur_act_USD     = dur_act_USD   + @fdurUS ,
                        pv01_act_USD    = pv01_act_USD  + @fmontoUS ,
                        mto_pas_UF      = mto_pas_UF    + @fvalueUFp ,
                        dur_pas_UF      = dur_pas_UF    + @fdurUFp ,
                        pv01_pas_UF     = pv01_pas_UF   + @fmontoUFp ,
                        mto_pas_CLP     = mto_pas_CLP   + @fvalueCLp ,
                        dur_pas_CLP     = dur_pas_CLP   + @fdurCLp ,
                        pv01_pas_CLP    = pv01_pas_CLP  + @fmontoCLp ,
                        mto_pas_USD     = mto_pas_USD   + @fvalueUSp ,
                        dur_pas_USD     = dur_pas_USD   + @fdurUSp ,
                        pv01_pas_USD    = pv01_pas_USD  + @fmontoUSp 
  WHERE  id_sistema = @parsistema 
  AND  rango = @crango 
  AND  periodo = @cperiodo 
 
-- select @fvalueUF , @CRANGO, @fduruf, @fmontoUF 
     /* 
 Se actualiza informacion para informacion consolidada 
 ----------------------------------------------------- */
 IF NOT EXISTS(SELECT * FROM BAC_INTER_PV03 WHERE id_sistema = 'CON' AND rango = @crango AND periodo = @cperiodo ) 
 BEGIN
  INSERT INTO 
  BAC_INTER_PV03(
   id_sistema  ,
   rango  ,
   periodo  ,
   mto_act_UF ,
   dur_act_UF ,
   pv01_act_UF ,
   mto_act_CLP ,
   dur_act_CLP ,
   pv01_act_CLP ,
   mto_act_USD ,
   dur_act_USD ,
   pv01_act_USD ,
   mto_pas_UF ,
   dur_pas_UF ,
   pv01_pas_UF ,
   mto_pas_CLP ,
   dur_pas_CLP ,
   pv01_pas_CLP ,
   mto_pas_USD ,
   dur_pas_USD ,
   pv01_pas_USD 
   )
  VALUES( 
   'CON'  ,
   @crango  ,
   @cperiodo ,
   @fvalueUF ,
          @fdurUF  ,
   @fmontoUF ,
   @fvalueCL ,
          @fdurCL  ,
   @fmontoCL ,
   @fvalueUS ,
          @fdurUS  ,
   @fmontoUS ,
   @fvalueUFp ,
          @fdurUFp ,
   @fmontoUFp ,
   @fvalueCLp ,
          @fdurCLp ,
   @fmontoCLp ,
   @fvalueUSp ,
          @fdurUSp ,
   @fmontoUSp 
   )
 END  
 ELSE
  UPDATE BAC_INTER_PV03 
                SET
                        mto_act_UF      = mto_act_UF    + @fvalueUF ,
                        dur_act_UF      = dur_act_UF    + @fdurUF ,
                        pv01_act_UF     = pv01_act_UF   + @fmontoUF ,
                        mto_act_CLP     = mto_act_CLP   + @fvalueCL ,
                        dur_act_CLP     = dur_act_CLP   + @fdurCL ,
                        pv01_act_CLP    = pv01_act_CLP  + @fmontoCL ,
                        mto_act_USD     = mto_act_USD   + @fvalueUS ,
                        dur_act_USD     = dur_act_USD   + @fdurUS ,
                        pv01_act_USD    = pv01_act_USD  + @fmontoUS ,
                        mto_pas_UF      = mto_pas_UF    + @fvalueUFp ,
                        dur_pas_UF      = dur_pas_UF    + @fdurUFp ,
    pv01_pas_UF     = pv01_pas_UF   + @fmontoUFp ,
                        mto_pas_CLP     = mto_pas_CLP   + @fvalueCLp ,
                        dur_pas_CLP     = dur_pas_CLP   + @fdurCLp ,
                        pv01_pas_CLP    = pv01_pas_CLP  + @fmontoCLp ,
                        mto_pas_USD     = mto_pas_USD   + @fvalueUSp ,
                        dur_pas_USD     = dur_pas_USD   + @fdurUSp ,
                        pv01_pas_USD    = pv01_pas_USD  + @fmontoUSp 
  WHERE  id_sistema = 'CON'
  AND  rango = @crango 
  AND  periodo = @cperiodo 
END

GO
