USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_LEEEJECUTIVO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_LEEEJECUTIVO]
AS
BEGIN
  SELECT codigo,nombre FROM view_EJECUTIVO ORDER BY nombre
END
GO
