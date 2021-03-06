USE [BacLineas]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_RIEFIN_GARANTIA]    Script Date: 13-05-2022 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[FN_RIEFIN_GARANTIA]
	(	@nRutcli		NUMERIC(13) 
	,	@nCodigo		NUMERIC(5)
	,	@nMetodologia	NUMERIC(5) 
	,	@cSistema		CHAR(03)		= ''
	,	@nNumoper 		NUMERIC(10,0)	= 0
	)
	RETURNS	FLOAT
AS
BEGIN

	declare @Resultado		float;			set @Resultado		= 0.0

    declare @Constituida	float;			set @Constituida	= 0.0
    declare @Efectivo		float;			set @Efectivo		= 0.0
    declare @Operaciones	float;			set @Operaciones	= 0.0
    declare @Gasignada		int;			set @Gasignada		= 0
    declare @FechaConv		datetime;		set @fechaConv		= ( select acfecante from BacTraderSuda.dbo.MDAC with(nolock) )
    declare @TCRC			float;			set @TCRC			= 1.0
											set @TCRC			= isnull( ( select tipo_cambio from BacParamSuda.dbo.Valor_Moneda_Contable 
																			 where fecha = @FechaConv and codigo_moneda = 994 ), 1.0)

    declare @RutAux			numeric(13);	set @RutAux			= @nRutCli
    declare @CodigoAux		numeric(5);		set @CodigoAux		= @nCodigo

    select	@nRutCli		= clrut_padre
		,	@nCodigo		= clcodigo_padre  
	from	BacLineas.dbo.cliente_relacionado with(nolock)
    where	clrut_hijo		= @RutAux 
	and		clcodigo_hijo	= @CodigoAux

	if @nMetodologia = 5
	begin
										-->  Garantias Constituidas
		set @Constituida = ISNULL((	SELECT	 SUM( c.ValorPresente + c.FactorMultiplicativo + b.FactorAditivo)
									FROM	 BacParamSuda.dbo.tbl_mov_garantia					  b
											 inner join BacParamSuda.dbo.tbl_mov_garantia_detalle c on c.NumeroOperacion = b.NumeroOperacion
									WHERE	 b.RutCliente = @nRutCli
									AND		 b.CodCliente = @nCodigo
									GROUP BY b.RutCliente, b.CodCliente), 0)

		set @Efectivo	=  ISNULL(( SELECT		garantiaefectiva 
		                   			FROM		BacParamSuda.dbo.Cliente
		                   			WHERE		Clrut		= @nRutCli	
									AND			ClCodigo	= @nCodigo
									AND			garantiaefectiva <> 0), 0)

		--	Conversión de las garantias de USD a CLP
		set @Resultado	= isnull( @Constituida + Round( @Efectivo * @TCRC, 0), 0)
	end

	if @nMetodologia = 4
	begin

		set @Gasignada	= (	select	count(1) 
							from	BacParamsuda.dbo.tbl_gar_AsociacionOper T01 
									inner join BacParamsuda.dbo.tbl_gar_AsociacionOper T02	 On T01.FolioAsocia		 = T02.FolioAsocia 
																							and T01.numeroOperacion <> T02.numeroOperacion
																							and	T01.RutCliente		 = T02.RutCliente
																							and	T01.CodCliente		 = T02.CodCliente   
							where	T01.RutCliente		 = @nRutCli
							and		T01.CodCliente		 = @nCodigo)

		if @Gasignada <> 0
		begin
			set @Resultado = 0
		end else
		begin
			select   @Operaciones			= isnull( SUM(GarDet.ValorPresente * GarDet.FactorMultiplicativo ) +  Gar.FactorAditivo , 0 )
			from	 BacParamsuda.dbo.tbl_gar_AsociacionOper   RelOpe
			,		 BacParamsuda.dbo.tbl_gar_asociaciongtia   RelGar
			,		 BacParamsuda.dbo.tbl_mov_garantia			  Gar
			,        BacParamsuda.dbo.tbl_mov_garantia_detalle GarDet
			where	 RelOpe.Sistema         = @cSistema
			and      RelOpe.numeroOperacion = @nNumoper
           	and      RelOpe.FolioAsocia		= RelGar.FolioAsocia
           	and      RelGar.NumeroGarantia  = Gar.NumeroOperacion
	   	    and      Gar.NumeroOperacion	= GarDet.NumeroOperacion
            group by Gar.FactorAditivo
		
			set @Resultado = @Operaciones
		end
	end

    RETURN @Resultado

END

GO
