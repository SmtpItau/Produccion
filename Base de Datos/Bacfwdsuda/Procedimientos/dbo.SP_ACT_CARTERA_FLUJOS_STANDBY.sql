USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_CARTERA_FLUJOS_STANDBY]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ACT_CARTERA_FLUJOS_STANDBY]	(	@Nro_Credito	NUMERIC(10,0)
						,	@Nro_Dividendo	NUMERIC(10,0)
						,	@Fecha_Vcto	DATETIME
						,	@Monto_UF	NUMERIC(21,4)
						,	@UF_Contrato	NUMERIC(21,4)
						,	@Rut_Cliente	NUMERIC(09,0)
						,	@Dv		CHAR(1)
						,	@Nombre		VARCHAR(60)
						,	@Nombre2	VARCHAR(12)
						,	@ApePtn		VARCHAR(18)
						,	@ApeMtn		VARCHAR(18)
						,	@Condicion	CHAR(1)
						)



AS
BEGIN

	SET NOCOUNT ON

	IF NOT EXISTS(SELECT 1 FROM TBL_CABECERA_FLUJOS_STANDBY WHERE Cf_Rut_Cli = @Rut_Cliente AND Cf_Credito = @Nro_Credito) BEGIN
		INSERT TBL_CABECERA_FLUJOS_STANDBY
		(	Cf_Rut_Cli
		,	Cf_Dv
		,	Cf_Nombre
		,	Cf_Nombre2
		,	Cf_ApePtn
		,	Cf_ApeMtn
		,	Cf_Credito
		,	Cf_Condicion
		,	Cf_Usuario_Lock
		)
		VALUES
		(	@Rut_Cliente
		,	@Dv
		,	@Nombre
		,	@Nombre2
		,	@ApePtn
		,	@ApeMtn
		,	@Nro_Credito
		,	@Condicion
		,	''
		)
	END

	DELETE	TBL_CARTERA_FLUJOS_STANDBY 
	WHERE	Cfs_Numero_Credito	= @Nro_Credito 
	AND	Cfs_Numero_Dividendo	= @Nro_Dividendo		

	INSERT TBL_CARTERA_FLUJOS_STANDBY
	(	Cfs_Numero_Credito
	,	Cfs_Numero_Dividendo
	,	Cfs_Fecha_Vencimiento
	,	Cfs_Monto_UF
	,	Cfs_Precio_Contrato
	)
	VALUES
	(	@Nro_Credito
	,	@Nro_Dividendo
	,	@Fecha_Vcto
	,	@Monto_UF
	,	@UF_Contrato
	)
		
	SET NOCOUNT OFF

END
GO
