USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Tbcodigo_Oma]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Tbcodigo_Oma]
AS
BEGIN
   SET NOCOUNT OFF
   SET DATEFORMAT dmy
      SELECT    codigo_numerico
      ,         codigo_caracter
      ,         glosa
      FROM      CODIGO_OMA
      ORDER BY  codigo_numerico
   SET NOCOUNT ON
END
















GO
