USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Ret_Filtrar]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Lineas_Ret_Filtrar]
	(	
	@rut_cliente		numeric(9) = 00,
	@codigo_cliente		numeric(9) = 00,
        @id_sistema             char(3)    = ' ',
        @numoper                numeric(9) = 00,
        @fechainicio		datetime   = ' ',
	@fechavencimiento	datetime   = ' ',
        @producto               CHAR(5)    = ' '
        )
			
AS BEGIN
SET DATEFORMAT dmy
	SELECT   a.numerooperacion,
                 a.rut_cliente, 
                 a.id_sistema,
              	 b.descripcion, --a.tipo_operacion, 
                 a.fechainicio, 
                 a.fechavencimiento, 
                 a.montotransaccion,
		 a.operador, 
                 a.activo,
		 a.numerodocumento,
		 a.numerocorrelativo,
                 'sistema'               = ( SELECT nombre_sistema FROM SISTEMA WHERE id_sistema = a.id_sistema ),
                 c.clnombre
               
	FROM   	
                 LINEA_TRANSACCION a
           ,     PRODUCTO b
           ,     CLIENTE  c

	WHERE  	
                (a.fechavencimiento     >=   @fechainicio  or @fechainicio = ' ' )  
	AND    	(a.fechavencimiento     <=   @fechavencimiento  or @fechavencimiento = ' ' )
	AND	(a.rut_cliente     =    @rut_cliente       or @rut_cliente      = 00 )
	AND     (a.codigo_cliente  =    @codigo_cliente    or @codigo_cliente   = 00 )
	AND	(a.activo          =    "S"                                          )
        AND     (a.id_sistema      =    @id_sistema        or @id_sistema       = ' ' ) 
        AND     (a.numerooperacion =    @numoper           or @numoper          = 00 )   
--	AND	(a.codigo_producto =    b.codigo_producto )
  --      AND     (a.codigo_producto =    @producto          or @producto         = ' ')

        AND     c.clrut            =    a.Rut_Cliente
        AND     c.clcodigo         =    a.Codigo_Cliente
END

GO
