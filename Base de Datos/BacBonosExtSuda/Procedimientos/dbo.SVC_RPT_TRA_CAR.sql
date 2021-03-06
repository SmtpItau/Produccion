USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_TRA_CAR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_RPT_TRA_CAR]
			(	@fecpro		char(10)	)
as
begin

DECLARE	@NombreEntidad   char(50),	
	@DireccEntidad   char(50)

select	@NombreEntidad  = rcnombre, @DireccEntidad = rcdirecc from view_entidad


	set nocount on
	create table	#cartera	
		(	numoper			char(12)	not null default ' '	,
			familia			char(10)	not null default ' '	,
			instrumento		char(20)	not null default ' '	,
			fec_vcto		datetime	not null default ' '	,
			tir_ant			numeric(19,7)	not null default 0	,
			pvp_ant			numeric(19,7)	not null default 0	,
			val_ant			numeric(19,4)	not null default 0	,
			tir_nue			numeric(19,7)	not null default 0	,
			pvp_nue			numeric(19,7)	not null default 0	,
			val_nue			numeric(19,4)	not null default 0	,
			fec_traspaso		datetime	not null default ' '	,
			ajuste			numeric(19,4)	not null default 0	,
			titulo			char(60)	not null default ' '	,
			sw			numeric(1)	not null default 0	,
			moneda			char(3)		not null default ' '	,
			NombreEntidad   	char(50)	NOT NULL DEFAULT ' '	,
			DireccEntidad   	char(50)	NOT NULL DEFAULT ' '	)

	insert into #cartera	
		select 	cpnumdocu	,
			(select Nom_Familia from text_fml_inm where text_tsp_ctr.cod_familia = text_fml_inm.cod_familia ),
			cod_nemo	,
			cpfecven	,
			tptir_ant	,
			tppvp_ant	,
			tpval_ant	,
			tptir_nue	,
			tppvp_nue	,
			tpval_nue	,
			trfectraspaso	,
			ajuste		,
			'INFORME DE TRASPASO DE CARTERA AL ' + convert(char(10), convert(datetime, @fecpro),103),
			1		,
			(select mnnemo from VIEW_moneda	where moneda = MNCODMON),
			@NombreEntidad   ,	
			@DireccEntidad

		from 	text_tsp_ctr
		where	trfectraspaso = @fecpro

	if not exists(select * from #cartera ) begin
		insert into #cartera
			(titulo,sw,NombreEntidad,DireccEntidad)
		values	('INFORME DE TRASPASO DE CARTERA AL ' + convert(char(10), convert(datetime, @fecpro),103),0,@NombreEntidad,@DireccEntidad)
		select * from #cartera
	end
	else begin
		select * from #cartera order by numoper
	end
		
	set nocount off

end

GO
