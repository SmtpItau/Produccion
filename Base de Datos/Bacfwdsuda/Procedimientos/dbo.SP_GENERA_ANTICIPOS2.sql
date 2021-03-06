USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_ANTICIPOS2]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GENERA_ANTICIPOS2]( 

	@Fecha_usuario datetime ,     -- Debería ser parámetro entregado desde Visual
	@Contrato	numeric(10))      -- Debería ser parámetro entregado desde Visual  
									-- Sp_Genera_Anticipos2 '20071016' , 12753

AS 
BEGIN


       
DECLARE @Fecha_proceso DATETIME
DECLARE @cBanco        CHAR (60)

SELECT  @Fecha_proceso = acfecproc 
,       @cBanco=acnomprop     
FROM MFAC

DECLARE @Fecha_Ope_Original DATETIME

-- Busca fecha original del contrato en MFCA o en MFCAH
select  @Fecha_Ope_Original = isnull( (select cafecha from mfca where canumoper = @Contrato) , (select cafecha from mfcah where canumoper = @Contrato) )

---------------------------------------------------------------------------------
--- INSERT INTO #Producto
    SELECT
        PrdCod = CONVERT( NUMERIC(10) , Codigo_Producto) ,
        PrdDsc = SUBSTRING( Descripcion, 1, 25 )
    INTO #Producto
    FROM  BacParamSuda..producto
    WHERE Id_Sistema = 'BFW'

