USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARDESVIACIONESTANDAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABARDESVIACIONESTANDAR] ( @ndesviacionestandar NUMERIC ( 10, 04 ) )
AS
BEGIN
   SET NOCOUNT ON
   UPDATE mfac
   SET    acdesviacionestandar = @ndesviacionestandar
   SET NOCOUNT OFF
END

GO
