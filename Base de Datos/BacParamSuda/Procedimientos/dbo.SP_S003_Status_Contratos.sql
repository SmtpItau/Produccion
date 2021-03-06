USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S003_Status_Contratos]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_S003_Status_Contratos]
	(	@ParamRutCli	varchar(08)	)   
as
begin

	set nocount on	

	declare @nRutBanco			numeric(12)
		set	@nRutBanco			= convert( int, @ParamRutCli )

	declare	@nRut				numeric(15)
	declare @nCodigo			numeric(9)
	declare @Bloqueado			int;		set	@Bloqueado		= 1
	declare	@FirmaPacto			datetime;	set @FirmaPacto		= '19000101'
	declare	@CondGenerales		datetime;	set @CondGenerales	= '19000101'
	declare @newCondGeneral		datetime;	set	@newCondGeneral	= '19000101'
	declare @CondOpciones		datetime;	set @CondOpciones	= '19000101'
	declare @AnexoOpciones		datetime;	set	@AnexoOpciones	= '19000101'
	declare @Comder				datetime;	set @Comder			= '19000101'

	--		Llenado de Estados, para determinar la habilitacion por productos
	select	@nRut				= clien.Rut
		,	@FirmaPacto			= clien.FirmaPacto
		,	@CondGenerales		= clien.CondGenerales
		,	@newCondGeneral		= clien.NuevasCondGenerales
		,	@CondOpciones		= clien.CondOpciones
		,	@AnexoOpciones		= clien.Anexo
		,	@Comder				= clien.Comder
		,	@Bloqueado			= clien.Bloqueado
	from	(	select	Rut					= cli.clrut
					,	Bloqueado			= case when cli.bloqueado = 'S' then 1 else 0 end
					,	CondGenerales		= isnull(	cli.clfechafirma_cond,			'19000101')
					,	NuevasCondGenerales	= isnull(	cli.fecha_firma_nuevo_ccg,		'19000101')
					,	FirmaPacto			= isnull(	cli.fechafirmacg_pactos,		'19000101')
					,	Comder				= isnull(	cli.clfechafirmacontratocomder,	'19000101')
					,	CondOpciones		= isnull(	opt.FechaCond,					'19000101')
					,	Anexo				= isnull(	opt.FechaAnexo,					'19000101')
				from	BacParamSuda.dbo.Cliente cli with(nolock)

						inner join	(	select	Rut	= clrut
											,	Id	= min( clcodigo )
										from	BacParamSuda.dbo.cliente with(nolock)
										where	clrut = @nRutBanco
										group 
										by		clrut
									)	GrpCli	On	GrpCli.Rut	= cli.clrut
												and GrpCli.Id	= cli.clcodigo

						left join	(	select	Rut			= clrut
											,	Codigo		= clcodigo
											,	FechaCond	= case when clFechaFirma_cond_OpcChk	= 0 then '19000101' else isnull(clFechaFirma_cond_Opc, '19000101')	end
											,	FechaAnexo	= case when clFechaFirma_Supl_OpcChk	= 0	then '19000101'	else isnull(clFechaFirma_Supl_Opc, '19000101')	end
										from	lnkOpc.CbmdbOpc.dbo.BreakBacParamsudaCliente with(nolock)
										where	clrut		= @nRutBanco
									)	Opt		On	Opt.Rut		= cli.clrut
												and Opt.Codigo	= cli.clcodigo

				where	clrut		= @nRutBanco
			)	clien

	--		Modelo de Bloqueo por Mantenedor
	declare @blqTodos		int;	set @blqTodos		= 0
	declare @blqForward		int;	set @blqForward		= 0
	declare @blqSwaps		int;	set @blqSwaps		= 0
	declare @blqOpciones	int;	set @blqOpciones	= 0
	declare @blqSpot		int;	set @blqSpot		= 0
	declare @blqPactos		int;	set @blqPactos		= 0
	
	select	@blqTodos		= case when blqTodos	= 'S' then 1 else 0 end
		,	@blqForward		= case when blqForward	= 'S' then 1 else 0 end
		,	@blqSwaps		= case when blqSwaps	= 'S' then 1 else 0 end
		,	@blqOpciones	= case when blqOpciones	= 'S' then 1 else 0 end
		,	@blqSpot		= case when blqSpot		= 'S' then 1 else 0 end
		,	@blqPactos		= case when blqPactos	= 'S' then 1 else 0 end
	from	BacParamsuda.dbo.TBL_BLOQUEOS_CLIENTES with(nolock)
	where	rutCliente		= @nRutBanco
	and		codCliente		= @nCodigo

	if @blqTodos = 1
	begin
		set	@blqForward		= @blqTodos
		set @blqSwaps		= @blqTodos
		set @blqOpciones	= @blqTodos
		set	@blqSpot		= @blqTodos
		set @blqPactos		= @blqTodos
	end
	--		Modelo de Bloqueo por Mantenedor


	select	Tipo					= Tip.Tipo
		,	Estado_Contrato			= Tip.Estado
		,	Fecha_Generacion_CCG	= CONVERT(varchar(10), Tip.Fecha, 126)
	from	(	select	Id		= 1
					,	Tipo	= 'Bloqueo de Cliente'
					,	Estado	= case when @Bloqueado = 1 then 'S' else 'N' end
					,	Fecha	= '19000101' --> @CondGenerales
					union
				----------------------------------------------------------------------
				SELECT	Id		= 2
					,	Tipo	= 'Bloqueo Cliente por Producto Forward'
					,	Estado	= case when @blqForward = 1 then 'S' else 'N' end
					,	Fecha	= '19000101'
					union
				SELECT	Id		= 3
					,	Tipo	= 'Bloqueo Cliente por Producto Swap'
					,	Estado	= case when @blqSwaps = 1 then 'S' else 'N' end
					,	Fecha	= '19000101'
					union
				SELECT	Id		= 4
					,	Tipo	= 'Bloqueo Cliente por Producto Opciones'
					,	Estado	= case when @blqOpciones = 1 then 'S' else 'N' end
					,	Fecha	= '19000101'
					union
				SELECT	Id		= 5
					,	Tipo	= 'Bloqueo Cliente por Producto Spot'
					,	Estado	= case when @blqSpot = 1 then 'S' else 'N' end
					,	Fecha	= '19000101'
					union
				SELECT	Id		= 6
					,	Tipo	= 'Bloqueo Cliente por Producto Pactos'
					,	Estado	= case when @blqPactos = 1 then 'S' else 'N' end
					,	Fecha	= '19000101'
				----------------------------------------------------------------------
					UNION
				select	Id		= 7
					,	Tipo	= 'Contrato CG Antiguo'
					,	Estado	= case when @CondGenerales = '19000101' then 'N' else 'S' end
					,	Fecha	= @CondGenerales
					union
				select	Id		= 8
					,	Tipo	= 'Contrato CG Nuevo'
					,	Estado	= case when @newCondGeneral = '19000101' then 'N' else 'S' end
					,	Fecha	= @newCondGeneral
					union
				select	Id		= 9
					,	Tipo	= 'Contrato CG Pactos'
					,	Estado	= case when @FirmaPacto = '19000101' then 'N' else 'S' end
					,	Fecha	= @FirmaPacto
					union
				select	Id		= 10
					,	Tipo	= 'Contrato ComDer'
					,	Estado	= case when @Comder = '19000101' then 'N' else 'S' end
					,	Fecha	= @Comder
					union
				select	Id		= 11
					,	Tipo	= 'Contrato CG Opciones'
					,	Estado	= case when @CondOpciones = '19000101' then 'N' else 'S' end
					,	Fecha	= @CondOpciones
					union
				select	Id		= 12
					,	Tipo	= 'Anexo Suplemntario Opciones'
					,	Estado	= case when @AnexoOpciones = '19000101' then 'N' else 'S' end
					,	Fecha	= @AnexoOpciones
			)	Tip
		order
		by		Tip.Id

end

GO
