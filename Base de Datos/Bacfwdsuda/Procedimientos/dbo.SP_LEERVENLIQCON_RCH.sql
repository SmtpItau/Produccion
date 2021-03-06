USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERVENLIQCON_RCH]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERVENLIQCON_RCH]  
AS    
BEGIN    
  
   SET NOCOUNT ON  
  
   DECLARE @dFechaProceso   DATETIME  
       SET @dFechaProceso   = '20200128'--( SELECT acfecproc FROM BacFwdSuda.dbo.MFAC with(nolock) )  
  
   DECLARE @cfecha          CHAR(8)    
       SET @cfecha          = CONVERT(CHAR(8), @dFechaProceso, 112)  
    
	DECLARE @dValorDO	NUMERIC(21,4)
	SELECT	@dValorDO	= vmvalor
	FROM	BacParamSuda.dbo.VALOR_MONEDA
	WHERE	vmfecha				=   ( SELECT acfecproc FROM BacFwdSuda.dbo.MFAC )
	AND		vmcodigo			= 994
    
   SELECT 'operacion'       = (CASE WHEN var_moneda2 > 0 THEN var_moneda2 ELSE canumoper END)    
      ,   'montocompensado' = SUM(camtocomp)     
     INTO #tmpcomp  
     FROM MFCARES  
    WHERE cafecvcto         = @dFechaProceso  
    and     CaFechaProceso = @dFechaProceso
 GROUP BY (CASE WHEN var_moneda2 > 0 THEN var_moneda2 ELSE canumoper END)    
  
	UPDATE	#tmpcomp
	SET		montocompensado		= ROUND(montocompensado / @dValorDO, 4)
	FROM	MFCARES
	WHERE	canumoper			= operacion
	AND		cacodpos1			= 1
	AND		var_moneda2			= 0
	AND		cacalcmpdol			= 13
	and     CaFechaProceso = @dFechaProceso
  
   SELECT 'cfecha'          = @cfecha    
   ,      'canumoper'       = ISNULL(a.canumoper, 0)    
   ,      'catipoper'       = ISNULL(a.catipoper,'')                               
   ,      'fecha'           = ISNULL(CONVERT(CHAR(10),a.cafecha,103),'')    
   ,      'rcnombre'        = ISNULL(RTRIM(b.rcnombre),'')    
  
   ,      'clnombre'        = ISNULL(d.clnombre,'')    
   ,      'mnnemo'          = ISNULL(e.mnnemo,'')    
   ,      'camtomon1'       = ISNULL(a.camtomon1,0.0)    
   ,      'cacodps'         = CASE WHEN a.cacodpos1 = 1 AND a.caantici  = 'A'                   THEN CONVERT(NUMERIC(21,4),ISNULL(a.camtoliq ,0.0))    
                                   WHEN a.cacodpos1 = 2 AND a.catipoper = 'C' AND d.clpais <> 6 THEN CONVERT(NUMERIC(21,4),ISNULL(t.montocompensado ,0.0)) -- CONVERT(NUMERIC(21,4),ISNULL(a.camtocomp,0.0))     
                                   WHEN a.cacodpos1 = 2 AND a.catipoper = 'V' AND d.clpais <> 6 THEN CONVERT(NUMERIC(21,4),ISNULL(t.montocompensado ,0.0)) -- CONVERT(NUMERIC(21,4),ISNULL(a.camtocomp,0.0))     
                                   ELSE                                                              CONVERT(NUMERIC(21,4),ISNULL(t.montocompensado ,0.0)) -- CONVERT(NUMERIC(21,4),ISNULL(a.camtocomp,0.0))    
                              END  
   ,      'tiptransac'      = CASE WHEN a.catipoper = 'C' THEN 'Compra ' ELSE 'Venta ' END    
                            + SUBSTRING(RTRIM(LTRIM(e.mnglosa)),1,25) + '/' + SUBSTRING(RTRIM(LTRIM(m.mnglosa)),1,25)    
   ,      'mdatransac'      = RTRIM(LTRIM(e.mnglosa)) + '/' + RTRIM(LTRIM(m.mnglosa))    
   ,      'montoc'          = CASE WHEN a.catipoper = 'C' THEN a.camtomon1     
                                   ELSE                        a.camtomon2     
                              END    
   ,      'catipcam'        = ISNULL(a.catipcam,0)    
   ,      'montov'          = CASE WHEN a.catipoper = 'V' THEN a.camtomon1    
                                   ELSE                        a.camtomon2    
                              END    
   ,      'pesos'           = CASE WHEN a.cacodpos1 = 2   THEN ROUND(a.camtomon2 * f.vmvalor,0)   
                                   ELSE                        a.caclpmoneda2     
                              END    
   ,      'pagomx'          = ISNULL(i.glosa,'')    
   ,      'pagomn'          = ISNULL(u.glosa,'')    
   ,      'catipmoda'       = ISNULL(a.catipmoda,'')    
   ,      'Nemo1'           = ISNULL(e.mnnemo,'')    
   ,      'Nemo2'           = ISNULL(m.mnnemo,'')    
   ,      'MonedaCompra'    = CASE WHEN a.catipoper = 'C' THEN e.mnnemo ELSE m.mnnemo END    
   ,      'MonedaVenta'     = CASE WHEN a.catipoper = 'C' THEN m.mnnemo ELSE e.mnnemo END    
   ,      'clPais'          = clpais    
   ,      'Numero_Producto' = a.cacodpos1    
   ,      'Descripcion_Prod'= ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE  codigo_producto = a.cacodpos1 ),'')    
   ,      'Tasa_Mercado'    = caprecal    
   ,      'Compensacion'    = ISNULL(t.montocompensado, 0)  
   ,      'DV01'            = catasacon     
   ,      'MdaOri'          = CASE WHEN a.cacalcmpdol	= 13	THEN 'US$ '
								   WHEN a.cacodpos1		= 3		THEN '$ '
                                   WHEN d.Cltipcli  = 2 THEN 'US$ '   
                                   ELSE '$ '   
                              END  
   FROM   MFCARES                                  a    
          LEFT JOIN BacParamSuda..CLIENTE       d ON a.cacodigo                   = d.clrut     AND a.cacodcli  = d.clcodigo    
          LEFT JOIN BacParamSuda..MONEDA     e ON a.cacodmon1                  = e.mncodmon    
          LEFT JOIN BacParamSuda..MONEDA        m ON a.cacodmon2                  = m.mncodmon    
          LEFT JOIN BacParamSuda..TIPO_CARTERA  b ON CONVERT(CHAR(5),a.cacodpos1) = b.rccodpro  AND a.cacodcart = b.rcrut    
          LEFT JOIN BacParamSuda..VALOR_MONEDA  f ON f.vmfecha                    = a.cafecvcto AND f.vmcodigo  = 994    
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO i ON i.codigo                     = a.cafpagomx    
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO u ON u.codigo         = a.cafpagomn    
          LEFT JOIN #tmpcomp                    t ON t.operacion      = a.canumoper    
   ,      MFAC                                  g    
   WHERE  a.cafecvcto       = g.acfecproc  
   AND    a.cacodpos1       IN(1, 2, 3, 10, 11, 14)    
   AND not (a.cacodpos1     = 1 and var_moneda2 > 0)    
   AND    a.caantici       <>  'A'     
   AND    a.var_moneda2     = 0  
   AND    a.CaFechaProceso = @dFechaProceso
   UNION    
    
   SELECT 'cfecha'         = @cfecha    
   ,      'canumoper'      = ISNULL(a.canumoper, 0)    
   ,      'catipoper'      = ISNULL(a.catipoper,'')                               
   ,      'fecha'          = ISNULL(CONVERT(CHAR(10),a.cafecha,103),'')    
   ,      'rcnombre'       = ISNULL(RTRIM(b.rcnombre),'')    
   ,      'clnombre'       = ISNULL(d.clnombre,'')    
   ,      'mnnemo'         = ISNULL(e.mnnemo,'')    
   ,      'camtomon1'      = ISNULL(a.camtomon1,0.0)    
   ,      'cacodps'        = CASE WHEN a.cacodpos1 = 1 AND a.caantici  = 'A'                   THEN CONVERT(NUMERIC(21,4),ISNULL(a.camtoliq ,0.0))    
                                  WHEN a.cacodpos1 = 2 AND a.catipoper = 'C' AND d.clpais <> 6 THEN CONVERT(NUMERIC(21,4),ISNULL(t.montocompensado ,0.0)) -- CONVERT(NUMERIC(21,4),ISNULL(a.camtocomp,0.0))     
                                  WHEN a.cacodpos1 = 2 AND a.catipoper = 'V' AND d.clpais <> 6 THEN CONVERT(NUMERIC(21,4),ISNULL(t.montocompensado ,0.0)) -- CONVERT(NUMERIC(21,4),ISNULL(a.camtocomp,0.0))     
                                  ELSE                                                              CONVERT(NUMERIC(21,4),ISNULL(t.montocompensado ,0.0)) -- CONVERT(NUMERIC(21,4),ISNULL(a.camtocomp,0.0))    
                             END    
   ,      'tiptransac'     = CASE WHEN a.catipoper = 'C' THEN 'Compra ' ELSE 'Venta ' END    
                           + SUBSTRING(RTRIM(LTRIM(e.mnglosa)),1,25) + '/' + SUBSTRING(RTRIM(LTRIM(m.mnglosa)),1,25)    
   ,      'mdatransac'     = RTRIM(LTRIM(e.mnglosa)) + '/' + RTRIM(LTRIM(m.mnglosa))    
   ,      'montoc'         = CASE WHEN a.catipoper = 'C' THEN a.camtomon1     
                                ELSE                        a.camtomon2     
                           END    
   ,      'catipcam'        = ISNULL(a.catipcam,0)    
   ,      'montov'          = CASE WHEN a.catipoper = 'V' THEN a.camtomon1    
                                ELSE                        a.camtomon2    
                           END    
   ,      'pesos'           = CASE WHEN a.cacodpos1 = 2   THEN ROUND(a.camtomon2 * f.vmvalor,0)     
                                ELSE                              a.caclpmoneda2     
                              END    
   ,      'pagomx'          = ISNULL(i.glosa,'')    
   ,      'pagomn'          = ISNULL(u.glosa,'')    
   ,      'catipmoda'       = ISNULL(a.catipmoda,'')    
   ,      'Nemo1'           = ISNULL(e.mnnemo,'')    
   ,      'Nemo2'           = ISNULL(m.mnnemo,'')    
   ,      'MonedaCompra'    = CASE WHEN a.catipoper = 'C' THEN e.mnnemo ELSE m.mnnemo END    
   ,      'MonedaVenta'     = CASE WHEN a.catipoper = 'C' THEN m.mnnemo ELSE e.mnnemo END    
   ,      'clPais'          = clpais    
   ,      'Numero_Producto' = a.cacodpos1    
   ,      'Descripcion_Prod'= ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE  codigo_producto = a.cacodpos1 ),'')    
