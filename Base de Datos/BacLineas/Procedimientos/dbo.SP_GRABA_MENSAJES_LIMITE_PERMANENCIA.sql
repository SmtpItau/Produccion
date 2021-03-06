USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_MENSAJES_LIMITE_PERMANENCIA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_MENSAJES_LIMITE_PERMANENCIA]
	(	@Fecha				datetime
	,	@Id_Sistema			varchar(5)
	,	@Producto			varchar(5)
	,	@NumOperacion		numeric(9)
	,	@NumDocumento		numeric(9)
	,	@NumCorrelativo		numeric(9)
	,	@Codigo				int
	,	@Familia			varchar(20)
	,	@Instrumento		varchar(20)
	,	@RutEmisor			numeric(9)
	,	@Operador			varchar(15)
	,	@Nominal			numeric(21,4)
	,	@Tasa				numeric(21,4)
	,	@Pvp				numeric(21,4)
	,	@PlazoLimite		numeric(9)
	,	@PlazoActual		numeric(9)
	,	@Mensaje			nvarchar(2500)
	,	@nIdRelacion		numeric(21)	= -1
	,	@nEstado			int			= -1
	)
AS
BEGIN

	set nocount on

	begin transaction

	declare @nId	numeric(21)
		set @nId	= isnull( (select max( id ) from BacLineas.dbo.mensajes_limite_permanencia), 0)
		set @nId	= @nId + 1

	insert into BacLineas.dbo.mensajes_limite_permanencia
		(	Fecha
		,	Id_Sistema
		,	Producto
		,	NumOperacion
		,	NumDocumento
		,	NumCorrelativo
		,	Codigo
		,	Familia
		,	Instrumento
		,	RutEmisor
		,	Operador
		,	Nominal
		,	Tasa
		,	Pvp
		,	PlazoLimite
		,	PlazoActual
		,	Firma1
		,	Firma2
		,	Mensaje
		,	FechaSistema
		,	HoraSistema
		,	nIdRelacion
		,	nEstado
		)
	select	Fecha			= @Fecha
		,	Id_Sistema		= @Id_Sistema
		,	Producto		= @Producto
		,	NumOperacion	= CASE WHEN @NumOperacion = -1 THEN @nId ELSE @NumOperacion END
		,	NumDocumento	= @NumDocumento
		,	NumCorrelativo	= @NumCorrelativo
		,	Codigo			= @Codigo
		,	Familia			= @Familia
		,	Instrumento		= @Instrumento
		,	RutEmisor		= @RutEmisor
		,	Operador		= @Operador
		,	Nominal			= @Nominal
		,	Tasa			= @Tasa
		,	Pvp				= @Pvp
		,	PlazoLimite		= @PlazoLimite
		,	PlazoActual		= @PlazoActual
		,	Firma1			= ''
		,	Firma2			= ''
		,	Mensaje			= @Mensaje
		,	FechaSistema	= convert(datetime, convert(char(10), getdate(), 112), 112)
		,	HoraSistema		= convert(datetime, convert(char(10), getdate(), 108), 112)
		,	nIdRelacion		= case when @nIdRelacion <= 0 then @nId else @nIdRelacion end
		,	@nEstado

	if @@error <> 0
	begin
		rollback transaction
		select -1, 'Error', -1
	end else
	begin
		commit transaction
		select 1, 'Ok', CASE	WHEN @NumOperacion = -1 THEN case when @nIdRelacion <= 0 then @nId else @nIdRelacion end
								ELSE @NumOperacion 
							END
	end

END
GO
