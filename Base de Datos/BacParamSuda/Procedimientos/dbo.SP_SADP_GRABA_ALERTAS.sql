USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_GRABA_ALERTAS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_GRABA_ALERTAS]
	(	@id_Alertas		SMALLINT
	,	@sNombre_Alerta	VARCHAR(30)
	,	@sEstado		VARCHAR(01)
	,	@dFechaDesde	DATETIME
	,	@dFechaHasta	DATETIME
	,	@sHora			VARCHAR(08)
	)
					 
AS
BEGIN

	IF @id_Alertas = 0   
		INSERT INTO SADP_Alertas
		(
			-- id_Alertas -- this column value is auto-generated,
			sNombre_Alerta,
			sEstado,
			cHora,
			dFecha_Desde,
			dFecha_Hasta
		)
		VALUES
		(
			@sNombre_Alerta	
		,	@sEstado
		,	@sHora			
		,	@dFechaDesde	
		,	@dFechaHasta	
		)
	ELSE
		UPDATE SADP_Alertas
		SET
			sNombre_Alerta = @sNombre_Alerta
		,	sEstado = @sEstado
		,	cHora = @sHora
		,	dFecha_Desde = @dFechaDesde
		,	dFecha_Hasta = @dFechaHasta		
		WHERE id_Alertas = @id_Alertas
END 
GO
