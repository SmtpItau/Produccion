USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_CARTERA_FWD_RF]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_CARTERA_FWD_RF] 
(    @Fecha DATETIME

   , @Rut numeric(13)   = 0
   , @Codigo numeric(3) = 0
)

AS
BEGIN
-- SP_RIEFIN_CONSULTA_CARTERA_FWD_RF '20110311'
-- SP_RIEFIN_CONSULTA_CARTERA_FWD_RF '20110311', 97043000, 1
-- SP_RIEFIN_CONSULTA_CARTERA_FWD_RF '20110314', 200000190, 1

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Cartera Efectiva

	IF @Rut = 0 
	BEGIN
		SELECT
			[Numero Operacion] = CARTERA.CaNumOper
		,	[Compra Venta] = CaTipOper
		,	[Nemo] = CARTERA.Caserie
		,	[Cartera] = PARAMETRIZA_CARTERA.Codigo
		,	[Nominal] = CARTERA.Camtomon1
		,	[Emisor] = EMISOR.emgeneric
		,	[Serie] = INSTRUMENTO.InSerie
		,	[Mascara] = CARTERA.Caserie
		,	[Fecha Vence Fwd] = CARTERA.CaFecEfectiva
		,	[Tasa Fwd] = CARTERA.CaTipCam
		,	[Moneda] = MONEDAS.Codigo
		,	[Tasa Subyacente] = PARAM_CURVAS.Codigo
		,	[Tasa Financiamiento] = PARAM_CURVA_FINANCIAMIENTO.Codigo
		,	[Base] = isnull( sebasemi , INSTRUMENTO.inbasemi ) -- Homologando valorizacion BAC del papel
		,	[Valor Mercado] = CARTERA.ValorRazonableActivo-CARTERA.ValorRazonablePasivo
		,	Rut = CARTERA.CaCodigo
		,   Codigo = CARTERA.CaCodCli
        ,   PosibleAplicacionET = case when isnull( MID.MddNumOpe, 0 ) = CARTERA.CanumOper  and  CARTERA.fRes_Obtenido < 0 then 'S' else 'N' end   
		,	Moneda_1_BAC = CARTERA.CaCodMon1
		,	Moneda_2_BAC = CARTERA.CaCodMon2
        ,   Plazo        = datediff( dd, @Fecha, CARTERA.CaFecVcto )
        ,   Duration     = datediff( dd, @Fecha, CARTERA.CaFecVcto ) / 365.0     
        ,   Producto     = CaCodPos1      
		FROM
			BACFWDSUDA.dbo.MFCARES CARTERA
            LEFT JOIN BacParamSuda.dbo.SERIE  ON SeMascara = CaSerie
            LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID ON MddMod = 'FWD' and MddNumOpe = Cartera.CanumOper
		,	BacParamSuda.dbo.EMISOR EMISOR
		,	BacParamSuda.dbo.INSTRUMENTO INSTRUMENTO
		,	ParametrosdboParametrizacion_Monedas MONEDAS
		,	ParametrosdboParametrizacion_RF PARAM_RF
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVAS
		,	ParametrosdboParametrizacion_Fwd_RF_Fmto FINANCIAMIENTO
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVA_FINANCIAMIENTO
		,	ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA
--		,	BacLineas.dbo.linea_general BANCOS
		WHERE
			CARTERA.CaFechaProceso = @Fecha
		AND	PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cacodcart
		AND	CARTERA.CaCodPos1 = 10
		AND CARTERA.CaBroker = INSTRUMENTO.InCodigo
		AND INSTRUMENTO.InRutEmi = EMISOR.emrut
		AND CARTERA.CaCodMon1 = MONEDAS.Codigo_BAC
		AND INSTRUMENTO.inserie = PARAM_RF.Serie
		AND PARAM_RF.Curva = PARAM_CURVAS.Curva
		AND PARAM_CURVAS.Producto = 'RF'
		AND FINANCIAMIENTO.Codigo_Moneda_BAC = CARTERA.CaCodMon1
		AND PARAM_CURVA_FINANCIAMIENTO.Curva = FINANCIAMIENTO.Curva
		AND CARTERA.CaAntici = ''
        AND CARTERA.CaEstado = ''
