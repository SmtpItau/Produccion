USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETA_ARB_MON_MX]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PAPELETA_ARB_MON_MX] (@numOper NUMERIC(19))
AS
  BEGIN
      SET nocount ON

      DECLARE @CatCartFin CHAR(10)
      DECLARE @CatCartNorm CHAR(10)
      DECLARE @CatLibro CHAR(10)
      DECLARE @CatAreaResp CHAR(10)
      DECLARE @CatSubCart CHAR(10)
	  
      SET @CatCartFin  = '204'
      SET @CatCartNorm = '1111'
      SET @CatLibro    = '1552'
      SET @CatAreaResp = '1553'
      SET @CatSubCart  = '1554'

      DECLARE @firma1 CHAR(15)
      DECLARE @firma2 CHAR(15)
      DECLARE @nvaluf FLOAT
      DECLARE @cnomprop CHAR(40)
      DECLARE @cdirprop CHAR(40)
      DECLARE @cSettlement CHAR(50)
      DECLARE @cPFE CHAR(50)
      DECLARE @cCCE CHAR(50)
      DECLARE @cEmisorInstPlazo CHAR(50)
      DECLARE @cEstado CHAR(15)
      DECLARE @cFecproc CHAR(10)
      DECLARE @cadena CHAR(1)
      DECLARE @cadena1 CHAR(1)
		DECLARE @OPER1 FLOAT
		DECLARE @OPER2 FLOAT
		DECLARE @numcor FLOAT

	  DECLARE @MTOEXCESOSISTEMA FLOAT
	  DECLARE @MTOEXCESO FLOAT
	  DECLARE @RUTAUX FLOAT
	  DECLARE @CDVAUX  CHAR(2)	--> CHAR(1)

      SET @cadena1 = ' '
      SET @cadena = ' '

      SELECT @firma1 = res.firma1
             ,@firma2 = res.firma2
      FROM   baclineas..detalle_aprobaciones res WITH (nolock)
      WHERE  id_sistema = 'BFW'
             AND res.numero_operacion = @numOper

      SELECT @cnomprop = acnomprop
             ,@cdirprop = acdirprop
             ,@cfecproc = CONVERT(CHAR(10), acfecproc, 103)
             ,@nvaluf = vmvalor
      FROM   view_valor_moneda WITH (nolock)
             INNER JOIN mfac WITH (nolock)
               ON vmfecha = acfecproc
                  AND vmcodigo = accodmonuf

      DECLARE @NombreEntidad VARCHAR(50)

      SET @NombreEntidad = (SELECT rcnombre
                            FROM   bacparamsuda..entidad WITH (nolock))
      SET @cEstado = ' '

      SELECT @cEstado = 'PENDIENTE'
      FROM   mfmo WITH (nolock)
      WHERE  monumoper = @numOper
             AND moestado = 'P'

      SELECT @cEstado = 'MODIFICADO'
      FROM   mfca_log WITH (nolock)
      WHERE  canumoper = @numOper
             AND caestado = 'M'

      SELECT @cEstado = 'ANULADA'
      FROM   mfca_log WITH (nolock)
      WHERE  canumoper = @numOper
             AND caestado = 'A'

      SELECT @cEstado = 'ANTICIPADA'
      FROM   mfca WITH (nolock)
      WHERE  canumoper = @numOper
             AND caantici = 'A'

      SELECT @cEstado = 'ANTICIPADA'
      FROM   mfcah WITH (nolock)
      WHERE  canumoper = @numOper
             AND caantici = 'A'

      SELECT @cEstado = 'RECHAZADA'
      FROM   mfca WITH (nolock)
      WHERE  canumoper = @numOper
             AND caestado = 'R'

      SELECT @cEstado = 'APROBADA'
      FROM   mfca WITH (nolock)
      WHERE  canumoper = @numOper
             AND caestado = ''

      DECLARE @MensajeThreshold VARCHAR(100)

      SET @MensajeThreshold = ''
      SET @MensajeThreshold = Isnull((SELECT TOP 1 Substring(mensaje, 1, 70)
                                      FROM   bacparamsuda.dbo.tbl_mensajes_operacion_threshold WITH(nolock)
                                      WHERE  id_sistema = 'BFW'
                                             AND num_contrato = @numOper), '')

      IF EXISTS(SELECT 1
                FROM   mfca_log WITH (nolock)
                WHERE  canumoper = @numOper
                       AND caestado = 'A')
        BEGIN
		-- SP_PAPELETA_ARB_MON_MX 31628

		if ( select 1 from MFCA_LOG where var_moneda2 = @numoper and canumoper != @numoper ) = 1
		begin
			select @oper1=var_moneda2
			      ,@oper2=canumoper
			  from MFCA_LOG 
			 where var_moneda2 = @numoper
			   and canumoper  != @numoper
		end
		else
		begin
			if ( select 1 from MFCA_LOG where canumoper = @numoper and var_moneda2 != @numoper ) = 1
			begin
				select @oper1=var_moneda2
				      ,@oper2=canumoper
				  from MFCA_LOG
				 where canumoper    = @numoper
		   and var_moneda2 != @numoper
			end 
		End
		set @oper1 = isnull(@oper1, 0)
		set @oper2 = isnull(@oper2, 0)

			/* Totales Exceso */
	 
			SELECT @rutaux = cacodigo
			      ,@cdvaux  = cacodcli
			 FROM mfca_log  where (canumoper = @oper1 or canumoper = @oper2) 
			 
			/* TOTAL EXCESO */
			SELECT @MTOEXCESO     = b.totalexceso
			FROM   BACLINEAS..LINEA_SISTEMA                        a with (nolock) 
				  INNER JOIN BACLINEAS..LINEA_GENERAL             b with (nolock) ON b.rut_cliente = a.rut_cliente AND b.Codigo_Cliente = a.Codigo_Cliente
				  INNER JOIN VIEW_CLIENTE              c with (nolock) ON c.clrut	= a.rut_cliente AND c.clcodigo	     = a.Codigo_Cliente
				  LEFT  JOIN BacParamSuda..MONEDA      m with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,m.mncodmon)))    = b.moneda
				  LEFT  JOIN BacParamSuda..SISTEMA_CNT s with (nolock) ON s.id_sistema =  a.id_sistema
				  LEFT  JOIN BacParamSuda..MONEDA      n with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,n.mncodmon)))    = a.moneda
			WHERE  a.rut_cliente     = @rutaux
			AND    a.Codigo_Cliente  = @cdvaux
			AND    a.id_sistema = 'BFW'
	    
			/* TOTAL EXCESO POR SISTEMA */
                        SELECT @MTOEXCESOSISTEMA =SUM( a.totalexceso )
			FROM   BACLINEAS..LINEA_SISTEMA                        a with (nolock) 
				  INNER JOIN BACLINEAS..LINEA_GENERAL             b with (nolock) ON b.rut_cliente = a.rut_cliente AND b.Codigo_Cliente = a.Codigo_Cliente
				  INNER JOIN VIEW_CLIENTE              c with (nolock) ON c.clrut	= a.rut_cliente AND c.clcodigo	     = a.Codigo_Cliente
				  LEFT  JOIN BacParamSuda..MONEDA      m with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,m.mncodmon)))    = b.moneda
				  LEFT  JOIN BacParamSuda..SISTEMA_CNT s with (nolock) ON s.id_sistema =  a.id_sistema
				  LEFT  JOIN BacParamSuda..MONEDA      n with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,n.mncodmon)))    = a.moneda
			WHERE  a.rut_cliente     = @rutaux
			AND    a.Codigo_Cliente  = @cdvaux

			SET @MTOEXCESOSISTEMA = ISNULL(@MTOEXCESOSISTEMA, 0)
			SET @MTOEXCESO 		  = ISNULL(@MTOEXCESO, 0)

            SELECT 'Numero Operacion' = a.canumoper
                   ,'Fecha Inicio' = CONVERT(CHAR(10), a.cafecha, 103)
                   ,'Fecha Vcto' = CONVERT(CHAR(10), a.cafecvcto, 103)
                   ,'Plazo' = a.caplazo
                   ,'Rut Cliente' = a.cacodigo
                   ,'Nombre Cliente' = b.clnombre
                   ,'Tc Inicial' =  a.capremon2 -- a.cavalpre -->
                   ,'Precio' = CASE
                                 WHEN a.cacodpos1 = 2 THEN a.caparmon1
                                 WHEN a.cacodpos1 = 12 THEN a.caprecal -- a.caparmon1 
                                 ELSE a.caprecal
                               END
                   ,'Monto MX' = a.camtomon1
                   ,'Precio Futuro' = CONVERT(NUMERIC(21, 8), a.caprecal)
                  -- ,'Monto Final' = a.camtomon1 * CONVERT(NUMERIC(21, 8), a.catipcam)
		   ,'Monto Final' =  a.camtomon1 * CONVERT(NUMERIC(21, 8), a.caprecal) -- a.caequmon2 -- a.camtomon2		
                   ,'Pago MN' = Isnull(l.glosa, 'X')
                   ,'Pago MX' = Isnull(x.glosa, 'X')
                   ,'Modalidad' = a.catipmoda
                   ,'Equivalente M/X' = a.caequusd1 --> a.caequmon1
                   ,'Monto CLP' = CASE
                                    WHEN a.cacodpos1 = 2 THEN 0
                                    ELSE a.caequmon2
                                  END
                                      ,'Articulo84' = a.cadiferen
                   ,'Observacion' = a.caobserv
                   ,'Retito' = a.caretiro
                   ,'Operador' = a.caoperador
                   ,'Moneda MX' = c.mnnemo
                   ,'Moneda MN' = d.mnnemo
                   ,'Digito V' = b.cldv
                   ,'UF del Dia' = @nvaluf
                   ,'Tipo Operacion' = catipoper
                   ,'Producto' = Ltrim(Rtrim(e.descripcion)) + CASE
                                                                 WHEN var_moneda2 > 0 THEN ' (MX/CLP)'
                                                               END
                   ,'Nombre Porpietario' = @cnomprop
                   ,'Direccion' = @cdirprop
                   ,'Entidad' = Isnull(@NombreEntidad, '')
                   ,'Moneda Mercado' = CASE
                                         WHEN cacodpos1 = 12 THEN '  T/C PACTADO'
                                         WHEN cacodpos1 = 3 THEN 'UF'
                                         ELSE (SELECT g.mnglosa
                                               FROM   bacparamsuda..moneda g WITH (nolock)
                                               WHERE  g.mncodmon = CASE
                                                                     WHEN a.camdausd = 0 THEN 994
                                                                     ELSE a.camdausd
                                                                   END)
                                       END
                   ,'Cartera' = Isnull(iiiii.tbglosa, '')
                   ,'Mercado' = CASE
                                  WHEN b.clpais = 1 THEN 'L'
                                  ELSE 'E'
                                END
                   ,'Estado' = @cEstado
                   ,'Hora' = CONVERT(CHAR(10), Getdate(), 108)
                   ,'FechaProceso' = @cfecproc
                   ,'Codigo Conversion' = a.cacodmon2
                   ,'Codigo Producto' = a.cacodpos1
                   ,'Equivalente M/N' = a.caequmon2
                   ,'Observa_lineas' = REPLACE(a.caobservlin, @cadena1, @cadena)
                   ,'Observa_limites' = REPLACE(a.caobservlim, @cadena1, @cadena) + CHAR(10) + @MensajeThreshold
                   ,'Aprobador' = a.caautoriza
                   ,'Firma1' = @Firma1
                   ,'Firma2' = @Firma2
                   ,'TasaMon1' = a.catasaefectmon1
                   ,'TasaMon2' = a.catasaefectmon2
                   --,'TCSpot' = a.catipcamspot
                   ,'TCSpot' = a.caSpotTipCam -- a.catipcamspot
                   --,'TCFwd' = CONVERT(NUMERIC(21, 8), a.catipcamfwd)
		   ,'TCFwd' = CONVERT(NUMERIC(21, 8), CASE WHEN c.mnrrda  = 'M' THEN caSpotTipCam * caSpotParidad ELSE caSpotTipCam * (1 /caSpotParidad) END ) -- a.catipcamfwd ) 
                   ,'FecEfect' = a.cafecefectiva
                   ,'Area_Responsable' = Isnull(i.tbglosa, '')
                   ,'Libro' = Isnull(ii.tbglosa, '')
                   ,'Cartera_Normativa' = Isnull(iii.tbglosa, '')
                   ,'SubCartera_Normativa'= Isnull(iiii.tbglosa, '')
                   ,'rTipoCambio' = CASE
                                      WHEN cacodpos2 = 1 THEN 'Dolar Observado'
                                      WHEN cacodpos2 = 2 THEN 'Dolar Mercado'
                                      ELSE '--'
                                    END
                   ,'rParidad' = CASE
                                   WHEN cacolmon1 = 1 THEN 'Reuters 11:00 Hras'
                                   WHEN cacolmon1 = 2 THEN 'Pactada'
                                   WHEN cacolmon1 = 3 THEN 'Banco Central Europeo'
                                   ELSE '--'
                                 END
                   ,'rcacosto_usdclp' = cacosto_usdclp
                   ,'rcacosto_mxusd' = cacosto_mxusd
                   ,'rcacosto_mxclp' = cacosto_mxclp
                   ,'rcafijaTCRef' = cafijatcref
                   ,'rcafijaPRRef' = cafijaprref
		   ,'OpeMxClpRel' = ( ltrim(str(@oper1)) + ' ' + ltrim(str(@oper2)) )
		   ,'TotalExcesoSistema' = @MTOEXCESOSISTEMA
		   ,'TotalExceso' = @mtoExceso
            FROM   mfca_log a WITH (nolock)
                   INNER JOIN bacparamsuda..cliente b WITH (nolock)
                     ON b.clrut = a.cacodigo
                        AND b.clcodigo = a.cacodcli
       INNER JOIN bacparamsuda..moneda c WITH (nolock)
                     ON c.mncodmon = a.cacodmon1
                   INNER JOIN bacparamsuda..moneda d WITH (nolock)
                     ON d.mncodmon = a.cacodmon2
                   INNER JOIN bacparamsuda..producto e WITH (nolock)
                     ON e.id_sistema = 'BFW'
                        AND e.codigo_producto = a.cacodpos1
                   LEFT JOIN bacparamsuda..forma_de_pago l WITH (nolock)
                     ON l.codigo = a.cafpagomn
                   LEFT JOIN bacparamsuda..forma_de_pago x WITH (nolock)
                     ON x.codigo = a.cafpagomx
                   LEFT JOIN bacparamsuda..tabla_general_detalle i WITH (nolock)
                     ON i.tbcateg = @CatAreaResp
                        AND i.tbcodigo1 = a.caarea_responsable
                   LEFT JOIN bacparamsuda..tabla_general_detalle ii WITH (nolock)
                     ON ii.tbcateg = @CatLibro
                        AND ii.tbcodigo1 = a.calibro
                   LEFT JOIN bacparamsuda..tabla_general_detalle iii WITH (nolock)
                     ON iii.tbcateg = @CatCartNorm
                        AND iii.tbcodigo1 = a.cacartera_normativa
                   LEFT JOIN bacparamsuda..tabla_general_detalle iiii WITH (nolock)
                     ON iiii.tbcateg = @CatSubCart
                        AND iiii.tbcodigo1 = a.casubcartera_normativa
                   LEFT JOIN bacparamsuda..tabla_general_detalle iiiii WITH (nolock)
                     ON iiiii.tbcateg = @CatCartFin
                        AND iiiii.tbcodigo1 = a.cacodcart
            WHERE  a.canumoper = @numoper
                   AND a.caestado = 'A'
        END
      ELSE
        BEGIN
		-- SP_PAPELETA_ARB_MON_MX 31628

		if ( select 1 from MFCA where var_moneda2 = @numoper and canumoper != @numoper ) = 1
		begin
			select @oper1=var_moneda2
				  ,@oper2=canumoper
			  from mfca 
			 where var_moneda2 = @numoper
			   and canumoper  != @numoper
		end
		else
		begin
			if ( select 1 from MFCA where canumoper = @numoper and var_moneda2 != @numoper ) = 1
			begin
				select @oper1=var_moneda2
					  ,@oper2=canumoper
				  from mfca
				 where canumoper    = @numoper
				   and var_moneda2 != @numoper
			end 
		End
		set @oper1 = isnull(@oper1, 0)
		set @oper2 = isnull(@oper2, 0)

			/* Totales Exceso */

			SELECT @rutaux = cacodigo
			      ,@cdvaux  = cacodcli
			 FROM MFCA  where (canumoper = @oper1 or canumoper = @oper2) 
	 
			
                        /* TOTAL EXCESO */
			SELECT @MTOEXCESO = b.totalexceso
			FROM   BACLINEAS..LINEA_SISTEMA                        a with (nolock) 
				  INNER JOIN BACLINEAS..LINEA_GENERAL             b with (nolock) ON b.rut_cliente = a.rut_cliente AND b.Codigo_Cliente = a.Codigo_Cliente
				  INNER JOIN BACLINEAS..VIEW_CLIENTE              c with (nolock) ON c.clrut	= a.rut_cliente AND c.clcodigo	     = a.Codigo_Cliente
				  LEFT  JOIN BacParamSuda..MONEDA      m with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,m.mncodmon)))    = b.moneda
				  LEFT  JOIN BacParamSuda..SISTEMA_CNT s with (nolock) ON s.id_sistema =  a.id_sistema
				  LEFT  JOIN BacParamSuda..MONEDA      n with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,n.mncodmon)))    = a.moneda
			WHERE  a.rut_cliente     = @rutaux
			AND    a.Codigo_Cliente  = @cdvaux
			AND    a.id_sistema = 'BFW'

			/* TOTAL EXCESO POR SISTEMA */
			SELECT @MTOEXCESOSISTEMA = SUM( a.totalexceso )
			FROM   BACLINEAS..LINEA_SISTEMA                        a with (nolock) 
				  INNER JOIN BACLINEAS..LINEA_GENERAL             b with (nolock) ON b.rut_cliente = a.rut_cliente AND b.Codigo_Cliente = a.Codigo_Cliente
				  INNER JOIN VIEW_CLIENTE              c with (nolock) ON c.clrut	= a.rut_cliente AND c.clcodigo	     = a.Codigo_Cliente
				  LEFT  JOIN BacParamSuda..MONEDA      m with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,m.mncodmon)))    = b.moneda
				  LEFT  JOIN BacParamSuda..SISTEMA_CNT s with (nolock) ON s.id_sistema =  a.id_sistema
				  LEFT  JOIN BacParamSuda..MONEDA      n with (nolock) ON LTRIM(RTRIM(CONVERT(CHAR,n.mncodmon)))    = a.moneda
			WHERE  a.rut_cliente     = @rutaux
			AND    a.Codigo_Cliente  = @cdvaux

			SET @MTOEXCESOSISTEMA = ISNULL(@MTOEXCESOSISTEMA, 0)
		SET @MTOEXCESO = ISNULL(@MTOEXCESO, 0)

            SELECT 'Numero Operacion' = a.var_moneda2 -- a.canumoper
                   ,'Fecha Inicio' = CONVERT(CHAR(10), a.cafecha, 103)
                   ,'Fecha Vcto' = CONVERT(CHAR(10), a.cafecvcto, 103)
                   ,'Plazo' = a.caplazo
                   ,'Rut Cliente' = a.cacodigo
                   ,'Nombre Cliente' = b.clnombre
                   ,'Tc Inicial' = a.cavalpre --> a.capremon2
                   ,'Precio' = CASE
                                 WHEN a.cacodpos1 = 2 THEN a.caparmon2
                                 -- WHEN a.cacodpos1 = 12 THEN a.caparmon1 
                                 ELSE a.caprecal
                               END
                   ,'Monto MX' = a.camtomon1
                   ,'Precio Futuro' = CONVERT(NUMERIC(21, 8), a.caprecal)
