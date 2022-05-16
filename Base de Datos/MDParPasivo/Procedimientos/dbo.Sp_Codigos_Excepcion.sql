USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Codigos_Excepcion]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Codigos_Excepcion]
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   SELECT codigo_excepcion
        , descripcion
        , mensaje
   FROM EXCEPCION
   WHERE codigo_excepcion <> ''

   SET NOCOUNT OFF

END

GO
