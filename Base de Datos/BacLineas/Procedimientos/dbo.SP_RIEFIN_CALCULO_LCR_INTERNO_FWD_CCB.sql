USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CALCULO_LCR_INTERNO_FWD_CCB]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RIEFIN_CALCULO_LCR_INTERNO_FWD_CCB]
 AS
BEGIN

-- SP_RIEFIN_CALCULO_LCR_INTERNO_FWD_CCB 

    SET NOCOUNT ON

    DECLARE @Fecha                  DATETIME
    DECLARE @SubTotal               float
    DECLARE @Prc                    float

    DECLARE 
			 @MontoPrincipal         FLOAT  
		   , @MonedaPrincipal        FLOAT  
		   , @MontoSecundario        FLOAT  
		   , @MonedaSecundaria       FLOAT  
		   , @Plazo                  FLOAT 
		   , @IdOper                 int
           , @Rut                    numeric(13)
           , @Codigo                 numeric(5)
           , @Contrato               numeric(13)
           , @MtoM                   float
           , @Duration               FLOAT
           , @TipOper				 CHAR(1)

    SELECT @Fecha = acFecProc
    FROM bactradersuda..mdac   -- select * from bactradersuda..mdac

	-- Por ahora todos los RUT.
    delete TBL_RIEFIN_Tabla_AddOnVcto
    where Fecha = @Fecha
    and Vehiculo = 'CCB'


	Select * 
	into #CCBCartera 
	from  LNKBACBDC72.BDC72.Dbo.FMCarteraForward 
	where Estado = 'V' and FechaVencimiento >= @Fecha


	select  Correlativo   = identity(Int, 0,1) 
		  ,	CaNumOper         = CARTERA.FolioCartera                                        -- CBB:CARTERA.CaNumoper  
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
		  , nDiasValor               = 0 * 10000 -- MAP
		  , cDiasFeriados            = replicate( ' ', 500 )
		  ,	cEstadoDia			     = 'I'  -- H: habil, I:Inhabil
		  ,	cDiaCaracter 			 = '  '
		  , CaCodigo = convert( numeric(13), substring( ltrim(rtrim(RutCliente)), 1, charindex( '-', ltrim(rtrim(RutCliente))) - 1 ) )
		  , CaCodCli      = 1	
		  , fRes_Obtenido = MtoVRNeto  -- Valor Razonable
          
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
/* Por mientras hasta que se recuelva el tema
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
			AND	cEstadoDia	= 'I'   and nDiasValor <> 0           
			
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

			IF (SELECT COUNT(1) FROM #MfCaCCB WHERE CaCodPos1 IN (1,2) AND cEstadoDia = 'I' and nDiasValor <> 0) = 0 BEGIN
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
			   ,  LISTADOCodigo_Padre = isnull( CR.ClCodigo_Padre, CaCodCli) 
		into #MFCA
		from #MfCaCCB Car
				 LEFT JOIN BacLineas.dbo.Cliente_relacionado CR
					 ON ( CR.clrut_hijo = Car.CaCodigo and CR.clcodigo_hijo = Car.CaCodCli )
		-----------------------------------------
		-- Detección de las familias en BAC    --
		-----------------------------------------
       
        declare @SimulaCursor numeric(10)
        declare @MaximoCursor numeric(10)
        set     @SimulaCursor = 0
        select  @SimulaCursor = min( Correlativo ), @MaximoCursor = max( Correlativo )  from #MFCA
 
        while @SimulaCursor <= @MaximoCursor
        BEGIN
			select @MontoPrincipal  = CaMtoMon1
                 , @MontoSecundario = CaMtoMon2
                 , @Plazo           = dateDiff( dd, @Fecha, CaFecEfectiva )
                 , @MonedaPrincipal = CaCodMon1
                 , @MonedaSecundaria = CaCodMon2
                 , @Rut              = LISTADORut_Padre
                 , @Codigo           = LISTADOCodigo_Padre
                 , @Contrato         = CaNumOper
                 , @MtoM             = fRes_Obtenido                 
                 , @Duration         = dateDiff( dd, @Fecha, CaFecEfectiva )/365.0
                 , @TipOper			 = CaTipOper
            From #MFCA where Correlativo = @SimulaCursor

            EXEC BacLineas.dbo.SP_Riesgo_Potencial_Futuro        0
                                                               , 'BFW'
                                                               , '1'
                                                               , @TipOper
                                                               , @MontoPrincipal
                                                               , @MontoSecundario
                                                               , @Plazo
                                                               , @Plazo
                                                               , @MonedaPrincipal
                                                               , @MonedaSecundaria
                                                               , @Duration
                                                               , @Duration
                                                               , @Fecha  -- select * from bacfwdsuda..mfac
                                                               , @SubTotal output
                                                               , @Prc      output

            -- select '@SubTotal' = @SubTotal, '@Prc' = @Prc, '@Plazo', @Plazo, '@SimulaCursor', @SimulaCursor
            
            Insert into TBL_RIEFIN_Tabla_AddOnVcto
            select   Fecha  = @Fecha
                   , Rut    = @Rut
                   , Codigo = @Codigo
                   , Tipo_Operacion = 'Fwd'
                   , Numero_Operacion = @Contrato
                   , MtoPrinc         = @MontoPrincipal
                   , Prc              = @Prc
                   , AddOnVcto        = @SubTotal 
                   , MtoM             = @MtoM
                   , Plazo            = @Plazo 
                   , Vehiculo         = 'CCB'
            Set @SimulaCursor = @SimulaCursor + 1
            
       END
END
-- select * from TBL_RIEFIN_Tabla_AddOnVcto


GO
