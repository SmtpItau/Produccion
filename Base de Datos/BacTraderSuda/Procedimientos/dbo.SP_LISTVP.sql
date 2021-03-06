USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTVP]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- SP_LISTVP 0, 'T', 'MOVIMIENTO DIARIO DE VENTAS DEFINITIVAS NEGOCIACION', 0, 1552, '', 0


CREATE PROCEDURE [dbo].[SP_LISTVP]
   (   @entidad      FLOAT        = 0
   ,   @carterasuper CHAR(1)      = ''
   ,   @titulo       VARCHAR(200) = ''
   ,   @Cartera_Inv  INTEGER
   ,   @Cat_Libro    CHAR(06)	  = ''
   ,   @Id_Libro     CHAR(06)     = ''
   ,   @CartPM       INTEGER      = 0 -- 0: Informe Cartera Normal; 1: Informe Cartera PM
   )
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @ncartini  NUMERIC(10,0)
   DECLARE @ncartfin  NUMERIC(10,0) 
   DECLARE @numero    INTEGER

   SELECT @ncartini  = @entidad 
   SELECT @ncartfin  = CASE WHEN @entidad  = 0 THEN 999999999 ELSE @entidad END

   DECLARE @acfecproc      CHAR(10)
          ,@acfecprox      CHAR(10)
          ,@uf_hoy         FLOAT
          ,@uf_man         FLOAT
          ,@ivp_hoy        FLOAT
          ,@ivp_man        FLOAT
          ,@do_hoy         FLOAT
          ,@do_man         FLOAT
          ,@da_hoy         FLOAT
          ,@da_man         FLOAT
          ,@acnomprop      CHAR(40)
          ,@rut_empresa    CHAR(12)
          ,@hora           CHAR(8)
	  ,@Glosa_Cartera  CHAR(20)
	  ,@Glosa_Libro	   CHAR(50)



   SELECT @Glosa_Cartera = '' 

   SELECT DISTINCT
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   bacparamsuda..TIPO_CARTERA
   WHERE  rcsistema      = 'BTR'
   AND    rcrut          = @Cartera_INV
