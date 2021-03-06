USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_CARTERA_FLUJOS_STANDBY]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_DEL_CARTERA_FLUJOS_STANDBY]	(	@RutCli		NUMERIC(10,0)
						,	@Nro_Credito	NUMERIC(10,0)	= -99
						,	@Nro_Dividendo	NUMERIC(10,0)	= -99
						)
AS
BEGIN

	SET NOCOUNT ON


	DELETE	TBL_CABECERA_FLUJOS_STANDBY
	WHERE	(Cf_Rut_Cli		= @RutCli 		OR @RutCli		= -99)
	AND	(Cf_Credito		= @Nro_Credito		OR @Nro_Credito		= -99)
	
	DELETE	TBL_CARTERA_FLUJOS_STANDBY
	WHERE	(Cfs_Numero_Credito	= @Nro_Credito		OR @Nro_Credito		= -99)
	AND	(Cfs_Numero_Dividendo	= @Nro_Dividendo	OR @Nro_Dividendo	= -99)

	SET NOCOUNT OFF	

END
GO
