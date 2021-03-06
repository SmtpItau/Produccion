USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CuadraturaCont_ObtieneCriterio]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE PROCEDURE [dbo].[CuadraturaCont_ObtieneCriterio] (@Sistema VARCHAR(10))
AS
 

IF @Sistema = 'BFW'
BEGIN

  SELECT  IDDetalleParametros 
		, c.Sistema
		, CodIBS      
		, Producto  
		, 'IdMonedaActiva'   =  c.MonedaActiva
		, 'IdMonedaPasiva'   =  c.MonedaPasiva
		, 'MonedaActiva'     =  m.mnglosa 
		, 'MonedaPasiva'     =  m_pas.mnglosa 
		, 'IdTipoOperacion'  =  TipoOperacion
		, 'TipoOperacion'    =  CASE WHEN TipoOperacion    = 'V' THEN 'VENTA' 
							         WHEN TipoOperacion    = 'C' THEN 'COMPRA' 
									 WHEN TipoOperacion    = 'M' THEN 'COMPRA/VENTA'  END
		, 'IdCartNormativa'  =  c.CarteraNormativa
		, 'CarteraNormativa' =  cn.tbglosa
		, 'IdTipoCriterio'   =  c.TipoCriterio
		, 'TipoCriterio'     =  UPPER(tc.nombre)
   FROM     dbo.Parametros_Detalle_Forwards AS c INNER JOIN
			BacParamSuda.dbo.MONEDA AS m ON c.MonedaActiva = m.mnnemo INNER JOIN
			BacParamSuda.dbo.MONEDA AS m_pas ON c.MonedaPasiva = m_pas.mnnemo INNER JOIN
			BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS cn ON c.CarteraNormativa = cn.tbcodigo1 INNER JOIN 
			dbo.Parametros_TipoCriterio tc ON c.TipoCriterio = tc.IdTipoCriterio
    WHERE c.Sistema = @Sistema  AND (cn.tbcateg = 1111) 
    ORDER BY IDDetalleParametros

 END 

 
IF @Sistema = 'PCS'
BEGIN
	 	SELECT    c.IDDetalleParametros
				, 'Sistema'            = c.Sistema
				, 'CodIBS'             = c.CodIBS 
				, 'IdTipoSwap'         = TipoSwap
				, 'TipoSwap'           = CASE WHEN TipoSwap = '1' THEN 'IRS' WHEN TipoSwap = '2' THEN 'CCS' WHEN TipoSwap = '4' THEN 'SPC' END 
				--, 'IdTipoFlujo'        = c.TipoFlujo
				--, 'TipoFlujo'          = CASE WHEN c.TipoFlujo = '1' THEN 'ACTIVO' WHEN c.TipoFlujo = '2' THEN 'PASIVO' END 			
				, 'IdMonedaActiva'     = ISNULL(c.MonedaActiva, 0)
				, 'MonedaActiva'       = ISNULL(m.mnglosa,'TODOS')
				, 'IdMonedaPasiva'     = ISNULL(c.MonedaPasiva,0)		
				, 'MonedaPasiva'       = ISNULL(m_pas.mnglosa,'TODOS')
				, 'IdCarteraNormativa' = CarteraNormativa 
				, 'CarteraNormativa'   = cn.tbglosa
				, 'IdTipoCriterio'     = c.TipoCriterio
				, 'TipoCriterio'       = UPPER(tc.nombre)
		FROM  dbo.Parametros_Detalle_Swap AS c LEFT OUTER JOIN
			  BacParamSuda.dbo.MONEDA AS m_pas ON c.MonedaPasiva = m_pas.mnnemo LEFT OUTER JOIN
			  BacParamSuda.dbo.MONEDA AS m ON c.MonedaActiva = m.mnnemo INNER JOIN 
			  dbo.Parametros_TipoCriterio tc ON c.TipoCriterio = tc.IdTipoCriterio INNER JOIN
			BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS cn ON c.CarteraNormativa = cn.tbcodigo1
		WHERE (cn.tbcateg = 1111) 