--		AND BANCOS.rut_Cliente = CARTERA.cacodigo
--		AND BANCOS.Codigo_cliente = CARTERA.CaCodCli  
UNION
		SELECT
			[Numero Operacion] = CARTERA.CaNumOper
		,	[Compra Venta] = CaTipOper
		,	[Nemo] = CARTERA.Caserie
		,	[Cartera] = PARAMETRIZA_CARTERA.Codigo
		,	[Nominal] = CARTERA.Camtomon1
		,	[Emisor] = '' -- EMISOR.emgeneric
		,	[Serie] = CARTERA.Caserie --  INSTRUMENTO.InSerie
		,	[Mascara] = CARTERA.Caserie 
		,	[Fecha Vence Fwd] = CARTERA.CaFecEfectiva
		,	[Tasa Fwd] = CARTERA.CaTipCam
		,	[Moneda] = MONEDAS.Codigo
		,	[Tasa Subyacente] = PARAM_CURVAS.Codigo
		,	[Tasa Financiamiento] = PARAM_CURVA_FINANCIAMIENTO.Codigo
		,	[Base] = 360 -- isnull( sebasemi , INSTRUMENTO.inbasemi ) -- Homologando valorizacion BAC del papel
		,	[Valor Mercado] = CARTERA.ValorRazonableActivo-CARTERA.ValorRazonablePasivo
		,	Rut = CARTERA.CaCodigo
		,   Codigo = CARTERA.CaCodCli
        ,   PosibleAplicacionET = case when isnull( MID.MddNumOpe, 0 ) = CARTERA.CanumOper  and  CARTERA.fRes_Obtenido < 0 then 'S' else 'N' end   
		,	Moneda_1_BAC = CARTERA.CaCodMon1
		,	Moneda_2_BAC = CARTERA.CaCodMon2
        ,   Plazo        = datediff( dd, @Fecha, CARTERA.CaFecVcto )
        ,   Duration     = datediff( dd, @Fecha, CARTERA.CaFecVcto ) / 365.0   
        ,   Producto     = CaCodPos1           
		FROM
			BACFWDSUDA.dbo.MFCA CARTERA
            LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID ON MddMod = 'FWD' and MddNumOpe = Cartera.CanumOper
		,	ParametrosdboParametrizacion_Monedas MONEDAS
		,	ParametrosdboParametrizacion_RF PARAM_RF
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVAS
		,	ParametrosdboParametrizacion_Fwd_RF_Fmto FINANCIAMIENTO
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVA_FINANCIAMIENTO
		,	ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA
--		,	BacLineas.dbo.linea_general BANCOS
		WHERE
			PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cacodcart
		AND	CARTERA.CaCodPos1 = 11
		AND CARTERA.CaCodMon1 = MONEDAS.Codigo_BAC
		AND PARAM_RF.Serie = '*'
		AND PARAM_RF.Curva = PARAM_CURVAS.Curva
		AND PARAM_CURVAS.Producto = 'RF'
		AND FINANCIAMIENTO.Codigo_Moneda_BAC = CARTERA.CaCodMon1
		AND PARAM_CURVA_FINANCIAMIENTO.Curva = FINANCIAMIENTO.Curva
		AND CARTERA.CaAntici = ''
        AND CARTERA.CaEstado = ''
