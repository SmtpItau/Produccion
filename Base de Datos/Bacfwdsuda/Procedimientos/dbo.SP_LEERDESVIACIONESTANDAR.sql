USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERDESVIACIONESTANDAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEERDESVIACIONESTANDAR]
AS
BEGIN
   SET NOCOUNT ON
   SELECT acdesviacionestandar
   FROM   mfac
   SET NOCOUNT OFF
END

GO
