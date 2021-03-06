USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_CARTERA_FWD]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_CARTERA_FWD]   
 (   @FechaParMuerto  DATETIME  
         , @Rut				NUMERIC(13) = 0  
         , @Codigo			NUMERIC(3) = 0
         , @Vehiculo		Varchar(15) = 'CORPBANCA'
         , @ConVencidosHoy  Numeric(1) = 1
)  
  
 AS

BEGIN  
-- SP_RIEFIN_CONSULTA_CARTERA_FWD '20110311' -- 472655828 -- 47005194  
-- SP_RIEFIN_CONSULTA_CARTERA_FWD '20110311', 472655828, 1    -- Padre, 10 contratos  
-- SP_RIEFIN_CONSULTA_CARTERA_FWD '20110311', 990005010, 1    -- Hijo  
-- SP_RIEFIN_CONSULTA_CARTERA_FWD '20110311', 3603339, 1   -- Sin familia
-- dbo.SP_RIEFIN_CONSULTA_CARTERA_FWD '20110311', 59029940, 1   -- Sin familia
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
-- SP_RIEFIN_CONSULTA_CARTERA_FWD '19000101', 0, 0, 'CCB'
-- SP_RIEFIN_CONSULTA_CARTERA_FWD '19000101', 0, 0, 'CCB', 1 -- 118
-- SP_RIEFIN_CONSULTA_CARTERA_FWD '19000101', 0, 0, 'CCB', 0 -- 116
-- SP_RIEFIN_CONSULTA_CARTERA_FWD_CONTINGENCIA '19000101', 0, 0, 'CCB', 0 -- 116
-- SP_RIEFIN_CONSULTA_CARTERA_FWD '20150623', 200000190, 1 , 'CORPBANCA', 1 
-- select * from bacparamsuda.dbo.cliente where ClRecMtdCod  = 3
 SET NOCOUNT ON;  
   
 DECLARE @FechaMet5y2 DATETIME
 SELECT  @FechaMet5y2 = acfecproc  FROM bactradersuda..mdac

   /************* Mantención ********************************
    Procedimiento debe agregar:
	   + Registros de la tabla BacSwapNY.dbo.Cartera_Eval (1)
	   + Registros de la tabla BacSwapSuda.dbo.Cartera_Eval (2)
	   + Registros de la tabla BacSwapNY.dbo.Cartera (3)
    Debido a PRDXXXXX
	Proyecto Turing del año 2012 no agregó tabla (2).  
	Banco soportará las lineas de clientes NY por esto se
	agregan tablas (1) y (3).
   **********************************************************/
   -- Chequeo existencia Base de datos.
   declare @BaseNYActiva varchar(1)
   declare @ComandoRescateCartera Varchar(8000)
   select @BaseNYActiva = 'N'

   
    DECLARE @Existe  int  
   
 -- Busca el dia laboral anterior  
 DECLARE @Fecha DATETIME
 DECLARE @FechaProx DATETIME
   
-- Importa las fechas relevantes
  SELECT  
		@Fecha = acfecproc
	,	@FechaProx = acfecprox
  from  
		BacTraderSuda.dbo.mdac  -- select * from BacTraderSuda.dbo.mdac 
-- Importa las fechas relevantes
 IF  @Vehiculo = 'CORPBANCA' 
 BEGIN 
 -- Ahora obtiene una tabla de los otros productos forward excepto FBT  
 IF @Rut = 0    
 BEGIN   
  SELECT  
   Numero_operacion = CARTERA.canumoper  
  , Sentido = CARTERA.catipoper  
  , Tipo_fwd = CARTERA.cacodpos1  
  , Modalidad = CARTERA.catipmoda  
  , Cartera = PARAMETRIZA_CARTERA.Codigo  
  , Moneda_1 = PARAMETRIZA_MONEDA_1.Codigo  
  , Moneda_2 = PARAMETRIZA_MONEDA_2.Codigo  
  , Fecha_inicio = CARTERA.cafecha  
  , Fecha_vencimiento = CARTERA.cafecvcto  
  , Fecha_efectiva = CASE  
    WHEN CARTERA.cacodpos1 = 2 THEN CARTERA.cafecvcto  
    ELSE CASE  
     WHEN CARTERA.catipmoda = 'C' THEN CARTERA.cafecefectiva  
     ELSE CARTERA.cafecvcto  
     END  
    END  
  , Codigo_descuento_1 = PARAMETRIZA_CURVAS_1.Codigo  
  , Codigo_descuento_2 = PARAMETRIZA_CURVAS_2.Codigo  
  , Nominal_1 = CARTERA.camtomon1  
  , Nominal_2 = CARTERA.camtomon2  
  , Valor_1 = CASE  
    WHEN CARTERA.catipoper = 'C' THEN  
     CARTERA.ValorRazonableActivo  
    WHEN CARTERA.catipoper = 'V' THEN  
     -CARTERA.ValorRazonablePasivo  
    END  
  , Valor_2 = CASE  
    WHEN CARTERA.catipoper = 'C' THEN  
     -CARTERA.ValorRazonablePasivo  
    WHEN CARTERA.catipoper = 'V' THEN  
     CARTERA.ValorRazonableActivo  
    END  
  , Fecha_Fixing = CARTERA.CaFechaFijacionStarting  
  , Puntos_Fwd = CARTERA.CaPuntosFwdCierre  
  , Rut = CARTERA.CaCodigo  
  ,   Codigo = CARTERA.CaCodCli  
        ,   PosibleAplicacionET = case when isnull( MID.MddNumOpe, 0 ) = CARTERA.CanumOper  and CARTERA.fRes_Obtenido < 0 then 'S' else 'N' end  
  , Moneda_1_BAC = CARTERA.CaCodMon1  
  , Moneda_2_BAC = CARTERA.CaCodMon2  
        ,   Plazo        = datediff( dd, @FechaMet5y2, CARTERA.CaFecEfectiva )  
        ,   Duration     = datediff( dd, @FechaMet5y2, CARTERA.CaFecEfectiva ) / 365.0          
  FROM  
   Bacfwdsuda.dbo.MFCARES CARTERA  -- select * from Bacfwdsuda.dbo.MFCARES  
        LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID ON MddMod = 'FWD' and MddNumOpe = CARTERA.CaNumOper  
  LEFT JOIN TBL_RieFinParametrizacion_Fixing_Arbitrajes FIX  -- select * from Parametros.dbo.Parametrizacion_Fixing_Arbitrajes  
         ON  
         FIX.Rut = CARTERA.cacodigo  
            AND FIX.Codigo = CARTERA.cacodcli         
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_1  
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_2  
  , ParametrosdboParametrizacion_Fwd PARAMETRIZA_FWD  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_1  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_2  
  , ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA  
  
  WHERE  
   CARTERA.cafechaproceso = @Fecha  
  AND PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cacodcart  
  AND PARAMETRIZA_MONEDA_1.Codigo_BAC = CARTERA.cacodmon1  
  AND PARAMETRIZA_MONEDA_2.Codigo_BAC = CARTERA.cacodmon2  
  AND PARAMETRIZA_FWD.Moneda_1 = CARTERA.cacodmon1  
  AND PARAMETRIZA_FWD.Moneda_2 = CARTERA.cacodmon2  
  AND PARAMETRIZA_FWD.Curva_1 = PARAMETRIZA_CURVAS_1.Curva  
  AND PARAMETRIZA_FWD.Curva_2 = PARAMETRIZA_CURVAS_2.Curva  
  AND PARAMETRIZA_CURVAS_1.Producto = 'Forward'  
  AND PARAMETRIZA_CURVAS_2.Producto = 'Forward'  
  AND CARTERA.CaAntici = ''  
