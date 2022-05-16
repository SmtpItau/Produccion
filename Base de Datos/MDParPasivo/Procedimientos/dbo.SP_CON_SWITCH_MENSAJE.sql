USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SWITCH_MENSAJE]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_SWITCH_MENSAJE]
		( @opcion_menu CHAR(20))
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   IF EXISTS(SELECT * FROM REGLA_MENSAJE_DETALLE WHERE LTRIM(RTRIM(opcion_menu)) = LTRIM(RTRIM(@opcion_menu)))
   BEGIN

      SELECT 'S'

   END ELSE BEGIN

      SELECT 'N'

   END

END


GO
