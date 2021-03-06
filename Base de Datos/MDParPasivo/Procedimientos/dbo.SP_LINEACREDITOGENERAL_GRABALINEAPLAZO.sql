USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEACREDITOGENERAL_GRABALINEAPLAZO]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEACREDITOGENERAL_GRABALINEAPLAZO]
		(
		@rut_cliente 		NUMERIC(9),
		@codigo_cliente  	NUMERIC(9),
		@Grupo     	 	CHAR(10),
		@plazodesde	 	NUMERIC(5),
		@plazohasta	 	NUMERIC(5),
		@porcentaje	 	NUMERIC(8,4),
		@totalasignado	 	NUMERIC(19,4),
		@totalocupado	 	NUMERIC(19,4),
		@totaldisponible	NUMERIC(19,4),
		@totalexceso		NUMERIC(19,4),
		@totaltraspaso		NUMERIC(19,4),
		@totalrecibido		NUMERIC(19,4),
		@SinRiesgoasignado      NUMERIC(19,4),
		@SinRiesgoOcupado       NUMERIC(19,4),
		@SinRiesgoDisponible    NUMERIC(19,4),
		@SinRiesgoexceso        NUMERIC(19,4),
		@ConRiesgoasignado      NUMERIC(19,4),
		@ConRiesgoOcupado       NUMERIC(19,4),
		@ConRiesgoDisponible    NUMERIC(19,4),
		@ConRiesgoexceso        NUMERIC(19,4)
		)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy
	
	IF EXISTS(SELECT RUT_CLIENTE FROM LINEA_SISTEMA WITH (NOLOCK)
		  WHERE ControlaPlazo = 'S' AND codigo_grupo = @Grupo
		  AND  rut_cliente = @rut_cliente 
		  AND  codigo_cliente = @codigo_cliente) BEGIN  	
					

	INSERT INTO LINEA_POR_PLAZO
		(
		rut_cliente,
		codigo_cliente,
		codigo_grupo,
		plazodesde,
		plazohasta,
		porcentaje,
		totalasignado,
        	totalocupado,
		totaldisponible,
		totalexceso,
		totaltraspaso,
		totalrecibido,
                SinRiesgoasignado,
		SinRiesgoOcupado,
		SinRiesgoDisponible,
		SinRiesgoexceso,
		ConRiesgoasignado,
		ConRiesgoOcupado,
		ConRiesgoDisponible,
		ConRiesgoexceso
		)
	   VALUES
	       (
		@rut_cliente,
		@codigo_cliente,
		@Grupo,
		@plazodesde,
		@plazohasta,
		@porcentaje,
		@totalasignado,
		@totalocupado,
		@totaldisponible,
		@totalexceso,
		@totaltraspaso,
		@totalrecibido,
                @SinRiesgoasignado,
	        @SinRiesgoOcupado,
		@SinRiesgoDisponible,
		@SinRiesgoexceso,
		@ConRiesgoasignado,
		@ConRiesgoOcupado,
		@ConRiesgoDisponible,
		@ConRiesgoexceso
		)
	END 

END





GO