END


 IF @Sistema = 'OPT'
 BEGIN
	
		SELECT IDDetalleParametros
		 , 'Sistema'         = Sistema
		 , 'CodIBS'          = CodIBS
		 , 'IdEstadoCod'     = EstadoCod     
		 , 'EstadoCod'       = opEst.ConOpcEstDsc
		 , 'IdEstructuraCod' = EstructuraCod    
		 , 'EstructuraCod'   = ope.OpcEstDsc 
		 , 'IdCallPut'       = o.CallPut
		 , 'CallPut'         = tgd.tbglosa
		 , 'IdCompraVenta'   = o.CompraVenta
		 , 'CompraVenta'     = tgd2.tbglosa
		 , 'IdTipoCriterio'  = o.TipoCriterio 
		 , 'TipoCriterio'    = UPPER(tc.nombre)
FROM    dbo.Parametros_Detalle_Opciones AS o INNER JOIN
        BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS tgd ON o.CallPut = tgd.tbcodigo1 INNER JOIN
        dbo.Parametros_TipoCriterio AS tc ON tc.IdTipoCriterio = o.TipoCriterio INNER JOIN
        BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS tgd2 ON o.CompraVenta = tgd2.tbcodigo1 INNER JOIN
        CbMdbOpc.dbo.OpcionEstructura AS ope ON o.EstructuraCod = ope.OpcEstCod INNER JOIN
        CbMdbOpc.dbo.ConOpcEstado AS opEst ON CASE WHEN o.EstadoCod = 'V' THEN '' ELSE o.EstadoCod END = opEst.ConOpcEstCod  
WHERE        (tgd.tbcateg = 810) AND (tgd2.tbcateg = 2651)



END 

 IF @Sistema = 'BFWAS'
 BEGIN

	 SELECT   IDDetalleParametros
		    , 'Sistema'          = Sistema
		    , 'CodIBS'           = CodIBS
		    , 'IdCartNormativa'  = fa.CarteraNormativa
		    , 'CarteraNormativa' = tgd.tbglosa
		    , 'IdEstructuraCod'  = EstructuraCod    
		    , 'EstructuraCod'    = ope.OpcEstDsc 
		    , 'IdCompraVenta'    = fa.CompraVenta
		    , 'CompraVenta'      = tgd2.tbglosa
			, 'IdTipoCriterio'   = fa.TipoCriterio 
		    , 'TipoCriterio'     = UPPER(tc.nombre)	  
	 FROM Parametros_Detalle_BFWAsisatico fa 
	      INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS tgd ON fa.CarteraNormativa = tgd.tbcodigo1 
		  INNER JOIN dbo.Parametros_TipoCriterio AS tc ON tc.IdTipoCriterio = fa.TipoCriterio INNER JOIN
		   (SELECT tbcodigo1, tbglosa 
			FROM   BacParamSuda.dbo.TABLA_GENERAL_DETALLE
			WHERE  tbcateg = 2651
			UNION
			SELECT '3', 'COMPRA/VENTA') AS tgd2 ON fa.CompraVenta = tgd2.tbcodigo1 INNER JOIN 
		  CbMdbOpc.dbo.OpcionEstructura ope ON fa.EstructuraCod = ope.OpcEstCod
		 --  INNER JOIN CbMdbOpc.dbo.ConOpcEstado AS opEst ON CASE WHEN fa.EstadoCod = 'V' THEN '' ELSE fa.EstadoCod END = opEst.ConOpcEstCod
     WHERE    (tgd.tbcateg = 1111) --(tgd2.tbcateg = 2651) AND 
