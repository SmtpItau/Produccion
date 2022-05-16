USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ayuda_Codigo_Comercio]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Ayuda_Codigo_Comercio]

AS
BEGIN

      SET NOCOUNT ON
      SET DATEFORMAT dmy

      SELECT 
       comercio
      ,glosa 
      FROM CODIGO_COMERCIO

      SET NOCOUNT OFF

END



GO