--  AND BANCOS.rut_Cliente = CARTERA.Cacodigo  
--  AND BANCOS.Codigo_cliente = CARTERA.CACodCli  
  AND  
   (  
    ( -- Si es un seguro de cambio, entonces fecha debe ser mayor que fecha efectiva  
     (CARTERA.cacodpos1 = 1 OR CARTERA.cacodpos1 = 3 OR CARTERA.cacodpos1 = 14)  
    AND (  
      ( -- Si la operacion es compensada importa la fecha efectiva  
						catipmoda = 'C'
					AND	cafecefectiva >= @Fecha
      )  
     OR  
      ( -- Si la operacion es con entrega fisica importa la fecha de vencimiento  
						catipmoda = 'E'
					AND	cafecvcto >= @Fecha
      )  
     )  
    )  
   OR  
    ( -- Si es un arbitraje a futuro, fecha debe ser mayor al fixing dependiendo del cliente  
     CARTERA.cacodpos1 = 2  
			AND
				(
					(catipmoda = 'E' AND cafecvcto >= @Fecha)
				OR
					(catipmoda = 'C' AND Fixing IS NULL AND cafecefectiva >= @Fecha)
				OR
					(catipmoda = 'C' AND Fixing = 1 AND cafecvcto >= @FechaProx)
				OR
					(catipmoda = 'C' AND Fixing = 2 AND cafecvcto > @FechaProx)
				)
    )  
   )  
    END -- @Rut = 0  
 ELSE  
 BEGIN  

 
 -- PRD 12119 COMDER
		 SELECT  canumoper  
		  , catipoper  
		  , cacodpos1  
		  , catipmoda  
		  , cafecha  
		  , cafecvcto  		  
		  ,	cafecefectiva  
		  , camtomon1  
		  , camtomon2  
		  , ValorRazonableActivo  
		  , ValorRazonablePasivo  				  
		  , CaFechaFijacionStarting  
		  , CaPuntosFwdCierre  
		  , CaCodigo  
		  , CaCodCli  
		  , PosibleAplicacionET = case when bEarlyTermination = 1 and fRes_Obtenido < 0 then 'S' else 'N' end
		  , CaCodMon1  
		  , CaCodMon2
		  ,  CaAntici, fRes_Obtenido , cacodcart
		     into #Cartera_ComDer 
		 FROM   BDBOMESA.dbo.ComDer_RelacionMarcaComder AS mc INNER JOIN
				BacFwdSuda.dbo.mfca AS c ON mc.nReNumOper = c.canumoper   -- select * from BacFwdSuda.dbo.mfca where 1 = 2
		 WHERE  (mc.iReNovacion = 1) AND (mc.vReEstado = 'V')
		         AND c.canumoper NOT IN(SELECT numero_operacion FROM BDBOMESA..ComDer_SolicitudEstado WHERE id_estado = 6)
	 


		 UPDATE #Cartera_ComDer SET cacodigo = 76317889
		 -- select * from #Cartera_ComDer

 -- Fin PRD 12119 COMDER
		


	     if exists( select (1) from master.dbo.sysdatabases where name = 'BacFWDNY' )
	     begin
		  select @BaseNYActiva = 'S'
	     end
	     select canumoper  
		  , catipoper  
		  , cacodpos1  
		  , catipmoda  
		  , cafecha  
		  , cafecvcto  		  
		  ,	cafecefectiva  
		  , camtomon1  
		  , camtomon2  
		  , ValorRazonableActivo  
		  , ValorRazonablePasivo  				  
		  , CaFechaFijacionStarting  
		  , CaPuntosFwdCierre  
		  , CaCodigo  
		  , CaCodCli  
		  , PosibleAplicacionET = ' '
		  , CaCodMon1  
		  , CaCodMon2
		  , CaAntici
		  , fRes_Obtenido 
		  , cacodcart
		   into #Cartera from Bacfwdsuda.dbo.mfca where 1 = 2		 
	     select @ComandoRescateCartera = ''
	     select @ComandoRescateCartera = @ComandoRescateCartera + ' select  canumoper , catipoper , cacodpos1 , catipmoda , cafecha , cafecvcto
         ,	cafecefectiva , camtomon1,camtomon2, ValorRazonableActivo, ValorRazonablePasivo , CaFechaFijacionStarting , CaPuntosFwdCierre  
         ,  CaCodigo , CaCodCli , PosibleAplicacionET = case when bEarlyTermination = 1 and fRes_Obtenido < 0 then ''S'' else ''N'' end, CaCodMon1 , CaCodMon2 
		 ,  CaAntici, fRes_Obtenido , cacodcart
		 from BacFwdSuda.dbo.Mfca '
		 select @ComandoRescateCartera = @ComandoRescateCartera + ' union select  canumoper, catipoper, cacodpos1, catipmoda, cafecha  		  
		  , cafecvcto ,	cafecefectiva, camtomon1, camtomon2, ValorRazonableActivo, ValorRazonablePasivo, CaFechaFijacionStarting  
		  , CaPuntosFwdCierre, CaCodigo , CaCodCli  , PosibleAplicacionET = case when bEarlyTermination = 1 and fRes_Obtenido < 0 then ''S'' else ''N'' end
		  , CaCodMon1, CaCodMon2   
		  ,  CaAntici, fRes_Obtenido , cacodcart
		  from BacFwdSuda.dbo.Mfca_Eval '  
		  select @ComandoRescateCartera = @ComandoRescateCartera + 'union select  canumoper, catipoper, cacodpos1, catipmoda  
		  , cafecha, cafecvcto,	cafecefectiva, camtomon1, camtomon2, ValorRazonableActivo, ValorRazonablePasivo  				  
		  , CaFechaFijacionStarting, CaPuntosFwdCierre, CaCodigo, CaCodCli
		  , PosibleAplicacionET 
		  , CaCodMon1 , CaCodMon2  
		  ,  CaAntici, fRes_Obtenido , cacodcart
		   from #Cartera_ComDer ' -- 573339
	     if @BaseNYActiva = 'S'
			select @ComandoRescateCartera = @ComandoRescateCartera + ' union select  canumoper, catipoper, cacodpos1, catipmoda  
		  , cafecha, cafecvcto,	cafecefectiva, camtomon1, camtomon2, ValorRazonableActivo, ValorRazonablePasivo  				  
		  , CaFechaFijacionStarting, CaPuntosFwdCierre, CaCodigo, CaCodCli, PosibleAplicacionET = ''N'' 
		  , CaCodMon1, CaCodMon2
		  ,  CaAntici, fRes_Obtenido , cacodcart
		     from BacFwdNY.dbo.Mfca '
         if @BaseNYActiva = 'S'
         select @ComandoRescateCartera = @ComandoRescateCartera + 			 
			 ' union select  canumoper, catipoper, cacodpos1, catipmoda
		  , cafecha, cafecvcto,	cafecefectiva, camtomon1, camtomon2, ValorRazonableActivo, ValorRazonablePasivo  				  
		  , CaFechaFijacionStarting, CaPuntosFwdCierre, CaCodigo, CaCodCli  
		  , PosibleAplicacionET = ''N'' , CaCodMon1, CaCodMon2
		  ,  CaAntici, fRes_Obtenido , cacodcart
		     from BacFwdNY.dbo.Mfca_Eval '


	    -- Crear la tabla y unirla al exec
	    insert into #Cartera
	    exec (@ComandoRescateCartera)    

	     select * into #Cortes from Bacfwdsuda.dbo.Cortes where 1 = 2		 
	     select @ComandoRescateCartera = ''
	     select @ComandoRescateCartera = @ComandoRescateCartera + ' select * from BacFwdSuda.dbo.cortes '
	     if @BaseNYActiva = 'S'
			select @ComandoRescateCartera = @ComandoRescateCartera + ' union select * from BacFwdNY.dbo.cortes  '
	    -- Crear la tabla y unirla al exec
	    insert into #Cortes
	    exec (@ComandoRescateCartera) 

		CREATE TABLE #FAMILIA  
           (  
             Id                 VARCHAR(19) ,  
             ClRut              numeric(13),  
             ClCodigo           numeric(5),  
        Afecta_Lineas_Hijo numeric(1)  
           )  
  
        INSERT INTO #FAMILIA  
            EXECUTE BacLineas..SP_RIEFIN_FAMILIAS @Rut, @Codigo  
        -- and #Familia.Afecta_Lineas_Hijo = 0
  
        SET @Existe = 0  
   
        SELECT @Existe=1  
        FROM   #Familia  
             , #Cartera CARTERA -- Bacfwdsuda.dbo.MFCA CARTERA  
        WHERE  CARTERA.CaCodigo = Clrut and  
               CARTERA.Cacodcli= ClCodigo   
               and #Familia.Afecta_Lineas_Hijo = 0  

         select caNumContrato
		   ,	CaCVEstructura
		   ,	CaFechaContrato
		   ,	CaRutCliente
		   ,    CaCodigo
		   ,    CaCarteraFinanciera
		   ,    CaEstado
		   ,    CaCodEstructura
		   ,    PosibleAplicacionET = 'N'
		    into #CarteraOpt from CbMdbOpc.dbo.CaEncContrato where 1 = 2
	     select @ComandoRescateCartera = ''
	     select @ComandoRescateCartera = @ComandoRescateCartera + ' select caNumContrato
		,	CaCVEstructura
		,	CaFechaContrato
		,	CaRutCliente
		,   CaCodigo
		,   CaCarteraFinanciera
		,    CaEstado
		,    CaCodEstructura
		,    PosibleAplicacionET = ''N''
		 from CbMdbOpc.dbo.CaEncContrato  '
	     if @BaseNYActiva = 'S'
			select @ComandoRescateCartera = @ComandoRescateCartera + ' union select caNumContrato
		,	CaCVEstructura
		,	CaFechaContrato
		,	CaRutCliente
		,   CaCodigo
		,   CaCarteraFinanciera
		,    CaEstado
		,    CaCodEstructura
		,   PosibleAplicacionET = ''N''
		 from CbMdbOpcNY.dbo.CaEncContrato '
	     --select '@ComandoRescateCartera', @ComandoRescateCartera

		 -- Crear la tabla y unirla al exec
		 insert into #CarteraOpt
		 exec (@ComandoRescateCartera)

                 
		SELECT @Existe=1
		FROM   #Familia
             ,  #CarteraOpt CARTERA  -- select * from CbMdbOpc.dbo.CaEncContrato 
		WHERE  CARTERA.CaRutCliente = #Familia.Clrut and
               CARTERA.Cacodigo = #Familia.ClCodigo 
               and #Familia.Afecta_Lineas_Hijo = 0

       
   
		IF @Existe =0   
		BEGIN  
		  SELECT 'Consulta'= -1,'Rut'= 'Rut no existe en Cartera'  
		  RETURN  
		END  

		 select     CanumContrato
		          , CaModalidad
		          ,	CaFechaVcto
		          , CaVrDet 
		          ,	CaCodMon1
		          ,	CaCodMon2 
				  , CaMontoMon1
				  , CaMontoMon2
				  into #CarteraOptDet from CbMdbOpc.dbo.CaDetContrato where 1 = 2
	     select @ComandoRescateCartera = ''
	     select @ComandoRescateCartera = @ComandoRescateCartera + ' select CanumContrato
		          , CaModalidad
		          ,	CaFechaVcto
		          , CaVrDet 
		          ,	CaCodMon1
		          ,	CaCodMon2 
				  , CaMontoMon1
				  , CaMontoMon2
				  from CbMdbOpc.dbo.CaDetContrato  '
	     if @BaseNYActiva = 'S'
			select @ComandoRescateCartera = @ComandoRescateCartera + ' union select CanumContrato
		          , CaModalidad
		          ,	CaFechaVcto
		          , CaVrDet 
		          ,	CaCodMon1
		          ,	CaCodMon2
				  , CaMontoMon1
				  , CaMontoMon2 from CbMdbOpcNY.dbo.CaDetContrato '
	     --select '@ComandoRescateCartera', @ComandoRescateCartera

		 -- Crear la tabla y unirla al exec
		 insert into #CarteraOptDet
		 exec (@ComandoRescateCartera)

        SELECT  
			   Numero_operacion = CARTERA.canumoper  
			  , Sentido = CARTERA.catipoper  
			  , Tipo_fwd = CARTERA.cacodpos1  
			  , Modalidad = CARTERA.catipmoda  
			  , Cartera = PARAMETRIZA_CARTERA.Codigo  
			  , Moneda_1 = PARAMETRIZA_MONEDA_1.Codigo  
			  , Moneda_2 = PARAMETRIZA_MONEDA_2.Codigo  
			  , Fecha_inicio = CARTERA.cafecha  
			  , Fecha_vencimiento = CARTERA.cafecvcto  
			  , Fecha_efectiva = CASE  
				WHEN CARTERA.cacodpos1 = 2 THEN CARTERA.cafecvcto  
				ELSE CASE  
				 WHEN CARTERA.catipmoda = 'C' THEN CARTERA.cafecefectiva  
				 ELSE CARTERA.cafecvcto  
				 END  
				END  
			  , Codigo_descuento_1 = PARAMETRIZA_CURVAS_1.Codigo  
			  , Codigo_descuento_2 = PARAMETRIZA_CURVAS_2.Codigo  
			  , Nominal_1 = CARTERA.camtomon1  
			  , Nominal_2 = CARTERA.camtomon2  
			  , Valor_1 = CASE  
				WHEN CARTERA.catipoper = 'C' THEN  
				 CARTERA.ValorRazonableActivo  
				WHEN CARTERA.catipoper = 'V' THEN  
			 -CARTERA.ValorRazonablePasivo  
				END  
			  , Valor_2 = CASE  
				WHEN CARTERA.catipoper = 'C' THEN  
				 -CARTERA.ValorRazonablePasivo  
				WHEN CARTERA.catipoper = 'V' THEN  
				 CARTERA.ValorRazonableActivo  
				END  
			  , Fecha_Fixing = CARTERA.CaFechaFijacionStarting  
			  , Puntos_Fwd = CARTERA.CaPuntosFwdCierre  
			  , Rut = CARTERA.CaCodigo  
			  ,   Codigo = CARTERA.CaCodCli  
					,   PosibleAplicacionET -- = case when isnull( MID.MddNumOpe, 0 ) = CARTERA.CanumOper  and CARTERA.fRes_Obtenido < 0 then 'S' else 'N' end  
			  , Moneda_1_BAC = CARTERA.CaCodMon1  
			  , Moneda_2_BAC = CARTERA.CaCodMon2  
					,   Plazo        = datediff( dd, @FechaMet5y2, CARTERA.CaFecEfectiva )  
					,   Duration     = datediff( dd, @FechaMet5y2, CARTERA.CaFecEfectiva ) / 365.0          
			  FROM  
              #Cartera CARTERA  
