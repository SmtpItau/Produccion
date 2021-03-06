USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOCARVI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFOCARVI]
	(	@tipo_cartera	INT			= 0
	,	@entidad		FLOAT		= 0
	,	@FechaProc		CHAR(8)		= ''
	,	@FechaProx		CHAR(8)		= ''
	,	@Titulo			VARCHAR(200)= ''
	,	@CDolar			CHAR(1)		= 'N'
	,	@Cat_Libro		CHAR(06)	= ' '
	,	@Id_Libro		CHAR(06)	= ' '
	)
AS
BEGIN


	SET @Id_Libro	 = CASE WHEN LTRIM(RTRIM( @Id_Libro ))	  = '' THEN '0' ELSE @Id_Libro		END

	SET NOCOUNT ON

	DECLARE	@acfecproc	DATETIME
	,	@paso		CHAR(01)
	,	@Glosa_Libro	CHAR(50)

	SELECT	@paso		= 'N'
	,	@acfecproc	= acfecproc
	FROM	MDAC

	IF  @id_libro = '0' 
	BEGIN
		SELECT @Glosa_libro = '< TODOS >'	
	END ELSE 
	BEGIN
		SELECT	@Glosa_libro	= tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	tbcateg			= 1552 --> @Cat_Libro 
		AND		ltrim(rtriM( tbcodigo1 ))	= @Id_Libro
	END

	SELECT	'NumDoc'			= CONVERT(VARCHAR(9),rsnumdocu) + '-' + CONVERT(VARCHAR(10),rscorrela) --1
		,	'rscorrela'			= rscorrela    --2
		,	'rsinstser'			= rsinstser    --3
		,	'Emisor'			= isnull((SELECT emgeneric FROM VIEW_EMISOR WHERE emrut = rsrutcli),' ')   --4
		,	'FechaCompra'		= ISNULL(CONVERT(CHAR(10),rsfeccomp,103) ,' ')    --5
		,	'FechaVctoP'		= ISNULL(CONVERT(CHAR(10),rsfecvtop,103),' ' )    --6
		,	'FechaIniP'			= ISNULL(CONVERT(CHAR(10),rsfecinip,103),' ' )    --7
		,	'FechaEmision'		= ISNULL(CONVERT(CHAR(10),rsfecinip,103),' ' )    --8
		,	'Dias'				= ISNULL(DATEDIFF(dd,rsfecinip,rsfecvtop),0 )     --9
		,	'rsvalcomu'			= rsvalcomu         --10
		,	'moneda'			=	(SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = rsmonpact)  --11
		,	'UM'				= (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = rsmonemi)   --12
		,	'rsnominal'			= rsnominal   --13
		,	'Cupon'				= rsvalvenc   --14
		,	'rscupint'			= rscupint    --15
		,	'rstir'				= CONVERT(FLOAT,rstir)  --16
		,	'rsvpcomp'			= rsvpcomp    --17
		,	'rsvppresen'		= rsvppresen   --18
		,	'rsinteres'			= rsinteres    --19
		,	'rsreajuste'		= rsreajuste    --20
		,	'rsintermes'		= rsintermes    --21
		,	'rsreajumes'		= rsreajumes    --22
		,	'rsvppresenx'		= rsvppresenx    --23
		,	'rsinteres_acum'	=(rsinteres_acum-rsinteres)   --24
		,	'rsreajuste_acum'	=(rsreajuste_acum-rsreajuste) --25
		,	'ValorIniPeso'		= CASE	WHEN rsmonpact = 13 then rsvalinip
										ELSE  Round((rsvalinip / (SELECT isnull(Min(vitcinicio),1.0) FROM MDVI Where virutcart = rsrutcart and vinumdocu = rsnumdocu and vinumoper = rsnumoper AND vicorrela = rscorrela)),mndecimal) end --26
		,	'ValorVctoUM'		= rsvalvtop    --27
		,	'TasaPacto'			= rstaspact    --28
		,	'TasaEmision'		= rstasemi    --29
		,	'rutCliente'		= ISNULL((CONVERT(VARCHAR(10) , rsrutcli )) + '-' + (SELECT CLDV FROM VIEW_CLIENTE where CLRUT  = rsrutcli and CLCODIGO = rscodcli),'*-*')  --30
		,	'Cliente'			= ISNULL((SELECT CLNOMBRE FROM VIEW_CLIENTE where CLRUT  = rsrutcli and CLCODIGO = rscodcli ),' ')           --31
		,	'sw'				= '0'     --32
		,	'suma1'				= 0     --33
		,	'base_emision'			= rsbasemi    --34
		,	'codigo_carterasuper'	= CASE rstipcart	WHEN 2 THEN 'P' 
														ELSE 'T' END --35  (2 Permanente / 1 Transable)
		,	'inserie'				= ISNULL(CASE	WHEN rsrutcli = '97029000' THEN 'REPOS'
													ELSE (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo=rscodigo)END,' ')
		,	'tipocliente'			= CASE	WHEN ISNULL((SELECT cltipcli FROM VIEW_CLIENTE where CLRUT  = rsrutcli and CLCODIGO = rscodcli),0) < 4 THEN 'INS. FIN.'
											WHEN ISNULL((SELECT cltipcli FROM VIEW_CLIENTE where CLRUT  = rsrutcli and CLCODIGO = rscodcli),0) > 3 THEN 'TERCEROS'  END
		,	'plazo'					= CASE	WHEN ISNULL(DATEDIFF(dd,rsfecinip,rsfecvtop),0) >= 0 AND ISNULL(DATEDIFF(dd,rsfecinip,rsfecvtop),0) < 30 THEN '0 - 29'
											WHEN ISNULL(DATEDIFF(dd,rsfecinip,rsfecvtop),0) >= 30 AND ISNULL(DATEDIFF(dd,rsfecinip,rsfecvtop),0)< 90 THEN '30 - 89'
											WHEN ISNULL(DATEDIFF(dd,rsfecinip,rsfecvtop),0) >= 90 AND ISNULL(DATEDIFF(dd,rsfecinip,rsfecvtop),0)< 365 THEN '90 - 365'
											WHEN ISNULL(DATEDIFF(dd,rsfecinip,rsfecvtop),0) >= 365  THEN '366 - MAS' END
		,	'rsfecprox'			= ISNULL(CONVERT(CHAR(10),rsfecprox,103),' ')       --29
		,	'rsfecctb'			= ISNULL(CONVERT(CHAR(10),rsfecctb,103),' ')
		,	'condicion'			= convert(varchar(255),'')
		,	'Numoper'			= CONVERT(VARCHAR(9),rsnumoper)
		,	'MonedaMx'			= mnmx
		,	'libro'				= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 1552 AND tbcodigo1 = rsid_libro),'') 
		,	'Glosa_libro'		= @Glosa_Libro
		,	'lcgp'				= ISNULL((select TOP 1 '*' fROM LCGP_VI WHERE rsnumoper=LCGP_OPERACION AND rscorrela=LCGP_CORRELATIVO AND LCGP_FECHA = @acfecproc),'')--20190107.RCHS.LCGP
	INTO	#TEMPORAL1
	from	BacTraderSuda.dbo.mdrs 
			inner join bacparamsuda.dbo.moneda on rsmonpact = mncodmon
	where	rsfecha		= @fechaprox
	and		rscartera	= @tipo_cartera
	and	(	rsrutcart	= @Entidad  or @Entidad  = 0	)
	and		charindex(	ltrim(rtrim( rsmonpact)) , case when @cDolar = 'N' then '997-998-999' else '988-994-995- 13' end) > 0
	and	(	ltrim(rtrim(rsid_libro))	= @id_libro OR @id_libro = '0'	)

	UPDATE	#TEMPORAL1 
		SET	condicion = inserie + ' ' + tipocliente + ' ' + plazo + ' ' + moneda

	UPDATE	#TEMPORAL1 
		SET	LCGP = ' ' 
	WHERE LCGP = '0'

	IF (SELECT COUNT(1) FROM #TEMPORAL1) > 0 
	BEGIN

		SELECT	condicion    
			,	rsfecprox
			,	rsfecctb
			,	inserie
			,	moneda     
			,	plazo     
			,	tipocliente    
			,	'ValorIniPeso'		= SUM(ValorIniPeso)
			,	'ValorVctoUM'		= SUM(ValorVctoUM)
			,	'rsintermes'		= SUM(rsintermes)
			,	'rsreajumes'		= SUM(rsreajumes)
			,	'rsinteres'		= SUM(rsinteres)
			,	'rsinteres_acum'	= SUM(rsinteres_acum)
			,	'rsreajuste'		= SUM(rsreajuste)
			,	'rsreajuste_acum'	= SUM(rsreajuste_acum)
			,	'tasapromedio'		= SUM(tasapacto*rsvppresen) / SUM(rsvppresen)
			,	'diaspromedio'		= SUM(dias*rsvppresen) / SUM(rsvppresen)
			,	'rsnominal'		= SUM(rsnominal)
			,	'rsvppresen'		= SUM(rsvppresen)
			,	'rsvppresenx'		= SUM(rsvppresenx)
			,	'tirprom'		= SUM(rstir *rsvppresen) / SUM(rsvppresen)
			,	'MonedaMx'		= Min(MonedaMx)
			,	'libro'			= ' '
			,	'Glosa_Libro'		= @Glosa_Libro
			,	'lcgp'				= 0				--20190107.RCHS.LCGP
		INTO	#TOTAL1
		FROM	#TEMPORAL1
		GROUP 
		BY		condicion
			,	rsfecprox
			,	rsfecctb
			,	inserie
			,	moneda
			,	plazo
			,	tipocliente
		
		INSERT INTO #TEMPORAL1
		SELECT	''                 --1
		,	0	           --2
		,	RTRIM(inserie)     --3
		,	''    	           --4
		,	''    	           --5
		,	RTRIM(tipocliente) --6
		,	RTRIM(plazo)   	   --7
		,	''    	           --8
		,	diaspromedio       --9
		,	0	           --10
		,	moneda    	   --11
		,	'z' + moneda   	   --12
		,	rsnominal   	   --13
		,	0	           --14
		,	0	           --15
		,	tirprom            --16
		,	0	           --17
		,	rsvppresen         --18
		,	rsinteres   	   --19
		,	rsreajuste   	   --20
		,	rsintermes   	   --21
		,	rsreajumes   	   --22
		,	rsvppresenx   	   --23
		,	rsinteres_acum     --24
		,	rsreajuste_acum    --25
		,	ValorIniPeso   	   --26
		,	ValorVctoUM   	   --27
		,	tasapromedio       --28
		,	0 	           --29
		,	0	           --30
		,	''  	           --31
		,	'sw'	= '1' 	   --32
		,	0	           --33
		,	0	           --34
		,	''  	           --35
		,	''                 --36	
		,	''                 --37	
		,	''                 --38	
		,	rsfecprox 	   --39
		,	rsfecctb 	   --40
		,	condicion 	   --41 
		,	'0'	           --42
		,	MonedaMx	   --43
		,	''		   --44
		,	Glosa_Libro	   --45
		,	' '							--20190107.RCHS.LCGP

		FROM	#TOTAL1	
	
	END 
	ELSE BEGIN
		
		INSERT INTO #TEMPORAL1
		SELECT  ''     --1
		,	0      --2
		,	''     --3
		,	''     --4
		,	''     --5
		,	''     --6
		,	''     --7
		,	''     --8
		,	0      --9
		,	0      --10
		,	''     --11
		,	''     --12
		,	0      --13
		,	0      --14
		,	0      --15
		,	0      --16
		,	0      --17
		,	0      --18
		,	0      --19
		,	0      --20
		,	0      --21
		,	0      --22
		,	0      --23
		,	0      --24
		,	0      --25
		,	0      --26
		,	0      --27
		,	0      --28
		,	0      --29
		,	0      --30
		,	''     --31
		,	'sw' = '0'  --32
		,	0     --33
		,	0     --34
		,	''    --35
		,	''    --36
		,	''    --37
		,	''    --38
		,	CONVERT(CHAR(10),CONVERT(DATETIME,@FechaProx),103) --39 
		,	CONVERT(CHAR(10),CONVERT(DATETIME,@FechaProc),103) --40
		,	''    --41
		,	'0'   --42
		,	' '   --43
		,	''    --44
		,	@Glosa_Libro --45
		,   ''			--46					--20190107.RCHS.LCGP

	END

	SELECT	
		
	 	NumDoc        --1
	,	rscorrela     --2
	,	rsinstser     --3
	,	Emisor        --4
	,	FechaCompra   --5
	,	FechaVctoP    --6
	,	FechaIniP     --7
	,	FechaEmision  --8
	,	Dias          --9
	,	rsvalcomu     --10
	,	moneda        --11
	,	UM            --12
	,	rsnominal     --13
	,	Cupon         --14
	,	rscupint      --15
	,	rstir         --16
	,	rsvpcomp      --17
	,	rsvppresen    --18
	,	rsinteres     --19
	,	rsreajuste    --20
	,	rsintermes    --21
	,	rsreajumes    --22
	,	rsvppresenx   --23
	,	rsinteres_acum   --24
	,	rsreajuste_acum  --25
	,	ValorIniPeso     --26
	,	ValorVctoUM      --27
	,	tasaPacto        --28
	,	TasaEmision      --29
	,	rutCliente       --30
	,	Cliente          --31
	,	'FechProc' = SUBSTRING(@fechaProc ,7,2) + '/' +SUBSTRING(@fechaProc ,5,2) + '/' +SUBSTRING(@fechaProc ,1,4)  --32
	,	'FechProx' = SUBSTRING(@fechaProx ,7,2) + '/' +SUBSTRING(@fechaProx ,5,2) + '/' +SUBSTRING(@fechaProx ,1,4)  --33
	,	'titulo1'  = @titulo  --34 
	,	CASE	WHEN sw='1' THEN 'RESUMEN '+ @titulo +SPACE(3)+'DEL'+SPACE(3)+ rsfecctb + SPACE(3)+ 'AL'+SPACE(3)+ rsfecprox
			ELSE @titulo + SPACE(3)+'DEL'+SPACE(3)+ rsfecctb + SPACE(3)+ 'AL'+SPACE(3)+ rsfecprox END AS titulo  -- 27
	,	'UF_Hoy'  = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha = @FechaProc AND VIEW_VALOR_MONEDA.vmcodigo = 998)   --36
	,	'UF_Man'  = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha = @FechaProx AND VIEW_VALOR_MONEDA.vmcodigo = 998)   --37
	,	'IVP_Hoy' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha = @FechaProc AND VIEW_VALOR_MONEDA.vmcodigo = 997)   --38
	,	'IVP_Man' = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha = @FechaProx AND VIEW_VALOR_MONEDA.vmcodigo = 997)   --39
	,	'DO_Hoy'  = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha = @FechaProc AND VIEW_VALOR_MONEDA.vmcodigo = 994)   --40
	,	'DO_Man'  = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha = @FechaProx AND VIEW_VALOR_MONEDA.vmcodigo = 994)   --41
	,	'DA_Hoy'  = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha = @FechaProc AND VIEW_VALOR_MONEDA.vmcodigo = 995)   --42
	,	'DA_Man'  = (SELECT ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE VIEW_VALOR_MONEDA.vmfecha = @FechaProx AND VIEW_VALOR_MONEDA.vmcodigo = 995)   --43
	,	'NombreEntidad' = (SELECT ISNULL(acnomprop, 'NO DEFINIDO') FROM MDAC )  --44
	,	'Hora'  = CONVERT(varchar(10), GETDATE(), 108)                          --45
	,	sw                      --46
	,	'suma1'  = 0            --47
	,	base_emision            --48
	,	codigo_carterasuper     --49
	,	inserie                 --50 
	,	tipocliente             --51
	,	plazo                   --52
	,	'rsfecprox' = ISNULL(CONVERT(CHAR(10),rsfecprox,103),' ') --53
	,	'rsfecctb'  = ISNULL(CONVERT(CHAR(10),rsfecctb ,103),' ') --54
	,	condicion               --55
	,	Numoper                 --56
	,	MonedaMx                --57
	,	Libro					--58
	,	Glosa_Libro             --59
	,	lcgp					--60					--20190107.RCHS.LCGP
	FROM	#temporal1
	ORDER 
	BY	moneda
	,	inserie
	,	tipocliente
	,	plazo
	,	fechavctop

	SET NOCOUNT OFF

END


GO
