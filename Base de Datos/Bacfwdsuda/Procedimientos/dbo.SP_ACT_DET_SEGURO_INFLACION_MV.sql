USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACT_DET_SEGURO_INFLACION_MV]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_ACT_DET_SEGURO_INFLACION_MV]	(	@Nro_Operacion		NUMERIC(10,0)
						,	@Correlativo		INT
						,	@Nro_Credito		NUMERIC(10,0)
						,	@Nro_Dividendo		NUMERIC(10,0)
						,	@Plazo			INT
						,	@Fecha_Vcto		DATETIME
						,	@Fecha_Fijacion		DATETIME
						,	@Nominal		NUMERIC(21,4)
						,	@Precio_Contrato	NUMERIC(21,4)
						,	@Precio_Costo		NUMERIC(21,4)
						,	@Spread			NUMERIC(21,4)
						,	@Monto_CLP		FLOAT
						,	@Tasa_UF		FLOAT
						,	@Tasa_CLP		FLOAT
						,	@UF_Proyectada		FLOAT
						)		
AS
BEGIN

	SET NOCOUNT ON
	
	INSERT TBL_CARTERA_FLUJOS
	(	Ctf_Numero_OPeracion
	,	Ctf_Correlativo
	,	Ctf_Numero_Credito
	,	Ctf_Numero_Dividendo
	,	Ctf_Plazo
	,	Ctf_Fecha_Vencimiento
	,	Ctf_Fecha_Fijacion
	,	Ctf_Monto_Principal
	,	Ctf_Precio_Contrato
	,	Ctf_Precio_Costo
	,	Ctf_Monto_Secundario
	,	Ctf_Spread
	,	Ctf_Tasa_Moneda_Principal
	,	Ctf_Tasa_Moneda_Secundaria
	,	Ctf_Precio_Proyectado
	)
	SELECT	@Nro_Operacion
	,	@Correlativo
	,	@Nro_Credito
	,	@Nro_Dividendo
	,	@Plazo
	,	@Fecha_Vcto
	,	@Fecha_Fijacion
	,	@Nominal
	,	@Precio_Contrato
	,	@Precio_Costo
	,	@Monto_CLP
	,	@Spread
	,	@Tasa_UF
	,	@Tasa_CLP
	,	@UF_Proyectada

	IF @@ERROR <> 0 BEGIN
		PRINT 'ERROR AL INSERTAR REGISTRO'
		RETURN
	END

	DELETE	TBL_CARTERA_FLUJOS_STANDBY 
	WHERE	Cfs_Numero_Credito	= @Nro_Credito 
	AND	Cfs_Numero_Dividendo	= @Nro_Dividendo
		
	IF @@ERROR <> 0 BEGIN
		PRINT 'ERROR AL ELIMINAR REGISTRO DESDE TBL_CARTERA_FLUJOS_STANDBY '
		RETURN
	END
		
	SET NOCOUNT OFF
END
GO
