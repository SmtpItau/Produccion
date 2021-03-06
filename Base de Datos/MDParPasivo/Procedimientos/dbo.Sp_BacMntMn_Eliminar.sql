USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMntMn_Eliminar]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_BacMntMn_Eliminar]
                  (
                  @codigo NUMERIC(5)
                  )

AS
BEGIN

      SET NOCOUNT ON
      SET DATEFORMAT dmy

      IF NOT EXISTS(SELECT codigo_moneda1 FROM PRODUCTO_CUENTA WHERE codigo_moneda1 =@codigo)
      AND NOT EXISTS(SELECT codigo_moneda2 FROM PRODUCTO_CUENTA WHERE codigo_moneda2 =@codigo)	
      AND NOT EXISTS(SELECT inmonemi FROM INSTRUMENTO WHERE inmonemi =@codigo)	
      AND NOT EXISTS(SELECT semonemi FROM SERIE WHERE semonemi =@codigo)	
--       AND NOT EXISTS(SELECT momonemi FROM VIEW_MOVIMIENTO_TRADER WHERE momonemi =@codigo)		
--       AND NOT EXISTS(SELECT momonpact FROM VIEW_MOVIMIENTO_TRADER WHERE momonpact =@codigo)		
--       AND NOT EXISTS(SELECT momonemi FROM VIEW_MOVIMIENTO_INVERSION_EXTERIOR WHERE momonemi =@codigo)		
--       AND NOT EXISTS(SELECT momonpag FROM VIEW_MOVIMIENTO_INVERSION_EXTERIOR  WHERE momonpag =@codigo)		
--       AND NOT EXISTS(SELECT mocodmon1 FROM VIEW_MOVIMIENTO_FORWARD WHERE mocodmon1 =@codigo)		
--       AND NOT EXISTS(SELECT mocodmon2 FROM VIEW_MOVIMIENTO_FORWARD WHERE mocodmon2 =@codigo)		
--       AND NOT EXISTS(SELECT pagamos_moneda FROM VIEW_MOVIMIENTO_SWAP WHERE pagamos_moneda =@codigo)		
--       AND NOT EXISTS(SELECT compra_moneda FROM VIEW_MOVIMIENTO_SWAP WHERE compra_moneda =@codigo)		
--       AND NOT EXISTS(SELECT venta_moneda FROM VIEW_MOVIMIENTO_SWAP WHERE venta_moneda =@codigo)		
--       AND NOT EXISTS(SELECT recibimos_moneda FROM VIEW_MOVIMIENTO_SWAP WHERE recibimos_moneda =@codigo)		
--       AND NOT EXISTS(SELECT mocodmon FROM VIEW_MOVIMIENTO_CAMBIO,MONEDA WHERE mocodmon = mnnemo
-- 									 AND   mncodmon  = @codigo)		
--       AND NOT EXISTS(SELECT mocodcnv FROM VIEW_MOVIMIENTO_CAMBIO,MONEDA WHERE mocodcnv = mnnemo
-- 									 AND   mncodmon  = @codigo)		
      AND NOT EXISTS(SELECT 1 FROM CONFIGURACION_DE_VALORES WHERE nombre_original_campo = 'mocodmon' AND @codigo = (CASE WHEN ISNUMERIC(valor_caracter) = 0 THEN 0 ELSE valor_caracter END))		
--      AND NOT EXISTS(SELECT codigo_moneda FROM VIEW_LETRA_HIPOTECARIA WHERE codigo_moneda =@codigo)		
--      AND NOT EXISTS(SELECT codigo_moneda FROM CODIGO_PLANILLA_AUTOMATICA WHERE codigo_moneda =@codigo)		


      BEGIN
	  	

	   DELETE MONEDA_FORMA_DE_PAGO where mfcodmon = @codigo
	   DELETE MONEDA_FORMA_DE_PAGO where mfmonpag = @codigo

   	   DELETE VALOR_MONEDA where vmcodigo = @codigo 

      	   DELETE BIDASK where moneda = @codigo 

      	   DELETE PRODUCTO_MONEDA where mpcodigo = @codigo 

           --DELETE FROM MONEDA WHERE mncodmon = @codigo AND ESTADO<>'A'
           UPDATE MONEDA SET ESTADO='A' WHERE mncodmon = @codigo

	   SELECT 'OK'      
    
      END ELSE BEGIN

            SELECT 'NO','NO ES POSIBLE ELIMINAR, EXISTEN DATOS RELACIONADOS'

      END

      SET NOCOUNT OFF

END





GO