END

 IF @Sistema = 'BTR'  -- Renta Fija
 BEGIN

   	 SELECT     IDDetalleParametros
			  , 'Sistema'             = Sistema
			  , 'CodIBS'              = CodIBS
			  , 'IdCartera'           = Cartera     
			  , 'Cartera'             = tgd.tbglosa  
			  , 'IdMoneda'            = Moneda
		      , 'Moneda'              = ISNULL(m.mnglosa,'TODOS')			 
			  , 'IdTipoEmisor'        = TipoEmisor			
			  , 'TipoEmisor'          = e.emnombre
			  , 'IdTipoInstrumento'   = TipoInstrumento 
			  , 'TipoIntrumento'      = i.inglosa 
			  , 'IdTipoCriterio'      = rf.TipoCriterio 
		      , 'TipoCriterio'        = UPPER(tc.nombre)  
	 FROM Parametros_Detalle_RentaFija rf
		 INNER JOIN BacParamSuda..INSTRUMENTO i 
		 ON rf.TipoInstrumento = i.inserie INNER JOIN
		 Parametros_TipoCriterio AS tc ON tc.IdTipoCriterio = rf.TipoCriterio  LEFT OUTER JOIN
		 BacParamSuda.dbo.MONEDA AS m ON rf.Moneda = m.mnnemo  INNER JOIN
		 BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS tgd ON rf.Cartera = tgd.tbcodigo1 INNER JOIN  BacParamSuda..EMISOR e ON
		 e.emrut = rf.TipoEmisor 
	WHERE Sistema = @Sistema AND (tgd.tbcateg = '1111')

 END
 
 IF @Sistema = 'BTREX' -- Renta Fija Ext.
 BEGIN
   SELECT     IDDetalleParametros
			  , 'Sistema'             = Sistema
			  , 'CodIBS'              = CodIBS
			  , 'IdCartera'           = Cartera     
			  , 'Cartera'             = tgd.tbglosa  
			  , 'IdMoneda'            = Moneda
		      , 'Moneda'              = ISNULL(m.mnglosa,'TODOS')			 
			  , 'IdTipoEmisor'        = TipoEmisor			
			  , 'TipoEmisor'          = emisor.tbglosa	
			  , 'IdTipoInstrumento'   = TipoInstrumento 
			  , 'TipoIntrumento'      = emisor.tbglosa
		      , 'IdTipoCriterio'      = rf.TipoCriterio 
		      , 'TipoCriterio'        = UPPER(tc.nombre)	  
	FROM        dbo.Parametros_Detalle_RentaFija AS rf INNER JOIN
				BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS tgd ON rf.Cartera = tgd.tbcodigo1 INNER JOIN
				BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS emisor ON CAST(rf.TipoEmisor AS CHAR(1)) = emisor.tbcodigo1 INNER JOIN
				dbo.Parametros_TipoCriterio AS tc ON rf.TipoCriterio = tc.IdTipoCriterio LEFT OUTER JOIN
				BacParamSuda.dbo.MONEDA AS m ON rf.Moneda = m.mnnemo
	WHERE        (rf.Sistema = 'BTREX') AND (tgd.tbcateg = 1111) AND (emisor.tbcateg = 210)
END
 
 IF @Sistema = 'PACTOS' -- Pactos
 BEGIN
   
	SELECT	p.IDDetalleParametros
		  , 'Sistema'        = p.Sistema
		  , 'CodIBS'         = p.CodIBS
		  , 'IdCartera'      = p.Cartera
		  , 'Cartera'        = tgdCartera.tbglosa  
		  , 'IdMoneda'       = p.Moneda
		  , 'Moneda'         = m.mnglosa
		  , 'IdSerie'        = ISNULL(p.Serie, 0)
		  , 'Serie'          = ISNULL(i.inglosa,'TODOS') 
		  , 'IdTipoCriterio' = p.TipoCriterio
		  , 'TipoCriterio'   = tc.nombre
		  , 'IdTipoCliente'  = p.TipoCliente
		  , 'TipoCliente'    = UPPER(tgd.tbglosa)
	FROM            dbo.Parametros_Detalle_Pactos AS p INNER JOIN
                         BacParamSuda.dbo.MONEDA AS m ON p.Moneda = m.mnnemo INNER JOIN
                         dbo.Parametros_TipoCriterio AS tc ON p.TipoCriterio = tc.IdTipoCriterio INNER JOIN
                         BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS tgd ON RTRIM(p.TipoCliente) = tgd.tbcodigo1 INNER JOIN
                         BacParamSuda.dbo.TABLA_GENERAL_DETALLE AS tgdCartera ON tgdCartera.tbcodigo1 = p.Cartera LEFT OUTER JOIN
                         BacParamSuda.dbo.INSTRUMENTO AS i ON p.Serie = i.inserie
	WHERE        (tgd.tbcateg = 72) AND (tgdCartera.tbcateg = 9921)

 END

 IF @Sistema = 'PASIVOS' -- Pasivos
 BEGIN
   
   SELECT IDDetalleParametros 
		  , 'Sistema'		 =  Sistema 
		  , 'CodIBS'         =  CodIBS
		  , 'NombreSerie'    =  NombreSerie
		  , 'Tipo_Bono'      =  Tipo_Bono 
		  , 'PlanCuenta'     =  PlanCuenta
		  , 'IdTipoCriterio' =  TipoCriterio
		  , 'TipoCriterio'   =  UPPER(tc.nombre)
   FROM dbo.Parametros_Detalle_Pasivos p INNER JOIN
        dbo.Parametros_TipoCriterio AS tc ON p.TipoCriterio = tc.IdTipoCriterio



 END

GO
