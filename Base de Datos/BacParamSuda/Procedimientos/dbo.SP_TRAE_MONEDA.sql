USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_MONEDA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TRAE_MONEDA    fecha de la secuencia de comandos: 03/04/2001 15:18:13 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_TRAE_MONEDA    fecha de la secuencia de comandos: 14/02/2001 09:58:31 ******/
CREATE PROCEDURE [dbo].[SP_TRAE_MONEDA](@xCodigo  NUMERIC(3))
AS
BEGIN
set nocount on
  DECLARE @mnglosa   CHAR(35)
  DECLARE @mnnemo    CHAR(5)
  DECLARE @codfox    CHAR(3)
  DECLARE @mnbase    NUMERIC(3)
  DECLARE @dias      NUMERIC(5)
  SELECT @mnglosa  = isnull(mnglosa,0),
         @mnnemo   = isnull(mnnemo,' '),
         @mnbase   = isnull(mnbase, 0) , 
         @codfox   = isnull(mncodfox,' ')    FROM MONEDA
   WHERE mncodmon = @xCodigo
  SELECT @dias = 30
--  SELECT @dias = ISNULL(Folio,30) FROM GEN_FOLIOS WHERE Codigo = 'CAP' + RTRIM(@mnnemo)
  SELECT isnull(@mnglosa,0),
  isnull(@mnnemo,''),
         isnull(@mnbase,0),
         isnull(@dias,'')
set nocount off
END  /* FIN PROCEDIMIENTO */
GO
