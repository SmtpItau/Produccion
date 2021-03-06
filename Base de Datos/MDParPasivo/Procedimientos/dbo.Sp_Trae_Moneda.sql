USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Moneda]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Trae_Moneda](@xCodigo		NUMERIC(3))
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

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
         AND ESTADO<>'A'

  SELECT @dias = 30

  SELECT isnull(@mnglosa,0),
	 isnull(@mnnemo,' '),
         isnull(@mnbase,0),
         isnull(@dias,' ')

END


GO
