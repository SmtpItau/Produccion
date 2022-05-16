USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CargaEarlyTermination]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CargaEarlyTermination]
(
	@numoper    NUMERIC(10)	
)
AS
BEGIN
	SET NOCOUNT ON
	
	SELECT bEarlyTermination
	,      Periodicidad
	,      FechaInicio 
	FROM   mfca 
	WHERE  canumoper = @numoper
END

GO
