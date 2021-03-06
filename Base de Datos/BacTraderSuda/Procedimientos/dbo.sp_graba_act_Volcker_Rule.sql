USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_graba_act_Volcker_Rule]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_graba_act_Volcker_Rule]
(				 @numeroOper	NUMERIC(10)
				,@correlativo	NUMERIC(2)
				,@Volcker_Rule  NUMERIC(1)
				)
AS
BEGIN

/* LD1-COR-035 FUSION CORPBANCA - ITAU -->ACTUALIZACION CARTERA VOLCKER RULE **/
/***********************************************************************/
/*SISTEMA: BACTRADERSUDA */ 

SET NOCOUNT ON


	UPDATE MDMO
	SET volcker_rule = @Volcker_Rule
	WHERE monumdocu = @numeroOper
		AND mocorrela = @correlativo
	 
	--UPDATE MOVIMIENTO_ORIGINAL
	--SET volcker_rule = @Volcker_Rule
	--WHERE monumdocu = @numeroOper
	--	AND mocorrela = @correlativo

	 
	UPDATE MDCP
	SET volcker_rule = @Volcker_Rule
	WHERE cpnumdocu = @numeroOper
		AND cpcorrela = @correlativo
	 
	UPDATE MDMH
	SET volcker_rule = @Volcker_Rule
	WHERE monumdocu = @numeroOper
		AND mocorrela = @correlativo

	 
END



-- Base de Datos --
GO
