USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTROPOR_RUT]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_FiltroPor_Rut    fecha de la secuencia de comandos: 03/04/2001 15:18:03 ******/
CREATE PROCEDURE [dbo].[SP_FILTROPOR_RUT]
  ( @fechainicio  datetime=' ',
   @fechavencimiento datetime=' ',
   @rut_cliente  numeric(9)=0,
   @codigo_cliente  numeric(9)=0)
   
AS   
BEGIN
 SELECT  LINEA_TRANSACCION.numerooperacion,LINEA_TRANSACCION.rut_cliente,LINEA_TRANSACCION.id_sistema,
               LINEA_TRANSACCION.tipo_operacion,LINEA_TRANSACCION.fechainicio,LINEA_TRANSACCION.fechavencimiento,LINEA_TRANSACCION.montotransaccion,
  LINEA_TRANSACCION.operador,PRODUCTO.descripcion,LINEA_TRANSACCION.activo
  
               
 FROM    LINEA_TRANSACCION ,PRODUCTO
 WHERE   (LINEA_TRANSACCION.fechainicio >= @fechainicio)  
 AND     (LINEA_TRANSACCION.fechainicio <= @fechavencimiento)
 AND (LINEA_TRANSACCION.rut_cliente=@rut_cliente)
 AND     (LINEA_TRANSACCION.codigo_cliente=@codigo_cliente)
 AND     (LINEA_TRANSACCION.codigo_producto=PRODUCTO.codigo_producto)
 AND (LINEA_TRANSACCION.activo='S')
   
 
END
GO
