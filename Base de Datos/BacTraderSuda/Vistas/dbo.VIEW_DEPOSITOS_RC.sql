USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_DEPOSITOS_RC]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE            view [dbo].[VIEW_DEPOSITOS_RC] AS
select
a.moneda,		a.monto_inicio,		a.tasa,
a.monto_final,		
a.fecha_operacion,	a.fecha_vencimiento,	a.plazo,
a.condicion_captacion,	a.numero_operacion,	a.correla_operacion,
a.correla_corte,	a.tipo_deposito,	a.estado,
b.codigo_as400,		b.clcodigo,		
ISNULL(CDV.Cuenta_DVC,'') as cuenta_dcv,
b.clnombre,		c.mncodbkb,		a.tipo_emision,
a.rut_cliente,		b.cldv,			a.monto_inicio_pesos,
a.codigo_rut,		a.tipo_operacion,	a.numero_certificado_dcv,
a.numero_original
from 
	gen_captacion 		a 
	INNER JOIN  view_cliente b ON
		a.rut_cliente	= b.clrut 
		and a.codigo_rut= b.clcodigo 
	INNER JOIN BacparamSuda..moneda c ON
		a.moneda	= c.mncodmon
	LEFT JOIN ClienteCuentaDCV CDV ON
		b.clrut = cdv.Rut 
		and b.cldv = cdv.dv 
		and b.clcodigo  = cdv.Codigo_Secuencia
where a.estado ='' and 
		a.tipo_operacion = 'RIC'
           
UNION
select
a.momonemi,		a.monominal,		a.motaspact,
a.movalvenp,		
a.mofecemi,		a.mofecven,		DATEDIFF("d",a.mofecemi,a.mofecven)as plazo,
a.Condicion_Captacion,	a.monumoper,		a.mocorrela,
a.mocorrelao,		a.tipo_deposito,	a.mostatreg,
b.codigo_as400,		b.clcodigo,		
ISNULL(CDV.Cuenta_DVC,'') as cuenta_dcv,
b.clnombre,		c.mncodbkb,		a.Tipo_Emision,
a.morutcli,		b.cldv,			a.movpresen,
a.mocodcli,		'ARIC' as motipoper,	a.numero_certificado_dcv,
a.monumdocu
from 
	Mdmo 			a
	INNER JOIN 	view_cliente b ON
		a.morutcli		= b.clrut 
		and a.mocodcli	= b.clcodigo 
	INNER JOIN BacparamSuda..moneda c ON
		a.momonemi=	c.mncodmon 
	LEFT JOIN ClienteCuentaDCV CDV ON
		b.clrut = cdv.Rut 
		and b.cldv = cdv.dv 
		and b.clcodigo  = cdv.Codigo_Secuencia
where a.mostatreg ='A' and  
	a.motipoper = 'RIC'

GO
