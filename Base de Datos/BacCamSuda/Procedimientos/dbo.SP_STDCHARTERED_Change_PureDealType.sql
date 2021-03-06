USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_STDCHARTERED_Change_PureDealType]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_STDCHARTERED_Change_PureDealType]
	(	@Fecha				VARCHAR(8) 
	,	@SourceRefrence		VARCHAR(20)
	,	@PureDealType		SMALLINT
	)
AS
BEGIN

	SET NOCOUNT ON

	-->		Cambia el Origen para los Forward Cero Dias
	UPDATE	BacParamSuda.dbo.TBL_STDCHTD_STATUS
	SET		PureDealType	= @PureDealType
	WHERE	Fecha			= @Fecha
	AND		SourceReference	= @SourceRefrence
	AND		PureDealType	= 4
	-->		Cambia el Origen para los Forward Cero Dias

END
GO
