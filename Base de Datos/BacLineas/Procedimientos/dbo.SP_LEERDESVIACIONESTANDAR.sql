USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERDESVIACIONESTANDAR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERDESVIACIONESTANDAR]
AS
BEGIN
   SET NOCOUNT ON
   SELECT acdesviacionestandar
   FROM   view_mfac
   SET NOCOUNT OFF
END
GO
