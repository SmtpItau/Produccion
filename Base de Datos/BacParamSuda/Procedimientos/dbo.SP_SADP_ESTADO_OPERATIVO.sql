USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_ESTADO_OPERATIVO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_ESTADO_OPERATIVO]
	(	@Id_Sistema		VARCHAR(5)
	,	@iContrato		NUMERIC(9)
	)
AS
BEGIN
	
	SET NOCOUNT ON

	UPDATE	MDLBTR
	SET		estado_envio		= 'OP'
	WHERE	sistema				= @Id_Sistema 
	AND		numero_operacion	= @iContrato 

	UPDATE	SADP_DETALLE_PAGOS
	SET	    cestado				= 'OP'
	WHERE	cModulo				= @Id_Sistema 
	AND		nContrato			= @iContrato

END
GO
