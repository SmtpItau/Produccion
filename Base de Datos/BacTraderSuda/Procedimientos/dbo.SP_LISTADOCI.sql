USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOCI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- SP_LISTADOCI 0, 'MOVIMIENTO DIARIO DE COMPRAS CON PACTO', 0, 1552, ''

CREATE PROCEDURE [dbo].[SP_LISTADOCI] 
		            (
  					@Entidad     Float			,
					@Titulo      Varchar(200) =	''	,
					@Cartera_Inv Integer			,
					@Cat_Libro	CHAR(06)	= ''	,
					@id_libro	CHAR(06)	= ''	
  
     )
AS
BEGIN
 
   DECLARE	@acfecproc   char(10),
			@acfecprox   char(10),
			@uf_hoy      float,
			@uf_man      float,
			@ivp_hoy     float,
			@ivp_man     float,
			@do_hoy      float,
			@do_man      float,
			@da_hoy      float,
			@da_man      float,
			@acnomprop   char(40),
			@rut_empresa char(12),
			@hora        char(8),
			@DolarObs	FLOAT,
 			@Glosa_Cartera	CHAR(20)	,
			@Glosa_Libro		CHAR(50)

	Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BTR'
     And  rcrut     = @Cartera_INV
	   -- ORDER BY rcrut REQ. 7619 CASS 25-01-2011

  if @Glosa_Cartera = '' 
	Select @Glosa_Cartera = '< TODAS >'

  IF  @id_libro = '' BEGIN
	SELECT @Glosa_libro = '< TODOS >'	
  END 
  ELSE BEGIN
	SELECT	@Glosa_libro	= tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbcateg		= @Cat_Libro 
	AND	tbcodigo1	= @Id_Libro
  END

   execute Sp_Base_Del_Informe
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT

 -- FUSION ---
  SET @acnomprop       = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 -------------
     
 DECLARE @ncartini NUMERIC(10,0)
 DECLARE @ncartfin NUMERIC(10,0)
 DECLARE @paso  CHAR(1)

 SELECT @DolarObs = vmvalor from View_Valor_moneda,mdac Where vmcodigo = 994 and vmfecha = acfecproc

 select @ncartini  = @entidad 
 select @ncartfin  = case @entidad when 0 then 999999999 else @entidad end
 SELECT @paso = 'N'
 SET NOCOUNT ON
 IF EXISTS(SELECT * FROM MDMO WHERE MDMO.motipoper='CI'AND MDMO.mostatreg=' ')
 BEGIN
  SELECT @paso = 'S'
  SELECT 'nomcli' = isnull( c.clnombre , ''), --1
		 'noment' = isnull( r.rcnombre , ''), --2
		 'numdocu' = isnull(rtrim(convert(char(10),a.monumdocu))+'-'+convert(char(3),a.mocorrela),'') , -- 3
		 'instrumento' = isnull( a.moinstser, ''), --4
		 'emisor' = isnull( e.emgeneric, ''), --5
		 'fecemi' = isnull( convert(char(10), a.mofecemi, 103), ''),--6
		 'fecven' = isnull( convert(char(10), a.mofecven, 103), ''),--7
		 'tasemi' = isnull( a.motasemi, 0), --8
		 'moneda' = isnull( m1.mnnemo, ''), --9
		 'nominal' = isnull( a.monominal,0), --10
		 'tircompra' = isnull( a.motir, 0)   , --11
		 'pvp'  = isnull( a.mopvp, 0)   , --12
		 'fecinip' = isnull( convert ( char(10), a.mofecinip, 103), '' ) ,--13
		 'fecvtop' = isnull( convert ( char(10), a.mofecvenp, 103), '' ) ,--14
		 'tasapact' = isnull( a.motaspact, 0) , --15   
		 'monpacto' = isnull( m2.mnnemo, '')  , --16    
		 'valinip' = CASE WHEN  m2.mnmx = 'C' AND a.momonpact <> 13 THEN isnull(Round(a.movalinip/momtoPFE,m2.mndecimal),0)
					Else isnull( a.movalinip,0) End , --17  
		 'valorven' = isnull( a.movalvenp, 0), --18
		 'familia' = isnull( i.inserie,'')  , --19
		 'acrutprop'     = x.acrutprop,  --20
		 'rcrut'         = z.rcrut     ,  --21
		 'sw'='0',
		 'titulo'=@titulo,--23,
		 'FormaPagoInicio'= p1.glosa,
		 'FormaPagoVencim'= p2.glosa,
		 'mnmx'           = m2.mnmx,
		 'Tipo_Cart'	  = isnull(cfrf.glosa,'sin definicion'), --(SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BTR' And rcrut =  motipcart),
		 'Tipo_InV'	=@Glosa_Cartera		,
		 'libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @Cat_Libro AND tbcodigo1 = a.id_libro),'') ,
		 'Glosa_libro'	= @Glosa_Libro	,
		 'TasaTran'		= moTirTran	,
		 'VFTranUM'		= moVPTran
   INTO #temp
   FROM MDMO          a
			LEFT JOIN
			(	SELECT	Id = cf.tbcodigo1, Glosa = cf.tbglosa
				FROM	BacParamSuda..TIPO_CARTERA tc
						INNER JOIN
						(	SELECT	tbcodigo1, tbglosa
							FROM	bacparamsuda.dbo.tabla_general_detalle WITH(NOLOCK) 
							WHERE	tbcateg = 204
						)	cf		ON cf.tbcodigo1	= tc.rcrut
				WHERE	tc.rcsistema = 'BTR'
				AND		tc.rccodpro='CP'
			)	cfrf	ON cfrf.Id	= a.motipcart , 
		VIEW_CLIENTE  c, 
		VIEW_ENTIDAD  r, 
		VIEW_EMISOR  e, 
		VIEW_INSTRUMENTO i,  
		VIEW_MONEDA  m1,
		VIEW_MONEDA  m2,
		MDAC  x,
		VIEW_ENTIDAD z,
		VIEW_FORMA_DE_PAGO p1,
		VIEW_FORMA_DE_PAGO p2,
		VIEW_TABLA_GENERAL_DETALLE t 
  WHERE a.motipoper='CI'
		AND  a.mostatreg                     = ' '
		AND r.rcrut                          = a.morutcart
		AND (c.clrut                         = a.morutcli 
		and c.clcodigo                       = a.mocodcli)
		and e.emrut                          = a.morutemi  
		and i.incodigo                       = a.mocodigo  
		and (t.tbcateg                       = 204        
		and CONVERT(NUMERIC(6),t.tbcodigo1)  = a.motipcart )
		and m1.mncodmon                      = a.momonemi
		and m2.mncodmon                      = a.momonpact
		and p1.codigo                        = a.moforpagi
		and p2.codigo                        = a.moforpagv
		and (a.morutcart                    >= @ncartini
		and a.morutcart                     <= @ncartfin)
		AND (motipcart                       =  @Cartera_INV	OR @Cartera_INV	= 0 ) 
		AND (a.id_libro						 = @id_libro	OR @id_libro	= '')

	SELECT	'monpacto'	= monpacto, 
		'valinip'	= sum(valinip) ,
		'valorven'	= sum(valorven),
		'Tasa'		= sum(valinip*tasapact)/ sum(valinip),
		'mnmx'		= Max(mnmx)   ,
		'TotVFTran'	= sum(VFTranUM)
	INTO	#total  
	FROM	#temp  
	GROUP
	BY	monpacto
 
   INSERT INTO #temp
          SELECT '',--1
        		'',--2
        		'',--3
        		'',--4
        		'',--5
               		'',--6
        		'',--7
        		0 ,--8
        		'',--9
        		0 ,--10
        		0 ,--11
   			0 ,--12
        		'',--13
        		'',--14
                	tasa ,--15
                	monpacto , --16
                	valinip  , --17
                	valorven , --18
                	'' ,--19
                 	0  ,--20
                 	0   ,
   			'sw'='1',
    			'RESUMEN ' + @titulo, --21,
   			'',
   			'',
			mnmx,
			0,
			@Glosa_Cartera	,
			''		,
			@Glosa_Libro	,
			0		,
			TotVFTran
        FROM #total

   select  	nomcli, --1
   		noment, --2
   		numdocu, -- 3
   		instrumento, --4
   		emisor, --5
   		fecemi,--6
   		fecven,--7
   		tasemi, --8
   		moneda, --9
   		nominal, --10
   		tircompra, --11
   		pvp, --12
   		fecinip,--13
   		fecvtop ,--14
   		tasapact, --15   
   		monpacto, --16    
   		valinip,  --17  
   		valorven , --18
   		familia  , --19
   		acrutprop    ,  --20
   		rcrut  ,--21
   		FormaPagoInicio,
   		FormaPagoVencim,
 		'acfecproc' = @acfecproc   ,
            	'acfecprox' = @acfecprox   ,
          	'uf_hoy'    = @uf_hoy      ,
   		'uf_man'    = @uf_man      ,
          	'ivp_hoy'   = @ivp_hoy     ,
   		'ivp_man'   = @ivp_man     ,
      		'do_hoy'    = @do_hoy      ,
   		'do_man'    = @do_man      ,
   		'da_hoy'    = @da_hoy      ,
   		'da_man'    = @da_man      ,
   		'acnomprop' = @acnomprop   ,
   		'rut_empresa' = @rut_empresa,
   		'hora'      = @hora,
   		sw,
   		titulo,
		mnmx	,
	       Tipo_Cart,
	       Tipo_InV	,
		Libro		,
		Glosa_Libro	,
		TasaTran	,
		VFTranUM
      FROM #temp ORDER BY monpacto
 END
 ELSE
  IF @paso = 'N'
  BEGIN
   SELECT 'nomcli'='                               ' , --1
    'noment'='                      ' , --2
    'numdocu'='     ' , -- 3
    'instrumento'='         ', --4
    'emisor'='         ' , --5
    'fecemi'='       ' ,--6
    'fecven'='       ' ,--7
    'tasemi'=0.0 , --8
    'moneda'='      ' , --9
    'nominal'=0.0 , --10
    'tircompra'=0.0 , --11
    'pvp'=0.0 , --12
    'fecinip'='        ' ,--13
    'fecvtop'='        '  ,--14
    'tasapact'=0.0 , --15   
    'monpacto'='     ' , --16    
    'valinip'=0.0 , --17  
    'valorven'=0.0 , --18
    'familia'='' , --19
    'acrutprop'=0  ,  --20
    'rcrut'=0 ,--21
    'FormaPagoInicio'='',
    'FormaPagoVencim'='',
    'acfecproc' = @acfecproc,   
    'acfecprox' = @acfecprox   ,
    'uf_hoy'    = @uf_hoy      ,
    'uf_man'    = @uf_man      ,
    'ivp_hoy'   = @ivp_hoy     ,
    'ivp_man'   = @ivp_man     ,
    'do_hoy'    = @do_hoy      ,
    'do_man'    = @do_man      ,
    'da_hoy'    = @da_hoy      ,
    'da_man'    = @da_man      ,
    'acnomprop' = @acnomprop   ,
    'rut_empresa' = @rut_empresa,
    'hora'      = @hora,
    sw     ='0',
    'titulo'    = @titulo,
    'mnmx'	= ''	,
    'Tipo_Cart' = ''		,
   'Tipo_InV'	= @Glosa_Cartera,
   'libro'	= ''		,
   'Glosa_Libro'= @Glosa_Libro	,
   'TasaTran'	= 0	,
   'VFTranUM'	= 0
  END
END
GO