--        LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID   
--                  ON MddMod = 'FWD' and MddNumOpe = CARTERA.CaNumOper  
		LEFT JOIN TBL_RieFinParametrizacion_Fixing_Arbitrajes FIX  -- select * from bacfwdsuda.dbo.cortes where cornumoper = 38295
         ON     FIX.Rut = CARTERA.cacodigo  
            AND FIX.Codigo = CARTERA.cacodcli  
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_1  
  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_2  
  , ParametrosdboParametrizacion_Fwd PARAMETRIZA_FWD  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_1  
  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_2  
  , ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA  
        ,   #Familia Fam  
  
  WHERE  
   PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cacodcart  
  AND PARAMETRIZA_MONEDA_1.Codigo_BAC = CARTERA.cacodmon1  
  AND PARAMETRIZA_MONEDA_2.Codigo_BAC = CARTERA.cacodmon2  
  AND PARAMETRIZA_FWD.Moneda_1 = CARTERA.cacodmon1  
  AND PARAMETRIZA_FWD.Moneda_2 = CARTERA.cacodmon2  
  AND PARAMETRIZA_FWD.Curva_1 = PARAMETRIZA_CURVAS_1.Curva  
  AND PARAMETRIZA_FWD.Curva_2 = PARAMETRIZA_CURVAS_2.Curva  
  AND PARAMETRIZA_CURVAS_1.Producto = 'Forward'  
  AND PARAMETRIZA_CURVAS_2.Producto = 'Forward'  
  AND CARTERA.CaAntici = ''  
