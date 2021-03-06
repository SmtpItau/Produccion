USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICAR_CODIGO]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_VERIFICAR_CODIGO]
                           (@inserie          CHAR   (12),          
       @Codigo_Instrumento  NUMERIC( 3))
AS
BEGIN
 IF EXISTS(SELECT * FROM VIEW_INSTRUMENTO WHERE incodigo = @Codigo_Instrumento and inserie = @inserie)
    SELECT 'NO'
 ELSE
 begin
    IF EXISTS(SELECT * FROM VIEW_INSTRUMENTO WHERE incodigo = @Codigo_Instrumento and inserie <> @inserie)
  SELECT 'SI'
 end
END

GO
