USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NEWVALORDEVENGO]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_NEWVALORDEVENGO](	 
		@dFecPro      		DATETIME
	,	@dFecProAnt      	DATETIME
	,	@dFecProxPro   		DATETIME
	,	@dFecUDMPro  	        DATETIME
	,	@dFecUDMAnt   	        DATETIME
	,	@cLastHabil            	CHAR(2)
	,	@cFirstHabil		CHAR(2)
	,	@nValorUF_Ant   	NUMERIC(12,04)
	,	@nValorUF_Pro		NUMERIC(12,04)
	,	@nValorUF_UDM	        NUMERIC(12,04)
	,	@nValUsd_Pro		NUMERIC(12,4)
	,	@nValUsd_Ant		NUMERIC(12,4)
	,	@nvalusd_udma	        NUMERIC(12,4)
	,	@iEjecucionIniDia   INT      = 0
	)
WITH RECOMPILE
AS
BEGIN 


	SET NOCOUNT ON

	DECLARE @nNumOpe		NUMERIC(10,00)
 	,	@nCarter   		NUMERIC(02,00)
 	,	@nCodMon      		NUMERIC(03,00)
 	,	@nMtoMex      		NUMERIC(21,04)
	,	@nValMex_i		NUMERIC(21,04)
	,	@nMtoClp_i 		NUMERIC(21,00)
	,	@nCodCnv      		NUMERIC(03,00)
	,	@nMtoCnv      		NUMERIC(21,04) 
	,	@nMtoCnv_i 		NUMERIC(21,00)
	,	@nPlazoOpe     		NUMERIC(04,00)
	,	@nPlazoVto		NUMERIC(04,00)
	,	@nPlazoVctop		NUMERIC(04,00)
	,	@nPlazoCal		NUMERIC(04,00)
	,	@nPlazoCal_a		NUMERIC(04,00)
	,	@nDiaDev      		NUMERIC(04,00)
	,	@nValorUF		NUMERIC(12,04)
	,	@nValUsd_C		NUMERIC(12,04)
        ,	@nMonRef      		NUMERIC(03,00)
	,	@nMtoDif		NUMERIC(21,00)
	,	@nDelUsd		NUMERIC(12,04)
	,	@nDelUf			NUMERIC(12,04)
	,	@nDelUsd_a		NUMERIC(12,04)
	,	@nDelUf_a		NUMERIC(12,04)
	,	@nPerDif 		NUMERIC(21,00)
	,	@nUtiDif 		NUMERIC(21,00)
	,	@nPerDev 		NUMERIC(21,00)
	,	@nUtiDev 		NUMERIC(21,00)
	,	@nPerAcu 		NUMERIC(21,00)
	,	@nUtiAcu 		NUMERIC(21,00)
	,	@nPerAcu_a 		NUMERIC(21,00)
	,	@nUtiAcu_a 		NUMERIC(21,00)
	,	@nPerSal 		NUMERIC(21,00)
	,	@nUtiSal 		NUMERIC(21,00)
	,	@nClp_Mex		NUMERIC(21,00)
	,	@nClp_Cnv		NUMERIC(21,00)
	,	@nCtaCamb_a 		NUMERIC(21,00)
	,	@nCtaCamb_c 		NUMERIC(21,00)
	,	@nReaUFDia 		NUMERIC(21,00)
	,	@nReaTCDia 		NUMERIC(21,00)
	,	@nValorDia		NUMERIC(21,00)
	,	@nRevUsd		NUMERIC(21,00)
	,	@nRevUF			NUMERIC(21,00)
	,	@nRevUsd_a		NUMERIC(21,00)
	,	@nRevUF_a		NUMERIC(21,00)
	,	@nRevTot		NUMERIC(21,00)
	,	@nRevTot_a		NUMERIC(21,00)
	,	@nMtoComp		NUMERIC(21,04)
	,	@nMarktomarket		NUMERIC(21,04)
	,	@nPrecioMtm		NUMERIC(21,04)
	,	@nmonto_mtm_usd 	NUMERIC(21,04)
	,	@nmonto_mtm_cnv 	NUMERIC(21,04)
	,	@nmonto_var_usd 	NUMERIC(21,04)	
	,	@nmonto_var_cnv 	NUMERIC(21,04)	
	,	@nObserAyer		NUMERIC(21,10)	
	,	@nmtoini1  		NUMERIC(21,04)
	,	@nmtofin1  		NUMERIC(21,04)	
	,	@nmtoini2  		NUMERIC(21,04)	
	,	@nmtofin2  		NUMERIC(21,04)	
	,	@nMtoDif_usd		NUMERIC(21,04)	
	,	@nMtoDif_cnv		NUMERIC(21,04)	
	,	@ndevengo_Acu_usd_hoy 	NUMERIC(21,04)	 
	,	@ndevengo_Acu_cnv_hoy 	NUMERIC(21,04)	  
	,	@ndevengo_Acu_usd_ayer	NUMERIC(21,04)	  
	,	@ndevengo_Acu_cnv_ayer	NUMERIC(21,04)	  
	,	@clp_nMtoDif_usd 	NUMERIC(21,00)	  
	,	@clp_nMtoDif_cnv 	NUMERIC(21,00)	  
	,	@clp_ndevengo_usd 	NUMERIC(21,00)	  
	,	@clp_ndevengo_cnv 	NUMERIC(21,00)	  
	,	@clp_ndevengo_Acu_usd 	NUMERIC(21,00)	  
	,	@clp_ndevengo_Acu_cnv 	NUMERIC(21,00)	  
	,	@clp_nSaldo_diferido_usd NUMERIC(21,00)	  
	,	@clp_nSaldo_diferido_cnv NUMERIC(21,00)	
	,	@tc_calculo_mes_actual	NUMERIC(12,4)	
	,	@tc_calculo_mes_anterior NUMERIC(21,4)	
	,	@nefecto_cambiario_mon1	NUMERIC(21,00)	
	,	@nefecto_cambiario_mon2	NUMERIC(21,00)	
	,	@ndevengo_tasa_mon1	NUMERIC(21,00)	
	,	@ndevengo_tasa_mon2	NUMERIC(21,00)	
	,	@ncambio_tasa_mon1	NUMERIC(21,00)	
	,	@ncambio_tasa_mon2	NUMERIC(21,00)	
	,	@nresiduo		NUMERIC(21,00)	
	,	@nmonto_mtm_mon1_ayer	NUMERIC(21,00)	
	,	@nmonto_mtm_mon2_ayer	NUMERIC(21,00)	
	,	@valor_actual_cnv	NUMERIC(21,04)	
	,	@devengo1		NUMERIC(21,00)	
	,	@monto_acumulado_mon1 	NUMERIC(21,04)	
	,	@monto_acumulado_mon2 	NUMERIC(21,04)	
	,	@plazo_uso_moneda1	NUMERIC(05,00)	
	,	@plazo_uso_moneda2	NUMERIC(05,00)	
	,	@nPlazoVtoanterior 	NUMERIC(4,0)	

	DECLARE @nTasa1        		FLOAT          
	,	@nTasa2        		FLOAT          
	,	@cacolmon1 		FLOAT
	,	@ntasausd_mtm 		FLOAT
	,	@ntasacnv_mtm 		FLOAT
	,	@ntasausd_var 		FLOAT
	,	@ntasacnv_var 		FLOAT
	,	@nptofwdvcto		FLOAT
	,	@preciospot		FLOAT
	,	@valormtm_usd		FLOAT
	,	@valorpte_usd		FLOAT
	,       @preciofwd              FLOAT
	,       @ntipcamval            	FLOAT
	,       @ntccierre             	FLOAT
	,	@ntasausd		FLOAT
	,	@ntasacnv		FLOAT
	,	@Valor_Obtenido		FLOAT
	,	@ResultadoMTM		FLOAT
	,	@CaTasaSinteticaM1	FLOAT
	,	@CaTasaSinteticaM2	FLOAT
	,	@CaPrecioSpotVentaM1	FLOAT
	,	@CaPrecioSpotVentaM2	FLOAT
	,	@CaPrecioSpotCompraM1	FLOAT
	,	@CaPrecioSpotCompraM2	FLOAT
	,	@nPlazoVtoEfec		FLOAT
	,       @ValorRazonableActivo	FLOAT
	,       @ValorRazonablePasivo   FLOAT
	,	@nValCnv_i		FLOAT
	,	@nPreFut		FLOAT
	
 	DECLARE @TipoCurvaMon  		VARCHAR(05)     
	,       @TipoCurvaCnv  		VARCHAR(05)      

	DECLARE @dFecIni		DATETIME
   	,	@dFecVto		DATETIME
	,	@dFecAux		DATETIME
	,	@dFecVctop		DATETIME
	,	@dFecEfectiva  		DATETIME
	,	@FechaCalculos    	DATETIME
	,	@vencimiento_original	DATETIME	

       	DECLARE @ctipcli               	CHAR(01)
	,	@cModal			CHAR(01)
	,	@canticipo		CHAR(01)	
	,	@cfuerte                CHAR(01)
	,	@cTipOpe      		CHAR(01)
       	,	@PrimerDiaMes      	CHAR(08)	

	DECLARE @iFound   		INT
	,	@iRefMercado         	INT
	,	@nCorrelativo		INT
       	,	@CodPais                INT

	DECLARE @CONST_ARB_MONEDA	SMALLINT
	,	@CONST_ARB_FUTURO	SMALLINT
	,	@CONST__T__LOCK		SMALLINT

	SET @CONST_ARB_MONEDA	= 12;

	SET @CONST_ARB_FUTURO	= 02;

	SET @CONST__T__LOCK	= 11;	 


	SET @FechaCalculos    	= CASE 		WHEN DATEPART(MONTH, @dFecPro) = DATEPART(MONTH, @dFecProxPro) 
						THEN @dFecPro
						ELSE @dFecUDMPro 
				  END;

	SET @iFound      = -1;

	SET @iFound      =  ( SELECT TOP 1 0 	
				FROM BacparamSuda..VALOR_MONEDA_CONTABLE
			       WHERE Fecha = CASE	WHEN @iEjecucionIniDia = 1 
							THEN @dFecProAnt 
							ELSE @dFecPro 
					     END
				 AND Tipo_Cambio <> 0.0);

	IF @iFound = -1 BEGIN
		SELECT -1 , 'No Existen Valores de Monedas Contables a la Fecha de Proceso...'
		RETURN
	END;