--  AND CARTERA.Cacodigo = @Rut    -- Adaptación a Familia AFP.  
--  AND CARTERA.CACodCli = @Codigo -- Adaptación a Familia AFP.  
--  AND BANCOS.rut_Cliente = CARTERA.Cacodigo  
--  AND BANCOS.Codigo_cliente = CARTERA.CACodCli  
  AND  
   (  
    ( -- Si es un seguro de cambio, entonces fecha debe ser mayor que fecha efectiva  
     (CARTERA.cacodpos1 = 1 OR CARTERA.cacodpos1 = 3 OR CARTERA.cacodpos1 = 14)  
    AND (  
      ( -- Si la operacion es compensada importa la fecha efectiva  
						catipmoda = 'C'
					AND	cafecefectiva >= @Fecha
      )  
     OR  
      ( -- Si la operacion es con entrega fisica importa la fecha de vencimiento  
						catipmoda = 'E'
					AND	cafecvcto >= @Fecha
      )  
     )  
    )  
   OR  
    ( -- Si es un arbitraje a futuro, fecha debe ser mayor al fixing dependiendo del cliente  
     CARTERA.cacodpos1 = 2  
			AND
				(
					(catipmoda = 'E' AND cafecvcto >= @Fecha)
				OR
					(catipmoda = 'C' AND Fixing IS NULL AND cafecefectiva >= @Fecha)
				OR
					(catipmoda = 'C' AND Fixing = 1 AND cafecvcto >= @FechaProx)
				OR
					(catipmoda = 'C' AND Fixing = 2 AND cafecvcto > @FechaProx)
				)
    )  
   )  

        AND CARTERA.CaCodigo = Fam.Clrut   
        AND CARTERA.Cacodcli= Fam.ClCodigo   
        
        union -- Compensaciones Parciales
		SELECT
			Numero_operacion = CARTERA.canumoper  * 10 + CarCort.CorCorrela 
		,	Sentido = CARTERA.catipoper
		,	Tipo_fwd = case when CARTERA.cacodpos1 = 7 then 1 else CARTERA.cacodpos1 end
		,	Modalidad = CARTERA.catipmoda
		,	Cartera = PARAMETRIZA_CARTERA.Codigo
		,	Moneda_1 = PARAMETRIZA_MONEDA_1.Codigo
		,	Moneda_2 = PARAMETRIZA_MONEDA_2.Codigo
		,	Fecha_inicio = CARTERA.cafecha
		,	Fecha_vencimiento = CarCort.corfecvcto
		,	Fecha_efectiva = CarCort.corfecvcto
		,	Codigo_descuento_1 = PARAMETRIZA_CURVAS_1.Codigo
		,	Codigo_descuento_2 = PARAMETRIZA_CURVAS_2.Codigo
		,	Nominal_1 = CARTERA.camtomon1
		,	Nominal_2 = round( CARTERA.camtomon1 * CarCort.corprecio, 4 )
		,	Valor_1 = CASE
				WHEN CARTERA.catipoper = 'C' THEN
					CARTERA.ValorRazonableActivo
				WHEN CARTERA.catipoper = 'V' THEN
					-CARTERA.ValorRazonablePasivo
				END
		,	Valor_2 = CASE
				WHEN CARTERA.catipoper = 'C' THEN
					-CARTERA.ValorRazonablePasivo
				WHEN CARTERA.catipoper = 'V' THEN
					CARTERA.ValorRazonableActivo
				END
		,	Fecha_Fixing = CARTERA.CaFechaFijacionStarting
		,	Puntos_Fwd = CARTERA.CaPuntosFwdCierre
		,	Rut = CARTERA.CaCodigo
		,   Codigo = CARTERA.CaCodCli
        ,   PosibleAplicacionET = 'N' -- case when isnull( MID.MddNumOpe, 0 ) = CARTERA.CanumOper  and CARTERA.fRes_Obtenido < 0 then 'S' else 'N' end
		,	Moneda_1_BAC = CARTERA.CaCodMon1
		,	Moneda_2_BAC = CARTERA.CaCodMon2
        ,   Plazo        = datediff( dd, @FechaMet5y2, CARTERA.CaFecVcto )
        ,   Duration     = datediff( dd, @FechaMet5y2, CARTERA.CaFecVcto ) / 365.0        
		FROM			
             #Cortes CarCort
		LEFT JOIN #Cartera CARTERA ON CARTERA.CaNumoper = CarCort.CorNumOper
        --LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID 
        --          ON MddMod = 'FWD' and MddNumOpe = CARTERA.CaNumOper
		LEFT JOIN TBL_RieFinParametrizacion_Fixing_Arbitrajes FIX  -- select * from Parametros.dbo.Parametrizacion_Fixing_Arbitrajes
			      ON     FIX.Rut = CARTERA.cacodigo
			         AND FIX.Codigo = CARTERA.cacodcli
		,	ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_1
		,	ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_2
		,	ParametrosdboParametrizacion_Fwd PARAMETRIZA_FWD
		,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_1
		,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_2
		,	ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA
        ,   #Familia Fam

		WHERE
			PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cacodcart
		AND	PARAMETRIZA_MONEDA_1.Codigo_BAC = CARTERA.cacodmon1
		AND	PARAMETRIZA_MONEDA_2.Codigo_BAC = CARTERA.cacodmon2
		AND	PARAMETRIZA_FWD.Moneda_1 = CARTERA.cacodmon1
		AND	PARAMETRIZA_FWD.Moneda_2 = CARTERA.cacodmon2
		AND	PARAMETRIZA_FWD.Curva_1 = PARAMETRIZA_CURVAS_1.Curva
		AND	PARAMETRIZA_FWD.Curva_2 = PARAMETRIZA_CURVAS_2.Curva
		AND	PARAMETRIZA_CURVAS_1.Producto = 'Forward'
		AND	PARAMETRIZA_CURVAS_2.Producto = 'Forward'
		AND CARTERA.CaAntici = ''
