USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINARVA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ELIMINARVA] ( 
				@noperacion 	NUMERIC(10,0), 
				@rutcart 	NUMERIC(09,0),
				@mensaje 	CHAR(255) OUTPUT ) WITH RECOMPILE
AS
BEGIN



	UPDATE	MDMO
	SET	mostatreg = 'A'
	WHERE	monumoper = @noperacion

	IF @@error <> 0 
        BEGIN		
	     	SELECT  @mensaje = 'No se Pudo Anular Operacion'
		RETURN 1
	END				



	INSERT	MDCI
	SELECT  *
	FROM	MDANT_CI
	WHERE	MDANT_CI.cinumdocu = @noperacion

	IF @@error <> 0 
        BEGIN
		SELECT  @mensaje = 'No se Pudo Anular Operacion'
		RETURN 1
	END				



	INSERT	MDCO
	SELECT  *
	FROM	MDANT_CO
	WHERE	MDANT_CO.conumdocu = @noperacion

	IF @@error <> 0 
        BEGIN	
	     	SELECT  @mensaje = 'No se Pudo Anular Operacion'
		RETURN 1
	END				



	INSERT INTO MDDI (dirutcart, ditipcart, dinumdocu, dicorrela, dinumdocuo, dicorrelao, ditipoper, diserie, diinstser, digenemi, dinemmon, dinominal, ditircomp, dipvpcomp, divptirc, dipvpmcd, ditirmcd, divpmcd100, divpmcd, divptirci, difecsal, dinumucup, dicapitalc, diinteresc, direajustc, dicapitaci, diintereci, direajusci, dibase, dimoneda, diintermes, direajumes, codigo_carterasuper, Tipo_Cartera_Financiera, Mercado, Sucursal, Id_Sistema, Fecha_PagoMañana, Laminas, Tipo_Inversion, Estado_Operacion_Linea)
	SELECT            dirutcart, ditipcart, dinumdocu, dicorrela, dinumdocuo, dicorrelao, ditipoper, diserie, diinstser, digenemi, dinemmon, dinominal, ditircomp, dipvpcomp, divptirc, dipvpmcd, ditirmcd, divpmcd100, divpmcd, divptirci, difecsal, dinumucup, dicapitalc, diinteresc, direajustc, dicapitaci, diintereci, direajusci, dibase, dimoneda, diintermes, direajumes, codigo_carterasuper, Tipo_Cartera_Financiera, Mercado, Sucursal, Id_Sistema, Fecha_PagoMañana, Laminas, Tipo_Inversion, Estado_Operacion_Linea
 
	FROM	MDANT_DI
	WHERE	dinumdocu=@noperacion

	IF @@error <> 0 
        BEGIN
	     	SELECT  @mensaje = 'No se Pudo Anular Operacion'
		RETURN 1
	END				



	DELETE mdant_ci where cinumdocu = @noperacion
	DELETE mdant_di where dinumdocu = @noperacion
	DELETE mdant_co where conumdocu = @noperacion


	SELECT @mensaje = 'Operacion Fue Anulada Correctamente'
        RETURN 0


END



GO
