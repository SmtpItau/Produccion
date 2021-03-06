USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[dpsp_obtiene_depositos_RC]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[dpsp_obtiene_depositos_RC] (@fecha as datetime)  
as  
begin  
  
 SET NOCOUNT ON  
  
 select v.numero_operacion,  
  v.fecha_operacion,  
  v.fecha_vencimiento,  
  v.plazo,  
  g.tasa,   
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
         g.numero_original,  
  g.monto_final_org,  
  g.Id_Compra,  
         round((a.vmvalor - b.vmvalor ) *  g.monto_inicio,0)  as valor_reajuste,  
  g.interes_acumulado,  
  g.reajuste_acumulado,
  g.int_dev_recompra as int_devengado,
  g.capital_recomprado
 into #tmp  
 from VIEW_DEPOSITOS_RC v, view_moneda mon, gen_captacion g   
        left join view_valor_moneda as a on a.vmfecha = fecha_vencimiento and a.vmcodigo = 998  
        left join view_valor_moneda as b on b.vmfecha = fecha_origen and b.vmcodigo = 998     
        where v.fecha_vencimiento=@fecha and v.numero_certificado_dcv = g.numero_certificado_dcv  
        and g.numero_operacion = v.numero_operacion and v.tipo_operacion <> 'ARIC'    
	and mon.mncodmon = a.vmcodigo
        order by v.numero_certificado_dcv,v.numero_operacion,v.rut_cliente,v.mncodbkb,v.tipo_deposito  
  
 UPDATE  #tmp  
 SET #tmp.tasa = Isnull((select top 1 a.tasa from gen_captacion a with(index(Idx_BuscaDap)) where a.numero_operacion = #tmp.numero_operacion),0)  
 
 --VGS actualiza Numero de operacion original ITAU 08/08/2016
 UPDATE #tmp
 SET #tmp.numero_original = crt.numero_original 
 FROM GEN_CAPTACION crt
 WHERE #tmp.numero_original = crt.numero_operacion and crt.tipo_operacion = 'CAP'
  
 select * from #tmp  
  
 SET NOCOUNT OFF  
  
end  
--select numero_original,* from GEN_CAPTACION where tipo_operacion = 'RIC' and fecha_vencimiento = '20160428'
--select numero_original,* from GEN_CAPTACION where numero_operacion IN(187488,187835,187677,186984)
--dpsp_obtiene_depositos_RC '20160428'

GO