--		AND CARTERA.Cacodigo = @Rut    -- Adaptación a Familia AFP.
--		AND CARTERA.CACodCli = @Codigo -- Adaptación a Familia AFP.
--		AND BANCOS.rut_Cliente = CARTERA.Cacodigo
--		AND BANCOS.Codigo_cliente = CARTERA.CACodCli
		AND CARTERA.cacodpos1 = 7
		AND CARTERA.cafecVcto > @Fecha
        AND CARTERA.CaCodigo = Fam.Clrut 
        AND CARTERA.Cacodcli= Fam.ClCodigo 

        Union -- Forward Americano
		SELECT
			Numero_operacion = EncCARTERA.caNumContrato
		,	Sentido = EncCARTERA.CaCVEstructura
		,	Tipo_fwd = 1                         -- Forward Americano se trata como seguro de cambio
		,	Modalidad = DetCARTERA.CaModalidad
		,	Cartera = PARAMETRIZA_CARTERA.Codigo
		,	Moneda_1 = PARAMETRIZA_MONEDA_1.Codigo
		,	Moneda_2 = PARAMETRIZA_MONEDA_2.Codigo
		,	Fecha_inicio = EncCARTERA.CaFechaContrato
		,	Fecha_vencimiento = DetCARTERA.CaFechaVcto
		,	Fecha_efectiva = DetCARTERA.cafechaVcto
		,	Codigo_descuento_1 = PARAMETRIZA_CURVAS_1.Codigo
		,	Codigo_descuento_2 = PARAMETRIZA_CURVAS_2.Codigo
		,	Nominal_1 = DetCARTERA.CaMontoMon1
		,	Nominal_2 = DetCARTERA.CaMontoMon2
		,	Valor_1 = CASE
				WHEN  DetCARTERA.CaVrDet > 0   THEN
					  DetCARTERA.CaVrDet
				WHEN  DetCARTERA.CaVrDet < 0 THEN
					- 0
 END  
		,	Valor_2 = CASE
				WHEN  DetCARTERA.CaVrDet < 0   THEN
					- DetCARTERA.CaVrDet
				WHEN  DetCARTERA.CaVrDet > 0 THEN
					  0
				END
		,	Fecha_Fixing = EncCARTERA.CaFechaContrato
		,	Puntos_Fwd = 0
		,	Rut = EncCARTERA.CaRutCliente
		,   Codigo = EncCARTERA.CaCodigo
        ,   PosibleAplicacionET -- = case when isnull( MID.MddNumOpe, 0 ) = EncCARTERA.CaNumContrato  and DetCARTERA.CaVrDet < 0 then 'S' else 'N' end
		,	Moneda_1_BAC = DetCARTERA.CaCodMon1
		,	Moneda_2_BAC = DetCARTERA.CaCodMon2
        ,   Plazo        = datediff( dd, @FechaMet5y2, DetCARTERA.cafechaVcto )
        ,   Duration     = datediff( dd, @FechaMet5y2, DetCARTERA.cafechaVcto ) / 365.0        
		FROM 
            #CarteraOpt EncCARTERA      --- select * from CbMdbOpc.dbo.CaEncContrato
          , #CarteraOptDet DetCARTERA		
