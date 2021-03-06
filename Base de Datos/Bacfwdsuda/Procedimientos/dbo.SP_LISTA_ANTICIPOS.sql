USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTA_ANTICIPOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTA_ANTICIPOS] (@Fecha_usuario    DATETIME
                                          )

AS
BEGIN

SET NOCOUNT ON


--declare @Fecha_usuario    DATETIME
--select  @Fecha_usuario 	 = '20071016'  -- Debería ser parámetro del Sp_
-- SP_LISTA_ANTICIPOS '20071206'

DECLARE @Fecha_proceso DATETIME
DECLARE @cBanco        CHAR (60)
SELECT  @Fecha_proceso = acfecproc 
,       @cBanco=acnomprop     
FROM MFAC

DECLARE @Fecha_ant_Habil DATETIME


---------------------------------------------------------------------------------
--    INSERT INTO #Producto
    SELECT
        PrdCod = CONVERT( NUMERIC(10) , Codigo_Producto) ,
        PrdDsc = SUBSTRING( Descripcion, 1, 25 )
    INTO #Producto
    FROM BacParamSuda..producto
    WHERE Id_Sistema = 'BFW'

---------------------------------------------------------------------------------
--   select * from #Producto

    IF  @Fecha_usuario = @Fecha_proceso 
        BEGIN
	    -- Para listar los anticipos realizados en el dia de proceso
	SELECT  @Fecha_ant_Habil 	= acfecante FROM mfac  

	SELECT 	'Contrato_Anticipado' 	= ANTICIPO.NumeroContratoCliente
	, 'Anexo_Anticipo' 		= ANTICIPO.Canumoper
	, 'Correlativo'			= ANTICIPO.caAntCorrela
	, 'Tipo_Operacion'		= ANTICIPO.CaTipOper
	, 'Total_Parcial'  		= CASE WHEN ANTICIPO.Canumoper = ANTICIPO.NumeroContratoCliente THEN 'TOTAL' ELSE 'PARCIAL' END 
	, 'Nocional_Anticipado' 	= ANTICIPO.CaMtoMon1 
	, 'Nocional_Original'		= CASE WHEN ANTICIPO.Cacodpos1 = 13 THEN ANTICIPO.camtomon1 ELSE ORIGINAL.CamtoMon1 END
	, 'Nombre_Cliente' 		= SUBSTRING( CLIENTE.clnombre , 1, 20 )
	, 'Fecha_Suscripcion_Original' 	= ORIGINAL.cafecha						    
	, 'Moneda_Trasanda'		= MONEDA1.MnNemo
	, 'Moneda_Conversion'		= MONEDA2.MnNemo
	, 'Modalidad_Anticipo'		= ANTICIPO.CaTipModa	
	, 'Mda_Compensacion'		= MONEDACOMP.MnNemo
	, 'Monto_en_Mda_Compensacion'	= ANTICIPO.caAntMtoMdaComp
        , 'Cod_Producto'                = PrdCod     
        , 'Desc_Producto'               = PrdDsc
        , 'Fecha_Listado'               = @Fecha_usuario
        , 'Banco'                       = @cBanco              
        , 'PrecOperEF'                  = ANTICIPO.CaAntPreOpEF
        , 'ForPagMdaTrans'		= ISNULL((SELECT Glosa FROM VIEW_FORMA_DE_PAGO WHERE Codigo =ANTICIPO.Cafpagomx ), '')
        , 'ForPagMdaConv'		= ISNULL((SELECT Glosa FROM VIEW_FORMA_DE_PAGO WHERE Codigo =ANTICIPO.Cafpagomn ), '')
        , 'TasaPlazoRem'		= ANTICIPO.CaAntTasaPlazoRem
        , 'BasetasaPlazoRem'		= ANTICIPO.CaAntBase
        , 'UtilImplOpEF'		= ANTICIPO.cacolmon1
        , 'CompMdaConv' 	   	= ANTICIPO.CaMtoComp
        , 'MTMComplAntMdaConv'          = ANTICIPO.CaMarkToMarket
        , 'MTMCostoAntMdaConv'		= ANTICIPO.CaAntMTMCost
        , 'MargenMdaConv'		= ANTICIPO. caAntMargenContMda
        , 'PrecioSpotAnt'               = ANTICIPO.Precio_Spot
        , 'PuntosFwdAnt'                = ANTICIPO.CaAntPtosFwd
        , 'PrecioSpotCosto'		= ANTICIPO.CaPreAnt
        , 'PuntosCosto'			= ANTICIPO.CaAntPtosCos
	, 'Valor_Pactado'		= ORIGINAL.CatipCam
	, 'Plazo_Rem'			= datediff( dd, ANTICIPO.cafecvcto, ANTICIPO.cafecvenor ) --datediff( dd, ANTICIPO.cafecha, ANTICIPO.cafecvenor ) 
	, 'Valor_Pactado_Desc'		= ANTICIPO.CaPrecioFwd  -- select * from mfca
	, 'Valor_Spot_MasPtosDesc'	= ANTICIPO.CaPrecioMTM
        , 'CodForPagMdaComp'		= ANTICIPO. caAntForPagMdaComp
        , 'DescForPagMdaComp'		= (SELECT glosa  FROM  BacParamSuda..Forma_de_pago where codigo= ANTICIPO. caAntForPagMdaComp)
	, 'CodMdaTrans'		        = ANTICIPO.CaCodMon1
	, 'CodMdaConv'		        = ANTICIPO.CaCodMon2
	, 'CodMdaComp'		        = ANTICIPO.Moneda_Compensacion
	, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

        
	FROM 	MFCA AS ANTICIPO , MFCARES AS ORIGINAL
		, BacParamSuda..MONEDA AS MONEDA1
		, BacParamSuda..MONEDA AS MONEDA2
		, BacParamSuda..MONEDA AS MONEDACOMP
		, VIEW_CLIENTE AS CLIENTE
                , #Producto
	WHERE ANTICIPO.cafecvcto      = @Fecha_usuario 
	AND   ANTICIPO.caantici       = 'A'
	AND   MONEDA1.MnCodMon   = ANTICIPO.CaCodMon1	
	AND   MONEDA2.MnCodMon        = ANTICIPO.CaCodMon2	
	AND   MONEDACOMP.MnCodMon     = ANTICIPO.Moneda_Compensacion
	AND   ANTICIPO.CaCodigo       = CLIENTE.ClRut
	AND   ANTICIPO.CaCodCli       = CLIENTE.ClCodigo 
	AND   ORIGINAL.CaFechaProceso =  @Fecha_ant_Habil 
	AND   ORIGINAL.Canumoper    = ANTICIPO.NumeroContratoCliente
        AND   #Producto.PrdCod        = Original.CaCodpos1
        ORDER BY ANTICIPO.NumeroContratoCliente
    END
    ELSE	
    BEGIN 
	-- Para poder listar los anticipos de fechas anteriores
	SELECT  @Fecha_ant_Habil = acfecante FROM mfach WHERE acfecproc = @Fecha_usuario
	SELECT 	'Contrato_Anticipado' 	= ANTICIPO.NumeroContratoCliente
	, 'Anexo_Anticipo' 		= ANTICIPO.Canumoper
	, 'Correlativo'			= ANTICIPO.caAntCorrela
	, 'Tipo_Operacion'		= ANTICIPO.CaTipOper
	, 'Total_Parcial'  		= CASE when ANTICIPO.Canumoper = ANTICIPO.NumeroContratoCliente THEN 'TOTAL' else 'PARCIAL' end 
	, 'Nocional_Anticipado' 	= ANTICIPO.CaMtoMon1 
	, 'Nocional_Original'		= CASE WHEN ANTICIPO.Cacodpos1 = 13 THEN ANTICIPO.camtomon1 ELSE ORIGINAL.CamtoMon1 END --ORIGINAL.CamtoMon1
	, 'Nombre_Cliente' 		= SUBSTRING( CLIENTE.clnombre , 1, 20 )
	, 'Fecha_Suscripcion_Original' 	= ORIGINAL.cafecha						    
	, 'Moneda_Trasanda'		= MONEDA1.MnNemo
	, 'Moneda_Conversion'		= MONEDA2.MnNemo
	, 'Modalidad_Anticipo'		= ANTICIPO.CaTipModa	
	, 'Mda_Compensacion'		= MONEDACOMP.MnNemo
	, 'Monto_en_Mda_Compensacion'	= ANTICIPO.caAntMtoMdaComp 
        , 'Cod_Producto'                = PrdCod     
        , 'Desc_Producto'               = PrdDsc
        , 'Fecha_Listado'               = @Fecha_usuario
        , 'Banco'          = @cBanco
        , 'PrecOperEF'                  = ANTICIPO.CaAntPreOpEF
        , 'ForPagMdaTrans'		= ISNULL((SELECT Glosa FROM VIEW_FORMA_DE_PAGO WHERE Codigo = ANTICIPO.Cafpagomx), '')
        , 'ForPagMdaConv'		= ISNULL((SELECT Glosa FROM VIEW_FORMA_DE_PAGO WHERE Codigo =ANTICIPO.Cafpagomn), '')
        , 'TasaPlazoRem'		= ANTICIPO.CaAntTasaPlazoRem
        , 'BasetasaPlazoRem'		= ANTICIPO.CaAntBase
        , 'UtilImplOpEF'		= ANTICIPO.cacolmon1
        , 'CompMdaConv' 	   	= ANTICIPO.CaMtoComp
        , 'MTMComplAntMdaConv'          = ANTICIPO.CaMarkToMarket
        , 'MTMCostoAntMdaConv'		= ANTICIPO.CaAntMTMCost
        , 'MargenMdaConv'		= ANTICIPO. caAntMargenContMda
        , 'PrecioSpotAnt'               = ANTICIPO.Precio_Spot
        , 'PuntosFwdAnt'                = ANTICIPO.CaAntPtosFwd
        , 'PrecioSpotCosto'		= ANTICIPO.CaPreAnt
        , 'PuntosCosto'			= ANTICIPO.CaAntPtosCos
	, 'Valor_Pactado'		= ORIGINAL.CatipCam
	, 'Plazo_Rem'			= datediff( dd, ANTICIPO.cafecvcto, ANTICIPO.cafecvenor ) --datediff( dd, ANTICIPO.cafecha, ANTICIPO.cafecvenor ) 
	, 'Valor_Pactado_Desc'		= ANTICIPO.CaPrecioFwd
	, 'Valor_Spot_MasPtosDesc'	= ANTICIPO.CaPrecioMTM
        , 'CodForPagMdaComp'		= ANTICIPO. caAntForPagMdaComp
        , 'DescForPagMdaComp'		= (SELECT glosa  FROM  BacParamSuda..Forma_de_pago where codigo= ANTICIPO. caAntForPagMdaComp)
	, 'CodMdaTrans'		        = ANTICIPO.CaCodMon1
	, 'CodMdaConv'		        = ANTICIPO.CaCodMon2
	, 'CodMdaComp'		        = ANTICIPO.Moneda_Compensacion
	, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

	from 	MFCARES As ANTICIPO , MFCARES As ORIGINAL
		, BacParamSuda..MONEDA As MONEDA1
		, BacParamSuda..MONEDA As MONEDA2
		, BacParamSuda..MONEDA As MONEDACOMP
		, VIEW_CLIENTE As CLIENTE
                , #Producto
	where ANTICIPO.CaFechaProceso = @Fecha_usuario
	and   ANTICIPO.cafecvcto = @Fecha_usuario 
	and   ANTICIPO.caantici = 'A'
	and   MONEDA1.MnCodMon  = ANTICIPO.CaCodMon1	
	and   MONEDA2.MnCodMon  = ANTICIPO.CaCodMon2	
	and   MONEDACOMP.MnCodMon = ANTICIPO.Moneda_Compensacion
	and   ANTICIPO.CaCodigo = CLIENTE.ClRut
	and   ANTICIPO.CaCodCli = CLIENTE.ClCodigo 
	and   ORIGINAL.CaFechaProceso =  @Fecha_ant_Habil 
	and   ORIGINAL.Canumoper = ANTICIPO.NumeroContratoCliente
        AND   #Producto.PrdCod    = Original.CaCodpos1
        ORDER BY ANTICIPO.NumeroContratoCliente
END


DROP TABLE #Producto

SET NOCOUNT OFF 
END


GO
