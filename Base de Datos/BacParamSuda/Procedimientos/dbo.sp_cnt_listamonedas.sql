USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_cnt_listamonedas]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_cnt_listamonedas]
	(	@paresid_sistemas	CHAR(03)
	,	@paresIdMovimiento	VARCHAR(10) = ''
	)
as
begin

	set nocount on

	declare @varorgmonedas	char(60)
	declare @vardatamonedas	char(60)
	declare @cond_monedas	char(60)

	if @paresid_sistemas = 'BTR' AND @paresIdMovimiento = 'GAR'
	begin
		select	mncodmon, mnnemo, mnglosa
		from	BacParamSuda.dbo.Moneda with(nolock)
		where	mncodmon IN(999,13)
		return
	end

	if exists( select 1 from BacParamSuda.dbo.producto_cnt with(nolock)	where id_sistema = @paresid_sistemas )
	begin
		select	@varorgmonedas   = origen_monedas
		,		@vardatamonedas  = datos_monedas
		,		@cond_monedas    = cond_monedas
		from	BacParamSuda.dbo.producto_cnt with(nolock)
		where	id_sistema       = @paresid_sistemas

		if rtrim(@cond_monedas  ) <> ''
			set	 @cond_monedas	= 'where ' + @cond_monedas

		if rtrim(@vardatamonedas) <> '' 
			execute ('select ' + @vardatamonedas + ' from ' + @varorgmonedas + @cond_monedas + ' order by mnglosa '	)
	end else
	begin
		select 'no hay datos' 
	end
end

GO
