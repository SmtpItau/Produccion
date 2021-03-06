USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[dpsp_obtiene_lineas_omd]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--dpsp_obtiene_lineas_omd 225455
CREATE PROCEDURE [dbo].[dpsp_obtiene_lineas_omd] (@omd as VARCHAR(256))  
AS  
/***********************************************************************  
NOMBRE         : dbo.dpsp_obtiene_lineas_omd.StoredProcedure.sql  
AUTOR          : SONDA (Unidad de Desarrollo)  
FECHA CREACION : 09/08/2011  
DESCRIPCION    : Migracion a SQL 2008  
HISTORICO DE CAMBIOS  
FECHA        AUTOR           DESCRIPCION     
----------------------------------------------------------------------  
  
**********************************************************************/  
  
begin  
  
	select	moneda
	,		monto_inicio
	,		tasa
	,		monto_final
	,		fecha_operacion
	,		fecha_vencimiento
	,		plazo
	,		condicion_captacion
	,		numero_operacion
	,		correla_operacion
	,		correla_corte
	,		tipo_deposito
	,		estado
	,		codigo_as400
	,		clcodigo
	,		cuenta_dcv
	,		clnombre
	,		mncodbkb
	,		tipo_emision
	,		rut_cliente
	,		cldv
	,		monto_inicio_pesos
--	,		0 as codigo_rut
	,		case when (select count(*) from bacparamsuda..cliente c where c.clrut=rut_cliente)=1 then 0 else clcodigo end as codigo_rut
	,		tipo_operacion
	,		numero_certificado_dcv
	,		tasa_tran
	from VIEW_DEPOSITOS  
	where numero_operacion=CONVERT (numeric,@omd)  
	order by numero_operacion  


end  
GO
