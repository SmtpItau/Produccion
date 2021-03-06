USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETA_BTL]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[SP_PAPELETA_BTL]	(	@nNumOperacion   NUMERIC(10)   = 0
					,	@Usuario         VARCHAR(15)   = 'ADMINISTRA'
					,	@Sistema         CHAR(3)       = 'BFW'  
					)
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Supervisor1  CHAR(20)
   ,       @Supervisor2  CHAR(20)
   ,       @Operador     CHAR(20)
   ,       @Autoriza     CHAR(20)

   SELECT  @Supervisor1     = ' '
   ,       @Supervisor2     = ' '
   ,       @Operador        = ' '
   ,       @Autoriza        = ' '

   SELECT  @Supervisor1     = Firma1
   ,       @Supervisor2     = Firma2
   ,       @Operador        = Operador_Origen
   ,       @Autoriza        = Operador_Autoriza
   FROM    baclineas..DETALLE_APROBACIONES
   WHERE   Numero_Operacion = @nNumOperacion


   IF EXISTS(SELECT 1 FROM bacfwdsuda..MFCA_LOG WHERE canumoper = @nNumOperacion AND caestado = 'A' )
   BEGIN

      SELECT 'NumeroOperacion'  = canumoper
      ,      'RutCliente'       = clrut -- LTRIM(RTRIM(CONVERT(CHAR(10),clrut))) + '-' + cldv
      ,      'DvCliente'        = cldv
      ,      'CodCliente'       = clcodigo
      ,      'NomCliente'       = clnombre
      ,      'DirCliente'       = cldirecc
      ,      'Cartera'          = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '204' AND tbcodigo1 = cacodcart),'NO ENCONTRADA')    -- cacodcart
      ,      'NumeroContrato'   = canumoper
      ,      'FechaInicio'      = CONVERT(CHAR(10),cafecha,103)
      ,      'FechaVencimiento' = CONVERT(CHAR(10),cafecvcto,103)
      ,      'DiasContrato'     = caplazo
      ,      'MonInstrumento'   = Mon1.mnnemo -- cacodmon1
      ,      'MonPago'          = Mon2.mnnemo -- cacodmon2
      ,      'ValorMonedaOp'    = capremon2 --caspread
      ,      'Nominales'        = camtomon1
      ,      'TasaForward'      = ROUND(CONVERT(NUMERIC(21,7),catipcam),7)
      ,      'TasaMercado'      = ROUND(CONVERT(NUMERIC(21,7),capremon1),7)
      ,      'ValorPresente'    = ROUND(CONVERT(NUMERIC(21,4),caequmon1),4)
      ,      'ValorMercado'     = ROUND(CONVERT(NUMERIC(21,4),caequusd2),4)
      ,      'Articulo84_81'    = CaDiferen -- CASE WHEN cadiferen > 0 THEN ROUND(CONVERT(NUMERIC(21,4),cadiferen),4)  ELSE 0 END
      ,      'FormaPagoMn'      = Pag1.glosa       -- cafpagomn
      ,      'FormaPagoMx'      = 'NO APLICA'      -- cafpagomx
      ,      'Modalidad'        = CASE WHEN catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,      'TipoOperacion'    = CASE WHEN catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
      ,      'Retiro'           = CASE WHEN caretiro = 1    THEN 'VAMOS'        ELSE 'VIENEN'         END
      ,      'Serie'            = caserie
      ,      'Seriado'          = caseriado
      ,      'Observa_lineas'   = caobservlin -- replace(replace(caobservlin , char(10),' ') , char(13),'..') 
      ,      'Observa_limites'  = caobservlim --replace(replace(caobservlim , char(10),' ')  , char(13),'..') 
      ,      'Aprobador'        = caautoriza
      ,      'EstadoOperacion'  = CASE WHEN caestado = 'P' THEN 'PENDIENTE'
                                       WHEN caestado = 'A' THEN 'ANULADA'
                                       WHEN caestado = 'R' THEN 'RECHAZADA'
                                       WHEN caestado = ' ' THEN 'APROBADA'
                                  END
      ,      'FechaProceso'     = CONVERT(CHAR(10),acfecproc,103)
      ,      'FechaEmision'     = CONVERT(CHAR(10),GETDATE(),103)
      ,      'HoraEmision'      = CONVERT(CHAR(10),GETDATE(),108)
      ,      'Observacion'      = caobserv   
      ,      'Usuario'          = @Usuario -- 'BAC-' + RTRIM(LTRIM(sis.nombre_sistema)) + '/' +  @Usuario
      ,      'Titulo'           = 'PAPELETA DE OPERACIONES'
      ,      'SubTitulo'        = 'Forward Treasury Lock'
      ,      'Operacion'        = CASE WHEN catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END
      ,      'Supervisor1'      = @Supervisor1 
      ,      'Supervisor2'      = @Supervisor2
      ,      'Operador'         = @Operador
      ,      'Autoriza'         = @Autoriza
      ,      'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1552' AND tbcodigo1 = calibro),'NO ENCONTRADA')
      ,	     'CarteraSuper'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1111' AND tbcodigo1 = cacartera_normativa),'NO ENCONTRADA')
      ,	     'SubCarteraSuper'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1554' AND tbcodigo1 = casubcartera_normativa),'NO ENCONTRADA')
      ,      'VPteorico'        = camtomon1fin  
      ,      'Area_Responsable' = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1553' AND tbcodigo1 = caArea_Responsable),'NO ENCONTRADA')          
      FROM   BACFWDSUDA..MFCA_LOG LEFT JOIN bacparamsuda..CLIENTE                     ON cacodigo  = clrut AND cacodcli = clcodigo
                                  LEFT JOIN bacparamsuda..MONEDA        AS Mon1       ON cacodmon1 = Mon1.mncodmon
                                  LEFT JOIN bacparamsuda..MONEDA        AS Mon2       ON cacodmon2 = Mon2.mncodmon
                                  LEFT JOIN bacparamsuda..FORMA_DE_PAGO AS Pag1       ON cafpagomn = Pag1.codigo
      ,      bacparamsuda..SISTEMA_CNT  AS sis
      ,      bacfwdsuda..MFAC
      WHERE  canumoper          = @nNumOperacion 
      AND    sis.id_sistema     = @Sistema
      ORDER BY canumoper        DESC

   END ELSE
   BEGIN

      SELECT 'NumeroOperacion'  = canumoper
      ,      'RutCliente'       = clrut -- LTRIM(RTRIM(CONVERT(CHAR(10),clrut))) + '-' + cldv
      ,      'DvCliente'        = cldv
      ,      'CodCliente'       = clcodigo
      ,      'NomCliente'       = clnombre
      ,      'DirCliente'       = cldirecc
      ,      'Cartera'          = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '204' AND tbcodigo1 = cacodcart),'NO ENCONTRADA')    -- cacodcart
      ,      'NumeroContrato'   = canumoper
      ,      'FechaInicio'      = CONVERT(CHAR(10),cafecha,103)
      ,      'FechaVencimiento' = CONVERT(CHAR(10),cafecvcto,103)
      ,      'DiasContrato'     = caplazo
      ,      'MonInstrumento'   = Mon1.mnnemo -- cacodmon1
      ,      'MonPago'          = Mon2.mnnemo -- cacodmon2
      ,      'ValorMonedaOp'    = capremon2 --caspread
      ,      'Nominales'        = camtomon1
      ,      'TasaForward'      = ROUND(CONVERT(NUMERIC(21,7),catipcam),7)
      ,      'TasaMercado'      = ROUND(CONVERT(NUMERIC(21,7),capremon1),7)
      ,      'ValorPresente'    = ROUND(CONVERT(NUMERIC(21,4),caequmon1),4)
      ,      'ValorMercado'     = ROUND(CONVERT(NUMERIC(21,4),caequusd2),4)
      ,      'Articulo84_81'    = cadiferen -- CASE WHEN cadiferen > 0 THEN ROUND(CONVERT(NUMERIC(21,4),cadiferen),4)  ELSE 0 END
      ,      'FormaPagoMn'      = Pag1.glosa    -- cafpagomn
      ,      'FormaPagoMx'      = 'NO APLICA'   -- cafpagomx
      ,      'Modalidad'        = CASE WHEN catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,      'TipoOperacion'    = CASE WHEN catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
      ,      'Retiro'           = CASE WHEN caretiro = 1    THEN 'VAMOS'        ELSE 'VIENEN'         END
      ,      'Serie'            = caserie
      ,      'Seriado'          = caseriado
      ,      'Observa_lineas'   = caobservlin -- replace(replace(caobservlin , char(10),' ') , char(13),'..') 
      ,      'Observa_limites'  = caobservlim --replace(replace(caobservlim , char(10),' ')  , char(13),'..') 
      ,      'Aprobador'        = caautoriza
      ,      'EstadoOperacion'  = CASE WHEN caestado = 'P' THEN 'PENDIENTE'
                                       WHEN caestado = 'A' THEN 'ANULADA'
                                       WHEN caestado = 'R' THEN 'RECHAZADA'
                                       WHEN caestado = ' ' THEN 'APROBADA'
                                  END
      ,      'FechaProceso'     = CONVERT(CHAR(10),acfecproc,103)
      ,      'FechaEmision'     = CONVERT(CHAR(10),GETDATE(),103)
      ,      'HoraEmision'      = CONVERT(CHAR(10),GETDATE(),108)
      ,      'Observacion'      = caobserv   
      ,      'Usuario'          = @Usuario --'BAC-' + RTRIM(LTRIM(sis.nombre_sistema)) + '/' +  @Usuario
      ,      'Titulo'           = 'PAPELETA DE OPERACIONES'
      ,      'SubTitulo'        = 'Forward Treasury Lock'
      ,      'Operacion'        = CASE WHEN catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END
                                  -- 'COMPRA ' + ltrim(rtrim(Mon1.mnnemo)) + ' /   VENTA ' + ltrim(rtrim(Mon2.mnnemo))
      ,      'Supervisor1'      = @Supervisor1 
      ,      'Supervisor2'      = @Supervisor2
      ,      'Operador'         = @Operador
      ,      'Autoriza'         = @Autoriza
      ,      'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1552' AND tbcodigo1 = calibro),'NO ENCONTRADA')
      ,	     'CarteraSuper'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1111' AND tbcodigo1 = cacartera_normativa),'NO ENCONTRADA')
      ,	     'SubCarteraSuper'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1554' AND tbcodigo1 = casubcartera_normativa),'NO ENCONTRADA')
      ,      'VPteorico'        = camtomon1fin
      ,      'Area_Responsable' = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = '1553' AND tbcodigo1 = caArea_Responsable),'NO ENCONTRADA')
      FROM   BACFWDSUDA..MFCA   LEFT JOIN bacparamsuda..CLIENTE                     ON cacodigo  = clrut AND cacodcli = clcodigo
                                LEFT JOIN bacparamsuda..TIPO_CARTERA                ON rcsistema = 'BFW' AND rccodpro = cacodpos1 AND rcrut = cacodcart
                                LEFT JOIN bacparamsuda..MONEDA        AS Mon1       ON cacodmon1 = Mon1.mncodmon
                                LEFT JOIN bacparamsuda..MONEDA        AS Mon2       ON cacodmon2 = Mon2.mncodmon
                                LEFT JOIN bacparamsuda..FORMA_DE_PAGO AS Pag1       ON cafpagomn = Pag1.codigo
      ,      BACPARAMSUDA..SISTEMA_CNT  AS sis
      ,      BACFWDSUDA..MFAC
      WHERE  canumoper          = @nNumOperacion 
      AND    sis.id_sistema     = @Sistema
      ORDER BY canumoper        DESC

   END

END




-- dbo.SP_PAPELETA_FBT 8530


GO
