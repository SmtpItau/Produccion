USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_OPERACIONES_VIGENTES]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CON_OPERACIONES_VIGENTES](
                                                      @id_sistema         CHAR(03)=''
                                                ,     @rut_cliente        NUMERIC(09)=0
                                                ,     @codigo_cliente     NUMERIC(09)=0
                                                ,     @numero_operacion   NUMERIC(10)=0
                                                )
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

   DECLARE @fecha_proceso   DATETIME

   SELECT @fecha_proceso = fecha_proceso FROM DATOS_GENERALES

   SELECT L.numerooperacion
   ,      P.descripcion
   ,      L.numerodocumento
   ,      L.numerocorrelativo
--   ,      L.codigo_producto
   ,      L.fechainicio
   ,      L.fechavencimiento
   ,      L.montooriginal
   ,      L.tipocambio
   ,      L.matrizriesgo
   ,      L.montotransaccion
   FROM LINEA_TRANSACCION L
     ,  PRODUCTO          P
   WHERE (L.id_sistema      = @id_sistema OR @id_sistema = '')
   AND   (L.rut_cliente     = @rut_cliente OR @rut_cliente = 0)
   AND   (L.codigo_cliente  = @codigo_cliente OR @codigo_cliente = 0)
   AND   (L.numerooperacion = @numero_operacion OR @numero_operacion = 0)
   AND   L.fechavencimiento > @fecha_proceso
--   AND   L.codigo_producto  = P.codigo_producto
          
END




GO
