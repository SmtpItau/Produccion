USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAECODIFICACION_PV02]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAECODIFICACION_PV02]
                     (  @parsistema CHAR(03) ,
   @pareplazo INTEGER  ,
   @paremoneda  CHAR(03) ,
   @partype CHAR(10) ,
   @paroper CHAR(02) ,
   @parpasivo CHAR(01) ,
   @parvalue FLOAT  ,
   @paremonedaVT CHAR(02)=''     )
AS
BEGIN
 DECLARE @cllave0  CHAR(10) ,
  @cllave  CHAR(20) ,
  @cperiodo CHAR(01) ,
  @frango  NUMERIC(10,0) ,
  @crango  VARCHAR(20) ,
  @nnn  NUMERIC(18,7)
 IF @parvalue IS NULL  
  SELECT @parvalue = 0.0
 IF @parsistema = 'BTR'
 BEGIN
  IF @paroper = 'CP'  
   IF @partype ='GO' 
    SELECT @cllave0 = 'GO' + 'VTS' 
   ELSE
    SELECT @cllave0 = 'REST'
  IF @paroper = 'VI'  OR  @paroper = 'CI'  OR @paroper = 'IC' OR @paroper = 'IB'
   SELECT @cllave0 = 'LOANS/DEP.'
 END 
 IF @parsistema = 'BFW'  SELECT @cllave0 = 'FORWARDS'
 IF @parsistema = 'BCC' SELECT @cllave0 = 'FX'
-- SELECT @PAROPER, @CLLAVE0, @PARTYPE 
     /* Organizacion de plazos correspondientes al CRI para estructuración de montos 
 ============================================================================ */
 SELECT @crango   = descripcion  FROM BAC_PLAZOS_INTER WHERE codigo_inter ='CRI' AND  @pareplazo >= dia_inicial AND @pareplazo <= dia_final 
 IF @pareplazo < 22 BEGIN
  IF @pareplazo < 8 SELECT @cperiodo = 'A'
  IF @pareplazo >= 8 SELECT @cperiodo = 'B' 
 END 
 ELSE BEGIN
  IF CONVERT(INTEGER,(@pareplazo/30))<= 21  SELECT @cperiodo = 'M'
  IF CONVERT(INTEGER,(@pareplazo/30)) > 21  SELECT @cperiodo = 'Y'
 END
     /* ============================================================================ */
 IF NOT EXISTS( SELECT * FROM BAC_INTER_PV02 WHERE product=@cllave0 AND bucket=@crango AND id_sistema=@parsistema ) BEGIN
  INSERT INTO
  BAC_INTER_PV02( id_sistema , informat, method , lon_sho, asset_al, risk_cla       ,  product,  bucket, currency,     llave,  pv01 )
  VALUES ( @parsistema, 'RISK'  ,'BVP_PA', 'NONE' , 'CLP'   , 'INTEREST_RATE', @cllave0, @crango,    'USD', @cperiodo,     0 ) 
 END
 IF @parpasivo = 'S'  SELECT @parvalue = @parvalue*-1
 SELECT @nnn = CONVERT(NUMERIC(18,7),ROUND(@parvalue,4))
 SELECT @nnn = @nnn / 1000.0
 UPDATE BAC_INTER_PV02 SET pv01 = pv01 + @NNN
 WHERE  product  = @cllave0 
 AND  bucket  = @crango 
 AND  id_sistema  = @parsistema 
END

GO
