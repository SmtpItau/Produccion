USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESPALDO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RESPALDO]
    ( @fecpro  DATETIME )
AS
BEGIN
	BEGIN TRANSACTION
	
    SET NOCOUNT ON


  /*  ====================================================================================
  +++ 04-12-2018 VBF Cambio para la ejecución de proceso de actualizacion de Costos 
      ==================================================================================== */
	DECLARE @dfecNext	char(8)
		SET @dfecNext = convert(char(8), (SELECT ACFECPRX FROM BacCamSuda.DBO.MEAC ), 112)
  /*  ====================================================================================
  --- 04-12-2018 VBF Cambio para la ejecución de proceso de actualizacion de Costos 
      ==================================================================================== */

	-->		Se copia el valor del DO a la fecha de proceso, a la tabla de control del Spot.	

	declare @nValorDO	numeric(19,4)
		set	@nValorDO	=	isnull((	select	vmvalor
								from	BacParamSuda.dbo.valor_moneda with(nolock) 
								where	vmfecha = ( select acfecprx from BacCamSuda.dbo.meac with(nolock) )
								--where	vmfecha = ( select ACFECPRO from BacCamSuda.dbo.meac with(nolock) )
							and		vmcodigo= 994
							),0)



	UPDATE	MEAC
	SET		accoscomp	= @nValorDO
		,	accosvent	= @nValorDO



	if @@error <> 0
	begin
		rollback transaction
		select -1, 'Error al copiar el valor del DO, a la fecha de próximo proceso a la tabla de control.'
		return
	end
	-->		Se copia el valor del DO a la fecha de proceso, a la tabla de control del Spot.	

     ----<< limpia movimiento historico de datos del dia
     DELETE FROM MEMOH  WHERE  mofech = @fecpro
     IF @@ERROR <> 0  BEGIN
        ROLLBACK TRANSACTION
        SELECT -1, 'NO SE PUEDE LIMPIAR MOVIMIENTO HISTORICO'
        RETURN
     END       

     ----<< LIMPIA PARAMETROS DE CONTROL HISTORICOS DE DATOS DEL DIA

     DELETE FROM MEACH  WHERE acfecpro = @fecpro
     IF @@ERROR <> 0  BEGIN
        ROLLBACK TRANSACTION
        SELECT -1, 'NO SE PUEDE LIMPIAR PARAMETROS DE CONTROL HISTORICO'
		SET NOCOUNT OFF
        RETURN
     END       

     
     ----<< ACTUALIZANDO PARAMETROS DE CONTROL HISTORICOS CON DATOS DEL DIA

     INSERT INTO MEMOH   SELECT * FROM MEMO
     IF @@ERROR <> 0  BEGIN
        ROLLBACK TRANSACTION
        SELECT -1, 'NO SE PUEDE ACTUALIZAR MOVIMIENTO HISTORICO CON EL DIARIO'
	    SET NOCOUNT OFF
        RETURN
     END       
     

     ----<< actualizando parametros de control historicos con datos del dia
     INSERT INTO MEACH   SELECT * FROM MEAC
     IF @@ERROR <> 0  BEGIN
        ROLLBACK TRANSACTION
        SELECT -1, 'NO SE PUEDE ACTUALIZAR MOVIMIENTO HISTORICO CON EL DIARIO'
		SET NOCOUNT OFF
        RETURN
     END       

     DELETE view_limite_transaccion_error WHERE Id_Sistema = 'BCC'

     DELETE view_limite_transaccion   WHERE Id_Sistema = 'BCC'

     DELETE view_aprobacion_operaciones   WHERE Id_Sistema = 'BCC'

     IF @@ERROR <> 0  BEGIN
        ROLLBACK TRANSACTION
        SELECT -1, 'NO SE PUEDE ELIMINAR MENSAJES DE ERROR DIARIO'
	    SET NOCOUNT OFF
        RETURN
     END       


     -- Respaldo de transaciones movimientos Corredora

     DELETE FROM TxOnlineCorredoraHistorico where FechaProceso = ( select ACFECPRO from MEAC )

     INSERT INTO TxOnlineCorredoraHistorico SELECT * FROM TxOnlineCorredora
     IF @@ERROR <> 0  BEGIN
        ROLLBACK TRANSACTION
        SELECT -1, 'NO SE PUEDE ACTUALIZAR MOVIMIENTO HISTORICO CON EL DIARIO'
	    SET NOCOUNT OFF
        RETURN
     END

  /*  ====================================================================================
  +++ 04-12-2018 VBF Cambio para la ejecución de proceso de actualizacion de Costos 
      ==================================================================================== */
		declare @fecpro_costos	char(8) = convert(char(8), @fecpro, 112)
		
		EXECUTE BACCAMSUDA.dbo.SP_AGREGACOSTOS @dfecNext, @fecpro_costos
		
		IF @@ERROR <> 0  BEGIN
			ROLLBACK TRANSACTION
	        SELECT -1, 'NO SE PUEDE ACTUALIZAR MOVIMIENTO HISTORICO CON EL DIARIO'
		END 
  /*  ====================================================================================
  --- 04-12-2018 VBF Cambio para la ejecución de proceso de actualizacion de Costos 
      ==================================================================================== */

COMMIT TRANSACTION

     

END
GO
