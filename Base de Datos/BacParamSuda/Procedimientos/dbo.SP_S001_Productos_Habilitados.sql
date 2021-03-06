USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S001_Productos_Habilitados]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_S001_Productos_Habilitados]
	(	@FechaExtraccion	DATETIME	= ''
	,	@RutCliente			INT			= 0
	)
as
begin

	set nocount on

	declare @iCodCliente	int
		set @iCodCliente	=	(	select	min(clcodigo)
									from	BacParamSuda.dbo.CLIENTE with(nolock) 
									where	clrut	 = @RutCliente
									and		clcodigo > 0
									group 
									by		clrut
								)

	declare @nRutBanco			numeric(12)
		set @nRutBanco			= @RutCliente

	declare	@nRut				numeric(15)
	declare @Bloqueado			int;	set	@Bloqueado		= 1
	declare	@FirmaPacto			int;	set @FirmaPacto		= 0
	declare	@CondGenerales		int;	set @CondGenerales	= 0	
	declare @newCondGeneral		int;	set	@newCondGeneral	= 0
	declare @CondOpciones		int;	set @CondOpciones	= 0
	declare @AnexoOpciones		int;	set	@AnexoOpciones	= 0

	--		detetmina la metodologia de calculo de lineas
	declare @iMetodologia		int;	set @iMetodologia	= -1
	declare @iEstadoLinea		int;	set @iEstadoLinea	= 0
	declare @iELineaDrv			int;	set @iELineaDrv		= 0

	declare @iELineaForward		int;	set @iELineaForward	= 0
	declare @iELineaOpciones	int;	set @iELineaOpciones= 0
	declare @iELineaPacto		int;	set @iELineaPacto	= 0
	declare @iELineaSpot		int;	set @iELineaSpot	= 0
	declare @iELineaSwap		int;	set @iELineaSwap	= 0

	declare @dFecProceso   datetime;	set @dFecProceso	= ( select acfecproc from bactradersuda.dbo.mdac with(nolock) )

	select	@iMetodologia		= clientes.Metodo
	FROM	(	
				select 	'Rut'				= clrut
					,	'Nombre'			= clnombre
					,	'CompBilateral'		= case when cli.ClCompBilateral = 'S' then 'SI' else 'NO' end
					,	'Metodologia'		= met.RecMtdDsc
					,	'Tipo'				= TipCli.tbglosa
					,	'Metodo'			= BacLineas.dbo.FN_RIEFIN_METODO_LCR( clrut, clcodigo, 0, 0)
				from	BacParamSuda.dbo.CLIENTE cli
						left join BacParamSuda.dbo.TBL_SEGMENTOSCOMERCIALES seg On seg.SgmCod		= cli.seg_comercial
						left join BacLineas.dbo.TBL_METODOLOGIAREC			met On met.recmtdcod	= cli.clrecmtdcod
						left join	(	select	tbcodigo1, tbglosa 
										from	BacparamSuda.dbo.Tabla_General_Detalle 
										where	tbcateg = 72
									)	TipCli	On TipCli.tbcodigo1	= cltipcli
				where	cli.clrut		= @RutCliente
				and		cli.clcodigo	= @iCodCliente
			)	clientes
			left join 
			BacLineas.dbo.TBL_METODOLOGIAREC MET On MET.recmtdcod	= Clientes.Metodo

	--	estado de la linea general
	select	@iEstadoLinea	= StatusLin.sw
	from	(	select	sw = case	when FechaVencimiento	< @dFecProceso	then 0	--> Vencida
									when Bloqueado			= 'S'			then 0	--> Bloqueada
								--	when TotalDisponible	>  0			then 1	--> Sin Disponible
									else 1											--> Vigente
								end
				from	BacLineas.dbo.linea_general 
				where	rut_cliente = @RutCliente and Codigo_Cliente = @iCodCliente
			)	StatusLin

	--	estado de la linea Drv
	select	@iELineaDrv	= StatusLin.sw
	from	(	select	sw = case when TotalDisponible > 0 then 1 else 0 end
				from	BacLineas.dbo.linea_sistema
				where	rut_cliente = @RutCliente and Codigo_Cliente = @iCodCliente
				and		Id_Sistema	= 'DRV'
			)	StatusLin

	--	estado de la linea Forward
	select	@iELineaForward	= StatusLin.sw
	from	(	select	sw = case when TotalDisponible > 0 then 1 else 0 end
				from	BacLineas.dbo.linea_sistema
				where	rut_cliente = @RutCliente and Codigo_Cliente = @iCodCliente
				and		Id_Sistema	= 'BFW'
			)	StatusLin

	--	estado de la linea Opciones
	select	@iELineaOpciones= StatusLin.sw
	from	(	select	sw = case when TotalDisponible > 0 then 1 else 0 end
				from	BacLineas.dbo.linea_sistema
				where	rut_cliente = @RutCliente and Codigo_Cliente = @iCodCliente
				and		Id_Sistema	= 'OPT'
			)	StatusLin

	--	estado de la linea Pacto
	select	@iELineaPacto	= StatusLin.sw
	from	(	select	sw = case when TotalDisponible > 0 then 1 else 0 end
				from	BacLineas.dbo.linea_sistema
				where	rut_cliente = @RutCliente and Codigo_Cliente = @iCodCliente
				and		Id_Sistema	= 'BTR'
			)	StatusLin

	--	estado de la linea Spot
	select	@iELineaSpot = StatusLin.sw
	from	(	select	sw = case when TotalDisponible > 0 then 1 else 0 end
				from	BacLineas.dbo.linea_sistema
				where	rut_cliente = @RutCliente and Codigo_Cliente = @iCodCliente
				and		Id_Sistema	= 'BCC'
			)	StatusLin

	--	estado de la linea Swap
	select	@iELineaSwap = StatusLin.sw
	from	(	select	sw = case when TotalDisponible > 0 then 1 else 0 end
				from	BacLineas.dbo.linea_sistema
				where	rut_cliente = @RutCliente and Codigo_Cliente = @iCodCliente
				and		Id_Sistema	= 'PCS'
			)	StatusLin

	set @iELineaForward		= case when (@iMetodologia = 1 or @iMetodologia = 4) then @iELineaForward	else @iELineaDrv	end
	set @iELineaOpciones	= case when  @iMetodologia = 1 or @iMetodologia = 4  then @iELineaOpciones	else @iELineaDrv	end
	set @iELineaSwap		= case when  @iMetodologia = 1 or @iMetodologia = 4  then @iELineaSwap		else @iELineaDrv	end
	--		detetmina la metodologia de calculo de lineas


	--		Llenado de Estados, para determinar la habilitacion por productos
	select	@nRut				= clien.Rut
		,	@Bloqueado			= clien.Bloqueado
		,	@FirmaPacto			= clien.FirmaPacto
		,	@CondGenerales		= clien.CondGenerales
		,	@newCondGeneral		= clien.NuevasCondGenerales
		,	@CondOpciones		= clien.CondOpciones
		,	@AnexoOpciones		= clien.Anexo
	from	(	select	Rut					= cli.clrut
					,	Bloqueado			= case when cli.bloqueado = 'S' then 1 else 0 end
					,	FirmaPacto			= case when isnull(cli.fechafirmacg_pactos,		'19000101') = '19000101' then 0 else 1 end
					,	CondGenerales		= case when isnull(cli.clfechafirma_cond,		'19000101') = '19000101' then 0 else 1 end
					,	NuevasCondGenerales	= case when isnull(cli.fecha_firma_nuevo_ccg,	'19000101') = '19000101' then 0 else 1 end
					,	CondOpciones		= case when isnull(opt.cond,  0)							= 0			 then 0 else 1 end
					,	Anexo				= case when isnull(opt.Anexo, 0)							= 0			 then 0 else 1 end
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
											,	cond		= clfechafirma_cond_opcchk
											,	anexo		= clfechafirma_supl_opcchk
										from	lnkOpc.CbmdbOpc.dbo.BreakBacParamsudaCliente with(nolock)
										where	clrut		= @nRutBanco
									)	Opt		On	Opt.Rut		= cli.clrut
												and Opt.Codigo	= cli.clcodigo

				where	clrut				= @nRutBanco
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
	where	rutCliente		= @RutCliente
	and		codCliente		= @iCodCliente

	if @blqTodos = 1
	begin
		set	@blqForward		= @blqTodos
		set @blqSwaps		= @blqTodos
		set @blqOpciones	= @blqTodos
		set	@blqSpot		= @blqTodos
		set @blqPactos		= @blqTodos
	end
	--		Modelo de Bloqueo por Mantenedor


	-->		Definicio de Cuadro de Excesos
	DECLARE @LinVencida			INT
		SET @LinVencida			= 0
		
	SELECT	@LinVencida			= CASE	WHEN FechaVencimiento <= (	SELECT acfecproc FROM BACFWDSUDA.DBO.MFAC WITH(NOLOCK)) 
																THEN 1 
										ELSE 0 
									END
	FROM	BACLINEAS.DBO.LINEA_GENERAL
	WHERE	RUT_CLIENTE			= @RutCliente
	AND		CODIGO_CLIENTE		= @iCodCliente

	DECLARE @idEstadoLinea		INT
		SET @idEstadoLinea		= 0

	SELECT	@idEstadoLinea		= CASE WHEN ( DERFLOW.ASIGNADO - DERFLOW.OCUPADO ) <= 0.0 THEN 1 ELSE 0 END
	FROM	(	SELECT	ID						= 'FORWARD'
					,	ASIGNADO				= ISNULL( SUM( LINSIS.TOTALASIGNADO ) , 0.0)
					,	OCUPADO					= ISNULL( SUM( LINSIS.TOTALOCUPADO  ) , 0.0)
				FROM	BACLINEAS.DBO.LINEA_SISTEMA LINSIS WITH(NOLOCK)

				WHERE	LINSIS.RUT_CLIENTE		= @RutCliente
				AND		LINSIS.CODIGO_CLIENTE	= @iCodCliente
				AND		LINSIS.ID_SISTEMA		IN( 'BFW', 'OPT')
			)	DERFLOW

	IF ( @idEstadoLinea = 1 ) OR ( @LinVencida = 1 )
	BEGIN
		set	@blqForward		= 1 -->	@blqTodos
		set @blqSwaps		= 1 -->	@blqTodos
		set @blqOpciones	= 1 -->	@blqTodos
		set	@blqSpot		= 1 -->	@blqTodos
		set @blqPactos		= 1 -->	@blqTodos
	END
	-->		Definicio de Cuadro de Excesos

	
	--		Retorno de Valores para el Servicio
	select	Familia_Producto	= upper( Prod.Producto	)
		,	Habilitado			= case when @Bloqueado = 1 then 'NO' else upper( Prod.Estado ) end
	from	(	
				select	id			= 1
					,	Producto	= 'Forward' 
					,	Estado		= case	when (@blqForward = 1) then 'No'
											when (@CondGenerales = 1 or @newCondGeneral = 1) and (@iEstadoLinea = 1 and @iELineaForward = 1) then 'Si'
											else 'No' 
										end
					union
				select	id			= 2
					,	Producto	= 'Opciones'
					,	Estado		= case	when (@blqOpciones = 1) THEN 'No'
											when (@CondOpciones	= 1 and @AnexoOpciones	= 1) and (@iEstadoLinea = 1 and @iELineaOpciones = 1) then 'Si'
											else 'No' 
										end
					union
				select  id			= 3
					,	Producto	= 'Pacto'
					,	Estado		= case	when (@blqPactos = 1) then 'No'
											when (@FirmaPacto = 1) and (@iEstadoLinea = 1 and @iELineaPacto = 1) then 'Si'
											else 'No' 
										end	
					union
				select	id			= 4
					,	Producto	= 'Spot'
					,	Estado		= case	when (@blqSpot = 1) then 'No'
											when (@nRut	> 0) and (@iEstadoLinea = 1 and @iELineaSpot = 1) then 'Si' 
											else 'No' 
										end	
					union
				select	id			= 5
					,	Producto	= 'Swap'
					,	Estado		= case	when (@blqSwaps = 1) then 'No'
											when (@CondGenerales = 1 or	@newCondGeneral = 1) and (@iEstadoLinea = 1 and @iELineaSwap = 1) then 'Si' 
											else 'No' 
										end
			)	Prod
end

GO
