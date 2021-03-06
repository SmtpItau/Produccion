USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_RET_FILTRAR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_RET_FILTRAR]
 ( 
 @rut_cliente  numeric(9) = 00,
 @codigo_cliente  numeric(9) = 00,
        @id_sistema             char(3)    = '',
        @numoper                numeric(9) = 00,
        @fechainicio  datetime   = '',
 @fechavencimiento datetime   = ''
        )
   
AS   
BEGIN
 SELECT   a.numerooperacion,
                 a.rut_cliente, 
                 a.id_sistema,
                a.tipo_operacion, 
                 a.fechainicio, 
                 a.fechavencimiento, 
                 a.montotransaccion,
   a.operador, 
                 a.activo,
   a.numerodocumento,
   a.numerocorrelativo
               
 FROM    
                 LINEA_TRANSACCION a,PRODUCTO b
 WHERE   
                (a.fechainicio     >=   @fechainicio       or @fechainicio      = '' )  
 AND     (a.fechainicio     <=   @fechavencimiento  or @fechavencimiento = '' )
 AND (a.rut_cliente     =    @rut_cliente       or @rut_cliente      = 00 )
 AND     (a.codigo_cliente  =    @codigo_cliente    or @codigo_cliente   = 00 )
 AND (a.activo          =    'S'                                          )
        AND     (a.id_sistema      =    @id_sistema        or @id_sistema       = '' ) 
        AND     (a.numerooperacion =    @numoper           or @numoper          = 00 )   
 AND (a.codigo_producto=b.codigo_producto)
 
END
GO
