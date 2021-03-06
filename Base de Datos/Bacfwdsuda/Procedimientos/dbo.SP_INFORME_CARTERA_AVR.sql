USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CARTERA_AVR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
--procedimiento que genera los informes para Cartera con resultados reconocidos o AVR
CREATE PROCEDURE [dbo].[SP_INFORME_CARTERA_AVR](	@AreaNegocio	CHAR(6)			-- area de Negocio
											,@CarteraFinac	NUMERIC(9,0)	-- CARTERA DE INVERSION
											,@CarteraNorma	CHAR(6)			-- CARTERA NORMATIVA
											,@Libro			CHAR(6)			-- LIBRO
											,@RutCliente	NUMERIC(9,0)	--RUT CLIENTE
											,@cFechaD		char(10)
											,@cFechaH		char(10)
											,@vOperador		CHAR(15)
											,@vTitulo		VARCHAR(200)
)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @dFechaProceso	DATETIME,
			@sCarteraFinac	CHAR(50),
			@sCarteraNorma	CHAR(50),
   			@sAreaNegocio	CHAR(50),
			@sLibro			CHAR(50),
			@sOperador		CHAR(50),
			@sCliente		CHAR(50)
			

	SELECT  @dFechaProceso = acfecproc
   	FROM    MFAC

	set 	@sCarteraFinac = '< TODOS (AS) >'
--	IF @AreaNegocio != 0
		SELECT	@sCarteraFinac = rcnombre
		FROM	VIEW_TIPO_CARTERA
				VIEW_TABLA_GENERAL_DETALLE
		WHERE 	RCCODPRO		= 10
		AND 	rcsistema		= 'BFW'
		AND		rcrut			= @CarteraFinac

	set @sCarteraNorma = '< TODOS (AS) >'
--	IF @CarteraNorma != ''
		SELECT 	@sCarteraNorma= tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE 
				,VIEW_TBL_RELACIONES
		WHERE	tbcateg			= '1111'
		AND		tbcodigo1		= Rel_IdRelacion1
		AND		Rel_IdRelacion1	= @CarteraNorma
		AND		Rel_IdCodigo1	= 'BFW'
		AND		tbcateg			= Rel_IdCodigo2

	set @sAreaNegocio = '< TODOS (AS) >'	
--	IF @AreaNegocio != ''
		SELECT 	@sAreaNegocio = tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE 
				,VIEW_TBL_RELACIONES
		WHERE	tbcateg			= '1553'
		AND		tbcodigo1		= Rel_IdRelacion1
		AND		Rel_IdRelacion1	= @AreaNegocio
		AND		Rel_IdCodigo1	= 'BFW'
		AND		tbcateg			= Rel_IdCodigo2

	SET	@sLibro = '< TODOS (AS) >'
--	IF @Libro != ''
		SELECT	@sLibro=TBGLOSA
		FROM	VIEW_TABLA_GENERAL_DETALLE
				,VIEW_TBL_RELACION_PRODUCTO_LIBRO
		WHERE	RPL_IDSISTEMA	= 'BFW'
		AND		RPL_IDPRODUCTO	= 10
		AND		RPL_IDLIBRO	= @Libro
		AND		TBCATEG		= '1552'
		AND		TBCODIGO1	= RPL_IDLIBRO

	set		@sOperador = '< TODOS (AS) >'
--	IF @vOperador!= ''
		select	@sOperador = nombre
		from 	VIEW_USUARIO
		where	usuario = @vOperador

	SET @sCliente ='< TODOS (AS) >'
