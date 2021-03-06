USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFCUENTAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFCUENTAS] --'20020924'
		(
			@Fecha	CHAR (08)
		)
AS
BEGIN
-- select * from BAC_CNT_DETALLE_VOUCHER

DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)

	SELECT 
	       @ACNOMPROP = acnomprop,
	       @ACFECPROC = acfecproc,
	       @ACRUTPROP = acrutprop,
	       @ACDIGPROP = acdigprop
	    FROM text_arc_ctl_dri               


	 SELECT cta	= e.CUENTA,
        	montodebe = sum(case TIPO_MONTO WHEN 'D' THEN Monto ELSE  0 END ),
		montohaber= sum(case TIPO_MONTO WHEN 'H' THEN Monto ELSE  0 END ),
	        tipo	= TIPO_MONTO,
		ctasub  = substring ( e.CUENTA, 1,3),
		Glosa	= '                                                                              ',
		e.ctacorresponsal,
		e.monedacuenta,						
		'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	   INTO #temp1
	   FROM BAC_CNT_DETALLE_VOUCHER E,
	        BAC_CNT_VOUCHER G
	  WHERE g.fecha_ingreso =  @Fecha
	    and g.numero_voucher = e.numero_voucher
	   GROUP BY TIPO_MONTO,	e.CUENTA,e.ctacorresponsal,e.monedacuenta

	UPDATE #temp1
	   set Glosa	= DESCRIPCION
	  From VIEW_PLAN_DE_CUENTA
	 WHERE cta	= cuenta
	   and ctasub   <> 182
	 
	UPDATE #temp1
	   set Glosa	= DESCRIPCION
	  From VIEW_PLAN_DE_CUENTA
	 WHERE ctasub   = cuenta
	   and ctasub   = 182

	SELECT  cta		,
        	montodebe 	,	
		montohaber	,
	        tipo		,
		ctasub  	,
		Glosa		,
		FECHA 		= substring(@Fecha,7,2 ) + '/' +  substring(@Fecha,5,2 )  + '/' + substring(@Fecha,1,4 ) ,
		HORA 		= RIGHT(GETDATE(),8),
	        banco		=  @ACNOMPROP ,
		ctacorresponsal ,
		monedacuenta,
		'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 	  from  #temp1	
	Order by cta 
	 
END
GO
