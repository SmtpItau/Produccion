USE [BacParamSuda]
GO
/****** Object:  View [dbo].[VIEW_MOTOR]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[VIEW_MOTOR]
AS

SELECT 
	[fecha]			   = so.dOPE_Fecha,
	[sistema]          = convert( varchar(3)  , mod.sMOD_Generico ) ,
	[tipo_mercado]     = convert( varchar(12) , mod.sMOD_Generico   ) ,
	[tipo_operacion]   = convert( varchar(6)  , sto.sTOPER_TipoMercado ) ,
	[estado_envio]     = CASE WHEN sdo.idEstado In (2,3,4,6) and sdo.idFormaPago not in (5) THEN 'E' 
							  WHEN sdo.idEstado In (4) and sdo.idFormaPago in (5) then 'R'
							  ELSE 'P' END,
	[numero_operacion] = so.iOPE_Operacion ,
	[rut_cliente]      = so.iOPE_RutCliente ,
	[codigo_cliente]   = so.iOPE_CodCliente ,
	[moneda]           = so.iOPE_Moneda ,
	[monto_operacion]  = so.fOPE_MontoOperacion ,
	[forma_pago]       = sdo.idFormaPago ,
	[fecha_operacion]  = sdo.dOPE_Fecha ,
	[fecha_vencimiento]= so.dOPE_FechaLiquidacion ,
	[liquidada]        = CASE WHEN sdo.idEstado = 4 THEN 'X' ELSE ' ' END,
	[RecRutBanco]      = so.iOPE_RutCliente ,
	[RecCodBanco]      = so.iOPE_CodCliente ,
	[RecCodSwift]      = '' ,
	[RecDireccion]     = '' ,
	[RecCtaCte]        = sdo.sDETOPE_NumeroCuenta ,
	[Tipo_Movimiento]  = CASE WHEN sto.sTOPER_AccionSADP = 'P' THEN 'A' ELSE 'C' END ,
	[GlosaAnticipo]    = '' ,
	[Id_Paquete]       = 0 ,
	[Estado_Paquete]   = 'D' ,
	[Reservado]        = ''
FROM   db_SADP_Filiales.dbo.SADP_DetOperaciones sdo
       INNER JOIN db_SADP_Filiales.dbo.SADP_Operaciones so
            ON  so.dOPE_Fecha = sdo.dOPE_Fecha
            AND so.idEntidad = sdo.idEntidad
            AND so.idModulo = sdo.idModulo
            AND so.idTipoOperacion = sdo.idTipoOperacion
            AND so.iOPE_Operacion = sdo.iOPE_Operacion
       INNER JOIN db_SADP_Filiales.dbo.SADP_TipoOperaciones sto
            ON  sto.idEntidad = so.idEntidad
            AND sto.idModulo = so.idModulo
            AND sto.idTipoOperacion = so.idTipoOperacion
       INNER JOIN db_SADP_Filiales.dbo.SADP_Modulos mod
            ON  mod.idEntidad = so.idEntidad
			AND mod.idModulo = so.idModulo
WHERE  sdo.idEntidad = 1

/*

SELECT 
	[fecha]  ,
	[sistema]          = convert( varchar(3)  , sistema ) ,
	[tipo_mercado]     = convert( varchar(12) , tipo_Mercado   ) ,
	[tipo_operacion]   = convert( varchar(6)  , tipo_operacion ) ,
	[estado_envio]     = convert( varchar(1)  , estado_envio   ) ,
	[numero_operacion]  ,
	[rut_cliente]       ,
	[codigo_cliente]    ,
	[moneda]            ,
	[monto_operacion]   ,
	[forma_pago]        ,
	[fecha_operacion]   ,
	[fecha_vencimiento] ,
	[liquidada]        = convert( varchar(1)  , liquidada      ) ,
	[RecRutBanco]       ,
	[RecCodBanco]       ,
	[RecCodSwift]       ,
	[RecDireccion]      ,
	[RecCtaCte]         ,
	[Tipo_Movimiento]  = convert( varchar(1)  , Tipo_Movimiento ) ,
	[GlosaAnticipo]     ,
	[Id_Paquete]        ,
	[Estado_Paquete]   = convert( varchar(1)  , Estado_Paquete  ) ,
	[Reservado]        = convert( varchar(50) , Reservado       )

 FROM bacparamsuda..MDLBTR
*/


GO
