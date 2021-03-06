USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Graba_Serie]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Graba_Serie]
    (@xCodigo  		NUMERIC(3)	,--1
     @xMascara  	CHAR(12) 	,--2
     @xSerie  		CHAR(12) 	,--3
     @xTera  		NUMERIC(9,4) 	,--4
     @xMonemi  		NUMERIC(3) 	,--5
     @xBasemi  		NUMERIC(3) 	,--6
     @xRutemi  		NUMERIC(9) 	,--7
     @xFecemi  		CHAR(10) 	,--8
     @xFecven  		CHAR(10) 	,--9
     @xPlazo  		NUMERIC(6,2) 	,--10 MOD. PLAZOS CON DECIMALES - ERBAQ: 20041001
     @xTasemi  		NUMERIC(9,4) 	,--11
     @xCupones  	NUMERIC(3) 	,--12
     @xTipvcup  	CHAR(1)  	,--13
     @xPervcup  	NUMERIC(2) 	,--14
     @xNumAmort 	NUMERIC(3) 	,--15
     @xDecs  		NUMERIC(2) 	,--16
     @xDiavcup  	NUMERIC(2) 	,--17
     @xffijos  		CHAR(1)  	,--18
     @xBascup  		NUMERIC(7,1) 	,--19
     @xCorte  		NUMERIC(19,4) 	,--20
     @xTipoAmort  	NUMERIC(1) 	,--21
     @xTotalEmitido	FLOAT 		,--22
     @xtipo_letra	CHAR(1) 	,--23
     @xFecPriVcto	CHAR(10) 	,--24
     @cSpreadTasa	CHAR(1)		,--25
     @cControlAmortiza  CHAR(1) = 'N'	
	)

AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT dmy

	  

	IF EXISTS(SELECT * FROM SERIE WHERE seserie = @xMascara) BEGIN

		IF EXISTS(SELECT 1 FROM VIEW_CARTERA_VENTA_PACTO 
				   WHERE viinstser = @xMascara 
				   AND  CONVERT(DATETIME,@xfecven) < vifecvenp ) BEGIN
		
			SELECT 'NO','Existen Pactos asociados que tienen plazo mayor a la fecha de Vcto'	
			RETURN

		END 
		IF EXISTS(SELECT 1 FROM VIEW_CARTERA_PROPIA
				   WHERE cpinstser = @xMascara 
				   AND CONVERT(DATETIME,@xFecemi) > cpfeccomp) BEGIN
		
			SELECT 'NO','Existen Compras con Fecha de  menor a la Fecha de Emision'	
			RETURN
		END 		

		IF EXISTS(SELECT 1 FROM VIEW_CARTERA_COMPRA_PACTO
				   WHERE ciinstser = @xMascara 
				   AND CONVERT(DATETIME,@xFecemi) > cifecinip) BEGIN
		
			SELECT 'NO','Existen Pactos con Fecha de compra menor a la Fecha de Emision'	
			RETURN
		END 	
	   
		UPDATE SERIE SET  
		serutemi	= @xRutemi	,
		sefecemi	= @xFecemi  	,
		sefecven	= @xFecVen  	,
		setasemi 	= @xTasemi  	,
		setera  	= @xTera    	,
		sebasemi 	= @xBasemi  	,
		semonemi 	= @xMonemi  	,
		secupones 	= @xCupones 	,
		sediavcup 	= @xDiavcup 	,
		sepervcup 	= @xPervcup 	,
		setipvcup 	= @xTipvcup 	,
		seplazo  	= @xPlazo   	,
		setipamort 	= @xTipoAmort	,
		senumamort 	= @xNumAmort	,
		seffijos 	= @xffijos  	,
		sebascup 	= @xBascup  	,
		sedecs  	= @xDecs    	,
		secorte  	= @xCorte   	,
		setotalemitido  = @xTotalEmitido,
		tipo_letra 	= @xtipo_letra 	,
		primer_vencimiento = @xFecPriVcto ,
		spread_tasa	= @cSpreadTasa	,		
		control_Amortizacion = @cControlAmortiza
		WHERE seserie  = @xMascara


		UPDATE VIEW_CARTERA_PROPIA SET	cpfecemi = @xfecemi,
						cpfecven = @xfecven
		WHERE cpmascara = @xMascara
		AND   cpcodigo <> 20
