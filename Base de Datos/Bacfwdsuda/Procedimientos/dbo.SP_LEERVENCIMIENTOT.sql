USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERVENCIMIENTOT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LEERVENCIMIENTOT]
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @cnomprop   CHAR(40)
   DECLARE @cdirprop   CHAR(40)
   DECLARE @cfecproc   CHAR(10)
   DECLARE @dfecproc   DATETIME
   DECLARE @nvaluf     FLOAT  
   DECLARE @nvalob     FLOAT

   SELECT @cnomprop = acnomprop                          ,
          @cdirprop = acdirprop                          , 
          @dfecproc = acfecproc                          ,
          @cfecproc = CONVERT(CHAR(10), acfecproc, 103 ) ,
          @nvaluf   = b.vmvalor                          ,
          @nvalob   = c.vmvalor                          
   FROM   mfac                ,
          mfca              a ,
   view_valor_moneda b ,
   view_valor_moneda c
   WHERE  b.vmcodigo = accodmonuf     AND
          b.vmfecha  = acfecproc      AND
          c.vmcodigo = accodmondolobs AND
          c.vmfecha  = acfecproc

   IF EXISTS(	SELECT 1
		FROM	mfca         a ,
			view_cliente
		WHERE	cafecvcto  = @dfecproc AND
			clrut      = cacodigo   AND
			clcodigo   = cacodcli   AND
			cacodpos1 NOT IN (4, 5, 6 )) OR EXISTS(SELECT 1 FROM TBL_CARTERA_FLUJOS WHERE Ctf_Fecha_Vencimiento = @dfecproc)
   BEGIN

	   SELECT  'rut cliente'     = clrut                                   ,
                   'nombre cliente'  = clnombre                                ,
                   'TotalPagarClp'   = ( SELECT ISNULL ( SUM ( CASE	WHEN caantici = 'A' AND camtoliq < 0  THEN
										ABS(camtoliq)  
									WHEN catipmoda = 'C' AND camtocomp < 0   THEN
										ABS(camtocomp )
									WHEN	catipmoda = 'E' AND
										catipoper = 'C' AND
										(cacodpos1 = 1   OR
										cacodpos1 = 7   OR
										cacodpos1 = 8 ) AND
										cacodmon2 = 999 THEN
										ABS(camtomon2 )
									WHEN	catipmoda = 'E' AND
										catipoper = 'C' AND
										( cacodpos1 = 1   OR
										cacodpos1 = 7   OR
										cacodpos1 = 8 ) AND
										cacodmon2 = 998 THEN
										ABS ( ROUND ( camtomon2 * @nvaluf, 0 ) )
									ELSE
										0
									END  ), 0 )
                                         FROM   mfca
                                         WHERE  cacodigo   = clrut     AND
                                                cafecvcto  = @dfecproc AND
                                                cacodpos1 <> 4         AND
                                                cacodpos1 <> 5         AND
                                                cacodpos1 <> 6         AND
                                                cacodpos1 <> 9 )                                         ,
                   'TotalRecibirClp' = ( SELECT ISNULL ( SUM ( CASE
                                                               	  WHEN caantici = 'A' AND camtoliq >= 0  THEN 
									camtoliq
			                                          WHEN catipmoda = 'C' AND
                                                                    camtocomp >= 0   THEN
                                                                    camtocomp 
                                                               	  WHEN   catipmoda = 'E' AND
                                                                      catipoper = 'V' AND
                                                                    ( cacodpos1 = 1   OR
                                                                      cacodpos1 = 7   OR
                                                                      cacodpos1 = 8 ) AND
                                                                      cacodmon2 = 999 THEN
                                                                  ABS ( camtomon2 )
                                                               WHEN   catipmoda = 'E' AND
                                                                      catipoper = 'V' AND
								     ( cacodpos1 = 1   OR
                                                                      cacodpos1 = 7   OR
                                                                      cacodpos1 = 8 ) AND
                                                                      cacodmon2 = 998 THEN
                                                                  ABS ( ROUND ( camtomon2 * @nvaluf, 0 ) )
                                                               ELSE
                                                                  0
                                                               END  ), 0 )
                                         FROM   mfca
                                         WHERE  cacodigo   = clrut     AND
                                                cafecvcto  = @dfecproc AND
                                                cacodpos1 <> 4         AND
                                                cacodpos1 <> 5         AND
                                                cacodpos1 <> 6         AND 
                                                cacodpos1 <> 9 )                                         ,
                   'TotalPagarUSD'   = ( SELECT ISNULL ( SUM ( camtomon2 ), 0 )
                                         FROM   mfca
                                         WHERE  cacodigo   = clrut     AND
                                                catipoper  = 'C'       AND
                                                cafecvcto  = @dfecproc AND
                                                catipmoda  = 'E'       AND
                                                cacodpos1  = 2 )                                         ,
                   'TotalRecibirUSD' = ( SELECT ISNULL ( SUM ( camtomon2 ), 0 )
                                         FROM   mfca
                                         WHERE  cacodigo   = clrut     AND
                                                catipoper  = 'V'       AND
                                                cafecvcto  = @dfecproc AND
                                                catipmoda  = 'E'       AND
                                                cacodpos1  = 2 )                                         ,
                'Fecha Proceso'      = @cfecproc                                                         ,
                'ValorUF'            = @nvaluf                                                           ,
                'ValorObs'           = @nvalob                                                           ,
                'Hora'               = CONVERT( CHAR(10), getdate(), 108 )    ,
  'entidad'=@cnomprop
   FROM   mfca         a ,
          view_cliente
   WHERE  cafecvcto  = @dfecproc AND
          (clrut = cacodigo   AND
          clcodigo   = cacodcli )  AND
          cacodpos1 NOT IN (4, 5, 6, 10)
   GROUP BY CLRUT,CLCODIGO,CLNOMBRE

   UNION

   SELECT 'rut cliente'     = clrut
   ,      'nombre cliente'  = clnombre
   ,      'TotalPagarClp'   = ABS(SUM(CASE WHEN cavalordia <  0 THEN cavalordia ELSE 0 END))
   ,      'TotalRecibirClp' = SUM(CASE WHEN cavalordia >= 0 THEN cavalordia ELSE 0 END)
   ,      'TotalPagarUSD'   = 0.0
   ,      'TotalRecibirUSD' = 0.0
   ,      'Fecha Proceso'   = @cfecproc
   ,      'ValorUF'         = @nvaluf
   ,      'ValorObs'        = @nvalob
   ,      'Hora'            = CONVERT(CHAR(10),GETDATE(),108)
   ,      'entidad'         = @cnomprop
   FROM   MFCA              a
                            LEFT JOIN bacparamsuda..CLIENTE ON a.cacodigo = clrut and a.cacodcli = clcodigo
   ,      MFAC
   WHERE  cafecvcto         = acfecproc
   AND    cacodpos1         = 10
   GROUP BY clrut,clcodigo,clnombre

	UNION
	
	SELECT 'rut cliente'     = clrut
	,      'nombre cliente'  = clnombre
	,      'TotalPagarClp'   = CASE WHEN SUM(ROUND(CASE	WHEN a.catipoper = 'C' 
								THEN (ROUND(FL.Ctf_Monto_Principal * @nvaluf,0) - FL.Ctf_Monto_Secundario) 
							ELSE	(FL.Ctf_Monto_Secundario - ROUND(FL.Ctf_Monto_Principal * @nvaluf,0))
						END,0)) < 0 
					THEN ABS(SUM(ROUND(CASE	WHEN a.catipoper = 'C' 
								THEN (ROUND(FL.Ctf_Monto_Principal * @nvaluf,0) - FL.Ctf_Monto_Secundario) 
							ELSE	(FL.Ctf_Monto_Secundario - ROUND(FL.Ctf_Monto_Principal * @nvaluf,0))
						END,0)))
					ELSE 0.0	END	--ABS(SUM(CASE WHEN camtocomp <  0 THEN camtocomp ELSE 0 END))
	,      'TotalRecibirClp' = CASE WHEN SUM(ROUND(CASE	WHEN a.catipoper = 'C' 
								THEN (ROUND(FL.Ctf_Monto_Principal * @nvaluf,0) - FL.Ctf_Monto_Secundario) 
							ELSE	(FL.Ctf_Monto_Secundario - ROUND(FL.Ctf_Monto_Principal * @nvaluf,0))
						END,0)) > 0 
					THEN SUM(ROUND(CASE	WHEN a.catipoper = 'C' 
								THEN (ROUND(FL.Ctf_Monto_Principal * @nvaluf,0) - FL.Ctf_Monto_Secundario) 
							ELSE	(FL.Ctf_Monto_Secundario - ROUND(FL.Ctf_Monto_Principal * @nvaluf,0))
						END,0))
					ELSE 0.0 	END--SUM(CASE WHEN camtocomp >= 0 THEN camtocomp ELSE 0 END)
	,      'TotalPagarUSD'   = 0.0
	,      'TotalRecibirUSD' = 0.0
	,      'Fecha Proceso'   = @cfecproc
	,      'ValorUF'         = @nvaluf
	,      'ValorObs'        = @nvalob
	,      'Hora'            = CONVERT(CHAR(10),GETDATE(),108)
	,      'entidad'         = @cnomprop
	FROM	MFCA              a	LEFT JOIN bacparamsuda..CLIENTE ON a.cacodigo = clrut and a.cacodcli = clcodigo
	,	TBL_CARTERA_FLUJOS	FL
--	,	MFAC
	WHERE	a.canumoper			= FL.Ctf_Numero_OPeracion
	AND	FL.Ctf_Fecha_Vencimiento	= @dfecproc
	AND	cacodpos1			= 13
	GROUP 
	BY	clrut
	,	clcodigo
	,	clnombre

   END
   
   ELSE
   BEGIN
   SELECT 'rut cliente'     = 0,
          'nombre cliente'  = '',
          'TotalPagarClp'   = 0,
          'TotalRecibirClp' = 0,
          'TotalPagarUSD'   = 0,
          'TotalRecibirUSD' = 0,
          'Fecha Proceso'      = @cfecproc                                                         ,
          'ValorUF'            = @nvaluf                                                           ,
          'ValorObs'           = @nvalob                                                           ,
          'Hora'               = CONVERT( CHAR(10), getdate(), 108 ),
  'entidad'=@cnomprop
   END  
   SET NOCOUNT OFF
END

GO