---- > Agrego nuevo cambio T-LOCK

	SET @iFound   = 0;

	SET @iFound   = (SELECT COUNT(1) 
			  FROM MFCA
			 WHERE cacodpos1 = 11
			   AND caestado  = ''
			   AND caserie NOT IN( SELECT DISTINCT instrumento 
						 FROM BENCH_MARCK_INVEX 
					        WHERE fecha = CASE 	WHEN @iEjecucionIniDia = 0 
									THEN @dFecPro 
									ELSE @dFecProAnt 
							      END));


	IF @iFound > 0 BEGIN
		SELECT -1 , 'Se deben ingresar las tasa Bench Marck INV.EXT antes de Devengar.'
		RETURN -1
      	END;

	SET @iFound   = 0;

	SET @iFound   = (SELECT COUNT(1)
			  FROM MFCA       
			 INNER 
		          JOIN BENCH_MARCK_INVEX 
			    ON fecha = (CASE 	WHEN @iEjecucionIniDia = 0
						THEN @dFecPro 
						ELSE @dFecProAnt 
				       END)
                           AND caserie = instrumento 
			   AND tasa = 0
   			 WHERE cacodpos1 = 11
			   AND caestado  = '');

	IF @iFound > 0  BEGIN
		SELECT -1 , 'Se deben ingresar las tasa Bench Marck INV. EXT.  distinta de Cero.'
		RETURN -1
	END;

