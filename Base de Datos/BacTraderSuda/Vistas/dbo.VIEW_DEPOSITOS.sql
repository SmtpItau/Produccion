USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_DEPOSITOS]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE      view [dbo].[VIEW_DEPOSITOS] AS

/**
 SP Name            : VIEW_DEPOSITOS 
 Fecha Creación     :
 Author             : Banco Itaú                        
 Author Modificación : Jose Bustos H.
 Fecha Modificación : 16/09/2010                                                                  
 Descripción        : VIEW_DEPOSITOS para Alta/Simulacion DP a Altamira   
 Modificación       :  Se agrego campo  tasa_tran                                           
**/

select
a.moneda,                  a.monto_inicio,                       a.tasa,
a.monto_final,             
a.fecha_operacion,     a.fecha_vencimiento, a.plazo,
a.condicion_captacion,          a.numero_operacion, a.correla_operacion,
a.correla_corte,          a.tipo_deposito,          a.estado,
b.codigo_as400,                      b.clcodigo,
ISNULL(CDV.Cuenta_DVC,'') as cuenta_dcv,
b.clnombre,                c.mncodbkb,               a.tipo_emision,
a.rut_cliente,               b.cldv,                         a.monto_inicio_pesos,
a.codigo_rut,               a.tipo_operacion,        a.numero_certificado_dcv,
a.tasa_tran
from 
            gen_captacion                        a
            INNER JOIN view_cliente b ON 
				a.rut_cliente=b.clrut and a.codigo_rut=b.clcodigo
			INNER JOIN BacparamSuda..moneda     c ON
				a.moneda=c.mncodmon
			LEFT JOIN ClienteCuentaDCV CDV ON
				b.clrut = cdv.Rut and b.cldv = cdv.dv and b.clcodigo  = cdv.Codigo_Secuencia
				
where       a.estado ='' and 
            a.tipo_operacion = 'CAP'

GO
