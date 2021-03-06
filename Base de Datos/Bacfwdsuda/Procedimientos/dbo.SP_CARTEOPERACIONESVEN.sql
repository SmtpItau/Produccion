USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTEOPERACIONESVEN]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- sp_carteoperacionesven 0, 0, 0, 0, 0, 0, '', '',0,0,'','','1111','1554','1552','','',''
CREATE PROCEDURE [dbo].[SP_CARTEOPERACIONESVEN] ( @norden       FLOAT,			--0
                                          @nentidad     FLOAT,				--0
                                          @ncodpos      FLOAT,				--0
                                          @ncodmda      FLOAT,				--0
                                          @nrutcli      FLOAT,				--0
                                          @nnumoper     FLOAT,				--0
                                          @cfecproc     VARCHAR    ( 08 ),		--''
                                          @cfecvcto     VARCHAR    ( 08 ),		--''
                                          @nentrefechas FLOAT,				--0
                                          @nfecinivcto  FLOAT,				--0
                                          @dfecdesde    CHAR    ( 08 ),			--''
                                          @dfechasta    CHAR    ( 08 ),			--''
                                          @cat_cartnorm CHAR    ( 06 ) = '',		--'1111'
                                          @cat_subcart	CHAR	( 06 ) = '',		--'1554'
                                          @cat_libro	CHAR	( 06 ) = '',		--'1552'
                                          @Id_CartNorm		CHAR    ( 06 ) = '',	--''
                                          @Id_SubCartNorm	CHAR	( 06 ) = '',	--''
                                          @Id_Libro		CHAR	( 06 ) = ''	--''
                                         )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @dfecproc    DATETIME
   DECLARE @cnomprop    CHAR(40)
   DECLARE @cdirprop    CHAR(40)
   DECLARE @cselect     VARCHAR(255)
   DECLARE @cdesde      VARCHAR(255)
   DECLARE @chasta      VARCHAR(255)
   DECLARE @corden      VARCHAR(255)
	,	@Glosa_Libro	CHAR(50)

  IF  @id_libro = '' BEGIN
	SELECT @Glosa_libro = '< TODOS >'	
  END 
  ELSE BEGIN
	SELECT	@Glosa_libro	= tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbcateg		= @Cat_Libro 
	AND	tbcodigo1	= @Id_Libro
  END



   SELECT @dfecproc = acfecproc  ,
          @cnomprop = acnomprop  ,
          @cdirprop = acdirprop   
   FROM mfac


   SELECT @cselect = 'SELECT * FROM #tmpmfcah '
   IF @dfecdesde = '' AND @nentrefechas = 1 BEGIN
      SELECT @dfecdesde = CONVERT ( CHAR ( 08 ), @dfecproc, 112 )
   END
   IF @dfechasta = '' AND @nentrefechas = 1 BEGIN
      SELECT @dfechasta = CONVERT ( CHAR ( 08 ), @dfecproc, 112 )
   END
   IF @cfecproc <> '' BEGIN
      SELECT @cselect = @cselect + ' WHERE CONVERT ( DATETIME, fproc ) = ''' + @cfecproc + ''' '
   END
   IF @cfecproc <> '' AND @cfecvcto <> '' BEGIN
      SELECT @cselect = @cselect + ' AND CONVERT ( DATETIME, fvcto ) = ''' + @cfecvcto + ''' '
   END ELSE IF @cfecvcto <> '' BEGIN
      SELECT @cselect = @cselect + ' WHERE CONVERT ( DATETIME, fvcto ) = ''' + @cfecvcto + ''' '
   END
   IF @cfecproc <> '' AND @cfecvcto <> '' AND @nentrefechas = 1 BEGIN
      SELECT @cdesde = ' AND CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END >= CONVERT ( DATETIME, ''' + @dfecdesde + ''' ) AND '
      SELECT @chasta =     ' CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END <= CONVERT ( DATETIME, ''' + @dfechasta + ''' ) '
   END ELSE IF @cfecvcto <> '' AND @nentrefechas = 1 BEGIN
      SELECT @cdesde = ' AND CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END >= CONVERT ( DATETIME, ''' + @dfecdesde + ''' ) AND '
      SELECT @chasta =     ' CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END <= CONVERT ( DATETIME, ''' + @dfechasta + ''' ) '
   END ELSE IF @nentrefechas = 1 BEGIN
      SELECT @cdesde = ' WHERE CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END >= CONVERT ( DATETIME, ''' + @dfecdesde + ''' ) AND '
      SELECT @chasta =       ' CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END <= CONVERT ( DATETIME, ''' + @dfechasta + ''' ) '
   END
   IF @norden = 0 BEGIN
      SELECT @corden = ' ORDER BY NroOperacion'
   END ELSE IF @norden = 1 BEGIN
      SELECT @corden = ' ORDER BY NomCliente'
   END ELSE IF @norden = 2 BEGIN
      SELECT @corden = ' ORDER BY MonedaConver'
   END ELSE IF @norden = 3 BEGIN
      SELECT @corden = ' ORDER BY fproc'
   END ELSE IF @norden = 4 BEGIN
      SELECT @corden = ' ORDER BY fvcto'
   END
   SELECT @cselect = ISNULL ( RTRIM ( @cselect ), '' ),
          @cdesde  = ISNULL ( RTRIM ( @cdesde  ), '' ),
          @chasta  = ISNULL ( RTRIM ( @chasta  ), '' ),
          @corden  = ISNULL ( RTRIM ( @corden  ), '' )
   SELECT   'NroOperacion' = a.canumoper                          ,
            'NomCliente'   = b.clnombre                           ,
            'TipoOperacion'= a.catipoper                          ,
            'FechaVcto'    = CONVERT( CHAR(10), a.cafecvcto, 103 ),
            'MonedaConver' = c.mnnemo                             ,
            'MontoOrigen'  = a.camtomon1                          ,
            'Producto'     = d.descripcion                        ,
            'FechaCompra'  = CONVERT( CHAR(10), a.cafecha, 103 )  , 
            'FechaProceso' = CONVERT( CHAR(10), @dfecproc, 103 )  ,
            'Plazo'        = a.caplazo                            ,
            'MonedaOrigen' = e.mnnemo                             ,
            'Precio'       = a.catipcam                           ,
            'MontoConver'  = a.camtomon2                          , 
            'NombrePropie' = @cnomprop                            ,
            'DireccPropie' = @cdirprop                            ,
            'fvcto'        = CONVERT( CHAR(8), a.cafecvcto, 112 ),
            'fproc'        = CONVERT( CHAR(8), a.cafecha, 112 )  ,
            'tipoproducto' = a.cacodpos1     ,
	    'HoraOp'     = a.cahora    ,
	    'Hora_Repor'   = CONVERT(CHAR(8),GETDATE(),108) ,
	    'Modal'       = a.catipmoda          ,
            'cartera norm' = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
            'subcartera'   = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcart  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
            'libro'        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro  AND tbcodigo1 = calibro),'No Especificado') ,
	    'Glosa_Libro'	= @Glosa_Libro,
            'Estado_Sinacofi'    = Estado_Sinacofi
   INTO     #tmpmfcah
   FROM     mfcah         a,
            view_cliente  b,
            view_moneda   c,
            view_producto d,
            view_moneda   e
   WHERE   (a.cacodigo         = b.clrut      AND
            a.cacodcli         = b.clcodigo ) AND 
            a.cacodmon2        = c.mncodmon   AND
            a.cacodmon1        = e.mncodmon   AND
            d.id_sistema       = 'BFW'        AND
            d.codigo_producto  = a.cacodpos1  AND
           (a.cacodsuc1        = @nentidad    OR
            @nentidad          = 0          ) AND
           (a.cacodpos1        = @ncodpos     OR
            @ncodpos           = 0          ) AND
           (a.cacodmon1        = @ncodmda     OR
            a.cacodmon2        = @ncodmda     OR
            @ncodmda           = 0          ) AND
           (a.cacodigo         = @nrutcli     OR
            @nrutcli           = 0          ) AND
           (a.canumoper        = @nnumoper    OR
            @nnumoper          = 0          )
	AND	(cacartera_normativa	= @Id_CartNorm		OR @Id_CartNorm		= '')
	AND	(casubcartera_normativa	= @Id_SubCartNorm	OR @Id_SubCartNorm	= '')
	AND	(calibro		= @id_libro		OR @id_libro		= '')
   ORDER BY a.canumoper

   INSERT   #tmpmfcah
   SELECT   a.canumoper                          ,
            b.clnombre                           ,
            a.catipoper                          ,
            CONVERT( CHAR(10), a.cafecvcto, 103 ),
            c.mnnemo                             ,
            a.camtomon1                          ,
            d.descripcion                        ,
            CONVERT( CHAR(10), a.cafecha, 103 )  ,
            CONVERT( CHAR(10), @dfecproc, 103 )  ,
            a.caplazo                            ,
            e.mnnemo                             ,
            a.catipcam                           ,
            a.camtomon2                          ,
            @cnomprop                            ,
            @cdirprop                            ,
            CONVERT( CHAR(8), a.cafecvcto, 112 ),
            CONVERT( CHAR(8), a.cafecha, 112 )  ,
            a.cacodpos1     ,
     a.cahora    ,
     CONVERT(CHAR(8),GETDATE(),108) ,
     a.catipmoda          ,
           'cartera norm'  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
           'subcartera'    = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcart  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
           'libro'         = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro  AND tbcodigo1 = calibro),'No Especificado'),
	       'Glosa_Libro'	= @Glosa_Libro,
           'Estado_Sinacofi'    = Estado_Sinacofi
   FROM     mfca  a,
            view_cliente  b,
            view_moneda   c,
            view_producto d,
            view_moneda   e
   WHERE    a.cafecvcto       = @dfecproc    AND
           (a.cacodigo        = b.clrut      AND
            a.cacodcli        = b.clcodigo ) AND 
            a.cacodmon2       = c.mncodmon   AND
            a.cacodmon1       = e.mncodmon   AND
            d.id_sistema      = 'BFW'        AND
            d.codigo_producto = a.cacodpos1  AND
           (a.cacodsuc1       = @nentidad    OR
            @nentidad         = 0          ) AND
           (a.cacodpos1       = @ncodpos     OR
            @ncodpos          = 0          ) AND
           (a.cacodmon1       = @ncodmda     OR
            a.cacodmon2       = @ncodmda     OR
            @ncodmda          = 0          ) AND
           (a.cacodigo        = @nrutcli     OR
            @nrutcli          = 0          ) AND
           (a.canumoper       = @nnumoper    OR
            @nnumoper         = 0          )
	AND	(cacartera_normativa	= @Id_CartNorm		OR @Id_CartNorm		= '')
	AND	(casubcartera_normativa	= @Id_SubCartNorm	OR @Id_SubCartNorm	= '')
	AND	(calibro		= @id_libro		OR @id_libro		= '')
   ORDER BY a.canumoper

   EXECUTE ( @cselect + @cdesde + @chasta + @corden)
   SET NOCOUNT OFF
   RETURN 0
END


GO