-----< Datos de >

	SET @PrimerDiaMes   = SUBSTRING(CONVERT(CHAR(8),@dfecpro,112),1,6) + '01';

	SET @nValUsd_c  = @nValUsd_Pro;

	SET @nObserAyer = @nValUsd_Ant;

	SET @CodPais    = (SELECT acpais FROM mfac);

	-- Mas actualizacion de tabla de resultado

	BEGIN TRANSACTION

	DECLARE Tmp_CurMFCA   SCROLL CURSOR FOR  
	SELECT	canumoper   		 --1
	,	cacodpos1   		 --2
	,	catipoper   		 --3
	,	cacodmon1   		 --4
	,	camtomon1 		 --5
	,	FLOOR( caequmon1 )	 --6
	,	capremon1   		 --7
	,	cacodmon2   		 --8
	,	camtomon2   		 --9
	,	FLOOR( caequmon2 )	 --10
	,	capremon2   		 --11
	,	cafecha     		 --12
	,	cafecvcto   		 --13
	,	catipcam    		 --14
	,	camdausd    		 --15
	,	caprecal    		 --16
	,	catipmoda   		 --17
	,	camtomon1fin		 --18
	,	camtomon1ini		 --19
	,	camtomon2fin		 --20
	,	camtomon2ini		 --21
	,	catasausd		 --22
	,	catasacon		 --23
	,	tc_calculo_mes_actual	 --24
	,	tc_calculo_mes_anterior  --25
	,	caantici		 --26
	,	cafecvenor		 --27
	,	cafecEfectiva		 --28
	,	cacolmon1                --29
	 FROM BACFWDSUDA..MFCA
	WHERE cafecvcto = CASE 	WHEN @iEjecucionIniDia = 1 
				THEN @dFecPro 
				ELSE cafecvcto 
			  END
 	  AND (CACODPOS1 = @CONST_ARB_MONEDA OR CACODPOS1 = @CONST_ARB_FUTURO OR CACODPOS1 = @CONST__T__LOCK)

	OPEN Tmp_CurMFCA

 	FETCH FIRST FROM Tmp_CurMFCA
	INTO 	@nNumOpe   	, --1
		@nCarter   	, --2   
	    	@cTipOpe   	, --3
	    	@nCodMon 	, --4
	 	@nMtoMex 	, --5
	    	@nMtoClp_i 	, --6
		@nValMex_i 	, --7
	    	@nCodCnv   	, --8
	    	@nMtoCnv   	, --9
	    	@nMtoCnv_i 	, --10
	    	@nValCnv_i 	, --11  
	    	@dFecIni   	, --12
	   	@dFecVto   	, --13
	    	@nPreFut   	, --14  
	    	@nMonRef   	, --15
               	@ntccierre 	, --16  
	    	@cModal    	, --17
	    	@nmtofin1  	, --18
	    	@nmtoini1  	, --19
	    	@nmtofin2  	, --20
	    	@nmtoini2  	, --21
	    	@ntasausd  	, --22  
	    	@ntasacnv  	, --23  
	    	@tc_calculo_mes_actual	 , -- 24
	    	@tc_calculo_mes_anterior , -- 25
	   	@canticipo	,          -- 26
	    	@vencimiento_original  ,   -- 27
		@dFecEfectiva	, 	   -- 28
		@cacolmon1                 -- 29

	WHILE ( @@FETCH_STATUS = 0 )BEGIN

		SET @nPlazoOpe			= 0
		SET @nPlazoVto 			= 0  
		SET @nPlazoCal 			= 0	
		SET @nDiaDev 			= 0		
		SET @nValorUF 			= 0	
		SET @nMtoDif 			= 0	
		SET @nDelUsd 			= 0	
		SET @nDelUf	        	= 0	
		SET @nDelUsd_a 			= 0	
		SET @nDelUf_a 			= 0	
		SET @nPerDif 			= 0	
		SET @nUtiDif 			= 0	
		SET @nPerDev 			= 0	
		SET @nRevUsd			= 0
		SET @nRevUF			= 0
		SET @nRevUsd_a			= 0
		SET @nRevUF_a			= 0
		SET @nRevTot			= 0
		SET @nRevTot_a			= 0
		SET @nUtiDev 			= 0	
		SET @nPerAcu 			= 0	
		SET @nUtiAcu 			= 0	
		SET @nPerAcu_a 			= 0	
		SET @nUtiAcu_a 			= 0	
		SET @nPerSal 			= 0		
		SET @nUtiSal 			= 0	
		SET @nClp_Mex 			= 0
		SET @nClp_Cnv 	        	= 0
		SET @nPlazoCal_a 		= 0	
		SET @nCtaCamb_a 		= 0	
		SET @nCtaCamb_c 		= 0	
		SET @nReaUFDia 	        	= 0	
		SET @nReaTCDia			= 0
		SET @nValorDia			= 0
		SET @nMtoComp			= 0
		SET @nMarktomarket           	= 0
		SET @nMtoDif_usd 	        = 0
		SET @nMtoDif_cnv 	        = 0	
		SET @nmonto_mtm_usd          	= 0
		SET @nmonto_mtm_cnv          	= 0	
		SET @nmonto_var_usd          	= 0
		SET @nmonto_var_cnv          	= 0
		SET @ntasausd_mtm            	= 0
		SET @ntasacnv_mtm            	= 0
		SET @ntasausd_var            	= 0
		SET @ntasacnv_var            	= 0
		SET @nresiduo                	= 0

		SET @ntipcamval              	= 0
		SET @valor_actual_cnv        	= 0
		SET @devengo1                	= 0
		SET @nPlazoVtoEfec           	= 0

		SET @clp_nMtoDif_usd         	= 0	
		SET @clp_nMtoDif_cnv         	= 0	
		SET @clp_ndevengo_usd        	= 0	
		SET @clp_ndevengo_cnv        	= 0	
		SET @plazo_uso_moneda1       	= 0
		SET @plazo_uso_moneda2       	= 0
		SET @nPlazoVtoanterior       	= 0
		SET @ncambio_tasa_mon1       	= 0
		SET @ncambio_tasa_mon2       	= 0
		SET @ndevengo_tasa_mon1      	= 0
		SET @ndevengo_tasa_mon2      	= 0
		SET @monto_acumulado_mon1    	= 0
		SET @monto_acumulado_mon2    	= 0
		SET @nmonto_mtm_mon1_ayer    	= 0
		SET @nmonto_mtm_mon2_ayer    	= 0
		SET @ndevengo_Acu_usd_hoy    	= 0
		SET @ndevengo_Acu_cnv_hoy    	= 0	
		SET @clp_ndevengo_Acu_usd    	= 0	
		SET @clp_ndevengo_Acu_cnv    	= 0
		SET @ndevengo_Acu_usd_ayer   	= 0	
		SET @ndevengo_Acu_cnv_ayer   	= 0	
		SET @nefecto_cambiario_mon1	= 0
		SET @nefecto_cambiario_mon2	= 0
		SET @clp_nSaldo_diferido_usd 	= 0
		SET @clp_nSaldo_diferido_cnv 	= 0
		SET @nValUsd_Ant             	= @nObserAyer



		SET @nPlazoOpe = DATEDIFF( dd, @dFecIni, @dFecVto);

		IF @nPlazoOpe = 0 SET @nPlazoOpe = 1;

        	SET @cTipCli = (SELECT CASE clpais 	WHEN @CodPais 
							THEN 'L' 
							ELSE 'E' 
				       END
				  FROM MFCA
			    INNER JOIN VIEW_CLIENTE
				    ON clrut = cacodigo 
				   AND clcodigo = cacodcli
				 WHERE canumoper = @nNumOpe);
           

		IF @nCarter = @CONST_ARB_FUTURO BEGIN -->02 

			SET @iRefMercado = CONVERT(NUMERIC(5), @cacolmon1)

			EXECUTE BacFwdSuda..SP_GENERA_FECHA_EFECTIVA @nCarter, @cModal, @iRefMercado, @dFecVto, @dFecEfectiva OUTPUT

			UPDATE MFCA
			   SET cafecefectiva = @dFecEfectiva
			 WHERE canumoper     = @nNumOpe
		END


		IF @dFecVto < @dFecPro BEGIN

			SET @nPlazoVto = 0;

			SET @nPlazoVtoEfec = 0;

        	END ELSE BEGIN

			SET @nPlazoVto      = DATEDIFF(DAY, @FechaCalculos, @dFecVto);

			SET @nPlazoVtoEfec  = DATEDIFF(DAY, @FechaCalculos, @dFecEfectiva);
		END

		SET @nPlazoVtoanterior = 0;

		IF @dFecini < @dFecPro SET @nPlazoVtoanterior = DATEDIFF(dd , @dFecProAnt , @dFecVto);

		IF @dFecPro = @dFecVto BEGIN

			SET @nPlazoCal   = DATEDIFF(DAY, @dFecIni, @FechaCalculos);

		END ELSE BEGIN

			IF @dFecVto < @dFecPro BEGIN
				SET @nPlazoCal = DATEDIFF( dd, @dFecIni, @dFecVto);
			END ELSE BEGIN
				SET @nPlazoCal = DATEDIFF( dd, @dFecIni, @dFecProxPro);
			END

			IF @cLastHabil = 'SI' AND @dFecVto <> @dFecPro SET @nPlazoCal = DATEDIFF( dd , @dFecIni , (@dFecUDMPro + 1));
		END

		IF @canticipo = 'A'  SET @nPlazoCal = DATEDIFF( dd, @dFecIni, @vencimiento_original );

		IF @dFecIni < @dFecPro SET @nPlazoCal_a = DATEDIFF(DAY, @dFecIni, @FechaCalculos);
	
		IF @cFirstHabil = 'SI'	AND @dFecIni < @dFecPro	 SET @nPlazoCal_a = DATEDIFF( dd , @dFecIni , (@dFecUDMAnt + 1));


		IF @dFecVto < @dFecPro BEGIN
			SELECT @dFecAux = @dFecVto
		END ELSE BEGIN
			IF @canticipo = 'A' BEGIN
				SELECT @dFecAux = @vencimiento_original
			END ELSE BEGIN
				SELECT @dFecAux = @dFecProxPro
			END
		END

		SET @nDiaDev = DATEDIFF(DAY, @FechaCalculos, @dFecAux );

		IF @cFirstHabil = 'SI' BEGIN		
			IF @dFecIni < @dFecPro BEGIN
				IF @dFecVto = @dFecPro  SET @nDiaDev = DATEDIFF( dd , ( @dFecUDMAnt + 1 ) , @dFecPro );
				ELSE SET @nDiaDev = DATEDIFF( dd , ( @dFecUDMAnt + 1 ) , @dFecProxPro );
			END
		END

		IF @cLastHabil = 'SI' SET @nDiaDev = DATEDIFF( dd , @dFecPro , ( @dFecUDMPro + 1 ) );
	
		IF @dFecVto <= @dFecPro AND @canticipo <> 'A' AND @cFirstHabil = 'NO' SET @nDiaDev = 0;

		SET @nValorUF = @nValorUF_Pro;

		IF @dFecPro <> @FechaCalculos SET @nValorUF = @nValorUF_UDM;

		IF @cLastHabil = 'SI' BEGIN
			IF @dFecVto <> @dFecPro SET @nValorUF = @nValorUF_UDM;
		END		


		IF @nCarter = @CONST_ARB_FUTURO BEGIN  -- M/X-USD

			IF @cTipOpe = 'C' SET @nmtodif = @nMtoClp_i - @nMtoCnv_i;
			ELSE		  SET @nmtodif = @nMtoCnv_i - @nMtoClp_i;

			SELECT @cfuerte = mnrefusd 
			  FROM VIEW_MONEDA 
			 WHERE mncodmon = @nCodMon;
		
			IF @dFecVto > @dFecPro AND @nCodCnv=13 BEGIN -- Cálculo de BID-ASK

				EXECUTE Sp_BidAsk2 @ncodmon , @dFecpro,@cTipOpe, @nPlazovto , @nPtofwdvcto OUTPUT , @Preciospot OUTPUT	

				SET @preciofwd = ROUND( @preciospot +  @nptofwdvcto , 6 ) 

				IF @cfuerte = 0 BEGIN --Mas Débil 
					EXECUTE Sp_Div 1.0 , @preciofwd  , @preciofwd OUTPUT 
					SET @preciofwd = ROUND(@preciofwd,10)
				END
                     
				SET @valormtm_usd = ROUND( @nMtoMex * @preciofwd    , 2 );

				SET @valorpte_usd = ROUND( @nMtoCnv - @valormtm_usd , 2 );

				IF @cTipOpe = 'C' SET @valorpte_usd =  @valorpte_usd * -1
                          
				IF @cfuerte = 0 EXECUTE Sp_Div 1 , @preciofwd , @preciofwd OUTPUT 
		
				SET @nValorDia = ROUND(ISNULL(@valorpte_usd * @nValUsd_c, 0.0),0);

				SET @ntipcamval = ISNULL(@preciofwd,0.0)
		END
                
		IF @dFecVto <= @dFecpro and @cModal = 'C' BEGIN
               		SELECT @preciofwd = @ntccierre

			IF @cfuerte = 0 BEGIN -- Mas Debil
				EXECUTE Sp_Div 1 , @ntccierre , @preciofwd OUTPUT 
			END

			IF @cTipOpe = 'C' BEGIN -- antes era esto DLS --> IF @cTipOpe = 'V' BEGIN
				SELECT @nMtoComp = ROUND(@nMtoMex * @PrecioFWD , 2) - @nMtoCnv
			END ELSE BEGIN
				SELECT @nMtoComp = @nMtoCnv - ROUND( @nMtoMex * @PrecioFWD , 2 )
			END

			IF @cTipCli = 'L' AND (@ncodcnv <> 999 and @ncodcnv<>998)
		       SELECT @nMtoComp = ROUND( @nMtoComp * @nValUsd_c, 0)
		END
	END

	IF @nCarter = @CONST__T__LOCK BEGIN

		EXECUTE SP_C08_TLOCK @nNumOpe , @iEjecucionIniDia
	END


	IF @nCarter = @CONST_ARB_FUTURO BEGIN

		SET @dFecVctop   = @dFecVto;

		SET @nPlazoVctop = @nPlazoVto;
	 				
		IF @nCarter = @CONST_ARB_FUTURO 

			EXECUTE sp_marktomarket 
				@nCarter
			,	@nPlazoVctop
			,       @nCodCnv
			,	@nValorUF
			,	@nMtoMex
			,	@dFecVctop
			,	@cTipOpe
			,	@nPreFut
			,       @nCodMon
			,	@nNumOpe
			,	@nMarkToMarket    	OUTPUT
			,	@nPrecioMtm       	OUTPUT
                        ,       @nmonto_mtm_usd  	OUTPUT
                 	,	@nmonto_mtm_cnv   	OUTPUT
			,	@Valor_Obtenido         OUTPUT
			,	@ResultadoMTM	        OUTPUT
			,	@cModal 
			,	@CaTasaSinteticaM1 	OUTPUT
			,	@CaTasaSinteticaM2 	OUTPUT
			,	@CaPrecioSpotVentaM1	OUTPUT
			,	@CaPrecioSpotVentaM2 	OUTPUT
			,	@CaPrecioSpotCompraM1   OUTPUT
			,	@CaPrecioSpotCompraM2   OUTPUT
                        ,       @ValorRazonableActivo   OUTPUT
                        ,       @ValorRazonablePasivo   OUTPUT
			,	@nTasa1                 OUTPUT
			,	@nTasa2           OUTPUT
			,	@TipoCurvaMon           OUTPUT
			,	@TipoCurvaCnv           OUTPUT
                        ,        @iEjecucionIniDia

