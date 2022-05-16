USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CORRELATIVO_IBS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_CORRELATIVO_IBS] (
	@NroOperacion as int, 
	@NemoSistema as char(3)
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT	correlativoIngresoIBS
	FROM	TBL_ART84_INPWSIBS_OPE_TICK
	WHERE  NRO_OPERACION = @NroOperacion
	AND    ltrim(rtrim(SISTEMA)) = ltrim(rtrim(@NemoSistema))

END

GO