,      'Tasa_Mercado'    = caprecal    
   ,      'Compensacion'    = ISNULL(t.montocompensado, 0) -- camtocomp    
   ,      'DV01'           = catasacon     
--   ,      'MdaOri'       = e.mnsimbol     
   ,      'MdaOri'          = case when d.Cltipcli = 2 then 'US$ ' else '$ ' end    
   FROM   MFCARES                                  a    
          LEFT JOIN BacParamSuda..CLIENTE       d ON a.cacodigo                   = d.clrut     AND a.cacodcli  = d.clcodigo    
          LEFT JOIN BacParamSuda..MONEDA        e ON a.cacodmon1                  = e.mncodmon    
          LEFT JOIN BacParamSuda..MONEDA        m ON a.cacodmon2                  = m.mncodmon    
          LEFT JOIN BacParamSuda..TIPO_CARTERA  b ON CONVERT(CHAR(5),a.cacodpos1) = b.rccodpro  AND a.cacodcart = b.rcrut    
          LEFT JOIN BacParamSuda..VALOR_MONEDA  f ON f.vmfecha                    = a.cafecvcto AND f.vmcodigo  = 994    
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO i ON i.codigo                     = a.cafpagomx    
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO u ON u.codigo                     = a.cafpagomn    
          LEFT JOIN #tmpcomp                    t ON t.operacion                         = a.canumoper    
   ,      MFAC                                  g    
   ,      TBL_CARTERA_FLUJOS   FLU    
   WHERE  a.cacodpos1   = 13     
   AND    FLU.Ctf_Fecha_Vencimiento = @cfecha    
   AND    a.canumoper   = FLU.Ctf_Numero_OPeracion    
   AND not (a.cacodpos1 = 1 and var_moneda2 > 0)    
  AND    a.CaFechaProceso = @dFechaProceso
   UNION  
  
   SELECT 'cFecha'          = @cFecha  
      ,   'canumoper'       = car.canumoper  
      ,   'catipoper'       = car.catipoper  
      ,   'fecha'           = CONVERT(CHAR(10), car.cafecha, 103)  
      ,   'rcnombre'        = isnull( tca.rcnombre, '')  
      ,   'clnombre'        = isnull( cli.clnombre, '')    
      ,   'mnnemo'          = isnull( mon.mnnemo, '')  
      ,   'camtomon1'       = isnull( car.camtomon1, 0.0)  
      ,   'cacodps'         = ISNULL( isnull( car.camtocomp, 0.0) + isnull( cap.camtocomp, 0.0), 0.0)  
      ,   'tiptransac'      = CASE WHEN car.catipoper = 'C' THEN 'Compra ' ELSE 'Venta ' END  
                            + SUBSTRING( ltrim(rtrim( mon.mnglosa )) + '/' + ltrim(rtrim( pes.mnglosa )), 1, 50)  
      ,   'mdatransac'      = ltrim(rtrim( mon.mnglosa )) + '/' + ltrim(rtrim( pes.mnglosa ))  
      ,   'montoc'          = CASE WHEN car.catipoper = 'C' THEN car.camtomon1 ELSE car.camtomon2 END  
      ,   'catipcam'        = isnull( car.catipcam, 0 )  
      ,   'montov'          = CASE WHEN car.catipoper = 'V' THEN car.camtomon1   ELSE car.camtomon2 END    
      ,   'pesos'           = ROUND(  car.camtomon2 * cap.catipcam, 0) --> 170.560.575 --> ROUND( car.camtomon2 * dol.vmvalor,0) --> 482.73  
      ,   'pagomx'          = ISNULL( fp1.glosa, '')    
      ,   'pagomn'          = ISNULL( fp2.glosa, '')    
      ,   'catipmoda'       = ISNULL( car.catipmoda, '')    
      ,   'Nemo1'           = ISNULL( mon.mnnemo, '')    
      ,   'Nemo2'           = ISNULL( pes.mnnemo, '')    
  
      ,   'MonedaCompra'    = CASE WHEN car.catipoper = 'C' THEN mon.mnnemo ELSE pes.mnnemo END    
      ,   'MonedaVenta'     = CASE WHEN car.catipoper = 'C' THEN pes.mnnemo ELSE mon.mnnemo END    
      ,   'clPais'          = cli.clpais    
      ,   'Numero_Producto' = car.cacodpos1    
      ,   'Descripcion_Prod'= CONVERT(CHAR(50), 'ARBITRAJE MONEDA MX-CLP' )  
      ,   'Tasa_Mercado'    = car.caprecal  
      ,   'Compensacion'    = ISNULL( isnull( car.camtocomp, 0.0) + isnull( cap.camtocomp, 0.0), 0.0)  
      ,   'DV01'            = car.catasacon    
      ,   'MdaOri'          = CASE WHEN cli.cltipcli = 2 THEN 'US$ ' ELSE '$ ' END  
     FROM BacFwdSuda.dbo.MFCARES                       car  
          INNER JOIN BacFwdSuda.dbo.MFCARES            cap ON  cap.CaFechaProceso = @dFechaProceso and cap.var_moneda2 = car.var_moneda2 AND cap.cacodpos1 = 1  
          LEFT  JOIN BacParamSuda.dbo.TIPO_CARTERA  tca ON tca.rcsistema   = 'BFW'           AND tca.rcrut     = car.cacodcart AND tca.rccodpro = CONVERT(CHAR(3), car.cacodpos1)  
          LEFT  JOIN BacParamSuda.dbo.CLIENTE       cli ON cli.clrut       = car.cacodigo    AND cli.clcodigo  = car.cacodcli  
          LEFT  JOIN BacParamSuda.dbo.MONEDA        mon ON mon.mncodmon    = car.cacodmon1  
          LEFT  JOIN BacParamSuda.dbo.MONEDA        pes ON pes.mncodmon    = 999  
          LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA  dol ON dol.vmfecha     = car.cafecvcto   AND dol.vmcodigo  = 994  
          LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO fp1 ON fp1.codigo      = car.cafpagomx  
          LEFT  JOIN BacParamSuda.dbo.FORMA_DE_PAGO fp2 ON fp2.codigo      = car.cafpagomn  
    WHERE car.cafecvcto   = @dFechaProceso  
      AND car.var_moneda2 > 0  
      AND car.cacodpos1   = 2  
  AND    car.CaFechaProceso = @dFechaProceso
END 
   

--go

--exec SP_LEERVENLIQCON_RCH

--go
GO
