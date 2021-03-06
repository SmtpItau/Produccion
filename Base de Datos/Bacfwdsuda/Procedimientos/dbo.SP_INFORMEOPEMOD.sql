USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMEOPEMOD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INFORMEOPEMOD]
       (
         @cFechaDesde           CHAR(08)
       , @cFechaHasta           CHAR(08)
       )
AS
BEGIN  

    SET NOCOUNT ON   

    DECLARE @dFechaDesde        DATETIME
    DECLARE @dFechaHasta        DATETIME
    DECLARE @nombre             VARCHAR(50)

    SELECT @Nombre = RTRIM( LTRIM( rcnombre ) )
      FROM VIEW_ENTIDAD

    SET @dFechaDesde = CONVERT( DATETIME, @cFechaDesde )
    SET @dFechaHasta = CONVERT( DATETIME, @cFechaHasta )

    -- GUARDA EL REGISTRO BASE DE LA LOG 
    SELECT 'Numoper'           = a.canumoper
         , 'Nombre'            = b.clnombre
         , 'TipOper'           = a.catipoper
         , 'Plazo'             = a.caplazo
         , 'FecVen'            = CONVERT( CHAR(10), a.cafecvcto, 103 )
         , 'Nemo'              = ISNULL( c.mnnemo, ' ' )
         , 'MtoMex'            = a.camtomon1
         , 'Precio'            = CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.caprecal END
         , 'Preciofinal'       = a.catipcam
         , 'MtoCnv'            = a.camtomon2
         , 'Modal'             = a.catipmoda
         , 'FPMN'              = ISNULL( d.glosa, 'N/A' )
         , 'FPMX'              = ISNULL( e.glosa, 'N/A' )
         , 'Operador'          = a.caoperador
         , 'NomProp'           = @Nombre
          ,'FecPro'            = CONVERT( CHAR(10), f.acfecproc, 103 )
         , 'CodMon'            = g.mnnemo
         , 'CodCnv'            = h.mnnemo
         , 'Hora'              = a.cahora
         , 'Hora_reporte'      = CONVERT( CHAR(08), GETDATE(), 108 )
         , 'Estado'            = 'L'
         , 'Producto'          = i.codigo_producto
         , 'NombreProducto'    = i.descripcion
         , 'Fechaconsulta'     = CONVERT( CHAR(10), @dFechaDesde, 103 )
         , 'Fechahasta'        = CONVERT( CHAR(10), @dFechaHasta, 103 )
         , 'FechaModificacion' = CONVERT( CHAR(10), a.cafecmod, 103 )
         , 'FechaOperacion'    = CONVERT( CHAR(10), a.cafecha, 103 )
         , 'FechaEfectiva'     = CONVERT( CHAR(10), a.cafecEfectiva, 103 )
      INTO #temp_1 
      
	 /* FROM dbo.MFCA_LOG           a
         , dbo.VIEW_CLIENTE       b
         , dbo.VIEW_MONEDA        c
         , dbo.VIEW_FORMA_DE_PAGO d
         , dbo.VIEW_FORMA_DE_PAGO e
         , dbo.MFAC               f
         , dbo.VIEW_MONEDA        g
         , dbo.VIEW_MONEDA        h
         , dbo.VIEW_PRODUCTO      i 
     WHERE a.cafecmod  >= @dFechaDesde
       AND a.cafecmod  <= @dFechaHasta
       AND a.caestado   = 'M'
       AND a.cacodigo   =  b.clrut
       AND a.cacodcli   =  b.clcodigo
       AND a.cacodmon1 *=  c.mncodmon
       AND a.cafpagomn *=  d.codigo
       AND a.cafpagomx *=  e.codigo
       AND a.cacodmon1  =  g.mncodmon
       AND a.cacodmon2  =  h.mncodmon
       AND a.caprimero  = 'S'
       AND i.id_sistema = 'BFW'
       AND a.cacodpos1  = i.codigo_producto  */ 

		-- RQ 7619
      FROM dbo.MFCA_LOG a LEFT OUTER JOIN dbo.VIEW_MONEDA c ON a.cacodmon1 =  c.mncodmon
				LEFT OUTER JOIN dbo.VIEW_FORMA_DE_PAGO d ON a.cafpagomn =  d.codigo
				LEFT OUTER JOIN dbo.VIEW_FORMA_DE_PAGO e ON a.cafpagomx =  e.codigo
         , dbo.VIEW_CLIENTE       b
         , dbo.MFAC               f
         , dbo.VIEW_MONEDA        g
         , dbo.VIEW_MONEDA        h
         , dbo.VIEW_PRODUCTO      i 
      WHERE a.cafecmod  >= @dFechaDesde
       AND a.cafecmod  <= @dFechaHasta
       AND a.caestado   = 'M'
       AND a.cacodigo   =  b.clrut
       AND a.cacodcli   =  b.clcodigo
       AND a.cacodmon1  =  g.mncodmon
       AND a.cacodmon2  =  h.mncodmon
       AND a.caprimero  = 'S'
       AND i.id_sistema = 'BFW'
       AND a.cacodpos1  = i.codigo_producto    



 

    -- GUARDA EL RESTO DE LOS REGISTROS DE LA LOG 
    SELECT 'Numoper'           = a.canumoper
         , 'Nombre'            = b.clnombre
         , 'TipOper'           = a.catipoper
         , 'Plazo'             = a.caplazo
         , 'FecVen'            = CONVERT( CHAR(10), a.cafecvcto, 103 )
         , 'Nemo'              = ISNULL( c.mnnemo, ' ' )
         , 'MtoMex'            = a.camtomon1
         , 'Precio'            = CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.caprecal END
         , 'Preciofinal'       = a.catipcam
         , 'MtoCnv'            = a.camtomon2
         , 'Modal'             = a.catipmoda
         , 'FPMN'              = ISNULL( d.glosa,'N/A' )
         , 'FPMX'              = ISNULL( e.glosa,'N/A' )
         , 'Operador'          = a.caoperador
         , 'NomProp'           = @Nombre
         , 'FecPro'            = CONVERT( CHAR(10), f.acfecproc, 103 )
         , 'CodMon'            = g.mnnemo
         , 'CodCnv'            = h.mnnemo
         , 'Hora'              = a.cahora
         , 'Hora_reporte'      = CONVERT( CHAR(08), GETDATE(), 108 )
         , 'Estado'            = 'C'
         , 'Producto'          = i.codigo_producto
         , 'NombreProducto'    = i.descripcion
         , 'Fechaconsulta'     = CONVERT( CHAR(10), @dFechaDesde, 103 )
         , 'Fechahasta'        = CONVERT( CHAR(10), @dFechaHasta, 103 )
         , 'FechaModificacion' = CONVERT( CHAR(10), a.cafecmod, 103 )
         , 'FechaOperacion'    = CONVERT( CHAR(10), a.cafecha, 103 )
         , 'FechaEfectiva'     = CONVERT( CHAR(10), a.cafecEfectiva, 103 )
      INTO #temp_2 
      

	 /* FROM dbo.MFCA_LOG           a
         , dbo.VIEW_CLIENTE       b
         , dbo.VIEW_MONEDA        c
         , dbo.VIEW_FORMA_DE_PAGO d
         , dbo.VIEW_FORMA_DE_PAGO e
         , dbo.MFAC               f
         , dbo.VIEW_MONEDA        g
         , dbo.VIEW_MONEDA        h
         , dbo.VIEW_PRODUCTO      i
     WHERE a.cafecmod  >=  @dFechaDesde
       AND a.cafecmod   <= @dFechaHasta
       AND a.caestado   =  'M'
       AND a.cacodigo   =  b.clrut
       AND a.cacodcli   =  b.clcodigo
       AND a.cacodmon1 *=  c.mncodmon
       AND a.cafpagomn *=  d.codigo
       AND a.cafpagomx *=  e.codigo
       AND a.cacodmon1  =  g.mncodmon
       AND a.cacodmon2  =  h.mncodmon
       AND a.caprimero  = 'N'
       AND i.id_sistema = 'BFW'
       AND a.cacodpos1  = i.codigo_producto */

	-- RQ 7619
     FROM dbo.MFCA_LOG a LEFT OUTER JOIN dbo.VIEW_MONEDA  c ON a.cacodmon1 =  c.mncodmon
			 LEFT OUTER JOIN dbo.VIEW_FORMA_DE_PAGO d ON  a.cafpagomn =  d.codigo
			 LEFT OUTER JOIN dbo.VIEW_FORMA_DE_PAGO e ON  a.cafpagomx =  e.codigo
         , dbo.VIEW_CLIENTE       b
         , dbo.MFAC               f
         , dbo.VIEW_MONEDA        g
         , dbo.VIEW_MONEDA        h
         , dbo.VIEW_PRODUCTO      i
     WHERE a.cafecmod  >=@dFechaDesde
       AND a.cafecmod   <= @dFechaHasta
       AND a.caestado   =  'M'
       AND a.cacodigo   =  b.clrut
       AND a.cacodcli   =  b.clcodigo
       AND a.cacodmon1  =  g.mncodmon
       AND a.cacodmon2  =  h.mncodmon
       AND a.caprimero  = 'N'
       AND i.id_sistema = 'BFW'
       AND a.cacodpos1  = i.codigo_producto



    -- GUARDA LOS CAMPOS DE LA CARTERA EN LA TEMPORAL 
    SELECT DISTINCT
           'Numoper'           = a.canumoper
         , 'Nombre'            = b.clnombre
         , 'TipOper'           = a.catipoper
         , 'Plazo'             = a.caplazo
         , 'FecVen'            = CONVERT( CHAR(10), a.cafecvcto, 103 )
         , 'Nemo'              = ISNULL( c.mnnemo, ' ' )
         , 'MtoMex'            = a.camtomon1
         , 'Precio'            = CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.caprecal END
         , 'Preciofinal'       = a.catipcam
         , 'MtoCnv'            = a.camtomon2
         , 'Modal'             = a.catipmoda
         , 'FPMN'              = ISNULL( d.glosa,'N/A' )
         , 'FPMX'              = ISNULL( e.glosa,'N/A' )
         , 'Operador'          = a.caoperador
         , 'NomProp'           = @Nombre
         , 'FecPro'            = CONVERT( CHAR(10), f.acfecproc, 103 )
         , 'Fechahasta'        = CONVERT( CHAR(10), @dFechaHasta, 103 )
         , 'CodMon'            = g.mnnemo
         , 'CodCnv'            = h.mnnemo
         , 'Hora'              = a.cahora
         , 'Estado'            = 'C'
         , 'Producto'          = l.codigo_producto
         , 'NombreProducto'    = l.descripcion
         , 'FechaModificacion' = CONVERT( CHAR(10), i.cafecmod ,103)
         , 'FechaOperacion'    = CONVERT( CHAR(10), i.cafecha ,103)                
         , 'FechaEfectiva'     = CONVERT( CHAR(10), a.cafecEfectiva, 103 )
      INTO #temp_cartera 
      
    /* FROM dbo.MFCA               a
         , dbo.VIEW_CLIENTE       b
         , dbo.VIEW_MONEDA        c
         , dbo.VIEW_FORMA_DE_PAGO d
         , dbo.VIEW_FORMA_DE_PAGO e
         , dbo.MFAC               f
         , dbo.VIEW_MONEDA        g
         , dbo.VIEW_MONEDA        h
         , dbo.MFCA_LOG           i       
         , dbo.VIEW_PRODUCTO      l
     WHERE i.cafecmod  >=  @dFechaDesde
       AND i.cafecmod   <= @dFechaHasta
       AND i.caestado   =  'M'
       AND a.cacodigo   =  b.clrut
       AND a.cacodcli   =  b.clcodigo
       AND a.cacodmon1 *=  c.mncodmon
       AND a.cafpagomn *=  d.codigo
       AND a.cafpagomx *=  e.codigo
       AND a.cacodmon1  =  g.mncodmon
       AND a.cacodmon2  =  h.mncodmon
       AND a.canumoper = i.canumoper
       AND l.id_sistema = 'BFW'
       AND a.cacodpos1  = l.codigo_producto  */


	--RQ 7619
     FROM dbo.MFCA  a LEFT OUTER JOIN dbo.VIEW_MONEDA c ON a.cacodmon1 =  c.mncodmon
		      LEFT OUTER JOIN dbo.VIEW_FORMA_DE_PAGO d ON a.cafpagomn =  d.codigo
		      LEFT OUTER JOIN dbo.VIEW_FORMA_DE_PAGO e ON a.cafpagomx =  e.codigo
		 , dbo.VIEW_CLIENTE       b
         , dbo.MFAC               f
         , dbo.VIEW_MONEDA        g
         , dbo.VIEW_MONEDA        h
         , dbo.MFCA_LOG           i       
         , dbo.VIEW_PRODUCTO      l
     WHERE i.cafecmod  >= @dFechaDesde
       AND i.cafecmod   <= @dFechaHasta
       AND i.caestado   =  'M'
       AND a.cacodigo   =  b.clrut
       AND a.cacodcli   =  b.clcodigo
       AND a.cacodmon1  =  g.mncodmon
       AND a.cacodmon2  =  h.mncodmon
       AND a.canumoper = i.canumoper
       AND l.id_sistema = 'BFW'
       AND a.cacodpos1  = l.codigo_producto    


    -- GUARDA LOS CAMPOS DE LA CARTERA  HISTORICA EN LA TEMPORAL 
    SELECT DISTINCT
           'Numoper'           = a.canumoper
         , 'Nombre'            = b.clnombre
         , 'TipOper'           = a.catipoper
         , 'Plazo'             = a.caplazo
         , 'FecVen'            = CONVERT( CHAR(10), a.cafecvcto, 103 )
         , 'Nemo'              = ISNULL( c.mnnemo, ' ' )
         , 'MtoMex'            = a.camtomon1
         , 'Precio'            = CASE a.cacodpos1 WHEN 2 THEN a.caparmon1 ELSE a.caprecal END
         , 'Preciofinal'       = a.catipcam
         , 'MtoCnv'            = a.camtomon2
         , 'Modal'             = a.catipmoda
         , 'FPMN'              = ISNULL( d.glosa,'N/A' )
         , 'FPMX'              = ISNULL( e.glosa,'N/A' )
         , 'Operador'          = a.caoperador
         , 'NomProp'           = @Nombre
         , 'FecPro'            = CONVERT( CHAR(10), f.acfecproc, 103 )
         , 'Fechahasta'        = CONVERT( CHAR(10), @dFechaHasta, 103 )
         , 'CodMon'            = g.mnnemo
         , 'CodCnv'            = h.mnnemo
         , 'Hora'              = a.cahora
         , 'Estado'            = 'C'
         , 'Producto'          = l.codigo_producto
         , 'NombreProducto'    = l.descripcion
         , 'FechaModificacion' = CONVERT( CHAR(10), i.cafecmod ,103)
         , 'FechaOperacion'    = CONVERT( CHAR(10), i.cafecha ,103)                
         , 'FechaEfectiva'     = CONVERT( CHAR(10), a.cafecEfectiva, 103 )
      INTO #temp_cartera_h
      


	/*FROM dbo.MFCAH              a
         , dbo.VIEW_CLIENTE       b
         , dbo.VIEW_MONEDA        c
         , dbo.VIEW_FORMA_DE_PAGO d
         , dbo.VIEW_FORMA_DE_PAGO e
         , dbo.MFAC               f
         , dbo.VIEW_MONEDA        g
         , dbo.VIEW_MONEDA        h
         , dbo.MFCA_LOG           i
         , dbo.VIEW_PRODUCTO      l       
     WHERE i.cafecmod  >= @dFechaDesde
       AND i.cafecmod  <= @dFechaHasta
       AND i.caestado   = 'M'
       AND a.cacodigo   = b.clrut
       AND a.cacodcli   = b.clcodigo
       AND a.cacodmon1 *= c.mncodmon
       AND a.cafpagomn *= d.codigo
       AND a.cafpagomx *= e.codigo
       AND a.cacodmon1  = g.mncodmon
       AND a.cacodmon2  = h.mncodmon
       AND a.canumoper  = i.canumoper
       AND l.id_sistema = 'BFW'
       AND a.cacodpos1  = l.codigo_producto  */  


	-- RQ 7619
     FROM dbo.MFCAH a LEFT OUTER JOIN dbo.VIEW_MONEDA c ON a.cacodmon1 = c.mncodmon
		      LEFT OUTER JOIN dbo.VIEW_FORMA_DE_PAGO d ON a.cafpagomn = d.codigo
		      LEFT OUTER JOIN dbo.VIEW_FORMA_DE_PAGO e ON a.cafpagomx = e.codigo
         , dbo.VIEW_CLIENTE       b
         , dbo.MFAC               f
         , dbo.VIEW_MONEDA        g
         , dbo.VIEW_MONEDA        h
         , dbo.MFCA_LOG           i
         , dbo.VIEW_PRODUCTO      l       
     WHERE i.cafecmod  >= @dFechaDesde
       AND i.cafecmod  <= @dFechaHasta
       AND i.caestado   = 'M'
       AND a.cacodigo   = b.clrut
       AND a.cacodcli   = b.clcodigo
       AND a.cacodmon1  = g.mncodmon
       AND a.cacodmon2  = h.mncodmon
       AND a.canumoper  = i.canumoper
       AND l.id_sistema = 'BFW'
       AND a.cacodpos1  = l.codigo_producto    
                
    -- COMPARA EL REGISTRO BASE CON LOS DEMAS REGISTROS DE LA LOG
    SELECT 'Numoper'           = a.numoper
         , 'Nombre'            = CASE WHEN a.Nombre        = b.Nombre        THEN ' ' ELSE b.nombre        END
         , 'TipOper'           = CASE WHEN a.TipOper       = b.TipOper       THEN ' ' ELSE b.tipoper       END
         , 'Plazo'             = CASE WHEN a.Plazo         = b.Plazo         THEN 0   ELSE b.Plazo         END
         , 'FecVen'            = CASE WHEN a.FecVen        = b.FecVen        THEN ' ' ELSE b.FecVen        END
         , 'Nemo'              = CASE WHEN a.Nemo          = b.Nemo          THEN ' ' ELSE b.Nemo          END
         , 'MtoMex'            = CASE WHEN a.MtoMex        = b.MtoMex        THEN 0   ELSE b.MtoMex        END
         , 'Precio'            = CASE WHEN a.Precio        = b.Precio        THEN 0   ELSE b.Precio        END
         , 'Preciofinal'       = CASE WHEN a.Preciofinal   = b.Preciofinal   THEN 0   ELSE b.Preciofinal   END
         , 'MtoCnv'            = CASE WHEN a.MtoCnv        = b.MtoCnv        THEN 0   ELSE b.MtoCnv        END
         , 'Modal'             = CASE WHEN a.Modal         = b.Modal         THEN ' ' ELSE b.Modal         END
         , 'FPMN'              = CASE WHEN a.FPMN          = b.FPMN          THEN ' ' ELSE b.FPMN          END
         , 'FPMX'              = CASE WHEN a.FPMX          = b.FPMX          THEN ' ' ELSE b.FPMX          END
         , 'Operador'          = CASE WHEN a.Operador      = b.Operador      THEN ' ' ELSE b.Operador      END
         , 'NomPr'             = CASE WHEN a.NomProp       = b.Nomprop       THEN ' ' ELSE b.NomProp       END
         , 'FechaPro'          = CASE WHEN a.FecPro        = b.FecPro        THEN ' ' ELSE b.FecPro        END
         , 'CodMon'            = CASE WHEN a.CodMon        = b.CodMon        THEN ' ' ELSE b.Codmon        END
         , 'CodCnv'            = CASE WHEN a.CodCnv        = b.CodCnv        THEN ' ' ELSE b.codcnv        END
         , 'Hora'              = CASE WHEN a.Hora          = b.Hora          THEN ' ' ELSE b.hora          END
         , 'HoraReporte'       = a.hora_reporte
         , 'Estado'            = CASE WHEN a.Estado        = b.Estado        THEN ' ' ELSE b.estado        END
         , 'Producto'          = a.producto
         , 'NombreProducto'    = a.nombreproducto
         , 'FechaConsulta'     = CONVERT( CHAR(10), @dFechaDesde, 103 )
         , 'Fechahasta'        = CONVERT( CHAR(10), @dFechaHasta, 103 )
         , 'FechaModificacion' = CONVERT( CHAR(10), a.FechaModificacion, 103 )
         , 'FechaOperacion'    = CONVERT( CHAR(10), a.FechaOperacion, 103 )
         , 'FechaEfectiva'     = CASE WHEN a.FechaEfectiva = b.FechaEfectiva THEN ' ' ELSE b.FechaEfectiva END
      INTO #temp_3
      FROM #temp_1 a
         , #temp_2 b 
     WHERE a.numoper           = b.numoper  
     ORDER BY
           Numoper
         , hora

    -- COMPARA EL REGISTRO BASE CON LOS REGISTROS DE LA CARTERA
    SELECT 'Numoper'           = a.numoper
         , 'Nombre'            = CASE WHEN a.Nombre        =  b.Nombre       THEN ' ' ELSE b.nombre        END
         , 'TipOper'           = CASE WHEN a.TipOper       =  b.TipOper      THEN ' ' ELSE b.tipoper       END
         , 'Plazo'             = CASE WHEN a.Plazo         =  b.Plazo        THEN 0   ELSE b.Plazo         END
         , 'FecVen'            = CASE WHEN a.FecVen        =  b.FecVen       THEN ' ' ELSE b.FecVen        END
         , 'Nemo'              = CASE WHEN a.Nemo          =  b.Nemo         THEN ' ' ELSE b.Nemo          END
         , 'MtoMex'            = CASE WHEN a.MtoMex        =  b.MtoMex       THEN 0   ELSE b.MtoMex        END
         , 'Precio'            = CASE WHEN a.Precio        =  b.Precio       THEN 0   ELSE b.Precio        END
         , 'Preciofinal'       = CASE WHEN a.Preciofinal   =  b.Preciofinal  THEN 0   ELSE b.Preciofinal   END
         , 'MtoCnv'            = CASE WHEN a.MtoCnv        =  b.MtoCnv       THEN 0   ELSE b.MtoCnv        END
         , 'Modal'             = CASE WHEN a.Modal         =  b.Modal        THEN ' ' ELSE b.Modal         END
         , 'FPMN'              = CASE WHEN a.FPMN          =  b.FPMN         THEN ' ' ELSE b.FPMN          END
         , 'FPMX'              = CASE WHEN a.FPMX          =  b.FPMX         THEN ' ' ELSE b.FPMX          END
         , 'Operador'          = CASE WHEN a.Operador      =  b.Operador     THEN ' ' ELSE b.Operador      END
         , 'NomPr'             = CASE WHEN a.NomProp       =  b.Nomprop      THEN ' ' ELSE b.NomProp       END
         , 'FechaPro'          = CASE WHEN a.FecPro        =  b.FecPro       THEN ' ' ELSE b.FecPro        END
         , 'CodMon'            = CASE WHEN a.CodMon        =  b.CodMon       THEN ' ' ELSE b.Codmon        END
         , 'CodCnv'            = CASE WHEN a.CodCnv        =  b.CodCnv       THEN ' ' ELSE b.codcnv        END
         , 'Hora'              = CASE WHEN a.Hora          =  b.Hora         THEN ' ' ELSE b.hora          END
         , 'HoraReporte'       = a.hora_reporte
         , 'Estado'            = CASE WHEN a.Estado        =  b.Estado       THEN ' ' ELSE b.estado        END
         , 'Producto'          = a.producto
         , 'NombreProducto'    = a.nombreproducto
         , 'FechaConsulta'     = CONVERT( CHAR(10), @dFechaDesde, 103 )
         , 'Fechahasta'        = CONVERT( CHAR(10), @dFechaHasta, 103 )
         , 'FechaModificacion' = CONVERT( CHAR(10), a.FechaModificacion,103)
         , 'FechaOperacion'    = CONVERT( CHAR(10), a.FechaOperacion, 103 )                
         , 'FechaEfectiva'     = CASE WHEN a.FechaEfectiva = b.FechaEfectiva THEN ' ' ELSE b.FechaEfectiva END
      INTO #temp_4
      FROM #temp_1       a
         , #temp_cartera b 
     WHERE a.numoper           = b.numoper  
     ORDER BY
           Numoper,
           hora

    -- COMPARA EL REGISTRO BASE CON LOS REGISTROS DE LA CARTERA Hitorica
    SELECT 'Numoper'           = a.numoper
         , 'Nombre'            = CASE WHEN a.Nombre        =  b.Nombre       THEN ' ' ELSE b.nombre        END
         , 'TipOper'           = CASE WHEN a.TipOper       =  b.TipOper      THEN ' ' ELSE b.tipoper       END
         , 'Plazo'             = CASE WHEN a.Plazo         =  b.Plazo        THEN 0   ELSE b.Plazo         END
         , 'FecVen'            = CASE WHEN a.FecVen        =  b.FecVen       THEN ' ' ELSE b.FecVen        END
         , 'Nemo'              = CASE WHEN a.Nemo          =  b.Nemo         THEN ' ' ELSE b.Nemo          END
         , 'MtoMex'            = CASE WHEN a.MtoMex        =  b.MtoMex       THEN 0   ELSE b.MtoMex        END
         , 'Precio'            = CASE WHEN a.Precio        =  b.Precio       THEN 0   ELSE b.Precio        END
         , 'Preciofinal'       = CASE WHEN a.Preciofinal   =  b.Preciofinal  THEN 0   ELSE b.Preciofinal   END
         , 'MtoCnv'            = CASE WHEN a.MtoCnv        =  b.MtoCnv       THEN 0   ELSE b.MtoCnv        END
         , 'Modal'             = CASE WHEN a.Modal         =  b.Modal        THEN ' ' ELSE b.Modal         END
         , 'FPMN'              = CASE WHEN a.FPMN          =  b.FPMN         THEN ' ' ELSE b.FPMN          END
         , 'FPMX'              = CASE WHEN a.FPMX          =  b.FPMX         THEN ' ' ELSE b.FPMX          END
         , 'Operador'          = CASE WHEN a.Operador      =  b.Operador     THEN ' ' ELSE b.Operador      END
         , 'NomPr'             = CASE WHEN a.NomProp       =  b.Nomprop      THEN ' ' ELSE b.NomProp       END
         , 'FechaPro'          = CASE WHEN a.FecPro        =  b.FecPro       THEN ' ' ELSE b.FecPro        END
         , 'CodMon'            = CASE WHEN a.CodMon        =  b.CodMon       THEN ' ' ELSE b.Codmon        END
         , 'CodCnv'            = CASE WHEN a.CodCnv        =  b.CodCnv       THEN ' ' ELSE b.codcnv        END
         , 'Hora'              = CASE WHEN a.Hora          =  b.Hora         THEN ' ' ELSE b.hora          END
         , 'HoraReporte'       = a.hora_reporte
         , 'Estado'            = CASE WHEN a.Estado        = b.Estado        THEN ' ' ELSE b.estado        END
         , 'Producto'          = a.producto
         , 'NombreProducto'    = a.nombreproducto
         , 'FechaConsulta'     = CONVERT( CHAR(10), @dFechaDesde, 103 )
         , 'Fechahasta'        = CONVERT( CHAR(10), @dFechaHasta, 103 )
         , 'FechaModificacion' = CONVERT( CHAR(10), a.FechaModificacion, 103 )
         , 'FechaOperacion'    = CONVERT( CHAR(10), a.FechaOperacion, 103 )
         , 'FechaEfectiva'     = CASE WHEN a.FechaEfectiva = b.FechaEfectiva THEN ' ' ELSE b.FechaEfectiva END
      INTO #temp_5
      FROM #temp_1         a
         , #temp_cartera_h b 
     WHERE a.numoper           = b.numoper  
     ORDER BY
           Numoper,
           hora

    IF EXISTS( SELECT DISTINCT * FROM #temp_1 UNION SELECT DISTINCT * FROM #temp_3 UNION SELECT DISTINCT * FROM #temp_4  )
    BEGIN
        SELECT DISTINCT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
          FROM #temp_1 
        UNION
        SELECT DISTINCT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
          FROM #temp_3 
        UNION
        SELECT DISTINCT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
          FROM #temp_4 
        UNION
        SELECT DISTINCT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
          FROM #temp_5
         ORDER BY
               numoper
             , Estado DESC
             , hora
      END ELSE
    BEGIN
        SELECT 'Numoper'           = 0
             , 'Nombre'            = ''
             , 'TipOper'           = ''
             , 'Plazo'             = 0
             , 'FecVen'            = ''
             , 'Nemo'              = ''
             , 'MtoMex'            = 0
             , 'Precio'            = 0
             , 'Preciofinal'       = 0
             , 'MtoCnv'            = 0
             , 'Modal'             = ''
             , 'FPMN'              = ''
             , 'FPMX'              = ''             , 'Operador'          = ''
             , 'NomProp'           = @Nombre
             , 'FecPro'            = CONVERT( CHAR(10), f.acfecproc, 103 )
             , 'CodMon'            = ''
             , 'CodCnv'            = ''
             , 'Hora'              = ''
             , 'Hora_reporte'      = CONVERT( CHAR(08), GETDATE(), 108 )
             , 'Estado'            = ''
             , 'Producto'          = 0
             , 'NombreProducto'    = ''
             , 'Fechaconsulta'     = CONVERT( CHAR(10), @dFechaDesde, 103 )
             , 'Fechahasta'        = CONVERT( CHAR(10), @dFechaHasta, 103 )
             , 'FechaModificacion' = CONVERT( CHAR(10), GETDATE(), 108 )
             , 'FechaOperacion'    = CONVERT( CHAR(10), GETDATE(), 108 )
             , 'FechaEfectiva'     = CONVERT( CHAR(10), GETDATE(), 108 )
			 , 'RazonSocial'       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
          FROM dbo.mfac F

    END  
    SET NOCOUNT OFF

END


GO
