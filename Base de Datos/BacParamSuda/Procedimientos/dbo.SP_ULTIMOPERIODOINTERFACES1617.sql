USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ULTIMOPERIODOINTERFACES1617]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_ULTIMOPERIODOINTERFACES1617]
AS
BEGIN
	SET NOCOUNT ON
	SELECT ISNULL(UltPeriodoInterfaces,'NO HAY') FROM Bacparamsuda.dbo.tbl_Parametros_Gral_Garantias
	SET NOCOUNT OFF
END
GO