--			IF @nCorrelativo = 0 BEGIN
				UPDATE MFCA  
				   SET	caplazoope                      = @nPlazoOpe		
				,	caplazovto                      = @nPlazoVto		
				,	caplazocal                      = @nPlazoCal		
				,	cadiasdev                       = @nDiaDev		
				,	cadiftipcam 			= @nReaTCDia		
				,	cadifuf 			= @nReaUFDia		
				,	carevusd			= @nRevUsd		
				,	carevuf				= @nRevUF		
				,	carevTot			= @nrevTot		
				,	carevusd_ayer			= @nRevUsd_a		
				,	carevuf_ayer			= @nRevUF_a		
				,	carevTot_ayer			= @nrevTot_a		
			        ,        cavalordia			= @nValorDia		
				,	cactacambio_a			= @nctaCamb_a		
				,	cactacambio_c			= @nctaCamb_c		
				,	cautildiferir			= @nUtiDif 		
				,	caperddiferir 			= @nPerDif		
				,	cautildevenga 			= @nUtiDev		
				,	caperddevenga 			= @nPerDev		
				,	cautilacum 			= @nUtiAcu		
				,	caperdacum 			= @nPerAcu		
				,	cautilacum_ayer			= @nUtiAcu_a		
				,	caperdacum_ayer			= @nPerAcu_a		
				,	cautilsaldo 			= @nUtiSal		
				,	caperdsaldo 			= @nPerSal		
				,	caclpmoneda1 			= @nClp_Mex 		
				,	caclpmoneda2 			= @nClp_Cnv 		
				,	cadelusd			= @nDelUsd		
				,	cadeluf				= @ndelUf		
				,	camtocomp      			= @nMtoComp     	
				,	camarktomarket 			= ISNULL(@nMarktomarket,0) 	
				,	capreciomtm			= ISNULL(@nPrecioMtm,0)		
				,	catipcamval     		= @ntipcamval		
				,	diferido_usd			= @nMtoDif_usd			
				,	diferido_cnv			= @nMtoDif_cnv			
				,	camtodiferir			= @nmtodif 			
				,	devengo_acum_usd_hoy            = @ndevengo_Acu_usd_hoy 		
				,	devengo_acum_cnv_hoy 		= @ndevengo_Acu_cnv_hoy 	
				,	devengo_acum_usd_ayer           = @ndevengo_Acu_usd_ayer		
				,	devengo_acum_cnv_ayer		= @ndevengo_Acu_cnv_ayer	
				,	pesos_diferido_usd		= @clp_nMtoDif_usd 		
				,	pesos_diferido_cnv		= @clp_nMtoDif_cnv 		
				,	pesos_devengo_usd		= @clp_ndevengo_usd 		
				,	pesos_devengo_cnv		= @clp_ndevengo_cnv 		
				,	pesos_devengo_acum_usd	        = @clp_ndevengo_Acu_usd 	
				,	pesos_devengo_acum_cnv	        = @clp_ndevengo_Acu_cnv 	
				,	pesos_devengo_saldo_usd	        = @clp_nSaldo_diferido_usd 	
				,	pesos_devengo_saldo_cnv   	= @clp_nSaldo_diferido_cnv 	
				,	valor_actual_cnv		= @valor_actual_cnv		
				,	mtm_hoy_moneda1		        = ISNULL(@nmonto_mtm_usd,0)	
				,	mtm_hoy_moneda2		        = ISNULL(@nmonto_mtm_cnv,0)	
				,	var_moneda1			= @nmonto_var_usd 		
				,	var_moneda2			= @nmonto_var_cnv 		
				,	tasa_mtm_moneda1		= @ntasausd_mtm 		
				,	tasa_mtm_moneda2		= @ntasacnv_mtm		
				,	tasa_var_moneda1		= @ntasausd_var 		
				,	tasa_var_moneda2		= @ntasacnv_var 		
				,	efecto_cambio_moneda1		= @nefecto_cambiario_mon1	
				,	efecto_cambio_moneda2		= @nefecto_cambiario_mon2	
				,	devengo_tasa_moneda1		= @ndevengo_tasa_mon1	
				,	devengo_tasa_moneda2		= @ndevengo_tasa_mon2	
				,	cambio_tasa_moneda1		= @ncambio_tasa_mon1 	
				,	cambio_tasa_moneda2		= @ncambio_tasa_mon2 	
				,	residuo				= @nresiduo 			
				,	mtm_ayer_moneda1		= @nmonto_mtm_mon1_ayer 	
				,	mtm_ayer_moneda2		= @nmonto_mtm_mon2_ayer 	
				,	caplazo_uso_moneda1		= @plazo_uso_moneda1		
				,	caplazo_uso_moneda2		= @plazo_uso_moneda2		
				WHERE canumoper=  @nNumOpe