/*
		UPDATE VIEW_MOVIMIENTO_TRADER SET mofecemi = @xfecemi,
						  mofecven = @xfecven,
						  momonemi = @xmonemi,
						  motasemi = @xtasemi,	
						  mobasemi = @xbasemi,
						  morutemi = @xrutemi					
		WHERE moinstser = @xMascara 
	*/

		UPDATE VIEW_CARTERA_DISPONIBLE SET digenemi = emgeneric,
	 		  	 	           dinemmon = mnnemo,
	 				           difecsal = @xfecven,
					           dibase   = @xbasemi,
					           dimoneda = @xmonemi
		 FROM EMISOR,MONEDA,SERIE,VIEW_CARTERA_PROPIA
		 WHERE cpmascara = semascara
		 AND   emrut     = serutemi
		 AND   mncodmon  = semonemi
		 AND   cpnumdocu  = dinumdocu
		 AND   cpcorrela  = dicorrela
	  	 AND   secodigo  <> 20
		 AND   cpmascara = @xMascara
			
	
		UPDATE VIEW_CARTERA_DISPONIBLE SET digenemi = emgeneric,
			  	   	      dinemmon = mnnemo,
	 				      difecsal = @xfecven,
					      dibase   = @xbasemi,
					      dimoneda = @xmonemi
		 FROM EMISOR,MONEDA,SERIE,VIEW_CARTERA_COMPRA_PACTO
		 WHERE cimascara = semascara
		 AND   emrut     = serutemi
		 AND   mncodmon  = semonemi
		 AND   cinumdocu  = dinumdocu
		 AND   cicorrela  = dicorrela
	  	 AND   secodigo  <> 20
		 AND   cimascara = @xMascara

		 UPDATE VIEW_CARTERA_VENTA_PACTO SET virutemi = @xrutemi,
						     vimonemi = @xmonemi,
						     vifecemi = @xfecemi,
						     vifecven = @xfecven 
		 WHERE vimascara = @xMascara
		 AND   vicodigo  <> 20	 
		 
		
 		 UPDATE VIEW_CARTERA_COMPRA_PACTO SET cifecemi = @xfecemi,
						      cifecven = @xfecven,
						      cirutemi = @xrutemi,
						      cimonemi = @xmonemi
		 WHERE cimascara = @xMascara
		 AND   cicodigo  <> 20
		

	END ELSE
	INSERT INTO SERIE(  secodigo  ,
		semascara  	,
		seserie   	,
		serutemi  	,
		sefecemi  	,
		sefecven  	,
		setasemi  	,
		setera   	,
		sebasemi  	,
		semonemi  	,
		secupones  	,	
		sediavcup  	,
		sepervcup  	,
		setipvcup  	,
		seplazo   	,
		setipamort  	,
		senumamort  	,
		seffijos   	,
		sebascup  	,
		sedecs   	,
		secorte       	,
		setotalemitido	,
		tipo_letra 	,
		primer_vencimiento,
		spread_tasa 	,
		control_amortizacion)
	VALUES(  @xCodigo  	,
		@xMascara  	,
		@xSerie   	,
		@xRutemi  	,
		@xFecemi  	,
		@xFecVen  	,
		@xTasemi  	,
		@xTera   	,
		@xBasemi  	,
		@xMonemi  	,
		@xCupones  	,
		@xDiavcup  	,
		@xPervcup  	,
		@xTipvcup  	,
		@xPlazo         ,
		@xTipoAmort  	,
		@xNumAmort  	,
		@xffijos  	,
		@xBascup  	,
		@xDecs          ,
		@xCorte         ,
		@xTotalEmitido	,
		@xtipo_letra	,
		@xFecPriVcto	,
		@CSpreadTasa	,
		@cControlAmortiza)

	IF @@error <> 0 BEGIN
	   SELECT "NO", "Error al Insertar Datos"
	   RETURN
	END

SELECT "SI"
SET NOCOUNT OFF
END

GO
