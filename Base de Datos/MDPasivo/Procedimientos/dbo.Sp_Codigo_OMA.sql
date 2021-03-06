USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Codigo_OMA]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Codigo_OMA]
   (
         @codigo    CHAR(10)
   )
AS
BEGIN 
   SET NOCOUNT OFF
   SET DATEFORMAT dmy

	SELECT codigo_numerico
        ,      codigo_caracter
        ,      glosa
	FROM   CODIGO_OMA
	WHERE  codigo_numerico =   @codigo

   SET NOCOUNT ON
END




GO
