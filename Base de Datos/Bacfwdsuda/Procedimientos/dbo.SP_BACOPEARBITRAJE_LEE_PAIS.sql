USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACOPEARBITRAJE_LEE_PAIS]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BACOPEARBITRAJE_LEE_PAIS]
AS 
BEGIN
   SET NOCOUNT ON
   SELECT 
 codigo_pais,
 nombre
   FROM VIEW_PAIS 
   ORDER BY nombre
   SET NOCOUNT OFF
END

GO
