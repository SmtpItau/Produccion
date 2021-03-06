USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Detalle_lineas_ret_filtrar]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Detalle_lineas_ret_filtrar]
         (   @numero_operacion   NUMERIC(10)
         ,   @NumeroDocumento    NUMERIC(10)
         ,   @NumeroCorrelativo  NUMERIC(05)
         )
AS
BEGIN
   SET NOCOUNT ON
   SET DATEFORMAT dmy

      
   SELECT NumeroTraspaso 
   ,      NumeroOperacion 
   ,      NumeroDocumento 
   ,      NumeroCorrelativo 
   ,      'CLIENTE'         = ( SELECT clnombre FROM CLIENTE WHERE clrut = rut_cliente AND clcodigo = codigo_cliente)
   ,      Rut_Cliente 
   ,      Codigo_Cliente 
--   ,      'SISTEMA'         = ( SELECT nombre_sistema FROM SISTEMA WHERE id_sistema = a.id_sistema )
--   ,      Id_Sistema 
--   ,      'PRODUCTO'        = ( SELECT descripcion FROM PRODUCTO WHERE codigo_producto = a.codigo_producto )
--   ,      Codigo_Producto 
--   ,      'SISTEMA'         = ( SELECT nombre_sistema FROM SISTEMA WHERE id_sistema = a.SistemaRecibio )
--   ,      SistemaRecibio 
   ,      TipoOperacion     = CASE WHEN TipoOperacion = 'C' THEN 'COMPRA'                           
                                   WHEN TipoOperacion = 'V' THEN 'VENTA'
                                   ELSE ' '
                                   END
   ,      FechaInicio                 
   ,      FechaVencimiento            
   ,      Operador        
   ,      MontoTraspasado       
   ,      UsuarioAutorizo   
   ,      Activo            = CASE WHEN Activo = 'S' THEN 'SI'
                                   ELSE 'N'
                                   END
   ,      Hora_Traspaso 

     FROM LINEA_TRASPASO  a
    WHERE NumeroOperacion   = @numero_operacion
      AND NumeroDocumento   = @NumeroDocumento   
      AND NumeroCorrelativo = @NumeroCorrelativo

   SET NOCOUNT OFF

END



GO