--		AND BANCOS.rut_Cliente = CARTERA.cacodigo
--		AND BANCOS.Codigo_cliente = CARTERA.CaCodCli 
--		AND CARTERA.cacodigo = @Rut
--		AND CARTERA.CaCodCli = @Codigo
	END
	ELSE
	BEGIN
		
		DECLARE @Existe AS INT
		SET @Existe = 0

        CREATE TABLE #FAMILIA
           (
             Id                 VARCHAR(19) ,
             ClRut              numeric(13),
             ClCodigo           numeric(5),
             Afecta_Lineas_Hijo numeric(1)
           )

        INSERT INTO #FAMILIA
            EXECUTE BacLineas..SP_RIEFIN_FAMILIAS @Rut, @Codigo
        -- and #Familia.Afecta_Lineas_Hijo = 0 -- colocar al cruzar con Cartera
	
		SELECT @Existe=1
		FROM #Familia 
          , BACFWDSUDA.dbo.MFCA CARTERA
		WHERE  CARTERA.cacodigo = ClRut
           and CARTERA.CaCodCli = ClCodigo
           and #Familia.Afecta_Lineas_Hijo = 0 
	
		IF @Existe =0 
		BEGIN
		SELECT 'Consulta'= -1,'Rut'= 'Rut no existe en Cartera'
		RETURN
		END
				
		SELECT
			[Numero Operacion] = CARTERA.CaNumOper
		,	[Compra Venta] = CaTipOper
		,	[Nemo] = CARTERA.Caserie
		,	[Cartera] = PARAMETRIZA_CARTERA.Codigo
		,	[Nominal] = CARTERA.Camtomon1
		,	[Emisor] = EMISOR.emgeneric
		,	[Serie] = INSTRUMENTO.InSerie
		,	[Mascara] = CARTERA.Caserie
		,	[Fecha Vence Fwd] = CARTERA.CaFecEfectiva
		,	[Tasa Fwd] = CARTERA.CaTipCam
		,	[Moneda] = MONEDAS.Codigo
		,	[Tasa Subyacente] = PARAM_CURVAS.Codigo
		,	[Tasa Financiamiento] = PARAM_CURVA_FINANCIAMIENTO.Codigo
		,	[Base] = isnull( sebasemi , INSTRUMENTO.inbasemi ) -- Homologando valorizacion BAC del papel
		,	[Valor Mercado] = CARTERA.ValorRazonableActivo-CARTERA.ValorRazonablePasivo
		,	Rut = CARTERA.CaCodigo
		,   Codigo = CARTERA.CaCodCli
        ,   PosibleAplicacionET = case when isnull( MID.MddNumOpe, 0 ) = CARTERA.CanumOper  and  CARTERA.fRes_Obtenido < 0 then 'S' else 'N' end   
		,	Moneda_1_BAC = CARTERA.CaCodMon1
		,	Moneda_2_BAC = CARTERA.CaCodMon2
        ,   Plazo        = datediff( dd, @Fecha, CARTERA.CaFecVcto )
        ,   Duration     = datediff( dd, @Fecha, CARTERA.CaFecVcto ) / 365.0        
        ,   Producto     = CaCodPos1      
		FROM
			BACFWDSUDA.dbo.MFCA CARTERA
            LEFT JOIN BacParamSuda.dbo.SERIE  ON SeMascara = CaSerie
            LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID ON MddMod = 'FWD' and MddNumOpe = Cartera.CanumOper
		,	BacParamSuda.dbo.EMISOR EMISOR
		,	BacParamSuda.dbo.INSTRUMENTO INSTRUMENTO
		,	ParametrosdboParametrizacion_Monedas MONEDAS
		,	ParametrosdboParametrizacion_RF PARAM_RF
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVAS
		,	ParametrosdboParametrizacion_Fwd_RF_Fmto FINANCIAMIENTO
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVA_FINANCIAMIENTO
		,	ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA
        ,   #Familia Fam
--		,	BacLineas.dbo.linea_general BANCOS
		WHERE
			PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cacodcart
		AND	CARTERA.CaCodPos1 = 10
		AND CARTERA.CaBroker = INSTRUMENTO.InCodigo
		AND INSTRUMENTO.InRutEmi = EMISOR.emrut
		AND CARTERA.CaCodMon1 = MONEDAS.Codigo_BAC
		AND INSTRUMENTO.inserie = PARAM_RF.Serie
		AND PARAM_RF.Curva = PARAM_CURVAS.Curva
		AND PARAM_CURVAS.Producto = 'RF'
		AND FINANCIAMIENTO.Codigo_Moneda_BAC = CARTERA.CaCodMon1
		AND PARAM_CURVA_FINANCIAMIENTO.Curva = FINANCIAMIENTO.Curva
		AND CARTERA.CaAntici = ''
        AND CARTERA.CaCodigo = Fam.Clrut 
        AND CARTERA.Cacodcli= Fam.ClCodigo 