-- ORDER BY rcrut  está demás, además sql 2005 no lo soporta

   IF @Glosa_Cartera = '' 
      SELECT @Glosa_Cartera = '< TODAS >'

  IF  @id_libro = '' BEGIN
	SELECT @Glosa_libro = '< TODOS >'	
  END 
  ELSE BEGIN
	SELECT	@Glosa_libro	= tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbcateg		= @Cat_Libro 
	AND	tbcodigo1	= @Id_Libro
  END

   EXECUTE SP_BASE_DEL_INFORME
           @acfecproc   OUTPUT
   ,       @acfecprox   OUTPUT
   ,       @uf_hoy      OUTPUT
   ,       @uf_man      OUTPUT
   ,       @ivp_hoy     OUTPUT
   ,       @ivp_man     OUTPUT
   ,       @do_hoy      OUTPUT
   ,       @do_man      OUTPUT
   ,       @da_hoy      OUTPUT
   ,       @da_man      OUTPUT
   ,       @acnomprop   OUTPUT
   ,       @rut_empresa OUTPUT
   ,       @hora        OUTPUT

 -- FUSION ---
  SET @acnomprop       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 -------------  

   IF EXISTS(SELECT 1 FROM MDMO WHERE motipoper = 'VP' AND codigo_carterasuper = @carterasuper AND mostatreg <> 'A')
   BEGIN


         SELECT /*001*/  'nomcli'      = ISNULL(VIEW_CLIENTE.clnombre , '')
         ,      /*002*/  'noment'      = ISNULL(MDRC.rcnombre, '')
         ,      /*003*/  'tipcart'     = ISNULL(VIEW_TABLA_GENERAL_DETALLE.tbglosa, '')
         ,      /*004*/  'numdocu'     = ISNULL(RTRIM(CONVERT(CHAR(10),MDMO.monumdocuo))
                                       + '-'
                                       + CONVERT(CHAR(3),MDMO.mocorrelao),'')
         ,      /*005*/  'instser'     = ISNULL(MDMO.moinstser,'')
         ,      /*006*/  'emisor'      = CASE WHEN mocodigo = 98 THEN ( SELECT clgeneric FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo=mocodcli )
                                              ELSE                    ( SELECT emgeneric FROM VIEW_EMISOR  WHERE emrut = morutemi )
                                         END
         ,      /*007*/  'fecemi'      = ISNULL(CONVERT(CHAR(10),MDMO.mofecemi,103),'')
         ,      /*008*/  'fecven'      = ISNULL(CONVERT(CHAR(10),MDMO.mofecven,103),'')
         ,      /*009*/  'tasemi'      = ISNULL(MDMO.motasemi,0)
         ,      /*010*/  'baseemi'     = ISNULL(MDMO.mobasemi,0)
         ,      /*011*/  'moneda'      = ISNULL(VIEW_MONEDA.mnnemo,'')
         ,      /*012*/  'nominal'     = ISNULL(MDMO.monominal,0)
         ,      /*013*/  'tirvta'      = ISNULL(MDMO.motir,0)
         ,      /*014*/  'valpar'      = ISNULL(MDMO.mopvp,0)
         ,      /*015*/  'tasest'      = ISNULL(MDMO.motasest,0)
         ,      /*016*/  'valpresen'   = ISNULL(MDMO.movpresen,0)
         ,      /*017*/  'valventa'    = ISNULL(MDMO.movalven,0)
         ,      /*018*/  'utilidad'    = ISNULL(CONVERT(FLOAT,MDMO.moutilidad),0)
         ,      /*019*/  'forpago'     = ISNULL(VIEW_FORMA_DE_PAGO.glosa,'')
         ,      /*020*/  'tipcust'     = ISNULL(MDMO.mocondpacto,'')
         ,      /*021*/  'paghoy'      = ISNULL(MDMO.mopagohoy,'')
         ,      /*022*/  'serie'       = ISNULL(VIEW_INSTRUMENTO.inserie, '')
         ,      /*023*/  'numoper'     = ISNULL(MDMO.monumoper,0)
         ,      /*024*/  'sw'          = '0'
         ,      /*025*/  'titulo'      = @titulo
         ,      /*026*/  'TIRCOMPRA'   = ISNULL((SELECT (CASE WHEN mocodigo=20 AND morutemi=acrutprop THEN tir_compra_original ELSE cptircomp END) FROM MDCP WHERE cpnumdocu = MDMO.monumdocu  AND cpcorrela = MDMO.mocorrela),0)
         ,      /*027*/  'prima'       = ISNULL(moprimadesc,0)
         ,      /*028*/  'perdida'     = ISNULL(CONVERT(FLOAT,(ABS(MDMO.moperdida) * -1)),0)
         ,      /*029*/  'Tipo_Moneda' = CASE WHEN mnmx = 'C' THEN '0' ELSE '1' END
         ,      /*030*/  'Tipo_Cart'   = ISNULL(cfrf.glosa,'sin definicion') --(SELECT DISTINCT ISNULL(rcnombre,'') FROM bacparamsuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' AND rcrut = motipcart)
         ,      /*031*/  'Tipo_InV'    = @Glosa_Cartera	
         ,      /*032*/  'Tipo_Ope'    = CASE WHEN motipopero = 'ST' THEN 'ST' ELSE '--' END 
	 ,	/*033*/  'libro'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDMO.id_libro),'')
	 ,	/*034*/	 'Glosa_libro'	= @Glosa_Libro
	 ,	/*035*/	 'TirTran'	= moTirTran
	 ,	/*036*/	 'PvpTran'	= moPvpTran
	 ,	/*037*/	 'VPTran'	= moVPTran
         INTO   #TEMP
         FROM   MDMO 
		 LEFT JOIN
			(	SELECT	Id = cf.tbcodigo1, Glosa = cf.tbglosa
				from	BacParamSuda..TIPO_CARTERA tc
						INNER JOIN
						(	SELECT	tbcodigo1, tbglosa
							FROM	bacparamsuda.dbo.tabla_general_detalle WITH(NOLOCK) 
							WHERE	tbcateg = 204
						)	cf		ON cf.tbcodigo1	= tc.rcrut
				WHERE	tc.rcsistema = 'BTR'
				AND		tc.rccodpro='CP'
			)	cfrf	ON cfrf.Id	= MDMO.motipcart
		 LEFT OUTER JOIN VIEW_MONEDA ON MDMO.momonemi = VIEW_MONEDA.mncodmon
         ,      MDAC 
         ,      VIEW_INSTRUMENTO
         ,      VIEW_ENTIDAD MDRC
         ,      VIEW_CLIENTE
         ,      VIEW_FORMA_DE_PAGO
         ,      VIEW_TABLA_GENERAL_DETALLE
         WHERE  MDMO.motipoper                     = 'VP' 
         AND    MDMO.mostatreg                    <> 'A' 
         AND    MDRC.rcrut                         = MDMO.morutcart
         AND   (VIEW_CLIENTE.clrut                 = MDMO.morutcli
         AND    VIEW_CLIENTE.clcodigo              = MDMO.mocodcli)