--	IF @RutCliente != 0
		SELECT	@sCliente= clnombre
		FROM	VIEW_CLIENTE
		WHERE	clrut = @RutCliente

	SELECT 'Operacion'   = mf.canumoper
	,      'Producto'    = mf.cacodpos1
	,      'Descripcion' = CONVERT(CHAR(25),p.descripcion)
	,      'Moneda'      = mf.cacodmon1
	,      'NemoMon'     = m.mnnemo
	,      'MonedaCnv'   = mf.cacodmon2
	,      'Tipo'        = CASE WHEN mf.catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
	,      'Modalidad'   = CASE WHEN mf.catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END 
	,      'Cliente'     = c.clnombre
	,      'vRazonable'  = mf.fres_obtenido
	,      'vValor'      = CASE WHEN mf.cacodpos1 IN(10,11) THEN mf.catasa_efectiva_moneda1 ELSE mf.fval_obtenido END
	,      'TasaM1'      = CONVERT(NUMERIC(21,4),mf.catasasinteticam1)
	,      'TasaM2'      = CONVERT(NUMERIC(21,4),mf.catasasinteticam2)
	,      'TEfectivaM1' = CONVERT(NUMERIC(21,4),mf.catasadolar) --> catasaEfectMon1)   
	,      'TEfectivaM2' = CONVERT(NUMERIC(21,4),mf.catasaufclp) --> catasaEfectMon2)
	,      'PlazoRes'    = DATEDIFF(DAY, @dFechaProceso, mf.cafecEfectiva) --cafecvcto)
	,      'FechaProceso'= CONVERT(CHAR(10),@dFechaProceso,103)
	,      'FechaEmision'= CONVERT(CHAR(10),GETDATE(),103)
	,      'HoraEmision' = CONVERT(CHAR(10),GETDATE(),108)
	,      'FechaOp'     = CONVERT(CHAR(10),mf.cafecha,103)
	,		'Cartera_financiera'		= ltrim(rtrim(@sCarteraFinac)) -- NOMBRE CARTERA
	,		'Cartera_normativa' 		= ltrim(rtrim(@sCarteraNorma))
	,		'Libro'			 			= ltrim(rtrim(@sLibro))
	,		'Area_Negocio'				= ltrim(rtrim(@sAreaNegocio))
	,		'Operador'					= ltrim(rtrim(@sOperador))
	,		'NombreCliente'				= ltrim(rtrim(@sCliente))-- rut cliente
	,		'Titulo'					= ltrim(rtrim(@vTitulo))
	,		'FechaDesde'				= @cFechaD
	,		'Fecha Hasta'				= @cFechaH
	INTO	#TEMPO
	FROM   MFCA mf
	INNER JOIN BacParamSuda..CLIENTE  C ON cacodigo     = c.clrut AND mf.cacodcli = c.clcodigo
	INNER JOIN BacParamSuda..PRODUCTO P ON p.id_sistema = 'BFW' AND mf.cacodpos1 = p.codigo_producto
	INNER JOIN BacParamSuda..MONEDA   M ON m.mncodmon   = mf.cacodmon1
	WHERE	mf.cafecvcto		> @cFechaH
	and		(mf.cafecha      BETWEEN  @cFechaD AND @cFechaH)
	AND		mf.caantici 	<> 'A'
	AND		(mf.cacodcart			= @CarteraFinac		OR @CarteraFinac	= 0)-- Cartera Financiera
	AND		(mf.cacartera_normativa	= RTRIM(@CarteraNorma)		OR RTRIM(@CarteraNorma)	= '')-- Cartera Normativa
	AND		(mf.calibro				= @Libro			OR @Libro			= '')-- Libro
	AND		(mf.caArea_Responsable	= @AreaNegocio		OR @AreaNegocio		= '')-- Area Responsable
	AND		(mf.caoperador			= @vOperador		OR @vOperador		= '')-- Operador	
	AND		(mf.cacodigo			= @RutCliente		OR @RutCliente		= 0)-- Rut del Cliente
	ORDER BY	cacodpos1,
			cacodigo, cacodcli, catipoper, canumoper, catipmoda


	IF @@ROWCOUNT = 0 BEGIN
		INSERT	INTO #TEMPO
		SELECT 	0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				0,
				'',
				'',
				'',
				'',
				'',
				@sCarteraFinac,
				@sCarteraNorma,
				@sLibro,
				@sAreaNegocio,
				@sOperador,
				@sCliente,
				@vTitulo,
				@cFechaD,
				@cFechaH
	END


	select * from #TEMPO
END
GO
