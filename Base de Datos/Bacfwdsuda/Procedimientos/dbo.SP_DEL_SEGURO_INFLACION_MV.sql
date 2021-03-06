USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_SEGURO_INFLACION_MV]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_DEL_SEGURO_INFLACION_MV]	(	@Nro_Operacion		INT
						,	@Nro_Correlativo	INT	= 0
						,	@Tipo_Elimina		CHAR(2)	= 'M'
						)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE	@dFechaProc	DATETIME

	SELECT	@dFechaProc	= acfecproc
	FROM	MFAC


	IF @Tipo_Elimina <> 'V' BEGIN
		INSERT	TBL_CARTERA_FLUJOS_RES
		(	Cfr_Numero_OPeracion 
		,	Cfr_Correlativo 
		,	Cfr_Numero_Credito 
		,	Cfr_Numero_Dividendo 
		,	Cfr_Plazo   
		,	Cfr_Fecha_Vencimiento       
		,	Cfr_Fecha_Fijacion          
		,	Cfr_Monto_Principal     
		,	Cfr_Precio_Contrato     
		,	Cfr_Precio_Costo        
		,	Cfr_Monto_Secundario    
		,	Cfr_Spread              
		,	Cfr_Tasa_Moneda_Principal                             
		,	Cfr_Tasa_Moneda_Secundaria                            
		,	Cfr_Precio_Proyectado                                 
		,	Cfr_Fecha_Evento            
		,	Cfr_Fecha_Proceso
		,	Cfr_Estado 
		)
		SELECT	Ctf_Numero_OPeracion
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
		,	GETDATE()
		,	@dFechaProc
		,	@Tipo_Elimina
		FROM	TBL_CARTERA_FLUJOS
		WHERE	(Ctf_Numero_OPeracion	= @Nro_Operacion	OR @Nro_Operacion = 0)
		AND	(Ctf_Correlativo	= @Nro_Correlativo	OR @Nro_Correlativo = 0)
	END
	ELSE BEGIN
		INSERT	TBL_CARTERA_FLUJOS_RES
		(	Cfr_Numero_OPeracion 
		,	Cfr_Correlativo 
		,	Cfr_Numero_Credito 
		,	Cfr_Numero_Dividendo 
		,	Cfr_Plazo   
		,	Cfr_Fecha_Vencimiento       
		,	Cfr_Fecha_Fijacion          
		,	Cfr_Monto_Principal     
		,	Cfr_Precio_Contrato     
		,	Cfr_Precio_Costo        
		,	Cfr_Monto_Secundario    
		,	Cfr_Spread              
		,	Cfr_Tasa_Moneda_Principal                             
		,	Cfr_Tasa_Moneda_Secundaria                            
		,	Cfr_Precio_Proyectado                                 
		,	Cfr_Fecha_Evento            
		,	Cfr_Fecha_Proceso
		,	Cfr_Estado 
		)
		SELECT	Ctf_Numero_OPeracion
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
		,	GETDATE()
		,	@dFechaProc
		,	@Tipo_Elimina
		FROM	TBL_CARTERA_FLUJOS
		WHERE	(Ctf_Numero_OPeracion	= @Nro_Operacion	OR @Nro_Operacion = 0)
		AND	(Ctf_Correlativo	= @Nro_Correlativo	OR @Nro_Correlativo = 0)
		AND	Ctf_Fecha_Vencimiento	= @dFechaProc	
	END


	IF @Tipo_Elimina <> 'V' BEGIN
		DELETE	TBL_CARTERA_FLUJOS
		WHERE	(Ctf_Numero_OPeracion	= @Nro_Operacion	OR @Nro_Operacion = 0)
		AND	(Ctf_Correlativo	= @Nro_Correlativo	OR @Nro_Correlativo = 0)
	END
/*	--LOS REGISTROS VENCIDOS SON ELIMINADOS EN EL DEVENGAMIENTO DEL INICIO DE DIA
	ELSE BEGIN
		DELETE	TBL_CARTERA_FLUJOS
		WHERE	(Ctf_Numero_OPeracion	= @Nro_Operacion	OR @Nro_Operacion = 0)
		AND	(Ctf_Correlativo	= @Nro_Correlativo	OR @Nro_Correlativo = 0)
		AND	Ctf_Fecha_Vencimiento	= @dFechaProc	
	END
*/


	SET NOCOUNT OFF

END

GO