--         AND    MDMO.momonemi                     *= VIEW_MONEDA.mncodmon
         AND    VIEW_INSTRUMENTO.incodigo          = MDMO.mocodigo
         AND    VIEW_FORMA_DE_PAGO.codigo          = MDMO.moforpagi
         AND    VIEW_TABLA_GENERAL_DETALLE.tbcateg = 204 
         AND    MDMO.motipcart                     = CONVERT(NUMERIC(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)
         AND   (MDMO.morutcart                    >= @ncartini
         AND    MDMO.morutcart                    <= @ncartfin)
         AND   (MDMO.codigo_carterasuper           = @carterasuper)
         AND   (MDMO.motipcart                     = @Cartera_INV OR @Cartera_INV = 0)
         AND    MDMO.PagoMañana                    = 'N'
	 AND   (MDMO.id_libro			   = @id_libro OR @id_libro = '' )
         ORDER BY MDMO.monumoper
         ,        MDMO.monumdocu

         INSERT INTO #TEMP
         SELECT /*001*/  'nomcli'      = ISNULL(VIEW_CLIENTE.clnombre , '')
         ,      /*002*/  'noment'      = ISNULL(MDRC.rcnombre, '')
         ,      /*003*/  'tipcart'     = ISNULL(VIEW_TABLA_GENERAL_DETALLE.tbglosa, '')
         ,      /*004*/  'numdocu'     = ISNULL(RTRIM(CONVERT(CHAR(10),MDMO.monumdocuo))
                                       + '-'
                                       + CONVERT(CHAR(3),MDMO.mocorrelao),'')
         ,      /*005*/  'instser'     = ISNULL(MDMO.moinstser,'')
         ,      /*006*/  'emisor'      = CASE WHEN mocodigo = 98 THEN ( SELECT clgeneric FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo=mocodcli )
                                              ELSE                    ( SELECT emgeneric FROM VIEW_EMISOR  WHERE emrut = morutemi )
                                         END
         ,      /*007*/  'fecemi'      = ISNULL(CONVERT(CHAR(10),MDMO.mofecemi,103),'')
         ,      /*008*/  'fecven'      = ISNULL(CONVERT(CHAR(10),MDMO.mofecven,103),'')
         ,      /*009*/  'tasemi'      = ISNULL(MDMO.motasemi,0)
         ,      /*010*/  'baseemi'  = ISNULL(MDMO.mobasemi,0)
         ,      /*011*/  'moneda'      = ISNULL(VIEW_MONEDA.mnnemo,'')
         ,      /*012*/  'nominal'     = ISNULL(MDMO.monominal,0)
         ,      /*013*/  'tirvta'      = ISNULL(MDMO.motir,0)
         ,      /*014*/  'valpar'      = ISNULL(MDMO.mopvp,0)
         ,      /*015*/  'tasest'      = ISNULL(MDMO.motasest,0)
         ,      /*016*/  'valpresen'   = ISNULL(MDMO.movpresen,0)
         ,      /*017*/  'valventa'    = ISNULL(MDMO.movalven,0)
         ,      /*018*/  'utilidad'    = ISNULL(CONVERT(FLOAT,MDMO.moutilidad),0)
         ,      /*019*/  'forpago'     = ISNULL(VIEW_FORMA_DE_PAGO.glosa,'')
         ,      /*020*/  'tipcust'     = ISNULL(MDMO.mocondpacto,'')
         ,      /*021*/  'paghoy'      = ISNULL(MDMO.mopagohoy,'')
         ,      /*022*/  'serie'       = ISNULL(VIEW_INSTRUMENTO.inserie, '')
         ,      /*023*/  'numoper'     = ISNULL(MDMO.monumoper,0)
         ,      /*024*/  'sw'          = '0'
         ,      /*025*/  'titulo'      = @titulo
         ,      /*026*/  'TIRCOMPRA'   = ISNULL((SELECT (CASE WHEN mocodigo=20 AND morutemi=acrutprop THEN tir_compra_original ELSE cptircomp END) FROM MDCP WHERE cpnumdocu = MDMO.monumdocu  AND cpcorrela = MDMO.mocorrela),0)
         ,      /*027*/  'prima'       = ISNULL(moprimadesc,0)
         ,      /*028*/  'perdida'     = ISNULL(CONVERT(FLOAT,(ABS(MDMO.moperdida) * -1)),0)
         ,      /*029*/  'Tipo_Moneda' = CASE WHEN mnmx = 'C' THEN '0' ELSE '1' END
         ,      /*030*/  'Tipo_Cart'   = (SELECT DISTINCT ISNULL(rcnombre,'') FROM bacparamsuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' AND rcrut = motipcart)
         ,      /*031*/  'Tipo_InV'    = @Glosa_Cartera	
         ,      /*032*/  'Tipo_Ope'    = 'ST'
	 ,	/*033*/  'libro'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = moid_libro),'')
	 ,	/*034*/	 'Glosa_libro'	= @Glosa_Libro
	 ,	/*035*/	 'TirTran'	= 0
	 ,	/*036*/	 'PvpTran'	= 0
	 ,	/*037*/	 'VPTran'	= 0
         FROM   MDMOPM MDMO LEFT OUTER JOIN VIEW_MONEDA ON MDMO.momonemi  = VIEW_MONEDA.mncodmon
         ,      MDAC 
