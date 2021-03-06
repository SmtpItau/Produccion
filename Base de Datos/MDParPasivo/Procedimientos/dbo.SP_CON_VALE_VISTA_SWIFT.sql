USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_VALE_VISTA_SWIFT]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_VALE_VISTA_SWIFT](@iNumero_Operacion NUMERIC(10),
                                        @iSistema          CHAR(3))
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET NOCOUNT ON	
        SET DATEFORMAT dmy

        IF EXISTS(SELECT DOCUMENTO_ESTADO  
                  FROM VALE_VISTA_EMITIDO  WITH (NOLOCK)
                  WHERE numero_operacion = @iNumero_Operacion
                  AND   id_sistema       = @iSistema
                  AND   DOCUMENTO_ESTADO = 'E') OR
           EXISTS(SELECT SWIFT_NUMERO 
                 FROM VIEW_MOVIMIENTO_CAMBIO
                 WHERE Monumope = @iNumero_Operacion 
                 AND @iSistema = 'BCC'
                 AND SWIFT_NUMERO <> 0)    

        BEGIN

                SELECT Respuesta="NO"

        END ELSE BEGIN

                SELECT Respuesta="OK"       

        END


END






GO
