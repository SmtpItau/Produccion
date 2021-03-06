USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_EST_PRO]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_RPT_EST_PRO]
as
begin
	set nocount on
	create	table #procesos
		(	sw	char(40)	not null default ' '	,
			ok	numeric(1)	not null default 0	,
			Fecha	Char(10)	not null default ' '	,
			hora	char(8)		not null default ' ' 	)

	insert into #procesos
		select 	'PROCESO DE INICIO DE DÍA'		,
			a.acsw_pd				,
			convert( char(10),max(b.fec_hor),103)	,
			convert( char(8) ,max(b.fec_hor),108)	
		from    text_arc_ctl_dri a, text_log_pcs b
		where	b.sw = 'id'
		and 	fecha = (select acfecproc from text_arc_ctl_dri)
		group by a.acsw_pd

	insert into #procesos
		select 	'PROCESO DE BLOQUEO DE MESA'	,
			a.acsw_MESA			,
			convert( char(10),max(b.fec_hor),103)	,
			convert( char(8) ,max(b.fec_hor),108)	
		from    text_arc_ctl_dri a, text_log_pcs b
		where	b.sw = 'me'
		and 	fecha = (select acfecproc from text_arc_ctl_dri)
		group by a.acsw_MESA

	insert into #procesos
		select 	'PROCESO DE DEVENGAMIENTO DE CARTERA'	,
			a.acsw_dv			,
			convert( char(10),max(b.fec_hor),103)	,
			convert( char(8) ,max(b.fec_hor),108)	
		from    text_arc_ctl_dri a, text_log_pcs b
		where	b.sw = 'dv'
		and 	fecha = (select acfecproc from text_arc_ctl_dri)
		group by a.acsw_dv

	insert into #procesos
		select 	'PROCESO DE AJUSTE DE MERCADO'	,
			a.acsw_tm			,
			convert( char(10),max(b.fec_hor),103)	,
			convert( char(8) ,max(b.fec_hor),108)	
		from    text_arc_ctl_dri a, text_log_pcs b
		where	b.sw = 'tm'
		and 	fecha = (select acfecproc from text_arc_ctl_dri)
		group by a.acsw_tm

	insert into #procesos
		select 	'PROCESO DE FIN DE DIA'	,
			a.acsw_fd			,
			convert( char(10),max(b.fec_hor),103)	,
			convert( char(8) ,max(b.fec_hor),108)	
		from    text_arc_ctl_dri a, text_log_pcs b
		where	b.sw = 'fd'
		and 	fecha = (select acfecproc from text_arc_ctl_dri)
		group by a.acsw_fd

	select A.*,B.acfecproC from #procesos A, text_arc_ctl_dri B
	set nocount off
end

GO