--         ,      VIEW_MONEDA
         ,      VIEW_INSTRUMENTO
         ,      VIEW_ENTIDAD MDRC
         ,      VIEW_CLIENTE
         ,      VIEW_FORMA_DE_PAGO
         ,      VIEW_TABLA_GENERAL_DETALLE
         WHERE  MDMO.mofecinip                     = acfecproc
         AND    MDMO.SorteoLCHR                    = 'S'
         AND    MDMO.PagoMañana                    = 'N'
         AND    MDMO.mostatreg                    <> 'A' 
         AND    MDMO.morutcart                     = MDRC.rcrut
         AND   (MDMO.morutcli                      = VIEW_CLIENTE.clrut
         AND    MDMO.mocodcli                      = VIEW_CLIENTE.clcodigo)
--         AND    MDMO.momonemi                     *= VIEW_MONEDA.mncodmon
         AND    MDMO.mocodigo                      = VIEW_INSTRUMENTO.incodigo
         AND    MDMO.moforpagi                     = VIEW_FORMA_DE_PAGO.codigo
         AND    VIEW_TABLA_GENERAL_DETALLE.tbcateg = 204 
         AND    MDMO.motipcart                     = CONVERT(NUMERIC(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)
         AND   (MDMO.morutcart                    >= @ncartini
         AND    MDMO.morutcart                    <= @ncartfin)
         AND   (MDMO.codigo_carterasuper           = @carterasuper)
         AND   (MDMO.motipcart                     = @Cartera_INV OR @Cartera_INV = 0)
	 AND   (moid_libro			   = @id_libro OR @id_libro = '' )
         ORDER BY MDMO.monumoper
         ,        MDMO.monumdocu
            
            INSERT INTO #TEMP
            SELECT /*001*/  'nomcli'      = ISNULL(VIEW_CLIENTE.clnombre , '')
            ,      /*002*/  'noment'      = ISNULL(MDRC.rcnombre, '')
            ,      /*003*/  'tipcart'     = ISNULL(VIEW_TABLA_GENERAL_DETALLE.tbglosa, '')
            ,      /*004*/  'numdocu'     = ISNULL(RTRIM(CONVERT(CHAR(10),MDMO.monumdocuo))
                                          + '-'
                                          + CONVERT(CHAR(3),MDMO.mocorrelao),'')
            ,      /*005*/  'instser'     = ISNULL(MDMO.moinstser,'')
            ,      /*006*/  'emisor'      = CASE WHEN mocodigo = 98 THEN ( SELECT clgeneric FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo=mocodcli )
                                                 ELSE                    ( SELECT emgeneric FROM VIEW_EMISOR  WHERE emrut = morutemi )
                                            END
            ,      /*007*/  'fecemi'      = ISNULL(CONVERT(CHAR(10),MDMO.mofecemi,103),'')
            ,      /*008*/  'fecven'      = ISNULL(CONVERT(CHAR(10),MDMO.mofecven,103),'')
            ,      /*009*/  'tasemi'      = ISNULL(MDMO.motasemi,0)
            ,      /*010*/  'baseemi'     = ISNULL(MDMO.mobasemi,0)
            ,      /*011*/  'moneda'      = ISNULL(VIEW_MONEDA.mnnemo,'')
            ,      /*012*/  'nominal'     = ISNULL(MDMO.monominal,0)
            ,      /*013*/  'tirvta'      = ISNULL(MDMO.motir,0)
            ,      /*014*/  'valpar'      = ISNULL(MDMO.mopvp,0)
            ,      /*015*/  'tasest'      = ISNULL(MDMO.motasest,0)
            ,      /*016*/  'valpresen'   = ISNULL(MDMO.movpresen,0)
            ,      /*017*/  'valventa'    = ISNULL(MDMO.movalven,0)
            ,      /*018*/  'utilidad'    = ISNULL(CONVERT(FLOAT,MDMO.moutilidad),0)
            ,      /*019*/  'forpago'     = ISNULL(VIEW_FORMA_DE_PAGO.glosa,'')
            ,      /*020*/  'tipcust'     = ISNULL(MDMO.mocondpacto,'')
            ,      /*021*/  'paghoy'      = ISNULL(MDMO.mopagohoy,'')
            ,      /*022*/  'serie'       = ISNULL(VIEW_INSTRUMENTO.inserie, '')
            ,      /*023*/  'numoper'     = ISNULL(MDMO.monumoper,0)
            ,      /*024*/  'sw'          = '0'
            ,      /*025*/  'titulo'      = @titulo
            ,      /*026*/  'TIRCOMPRA'   = ISNULL((SELECT (CASE WHEN mocodigo=20 AND morutemi=acrutprop THEN tir_compra_original ELSE cptircomp END) FROM MDCP WHERE cpnumdocu = MDMO.monumdocu  AND cpcorrela = MDMO.mocorrela),0)
            ,      /*027*/  'prima'       = ISNULL(moprimadesc,0)
            ,      /*028*/  'perdida'     = ISNULL(CONVERT(FLOAT,(ABS(MDMO.moperdida) * -1)),0)
            ,      /*029*/  'Tipo_Moneda' = CASE WHEN mnmx = 'C' THEN '0' ELSE '1' END
            ,      /*030*/  'Tipo_Cart'   = (SELECT DISTINCT ISNULL(rcnombre,'') FROM bacparamsuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' AND rcrut = motipcart)
            ,      /*031*/  'Tipo_InV'    = @Glosa_Cartera	
            ,      /*032*/  'Tipo_Ope'    = CASE WHEN motipopero = 'ST' THEN 'ST' ELSE '--' END 
	    ,	   /*033*/  'libro'	  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = MDMO.id_libro),'')
	    ,	   /*034*/  'Glosa_libro' = @Glosa_Libro
	    ,	   /*035*/  'TirTran'	  = moTirTran
	    ,	   /*036*/  'PvpTran'	  = moPvpTran
	    ,	   /*037*/  'VPTran'	  = moVPTran
            FROM   MDMO LEFT OUTER JOIN VIEW_MONEDA ON  MDMO.momonemi = VIEW_MONEDA.mncodmon
            ,      MDAC 
