USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_CAPTACIONES_TERCEROS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GENERA_CAPTACIONES_TERCEROS]

AS

BEGIN TRAN

	TRUNCATE TABLE MENS_CARGACAPTATERCEROS

	DECLARE @nuevaOperacion NUMERIC(9)
	DECLARE @numeroOperacion NUMERIC(9)
	DECLARE @correlativoOperacion NUMERIC(9)
	DECLARE @vueltaCorrela	NUMERIC(9)
	DECLARE @contador		NUMERIC(9)
	
	--variables de la tabla
	DECLARE @Dfecpro		DATETIME		--Largo 8
			,@cDfecpro		char(10)
			,@cDfecven		char(10)
			,@Nrutcart		NUMERIC(10,0)	--10 enteros sin decimales
			,@Dfecvcto		DATETIME		--Largo 8
			,@Ftasa			FLOAT			--campo tasa (2,4) largo, 2 enteros 4 decimales
			,@Ftasatran		FLOAT			--campo tasa (2,4) largo, 2 enteros 4 decimales
			,@Idias			integer			--Largo 5
			,@Imoneda		INTEGER			--Largo 3
			,@Iforpago		INTEGER			--Largo 3
			,@Nrutcli		NUMERIC(09,0)	--Largo 9
			,@Ncodcli		NUMERIC(09,0)	--Largo 9
			,@Cretiro		CHAR(01)		--Largo 1
			,@Nnumdocu		NUMERIC(10,0)	--Largo 10
			,@Ccustodia		CHAR(01)		--Largo 1
			,@ctipo_deposito CHAR(01)		--Largo 1
			,@ncorrela_corte NUMERIC(03,00)	--Largo 3
			,@ncorrela_oper	NUMERIC(05,00)	--Largo 5
			,@nmtoini		NUMERIC(19,4)	--Largo 23, 19 enteros, 4 decimales.
			,@nmtoiniclp	NUMERIC(19,0)	--Largo 19, 19 enteros.
			,@nmontofin		NUMERIC(19,4)	--Largo 19, 19 enteros 4 decimales
			,@susuari		CHAR(20)		--Largo 20 caracteres
			,@Ejecutivo		INTEGER			--Largo 4
			,@Condicion		CHAR(01)		--Largo 1
			,@pago_hoy		CHAR(01)		--Largo 1
			,@dFecPmH 		CHAR(10)		--Largo 10
			,@observ		CHAR(70)		--Largo 70
			,@sucursal		CHAR(5)			--Largo 5
			,@Tipo_Emision	Integer			--Largo 4
			,@cTerminal		varchar(15)
			,@Numero_certificado_dcv NUMERIC(10)		
			,@nOperCargada	NUMERIC(10)	
			,@nCorrelaCargada NUMERIC(03)	
			,@nCorralaCorte	NUMERIC(03)	
	
	
	SET @vueltaCorrela = 1
	
	CREATE TABLE #UltimaOpe (numOper NUMERIC(9))
	
	UPDATE CARGACAPTATERCEROS
	SET Ncodcli = Clcodigo
	FROM	BacParamSuda..cliente cli
	WHERE	Nrutcli = cli.clrut
	
	
	DECLARE CURSOR_INTER CURSOR FOR   
		--SELECT	DISTINCT Nnumdocu
		--		--,ncorrela_oper
		--		,count(*) as registros
		--FROM	CARGACAPTATERCEROS AS carga
		--	INNER JOIN BacParamSuda..cliente AS cli ON -->jcamposd 20170717 solo se consideraran clientes existentes en BAC
		--		cli.clrut =	carga.Nrutcli
		--		AND cli.Clcodigo = 1 --carga.ncodcli --> no conocen este codigo los que envian la información por lo cual sera 1
		--GROUP BY Nnumdocu
		SELECT	DISTINCT 
				Nnumdocu
				,count(*) as registros		
		FROM	CARGACAPTATERCEROS AS carga
		WHERE	carga.Nrutcli IN (SELECT cli.clrut FROM  BacParamSuda..cliente cli) --AS cli ON -->jcamposd 20170717 solo se consideraran clientes existentes en BAC
		GROUP BY Nnumdocu		
		
		
		OPEN	CURSOR_INTER  
		FETCH	NEXT	FROM CURSOR_INTER
		INTO	@numeroOperacion, @vueltaCorrela

		WHILE @@FETCH_STATUS  = 0
		BEGIN

		SET @contador = 1
		WHILE (@contador <= @vueltaCorrela)
		BEGIN
			
			IF @contador = 1 
			BEGIN
			
				INSERT INTO #UltimaOpe (numOper) EXEC dbo.SP_OPMDAC
				SET @nuevaOperacion = (SELECT numOper FROM #UltimaOpe)
			END
		

			SELECT	
				 @Dfecpro		= Dfecpro
				,@Nrutcart		= 97023000--Nrutcart
				,@Dfecvcto		= Dfecvcto
				,@Ftasa			= Ftasa	
				,@Ftasatran		= Ftasatran
				,@Idias			= Idias
				,@Imoneda		= Imoneda
				,@Iforpago		= 137--Iforpago
				,@Nrutcli		= Nrutcli
				,@Ncodcli		= Ncodcli
				,@Cretiro		= 'V'--Cretiro
				,@Nnumdocu		= @nuevaOperacion--Nnumdocu
				,@Ccustodia		= 'D'--Ccustodia -->DCV
				,@ctipo_deposito= ctipo_deposito
				,@ncorrela_corte= ncorrela_corte
				,@ncorrela_oper = @contador--ncorrela_oper
				,@nmtoini		= nmtoini	
				,@nmtoiniclp	= nmtoiniclp
				,@nmontofin		= nmontofin
				,@susuari		= 'USRMGCN'--susuari
				,@Ejecutivo		= 999--Ejecutivo
				,@Condicion		= Condicion
				,@pago_hoy		= pago_hoy
				,@dFecPmH 		= dFecPmH
				,@observ		= observ
				,@sucursal		= sucursal
				,@Tipo_Emision  = 2--Tipo_Emision --> siempre sera desmaterializado
				,@cTerminal		= cTerminal
				,@nOperCargada	= Nnumdocu
				,@nCorrelaCargada = ncorrela_oper
				,@nCorralaCorte	= ncorrela_corte
				,@Numero_certificado_dcv = Numero_certificado_dcv				
			FROM	CARGACAPTATERCEROS
			WHERE 	Nnumdocu		= @numeroOperacion
				AND ncorrela_oper	= @contador--@correlativoOperacion

			set @cDfecpro = convert(char(10), @Dfecpro, 112)
			set @cDfecven = convert(char(10), @Dfecvcto, 112)
			
			/*SELECT @cDfecpro
				,@Nrutcart,@Dfecvcto,@Ftasa,@Ftasatran,@Idias,@Imoneda,@Iforpago,@Nrutcli,@Ncodcli,@Cretiro,@nuevaOperacion,@Ccustodia,@ctipo_deposito
				,@contador,@contador,@nmtoini,@nmtoiniclp,@nmontofin,@susuari,@Ejecutivo,@Condicion,@pago_hoy,@dFecPmH,@observ		
				,@sucursal,@Tipo_Emision,@cTerminal					
			*/
			EXEC SP_GRABA_CAPTACIONES  
				 @cDfecpro
				,@Nrutcart,@cDfecven,@Ftasa,@Ftasatran,@Idias,@Imoneda,@Iforpago,@Nrutcli,@Ncodcli,@Cretiro,@nuevaOperacion,@Ccustodia,@ctipo_deposito
				,@ncorrela_corte,@contador,@nmtoini,@nmtoiniclp,@nmontofin,@susuari,@Ejecutivo,@Condicion,@pago_hoy,@dFecPmH,@observ		
				,@sucursal,@Tipo_Emision,@cTerminal	
		
			
			IF @@ERROR <> 0
			BEGIN 
				--PRINT 'ENTRE'
				INSERT INTO MENS_CARGACAPTATERCEROS VALUES(@nOperCargada,@nCorralaCorte,@nCorrelaCargada,@nuevaOperacion,@contador,'ERROR')			
			END 
			ELSE
			BEGIN
				INSERT INTO MENS_CARGACAPTATERCEROS VALUES(@nOperCargada,@nCorralaCorte,@nCorrelaCargada,@nuevaOperacion,@contador,'OK')			
			END
			
			--A solicitud de usuario Vgonzalez se anexa la grabación del campo "Numero_certificado_dcv" en la tabla gen_captacion
			
			UPDATE GEN_CAPTACION
			SET Numero_certificado_dcv = @Numero_certificado_dcv
			WHERE numero_operacion	= @nuevaOperacion
			AND correla_operacion	= @contador
			
			SET @contador = @contador + 1
		
		END
		
		SET @contador = 1
		TRUNCATE TABLE #UltimaOpe

		FETCH	NEXT FROM CURSOR_INTER
			INTO @numeroOperacion,@vueltaCorrela
		END  

		CLOSE CURSOR_INTER  
		DEALLOCATE  CURSOR_INTER  


		--SELECT * FROM GEN_CAPTACION where numero_operacion >= 197515


COMMIT TRAN

GO
