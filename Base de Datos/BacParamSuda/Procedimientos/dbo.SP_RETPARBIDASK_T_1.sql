USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETPARBIDASK_T_1]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RETPARBIDASK_T_1]
(
	@moneda	INTEGER,
	@tipoOp CHAR(1),
	@plazo	INTEGER,
	@Paridad NUMERIC(19,4) OUTPUT
)
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @fmenos1 DATETIME,
		@tSpot FLOAT,
		@ptosFwd FLOAT

	SELECT @fmenos1 = acfecante
	FROM Bacfwdsuda.dbo.mfac

	EXECUTE Bacfwdsuda.dbo.SP_BIDASK2 @moneda, @fmenos1, @tipoOp, @plazo, @tSpot OUTPUT, @ptosFwd OUTPUT
	SELECT @Paridad = (@tSpot + @ptosFwd)
END
GO
