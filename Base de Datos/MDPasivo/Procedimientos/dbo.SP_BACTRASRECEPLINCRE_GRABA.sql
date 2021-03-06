USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACTRASRECEPLINCRE_GRABA]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BACTRASRECEPLINCRE_GRABA]	(
                                                            @numeroperacion             NUMERIC(10),
                                                            @numerodocumento            NUMERIC(10),
                                                            @numerocorrelativo          NUMERIC(10),
                                                            @rut_cliente		NUMERIC(9),
                                                            @codigo_cliente		NUMERIC(9),
                                                            @id_sistema			CHAR(3),
                                                            @codigo_producto		CHAR(5),
                                                            @tipo_operacion		VARCHAR(2),
                                                            @tipo_riesgo		VARCHAR(1),
                                                            @fechainicio		DATETIME,
                                                            @fechavencimiento		DATETIME,
                                                            @montooriginal		NUMERIC(19),
                                                            @tipocambio			NUMERIC(8),
                                                            @matrizriesgo		NUMERIC(8),
                                                            @montotransaccion		NUMERIC(19),
                                                            @operador			CHAR(10),
                                                            @activo			CHAR(1),
							    @usuarioautorizo		CHAR(15),
	              					    @sistemarecibio             CHAR(3)
                                                         )

AS
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	BEGIN TRANSACTION

		INSERT INTO LINEA_TRASPASO 	
                                                        (
			                                     NumeroTraspaso
                                                            ,NumeroOperacion
                                                            ,NumeroDocumento
                                                            ,NumeroCorrelativo
			                                    ,Rut_Cliente
			                                    ,Codigo_Cliente
--			                                    ,Id_Sistema
--			                                    ,Codigo_Producto
--			                                    ,SistemaRecibio
			                                    ,TipoOperacion
			                                    ,FechaInicio
			                                    ,FechaVencimiento
			                                    ,Operador
			                                    ,MontoTraspasado
			                                    ,UsuarioAutorizo
			                                    ,Activo
                                                            ,hora_traspaso
                                                            ,tipo_riesgo
                                                        )

                                          VALUES	(				
	                                                    @numeroperacion		,
           		                                    @numeroperacion		,
           		                                    @numerodocumento		,
           		                                    @numerocorrelativo          ,
                        	                            @rut_cliente		,
                 	                                    @codigo_cliente		,
--                            		                    @id_sistema			,
--                                 	                    @codigo_producto		,
--                                                	    @sistemarecibio		,
                                                	    @tipo_operacion		,
                                                	    @fechainicio		,
                                                	    @fechavencimiento		,
                	    @operador			,
                               	                            @montotransaccion		,
                                                	    @usuarioautorizo		,
 	    			                            @Activo                     ,
                                                            CONVERT(CHAR(08),GETDATE(),108),
                                                            'C'
							)

         	IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT "ERROR"
			RETURN
		END

/***********************************************************************************************************************/
	UPDATE	LINEA_SISTEMA
	SET	totaltraspaso	= totaltraspaso + @montotransaccion	,
		totalocupado	= totalocupado + @montotransaccion
	WHERE	rut_cliente	= @rut_cliente
	AND 	codigo_cliente	= @codigo_cliente
--	AND 	id_sistema	= @id_sistema


	UPDATE	LINEA_SISTEMA
	SET	ConRiesgoocupado= ConRiesgoocupado + @montotransaccion
	WHERE	rut_cliente	= @rut_cliente
	AND 	codigo_cliente	= @codigo_cliente
--	AND 	id_sistema	= @id_sistema


	UPDATE	LINEA_SISTEMA
	SET	totalrecibido	= totalrecibido + @montotransaccion ,
         	totalocupado	= totalocupado  - @montotransaccion
	WHERE	rut_cliente	= @rut_cliente
	AND 	codigo_cliente	= @codigo_cliente
--	AND 	id_sistema	= @sistemarecibio


	EXECUTE Sp_Lineas_Actualiza

/***********************************************************************************************************************/                
               

		SELECT 'Retorno' = @numeroperacion
		
		COMMIT TRANSACTION


	SET NOCOUNT OFF

END




GO