--			END

			EXECUTE sp_marktomarket 
				@nCarter
			,	@nPlazoVtoEfec				
			,       @nCodCnv
			,	@nValorUF
			,	@nMtoMex
			,	@dFecVctop
			,	@cTipOpe
			,	@nPreFut
			,       @nCodMon
			,	@nNumOpe
			,	@nMarkToMarket    	OUTPUT
			,	@nPrecioMtm       	OUTPUT
                        ,       @nmonto_mtm_usd  	OUTPUT
                 	,	@nmonto_mtm_cnv   	OUTPUT
			,	@Valor_Obtenido         OUTPUT
			,	@ResultadoMTM	        OUTPUT
			,	@cModal 
			,	@CaTasaSinteticaM1 	OUTPUT
			,	@CaTasaSinteticaM2 	OUTPUT
			,	@CaPrecioSpotVentaM1	OUTPUT
			,	@CaPrecioSpotVentaM2 	OUTPUT
			,	@CaPrecioSpotCompraM1   OUTPUT
			,	@CaPrecioSpotCompraM2   OUTPUT
                        ,       @ValorRazonableActivo   OUTPUT
                        ,       @ValorRazonablePasivo   OUTPUT
			,	@nTasa1                 OUTPUT
			,	@nTasa2                 OUTPUT
			,	@TipoCurvaMon           OUTPUT
			,	@TipoCurvaCnv           OUTPUT
                        ,       @iEjecucionIniDia

