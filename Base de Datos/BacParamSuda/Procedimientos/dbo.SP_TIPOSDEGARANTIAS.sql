USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TIPOSDEGARANTIAS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TIPOSDEGARANTIAS]
	(
	@Tipo CHAR(1)
	)
AS
BEGIN
	SET NOCOUNT ON
	SELECT tbcodigo1, tbglosa
	FROM Bacparamsuda.dbo.TABLA_GENERAL_DETALLE
	WHERE tbcateg = 8700
	AND nemo = @Tipo
END
GO
