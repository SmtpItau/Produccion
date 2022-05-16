USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Tbcodigo_Oma]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Busca_Tbcodigo_Oma]
                  (
                   @cod CHAR(06)
                  )
AS
BEGIN

   SET NOCOUNT OFF
   SET DATEFORMAT dmy

      SELECT    
                comercio
      ,         glosa

      FROM      CODIGO_COMERCIO B

   SET NOCOUNT ON

END




GO
