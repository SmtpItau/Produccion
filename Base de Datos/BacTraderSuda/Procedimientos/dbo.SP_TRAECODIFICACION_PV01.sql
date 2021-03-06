USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAECODIFICACION_PV01]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAECODIFICACION_PV01]
                           (  @parsistema CHAR(03)  ,
    @pareplazo INTEGER  ,
    @paremoneda  CHAR(03)  ,
    @partype CHAR(02)  ,
    @paroper CHAR(02)  ,
    @parpasivo CHAR(01)  ,
    @parvalueir FLOAT  ,
    @paremonedaVT CHAR(02)='' )
AS
BEGIN
 DECLARE @cllave0 CHAR(10)  ,
  @cllave  CHAR(20)  ,
  @cID_aux CHAR(01)  ,
  @cemer_aux CHAR(04)
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
 IF @parvalueir IS NULL  SELECT @parvalueir = 0
     /* _______________________________________________________________________________________________________________
 Se realiza tabulaci¢n de plazos para codificaci¢n 
      =============================================================================================================== */
/* IF @pareplazo < 28 BEGIN
  IF CONVERT(INTEGER,(@pareplazo/7))<= 0 SELECT @cllave = 'o/n'+ SPACE(07)
     ELSE   SELECT @cllave = RTRIM(CONVERT(CHAR(2),CONVERT(INTEGER,(@pareplazo/7))))+'W'+SPACE(7)
 END
 ELSE
  IF CONVERT(INTEGER,(@pareplazo/28))<= 12  
   SELECT @cllave = RTRIM(CONVERT(CHAR(2),CONVERT(INTEGER,(@pareplazo/28))))+'M'+SPACE(7)
  ELSE
        IF CONVERT(INTEGER,(@pareplazo/28))> 12 AND CONVERT(INTEGER,(@pareplazo/28))<=18  
           SELECT @cllave = '18M' + SPACE(07)
        ELSE
           IF CONVERT(INTEGER,(@pareplazo/365))< 2 
        SELECT @cllave = RTRIM(CONVERT(CHAR(02),CONVERT(INTEGER,(@pareplazo/365))+1))+'Y'+SPACE(07)
           ELSE
     IF CONVERT(INTEGER,(@pareplazo/365)) >= 2 
         SELECT @cllave = RTRIM(CONVERT(CHAR(02),CONVERT(INTEGER,(@pareplazo/365))))+'Y'+SPACE(07)
*/ 
 SELECT @cllave   = descripcion  FROM BAC_PLAZOS_INTER WHERE codigo_inter ='PV01' AND  @pareplazo >= dia_inicial AND @pareplazo <= dia_final  
 SELECT @cllave   = @cllave0 + RTRIM(@cllave)
 IF @parpasivo = 'S'  SELECT @parvalueir = @parvalueir *-1
 SELECT @cID_Aux = CASE 
   WHEN PATINDEX('%W%',@cllave) > 0 THEN 'D' 
   WHEN PATINDEX('%n%',@cllave) > 0 THEN 'A' 
   ELSE SUBSTRING(RTRIM(@cllave),DATALENGTH(RTRIM(@cllave)),1) END
 SELECT @cemer_aux = SUBSTRING(@cllave,1,4)
     /* __________________________________________________________________________________________________________________________________ 
 Actualizo montos para registrar informaci¢n por sistema 
 ================================================================================================================================== */  
 IF NOT EXISTS( SELECT * FROM BAC_INTER_PV01 WHERE id_sistema=@parsistema AND idc=@cid_aux AND emer_mark=@cemer_aux AND LTRIM(RTRIM(ano))=LTRIM(RTRIM(SUBSTRING(@cllave,5,10))) ) BEGIN
  INSERT INTO 
  BAC_INTER_PV01( 
   id_sistema  ,
   header  ,
   san  , 
   emer_mark ,
   latamericam ,
   trading  ,
   ano  ,
   idc  )
  VALUES(
   @parsistema ,
   'IR'  ,
   'CLP'  ,
   @cemer_aux ,
   'REST'  ,
   'CHL'  ,
   LTRIM(RTRIM(SUBSTRING(@cllave,5,10))),
   @cID_aux  )
 END 
 UPDATE  BAC_INTER_PV01 
 SET  ir = ISNULL(ir,0) + @parvalueir 
 WHERE  id_sistema  = @parsistema
 AND  idc  = @cid_aux 
 AND  ano   = LTRIM(RTRIM(SUBSTRING(@cllave,5,10) ))
 AND     emer_mark       = @cemer_aux 
 
     /* __________________________________________________________________________________________________________________________________
 Actualizo información consolidada del pv01 
 =================================================================================================================================== */  
 IF NOT EXISTS( SELECT * FROM BAC_INTER_PV01 WHERE id_sistema ='CON' AND idc=@cid_aux AND emer_mark=@cemer_aux AND LTRIM(RTRIM(ano)) = LTRIM(RTRIM(SUBSTRING(@cllave,5,10))) )  BEGIN
  INSERT INTO 
  BAC_INTER_PV01( 
   id_sistema , 
   header  ,
   san  ,
   emer_mark ,
   latamericam ,
   trading  ,
   ano  ,
   idc   )
  VALUES(
   'CON'  ,
   'IR'  ,
   'CLP'  ,
   @cemer_aux  ,
   'REST'  ,
   'CHL'  ,
   LTRIM(RTRIM(SUBSTRING(@cllave,5,10))), 
   @cid_aux  )
 END 
 UPDATE BAC_INTER_PV01 SET ir = ISNULL(ir,0) + @parvalueir 
 WHERE  id_sistema  = 'CON' 
 AND  idc  = @cid_aux 
 AND  ano   = LTRIM(RTRIM(SUBSTRING(@cllave,5,10) ))
 AND     emer_mark       = @cemer_aux 
     /* =================================================================================================================================== */  
END

GO
