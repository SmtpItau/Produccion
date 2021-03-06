USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_AnulaInterBancario]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_AnulaInterBancario]
		(@Numoper	NUMERIC	(10,0),
                 @Mensaje 	char(255) output )with recompile
AS
BEGIN

      SET TRANSACTION ISOLATION LEVEL READ COMMITTED
      SET DATEFORMAT dmy
      SET NOCOUNT ON

      DECLARE @Fecha_Proceso   DATETIME,
              @dFecha_proceso  DATETIME,
              @nNumero_Swift   NUMERIC (10)

      SELECT @Fecha_Proceso   = Fecha_proceso
      FROM VIEW_DATOS_GENERALES

      SELECT @nnumero_swift = Swift_numero ,
             @dfecha_proceso = mofecpro
      FROM MOVIMIENTO_TRADER WITH (NOLOCK) WHERE monumoper = @Numoper

--	BEGIN TRANSACTION

                UPDATE  VIEW_VALE_VISTA_EMITIDO WITH (ROWLOCK)
                   SET  documento_estado  = 'A'
                 WHERE  numero_operacion  = @Numoper
                   AND  fecha_generacion  = @Fecha_Proceso


		UPDATE	MOVIMIENTO_TRADER WITH (ROWLOCK)
		SET	mostatreg	= 'A'
                  ,     moimpreso       = ''
		WHERE	monumoper=@Numoper AND motipoper='IB'
	        AND     mofecpro = @fecha_proceso

		IF @@ERROR<>0
		BEGIN
                    SELECT @Mensaje = 'Error al actualizar'
                    RETURN
		END

		DELETE CARTERA_INTERBANCARIA WITH (ROWLOCK) WHERE numero_operacion=@Numoper
		IF @@ERROR<>0
		BEGIN
                        SELECT @Mensaje = 'Error al Eliminar' 
                  	RETURN
		END

               CREATE TABLE #PASO_SWIFT(Error   CHAR(3),
                                Mensaje VARCHAR(60))
    
               INSERT INTO #PASO_SWIFT EXEC SP_ANULA_SWIFT @nnumero_swift,@Numoper,@dfecha_proceso,'BTR'


END

GO
