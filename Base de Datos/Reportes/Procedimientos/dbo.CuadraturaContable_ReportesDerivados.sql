USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaContable_ReportesDerivados]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CuadraturaContable_ReportesDerivados]
AS
BEGIN
	-- BFW
	SELECT    'CodIBS'		     = cc.codIBS
			, 'NombreCuenta'	 = pc.descripcion
			, 'TipoCuenta'       = pc.tipo_cuenta
			, 'SaldoCartera'     = cc.saldoContable
			, 'Producto'	     = pf.Producto
			, 'CarteraNormativa' = pd.tbglosa
			, 'SaldoContable'	 = ABS(cc.saldoIBS)
			, 'Moneda'			 = cc.Moneda --CASE WHEN LEFT(cc.codIBS, 2) = '21' OR LEFT(cc.codIBS, 2) = '41'  THEN 'CLP' ELSE  pf.MonedaActiva END 
			, 'Diferencia'       = cc.saldoContable  - (cc.saldoIBS - 0) -- saldoHaber)
			, 'Grupo'            = pf.Producto + ' ' + pf.MonedaPasiva + '-' +  pf.MonedaActiva 
			--, 'Nombre'	=  'BFW'
	FROM    dbo.CuadraturaContableDerivados  AS cc   with (nolock) INNER JOIN
            BacParamSuda.dbo.PLAN_DE_CUENTA AS pc  with (nolock) ON cc.codIBS = CONVERT(FLOAT, pc.cuenta) INNER JOIN
            dbo.Parametros_Detalle_Forwards AS pf with (nolock)  ON cc.codIBS = pf.CodIBS INNER JOIN
            BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS pd with (nolock) ON pf.CarteraNormativa = pd.tbcodigo1
	WHERE   (pd.tbcateg = 1111)
		--	AND cc.codIBS IN(212801014, 212801032)  --<> 212801017


	UNION
	-- SWAP
	SELECT    'CodIBS'		     = cc.codIBS
			, 'NombreCuenta'	 = pc.descripcion
			, 'TipoCuenta'       = pc.tipo_cuenta
			, 'SaldoCartera'     = cc.saldoContable
			, 'Producto'	     = CASE  WHEN TipoSwap = 1 THEN 'FORWARD RATE AGREETMEN'
										 WHEN TipoSwap = 2 THEN 'SWAP DE MONEDAS'
										 WHEN TipoSwap = 3 THEN 'SWAP PROMEDIO CAMARA'
										 WHEN TipoSwap = 4 THEN 'SWAP DE TASAS'END
			, 'CarteraNormativa' = pd.tbglosa
			, 'SaldoContable'	 = ABS(cc.saldoIBS) 
			, 'Moneda'			 = cc.Moneda
			, 'Diferencia'       = cc.saldoContable  - (cc.saldoIBS - 0) -- saldoHaber) 
			, 'Grupo'            = CASE  WHEN TipoSwap = 1 THEN 'FORWARD RATE AGREETMEN ' + CASE WHEN ps.MonedaActiva = '0' THEN '' ELSE ps.MonedaActiva END	+ ' ' +  CASE WHEN ps.MonedaPasiva = '0' THEN '' ELSE ps.MonedaPasiva END
										 WHEN TipoSwap = 2 THEN 'SWAP DE MONEDAS ' +  CASE WHEN ps.MonedaActiva = '0' THEN '' ELSE ps.MonedaActiva END	+ ' ' +  CASE WHEN ps.MonedaPasiva = '0' THEN '' ELSE ps.MonedaPasiva END
										 WHEN TipoSwap = 3 THEN 'SWAP PROMEDIO CAMARA ' +  CASE WHEN ps.MonedaActiva = '0' THEN '' ELSE ps.MonedaActiva END	+ ' ' +  CASE WHEN ps.MonedaPasiva = '0' THEN '' ELSE ps.MonedaPasiva END
										 WHEN TipoSwap = 4 THEN 'SWAP DE TASAS ' +  CASE WHEN ps.MonedaActiva = '0' THEN '' ELSE ps.MonedaActiva END	+ ' ' +  CASE WHEN ps.MonedaPasiva = '0' THEN '' ELSE ps.MonedaPasiva END 
									END
		--	, 'Nombre'	=  'SWAP'
	FROM   dbo.CuadraturaContableDerivados AS cc with (nolock)  INNER JOIN
		   BacParamSuda.dbo.PLAN_DE_CUENTA AS pc with (nolock)  ON  cc.codIBS = CONVERT(FLOAT, pc.cuenta) INNER JOIN
		   dbo.Parametros_Detalle_Swap AS ps with (nolock) ON cc.codIBS = ps.CodIBS INNER JOIN
		   BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS pd with (nolock)  ON ps.CarteraNormativa = pd.tbcodigo1
	WHERE  (pd.tbcateg = 1111)


    UNION

	---- OPCIONES
	SELECT     'CodIBS'		        =   o.CodIBS
			, 'NombreCuenta'	 	=	pc.descripcion
			, 'TipoCuenta'       	=	pc.tipo_cuenta 
			, 'SaldoCartera'     	=	cc.saldoContable
			, 'Producto'	     	=	UPPER(ope.OpcEstDsc)
			, 'CarteraNormativa' 	=	''
			, 'SaldoContable'	 	=	ABS(cc.saldoIBS)
			, 'Moneda'			 	=	cc.Moneda
			, 'Diferencia'       	=	cc.saldoContable  - ABS(cc.saldoIBS)
			, 'Grupo'            	=   UPPER(ope.OpcEstDsc) + ' CLP'
	--		, 'Nombre'	=  'OPCIONES'	
	FROM        dbo.Parametros_Detalle_Opciones AS o with (nolock) INNER JOIN
                BacParamSuda.dbo.PLAN_DE_CUENTA AS pc with (nolock) ON o.CodIBS = CONVERT(FLOAT, pc.cuenta) INNER JOIN
                dbo.CuadraturaContableDerivados AS cc with (nolock) ON o.CodIBS = cc.codIBS INNER JOIN
                CbMdbOpc.dbo.OpcionEstructura AS ope with (nolock) ON o.EstructuraCod = ope.OpcEstCod
   
   UNION 


   -- FORWARD ASIATICO
	 SELECT   'CodIBS'		        =   fa.CodIBS
			, 'NombreCuenta'	 	=	pc.descripcion
			, 'TipoCuenta'       	=	pc.tipo_cuenta
			, 'SaldoCartera'     	=	cc.saldoContable
			, 'Producto'	     	=	UPPER(ope.OpcEstDsc)
			, 'CarteraNormativa' 	=	''
			, 'SaldoContable'	 	=	ABS(cc.saldoIBS)
			, 'Moneda'			 	=	cc.Moneda
			, 'Diferencia'       	=	cc.saldoContable  - ABS(cc.saldoIBS)
			, 'Grupo'            	=   UPPER(ope.OpcEstDsc) + ' CLP'
	--		, 'Nombre'	=  'FORWARD ASIATICO'
	FROM    dbo.Parametros_Detalle_BFWAsisatico AS fa  with (nolock) INNER JOIN
            CbMdbOpc.dbo.OpcionEstructura AS ope  with (nolock) ON fa.EstructuraCod = ope.OpcEstCod INNER JOIN
            BacParamSuda.dbo.PLAN_DE_CUENTA AS pc with (nolock) ON CONVERT(FLOAT, fa.CodIBS) = pc.cuenta INNER JOIN
            dbo.CuadraturaContableDerivados AS cc with (nolock) ON fa.CodIBS = cc.codIBS

	UNION

	 -- RENTA FIJA
	 -- SELECT rf.CodIBS, pc.descripcion AS NombreCuenta, pc.tipo_cuenta AS TipoCuenta, rf.Cartera, cc.saldoContable, cc.saldoIBS, cc.Moneda
	  SELECT  'CodIBS'		        =    rf.CodIBS
			, 'NombreCuenta'	 	=	pc.descripcion
			, 'TipoCuenta'       	=	pc.tipo_cuenta
			, 'SaldoCartera'     	=	cc.saldoContable
			, 'Producto'	     	=	''
			, 'CarteraNormativa' 	=	''
			, 'SaldoContable'	 	=	ABS(cc.saldoIBS)
			, 'Moneda'			 	=	cc.Moneda
			, 'Diferencia'       	=	cc.saldoContable  - ABS(cc.saldoIBS)
			, 'Grupo'            	=   ''-- UPPER(ope.OpcEstDsc) + ' CLP'
	--		, 'Nombre'	=  'RENTA FIJA'
      FROM   dbo.Parametros_Detalle_RentaFija AS rf WITH (nolock) INNER JOIN
             BacParamSuda.dbo.PLAN_DE_CUENTA AS pc WITH (nolock) ON CONVERT(FLOAT, rf.CodIBS) = pc.cuenta INNER JOIN
             dbo.CuadraturaContableDerivados AS cc WITH (nolock) ON rf.CodIBS = cc.codIBS
	  WHERE        (rf.Sistema = 'BTR')
	
	UNION
	 -- RENTA FIJA EXTERIOR
	 SELECT  'CodIBS'		        =    rf.CodIBS
			, 'NombreCuenta'	 	=	pc.descripcion
			, 'TipoCuenta'       	=	pc.tipo_cuenta
			, 'SaldoCartera'     	=	cc.saldoContable
			, 'Producto'	     	=	''
			, 'CarteraNormativa' 	=	''
			, 'SaldoContable'	 	=	ABS(cc.saldoIBS)
			, 'Moneda'			 	=	cc.Moneda
			, 'Diferencia'       	=	cc.saldoContable  - ABS(cc.saldoIBS)
			, 'Grupo'            	=   ''-- UPPER(ope.OpcEstDsc) + ' CLP'
	--		, 'Nombre'	=  'RENTA FIJA EXTERIOR'
	 FROM    dbo.Parametros_Detalle_RentaFija AS rf WITH (nolock) INNER JOIN
             BacParamSuda.dbo.PLAN_DE_CUENTA AS pc WITH (nolock) ON CONVERT(FLOAT, rf.CodIBS) = pc.cuenta INNER JOIN
             dbo.CuadraturaContableDerivados AS cc WITH (nolock) ON rf.CodIBS = cc.codIBS
	 WHERE   (rf.Sistema = 'BTREX')

	 UNION

	 -- PACTOS
 	SELECT   'CodIBS'		    =   p.CodIBS
		  , 'NombreCuenta'	 	=	pc.descripcion
		  , 'TipoCuenta'       	=	pc.tipo_cuenta
		  , 'SaldoCartera'     	=	cc.saldoContable
		  , 'Producto'	     	=	''
		  , 'CarteraNormativa' 	=	p.Cartera
		  , 'SaldoContable'	 	=	ABS(cc.saldoIBS)
		  , 'Moneda'			=	cc.Moneda 
		  , 'Diferencia'       	=	cc.saldoContable  - ABS(cc.saldoIBS)
		  , 'Grupo'            	=   p.Cartera
	--	  , 'Nombre'	=  'PACTOS'
	FROM  dbo.Parametros_Detalle_Pactos AS p WITH (nolock) INNER JOIN
          dbo.CuadraturaContableDerivados AS cc ON p.CodIBS = cc.codIBS INNER JOIN
          BacParamSuda.dbo.PLAN_DE_CUENTA AS pc WITH (nolock) ON CONVERT(FLOAT, p.CodIBS) = pc.cuenta

END  

GO
