USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_CAR_VLU]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE procedure [dbo].[SVC_RPT_CAR_VLU]
(	
     @FecPro		CHAR(8)		,
     @NUM_SUCU1	FLOAT		,
     @NUM_SUCU2	FLOAT		
)

as
begin

DECLARE	@NombreEntidad   char(50),	
	@DireccEntidad   char(50)


select	@NombreEntidad  = rcnombre, @DireccEntidad = rcdirecc from view_entidad


	set nocount on
	create table #temp_cartera
		(	Numdocu		Float(12)	not null default 0	,--1
			Fec_pag		datetime	not null default ' '	,--2	
			Fec_neg		datetime	not null default ' '	,--3
			Familia		char(10)	not null default ' '	,--4
			Nemotecnico	char(20)	not null default ' '	,--5
			num_uni		numeric(4)	not null default 0	,--5
			Unidad		char(20)	not null default ' '	,--6
			Nombre_corr	CHAR(50)	NOT NULL DEFAULT ' '	,--7
			pais_corr	char(15)	not null default ' '	,--8
			Cta_corr	char(30)	not null default ' '	,--9
			Nombre_contra	char(50)	not null default ' '	,--10
			Moneda		char(3)		not null default ' '	,--11
			Monto_compra	numeric(19,4)	not null default 0	,--12
			Monto_Venta	numeric(19,4)	not null default 0	,--13
			Titulo		char(60)	not null default ' '	,--14
			SW		numeric(1)	not null default 0	,--15
			carterasuper    char(1)		not null default ' '	,--16
			NombreEntidad   char(50)	NOT NULL DEFAULT ' '	,--17
			DireccEntidad   char(50)	NOT NULL DEFAULT ' '	)--18

	insert into #temp_cartera
	select 	rsnumdocu	,--1
		rsfecpago	,--2
		rsfecneg	,--3
		b.Nom_Familia	,--4
		id_instrum	,--5
		sucursal	,
		ISNULL((select ofi_nom from ttab_ofi where ofi_cod = sucursal), ' ' )			,--6
		corr_cli_nombre	,--7
		corr_cli_pais	,--8
		corr_cli_cta	,--9
		ISNULL((select clnombre from VIEW_CLIENTE where clrut = rsrutcli and clcodigo = rscodcli), ' ' ),--10
		(select mnnemo from VIEW_moneda where mncodmon = rsmonemi )				,--11
		(case 	when rscartera = '334' then rsvalcomu else 0 end )					,--12
		(case	when rscartera = '335' then rsvalcomu else 0 end )					,--13
		'INFORME DE CARTERA DE VALUTAS VIGENTES AL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FECPRO),103)	,--14
		1		 ,	--15
		codigo_carterasuper,	--16
		@NombreEntidad 	, 	--17
		@DireccEntidad		--18

	from 	text_rsu a, text_fml_inm b				
	where	(rscartera = '334' or	rscartera = '335')
	and	a.cod_familia = b.cod_familia
	and 	a.rsfecpro    = @fecpro
	AND	CONVERT(NUMERIC(03),sucursal) >= @NUM_SUCU1
	AND	CONVERT(NUMERIC(03),sucursal) <= @NUM_SUCU2


	if not exists( select * from #temp_cartera) begin
		insert into #temp_cartera
			(	titulo	,
				sw	,
				NombreEntidad  ,
				DireccEntidad )
		values	( 'INFORME DE CARTERA DE VALUTAS VIGENTES AL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FECPRO),103)	,	
			  0		,
			@NombreEntidad 	,
			@DireccEntidad
			)
	end
				
	select * from #temp_cartera

	set nocount off
end

GO
