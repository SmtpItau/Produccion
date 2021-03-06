USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LineaCreditoGeneral_Graba]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_LineaCreditoGeneral_Graba]
		(
		@rut_cliente		NUMERIC(09),
		@codigo_cliente		NUMERIC(09),
		@fechaasignacion	DATETIME,
		@fechavencimiento	DATETIME,
		@fechafincontrato	DATETIME,
		@bloqueado		CHAR(01),
		@totalasignado		NUMERIC(19,4),
		@totalocupado		NUMERIC(19,4),
		@totaldisponible	NUMERIC(19,4),
		@totalexceso		NUMERIC(19,4),
		@totaltraspaso		NUMERIC(19,4),
		@totalrecibido		NUMERIC(19,4),
		@rutcasamatriz		NUMERIC(09),
		@codigocasamatriz	NUMERIC(09)
		)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON
	SET DATEFORMAT dmy

--	SELECT @totalocupado = 0
	BEGIN
	IF EXISTS(SELECT 1 FROM LINEA_GENERAL WITH (NOLOCK)
				WHERE	rut_cliente	= @rut_cliente	AND
					codigo_cliente	= @codigo_cliente)
		BEGIN

		UPDATE LINEA_GENERAL SET 
			--Rut_Cliente		=	@Rut_Cliente,
			--Codigo_Cliente	=	@Codigo_Cliente,
			fechaasignacion		=	@fechaasignacion,
			fechavencimiento	=	@fechavencimiento,
			fechafincontrato	=	@fechafincontrato,
			bloqueado		=	@bloqueado,
			totalasignado		=	@totalasignado,
			totalocupado		=	@totalocupado,
			totaldisponible		=	@totaldisponible,
			totalexceso		=	@totalexceso,
			totaltraspaso		=	@totaltraspaso,
			totalrecibido		=	@totalrecibido,
			rutcasamatriz		=	@rutcasamatriz,
			codigocasamatriz	=	@codigocasamatriz

			WHERE rut_cliente	=	@rut_cliente and
			      codigo_cliente	=	@codigo_cliente

		END
	ELSE
		BEGIN
		INSERT INTO LINEA_GENERAL
		       (rut_cliente,
			codigo_cliente,
			fechaasignacion,
			fechavencimiento,
			fechafincontrato,
			bloqueado,
			totalasignado,
			totalocupado,
			totaldisponible,
			totalexceso,
			totaltraspaso,
			totalrecibido,
			rutcasamatriz,
			codigocasamatriz)

		VALUES
		       (@rut_cliente,
			@codigo_cliente,
			@fechaasignacion,
			@fechavencimiento,
			@fechafincontrato,
			@bloqueado,
			@totalasignado,
			@totalocupado,
			@totaldisponible,
			@totalexceso,
			@totaltraspaso,
			@totalrecibido,
			@rutcasamatriz,
			@codigocasamatriz)

		END
	END
END









GO
