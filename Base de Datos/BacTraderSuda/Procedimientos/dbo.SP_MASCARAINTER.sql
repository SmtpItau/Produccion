USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MASCARAINTER]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_MASCARAINTER]
    (
    @cInst  CHAR (12) ,
    @iForpagi INTEGER  ,
    @iForpagv INTEGER  ,
    @dFecven DATETIME
    )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @cPagoInicio CHAR (20) ,
  @cPagovcto CHAR (20) ,
  @cPgIni  CHAR (02) ,
  @cPgVcto CHAR (02) ,
  @cUf  CHAR (02) ,
  @cInstAux CHAR (12) ,
  @iCodigo INTEGER
 SELECT @cPagoInicio = glosa FROM VIEW_FORMA_DE_PAGO WHERE @iForpagi=codigo
 SELECT @cPagovcto = glosa FROM VIEW_FORMA_DE_PAGO WHERE @iForpagv=codigo
 SELECT @cUf  = ''
 SELECT @cPgIni = CASE
    WHEN @cPagoInicio='VALE CAMARA' THEN 'VC'
    WHEN @cPagoInicio='VISTA / CAMARA' THEN 'VV'
    WHEN @cPagoInicio='VALE VISTA BSA' THEN 'VV'
    ELSE ''
     END
 SELECT @cPgVcto = CASE
     WHEN @cPagoInicio='VALE CAMARA' THEN 'VC'
     WHEN @cPagoInicio='VISTA / CAMARA' THEN 'VC'
     WHEN @cPagoInicio='VALE VISTA BSA' THEN 'VV'
     ELSE ''
      END
 IF @cPgIni='VV' AND @cPgVcto='VV'
 BEGIN
  IF (SELECT ISNULL(vmvalor,0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo=998 AND vmfecha=@dFecven)>0
   SELECT @cUf = ' C'
  ELSE
   SELECT @cUf = ' D'
 END
 IF @cPgIni='' AND @cPgVcto=''
  SELECT @cInstAux = @cInst
 ELSE
  SELECT @cInstAux = RTRIM(@cInst)+' '+@cPgIni+'/'+@cPgVcto+@cUf
 SELECT @iCodigo = incodigo FROM VIEW_INSTRUMENTO WHERE inserie=@cInstAux
 SELECT @cInstAux,@iCodigo
END
-- Sp_MascaraInter 'ICOL',5,5,'20020703'
-- Sp_MascaraInter 'ICAP',5,5,'20010703'
-- Sp_MascaraInter 'ICAP',10,10,'20020703'
-- Sp_MascaraInter 'ICAP',4,4,'20020703'
-- select * from VIEW_FORMA_DE_PAGO order by codigo
-- select * from VIEW_INSTRUMENTO

GO
