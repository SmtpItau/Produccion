USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[CONTRATO_FWDDOBS_ANEXO7]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- CONTRATO_FWDDOBS_ANEXO7 607260, '20160525', 5676774, 1, 0, 0, 0, 0

CREATE PROCEDURE [dbo].[CONTRATO_FWDDOBS_ANEXO7]
   (    @noper numeric(8)
        ,@fecha				AS CHAR(8)
 		,@RUT_CLIENTE		AS NUMERIC(11)  
	    ,@COD_CLIENTE		AS NUMERIC(10)  
	    ,@RUT_APODERADO1	AS NUMERIC(11) = 0  
	    ,@RUT_APODERADO2	AS NUMERIC(11) = 0  
	    ,@RUT_APODERADOB1	AS NUMERIC(11) = 0  
	    ,@RUT_APODERADOB2	AS NUMERIC(11) = 0   
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @monto_fin       FLOAT
   DECLARE @monto_fin_esc   VARCHAR(255)

   DECLARE @iContador       INTEGER
   DECLARE @cBancosRef1     VARCHAR(50)
   DECLARE @cBancosRef2     VARCHAR(50)
   DECLARE @cBancosRef3     VARCHAR(50)

       SET ROWCOUNT     1
       SET @cBancosRef1 = (SELECT TOP 1 LTRIM(RTRIM(clnombre)) FROM BacParamsuda..CLIENTE WHERE cltipcli = 1 AND clCondicionesGenerales = 'S')
       SET @cBancosRef2 = (SELECT TOP 1 LTRIM(RTRIM(clnombre)) FROM BacParamsuda..CLIENTE WHERE cltipcli = 1 AND clCondicionesGenerales = 'S' AND clnombre NOT IN(@cBancosRef1) )
       SET @cBancosRef3 = (SELECT TOP 1 LTRIM(RTRIM(clnombre)) FROM BacParamsuda..CLIENTE WHERE cltipcli = 1 AND clCondicionesGenerales = 'S' AND clnombre NOT IN(@cBancosRef1, @cBancosRef2) )
       SET ROWCOUNT     0

   --PRD 12712		
	DECLARE	@Termino_anticipado VARCHAR(1000)

    SELECT	@Termino_anticipado = CASE WHEN bearlytermination = 1 THEN 
   									'Las partes acuerdan que dentro del plazo  de diez (10) Días Hábiles contados desde el día ' 
   									+ right('00'+convert(varchar(2),DATEPART(day,fechainicio)) ,2) +   									
   									+ ' de ' 
   									+  case when datepart(month,fechainicio	) = 1  THEN 'Enero'
										    when datepart(month,fechainicio	) = 2  THEN 'Febrero'
										    when datepart(month,fechainicio	) = 3  THEN 'Marzo'
										    when datepart(month,fechainicio	) = 4  THEN 'Abril'
										    when datepart(month,fechainicio	) = 5  THEN 'Mayo'
										    when datepart(month,fechainicio	) = 6  THEN 'Junio'
										    when datepart(month,fechainicio	) = 7  THEN 'Julio'
										    when datepart(month,fechainicio	) = 8  THEN 'Agosto'
										    when datepart(month,fechainicio	) = 9  THEN 'Septiembre'
										    when datepart(month,fechainicio	) = 10 THEN 'Octubre'
										    when datepart(month,fechainicio	) = 11 THEN 'Noviembre'
										    when datepart(month,fechainicio	) = 12 THEN 'Diciembre' end
   									+ ' del ' + rtrim(DATEPART(year,fechainicio)) + ' , y con una periodicidad ' 
   									+ CASE WHEN Periodicidad = 0 THEN ''
   									       ELSE (SELECT ltrim(rtrim(gd.tbglosa))   
   												 FROM   BacParamSuda..TABLA_GENERAL_DETALLE GD 
   									             WHERE  GD.tbcateg			 = 9920
   												 AND    ca.Periodicidad      = gd.tbcodigo1 )
   									  END 
   									+ ',  cualquiera de las partes tendrá la facultad de terminar en forma unilateral y anticipada el presente contrato.' 
   									+ ' La terminación deberá comunicarse a la otra parte antes de las 11:00 horas a.m. de cualquiera de los días comprendidos en el citado plazo ' 
   									+ '(en adelante,  la “Fecha de Terminación Anticipada”). Dentro de los 2 Días Hábiles siguientes a la Fecha de Terminación Anticipada deberá procederse al pago,'
   									+ ' por la parte que resulte deudora, del Valor de Mercado del contrato, calculado conforme a la Tasa de Valorización Referencial de Mercado y al Plazo residual a la Fecha de Terminación Anticipada.'

                                   ELSE 'No Aplica' END
   FROM BacFwdSuda.dbo.mfca ca
   WHERE ca.canumoper		= @noper  
   
   

   SELECT 'canumope'      = a.canumoper
      ,   'catipcar'      = CASE WHEN var_moneda2 > 0 AND a.cacodpos1 = 2 THEN 'ARBITRAJE MONEDA MX-$' ELSE b.descripcion END
      ,   'catipope'      = CASE WHEN a.catipoper = 'C'                   THEN 'COMPRA'                ELSE 'VENTA '      END
     -- ,   'cafecini'      = CONVERT(CHAR(10), a.cafecha, 103)
	  ,   'cafecini'      =  a.cafecha
      ,   'canomcli'  = CASE WHEN Len(Ltrim(Rtrim(c.clnombre))) > 0 THEN c.clnombre
                                 ELSE (RTRIM(clnomb1) + ' ' + RTRIM(clnomb2) + ' ' + RTRIM(clapelpa) + ' ' + RTRIM(clapelma) ) 
                            END
      ,   'catipcli'      = c.cltipcli
      ,   'calocext'      = CASE WHEN d.nombre = 'CHILE' THEN 'L' ELSE 'E' END
      ,   'carutcli'      = c.clrut
      ,   'cadigcli'      = c.cldv
      ,   'cacodcli'      = c.clcodigo
      ,   'cacodmon'      = CASE WHEN a.var_moneda2 > 0 AND ( a.cacodpos1 = 1 OR a.cacodpos1 = 2 ) THEN e.mnnemo               ELSE e.mnnemo    END
      ,   'camtomex'      = CASE WHEN a.var_moneda2 > 0 AND ( a.cacodpos1 = 1 )                    THEN 0                      ELSE a.camtomon1 END
      ,   'cacodcnv'      = CASE WHEN a.var_moneda2 > 0                                            THEN 'CLP'                  ELSE f.mnnemo    END
      ,   'camtofin'      = CASE WHEN a.cacodpos1   = 2 AND a.var_moneda2 > 0                      THEN a.camtomon1 * caprecal ELSE a.camtomon2 END
      ,   'cafecven'      = CONVERT(CHAR(10), a.cafecvcto, 103)
      ,   'cacomuna'      = ISNULL(g.nom_ciu, '')
      ,   'caglocodmon'   = CASE WHEN a.var_moneda2 > 0 AND a.cacodpos1 = 1 THEN 'EUR EURO'  ELSE RTRIM( e.mnnemo) + ' ' + e.mnglosa END
      ,   'caglocodcnv'   = CASE WHEN a.var_moneda2 > 0                     THEN 'CLP PESOS' ELSE RTRIM( f.mnnemo) + ' ' + f.mnglosa END
      ,   'catipcam'      = CASE WHEN a.cacodpos1 = 2 AND a.var_moneda2 > 0 THEN a.caprecal 
                                 ELSE                                            a.catipcam --> a.capreciopunta 
                            END
      ,   'capreref'      = CASE WHEN a.cacodpos1 = 2 AND a.var_moneda2 > 0 THEN a.caprecal
                                 WHEN a.cacodpos1 = 2                       THEN a.caparmon1
                                 WHEN a.cacodpos1 = 9                       THEN a.caparmon1
                                 ELSE                                            a.capremon1
                            END
      ,   'cacodpos1'     = CASE WHEN a.cacodpos1 = 13                      THEN 3
                                 WHEN a.cacodpos1 = 2 AND a.var_moneda2 > 0 THEN 12
                                 ELSE                                            a.cacodpos1
                            END
      ,   'cadireccion'   = c.cldirecc
      ,   'catelefono'    = c.clfono
      ,   'cafax'         = c.clfax
      ,   'camodalidad'   = CASE WHEN a.catipmoda = 'C' THEN 'COMPENSACION  ' ELSE 'ENTREGA FISICA' END
      ,   'caglomonref'   = Isnull(h.mnglosa, ' ') 
      ,   'simbolo'       = CASE WHEN a.var_moneda2 > 0 THEN '$' ELSE f.mnsimbol END
      ,   'Glosa_Moneda1' = CASE WHEN a.var_moneda2 > 0 AND (a.cacodpos1 = 1 OR a.cacodpos2 = 2) THEN 'EURO'
                                 ELSE e.mnglosa
                            END
      ,   'Glosa_Moneda2' = CASE WHEN a.var_moneda2 > 0 AND (a.cacodpos1 IN(1, 2)) THEN 'PESOS' ELSE f.mnglosa END
      ,   'fecha_condiciones_generales' = CASE WHEN c.nuevo_ccg_firmado = 'S' THEN c.fecha_firma_nuevo_ccg ELSE c.clfechafirma_cond END
      ,   'REFUSD'        = CASE WHEN e.mnrrda = 'M' THEN 3 ELSE 1 END

      ,   'cacodmon1'     = (CASE WHEN ( a.cacodmon1 = 1 OR a.cacodmon1 = 2 ) AND var_moneda2 > 0 THEN 13 --> 12 --> Por lo menos es 13, pero no debe ir en duro
                                  WHEN a.var_moneda2 > 0  AND a.cacodpos1 IN ( 1, 2 )             THEN 142
                                  ELSE                                                                 a.cacodmon1
                              END)
      ,   'cacodmon2'     = CASE WHEN a.var_moneda2 > 0 AND a.cacodpos1 IN ( 1, 2 ) THEN 999
                                 ELSE a.cacodmon2
                            END
      ,   'FORMA_PAGO'    = CASE WHEN a.cacodpos1 = 10 THEN pg.glosa
                                 ELSE ( 'a)MN: ' + CASE WHEN cacodpos1 = 12 OR ( a.var_moneda2 > 0 AND a.cacodpos1 IN ( 1, 2 ) ) THEN RTRIM(ISNULL(pg.glosa, ''))
                                                        WHEN catipmoda = 'C' AND moneda_compensacion = 13                        THEN 'N/A'
                                                        WHEN RTRIM(isnull(pg.glosa,''))='NO APLICA'                              THEN 'N/A' 
                                                        ELSE                                                                          RTRIM(ISNULL(pg.glosa,''))
                                                   END 
                                     + ' b)MX: ' + CASE WHEN cacodpos1 = 12                                                      THEN RTRIM(ISNULL(pg2.glosa, ''))
                                                        WHEN catipmoda = 'C' AND moneda_compensacion <> 13                       THEN 'N/A'
                                                        WHEN RTRIM(isnull(pg2.glosa,''))='NO APLICA'                             THEN 'N/A' 
                                                        ELSE                                                                          RTRIM(isnull(pg2.glosa,''))
                                                   END)
                            END
      ,   'PARIDAD1'       = CASE WHEN cacodpos1 = 12                    THEN CONVERT(NUMERIC(21, 10), caparmon1)
                                  WHEN var_moneda2 > 0 AND cacodpos1 = 1 THEN catipcam
                                  ELSE                                        CONVERT(NUMERIC(21, 10), caparmon2)
                             END
  	,'MontoEscrito'    = CONVERT(VARCHAR(2000), '')
  	,'observaciones'   = a.caobserv
        ,'NocionalEscrito' = CONVERT(VARCHAR(2000), '')
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
	  ,    'FechaStarting'			= (SELECT CONVERT(CHAR(2), CaFechaStarting	, 103) + ' de '
										+ case when datepart(month,CaFechaStarting	) = 1 THEN 'Enero'
										 when datepart(month,CaFechaStarting	) = 2 THEN 'Febrero'
										  when datepart(month,CaFechaStarting	) = 3 THEN 'Marzo'
										   when datepart(month,CaFechaStarting	) = 4 THEN 'Abril'
										    when datepart(month,CaFechaStarting	) = 5 THEN 'Mayo'
										     when datepart(month,CaFechaStarting	) = 6 THEN 'Junio'
										      when datepart(month,CaFechaStarting	) = 7 THEN 'Julio'
										       when datepart(month,CaFechaStarting	) = 8 THEN 'Agosto'
										        when datepart(month,CaFechaStarting	) = 9 THEN 'Septiembre'
										         when datepart(month,CaFechaStarting	) = 10 THEN 'Octubre'
										          when datepart(month,CaFechaStarting	) = 11 THEN 'Noviembre'
										           when datepart(month,CaFechaStarting	) = 12 THEN 'Diciembre'
										           end + ' del año '
										           + ltrim(rtrim(datepart(year,CaFechaStarting	))))
	,'PuntosFwdCierre' = capuntosfwdcierre
        ,'var_moneda2'     = var_moneda2
      ,   'Termino_anticipado' = @Termino_anticipado
	  , 'Tipo_Operacion'	= a.catipoper

		into #temporal1
   FROM  bacfwdsuda..MFCA                          a   with (nolock)
INNER JOIN bacfwdsuda..view_producto      b   with (nolock) ON b.id_sistema  = 'BFW'      AND b.codigo_producto = a.cacodpos1
         INNER JOIN bacfwdsuda..view_cliente       c   with (nolock) ON c.clrut       = a.cacodigo AND c.clcodigo        = a.cacodcli
         INNER JOIN bacfwdsuda..view_pais          d   with (nolock) ON d.codigo_pais = c.clpais       
         INNER JOIN bacfwdsuda..view_moneda        e   with (nolock) ON e.mncodmon    = a.cacodmon1
         INNER JOIN bacfwdsuda..view_moneda        f   with (nolock) ON f.mncodmon    = a.cacodmon2
         LEFT  JOIN bacfwdsuda..VIEW_FORMA_DE_PAGO PG  with (nolock) ON pg.codigo     = cafpagomn
         LEFT  JOIN bacfwdsuda..VIEW_FORMA_DE_PAGO PG2 with (nolock) ON pg2.codigo    = cafpagomx
         LEFT  JOIN bacfwdsuda..view_moneda        h   with (nolock) ON h.mncodmon    = a.camdausd 
         LEFT  JOIN bacfwdsuda..view_ciudad_comuna g   with (nolock) ON g.cod_pai     = c.clpais   AND g.cod_ciu = c.clciudad AND g.cod_com = c.clcomuna   
   WHERE a.canumoper = @noper

  UNION
  /* INSERT INTO #temporal1
   (   canumope,        catipcar,      catipope,     cafecini,      canomcli,      catipcli,     calocext,   carutcli
   ,   cadigcli,        cacodcli,      cacodmon,     camtomex,      cacodcnv,      camtofin,     cafecven,   cacomuna
   ,   caglocodmon,     caglocodcnv,   catipcam,     capreref,      cacodpos1,     cadireccion,  catelefono, cafax
   ,   camodalidad,     caglomonref,   simbolo,      glosa_moneda1, glosa_moneda2, fecha_condiciones_generales
   ,   refusd,          cacodmon1,     cacodmon2,    forma_pago,    paridad1,      montoescrito, observaciones
   ,   nocionalescrito, rparidad,      refclientes1, refclientes2,  refclientes3,  tasaefecmon1, tasaefecmon2
   ,   serie,           FechaStarting, PuntosFwdCierre
   ,   var_moneda2
   )*/
    

   SELECT canumope                    = a.canumoper
   ,      catipcar                    = b.descripcion
   ,      catipope                    = CASE WHEN a.catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA ' END
   --,      cafecini                    = CONVERT(CHAR(10), a.cafecha, 103)
   ,      cafecini                    = cafecha
   ,      canomcli                    = c.clnombre
   ,      catipcli                    = c.cltipcli
   ,      calocext                    = CASE WHEN d.nombre = 'CHILE' THEN 'L' ELSE 'E' END
   ,      carutcli                    = c.clrut
   ,      cadigcli                    = c.cldv
   ,      cacodcli                    = c.clcodigo
   ,      cacodmon                    = e.mnnemo
   ,      camtomex                    = a.camtomon1
   ,      cacodcnv                    = f.mnnemo
   ,      camtofin                    = a.camtomon2
   ,      cafecven                    = CONVERT(CHAR(10), a.cafecvcto, 103)
   ,      cacomuna                    = ISNULL( g.nom_ciu, '')
   ,      caglocodmon                 = RTRIM(  e.mnnemo ) + ' ' + e.mnglosa
   ,      caglocodcnv                 = RTRIM(  f.mnnemo ) + ' ' + f.mnglosa
   ,      catipcam                    = CASE WHEN a.cacodpos1 = 2 AND a.var_moneda2 > 0 THEN a.catipcam ELSE a.catipcam END
   ,      capreref                    = CASE WHEN a.cacodpos1 = 2 AND a.var_moneda2 > 0 THEN a.caprecal
                                             WHEN a.cacodpos1 = 2                       THEN a.caparmon1
                                             WHEN a.cacodpos1 = 9                       THEN a.caparmon1
                                             ELSE                                            a.capremon1
                                        END
   ,      cacodpos1                   = CASE WHEN a.cacodpos1 = 13 THEN 3 ELSE a.cacodpos1 END
   ,      cadireccion                 = c.cldirecc
   ,      catelefono                  = c.clfono
   ,      cafax                       = c.clfax
   ,      camodalidad                 = CASE WHEN a.catipmoda = 'C' THEN 'COMPENSACION  ' ELSE 'ENTREGA FISICA' END
   ,      caglomonref   = Isnull(h.mnglosa, ' ')
   ,      simbolo                     = f.mnsimbol
   ,      glosa_moneda1               = e.mnglosa
   ,      glosa_moneda2               = f.mnglosa
   ,      fecha_condiciones_generales = CASE WHEN c.nuevo_ccg_firmado = 'S' THEN c.fecha_firma_nuevo_ccg ELSE c.clfechafirma_cond END
   ,      refusd                      = CASE WHEN e.mnrrda = 'M' THEN 3 ELSE 1 END
   ,      cacodmon1                   = a.cacodmon1
   ,      cacodmon2                   = a.cacodmon2
   ,      forma_pago                  = 'a)MN: '  + CASE WHEN cacodpos1 = 12                                THEN RTRIM(ISNULL( pg.glosa, ''))
			                                 WHEN catipmoda ='C' AND Moneda_Compensacion = 13   THEN 'N/A'
		                                         WHEN RTRIM(isnull(pg.glosa,'')) = 'NO APLICA'      THEN 'N/A'
                                                         ELSE                                                    RTRIM(ISNULL( pg.glosa,''))
                                                    END 
                                      + ' b)MX: ' + CASE WHEN cacodpos1 = 12                                THEN RTRIM(ISNULL( pg2.glosa,''))
			                                 WHEN catipmoda = 'C' AND Moneda_Compensacion <> 13 THEN 'N/A'
			                                 WHEN RTRIM(isnull(pg2.glosa,'')) = 'NO APLICA'     THEN 'N/A'
			                                 ELSE                                                    RTRIM(ISNULL( pg2.glosa,''))
                                                    END
   ,      paridad1                    = CASE WHEN cacodpos1 = 12 then CONVERT(NUMERIC(21,10),caparmon1) ELSE CONVERT(NUMERIC(21,10),caparmon2) END
   ,      montoescrito                = CONVERT(VARCHAR(2000), '')
   ,      observaciones               = a.caobserv
   ,      nocionalescrito             = CONVERT(VARCHAR(2000), '')
   ,      rparidad                    = CASE WHEN cacolmon1 = 1 THEN 'Reuters 11:00 Hras'     + ' -- ' + CONVERT(CHAR(10),cafijaPRRef,103)
                                             WHEN cacolmon1 = 2 THEN 'Pactada'                + ' -- ' + CONVERT(CHAR(10),cafijaPRRef,103)
                                             WHEN cacolmon1 = 3 THEN 'Banco Central Europeo'  + ' -- ' + CONVERT(CHAR(10),cafijaPRRef,103)
                                             ELSE                    '--'
                                        END
   ,      refclientes1                = CASE WHEN cltipcli = 1 THEN @cBancosRef1 ELSE '- ' END
   ,      refclientes2                = CASE WHEN cltipcli = 1 THEN @cBancosRef2 ELSE '- ' END
   ,      refclientes3                = CASE WHEN cltipcli = 1 THEN @cBancosRef3 ELSE '- ' END
   ,      tasaefecmon1                = catasaEfectMon1
   ,      tasaefecmon2                = catasaEfectMon2
   ,      serie                       = caserie
   ,      FechaStarting			= (SELECT CONVERT(CHAR(2), CaFechaStarting	, 103) + ' de '
										+ case when datepart(month,CaFechaStarting	) = 1 THEN 'Enero'
										 when datepart(month,CaFechaStarting	) = 2 THEN 'Febrero'
										  when datepart(month,CaFechaStarting	) = 3 THEN 'Marzo'
										   when datepart(month,CaFechaStarting	) = 4 THEN 'Abril'
										    when datepart(month,CaFechaStarting	) = 5 THEN 'Mayo'
										     when datepart(month,CaFechaStarting	) = 6 THEN 'Junio'
										      when datepart(month,CaFechaStarting	) = 7 THEN 'Julio'
										       when datepart(month,CaFechaStarting	) = 8 THEN 'Agosto'
										        when datepart(month,CaFechaStarting	) = 9 THEN 'Septiembre'
										         when datepart(month,CaFechaStarting	) = 10 THEN 'Octubre'
										          when datepart(month,CaFechaStarting	) = 11 THEN 'Noviembre'
										           when datepart(month,CaFechaStarting	) = 12 THEN 'Diciembre'
										           end + ' del año '
										           + ltrim(rtrim(datepart(year,CaFechaStarting	))))
   ,      PuntosFwdCierre             = CaPuntosFwdCierre
   ,      var_moneda2                 = var_moneda2
   --,     'Termino_anticipado'         = @Termino_anticipado

   ,     'Termino_anticipado'         = CASE WHEN bearlytermination = 1 THEN 
   									'Las partes acuerdan que dentro del plazo  de diez (10) Días Hábiles contados desde el día ' 
   									+ right('00'+convert(varchar(2),DATEPART(day,fechainicio)) ,2) +   									
   									+ ' de ' 
   									+  case when datepart(month,fechainicio	) = 1  THEN 'Enero'
										    when datepart(month,fechainicio	) = 2  THEN 'Febrero'
										    when datepart(month,fechainicio	) = 3  THEN 'Marzo'
										    when datepart(month,fechainicio	) = 4  THEN 'Abril'
										    when datepart(month,fechainicio	) = 5  THEN 'Mayo'
										    when datepart(month,fechainicio	) = 6  THEN 'Junio'
										    when datepart(month,fechainicio	) = 7  THEN 'Julio'
										    when datepart(month,fechainicio	) = 8  THEN 'Agosto'
										    when datepart(month,fechainicio	) = 9  THEN 'Septiembre'
										    when datepart(month,fechainicio	) = 10 THEN 'Octubre'
										    when datepart(month,fechainicio	) = 11 THEN 'Noviembre'
										    when datepart(month,fechainicio	) = 12 THEN 'Diciembre' end
   									+ ' del ' + rtrim(DATEPART(year,fechainicio)) + ' , y con una periodicidad ' 
   									+ CASE WHEN Periodicidad = 0 THEN ''
   									       ELSE (SELECT ltrim(rtrim(gd.tbglosa))   
   												 FROM   BacParamSuda..TABLA_GENERAL_DETALLE GD 
   									             WHERE  GD.tbcateg			 = 9920
   												 AND    a.Periodicidad      = gd.tbcodigo1 )
   									  END 
   									+ ',  cualquiera de las partes tendrá la facultad de terminar en forma unilateral y anticipada el presente contrato.' 
   									+ ' La terminación deberá comunicarse a la otra parte antes de las 11:00 horas a.m. de cualquiera de los días comprendidos en el citado plazo ' 
   									+ '(en adelante,  la “Fecha de Terminación Anticipada”). Dentro de los 2 Días Hábiles siguientes a la Fecha de Terminación Anticipada deberá procederse al pago,'
   									+ ' por la parte que resulte deudora, del Valor de Mercado del contrato, calculado conforme a la Tasa de Valorización Referencial de Mercado y al Plazo residual a la Fecha de Terminación Anticipada.'

                                   ELSE 'No Aplica' END

 , 'Tipo_Operacion'	= a.catipoper

   FROM  bacfwdsuda..MFCAH                           a with(nolock) 
         INNER JOIN bacfwdsuda..view_cliente         c with(nolock) ON c.clrut           = a.cacodigo  AND c.clcodigo   = a.cacodcli
         INNER JOIN bacfwdsuda..view_producto        b with(nolock) ON b.codigo_producto = a.cacodpos1 AND b.id_sistema = 'BFW'
         INNER JOIN bacfwdsuda..view_moneda          e with(nolock) ON e.mncodmon        = a.cacodmon1 
         INNER JOIN bacfwdsuda..view_moneda          f with(nolock) ON f.mncodmon        = a.cacodmon2 
         LEFT  JOIN bacfwdsuda..view_moneda          h with(nolock) ON h.mncodmon        = a.camdausd
         LEFT  JOIN bacfwdsuda..VIEW_FORMA_DE_PAGO  PG with(nolock) ON cafpagomn	     = pg.codigo
         LEFT  JOIN bacfwdsuda..VIEW_FORMA_DE_PAGO PG2 with(nolock) ON cafpagomx	     = pg2.codigo
         LEFT  JOIN bacfwdsuda..view_pais            d with(nolock) ON d.codigo_pais     = c.clpais
         LEFT  JOIN bacfwdsuda..view_ciudad_comuna   g with(nolock) ON g.cod_pai         = c.clpais AND g.cod_ciu = c.clciudad AND g.cod_com = c.clcomuna
   WHERE a.canumoper = @noper
  

 

   /* Borramos los Seguros de cambios (Mx-clp) no nos interesan */
   DELETE FROM #temporal1
         WHERE var_moneda2 > 0
           AND cacodpos1   = 1

   DECLARE @CONT 	  INTEGER
   DECLARE @TOTAL 	  INTEGER
   DECLARE @MONTO_ESCRITO VARCHAR(2000)
   DECLARE @NUMOPER       NUMERIC(10)
 DECLARE @MONTO_VALOR   NUMERIC(19,4)
   DECLARE @NOCIONAL      NUMERIC(19,4)

   SET     @CONT  = 1
   SET     @TOTAL = (SELECT COUNT(1) FROM #temporal1)

   SELECT @NUMOPER     = canumope
   ,      @MONTO_VALOR = camtofin
   ,      @NOCIONAL    = camtomex
   FROM   #temporal1
   
    
	
	  EXECUTE bacfwdsuda.dbo.SP_MONTOESCRITO @MONTO_VALOR ,@MONTO_ESCRITO OUTPUT

      UPDATE #temporal1 
         SET MontoEscrito = @MONTO_ESCRITO
       WHERE canumope     = @numoper

      EXECUTE bacfwdsuda.dbo.SP_MONTOESCRITO @NOCIONAL ,@MONTO_ESCRITO OUTPUT

      UPDATE #temporal1 
         SET NocionalEscrito = ltrim(rtrim(substring(@MONTO_ESCRITO, 1, len(@MONTO_ESCRITO)-3)))
       WHERE canumope        = @numoper

      SET @CONT = @CONT + 1




   DECLARE @fechacond  DATETIME, @fecha1 datetime

   SELECT @fechacond=clFechaFirma_cond 
   FROM bacparamsuda..cliente CLIENTE with (nolock)
   WHERE clrut = @rut_cliente 
   AND clcodigo = @COD_CLIENTE 
AND clvigente = 'S'

   select @fecha1=convert(datetime,@fecha)

	DECLARE @NomEntidad		VARCHAR(100)
	DECLARE @RutEntidad		NUMERIC(8)
	DECLARE	@DvEntidad		VARCHAR(1)
	DECLARE	@DirecEntidad	VARCHAR(100)
	DECLARE @FonoEntidad	VARCHAR(14)
	DECLARE @FaxEntidad		VARCHAR(14)

   	SELECT DISTINCT
			@NomEntidad		=	RazonSocial	
	,		@RutEntidad		=	RutEntidad	
	,		@DvEntidad		=	DigitoVerificador
	,		@DirecEntidad	=	DireccionLegal + ', ' + Comuna + ', ' + Ciudad
	,		@FonoEntidad	=	TelefonoLegal
	FROM bacparamsuda..Contratos_ParametrosGenerales

	

	
	select 'FECHA_CONTRATO'			= (SELECT  convert(varchar(2),datepart(day,cafecini))	 + ' de '
										+ case when datepart(month,cafecini	) = 1 THEN 'Enero'
										 when datepart(month,cafecini	) = 2 THEN 'Febrero'
										  when datepart(month,cafecini	) = 3 THEN 'Marzo'
										   when datepart(month,cafecini	) = 4 THEN 'Abril'
										    when datepart(month,cafecini	) = 5 THEN 'Mayo'
										     when datepart(month,cafecini	) = 6 THEN 'Junio'
										      when datepart(month,cafecini	) = 7 THEN 'Julio'
										       when datepart(month,cafecini	) = 8 THEN 'Agosto'
										        when datepart(month,cafecini	) = 9 THEN 'Septiembre'
										         when datepart(month,cafecini	) = 10 THEN 'Octubre'
										          when datepart(month,cafecini	) = 11 THEN 'Noviembre'
										           when datepart(month,cafecini	) = 12 THEN 'Diciembre'
										           end + ' de '
										           + ltrim(rtrim(datepart(year,cafecini	))))


						   	,   (SELECT CONVERT(CHAR(2), @fechacond	, 103) + ' de '
										+ case when datepart(month,@fechacond	) = 1 THEN 'Enero'
										 when datepart(month,@fechacond	) = 2 THEN 'Febrero'
										  when datepart(month,@fechacond	) = 3 THEN 'Marzo'
										   when datepart(month,@fechacond	) = 4 THEN 'Abril'
										    when datepart(month,@fechacond	) = 5 THEN 'Mayo'
										     when datepart(month,@fechacond	) = 6 THEN 'Junio'
										      when datepart(month,@fechacond	) = 7 THEN 'Julio'
										       when datepart(month,@fechacond	) = 8 THEN 'Agosto'
										        when datepart(month,@fechacond	) = 9 THEN 'Septiembre'
										         when datepart(month,@fechacond	) = 10 THEN 'Octubre'
										          when datepart(month,@fechacond	) = 11 THEN 'Noviembre'
										           when datepart(month,@fechacond	) = 12 THEN 'Diciembre'
										           end + ' de '
										           + ltrim(rtrim(datepart(year,@fechacond	)))) as fechacond

	,	'BANCO'						= @NomEntidad -->(SELECT nombre from Bacswapsuda.dbo.SwapGeneral with(nolock))	-->	A.Nombre

	--,	'RUT'						=	(SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.'))) + '-' 
	--														+ ltrim(rtrim(CLDV))
	--										From	Bacparamsuda.dbo.cliente with(nolock)
	--										where	clrut	= (SELECT rut from Bacswapsuda.dbo.SwapGeneral with(nolock))
	--									)
										
	,	'RUT'						=	(SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, @RutEntidad), 1), '.00', ''), ',','.'))) + '-' 
															+ ltrim(rtrim(@DvEntidad))
											--From	Bacparamsuda.dbo.cliente with(nolock)
											--where	clrut	= (SELECT rut from Bacswapsuda.dbo.SwapGeneral with(nolock))
										)

	,   'RUT_CLI'					=	(SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, Clrut), 1), '.00', ''), ',','.'))) + '-' 
											+ ltrim(rtrim(CLDV))
											From	Bacparamsuda.dbo.cliente with(nolock)
											where	clrut = @rut_cliente
										)
										
	,	'CLIENTE'				= CLNOMBRE 
	,	'DIRECCION_CLI'				= CLI.CLDIRECC  
	,	'FONO_CLI'					= CLI.CLFONO
	,	'FAX_CLI'					= CLI.CLFAX
	,	'COMUNA'					= CLI.COMUNA	-->	COMUNA.NOMBRE  
	,	'CIUDAD'					= CLI.CIUDAD	-->	CIUDAD.NOMBRE  

	,	'APODERADO_CLIENTE_1'		= ISNULL(APOCLI.APNOMBRE,'')  
	,   'RUT_APODERADO_CLIENTE_1'	= ISNULL(APOCLI.RUT_APODERADO,'')

	,	'APODERADO_CLIENTE_2'		= ISNULL(APOCLI2.APNOMBRE,'')
	,   'RUT_APODERADO_CLIENTE_2'	= ISNULL(APOCLI2.RUT_APODERADO,'')  
	,   'APODERADO_BANCO_1'			= ISNULL(APOBAN.APNOMBRE,'')  
	,   'RUT_APODERADO_BANCO_1'		= ISNULL(APOBAN.RUT_APODERADO,'')  
	,   'APODERADO_BANCO_2'			= ISNULL(APOBAN2.APNOMBRE,'')  
	,   'RUT_APODERADO_BANCO_2'		= ISNULL(APOBAN2.RUT_APODERADO,'') 

	,   'DIRECCION_BANCO'			= @DirecEntidad -->FUSION (SELECT DIRECCION from Bacswapsuda.dbo.SwapGeneral with(nolock))
	,	'TELEFONO_BANCO'			= @FonoEntidad --> FUSION (SELECT TELEFONO	from Bacswapsuda.dbo.SwapGeneral with(nolock))
	,	'FAX_BANCO'					= (SELECT FAX		from Bacswapsuda.dbo.SwapGeneral with(nolock))
	,   b.*
	, cDecimales = ' CON  '+case substring(convert(varchar(20),camtomex), charindex('.',convert(varchar(20),camtomex))+1, 4) when '0000' then '00'

					else case when substring(convert(varchar(20),camtomex), charindex('.',convert(varchar(20),camtomex))+4, 1)= '0' then 
							case when substring(convert(varchar(20),camtomex), charindex('.',convert(varchar(20),camtomex))+3, 1)= '0' then  substring(convert(varchar(20),camtomex), charindex('.',convert(varchar(20),camtomex))+1, 2)
							else substring(convert(varchar(20),camtomex), charindex('.',convert(varchar(20),camtomex))+1,3) 
							end
					   else
						   substring(convert(varchar(20),camtomex), charindex('.',convert(varchar(20),camtomex))+1, 4) 
					   end
					end +
					 case substring(convert(varchar(20),camtomex), charindex('.',convert(varchar(20),camtomex))+1, 4) when '0000' then '/100)'
					else
					   case when substring(convert(varchar(20),camtomex), charindex('.',convert(varchar(20),camtomex))+4, 1)= '0' then 
							case when substring(convert(varchar(20),camtomex), charindex('.',convert(varchar(20),camtomex))+3, 1)= '0' then '/100)'
							else '/1000)' 
							end
					   else
						   '/10000)' 
					   end
					end
		, 'BannerLargoContrato' = (SELECT BannerLargoContrato FROM BacParamSuda..Contratos_ParametrosGenerales)
		, 'logo'				= (SELECT logo FROM BacParamSuda..Contratos_ParametrosGenerales)

		,		'Vendedor'			=	ISNULL((SELECT CASE WHEN Tipo_Operacion = 'V' THEN @NomEntidad ELSE Clnombre END),'')
		,		'Comprador'			=	ISNULL((SELECT CASE WHEN Tipo_Operacion = 'V' THEN Clnombre  ELSE @NomEntidad END),'')


	FROM	#temporal1 B
			INNER JOIN
			(	select	distinct 
						Rut			= clrut
					,	Codigo		= clcodigo
					,	clnombre	= clnombre
					,	CLDIRECC	= CLDIRECC
					,	CLFONO		= CLFONO
					,	CLFAX		= CLFAX
					--,	RUT_CLIENTE = RTRIM(LTRIM(CONVERT(CHAR(10),CLRUT))) + '-' + CLDV
					,	RUT_CLIENTE	= (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, CLRUT), 1), '.00', ''), ',','.')))) + '-' + CLDV
					,	COMUNA		= comuna.Nombre
					,	CIUDAD		= ciudad.nombre
				FROM	BacParamSuda.dbo.CLIENTE with(nolock)
						left join 
						(	select	id		= codigo_comuna
								,	Nombre	= nombre
							from	BacParamSuda.dbo.Comuna with(nolock)
						)	comuna	On comuna.id	= clcomuna

						left join
						(	select	Id		= codigo_ciudad
								,	Nombre	= Nombre
							from	BacParamSuda.dbo.ciudad with(nolock)
						)	ciudad	On ciudad.Id	= clciudad

				WHERE	CLRUT = @RUT_CLIENTE and clcodigo = @COD_CLIENTE
			)	cli		On	cli.Rut		= B.carutcli
						and	cli.codigo	= B.cacodcli

			LEFT JOIN
			(	select	distinct 
						APNOMBRE
					--,	RUT_APODERADO	= RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO
					,	RUT_APODERADO	= (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO
					,	Rut				= APRUTCLI
					,	Codigo			= APCODCLI
				FROM	BACPARAMSUDA..CLIENTE_APODERADO with(nolock)
				WHERE	APRUTAPO		= @RUT_APODERADO1 
				and		APRUTCLI		= @RUT_CLIENTE 
				and		APCODCLI		= @COD_CLIENTE
			)	APOCLI	On	APOCLI.Rut		= B.carutcli
						and	APOCLI.Codigo	= B.cacodcli

			LEFT JOIN
			(	select	distinct 
						APNOMBRE
					--,	RUT_APODERADO	= RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO   
					,	RUT_APODERADO	= (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO
					,	Rut				= APRUTCLI
					,	Codigo			= APCODCLI
				FROM	BACPARAMSUDA.dbo.CLIENTE_APODERADO with(nolock)
				WHERE	APRUTAPO		= @RUT_APODERADO2 
				and		aprutcli		= @RUT_CLIENTE 
				and		apcodcli		= @COD_CLIENTE
			)	APOCLI2 On	APOCLI2.Rut		= B.carutcli
						and	APOCLI2.Codigo	= B.cacodcli
			LEFT JOIN
			(	select	distinct 
						APNOMBRE
					--,	RUT_APODERADO	= RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO
					,	RUT_APODERADO	= (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO
					,	Rut				= 97023000
				FROM	BACPARAMSUDA.DBO.CLIENTE_APODERADO with(nolock)
				WHERE	APRUTAPO		= @RUT_APODERADOB1 
				and		aprutcli		= 97023000
			)	APOBAN	On APOBAN.Rut	= 97023000	--> CORPBANCA

			LEFT JOIN
			(	select	distinct 
						APNOMBRE
					--,	RUT_APODERADO	= RTRIM(LTRIM(CONVERT(CHAR(10),APRUTAPO))) + '-' + APDVAPO 
					,	RUT_APODERADO	= (SELECT distinct convert(varchar(20),(select replace (replace (convert (varchar(20), convert(money, APRUTAPO), 1), '.00', ''), ',','.')))) + '-' + APDVAPO
					,	Rut				= 97023000
				FROM	BACPARAMSUDA.dbo.CLIENTE_APODERADO with(nolock)
				WHERE	APRUTAPO		= @RUT_APODERADOB2 
				and		aprutcli		= 97023000
			)	APOBAN2 On APOBAN2.Rut	= 97023000 --> CORPBANCA   

END



GO
