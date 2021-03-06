USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_UDP_CARTERA_VS_TURING]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

--sp_helptext  sp_udp_cartera_vs_turing

CREATE PROCEDURE [dbo].[SP_UDP_CARTERA_VS_TURING]
AS BEGIN

return
	BEGIN TRANSACTION udpct

	UPDATE   mfca
	   SET  ValorRazonableActivo	= b.ValuatorFairValuesAsset	   
		,ValorRazonablePasivo	= b.ValuatorFairValuesLiabilities  
		,fVal_Obtenido		= b.PriceForwardTheory		
		,fRes_Obtenido		= b.ValuatorFairValuesNet		
		,CaTasaSinteticaM1	= b.PrimaryCurrencyRate		
		,CaTasaSinteticaM2	= b.SecondaryCurrencyRate	
		,CaPrecioSpotVentaM1	= b.PriceForwardTheory		
		,catasadolar		= b.rateUSD
		,catasaufclp		= b.rateCLP
		,CaPrecioSpotCompraM1	= b.PriceForwardTheory		
	  FROM 	mfca a
    INNER JOIN	tblweb_turing_contract b
	    ON  b.operationnumber = a.canumoper
	   AND	a.cacodpos1= b.producttype

	IF @@ERROR <> 0  GOTO ERR_Actualizacion

	UPDATE	TBL_CARTERA_FLUJOS						
	   SET	Ctf_Valor_Razonable_Activo	= b.ValuatorFairValueAsset
	,	Ctf_Valor_Razonable_Pasivo	= b.ValuatorFairValueLiabilities
	  FROM 	tbl_cartera_flujos a
    INNER JOIN	tblweb_turing_flows b
	    ON  b.operationnumber = a.Ctf_Numero_OPeracion
	   AND  B.OperationID     = a.Ctf_Correlativo

	IF @@ERROR <> 0  GOTO ERR_Actualizacion

	If @@TRANCOUNT>0  COMMIT TRANSACTION udpct
	SELECT 'OK'
	RETURN 0

ERR_Actualizacion:	
	If @@TRANCOUNT>0 ROLLBACK TRANSACTION udpct
	SELECT -1,'Error: Actualizando tabla de cartera con datos del Web Services'
	RETURN -1

END



GO