--            ,      VIEW_MONEDA
            ,      VIEW_INSTRUMENTO
            ,      VIEW_ENTIDAD MDRC
            ,      VIEW_CLIENTE
            ,      VIEW_FORMA_DE_PAGO
 ,      VIEW_TABLA_GENERAL_DETALLE
            WHERE  MDMO.motipoper                     = 'VP' 
            AND    MDMO.mostatreg                    <> 'A' 
            AND    MDRC.rcrut                         = MDMO.morutcart
            AND   (VIEW_CLIENTE.clrut                 = MDMO.morutcli
            AND    VIEW_CLIENTE.clcodigo              = MDMO.mocodcli)
--            AND    MDMO.momonemi                     *= VIEW_MONEDA.mncodmon
            AND    VIEW_INSTRUMENTO.incodigo          = MDMO.mocodigo
            AND    VIEW_FORMA_DE_PAGO.codigo          = MDMO.moforpagi
            AND    VIEW_TABLA_GENERAL_DETALLE.tbcateg = 204 
            AND    MDMO.motipcart                     = CONVERT(NUMERIC(6),VIEW_TABLA_GENERAL_DETALLE.tbcodigo1)
            AND   (MDMO.morutcart                    >= @ncartini
            AND    MDMO.morutcart                    <= @ncartfin)
            AND   (MDMO.codigo_carterasuper           = @carterasuper)
            AND   (MDMO.motipcart                     = @Cartera_INV OR @Cartera_INV = 0)
            AND    MDMO.PagoMañana                    = 'S'
	    AND   (MDMO.id_libro			   = @id_libro OR @id_libro = '' )
	    AND CONVERT(CHAR(10),MDMO.mofecpro,103) 	      = @acfecproc 	
            ORDER BY MDMO.monumoper
            ,        MDMO.monumdocu

         ----<< agrupando por instrumento
         SELECT serie
         ,      'nominal'  = sum(nominal)
         ,      'valpresen'= sum(valpresen)
         ,      'valventa' = sum(valventa)
         ,      'utilidad' = sum(utilidad)
         ,      'Tir'      = sum(valventa * tirvta) / sum(valventa)
         ,      'perdida'  = sum(perdida)
         ,      moneda
         ,      'TipoOperacion' = Tipo_Ope
	 ,	'PromTirTran'	= sum(valventa * TirTran) / sum(valventa)
	 ,	'VPTran'	= SUM(VPTran)
         INTO   #TOTAL  
         FROM   #TEMP  
         GROUP BY serie,moneda,Tipo_Ope

         INSERT INTO #temp
         SELECT ' ',       --1
                '',        --2
                '',        --3
                '',        --4
                serie,     --5
                '',        --6
                '',        --7  
                '',        --8
                0,         --9
                0,         --10
                moneda ,   --11
                nominal,   --12
                tir,       --13
                0,         --14
                0,         --15
                valpresen, --16
                valventa,  --17
                utilidad,  --18
                '',        --19
                '',        --20
                '',        --21
                'Total' ,  --22
                0,         --23
                'sw'='1',  --24
                'RESUMEN ' + @titulo, --25
                0 ,
                0 ,
		perdida,
                ''	,
		''	,
		@Glosa_Cartera,
                TipoOperacion	,
		''		,
		@Glosa_Libro	,
		PromTirTran	,
		0		,
		VPTran		
          FROM #total
  
        ----<< Control de datos
    SELECT nomcli,     --1
               noment,     --2
               tipcart,    --3
               numdocu,    --4
               instser,    --5
               emisor,     --6
               fecemi,     --7
               fecven,     --8
               tasemi,     --9
               baseemi,    --10
               moneda,     --11
               nominal,    --12
               tirvta,     --13
               valpar,     --14
               tasest,     --15
               valpresen,  --16
               valventa,   --17
               utilidad,   --18
               forpago,    --19
               tipcust,    --20
               paghoy,     --21
               serie,      --22
               numoper,
    
               'acfecproc'   = @acfecproc   ,
               'acfecprox'   = @acfecprox   ,
               'uf_hoy'      = @uf_hoy      ,
               'uf_man'      = @uf_man      ,
           'ivp_hoy'     = @ivp_hoy     ,
               'ivp_man'     = @ivp_man     ,
               'do_hoy'      = @do_hoy      ,
   	       'do_man'    = @do_man      ,
               'da_hoy'      = @da_hoy      ,
	       'da_man'     = @da_man      ,
 	       'acnomprop'   = @acnomprop   ,
               'rut_empresa' = @rut_empresa,
               'hora'        = @hora,
               sw,
               titulo,
               TIRCOMPRA ,
               prima,
	       perdida  ,
               Tipo_Moneda,
	       Tipo_Cart,
	       Tipo_inv,
               Tipo_Ope		,
	       Libro		,
	       Glosa_Libro	,
	       TirTran		,
	       PvpTran		,
	       VPTran
          from #temp
          order by serie
 END
 ELSE
        SELECT 'nomcli'      = SPACE(30),         --1
               'noment'      = ' ',         --2
               'tipcart'     = ' ',         --3
               'numdocu'     = '        ',  --4
               'instser'     = SPACE(15),  --5
               'emisor'      = SPACE(15),  --6
               'fecemi'      = '         ', -- 7
               'fecven'      = '         ', --8
               'tasemi'      = 0.0,         --9
               'baseemi'     = 0.0,         --10
               'moneda'      = ' ',         --11
               'nominal'     = 0.0,         --12
               'tirvta'      = 0.0,         --13
               'valpar'      = 0.0,         --14
               'tasest'      = 0.0,         --15
               'valpresen'   = 0.0,         --16
               'valventa'    = 0.0,         --17
               'utilidad'    = 0.0,         --18
               'forpago'     = SPACE(15),   --19
               'tipcust'     = ' ',         --20
               'paghoy'      = ' ',         --21
               'serie'       = ' ',         --22
               'numoper'     = '         ' ,
               'acfecproc'   = @acfecproc    ,
               'acfecprox'   = @acfecprox    ,
               'uf_hoy'      = @uf_hoy       ,
               'uf_man'      = @uf_man       ,
               'ivp_hoy'     = @ivp_hoy      ,
               'ivp_man'     = @ivp_man      ,
               'do_hoy'      = @do_hoy       ,
               'do_man'      = @do_man       ,
               'da_hoy'      = @da_hoy       ,
               'da_man'      = @da_man       ,
               'acnomprop'   = @acnomprop    ,
               'rut_empresa' = @rut_empresa ,
               'hora'        = @hora  ,
               'sw'          = '0'  ,
               'titulo'      = @titulo,
               'tircompra'   = 0.0,
               'prima'       = 0.0,
	       'perdida'     = 0.0,
               'Tipo_Moneda' = '',
	       'Tipo_Cart'  = '',
	       'Tipo_INV'   = @Glosa_Cartera,
               'Tipo_Ope'    = '--'	,
	       'Libro'		= ''	,
	       'Glosa_libro'	= @Glosa_Libro	,
	       'TirTran'	= 0	,
               'PvpTran'	= 0	,
               'VPTran'		= 0


 SET NOCOUNT OFF

END

-- Base de Datos --

GO