---------------------------------------------------------------------------------

	( 
	-- Operacion Original, siempre debe estar en la RES
	Select 	'Contrato' 		= ORIGINAL.CaNumOper
	, 'Anexo_Anticipo' 		= 0
	, 'Correlativo'			= 0 
	, 'Tipo_Operacion'		= ORIGINAL.CaTipOper
	, 'Fecha_Cierre'		= ORIGINAL.Cafecha
	, 'Total_Parcial'  		= 'ORIGINAL' 
	, 'Nocional_Original'		= ORIGINAL.CamtoMon1
	, 'Nocional_Anticipado' 	= 0.0 
	, 'Nombre_Cliente' 		= substring( CLIENTE.clnombre , 1, 20 )
	, 'Fecha_Suscripcion_Original' 	= ORIGINAL.cafecha						    
	, 'Moneda_Trasanda'		= MONEDA1.MnNemo
	, 'Moneda_Conversion'		= MONEDA2.MnNemo
	, 'Modalidad'			= ORIGINAL.CaTipModa	
	, 'Mda_Compensacion'		= 'N/A' 
	, 'Monto_en_Mda_Compensacion'	= 0.0
        , 'Cod_Producto'                = PrdCod     
        , 'Desc_Producto'               = PrdDsc
        , 'Fecha_Listado'               = @Fecha_usuario
        , 'Banco'                       = @cBanco    	     
	from 	MFCARES As ORIGINAL
		, BacParamSuda..MONEDA As MONEDA1
		, BacParamSuda..MONEDA As MONEDA2
		, VIEW_CLIENTE As CLIENTE
                , #Producto
	where 	 ORIGINAL.CaFechaProceso = @Fecha_Ope_Original  	-- Para ver operación cuando nació
		and   ORIGINAL.CaNumOper = @Contrato
		and   MONEDA1.MnCodMon  = ORIGINAL.CaCodMon1	
		and   MONEDA2.MnCodMon  = ORIGINAL.CaCodMon2	
		and   ORIGINAL.CaCodigo = CLIENTE.ClRut
		and   ORIGINAL.CaCodCli = CLIENTE.ClCodigo 
                And   #Producto.PrdCod  = Original.CaCodpos1

	UNION 
	-- ANTICIPO DEL DIA DE PROCESO
	Select 	'Contrato' 		= ORIGINAL.CaNumOper
	, 'Anexo_Anticipo' 		= ANTICIPO.Canumoper
	, 'Correlativo'			= ANTICIPO.caAntCorrela
	, 'Tipo_Operacion'		= ANTICIPO.CaTipOper
	, 'Fecha_Cierre'		= ANTICIPO.cafecvcto  
	, 'Total_Parcial'  		= case when ANTICIPO.Canumoper = ANTICIPO.NumeroContratoCliente then 'ANT. TOT.' else 'ANT. PARCIAL' end 
	, 'Nocional_Original'		= 0.0 
	, 'Nocional_Anticipado' 	= ANTICIPO.CaMtoMon1 
	, 'Nombre_Cliente' 		= substring( CLIENTE.clnombre , 1, 20 )
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
	from 	MFCARES As ORIGINAL
		, MFCA As ANTICIPO
		, BacParamSuda..MONEDA As MONEDA1
		, BacParamSuda..MONEDA As MONEDA2
		, BacParamSuda..MONEDA As MONEDACOMP
		, VIEW_CLIENTE As CLIENTE 
                , #Producto
	where 	 ORIGINAL.CaFechaProceso  = @Fecha_Ope_Original  	-- Para ver operación cuando nació
		and   ORIGINAL.CaNumOper  = @Contrato
		and   ANTICIPO.NumeroContratoCliente = @Contrato  -- OJO, Los Anticipos aparecen 1 vez en la MFCARES
		and   MONEDA1.MnCodMon    = ANTICIPO.CaCodMon1	
		and   MONEDA2.MnCodMon    = ANTICIPO.CaCodMon2	
		and   MONEDACOMP.MnCodMon = ANTICIPO.Moneda_Compensacion
		and   ANTICIPO.CaCodigo   = CLIENTE.ClRut
		and   ANTICIPO.CaCodCli   = CLIENTE.ClCodigo
                and   ANTICIPO.CaCodpos1  = #Producto.PrdCod
	UNION
	-- Anticipo de días anteriores
	Select 	'Contrato' 		= ORIGINAL.CaNumOper
	, 'Anexo_Anticipo' 		= ANTICIPO.Canumoper
	, 'Correlativo'			= ANTICIPO.caAntCorrela
	, 'Tipo_Operacion'		= ANTICIPO.CaTipOper
	, 'Fecha_Cierre'		= ANTICIPO.cafecvcto  
	, 'Total_Parcial'  		= CASE WHEN ANTICIPO.Canumoper = ANTICIPO.NumeroContratoCliente THEN 'ANT. TOT.' ELSE 'ANT. PARCIAL' END 
	, 'Nocional_Original'		= 0.0 
	, 'Nocional_Anticipado' 	= ANTICIPO.CaMtoMon1 
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

	from 	MFCARES As ORIGINAL
		, MFCARES As ANTICIPO
		, BacParamSuda..MONEDA As MONEDA1
		, BacParamSuda..MONEDA As MONEDA2
		, BacParamSuda..MONEDA As MONEDACOMP
		, VIEW_CLIENTE As CLIENTE
                , #Producto
	where 	 ORIGINAL.CaFechaProceso = @Fecha_Ope_Original  	-- Para ver operación cuando nació
		and   ANTICIPO.CaFechaProceso >= @Fecha_Ope_Original	-- Para activar utilizacion de indice
		and   ORIGINAL.CaNumOper = @Contrato
		and   ANTICIPO.NumeroContratoCliente = @Contrato  
                and   ANTICIPO.CaFechaProceso = ANTICIPO.CaFecVcto   -- OJO, Los Anticipos aparecen 1 vez en la MFCARES, esto gatilla optimización
		and   MONEDA1.MnCodMon  = ANTICIPO.CaCodMon1	
		and   MONEDA2.MnCodMon  = ANTICIPO.CaCodMon2	
		and   MONEDACOMP.MnCodMon = ANTICIPO.Moneda_Compensacion
		and   ANTICIPO.CaCodigo = CLIENTE.ClRut
		and   ANTICIPO.CaCodCli = CLIENTE.ClCodigo
                and   ORIGINAL.CaCodpos1  = #Producto.PrdCod

       )
	order by Fecha_Cierre, Correlativo

 


END



GO