--                   ,'Monto Final' = a.camtomon1 * CONVERT(NUMERIC(21, 8) ,a.catipcam) -- CONVERT(NUMERIC(21,8), a.caprecal)
		   ,'Monto Final' =  a.camtomon1 * CONVERT(NUMERIC(21, 8), a.caprecal) -- a.caequmon2 -- a.camtomon2		
                   ,'Pago MN' = Isnull(l.glosa, 'X')
                   ,'Pago MX' = Isnull(x.glosa, 'X')
                   ,'Modalidad' = a.catipmoda
                   ,'Equivalente M/X' = a.caequusd1 --> a.caequmon1
                   ,'Monto CLP' = CASE
                                    WHEN a.cacodpos1 = 2 THEN 0
                                    ELSE a.caequmon2
                                  END
                   ,'Articulo84' = a.cadiferen
                   ,'Observacion' = a.caobserv
                   ,'Retito' = a.caretiro
                   ,'Operador' = a.caoperador
                   ,'Moneda MX' = c.mnnemo
                   ,'Moneda MN' = 'CLP'
                   ,'Digito V' = b.cldv
                   ,'UF del Dia' = @nvaluf
                   ,'Tipo Operacion' = catipoper
                   ,'Producto' = 'ARBITRAJE MONEDA MX-$' -- lTrim(rTrim(e.descripcion)) + Case when var_moneda2 > 0 Then ' (MX/CLP)' End
                   ,'Nombre Porpietario' = @cnomprop
                   ,'Direccion' = @cdirprop
                   ,'Entidad' = Isnull(@NombreEntidad, '')
                   ,'Moneda Mercado' = CASE
                                         WHEN cacodpos1 = 12 THEN '  T/C PACTADO'
                                         WHEN cacodpos1 = 3 THEN 'UF'
                                         ELSE (SELECT g.mnglosa
                                               FROM   bacparamsuda..moneda g WITH (nolock)
                                               WHERE  g.mncodmon = CASE
                                                                     WHEN a.camdausd = 0 THEN 994
                                                                     ELSE a.camdausd
                                                                   END)
                                       END
                   ,'Cartera' = Isnull(iiiii.tbglosa, '')
                   ,'Mercado' = CASE
                                  WHEN b.clpais = 1 THEN 'L'
                                  ELSE 'E'
                                END
                   ,'Estado' = @cEstado
                   ,'Hora' = CONVERT(CHAR(10), Getdate(), 108)
                   ,'FechaProceso' = @cfecproc
                   ,'Codigo Conversion' = a.cacodmon2
                   ,'Codigo Producto' = a.cacodpos1
                   ,'Equivalente M/N' = a.caequmon2
                   ,'Observa_lineas' = REPLACE(a.caobservlin, @cadena1, @cadena)
                   ,'Observa_limites' = REPLACE(a.caobservlim, @cadena1, @cadena) + CHAR(10) + @MensajeThreshold
          ,'Aprobador' = a.caautoriza
                   ,'Firma1' = @Firma1
                   ,'Firma2' = @Firma2
                   ,'TasaMon1' = a.catasaefectmon1 -- catasa_efectiva_moneda1
                   ,'TasaMon2' = a.catasaefectmon2
                   -- ,'TCSpot' = a.catipcamspot
                   ,'TCSpot' = a.caSpotTipCam -- a.catipcamspot
      		   --,'TCFwd' = CONVERT(NUMERIC(21, 8), a.catipcamfwd)
		   ,'TCFwd' = CONVERT(NUMERIC(21, 8), CASE WHEN c.mnrrda  = 'M' THEN caSpotTipCam * caSpotParidad ELSE caSpotTipCam * (1 /caSpotParidad) END ) -- a.catipcamfwd ) 
                   ,'FecEfect' = a.cafecefectiva
                   ,'Area_Responsable' = Isnull(i.tbglosa, '')
                   ,'Libro' = Isnull(ii.tbglosa, '')
                   ,'Cartera_Normativa' = Isnull(iii.tbglosa, '')
                   ,'SubCartera_Normativa'= Isnull(iiii.tbglosa, '')
                   ,'rTipoCambio' = CASE
                                      WHEN cacodpos2 = 1 THEN 'Dolar Observado'
                                      WHEN cacodpos2 = 2 THEN 'Dolar Mercado'
                                      ELSE '--'
                                    END
                   ,'rParidad' = CASE
                                   WHEN cacolmon1 = 1 THEN 'Reuters 11:00 Hras'
                                   WHEN cacolmon1 = 2 THEN 'Pactada'
                                   WHEN cacolmon1 = 3 THEN 'Banco Central Europeo'
                                   ELSE '--'
                                 END
                   ,'rcacosto_usdclp' = cacosto_usdclp
                   ,'rcacosto_mxusd' = cacosto_mxusd
                   ,'rcacosto_mxclp' = cacosto_mxclp
                   ,'rcafijaTCRef' = cafijatcref
                   ,'rcafijaPRRef' = cafijaprref
		   ,'OpeMxClpRel' = ( ltrim(str(@oper1)) + ' ' + ltrim(str(@oper2)) )
		   ,'TotalExcesoSistema' = @MTOEXCESOSISTEMA
		   ,'TotalExceso' = @mtoExceso
            FROM   mfca a WITH (nolock)
                   INNER JOIN bacparamsuda..cliente b WITH (nolock)
                     ON b.clrut = a.cacodigo
                        AND b.clcodigo = a.cacodcli
                   INNER JOIN bacparamsuda..moneda c WITH (nolock)
                     ON c.mncodmon = a.cacodmon1
                   INNER JOIN bacparamsuda..moneda d WITH (nolock)
                     ON d.mncodmon = a.cacodmon2
                   INNER JOIN bacparamsuda..producto e WITH (nolock)
                     ON e.id_sistema = 'BFW'
                        AND e.codigo_producto = a.cacodpos1
                   LEFT JOIN bacparamsuda..forma_de_pago l WITH (nolock)
                     ON l.codigo = a.cafpagomn
                   LEFT JOIN bacparamsuda..forma_de_pago x WITH (nolock)
                     ON x.codigo = a.cafpagomx
                   LEFT JOIN bacparamsuda..tabla_general_detalle i WITH (nolock)
                     ON i.tbcateg = @CatAreaResp
                        AND i.tbcodigo1 = a.caarea_responsable
                   LEFT JOIN bacparamsuda..tabla_general_detalle ii WITH (nolock)
                     ON ii.tbcateg = @CatLibro
                        AND ii.tbcodigo1 = a.calibro
                   LEFT JOIN bacparamsuda..tabla_general_detalle iii WITH (nolock)
                     ON iii.tbcateg = @CatCartNorm
                        AND iii.tbcodigo1 = a.cacartera_normativa
                   LEFT JOIN bacparamsuda..tabla_general_detalle iiii WITH (nolock)
                     ON iiii.tbcateg = @CatSubCart
                        AND iiii.tbcodigo1 = a.casubcartera_normativa
                   LEFT JOIN bacparamsuda..tabla_general_detalle iiiii WITH (nolock)
                     ON iiiii.tbcateg = @CatCartFin
                        AND iiiii.tbcodigo1 = a.cacodcart
            WHERE  a.canumoper = @numoper

        END
END
GO