--        LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID 
--                  ON MddMod = 'OPT' and MddNumOpe = DetCARTERA.CaNumContrato
		,	ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_1
		,	ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_2
		,	ParametrosdboParametrizacion_Fwd PARAMETRIZA_FWD
		,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_1
		,	ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_2
		,	ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA
        ,   #Familia Fam

		WHERE
            EncCARTERA.CaNumContrato = DetCARTERA.CaNumContrato
        AND	PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = EncCARTERA.CaCarteraFinanciera
		AND	PARAMETRIZA_MONEDA_1.Codigo_BAC = DetCARTERA.cacodmon1
		AND	PARAMETRIZA_MONEDA_2.Codigo_BAC = DetCARTERA.cacodmon2
		AND	PARAMETRIZA_FWD.Moneda_1 = DetCARTERA.cacodmon1
		AND	PARAMETRIZA_FWD.Moneda_2 = DetCARTERA.cacodmon2
		AND	PARAMETRIZA_FWD.Curva_1 = PARAMETRIZA_CURVAS_1.Curva
		AND	PARAMETRIZA_FWD.Curva_2 = PARAMETRIZA_CURVAS_2.Curva
		AND	PARAMETRIZA_CURVAS_1.Producto = 'Forward'
		AND	PARAMETRIZA_CURVAS_2.Producto = 'Forward'
		AND EncCARTERA.CaEstado <> 'E' AND EncCARTERA.CaEstado <> 'C'
		AND DetCARTERA.cafechaVcto > @Fecha
                AND EncCARTERA.CaCodEstructura = 8  -- Codigo del Forward Americano
--		AND CARTERA.Cacodigo = @Rut    -- Adaptación a Familia AFP.
--		AND CARTERA.CACodCli = @Codigo -- Adaptación a Familia AFP.
--		AND BANCOS.rut_Cliente = CARTERA.Cacodigo
--		AND BANCOS.Codigo_cliente = CARTERA.CACodCli
        AND EncCARTERA.CaRutCliente = Fam.Clrut 
        AND EncCARTERA.Cacodigo = Fam.ClCodigo 

 END  
END  
  ELSE
  IF @Vehiculo = 'CCB' 
  BEGIN

        -- Por ahora todos los RUT.

	   SELECT  
				@Fecha = case when @ConVencidosHoy = 1 then acfecproc else acfecprox end
			,	@FechaProx = case when @ConVencidosHoy = 1 then acfecprox else dateadd( day, 1 , acfecprox )  end
		  from  
				BacTraderSuda.dbo.mdac  -- select * from BacTraderSuda.dbo.mdac 


        Select * 
        into #CCBCartera 
        from  BDC72.Dbo.FMCarteraForward 
        where Estado = 'V' and   FechaVencimiento >= @Fecha 

                               
        
		select 
				CaNumOper     = CARTERA.FolioCartera                                        -- CBB:CARTERA.CaNumoper  
			  , CaTipOper         = Case when CARTERA.CodTipoMovto = 1 then 'C' else 'V' end    -- CBB:CARTERA.catipoper       
			  , CaCodPos1         = MapeoPRODUCTO.BACCaCodPos1                                  -- MAP:Mappeo 
			  , CaTipModa         = Case when CARTERA.ModCumplimiento = 2 then 'C' else 'E' end -- MAP:Código BCS dbo.FmLiquidaForward   
			  , cacodcart         = 0  -- IGual revisar que le podemos poner pero no es relevante
			  , CaCodMon1         = isnull( MapeoMoneda1.BACCodMoneda, CARTERA.CodMonPrinc )    -- MAP:Cuando alla Dif. en codigos se 
																								--     debe llenar tabla CCBMapeoMoneda    
			  , CaCodMon2         = isnull( MapeoMoneda2.BACCodMoneda, CARTERA.CodMonSecu )     -- MAP:Cuando alla Dif. en codigos se 
																								--     debe llenar tabla CCBMapeoMoneda    
			  , Cafecha           = CARTERA.FechaInicio
			  , Cafecvcto         = CARTERA.FechaVencimiento  
			  , Cafecefectiva     = CARTERA.FechaVencimiento -- PENDIENTE: calcular
			  , Camtomon1         = CARTERA.MtoMonPrinc
			  , Camtomon2         = CARTERA.MtoMonSecu
			  , CaFechaFijacionStarting  = CARTERA.FechaInicio
			  , CaPuntosFwdCierre        = 0  
			  , iRefMercado              = 100
			  , nDiasValor               = 0*10000 -- MAP Correccion
			  , cDiasFeriados            = replicate( ' ', 500 )
			  ,	cEstadoDia			     = 'I'  -- H: habil, I:Inhabil
			  ,	cDiaCaracter 			 = '  '
			  , CaCodigo = convert( numeric(13), substring( ltrim(rtrim(RutCliente)), 1, charindex( '-', ltrim(rtrim(RutCliente))) - 1 ) )
			  , CaCodCli      = 1	
              , fRes_Obtenido = MtoVRNeto  -- Valor Razonable
		      ,	Valor_1 = MtoVRActivo                                 
		     ,	Valor_2 = MtoVRPasivo 
		into   #MfCaCCB 
		from   #CCBCartera CARTERA  
							 JOIN BacLineas.dbo.CCBMapeoProducto MapeoPRODUCTO
									  ON   MapeoPRODUCTO.CCBCodProducto = CARTERA.CodProducto
									   AND MapeoPRODUCTO.CCBCodSubProducto = CARTERA.CodSubProducto
									   AND MapeoPRODUCTO.CCBCodMonSecu  = CARTERA.CodMonSecu 
									   AND  ( MapeoPRODUCTO.CCBCodMonPrinc    = CARTERA.CodMonPrinc or CCBCodMonPrinc = 0 )
									   And MapeoPRODUCTO.CCBCodMonPrincNoaplica <> CARTERA.CodMonPrinc  
							 LEFT JOIN BacLineas.dbo.CCBMapeoMoneda MapeoMoneda1
									  ON MapeoMoneda1.CCBCodMoneda = CARTERA.CodMonPrinc
							 LEFT JOIN BacLineas.dbo.CCBMapeoMoneda MapeoMoneda2
									  ON MapeoMoneda2.CCBCodMoneda = CARTERA.CodMonSecu