--		AND BANCOS.rut_Cliente = CARTERA.cacodigo
--		AND BANCOS.Codigo_cliente = CARTERA.CaCodCli 
--		AND CARTERA.cacodigo = @Rut
--		AND CARTERA.CaCodCli = @Codigo
UNION
		SELECT
			[Numero Operacion] = CARTERA.CaNumOper
		,	[Compra Venta] = CaTipOper
		,	[Nemo] = CARTERA.Caserie
		,	[Cartera] = PARAMETRIZA_CARTERA.Codigo
		,	[Nominal] = CARTERA.Camtomon1
		,	[Emisor] = '' -- EMISOR.emgeneric
		,	[Serie] = CARTERA.Caserie --  INSTRUMENTO.InSerie
		,	[Mascara] = CARTERA.Caserie 
		,	[Fecha Vence Fwd] = CARTERA.CaFecEfectiva
		,	[Tasa Fwd] = CARTERA.CaTipCam
		,	[Moneda] = MONEDAS.Codigo
		,	[Tasa Subyacente] = PARAM_CURVAS.Codigo
		,	[Tasa Financiamiento] = PARAM_CURVA_FINANCIAMIENTO.Codigo
		,	[Base] = 360 -- isnull( sebasemi , INSTRUMENTO.inbasemi ) -- Homologando valorizacion BAC del papel
		,	[Valor Mercado] = CARTERA.ValorRazonableActivo-CARTERA.ValorRazonablePasivo
		,	Rut = CARTERA.CaCodigo
		,   Codigo = CARTERA.CaCodCli
        ,   PosibleAplicacionET = case when isnull( MID.MddNumOpe, 0 ) = CARTERA.CanumOper  and  CARTERA.fRes_Obtenido < 0 then 'S' else 'N' end   
		,	Moneda_1_BAC = CARTERA.CaCodMon1
		,	Moneda_2_BAC = CARTERA.CaCodMon2
        ,   Plazo        = datediff( dd, @Fecha, CARTERA.CaFecVcto )
        ,   Duration     = datediff( dd, @Fecha, CARTERA.CaFecVcto ) / 365.0        
        ,   Producto     = CaCodPos1      
		FROM
			BACFWDSUDA.dbo.MFCA CARTERA
            LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID ON MddMod = 'FWD' and MddNumOpe = Cartera.CanumOper
		,	ParametrosdboParametrizacion_Monedas MONEDAS
		,	ParametrosdboParametrizacion_RF PARAM_RF
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVAS
		,	ParametrosdboParametrizacion_Fwd_RF_Fmto FINANCIAMIENTO
		,	ParametrosdboParametrizacion_Curvas PARAM_CURVA_FINANCIAMIENTO
		,	ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA
        ,   #FAMILIA Fam
--		,	BacLineas.dbo.linea_general BANCOS
		WHERE
			PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cacodcart
		AND	CARTERA.CaCodPos1 = 11
		AND CARTERA.CaCodMon1 = MONEDAS.Codigo_BAC
		AND PARAM_RF.Serie = '*'
		AND PARAM_RF.Curva = PARAM_CURVAS.Curva
		AND PARAM_CURVAS.Producto = 'RF'
		AND FINANCIAMIENTO.Codigo_Moneda_BAC = CARTERA.CaCodMon1
		AND PARAM_CURVA_FINANCIAMIENTO.Curva = FINANCIAMIENTO.Curva
		AND CARTERA.CaAntici = ''
--		AND BANCOS.rut_Cliente = CARTERA.cacodigo
--		AND BANCOS.Codigo_cliente = CARTERA.CaCodCli 
--		AND CARTERA.cacodigo = @Rut
--		AND CARTERA.CaCodCli = @Codigo
        AND CARTERA.CaCodigo = Fam.Clrut 
        AND CARTERA.Cacodcli = Fam.ClCodigo 



	END		
END
GO
