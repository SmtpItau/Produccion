USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_DATOS_OPERACION_IDD]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_DATOS_OPERACION_IDD]	(
														@nError				NUMERIC(3,0)
														,@cmodulo			VARCHAR(3)
														,@cproducto			VARCHAR(10)
														,@nOperacion		NUMERIC(9)
														,@nDocumento		NUMERIC(9)
														,@iCorrelativo		NUMERIC(9)
														,@sMensajeErrIdd	VARCHAR(100)	= '' -- Descripcion Error IDD
														,@nNumeroIdd		NUMERIC(9)	= 0
														,@sControlLinea		INT			= 1	--Check=1 UnCheck=0
													)
AS    
BEGIN
	
/*
NOMBRE              : dbo.SP_ACTUALIZA_DATOS_IDD.sql
AUTOR               : Cristian Vega Sanhueza.
DESCRIPCION			: [NUEVO]-Actualiza el estado, el mensaje y el numero IDD, en la tabla Transacciones_IDD.
FECHA CREACIÓN		: 2017.08.08

HISTÓRICO DE CAMBIOS
FECHA		AUTOR		TAG
----------------------------------------------------------------------------------------------------------------------------------------
2017.08.08	CVS			cvegasan 2017.08.08


IMPORTANTE
---------- 
	@nError = 200 Exitosa con reserva de linea		'O' = OK		, mensaje en blanco, Actualizacion de numero IDD
	@nError = 201 Exitosa con error en validación	'R' = Rechazado	, mensaje retornado por Servicio IDD
	
	SELECT iEstadoIdd,sMensajeIdd,nNumeroIdd FROM Transacciones_IDD WHERE cModulo='BTR' AND cPoducto='CP' AND nOperacion=199266 AND nDocumento=199266 AND ICORRELATIVO=1
		BEGINT TRAN
			exec SP_ACTUALIZA_DATOS_IDD 200,'BTR','CP',199266,199266,1,'',11111
		ROLLBACK TRAN
	
		BEGINT TRAN
			exec SP_ACTUALIZA_DATOS_IDD 201,'BTR','CP',199266,199266,1,'error IDD'
		ROLLBACK TRAN
	SELECT iEstadoIdd,sMensajeIdd,nNumeroIdd FROM Transacciones_IDD WHERE cModulo='BTR' AND cPoducto='CP' AND nOperacion=199266 AND nDocumento=199266 AND ICORRELATIVO=1
*/
DECLARE
	@iTotalOperacionesBTR NUMERIC(9)
	,@cUsuarioAutomatica VARCHAR(10)
	
		SELECT @cUsuarioAutomatica='AUTOMATICA' -- VARIABLE definida internamente, para aprobar automaticamente una línea

		--jcamposd controla error de envio de correlativo para bfw (correlativo sucio)
		IF @cmodulo IN('BFW','PCS','BCC','OPT')
			SET @iCorrelativo = 0
		
		IF @cmodulo = 'BEX'
		BEGIN
			SELECT @cproducto = CASE WHEN @cproducto = 'CP' THEN 'CPX' 
										WHEN @cproducto = 'VP' THEN 'VPX' 
								ELSE @cproducto 
								END
		END

		
		IF EXISTS (SELECT 1 FROM Transacciones_IDD WHERE cModulo		= @cmodulo
													AND cProducto		= @cproducto
													AND nOperacion		= @nOperacion
													AND (nDocumento		= @nDocumento OR @nDocumento = @nOperacion)
													AND iCorrelativo	= @iCorrelativo )
		BEGIN
		
			UPDATE ti
				SET iEstadoIDD = CASE
									WHEN @nError = 200 THEN 'O' 
									WHEN @nError = 201 THEN 'R'
									ELSE iEstadoIDD
								 END
				,sMensajeIdd = SUBSTRING(@sMensajeErrIdd,1,50)
				,nNumeroIdd = @nNumeroIdd
				,sControlLinea = CASE
									WHEN @sControlLinea = 1 THEN 'S'
									ELSE 'N' END
			FROM Transacciones_IDD ti
			WHERE
				cModulo				= @cmodulo
				AND cProducto		= @cproducto
				AND nOperacion		= @nOperacion
				AND (nDocumento		= @nDocumento OR @nDocumento = @nOperacion)
				AND iCorrelativo	= @iCorrelativo
				--AND iEstadoIDD		= 'P' --jcamposd 20180314 no debe considerar el estado puede estar OK/PENDIENTE/RECHAZADA
			
			IF @@ERROR <> 0
			BEGIN
				SELECT -1,'Error al actualizar Transacciones_IDD'
				RETURN
			END			
			
			--> En caso de que no haya conexion actualizacion de mensaje en tabla linea_transaccion_detalle
			UPDATE LINEA_TRANSACCION_DETALLE
			SET  Mensaje_Error = SUBSTRING(@sMensajeErrIdd,1,50)
			WHERE Error = 'S'
				AND NumeroOperacion = @nOperacion
				AND Id_Sistema = @cmodulo
				
			IF @@ERROR <> 0
			BEGIN
				SELECT -1,'Error al actualizar LINEA_TRANSACCION_DETALLE'
				RETURN
			END
			--< En caso de que no haya conexion actualizacion de mensaje en tabla linea_transaccion_detalle
			
			--> Validacion ejecución Autorizacion_Automatica 
			--> En "BTR" todos los productos deben tener numero iDD para ejecutar autorizacion automática
			
			SELECT @iTotalOperacionesBTR= ISNULL(COUNT(1),0) --> Cuento las operaciones BTR con numeroIDD = 0, para una determinada operación
			FROM Transacciones_IDD ti
			WHERE
				cModulo			= @cmodulo
				AND nOperacion	= @nOperacion
				AND nNumeroIdd	= 0
			
			IF 	(@iTotalOperacionesBTR = 0) --> Si NO EXISTEN operaciones con numero IDD =0, Aprobación autómatica de lo contrario, quedan pendientes
				BEGIN
					EXEC SP_CONTROL_APROBACION @cUsuarioAutomatica,@cmodulo,@nOperacion
					
					IF @@ERROR <> 0
					BEGIN
						SELECT -1,'Error al ejecutar SP_CONTROL_APROBACION'
						RETURN
					END
				END
			--ELSE
			--	SELECT 'Existen instrumentos pendientes de aprobación, para la operación ' + @nOperacion
			--< En "BTR" todos los productos deben tener numero iDD para ejecutar autorizacion automática
			--< Validacion ejecución Autorizacion_Automatica 
		END
		
		SELECT 0,'Proceso OK'
END
GO
