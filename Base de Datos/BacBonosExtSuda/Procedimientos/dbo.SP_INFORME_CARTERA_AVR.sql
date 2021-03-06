USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CARTERA_AVR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[SP_INFORME_CARTERA_AVR]	(	
						@FecPro		CHAR(8)		
					,	@Libro			CHAR(10)
					,	@CartNorm		CHAR(10)
					,	@CartFin		CHAR(10)
					,	@AreaResp		CHAR(10)
					,	@FechaDesde		CHAR(10)
					,	@FechaHasta		CHAR(10)
					,	@Operador		CHAR(20)
					,	@RutCliente		NUMERIC(9,0)	
					, 	@TituloRPT		CHAR(100)
					)
AS 
SET DATEFORMAT ymd
/*****************************************************************
	CREADO POR
	AUTOR : Carolina Villegas Godoy
	FECHA : 25/09/2008
	MOTIVO: Para generar Carteras con Resultados Reconocidos o AVR
	CODIGO ARGUS
  *****************************************************************/
BEGIN

	SET NOCOUNT ON

	DECLARE	@Glosa_Cartera	CHAR(20)
	DECLARE @FechaContable  DATETIME
	DECLARE @fechabil 	CHAR (02)
	DECLARE @dFecRet 	DATETIME,
	@sAreaNegocio	CHAR(50),
	@sOperador		CHAR(50),
	@sCarteraNorma	CHAR(50),
	@sCarteraFinac	CHAR(50),
	@sLibro			CHAR(50),
	@CarteraINV_OP	CHAR(50),
	@sRut_cliente	CHAR(50)

	SELECT  @fechabil = ' '
	SELECT  @dFecRet  = ' '	
	


	EXECUTE BacParamSuda..SP_DETECTA_FECHA_HABIL_INHABIL @FecPro, @fechabil OUTPUT


        IF @fechabil = 'NO' 
	BEGIN
		EXECUTE BacParamSuda..SP_FECHA_HABIL_ANTERIOR @FecPro, @dFecRet OUTPUT
		SELECT @FechaContable = @dFecRet

	END
	ELSE 
	BEGIN
		SELECT @FechaContable = @FecPro
	END

	/*IF @CartFin = '' 
		SELECT @Glosa_Cartera = '< TODAS >'
	ELSE
		SELECT	@Glosa_Cartera = ISNULL(TBGLOSA,'')
		FROM	VIEW_TABLA_GENERAL_DETALLE
		WHERE	TBCATEG		= @CatCartFin
		AND	TBCODIGO1	= @CartFin*/
	
	set 	@sCarteraFinac = '< TODOS (AS) >'
	SELECT 	@sCarteraFinac = tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE	A
		WHERE	A.tbcateg	= 204
		and	A.tbcodigo1 	= @CartFin

	--obtiene descripcion de area de negocio
	set 	@sAreaNegocio = '< TODOS (AS) >'
	select 	@sAreaNegocio = tbglosa
	from	VIEW_TABLA_GENERAL_DETALLE 
	where	tbcateg=1553
	AND 	tbcodigo1 = @AreaResp

	--obtiene descripcion del Operador
	set 	@sOperador = '< TODOS (AS) >'
	select	@sOperador= nombre
	from 	VIEW_USUARIO
	where 	tipo_usuario='TRADER'
	and	usuario = @Operador

	--obtiene descripcion de la cartera normativa
	set 	@sCarteraNorma = '< TODOS (AS) >'
	SELECT 	@sCarteraNorma = tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE	A
		WHERE	A.tbcateg	= 1111
		and	A.tbcodigo1 	= @CartNorm

	--obtiene descripcion de la cartera financiera
	set 	@sCarteraFinac = '< TODOS (AS) >'
	SELECT 	@sCarteraFinac = tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE	A
		WHERE	A.tbcateg	= 204
		and	A.tbcodigo1 	= @CartFin

	--obtiene descripcion Libro
	set 	@sLibro = '< TODOS (AS) >'
	SELECT 	@sLibro = tbglosa
		FROM	VIEW_TABLA_GENERAL_DETALLE	A
		WHERE	A.tbcateg	= 1552
		and	A.tbcodigo1 	= @Libro

	SET		@sRut_cliente = '< TODOS [AS] >'
	--obtiene Nombre de Cliente
	SELECT	@sRut_cliente = clnombre
	FROM	VIEW_CLIENTE
	WHERE	clrut	= @Rutcliente

	CREATE TABLE #TEMP_cartera_AVR	
	(	NUMDOCU				numeric(10)
		,NEMOTECNICO		CHAR(20)
		,FEC_VCTO			DATETIME
		,NOMINAL			FLOAT
		,TIR				FLOAT
		,TIRMERC			FLOAT
		,VALCOMU			FLOAT
		,VALCOMU_MERC		FLOAT
		,PVP				FLOAT
		,PVP_MERC			FLOAT
		,NUM_OFI			NUMERIC(4)
		,OFICINA			CHAR(50)
		,FEC_IMP			DATETIME
		,SW					NUMERIC(1)
		,valor_cambio		FLOAT
		,glosa_moneda		CHAR(60)
		,nom_familia		CHAR(60)
		,NombreEntidad   	CHAR(50)
		,DireccEntidad   	CHAR(50)
		,TipoEmisor			CHAR(50)
		,cartera			CHAR(50)
		,CarteraINV_OP		CHAR(50)
		,Cartera_Selec   	CHAR(50)
		,Nemo_Moneda		CHAR(5)
		,Libro				CHAR(50)
		,Cartera_Norm		CHAR(50)
		,AreaResp			CHAR(50)
		,Operador			CHAR(50)
		,FechaDesde			CHAR(10)
		,FechaHasta			CHAR(10)
		,Titulo 			CHAR(100)
		,Rut_cliente		CHAR(50)
)

	INSERT INTO 	#TEMP_cartera_AVR
	select  a.RSNUMDOCU
			,a.ID_INSTRUM
			,a.RSFECVCTO
			,a.RSNOMINAL
			,a.RSTIR		
			,a.RSTIRMERC	
			,rsvppresen
			,CASE WHEN RSVALMERC <> 0 THEN RSVALMERC	ELSE rsvppresen END
			,RSPVP
			,RSPVPMERC
			,CONVERT(NUMERIC(4), a.SUCURSAL)
			,isnull( ( SELECT ofi_NOM FROM 	TTAB_ofi WHERE ofi_COD = a.SUCURSAL ), ' ' )
			,CONVERT(DATETIME,@FechaDesde)
		,1
		,isnull( ( select Tipo_Cambio from BACPARAMSUDA..VALOR_MONEDA_CONTABLE where Codigo_Moneda = (case when rsmonemi = 13 then 994 else rsmonemi end ) and  Fecha = @FechaContable )  ,0)
		,( select mnglosa from VIEW_moneda where mncodmon = rsmonemi)
		,c.Descrip_familia
		,ISNULL( (Select rcnombre from view_entidad),' ')
		,ISNULL( (Select rcdirecc from view_entidad),' ')
		,ISNULL(( select TBGLOSA from view_tabla_general_detalle , view_emisor where TBCATEG = 210  and TBCODIGO1 = emtipo and emrut = rsrutemis and emcodigo = rscodemi) , '')
		,case when a.codigo_carterasuper = 'T' then 'NORMAL' ELSE 'PERMANENTE' END
		,ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = 204 AND TBCODIGO1 = d.tipo_inversion),'No Especificado')
		,@sCarteraFinac --		,@Glosa_Cartera							
		,(SELECT MNNEMO FROM VIEW_MONEDA WHERE MNCODMON = RSMONEMI)
		,@sLibro--		,ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatLibro    AND TBCODIGO1 = d.Id_Libro),'No Especificado')
		,@sCarteraNorma --	,	ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatCartNorm AND TBCODIGO1 = d.codigo_carterasuper),'No Especificado')
		,@sAreaNegocio --	,	ISNULL((SELECT TBGLOSA FROM VIEW_TABLA_GENERAL_DETALLE WHERE TBCATEG = @CatAreaResp AND TBCODIGO1 = d.Id_Area_Responsable),'No Especificado')
		,@sOperador
		,@FechaDesde
		,@FechaHasta
		,@TituloRPT
		,@sRut_cliente
	FROM 	TEXT_RSU a
	,	text_fml_inm c 
	,	text_ctr_inv d
	WHERE 	a.rscartera		= '333'
        AND     rstipoper		= 'DEV'