/*
			-----------------------------------
			--   CALCULO DE FECHA EFECTIVA   --
			-----------------------------------
			UPDATE	#MfCaCCB
			SET	iRefMercado	= CASE	WHEN CaCodPos1 = 1 THEN 1
				  			WHEN CaCodPos1 = 2 THEN 6 END
			WHERE	CaCodPos1 IN (1,2)
			

			UPDATE #MfCaCCB
			SET	nDiasValor		= ISNULL((SELECT DiasValor FROM BacParamSuda..REFERENCIA_MERCADO_PRODUCTO WITH (NOLOCK)
															WHERE Producto    = CaCodPos1
															  AND Modalidad   = CaTipModa
															  AND Referencia  = iRefMercado), 0)
			WHERE	CaCodPos1 IN (1,2)

			DECLARE	@cExiste	CHAR(01)
      			,	@nContador	INT

			SET	@cExiste		= 'S'
			SET	@nContador	= 1

			WHILE @cExiste = 'S' BEGIN 
					
				UPDATE	#MfCaCCB
				SET	cDiasFeriados = CASE DATEPART(MONTH,DATEADD(DAY, -1, CaFecEfectiva))	
												WHEN 1  THEN feene
												WHEN 2  THEN fefeb
												WHEN 3  THEN femar
												WHEN 4  THEN feabr
												WHEN 5  THEN femay
												WHEN 6  THEN fejun
												WHEN 7  THEN fejul
												WHEN 8  THEN feago
												WHEN 9  THEN fesep
												WHEN 10 THEN feoct
												WHEN 11 THEN fenov
												WHEN  12 THEN fedic
												END
				,	cDiaCaracter	=  CASE WHEN DATEPART(DAY, CaFecEfectiva) <= 9	THEN '0' + CONVERT(CHAR(1),DATEPART(DAY, DATEADD(DAY, -1, CaFecEfectiva)))
													ELSE CONVERT(CHAR(2),DATEPART(DAY, DATEADD(DAY, -1, CaFecEfectiva)))
													END						
				FROM	BACPARAMSUDA..FERIADO WITH (NOLOCK)
				WHERE	feano		= DATEPART(YEAR,DATEADD(DAY, -1, CaFecEfectiva))
				AND	feplaza		= 6 -- CHILE
				AND	CaCodPos1	IN (1,2)
				AND	cEstadoDia	= 'I'    and nDiasValor <> 0        
				
				UPDATE	#MfCaCCB
				SET	CafecEfectiva	= DATEADD(DAY, -1, CafecEfectiva)
				WHERE	CaCodPos1	IN (1,2)
				AND	cEstadoDia	= 'I' and nDiasValor <> 0   

				SET @nContador	= @nContador + 1

				UPDATE	#MfCaCCB
				SET	cEstadoDia	= CASE	WHEN CHARINDEX(RTRIM(CONVERT(CHAR(02), cDiaCaracter)),CaFecEfectiva) > 0		THEN 'I'	-- SI EL DIA ESTA EN LA CADENA DE FERIADOS
								WHEN DATEPART(WEEKDAY, CaFecEfectiva) = 7 OR DATEPART(WEEKDAY, CaFecEfectiva) = 1		THEN 'I'	-- SABADO O DOMINGO
								WHEN ABS(nDiasValor) >= @nContador			THEN 'I'
																			ELSE 'H' END	-- DIA HABIL
				WHERE	CaCodPos1	IN (1,2) and nDiasValor <> 0   

				IF (SELECT COUNT(1) FROM #MfCaCCB WHERE CaCodPos1 IN (1,2) AND cEstadoDia = 'I' and nDiasValor <> 0   ) = 0 BEGIN
					SET @cExiste = 'N'
				END
			END
			-----------------------------------
			-- FIN CALCULO DE FECHA EFECTIVA --
			-----------------------------------
*/

			-----------------------------------------
			-- Detección de las familias en BAC    --
			----------------------------------------- 
			select *, LISTADORut_Padre = isnull( CR.ClRut_Padre, CaCodigo)
				   , LISTADOCodigo_Padre = isnull( CR.ClCodigo_Padre, CaCodCli) 
			into #MFCA
			from #MfCaCCB Car
					 LEFT JOIN BacLineas.dbo.Cliente_relacionado CR
						 ON ( CR.clrut_hijo = Car.CaCodigo and CR.clcodigo_hijo = Car.CaCodCli )
			-----------------------------------------
			-- Detección de las familias en BAC    --
			-----------------------------------------
            

			SELECT  
			   Numero_operacion = CARTERA.canumoper  
			  , Sentido = CARTERA.catipoper  
			  , Tipo_fwd = CARTERA.cacodpos1  
			  , Modalidad = CARTERA.catipmoda  
			  , Cartera = 0 -- PARAMETRIZA_CARTERA.Codigo  Son otras clasificaciones que no estan en BAC
			  , Moneda_1 = PARAMETRIZA_MONEDA_1.Codigo  
			  , Moneda_2 = PARAMETRIZA_MONEDA_2.Codigo  
			  , Fecha_inicio = CARTERA.cafecha  
			  , Fecha_vencimiento = CARTERA.cafecvcto  
			  , Fecha_efectiva = CASE  
				WHEN CARTERA.cacodpos1 = 2 THEN CARTERA.cafecvcto  
				ELSE CASE  
				 WHEN CARTERA.catipmoda = 'C' THEN CARTERA.cafecefectiva  
				 ELSE CARTERA.cafecvcto  
				 END  
				END  
			  , Codigo_descuento_1 = PARAMETRIZA_CURVAS_1.Codigo  
			  , Codigo_descuento_2 = PARAMETRIZA_CURVAS_2.Codigo  
			  , Nominal_1 = CARTERA.camtomon1  
			  , Nominal_2 = CARTERA.camtomon2  
			  , Valor_1 = Valor_1 /*CASE  
				WHEN CARTERA.catipoper = 'C' THEN  
				 0  
				WHEN CARTERA.catipoper = 'V' THEN  
				 -0  
				END  */
			  , Valor_2 = Valor_2 /*CASE  
				WHEN CARTERA.catipoper = 'C' THEN  
				 -0  
				WHEN CARTERA.catipoper = 'V' THEN  
				 0  
				END  */
			  , Fecha_Fixing = CARTERA.CaFechaFijacionStarting  
			  , Puntos_Fwd = CARTERA.CaPuntosFwdCierre  
			  , Rut = CARTERA.LISTADORut_Padre  
			  , Codigo = CARTERA.LISTADOCodigo_Padre  
			  , PosibleAplicacionET = case when isnull( MID.MddNumOpe, 0 ) = CARTERA.CanumOper  and CARTERA.fRes_Obtenido < 0 then 'S' else 'N' end  
			  , Moneda_1_BAC = CARTERA.CaCodMon1  
			  , Moneda_2_BAC = CARTERA.CaCodMon2  
			  , Plazo        = datediff( dd, @FechaMet5y2, CARTERA.CaFecEfectiva )  
			  , Duration     = datediff( dd, @FechaMet5y2, CARTERA.CaFecEfectiva ) / 365.0       
			  FROM  
			   #MFCA CARTERA  
					LEFT JOIN BacLineas.dbo.TBL_RIEFIN_DRV_MIDDLE_OFFICE MID   
							  ON MddMod = 'FWD' and MddNumOpe = CARTERA.CaNumOper  
					LEFT JOIN TBL_RieFinParametrizacion_Fixing_Arbitrajes FIX  -- select * from bacfwdsuda.dbo.cortes where cornumoper = 38295
					 ON     FIX.Rut = CARTERA.cacodigo  
						AND FIX.Codigo = CARTERA.cacodcli  
			  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_1  
			  , ParametrosdboParametrizacion_Monedas PARAMETRIZA_MONEDA_2  
			  , ParametrosdboParametrizacion_Fwd PARAMETRIZA_FWD  
			  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_1  
			  , ParametrosdboParametrizacion_Curvas PARAMETRIZA_CURVAS_2  
	--		  , ParametrosdboParametrizacion_Carteras PARAMETRIZA_CARTERA  
 
			  
			  WHERE  
	/*		   PARAMETRIZA_CARTERA.Codigo_Cartera_Finan = CARTERA.cacodcart  
			  AND */ 
                  PARAMETRIZA_MONEDA_1.Codigo_BAC = CARTERA.cacodmon1  
			  AND PARAMETRIZA_MONEDA_2.Codigo_BAC = CARTERA.cacodmon2  
			  AND PARAMETRIZA_FWD.Moneda_1 = CARTERA.cacodmon1  
			  AND PARAMETRIZA_FWD.Moneda_2 = CARTERA.cacodmon2  
			  AND PARAMETRIZA_FWD.Curva_1 = PARAMETRIZA_CURVAS_1.Curva  
			  AND PARAMETRIZA_FWD.Curva_2 = PARAMETRIZA_CURVAS_2.Curva  
			  AND PARAMETRIZA_CURVAS_1.Producto = 'Forward'  
			  AND PARAMETRIZA_CURVAS_2.Producto = 'Forward'  
			--  AND CARTERA.CaAntici = ''  
			--  AND CARTERA.Cacodigo = @Rut    -- Adaptación a Familia AFP.  
			--  AND CARTERA.CACodCli = @Codigo -- Adaptación a Familia AFP.  
			--  AND BANCOS.rut_Cliente = CARTERA.Cacodigo  
			--  AND BANCOS.Codigo_cliente = CARTERA.CACodCli  
			  AND  
			   (  
				( -- Si es un seguro de cambio, entonces fecha debe ser mayor que fecha efectiva  
				 (CARTERA.cacodpos1 = 1 OR CARTERA.cacodpos1 = 3 OR CARTERA.cacodpos1 = 14)  
				AND (  
				  ( -- Si la operacion es compensada importa la fecha efectiva  
									catipmoda = 'C'
								AND	cafecefectiva >= @Fecha
				  )  
				 OR  
				  ( -- Si la operacion es con entrega fisica importa la fecha de vencimiento  
									catipmoda = 'E'
								AND	cafecvcto >= @Fecha
				  )  
				 )  
				)  
			   OR  
				( -- Si es un arbitraje a futuro, fecha debe ser mayor al fixing dependiendo del cliente  
				 CARTERA.cacodpos1 = 2  
						AND
							(
								(catipmoda = 'E' AND cafecvcto >= @Fecha)
							OR
								(catipmoda = 'C' AND Fixing IS NULL AND cafecefectiva >= @Fecha)
							OR
								(catipmoda = 'C' AND Fixing = 1 AND cafecvcto >= @FechaProx)
							OR
								(catipmoda = 'C' AND Fixing = 2 AND cafecvcto > @FechaProx)
							)
				)  
			   )  

         order by cafecvcto
  END
  ELSE
  BEGIN
     select 'Vehiculo no definido'
  END
END    
GO
