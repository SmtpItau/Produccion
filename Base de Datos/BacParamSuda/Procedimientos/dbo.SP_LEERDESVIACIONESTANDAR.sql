USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERDESVIACIONESTANDAR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
