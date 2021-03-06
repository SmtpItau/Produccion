USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREAMOVIMIENTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_CREAMOVIMIENTO]

   (   @dfecmov   DATETIME

   ,   @ncontrato NUMERIC(3)

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



   --PRD 12712

   DECLARE @texto VARCHAR(MAX)



       SET ROWCOUNT     1

       SET @cBancosRef1 = (SELECT TOP 1 LTRIM(RTRIM(clnombre)) FROM BacParamsuda..CLIENTE WHERE cltipcli = 1 AND clCondicionesGenerales = 'S')

       SET @cBancosRef2 = (SELECT TOP 1 LTRIM(RTRIM(clnombre)) FROM BacParamsuda..CLIENTE WHERE cltipcli = 1 AND clCondicionesGenerales = 'S' AND clnombre NOT IN(@cBancosRef1) )

       SET @cBancosRef3 = (SELECT TOP 1 LTRIM(RTRIM(clnombre)) FROM BacParamsuda..CLIENTE WHERE cltipcli = 1 AND clCondicionesGenerales = 'S' AND clnombre NOT IN(@cBancosRef1, @cBancosRef2) )

       SET ROWCOUNT     0



   SELECT 'canumope'      = a.canumoper

      ,   'catipcar'      = CASE WHEN var_moneda2 > 0 AND a.cacodpos1 = 2 THEN 'ARBITRAJE MONEDA MX-$' ELSE b.descripcion END

      ,   'catipope'      = CASE WHEN a.catipoper = 'C'                   THEN 'COMPRA'                ELSE 'VENTA '      END

      ,   'cafecini'      = CONVERT(CHAR(10), a.cafecha, 103)

      ,   'canomcli'      = CASE WHEN Len(Ltrim(Rtrim(c.clnombre))) > 0 THEN c.clnombre

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

  	,'CONTADOR'        = identity(INT)

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

	,'FechaStarting'   = CASE WHEN cacodpos1 = 14 THEN CONVERT(CHAR(10),CaFechaStarting,103)

				  ELSE ''

			     END

	,'PuntosFwdCierre' = capuntosfwdcierre

        ,'var_moneda2'     = var_moneda2

      ,   'Termino_Anticipado' = @texto

        

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

   WHERE a.cafecha                     = @dfecmov 
		 and a.caantici <> 'A' 




   INSERT INTO #TEMPORAL

   (   canumope,        catipcar,      catipope,     cafecini,      canomcli,      catipcli,     calocext,   carutcli

   ,   cadigcli,        cacodcli,      cacodmon,     camtomex,      cacodcnv,      camtofin,     cafecven,   cacomuna

   ,   caglocodmon,     caglocodcnv,   catipcam,     capreref,      cacodpos1,     cadireccion,  catelefono, cafax

   ,   camodalidad,     caglomonref,   simbolo,      glosa_moneda1, glosa_moneda2, fecha_condiciones_generales

   ,   refusd,          cacodmon1,     cacodmon2,    forma_pago,    paridad1,      montoescrito, observaciones

   ,   nocionalescrito, rparidad,      refclientes1, refclientes2,  refclientes3,  tasaefecmon1, tasaefecmon2

   ,   serie,           FechaStarting, PuntosFwdCierre

   ,   var_moneda2,     Termino_Anticipado

   )

   SELECT canumope                    = a.canumoper

   ,      catipcar                    = b.descripcion

   ,      catipope                    = CASE WHEN a.catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA ' END

   ,      cafecini                    = CONVERT(CHAR(10), a.cafecha, 103)

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

   ,      caglomonref                 = Isnull(h.mnglosa, ' ')

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

   ,      FechaStarting               = CASE WHEN cacodpos1 = 14 THEN CONVERT(CHAR(10),CaFechaStarting,103) ELSE '' END

   ,      PuntosFwdCierre             = CaPuntosFwdCierre

   ,      var_moneda2                 = var_moneda2

   ,      Termino_Anticipado		  = '' 

   FROM  MFCAH  a with(nolock) 

         INNER JOIN view_cliente         c with(nolock) ON c.clrut           = a.cacodigo  AND c.clcodigo   = a.cacodcli

         INNER JOIN view_producto        b with(nolock) ON b.codigo_producto = a.cacodpos1 AND b.id_sistema = 'BFW'

         INNER JOIN view_moneda          e with(nolock) ON e.mncodmon        = a.cacodmon1 

         INNER JOIN view_moneda          f with(nolock) ON f.mncodmon        = a.cacodmon2 

         LEFT  JOIN view_moneda          h with(nolock) ON h.mncodmon        = a.camdausd

         LEFT  JOIN VIEW_FORMA_DE_PAGO  PG with(nolock) ON cafpagomn	     = pg.codigo

         LEFT  JOIN VIEW_FORMA_DE_PAGO PG2 with(nolock) ON cafpagomx	     = pg2.codigo

         LEFT  JOIN view_pais            d with(nolock) ON d.codigo_pais     = c.clpais

         LEFT  JOIN view_ciudad_comuna   g with(nolock) ON g.cod_pai         = c.clpais AND g.cod_ciu = c.clciudad AND g.cod_com = c.clcomuna

   WHERE a.cafecha                     = @dfecmov
			and a.caantici <> 'A' 


   /* Borramos los Seguros de cambios (Mx-clp) no nos interesan */

   DELETE FROM #TEMPORAL

         WHERE var_moneda2 > 0

           AND cacodpos1   = 1



   DECLARE @CONT 	  INTEGER

   DECLARE @TOTAL 	  INTEGER

   DECLARE @MONTO_ESCRITO VARCHAR(2000)

   DECLARE @NUMOPER       NUMERIC(10)

   DECLARE @MONTO_VALOR   NUMERIC(19,4)

   DECLARE @NOCIONAL      NUMERIC(19,4)



   SET     @CONT  = 1

   SET     @TOTAL = (SELECT COUNT(1) FROM #temporal)



   WHILE @CONT <= @TOTAL

   BEGIN



      SELECT @NUMOPER     = canumope

      ,      @MONTO_VALOR = camtofin

      ,      @NOCIONAL    = camtomex

      FROM   #temporal

      WHERE  contador     = @CONT



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





    --PRD 12712	-->		

	SELECT 'canumoper'          = ca.canumoper,    

		   'Termino_Anticipado' = CASE WHEN bearlytermination = 1 THEN 

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

   									+ ', cualquiera de las partes tendrá la facultad de terminar en forma unilateral y anticipada el presente contrato.' 

   									+ ' La terminación deberá comunicarse a la otra parte antes de las 11:00 horas a.m. de cualquiera de los días comprendidos en el citado plazo ' 

   									+ '(en adelante,  la “Fecha de Terminación Anticipada”). Dentro de los 2 Días Hábiles siguientes a la Fecha de Terminación Anticipada deberá procederse al pago,'

   									+ ' por la parte que resulte deudora, del Valor de Mercado del contrato, calculado conforme a la Tasa de Valorización Referencial de Mercado y al Plazo residual a la Fecha de Terminación Anticipada.'



                                   ELSE 'No Aplica' END                                   

	

	INTO #Temp_ET

	FROM BacFwdSuda.dbo.mfca ca

	inner JOIN #temporal t ON ca.canumoper = t.canumope

	

	UPDATE #temporal SET #temporal.Termino_Anticipado = ET.Termino_Anticipado

	FROM #Temporal t

	INNER JOIN #Temp_ET  ET ON t.canumope = ET.canumoper

	

	--PRD 12712 <--

	

   IF @ncontrato = 1

   BEGIN

      SELECT DISTINCT * FROM #TEMPORAL WHERE catipcli <> 1

   END ELSE 



      IF @ncontrato = 2

      BEGIN



         SELECT DISTINCT * FROM #temporal WHERE cacodpos1 IN( 3,13) AND catipcli = 1 



      END ELSE 



         IF @ncontrato = 3

         BEGIN

            SELECT DISTINCT * FROM #temporal WHERE cacodpos1 IN(1, 2, 9, 10, 11, 12,13) AND catipcli = 1



         END ELSE 

            IF @ncontrato = 4

            BEGIN

               SELECT DISTINCT * FROM #temporal WHERE cacodpos1 IN( 3,13) AND catipcli <> 1



            END ELSE 

               IF @ncontrato = 5

               BEGIN

                  SELECT DISTINCT * FROM #temporal WHERE cacodpos1 = 7



               END ELSE

					IF @ncontrato = 0

					BEGIN

						SELECT DISTINCT * FROM #temporal

				END





END


GO