--	AND	(convert(char(10),a.rsfecpro,103)	between @FechaDesde AND @FechaHasta )
	AND	a.rsfecpro	between @FechaDesde AND @FechaHasta 
	AND	CONVERT(NUMERIC(03),a.sucursal) >= 0
	AND	CONVERT(NUMERIC(03),a.sucursal) <= 0
	AND c.cod_familia		= a.cod_familia	 
	AND d.cpnumdocu		= a.rsnumoper
	AND	(d.id_libro		= @Libro	OR @Libro	= '')
	AND	(d.codigo_carterasuper	= @CartNorm		OR @CartNorm	= '')
	AND  (d.tipo_inversion		= @CartFin		OR @CartFin		= '')
	AND	(d.Id_Area_Responsable	= @AreaResp		OR @AreaResp	= '')
	AND (d.mousuario			= @Operador		or @Operador	= '')
	AND (d.cprutcli				= @RutCliente	OR @RutCliente	= 0)




	IF ( SELECT COUNT(1) FROM #TEMP_cartera_AVR ) = 0 BEGIN
		INSERT INTO #TEMP_cartera_AVR
			SELECT 
				0	,--1
				' '	,--2
				' '	,--3
				0,--4
				0 ,--5
				0,--6
				0,--7
				0,--8
				0,--9
				0,--10
				0,--11
				0,--12
				' '	,--13
				0	,--15
				0	,
				' '	,
				' '	,
				ISNULL( (Select rcnombre from view_entidad),' '),
				ISNULL( (Select rcdirecc from view_entidad),' '),
				space(50)          ,
				space(50)
				,' ' 
				,@sCarteraFinac 
				,''
				,@sLibro
				,@sCarteraNorma
				,@sAreaNegocio
				,@sOperador
				,@FechaDesde
				,@FechaHasta
				,@TituloRPT
				,@sRut_cliente
			FROM text_arc_ctl_dri 
	END

	SELECT 	*
	FROM 	#TEMP_cartera_AVR
	ORDER BY NUMDOCU

	SET NOCOUNT OFF
END

GO
