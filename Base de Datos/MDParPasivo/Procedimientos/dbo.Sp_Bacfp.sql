USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Bacfp]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[Sp_Bacfp]
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON

      SELECT codigo
            ,glosa
            ,cc2756
            ,diasvalor 
      FROM  FORMA_DE_PAGO 
  ORDER BY codigo
END         



GO
