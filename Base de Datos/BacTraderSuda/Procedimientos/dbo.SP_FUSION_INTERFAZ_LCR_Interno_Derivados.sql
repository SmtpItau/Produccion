USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUSION_INTERFAZ_LCR_Interno_Derivados]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FUSION_INTERFAZ_LCR_Interno_Derivados] 
(
		@fecCont DATETIME
		, @Formateada VARCHAR(1) = 'S'
)
AS
BEGIN	
 	SET NOCOUNT ON

	/*DECLARACION DE VARIABLES*/                                  
	-- select * from bacSwapsuda.dbo.cartera where numero_operacion = 11391
    -- SP_FUSION_INTERFAZ_LCR_Interno_Derivados '20150623'  
	-- SP_FUSION_INTERFAZ_LCR_Interno_Derivados '20150623'  , 'N'                                                             
	-- POR HACER:
	-- RUT debe ser rellenado con "0"s a la izquierda y estar por ende alineado a la derecha.
	-- Aplicar API de Alan cuyo desarrollo coordinó Alan.
	-- Solicitar el numero único para cada cliente para enviar el Netting
	-- se me ocurre enviar el rut por mientras se resuelve el tema del netting

	/*FIN DECLARACION*/

	                                                                

	    CREATE TABLE #INT_SALIDA 
	(
          LINEA        VarCHAR(296)  -- El largo definitivo y el formato será manejado por el SP
   ,      ORDEN        INT
   ,      CANTIDAD     Numeric(10)
   ,      Moneda       Numeric(5)
   ,      Rut_Cliente  Numeric(13)
   ,      Codigo_Cliente Numeric(5)
    )
	/*********
	1	CONTRAT0
	2	RUT
	3	DIGV
	4	FACILITY
	5	DTCONTR
	6	DTVENC
	7	MOEDAR
	8	VLCONTR
	9	VLPRIN
	10	Signo-1
	11	VALMTM
	12	Signo-2
	13	VALRCP
	14	NOMPRO
	15	Signo-3
	16	SALDES
	17	AMOOPE
	18	AINDOP
	19	APOROP
	20	Signo-4
	21	ATASOP
	22	PMOOPE
	23	PINDOP
	24	PPOROP
	25	Signo-5
	26	PTASOP
	27	ACUCOM

	**********/
	CREATE TABLE #Salida 
			(
				/*01*/	[CONTRATO]	numeric(13)
			,	/*02*/	[RUT]		numeric(10)
			,	/*03*/	[DIGV]		Varchar(1)
			,	/*04*/	[Facility]	            VARCHAR(4)  
			,	/*05*/	[DTContr]	            datetime
			,	/*06*/	[DTVenc]	            datetime
			,	/*07*/	[MOEDAR_MdaNocional]    numeric(4) 
			,	/*08*/	[VLCONTR_Nocional]		numeric(14,2)
			,   /*09*/  [VLPRIN_Valor_Principal_Riesgo_Interno] numeric(14,2)
			,   /*10*/  [Signo_01]              varchar(1)
			,   /*11*/  [VALMTM_ValorMTM]       numeric(16,4)
			,   /*12*/  [Signo_02]              varchar(1)
			,   /*13*/  [VALRCP_MontoREC]       numeric(16,4) 
			,   /*14*/  [NOMPRO_NombreProducto] varchar(50)
			,   /*15*/  [FILLER]                varchar(135) -- son 135 
			-- Se llenará con
			-- '+0000000000000000                                  00000+00000000000000                                  00000+00000000000000          '
			)

    /* POR HACER: pantallas de parametrizacion para todos estos conceptos */
	/*
	Sistema	Facility	Producto Relacionado
    FINDUR	080	Operaciones Spot Intradia
    FINDUR	640	Operaciones FOWARD (En general)
    FINDUR	642	Operaciones Spot mayor 1 día
    FINDUR	701	Operaciones SWAP (En general)
    FINDUR	730	Operaciones OPCIONES (En general)
    BAC	630	Colocaciones Interbancarias/Captación a Plazos
    BAC	670	Compra IRF/IIF a Término Tresury Investment
    BAC	679	Compra IRF/IIF a Término Letras Hipotecarias
    BAC	690	Compra IRF/IIF con Pacto
	*/	



	 /* rescate de Carteras */
	 
	 select Sistema = 'BFW'
	      , Contrato    = convert( numeric(10), CaNumoper )
		  , MdaNocional = Convert( numeric(5) , CaCodMon1 )
		  , MdaNocionalNemo = convert( varchar(5), '     ' )
		  , Nocional    = Convert( numeric(20,2), CaMtoMon1 )
		  , Fecha_Curse = convert( datetime, CaFecha )
		  , MTM         = convert( numeric(20), fRes_Obtenido )
		   into #Cartera
		  from BacFwdSuda.dbo.MfcaRES 
		  where cafechaProceso = @fecCont
	 union
	 select Sistema = 'BFW'
	      , Contrato    = convert( numeric(10), CaNumoper )
		  , MdaNocional = Convert( numeric(5) , CaCodMon1 )
		  , MdaNocionalNemo = convert( varchar(5), '     ' )
		  , Nocional    = Convert( numeric(20,2), CaMtoMon1 )
		  , Fecha_Curse = convert( datetime, CaFecha )
		  , MTM         = convert( numeric(20), fRes_Obtenido )
		  from BacFwdSuda.dbo.Mfca


	insert into #Cartera
	select Sistema = 'OPT'
	      , Contrato    = Enc.CaNumContrato
		  , MdaNocional = max( CaCodMon1 )
		  , MdaNocionalNemo = convert( varchar(5), '     ' )
		  , Nocional    = max( CaMontoMon1 )
		  , Fecha_Curse = Enc.CafechaContrato 
		  , MTM         = Enc.CaVr
		  from lnkopc.cbmdbopc.dbo.caResEncContrato Enc  
		    left join   lnkOpc.cbmdbOpc.dbo.CaResDetContrato Det 
			      on det.CanumContrato = Enc.CaNumContrato 
		where Enc.CaEncFechaRespaldo = @fecCont
		  and Det.CaDetFechaRespaldo = Enc.CaEncFechaRespaldo 
	 group by Enc.CaNumContrato, Enc.CafechaContrato, Enc.CaVr

     
	 select Sistema = 'PCS'
	      , Contrato    = Numero_Operacion
		  , EntraNocional = max( Compra_Capital )
		  , EntraMdaNocional = max( Compra_Moneda )
		  , SaleNocional = max( Venta_Capital )
		  , SaleMdaNocional = max( Venta_Moneda )
		  , Fecha_Curse = Fecha_Cierre
		  , MTM = Valor_RazonableCLP
	  into #CarteraPCS
		  from BacSwapSuda.dbo.CarteraRes Enc
		where Enc.fecha_Proceso = @fecCont		  
	 group by Numero_Operacion, Fecha_Cierre, Valor_RazonableCLP
	 union
	 select Sistema = 'PCS'
	      , Contrato    = Numero_Operacion
		  , EntraNocional = max( Compra_Capital )
		  , EntraMdaNocional = max( Compra_Moneda )
		  , SaleNocional = max( Venta_Capital )
		  , SaleMdaNocional = max( Venta_Moneda )
		  , Fecha_Curse = Fecha_Cierre
		  , MTM = Valor_RazonableCLP
		  from BacSwapSuda.dbo.Cartera Enc
	 group by Numero_Operacion, Fecha_Cierre, Valor_RazonableCLP

	 -- Prioridades de monedas
	    -- PROD-8321 Prioridad de las monedas    
     -- para seleccionar la moneda relevante en los Swap   
     SELECT mncodmon    
     ,      mnPrioridad = isnull((select MnPRioridad     
                                from BacParamSuda..MonedaPrioridad Pri    
                                where Pri.MnCodMon = Mda.MnCodMon)    
                  , case when mnCodMon = 999 then 0    
                                       when mnCodMon = 998 then 1    
                                       when mnCodMon = 13  then 2    
                                       else 3 end)    
     into #MdaPri    
     from BacParamSuda..MONEDA Mda where mnmx = 'C'     
     Union    
     Select mnCodMon    
     ,      MnPrioridad = isnull( (select MnPrioridad     
                          from BacParamSuda..MonedaPrioridad Pri    
                          where Pri.MnCodMon = Mda.MnCodMon)    
                          , case when Mda.MnCodMon = 999 then 0     
                                 when Mda.MnCodMon = 998 then 1    
                                 when Mda.MnCodMon = 13  then 2    
                                 else 3 end)    
     from  BacParamSuda..Moneda Mda    
     where MnCodMon in ( 999, 998 )    

	insert into #Cartera
	select Sistema = 'PCS'
	      , Contrato    = Contrato
		  , MdaNocional = case when Entra.mnPrioridad > Sale.mnPrioridad 
		                  then EntraMdaNocional  else SaleMdaNocional  end
		  , MdaNocionalNemo = convert( varchar(5), '     ' )
		  , Nocional    = case when Entra.mnPrioridad > Sale.mnPrioridad 
		                  then EntraNocional else SaleNocional end		                   
		  , Fecha_Curse  
		  , MTM
		  from #CarteraPCS Enc
		    left join #MdaPri Entra on Entra.MnCodMon = Enc.EntraMdaNocional
			left join #MdaPri Sale  on Sale.MnCodMon = Enc.SaleMdaNocional

      update #Cartera
	     set MdaNocionalNemo = Mda.MnNemo
		 from BacParamSuda.dbo.Moneda Mda where  Mda.MnCodMon = MdaNocional


		select Id_Sistema 
		     , Codigo_producto = convert( varchar(5),  Codigo_Producto )
	         , Codigo_producto_otro = convert( varchar(5), case when id_sistema = 'PCS' then 
		                                                    case when codigo_Producto = 'SP' then '4' 
									                             when codigo_Producto = 'ST' Then '1'
										                         when codigo_Producto = 'SM' then '2'
										                         when codigo_producto = 'FR' then '3' end 
								                           else codigo_Producto end
                                                          )
			 , Codigo_Instrumento = convert( numeric(6),  0 )
             , Facility = case when id_sistema = 'PCS' then '701' 
			                   when Id_sistema = 'OPT' then '730'
							   when Id_sistema = 'BFW' then '640' end
			 , descripcion
							   
         into #ProductoInstrumento
         from BacParamSuda.dbo.producto where id_sistema not in ( 'BCC' , 'BTR', 'BEX' ) 

		 -- Tipo de Operacion Creada en duro siempre
		 insert into #ProductoInstrumento
		 select Id_Sistema = 'BTR'		  
		     ,  Codigo_producto = 'CP'
			 ,  Codigo_producto_Otro = 'CP'
			 ,  Codigo_Instrumento   = Ins.InCodigo
			 ,  Facility = '630'   -- POR HACER: Parametrizar en instrumento
			 ,  Descripcion = Ins.InGLosa
		 from BacParamSuda.dbo.Instrumento Ins  

		 insert into #ProductoInstrumento
		 select Id_Sistema = 'BEX'		  
		     ,  Codigo_producto = 'CP'
			 ,  Codigo_producto_Otro = 'CP'
			 ,  Codigo_Instrumento   = Ins.Cod_familia
			 ,  Facility = '630' 
			 ,  Descipcion = Ins.Descrip_familia
		 from BacBonosExtSuda.dbo.text_fml_inm Ins

		 -- Tipo de operación creada en duro siempre
		 insert into #ProductoInstrumento
		 select Id_Sistema = 'BTR'
		     ,  Codigo_producto = 'CI'
			 ,  Codigo_producto_Otro = 'CI'
			 ,  Codigo_Instrumento = 0
			 ,  Facility = 630   -- POR HACER: Parametrizar... definit origen
			 ,  Descripcion = 'Compra Con Pacto'

         insert into #ProductoInstrumento
		 select Id_Sistema = 'BTR'
		     ,  Codigo_producto = 'IB'
			 ,  Codigo_producto_Otro = 'IB'
			 ,  Codigo_Instrumento = 992 -- COLocaciones
			 ,  Facility = 630   -- POR HACER: Parametrizar... definit origen
			 ,  Descripcion = 'Colocacion Interbancaria'

	 
		 select 				
		        /*01*/	[CONTRATO]	= NumeroOperacion
			,	/*02*/	[RUT]		                = Rut_Cliente
			,	/*03*/	[DIGV]		                = convert( varchar(1), Cli.ClDv )
			,	/*04*/	[Facility]	                = '0' + ltrim(rtrim( Prd.Facility))   
			,	/*05*/	[DTContr]	                = Car.Fecha_Curse             
			,	/*06*/	[DTVenc]	                = FechaVencimiento
			,	/*07*/	[MOEDAR_MdaNocional]        = Car.MdaNocional            
			,	/*08*/	[VLCONTR_Nocional]		    = Car.Nocional              
			,   /*09*/  [VLPRIN_Valor_Principal_Riesgo_Interno] = convert( numeric(14,2), MontoTransaccion ) 
			,   /*10*/  [Signo_01]                  = case when MontoTransaccion > 0 then '+' else '-' end
			,   /*11*/  [VALMTM_ValorMTM]           = convert( numeric(16,4), abs( MontoTransaccion )) -- POR HACER: rescatar el MTM y colocar el signo de tal concepto
			,   /*12*/  [Signo_02]                  = '+'
			,   /*13*/  [VALRCP_MontoREC]           = convert( numeric(16,4), MontoOriginal + MontoTransaccion ) 
			,   /*14*/  [NOMPRO_NombreProducto]     = convert( varchar(50), rtrim( Prd.Descripcion ) + replicate( ' ', 50 - len( Prd.Descripcion ) ) ) 
			,   /* Varios */ [FILLER]               = convert( varchar(135), '+' /*15*/ 
			                                                                + replicate( '0', 16 ) /*16*/
																			+ replicate( ' ', 4 )  /*17*/
																			+ replicate( ' ', 30 ) /*18*/
																			+ replicate( '0', 5 )  /*19*/
																			+ '+' /*20*/
																			+ replicate( '0', 14 ) /*21*/
																			+ replicate( ' ', 4 )  /*22*/
																			+ replicate( ' ', 30 ) /*23*/
																			+ replicate( '0', 5 )  /*24*/
																			+ '+' /*25*/
																			+ replicate( '0', 14 ) /*26*/
																			+ replicate( ' ', 10 ) /*27*/
																			)
			,   MdaNocionalNemo
																	
            ,   corr = identity(Int, 1,1) 
				into #TMP001
	      from       
		  BacLineas.dbo.LINEA_TRANSACCION  LCR --- select * from BacLineas.dbo.LINEA_TRANSACCION  order by fec_proc
		                                            --- select * from bacparamsuda.dbo.instrumento where incodigo = 992
	--	  left join  BacParamSuda.dbo.moneda  mdaOri on MdaOri.MncodMon = art.moneda
	--	  left join  BacParamSuda.dbo.moneda  mdaLiq on MdaLiq.MncodMon = art.moneda
	      left join  BacParamSuda.dbo.Cliente Cli on Cli.Clrut = LCR.Rut_Cliente and Cli.Clcodigo = LCR.Codigo_Cliente 
		  left join  #Cartera Car on Car.Contrato = LCR.NumeroOperacion and LCR.Id_Sistema = Car.Sistema	   
		  left join  #ProductoInstrumento Prd on Prd.Id_sistema = LCR.Id_sistema 
		                                    and  Prd.Codigo_producto_otro = LCR.Codigo_Producto 
		 where FechaInicio = @fecCont
		   and LCR.id_sistema in ( 'DRV', 'PCS', 'BFW', 'OPT' ) -- Derivados
		   and LCR.metodoLCR not in ( 2, 6 ) -- Netting la tabla pasa a ser un transportador
		   and LCR.NumeroOperacion <> 0      -- ??
		   and car.Contrato = Car.Contrato   -- Si no hay contrato no se trasmite
		 order by LCR.Id_sistema, LCR.NumeroOperacion 
    
	 --select 'debug', * from #TMP001  -- -- SP_FUSION_INTERFAZ_LCR_Interno_Derivados '20150623'       

	 CREATE  TABLE #CodigoAS400Mda ( MdaBAC Varchar(3), MdaNemo Varchar(3) /* Findur*/ ,  MdaAS Varchar(4) /*AS400*/ ) 
	 Insert into #CodigoAS400Mda select  'AUD','AUD', 'AU.D'
	 Insert into #CodigoAS400Mda select  'SEK','SEK', 'SWKR'
	 Insert into #CodigoAS400Mda select  'NZD','NZD', 'NZ.D'  
	 Insert into #CodigoAS400Mda select  'NOK','NOK', 'NKR'
	 Insert into #CodigoAS400Mda select  'BRL','BRL', 'BRL'
	 Insert into #CodigoAS400Mda select  'DKK','DKK', 'DKR'
	 Insert into #CodigoAS400Mda select  'CAD','CAD', 'CA.D'
	 Insert into #CodigoAS400Mda select  'CHF','CHF', 'SFCS'
	 Insert into #CodigoAS400Mda select  'CLP','CLP', 'CHEZ'
	 Insert into #CodigoAS400Mda select  'USD','USD', 'US.D'
	 Insert into #CodigoAS400Mda select  'UF','CLF', 'UF'
	 Insert into #CodigoAS400Mda select  'GBP','GBP', 'LSTG'
	 Insert into #CodigoAS400Mda select  'EUR','EUR', 'EUR'
	 Insert into #CodigoAS400Mda select  'JPY','JPY', 'YEN'


    -- SP_FUSION_INTERFAZ_LCR_Interno_Derivados '20150622'   
    -- SP_FUSION_INTERFAZ_LCR_Interno_Derivados '20150623'    
	insert into #INT_SALIDA
	select  convert( Varchar(296), 
	   -- Contrato
	     replicate('0', 13 - len( convert( varchar(13), [CONTRATO] ) )  ) + ltrim(rtrim( convert( varchar(13), [CONTRATO])))
		 
	   -- Rut
	     + replicate( '0' , 10 - len(isnull( [RUT], 'ERR       ' ) ) ) + ltrim(rtrim( convert( varchar(10), [RUT])))  
	   -- DV
	   + [DIGV]
	   -- Facility
	   +  [Facility]
	   -- Fecha Inicio Contrato
	   + convert( varchar(8), [DTContr], 112 ) 
	   -- Fecha Vence Contrato
	   + convert( varchar(8), [DTVenc], 112 ) 
	   -- Moneda 
	   + ltrim(rtrim( convert( varchar(4), isnull(MdaITAU.MdaAS, 'ERR'  ) ))) + replicate( ' ' , 4- len(isnull( MdaITAU.MdaAS, 'ERR' ) ) )
	   -- Valor Nocional Contrato POR HACER  
       +  REPLICATE ('0', 14 - len(  convert( numeric(14),  [VLCONTR_Nocional]  *100 ) ) )
          +  convert( varchar(14), convert( numeric(14), [VLCONTR_Nocional] * 100 ) ) 	
	   -- Valor Principal Riesgo Interno 
	    +  REPLICATE ('0', 14 - len(  convert( numeric(14),  [VLPRIN_Valor_Principal_Riesgo_Interno]  *100 ) ) )
          +  convert( varchar(14), convert( numeric(14), [VLPRIN_Valor_Principal_Riesgo_Interno] * 100 ) ) 
	   +  [Signo_01]
	   -- MTM se deben formatear 4 decimales
	    +  REPLICATE ('0', 16 - len(  convert( numeric(16),  [VALMTM_ValorMTM]  * 10000 ) ) )
          +  convert( varchar(16), convert( numeric(16), [VALMTM_ValorMTM] * 10000 ) ) 
	   +  [Signo_02]
	   -- VALRCP
	    +  REPLICATE ('0', 16 - len(  convert( numeric(16),  [VALRCP_MontoREC]  * 10000 ) ) )
          +  convert( varchar(16), convert( numeric(16), [VALRCP_MontoREC] * 10000 ) ) 
	   -- NOMPRO
	   +  [NOMPRO_NombreProducto]
	   +  [FILLER] 
	    ) -- Convert
        , ORDEN = Corr
        , CANTIDAD = 0 
        , Moneda = 0
        , Rut_Cliente  = 0
        , Codigo_Cliente = 0
	   from #TMP001 
	      left join #CodigoAS400Mda MdaITAU on MdaITAU.MdaBAC = #TMP001.MdaNocionalNemo

		if exists( select (1) from #INT_SALIDA )
		   BEGIN
				If @formateada = 'S' 
				Begin

					declare @Cnt_Registros numeric(10)
					select  @Cnt_Registros = count(1) from #INT_SALIDA
					update #INT_SALIDA set cantidad = @Cnt_Registros

					if exists( select (1) from #INT_SALIDA where #INT_SALIDA.LINEA like '%ADVERTENCIA: moneda no definida:%' )
					   select Linea = substring(  #INT_SALIDA.LINEA ,  1, 295 ) , Cnt = @Cnt_Registros, orden, rut_Cliente
							  from #INT_SALIDA  
							  order by  ORDEN
					else
					  begin
						  SELECT Linea = substring(  #INT_SALIDA.LINEA ,  1, 295 ) , Cnt = @Cnt_Registros, orden, rut_Cliente FROM #INT_SALIDA   order by  #INT_SALIDA.ORDEN
					  end 
                 End 
				 else
				     select * from  #TMP001 -- where MdaNocionalNemo not in ( select MdaBAC from #CodigoAS400Mda )
		   END
		else
		 select  Linea = convert( CHAR(295) , 'NO HAY INFORMACION PARA INTERFAZ!!!!' )
			   , cantidad = 0  , orden = 0
    
	     drop table #Salida
		 drop table #ProductoInstrumento 
		 drop table #TMP001
END


GO
