USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CANTGARANTIASVENCIDAS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CANTGARANTIASVENCIDAS]
	(	
		@tipo 		CHAR(1),
		@fechaProc 	DATETIME
	)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @cantidad INTEGER
	SELECT @cantidad = 0

	IF @tipo = 'O'
		SELECT @cantidad = COUNT(Folio) FROM BacParamsuda..tbl_Garantias_Otorgadas
				   WHERE FechaVigencia <= @fechaProc
	ELSE
		SELECT @cantidad = COUNT(NumeroOperacion) FROM BacParamSuda..tbl_mov_garantia
				   WHERE Estado = 'V' AND FechaVigencia <= @fechaProc

	SELECT @cantidad
	SET NOCOUNT OFF
END
GO
