USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_RPT_MIDDLED_OFFICE]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_RPT_MIDDLED_OFFICE]
--	(	@Id_Sistema		VARCHAR(3)
--	,	@Rut			NUMERIC(9)=0
--	,	@Codigo			NUMERIC(9)=0
--	,	@Producto		VARCHAR(3)=''
--	)	
AS
BEGIN
	
	SET NOCOUNT ON  
   
	SELECT	MddMod
	,		MddNumOpe
	,		MddSujEarlyTerminationSN
	,		MddSujEarlyTerminationFecha
	,		MddSujEarlyTerminationPeriodo
	,		MddTipPer
	,		MddModRel
	,		MddOpeRel
	,		MddFecVcto   
	FROM	TBL_RIEFIN_DRV_MIDDLE_OFFICE
	UNION
	SELECT	MddMod    = Modulo_Derivado
	,		MddNumOpe = Numero_Derivado
	,		MddSujEarlyTerminationSN = 'NA'
	,		MddSujEarlyTerminationFecha = '19000101'
	,		MddSujEarlyTerminationPeriodo = 0
	,		MddTipPer = 0
	,		MddModRel = 'CRE'
	,		MddOpeRel = Numero_Credito
	,		MddFecVcto = '19000101'
	FROM	BacParamSuda.dbo.RELACION_CREDITO_DERIVADO
		
	SET NOCOUNT OFF  	
END 


--SP_HELP TBL_RIEFIN_DRV_MIDDLE_OFFICE
GO
