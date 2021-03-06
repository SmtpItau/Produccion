USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borrar_Formapago]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Borrar_Formapago] ( @codigo INTEGER )
AS
BEGIN

      SET DATEFORMAT dmy


      IF NOT EXISTS(SELECT forma_pago FROM PRODUCTO_CUENTA WHERE forma_pago =@codigo)
      AND NOT EXISTS(SELECT forma_pago FROM VALE_VISTA_EMITIDO WHERE forma_pago =@codigo)	
--       AND NOT EXISTS(SELECT moforpagi FROM VIEW_MOVIMIENTO_TRADER WHERE moforpagi =@codigo)		
--       AND NOT EXISTS(SELECT moforpagv FROM VIEW_MOVIMIENTO_TRADER WHERE moforpagv =@codigo)		
--       AND NOT EXISTS(SELECT forma_pago FROM VIEW_MOVIMIENTO_INVERSION_EXTERIOR WHERE forma_pago =@codigo)		
--       AND NOT EXISTS(SELECT mofpagomn FROM VIEW_MOVIMIENTO_FORWARD WHERE mofpagomn =@codigo)		
--       AND NOT EXISTS(SELECT mofpagomx FROM VIEW_MOVIMIENTO_FORWARD WHERE mofpagomx =@codigo)		
--       AND NOT EXISTS(SELECT recibimos_documento FROM VIEW_MOVIMIENTO_SWAP WHERE recibimos_documento =@codigo)		
--       AND NOT EXISTS(SELECT pagamos_documento FROM VIEW_MOVIMIENTO_SWAP WHERE pagamos_documento =@codigo)		
--       AND NOT EXISTS(SELECT Moentre FROM VIEW_MOVIMIENTO_CAMBIO WHERE Moentre= @codigo)		
--       AND NOT EXISTS(SELECT Morecib FROM VIEW_MOVIMIENTO_CAMBIO WHERE Morecib = @codigo)		
      AND NOT EXISTS(SELECT 1 FROM CONFIGURACION_DE_VALORES WHERE nombre_original_campo IN('moentre','morecib','Forma_Pago_Cli_Nac','Forma_Pago_Cli_Ext' )
                                                              AND @codigo = valor_numerico)



      BEGIN	

	     DELETE MONEDA_FORMA_DE_PAGO WHERE mfcodfor = @codigo	

	     ---DELETE FROM FORMA_DE_PAGO WHERE codigo = @codigo

             UPDATE FORMA_DE_PAGO 
                     SET ESTADO='A' 
                     WHERE codigo = @codigo

  	     SELECT   0, 'Forma de Pago Borrada en Forma Correcta'
     END	
     ELSE
             SELECT   1, 'NO ES POSIBLE ELIMINAR, EXISTEN DATOS RELACIONADOS' 


END  


GO
