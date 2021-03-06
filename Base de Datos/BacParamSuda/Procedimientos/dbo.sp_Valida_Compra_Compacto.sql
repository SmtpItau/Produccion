USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_Valida_Compra_Compacto]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_Valida_Compra_Compacto]
	(	@Cod_Mon	char(5)
	,	@Plazo		numeric(8)
	,	@rutcli		numeric(8)
	,	@codcli		numeric(8)
	,	@monto		numeric(26,6)
	)
AS
BEGIN

	set nocount on

	declare @tipocli	int
	select	@tipocli	= cltipcli
	from	BacParamSuda.dbo.cliente with(nolock)
	where	clrut		= @rutcli
	and		clcodigo	= @codcli

	select 'SI'
	return

	if @tipocli IN (1,2,3) 
	begin
		select 'SI'
		return
	end

	declare @Codigo_M		numeric(8)
		set @Codigo_M		= (select mncodmon from moneda with(nolock) where mnnemo = @Cod_Mon)

	declare @ntasa			float
	declare @nPlazoDesde	int
	declare @nPlazoHasta	int
	declare @nMontoMin		float
	declare @nMontoMan		float

	select	@ntasa			= isnull(Tasa, 0.0) 
		,	@nPlazoDesde	= isnull(DiasDesde, 0)
		,	@nPlazoHasta	= isnull(DiasHasta, 0)
		,	@nMontoMin		= isnull(MontoMinimo, 0)
		,	@nMontoMan		= isnull(MontoMaximo, 0)
	from	BacParamSuda.dbo.Tasas_Maximas_Convencional with(nolock)
	where	Codigo_Moneda	= @Codigo_M
	and	(	@Plazo BETWEEN	DiasDesde   AND DiasHasta	)
	and	(	@Monto BETWEEN	MontoMinimo AND MontoMaximo	)

	select	Moneda			= @Codigo_M
		,	Tasa			= 100.0 --> @ntasa
		,	DiasDesde		= @nPlazoDesde 
		,	DiasHasta		= @nPlazoHasta 
		,	MontoMinimo		= @nMontoMin 
		,	MontoMaximo		= @nMontoMan 

/*
	SELECT	'Codigo_Moneda'	= @Codigo_M,
			'Tasa'			= 100.0, --> Tasa,
			'DiasDesde'		= DiasDesde,
			'DiasHasta'		= DiasHasta,
			'MontoMinimo'	= MontoMinimo,
			'MontoMaximo'	= MontoMaximo
	INTO	#Tempo_Valida_Compra_Compacto
	FROM	tasas_maximas_convencional 
	WHERE	Codigo_Moneda = @Codigo_M
	AND	(	@Plazo BETWEEN DiasDesde   AND DiasHasta	)
	AND	(	@Monto BETWEEN MontoMinimo AND MontoMaximo	)

	SELECT * FROM #Tempo_Valida_Compra_Compacto
*/

	return

end
GO
