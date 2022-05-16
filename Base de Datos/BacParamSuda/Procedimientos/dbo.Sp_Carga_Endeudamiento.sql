USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Carga_Endeudamiento]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Carga_Endeudamiento]
AS

/*LD1-COR-035 CARGA ENDEUDAMIENTO */



/***********************************************************************


**********************************************************************/
BEGIN

	SET NOCOUNT ON

	SELECT	Activo_Circulante	,
		Pend_Inst_Finan		,
		Pmax_End_Inst_Finan	,
		PFwp_Perd_Dif
	FROM	ENDEUDAMIENTO with(nolock)

	SET NOCOUNT OFF

END

GO
