USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[dpsp_obtiene_anula_RC]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[dpsp_obtiene_anula_RC] (@fecha as datetime,@modo as varchar(50), @noper as varchar(50),@ncertificado as varchar(50))  
AS  
/***********************************************************************  
NOMBRE         : dbo.dpsp_obtiene_anula_RC.StoredProcedure.sql  
AUTOR          : SONDA (Unidad de Desarrollo)  
FECHA CREACION : 09/08/2011  
DESCRIPCION    : Migracion a SQL 2008  
HISTORICO DE CAMBIOS  
FECHA        AUTOR           DESCRIPCION     
----------------------------------------------------------------------  
  
  
**********************************************************************/  
  
begin  
  
if @modo = 'C'  
begin  
  
select  
	v.numero_operacion,
	v.fecha_operacion,
	v.fecha_vencimiento,
	v.plazo,
	v.tasa,  
	v.moneda,
	v.codigo_as400,
	v.clcodigo,
	v.cuenta_dcv,
	v.mncodbkb,
	v.clnombre,  
	v.monto_inicio,
	v.monto_final,
	v.correla_operacion as cortes,  
	v.tipo_emision,
	v.tipo_deposito,
	v.rut_cliente,
	v.cldv,
	v.numero_certificado_dcv,
	v.tipo_operacion,  
	g.numero_original as 'monumdocu', --m.monumdocu VGS se cambia por Migracion a folios de Corpbanca, se debe buscar el numero operacion original de exITAU, m.monumdocu,
	m.movalvenp,
	ISNULL(a.actualizado,' ') as 'actualizado',
	m.mostatreg,
	0,
	0,
	0,
	r.CodigoCtaCliente,
	r.SecImposicion
 from VIEW_DEPOSITOS_RC v, GEN_CAPTACION g, Relacion_Anulacion r, mdmo m  
	left join graba_anula_dpf as a on a.numero_operacion = m.monumoper  
	and a.numero_certificado = m.numero_certificado_dcv  
 where v.fecha_vencimiento=@fecha and v.numero_certificado_dcv = m.numero_certificado_dcv  
	AND m.monumoper = v.numero_operacion AND m.mocorrela = v.correla_operacion and  motipoper = 'RIC'  and mostatreg = 'A'  
	AND r.fecha_operacion = @fecha and r.numero_operacion = m.monumoper AND r.numero_certificado_dcv = m.numero_certificado_dcv
	AND g.numero_operacion = m.monumdocu AND g.tipo_operacion = 'CAP' AND g.numero_certificado_dcv = m.numero_certificado_dcv
	-- !!!importante: no desordenar el order by por  numero_certificado_dcv como orden de inicio  
	order by v.numero_certificado_dcv,v.numero_operacion,v.rut_cliente,v.mncodbkb,v.tipo_deposito  
  
end  
  
else  
  
begin  
  
if @modo = 'I'  
  
begin  
  
	BEGIN TRAN  
	insert into dbo.graba_anula_dpf(fecha_proc,numero_operacion,numero_certificado,actualizado) values(@fecha,@noper,@ncertificado,'S')  
	COMMIT TRAN  
  
end  
  
end  
  
end  

/*
dpsp_obtiene_anula_RC '2016-04-28','C','0','0'

select mostatreg, numero_certificado_dcv,* from mdmo where monumoper = 188030
select * from Relacion_Anulacion where numero_operacion = 188030

select * from graba_anula_dpf
*/

GO
