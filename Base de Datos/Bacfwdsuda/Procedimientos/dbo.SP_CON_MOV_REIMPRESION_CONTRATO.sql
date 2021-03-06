USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_MOV_REIMPRESION_CONTRATO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_MOV_REIMPRESION_CONTRATO]	(	@dfecmov	CHAR(8)		= '19000101'
							,	@nNumOper	NUMERIC(10,0)	= '-999'
							)
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @monto_fin       FLOAT
   DECLARE @monto_fin_esc   VARCHAR(255)

   DECLARE @iContador       INT
   DECLARE @cBancosRef1     VARCHAR(50)
   DECLARE @cBancosRef2     VARCHAR(50)
   DECLARE @cBancosRef3     VARCHAR(50)

       SET ROWCOUNT     1
       SET @cBancosRef1 = (SELECT TOP 1 LTRIM(RTRIM(clnombre)) FROM BacParamsuda..CLIENTE WHERE cltipcli = 1 AND clCondicionesGenerales = 'S')
       SET @cBancosRef2 = (SELECT TOP 1 LTRIM(RTRIM(clnombre)) FROM BacParamsuda..CLIENTE WHERE cltipcli = 1 AND clCondicionesGenerales = 'S' AND clnombre NOT IN(@cBancosRef1) )
       SET @cBancosRef3 = (SELECT TOP 1 LTRIM(RTRIM(clnombre)) FROM BacParamsuda..CLIENTE WHERE cltipcli = 1 AND clCondicionesGenerales = 'S' AND clnombre NOT IN(@cBancosRef1, @cBancosRef2) )
       SET ROWCOUNT     0

   SELECT 'canumope'       = a.canumoper,
          'catipcar'       = b.descripcion,
          'catipope'       = CASE a.catipoper WHEN 'C' THEN 'COMPRA' ELSE 'VENTA ' END,
          'cafecini'       = CONVERT(CHAR(10), a.cafecha, 103),
          'canomcli'       = CASE WHEN LEN(LTRIM(RTRIM(c.clnombre))) > 0 THEN c.clnombre 
                               -->WHEN c.clopcion = 'J' THEN c.clnombre 
                                  ELSE (RTRIM(clnomb1) + ' ' + RTRIM(clnomb2) + ' ' + RTRIM(clapelpa) + ' ' + RTRIM(clapelma) ) 
                             END,
          'catipcli'       = c.cltipcli,
          'calocext'       = CASE WHEN d.nombre = 'CHILE' THEN 'L' ELSE 'E' END,
          'carutcli'       = c.clrut,
          'cadigcli'       = c.cldv,
          'cacodcli'       = c.clcodigo,
          'cacodmon'       = e.mnnemo,
          'camtomex'       = a.camtomon1,
          'cacodcnv'       = f.mnnemo,
          'camtofin'       = a.camtomon2,
          'cafecven'       = CONVERT(CHAR(10), a.cafecvcto, 103),
          'cacomuna'       = ISNULL(g.nom_ciu , ''),
          'caglocodmon'    = RTRIM(e.mnnemo) + ' ' + e.mnglosa,
          'caglocodcnv'    = RTRIM(f.mnnemo) + ' ' + f.mnglosa,
          'catipcam'       = a.catipcam,
          'capreref'       = CASE WHEN a.cacodpos1 = 2 THEN a.caparmon1
                                  WHEN a.cacodpos1 = 9 THEN a.caparmon1
                                  ELSE                      a.capremon1
                             END,
          'cacodpos1'      = CASE WHEN a.cacodpos1 = 13 THEN 3 ELSE a.cacodpos1 END,
          'cadireccion'    = c.cldirecc,
          'catelefono'     = c.clfono,
          'cafax'          = c.clfax,
          'camodalidad'    = CASE WHEN a.catipmoda = 'C' THEN 'COMPENSACION  ' ELSE 'ENTREGA FISICA' END,
          'caglomonref'    = ISNULL(h.mnglosa, ' '),
          'simbolo'        = f.mnsimboL       ,
  	  'Glosa_Moneda1'  = e.mnglosa,
   	  'Glosa_Moneda2'  = f.mnglosa,
   	  'fecha_condiciones_generales'=c.clFechaFirma_cond,
          'REFUSD'	   = (CASE WHEN e.mnrrda = 'M' THEN 3 ELSE 1 END),
	  'cacodmon1'      = a.cacodmon1,
   	  'cacodmon2'      = a.cacodmon2,
   	  'FORMA_PAGO'     = CASE WHEN a.cacodpos1 = 10 THEN  pg.glosa ELSE
			    ( 'a)MN: ' +  CASE WHEN cacodpos1 = 12                               THEN RTRIM(isnull(pg.glosa,''))
                                              WHEN catipmoda = 'C' AND Moneda_Compensacion = 13 THEN 'N/A'
                                              WHEN                                                   RTRIM(isnull(pg.glosa,''))='NO APLICA' THEN 'N/A' 
                                              ELSE                                                   RTRIM(isnull(pg.glosa,''))
                                         END
		           + ' b)MX: ' + CASE WHEN cacodpos1 = 12                                THEN RTRIM(isnull(pg2.glosa,''))
                                              WHEN catipmoda = 'C' AND Moneda_Compensacion <> 13 THEN 'N/A'
					      WHEN                   RTRIM(isnull(pg2.glosa,''))='NO APLICA' THEN 'N/A' 
                                              ELSE                                                    RTRIM(isnull(pg2.glosa,''))
                                         END)
			     END
  	,'PARIDAD1'	   = CASE WHEN cacodpos1 = 12 then CONVERT(NUMERIC(21,10),caparmon1) else CONVERT(NUMERIC(21,10),caparmon2) end
  	,'MontoEscrito'    = CONVERT(VARCHAR(2000),'')
  	,'CONTADOR'        = identity(int)
	,'observaciones'   = a.caobserv
        ,'NocionalEscrito' = CONVERT(VARCHAR(2000),'')
        ,'rParidad'        = CASE WHEN cacolmon1 = 1 THEN 'Reuters 11:00 Hras'     + ' -- ' + CONVERT(CHAR(10),cafijaPRRef,103)
                                  WHEN cacolmon1 = 2 THEN 'Pactada'                + ' -- ' + CONVERT(CHAR(10),cafijaPRRef,103)
                                  WHEN cacolmon1 = 3 THEN 'Banco Central Europeo'  + ' -- ' + CONVERT(CHAR(10),cafijaPRRef,103)
                                  ELSE                    '--'
                             END
        ,'RefClientes1'    = CASE WHEN cltipcli = 1 THEN @cBancosRef1 ELSE '- ' END
        ,'RefClientes2'    = CASE WHEN cltipcli = 1 THEN @cBancosRef2 ELSE '- ' END
        ,'RefClientes3'    = CASE WHEN cltipcli = 1 THEN @cBancosRef3 ELSE '- ' END
	,'TasaEfecMon1'	   = catasaEfectMon1                                       
	,'TasaEfecMon2'	   = catasaEfectMon2
	,'Serie'	   = caserie
        ,'FechaStarting'   = CaFechaStarting   -- MAP Contingencia  
        ,'PuntosForward'   = CaPuntosFwdCierre -- MAP Contingencia  
   INTO  #temporal
   FROM  MFCA                          a   with (nolock)
         INNER JOIN view_producto      b   with (nolock) ON b.id_sistema  = 'BFW'      AND b.codigo_producto = a.cacodpos1
         INNER JOIN view_cliente       c   with (nolock) ON c.clrut       = a.cacodigo AND c.clcodigo        = a.cacodcli
         INNER JOIN view_pais          d   with (nolock) ON d.codigo_pais = c.clpais       
         INNER JOIN view_moneda        e   with (nolock) ON e.mncodmon    = a.cacodmon1
         INNER JOIN view_moneda        f   with (nolock) ON f.mncodmon    = a.cacodmon2
         LEFT  JOIN VIEW_FORMA_DE_PAGO PG  with (nolock) ON pg.codigo     = cafpagomn
         LEFT  JOIN VIEW_FORMA_DE_PAGO PG2 with (nolock) ON pg2.codigo    = cafpagomx
         LEFT  JOIN view_moneda        h   with (nolock) ON h.mncodmon    = a.camdausd 
         LEFT  JOIN view_ciudad_comuna g   with (nolock) ON g.cod_pai     = c.clpais   AND g.cod_ciu = c.clciudad AND g.cod_com = c.clcomuna   
   WHERE (a.cafecha                     = @dfecmov	OR @dfecmov	= '19000101')
   AND	 (a.canumoper 			= @nNumOper	OR @nNumOper	= -999)

   INSERT INTO #temporal 
   (   canumope   ,
       catipcar   ,
       catipope   ,
       cafecini   ,
       canomcli   ,
       catipcli   ,
       calocext   ,
       carutcli   ,
       cadigcli   ,
       cacodcli   ,
       cacodmon   ,
       camtomex   ,
       cacodcnv   ,
       camtofin   ,
       cafecven   ,
       cacomuna   ,
       caglocodmon,
       caglocodcnv,
       catipcam   ,
       capreref   ,
       cacodpos1  ,
       cadireccion,
       catelefono ,
       cafax      ,
       camodalidad,
       caglomonref,
       simbolo    ,
       Glosa_Moneda1,
       Glosa_Moneda2,
       fecha_condiciones_generales,
       REFUSD,
       cacodmon1,
       cacodmon2,
       FORMA_PAGO,
       PARIDAD1,
       MontoEscrito,
       observaciones,
       NocionalEscrito,
       rParidad,
       RefClientes1,
       RefClientes2,
       RefClientes3,
       TasaEfecMon1,
       TasaEfecMon2,
       Serie,
       FechaStarting, -- MAP Contingencia  
       PuntosForward -- MAP Contingencia  

   )
   SELECT 
       a.canumoper,
       b.descripcion,
       CASE WHEN a.catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA ' END,
       CONVERT(CHAR(10), a.cafecha, 103),
       c.clnombre,
       c.cltipcli,
       CASE WHEN d.nombre = 'CHILE' THEN 'L' ELSE 'E' END,
       c.clrut,
       c.cldv,
       c.clcodigo,
       e.mnnemo,
       a.camtomon1,
       f.mnnemo,
       a.camtomon2,
       CONVERT(CHAR(10), a.cafecvcto, 103),
       ISNULL(g.nom_ciu, ''),
       RTRIM(e.mnnemo) + ' ' + e.mnglosa,
       RTRIM(f.mnnemo) + ' ' + f.mnglosa,
       a.catipcam,
       CASE WHEN a.cacodpos1 = 2 THEN a.caparmon1
            WHEN a.cacodpos1 = 9 THEN a.caparmon1
            ELSE    a.capremon1
       END,
       CASE WHEN a.cacodpos1 = 13 THEN 3 ELSE a.cacodpos1 END,
       c.cldirecc,
       c.clfono,
       c.clfax,
       CASE WHEN a.catipmoda = 'C' THEN 'COMPENSACION  ' ELSE 'ENTREGA FISICA' END,
       ISNULL(h.mnglosa, ' '),
       f.mnsimbol,
       e.mnglosa,
       f.mnglosa,
       c.clFechaFirma_cond,
       CASE WHEN e.mnrrda = 'M' THEN 3 ELSE 1 END,
       a.cacodmon1,
       a.cacodmon2,
         'a)MN: ' + CASE WHEN cacodpos1 = 12                             THEN RTRIM(isnull(pg.glosa,''))
			 WHEN catipmoda='C' AND Moneda_Compensacion = 13 THEN 'N/A'
		         WHEN RTRIM(isnull(pg.glosa,'')) = 'NO APLICA'   THEN 'N/A'
                         ELSE                                                  RTRIM(isnull(pg.glosa,''))
                    END
      + ' b)MX: ' + CASE WHEN cacodpos1 = 12                              THEN RTRIM(isnull(pg2.glosa,''))
			 WHEN catipmoda='C' AND Moneda_Compensacion <> 13 THEN 'N/A'
			 WHEN RTRIM(isnull(pg2.glosa,'')) = 'NO APLICA'   THEN 'N/A'
			 ELSE                                                  RTRIM(isnull(pg2.glosa,''))
                    END
     ,'PARIDAD1'	= CASE WHEN cacodpos1 = 12 then CONVERT(NUMERIC(21,10),caparmon1) ELSE CONVERT(NUMERIC(21,10),caparmon2) END
     , CONVERT(VARCHAR(2000),'')
     , a.caobserv
     , CONVERT(VARCHAR(2000),'')
     ,'rParidad'        = CASE WHEN cacolmon1 = 1 THEN 'Reuters 11:00 Hras'     + ' -- ' + CONVERT(CHAR(10),cafijaPRRef,103)
                               WHEN cacolmon1 = 2 THEN 'Pactada'                + ' -- ' + CONVERT(CHAR(10),cafijaPRRef,103)
                               WHEN cacolmon1 = 3 THEN 'Banco Central Europeo'  + ' -- ' + CONVERT(CHAR(10),cafijaPRRef,103)
                               ELSE                    '--'
                          END
     ,'RefClientes1'    = CASE WHEN cltipcli = 1 THEN @cBancosRef1 ELSE '- ' END
     ,'RefClientes2'    = CASE WHEN cltipcli = 1 THEN @cBancosRef2 ELSE '- ' END
     ,'RefClientes3'    = CASE WHEN cltipcli = 1 THEN @cBancosRef3 ELSE '- ' END
     ,'TasaEfecMon1'	= catasaEfectMon1                                       
     ,'TasaEfecMon2'	= catasaEfectMon2
     ,'SERIE'		= caserie
     ,'FechaStarting'   = CaFechaStarting   -- MAP Contingencia  
     ,'PuntosForward'   = CaPuntosFwdCierre -- MAP Contingencia  

   FROM  mfcah                           a with (nolock) 
         INNER JOIN view_cliente         c with (nolock) ON c.clrut           = a.cacodigo  AND c.clcodigo   = a.cacodcli
         INNER JOIN view_producto        b with (nolock) ON b.codigo_producto = a.cacodpos1 AND b.id_sistema = 'BFW'
         INNER JOIN view_moneda          e with (nolock) ON e.mncodmon        = a.cacodmon1
         INNER JOIN view_moneda          f with (nolock) ON f.mncodmon        = a.cacodmon2
         LEFT  JOIN view_moneda          h with (nolock) ON h.mncodmon        = a.camdausd
         LEFT  JOIN VIEW_FORMA_DE_PAGO  PG with (nolock) ON cafpagomn	      = pg.codigo
         LEFT  JOIN VIEW_FORMA_DE_PAGO PG2 with (nolock) ON cafpagomx	      = pg2.codigo
         LEFT  JOIN view_pais            d with (nolock) ON d.codigo_pais     = c.clpais
         LEFT  JOIN view_ciudad_comuna   g with (nolock) ON g.cod_pai         = c.clpais AND g.cod_ciu = c.clciudad AND g.cod_com = c.clcomuna
   WHERE (a.cafecha                     = @dfecmov	OR @dfecmov	= '19000101')
   AND	 (a.canumoper 			= @nNumOper	OR @nNumOper	= -999)

   DECLARE @CONT 	  INT
   DECLARE @TOTAL 	  INT
   DECLARE @MONTO_ESCRITO VARCHAR(2000)
   DECLARE @NUMOPER       NUMERIC(10)
   DECLARE @MONTO_VALOR   NUMERIC(19,4)
   DECLARE @NOCIONAL      NUMERIC(19,4)

   SET     @CONT  = 1
   SET     @TOTAL = (SELECT COUNT(1) FROM #temporal)

   WHILE @CONT <= @TOTAL
   BEGIN

      SELECT @NUMOPER     = canumope
         ,   @MONTO_VALOR = camtofin
         ,   @NOCIONAL    = camtomex
        FROM #temporal
       WHERE contador     = @CONT

      EXECUTE SP_MONTOESCRITO @MONTO_VALOR ,@MONTO_ESCRITO OUTPUT

      UPDATE #temporal 
         SET MontoEscrito = @MONTO_ESCRITO
       WHERE canumope     = @numoper

      EXECUTE SP_MONTOESCRITO @NOCIONAL ,@MONTO_ESCRITO OUTPUT

      UPDATE #temporal 
         SET NocionalEscrito = @MONTO_ESCRITO
       WHERE canumope        = @numoper

         SET @CONT = @CONT + 1
   END

	SELECT	*
	FROM	#TEMPORAL
	WHERE	(canumope = @nNumOper OR  @nNumOper = -999)

END

GO