--			IF @nCorrelativo = 0 BEGIN
				UPDATE MFCA  	
				   SET fVal_Obtenido 			= @Valor_Obtenido 	
				,	fRes_Obtenido			= @ResultadoMTM 	
				,	CaTasaSinteticaM1		= @CaTasaSinteticaM1	
				,	CaTasaSinteticaM2		= @CaTasaSinteticaM2	
				,	CaPrecioSpotVentaM1		= @CaPrecioSpotVentaM1	
				,	CaPrecioSpotVentaM2		= @CaPrecioSpotVentaM2	
				,	CaPrecioSpotCompraM1		= @CaPrecioSpotCompraM1	
				,	CaPrecioSpotCompraM2		= @CaPrecioSpotCompraM2	
				,	CaFecEfectiva			= @dFecEfectiva         
				,	ValorRazonableActivo            = @ValorRazonableActivo 
				,	ValorRazonablePasivo            = @ValorRazonablePasivo 
				,	catasadolar			= @nTasa1		
				,	catasaufclp			= @nTasa2		
				,	caOrgCurvaMon			= @TipoCurvaMon		
				,	caOrgCurvaCnv			= @TipoCurvaCnv
				  WHERE	canumoper               	= @nNumOpe
--			END

			SET @devengo1             = (@nPerDev + @nUtiDev)
			SET @monto_acumulado_mon1 = @nMtoini1 + ABS(@ndevengo_Acu_usd_hoy)	
			SET @monto_acumulado_mon2 = @nMtoini2 + ABS(@ndevengo_Acu_cnv_hoy)	

			-- Aca se llenaba la tabla de resultado

		END

	 	FETCH NEXT FROM Tmp_CurMFCA
		INTO 	@nNumOpe   	, --1
			@nCarter   	, --2   
		    	@cTipOpe   	, --3
		    	@nCodMon 	, --4
		 	@nMtoMex 	, --5
		    	@nMtoClp_i 	, --6
			@nValMex_i 	, --7
		    	@nCodCnv   	, --8
		    	@nMtoCnv   	, --9
		    	@nMtoCnv_i 	, --10
		    	@nValCnv_i 	, --11  
		    	@dFecIni   	, --12
		   	@dFecVto   	, --13
		    	@nPreFut   	, --14  
		    	@nMonRef   	, --15
	               	@ntccierre 	, --16  
		    	@cModal    	, --17
		    	@nmtofin1  	, --18
		    	@nmtoini1  	, --19
		    	@nmtofin2  	, --20
		    	@nmtoini2  	, --21
		    	@ntasausd  	, --22  
		    	@ntasacnv  	, --23  
		    	@tc_calculo_mes_actual	 , -- 24
		    	@tc_calculo_mes_anterior , -- 25
		   	@canticipo	,          -- 26
		    	@vencimiento_original  ,   -- 27
			@dFecEfectiva	, 	   -- 28
			@cacolmon1                 -- 29
	END -- While
			      
	CLOSE Tmp_CurMFCA;

	DEALLOCATE Tmp_CurMFCA;

	IF @iEjecucionIniDia = 0 EXECUTE SP_DETALLE_VALOR_RAZONABLE @dFecPro, @dFecProxPro, @dFecProAnt;

	UPDATE MFAC 
	   SET  acsw_devenfwd = '1' 
	,	acsw_fd ='0' 
	,	acsw_contafwd = '0'

	IF @@ERROR <> 0 
	BEGIN
		ROLLBACK TRANSACTION
		SELECT -1,
		'Error: al grabar flags de tabla de parametros'
		RETURN -1
	END

	SET NOCOUNT OFF
	COMMIT TRANSACTION

 	SELECT 'OK'
 
END

GO
