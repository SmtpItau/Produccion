USE [BacCamSuda]
GO
/****** Object:  View [dbo].[VIEW_VALOR_DEFECTO]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_VALOR_DEFECTO]
AS  
SELECT 'BCC' as id_sistema, 
		cop.sDescripcion AS codigo_producto, 
		cop.sDescripcion AS  codigo_area, 
		
		dv.default_iformapagomn	as compra_forma_pagomn,
        dv.default_iformapagomx	as compra_forma_pagomx, 
        dv.default_sCodigoOMA		as compra_codigo_oma,
        dv.default_sCodigoComercio as compra_codigo_comercio,
        dv.default_sCodigoConcepto as compra_codigo_concepto, 
       
		venta.default_iformapagomn	as venta_forma_pagomn,
        venta.default_iformapagomx	as venta_forma_pagomx, 
        venta.default_sCodigoOMA		as venta_codigo_oma,
        venta.default_sCodigoComercio as venta_codigo_comercio,
        venta.default_sCodigoConcepto as venta_codigo_concepto, 
        
        'S'			as contabiliza,
        0			as monto_operacion, 
        dv.idMoneda2 	as codigo_moneda, 
        dv.Default_iCodCorresponsal			as Corres_Compra, 
        venta.Default_iCodCorresponsal 		as Corres_Venta
 FROM bacparamsuda.dbo.CargaOperaciones_DefectoValores dv
INNER JOIN BacParamSuda.dbo.CargaOperaciones_Plataformas cop ON cop.idPlataforma = dv.idPlataforma
INNER JOIN (SELECT * from bacparamsuda.dbo.CargaOperaciones_DefectoValores Vdv WHERE vdv.idOperacion =2 )AS Venta ON 
 venta.idProducto = dv.idProducto 
 AND Venta.idPlataforma = dv.idPlataforma
 AND venta.idMoneda1 = dv.idMoneda1
 AND venta.idMoneda2 = dv.idMoneda2
 AND dv.idOperacion=1
 AND dv.idPlataforma>3


 
GO
