USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFVOUCHERS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFVOUCHERS]
(
	@FECPROC CHAR(10)
)
AS
BEGIN
	
SELECT acfecproc,
       acfecprox,
       'UF_HOY'    = CONVERT(FLOAT, 0),
       'UF_MAN'    = CONVERT(FLOAT, 0),
       'IVP_HOY'   = CONVERT(FLOAT, 0),
       'IVP_MAN'   = CONVERT(FLOAT, 0),
       'DO_HOY'    = CONVERT(FLOAT, 0),
       'DO_MAN'    = CONVERT(FLOAT, 0),
       'DA_Hoy'     = CONVERT(FLOAT, 0),
       'DA_Man'     = CONVERT(FLOAT, 0),
       acnomprop,
       'RUT_EMPRESA' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop,
       'RUT' = acrutprop ,
       'DV'  = acdigprop ,
       'NOM' = acnomprop,
	   'RazonSocial'      = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) 		
  INTO #PARAMETROS
  FROM text_arc_ctl_dri

IF EXISTS(SELECT * 
			FROM	BAC_CNT_DETALLE_VOUCHER
			INNER JOIN BAC_CNT_VOUCHER
			ON BAC_CNT_DETALLE_VOUCHER.Numero_Voucher = BAC_CNT_VOUCHER.Numero_Voucher
			RIGHT OUTER JOIN VIEW_PLAN_DE_CUENTA
			ON VIEW_PLAN_DE_CUENTA.Cuenta = BAC_CNT_DETALLE_VOUCHER.Cuenta
         ) BEGIN


     
	SELECT	'cta'		= b.cuenta           	,
		'tipo_monto'	= b.tipo_monto       	,
		'MONTO'	= b.monto		,
		'tipo_voucher'	= a.tipo_voucher     	,
		'GLOSA'	= SUBSTRING(a.glosa,1,45) + ' ' + a.tipo_operacion + ' ' + a.fpago ,
		'descripcioncta'	= '                                                                        ', --Descripcion 		,
		'numerovoucher' = a.Numero_Voucher	,
		'correlativo'	= b.Correlativo		,
		'FechaProcConta'= CONVERT ( CHAR (10) , a.FECHA_INGRESO , 103),
		'MonOperacion'  = a.MonedaOperacion	,
		'MonCuenta'	= b.MonedaCuenta	,
		'NumeroOp'	= a.Operacion  		,
		'Cliente'		= SPACE(100)		,
		'tipo_operacion'  = a.tipo_operacion	,
		'operacion'	= a.operacion		,
		'ctasub'		= SUBSTRING(b.cuenta,1,3),
		'ctacorres'	= (case WHEN b.cuenta = '182' THEN b.ctacorresponsal ELSE '' END),
		'DescMoneda'    = (CASE WHEN pla.tipo_moneda='N' THEN 'CLP' ELSE mon.MNNEMO END),
		'RazonSocial'      = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	INTO	#voucher
	FROM	BAC_CNT_DETALLE_VOUCHER b,
		BAC_CNT_VOUCHER a,
		view_moneda mon,
		VIEW_PLAN_DE_CUENTA pla

	WHERE	b.Numero_Voucher = a.Numero_Voucher 
	AND	a.FECHA_INGRESO = @FECPROC
	and 	mon.MNCODMON= b.MonedaCuenta
	and 	pla.cuenta=b.cuenta

	 update #voucher
	 set descripcioncta = Descripcion
	 From VIEW_PLAN_DE_CUENTA 
	 where Cta	   = Cuenta	
	 and ctasub	   <> 182	


	update #voucher
	   set descripcioncta = Descripcion
	  From VIEW_PLAN_DE_CUENTA 
	 where ctasub	   = Cuenta	
	   and ctasub	   = 182	

	UPDATE #voucher 
	SET    Cliente = c.clnombre
	FROM   view_cliente c,
 	       text_mvt_dri m
               
	WHERE  #voucher.operacion = monumoper  
	  AND  m.morutcli  = c.clrut
	  AND  m.mocodcli  = c.clcodigo
	  AND  (#voucher.tipo_operacion = 'CP' OR #voucher.tipo_operacion = 'VP')			

	UPDATE #voucher 
	SET    Cliente = c.clnombre
	FROM   view_cliente c,
 	       text_rsu     r
               
	WHERE  #voucher.operacion = r.rsnumdocu  
	  AND  r.rsrutcli  = c.clrut
	  AND  r.rscodcli  = c.clcodigo
	  AND  (#voucher.tipo_operacion = 'DCP' OR #voucher.tipo_operacion = 'DVP')			
          and  r.rsfecpro = @fecproc

 
	SELECT	'ACFECPROC' = CONVERT(CHAR(10),@fecproc, 103),
		'ACFECPROX' = CONVERT(CHAR(10), #PARAMETROS.acfecprox, 103),
		#PARAMETROS.uf_hoy,
		#PARAMETROS.uf_man,
		#PARAMETROS.ivp_hoy,
		#PARAMETROS.ivp_man,
		#PARAMETROS.do_hoy,
		#PARAMETROS.do_man,
		#PARAMETROS.da_hoy,
		#PARAMETROS.da_man,
		#PARAMETROS.acnomprop,
		#PARAMETROS.rut_empresa,
		'HORA' = CONVERT(varchar(10), GETDATE(), 108)	,
		#PARAMETROS.RUT,
		#PARAMETROS.DV,
		#PARAMETROS.NOM,
		'cuenta' = cta	,
		tipo_monto	,
		monto		,
		tipo_voucher	,
		GLOSA		,
		'descripcion'=descripcioncta 	,
		GLOSITA = substring(glosa,1,50),
		numerovoucher	,
		correlativo	,
		FechaProcConta	,
		MonOperacion	,
		MonCuenta	,
		NumeroOp	,
		Cliente		,
		ctacorres	,
		DescMoneda ,
		'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	FROM	#voucher	,
		#PARAMETROS 	
	ORDER BY GLOSA

	END

   ELSE BEGIN

      SELECT 	'ACFECPROC' = CONVERT(CHAR(10), @fecproc, 103),
             	'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
             	uf_hoy,
             	uf_man,
             	ivp_hoy,
             	ivp_man,
             	do_hoy,
             	do_man,
             	da_hoy,
		da_man,
             	acnomprop,
 		rut_empresa,
             	'HORA' = CONVERT(VARCHAR(10), GETDATE(), 108),
             	'NUMERO_VOUCHER'   	= '' ,
             	'CORRELATIVO'      	= '' ,
            	'CUENTA'      		= '' ,
             	'TIPO_MONTO'       	= '' ,
             	'MONTO'        		= '' ,
             	'TIPO_VOUCHER'    	= '' ,
             	'TIPO_OPERACION'   	= '' ,
             	'OPERACION'        	= '' ,
             	'GLOSA_OPERACION'  	= '' ,
            	'RUT'          		= '' ,
            	'DV'           		= '' ,
             	'NOM'          		= '' ,
             	'DESCRIPCION'      	= '' ,
	 	'glosita' 		= ' ',	
		'numerovoucher'		= 0  ,
		'correlativo'		= 0  ,
		'FechaProcConta'	= CONVERT(CHAR(10), @fecproc, 103),
		'MonOperacion'		= 0  ,
		'MonCuenta'		= 0  ,
		'NumeroOp'		= 0  ,
		'Cliente'		= ' ',			
		'ctacorres'		= ' ',
		'DescMoneda',
		'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
         	FROM 
             	#PARAMETROS
   END

END
GO
