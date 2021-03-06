USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SELECT_REG_MOV_TICKET_SPOT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_SELECT_REG_MOV_TICKET_SPOT]
       (
         @_Fecha_Inicio DateTime,
         @_Fecha_Fin DateTime
       )
AS
BEGIN
  
SELECT 'Numero_Operacion'=           Numero_Operacion, 
       'Numero_Relacion_Operacion' = Numero_Relacion_Operacion,
       'Fecha_Operacion' =           convert(nvarchar(10), Fecha_Operacion,105) ,
       'Tipo_Operacion' =            CASE WHEN Tipo_Operacion = 'V' THEN 'VENTA' ELSE 'COMPRA' END,
       'Codigo_Producto' =           PROD.Codigo_Producto, 
       'CarteraOrigen' =             0,
       'CodMesaOrigen' =             CodMesaOrigen,
       'CarteraDestino' =            0,
       'CodMesaDestino' =            CodMesaDestino,
       'CodMoneda1' =                CodMoneda1,
       'NemoMoneda1' =               MDA1.mnnemo,
       'MontoMoneda1' =              MontoMoneda1,
       'CodMoneda2' =                CodMoneda2,
       'NemoMoneda2' =               MDA2.mnnemo,
       'MontoMoneda2' =              MontoMoneda2,
       'T/C Paridad' =                Case WHEN MDA1.mnnemo = 'USD' AND MDA2.mnnemo = 'CLP' THEN TipoCambio
                                      ELSE Paridad END,                                      
       'Par' =            RTRIM(MDA1.mnnemo)+'/'+MDA2.mnnemo, 
       'Paridad' =                   Paridad,
       'Precio' =                    Precio,
       'Usuario' =                   Usuario,
       'Estado_Operacion' =          CASE WHEN Estado_Operacion = 'A' THEN 'ANULADA'
                                          WHEN Estado_Operacion = 'V' THEN 'VIGENTE' END ,
       'DescMesa1' =                 MESA1.tbglosa,
       'DescMesa2' =                 MESA2.tbglosa        

    FROM Tbl_movTicketSpot
        INNER JOIN view_moneda MDA1 ON MDA1.mncodmon = CodMoneda1
        INNER JOIN view_moneda MDA2 ON MDA2.mncodmon = CodMoneda2
        INNER JOIN bacparamsuda.dbo.tabla_general_detalle MESA1 ON MESA1.tbcateg = 245 AND MESA1.tbcodigo1 = CodMesaOrigen
        INNER JOIN bacparamsuda.dbo.tabla_general_detalle MESA2 ON MESA2.tbcateg = 245 AND MESA2.tbcodigo1 = CodMesaDestino        
        INNER JOIN BacParamSuda..PRODUCTO PROD ON PROD.Id_Sistema = 'BCC' AND PROD.codigo_producto = Tbl_movTicketSpot.Codigo_Producto
    WHERE Fecha_Operacion BETWEEN @_Fecha_Inicio AND @_Fecha_FIN
    ORDER BY Numero_Operacion, Numero_Relacion_Operacion
END



GO
