USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Codigos_Area]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Carga_Codigos_Area]
AS
BEGIN
  SET NOCOUNT ON
  SET DATEFORMAT dmy  

     SELECT codigo_area  
     ,      descripcion
     FROM   AREA_PRODUCTO
  SET NOCOUNT OFF
END




GO
