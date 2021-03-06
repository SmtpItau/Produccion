USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_UDP_TURING_FLAG2]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_UDP_TURING_FLAG2]
    (    @nContador				INT
    ,    @ProcessDate				DATETIME
    ,    @a01_Contract_Flag			INT
    ,    @a02_OperationNumber			NUMERIC(10)
    ,    @a03_OperationID			INT	
    ,    @a04_ContractTerm			INT
    ,    @a05_OperationType			CHAR(01)
    ,    @a06_PaymentType			CHAR(01)	
    ,    @a07_ExpiryDate			DATETIME
    ,    @a08_EffectiveDate			DATETIME
    ,    @a09_PrimaryCurrency			INT
    ,    @a10_aSecondaryCurrency		INT
    ,    @a11_AmountPrimaryCurrency		FLOAT
    ,    @a12_ExchangeRate			FLOAT
    ,    @a13_ExchangeRateCost			FLOAT
    ,    @a14_ExchangeRatePoint			FLOAT
    ,    @a15_AmountSecondaryCurrency		FLOAT
    ,    @a16_Spread				FLOAT
    ,    @a17_RatePrimary			FLOAT
    ,    @a18_RateSecondary			FLOAT
    ,    @a19_PriceProjected			FLOAT
    ,    @a20_FairValueAsset			FLOAT
    ,    @a21_FairValueLiabilities		FLOAT
    ,    @a22_FairValueNet			FLOAT
    ,    @a23_PurchaseDate			DATETIME
    ,    @a24_UnWind				CHAR(10)
    ,    @a25_ValuatorFairValueAsset		FLOAT
    ,    @a26_ValuatorFairValueAssetUM		FLOAT
    ,    @a27_ValuatorFairValueLiabilities	FLOAT
    ,    @a28_ValuatorFairValueLiabilitiesUM	FLOAT
    ,    @a29_ValuatorFairValueNet		FLOAT
    ,    @a30_ValuatorFairValueNetUM		FLOAT
    ,    @a31_ValuatorFairValueNetCost		FLOAT
    ,    @a32_ValuatorTerm			FLOAT
    ,    @a33_ValuatorPrimaryCurrencyRate	FLOAT
    ,    @a34_ValuatorSecondaryCurrencyRate	FLOAT
    ,    @a35_ValuatorForwardPriceTheory	FLOAT
    ,    @a36_MacaulayDuration			FLOAT
    ,    @a37_ModifiedDuration			FLOAT
    ,    @a38_Convexity				FLOAT
    ,    @a39_PriceForwardTheory		FLOAT
    ,    @a40_RateForwardTheory			FLOAT	
    ,    @a41_CashFlow				FLOAT
    ,    @a42_ResultDistribution		FLOAT
    ,    @a43_TransferDistribution		FLOAT
    ,    @a44_MarktoMarketEfectRate		FLOAT
    ,    @a45_MarktoMarketRateAdjustment	FLOAT
    ,    @a46_PointForward			FLOAT
    ,    @a47_RateUSD				FLOAT
    ,    @a48_RateCLP				FLOAT
    ,    @a49_TAB30Days				FLOAT
    ,    @a50_CarryRateUSD			FLOAT
    ,    @a51_CarryCostValue			FLOAT
    ,    @a52_YieldPrimary			CHAR(20)
    ,    @a53_YieldSecondary			CHAR(20) )

AS
BEGIN

   SET NOCOUNT ON

   IF @nContador = 1   TRUNCATE TABLE TBLWEB_TURING_FLOWS

	INSERT INTO 
    TBLWEB_TURING_FLOWS(
         ProcessDate			
    ,    Contract_Flag			
    ,    OperationNumber		
    ,    OperationID			
    ,    ContractTerm			
    ,    OperationType			
    ,    PaymentType			
    ,    ExpiryDate			
    ,    EffectiveDate			
    ,    PrimaryCurrency		
    ,    aSecondaryCurrency		
    ,    AmountPrimaryCurrency		
    ,    ExchangeRate			
    ,    ExchangeRateCost		
    ,    ExchangeRatePoint		
    ,    AmountSecondaryCurrency	
    ,    Spread				
    ,    RatePrimary			
    ,    RateSecondary			
    ,    PriceProjected			
    ,    FairValueAsset			
    ,    FairValueLiabilities		
    ,    FairValueNet			
    ,    PurchaseDate			
    ,    UnWind				
    ,    ValuatorFairValueAsset		
    ,    ValuatorFairValueAssetUM	
    ,    ValuatorFairValueLiabilities	
    ,    ValuatorFairValueLiabilitiesUM	
    ,    ValuatorFairValueNet		
    ,    ValuatorFairValueNetUM		
    ,    ValuatorFairValueNetCost	
    ,    ValuatorTerm			
    ,    ValuatorPrimaryCurrencyRate	
    ,    ValuatorSecondaryCurrencyRate	
    ,    ValuatorForwardPriceTheory	
    ,    MacaulayDuration		
    ,    ModifiedDuration		
    ,    Convexity			
    ,    PriceForwardTheory		
    ,    RateForwardTheory		
    ,    CashFlow			
    ,    ResultDistribution		
    ,    TransferDistribution		
    ,    MarktoMarketEfectRate		
    ,    MarktoMarketRateAdjustment	
    ,    PointForward			
    ,    RateUSD			
    ,    RateCLP			
    ,    TAB30Days			
    ,    CarryRateUSD			
    ,    CarryCostValue			
    ,    YieldPrimary			
    ,    YieldSecondary			
    )
   VALUES(
         @ProcessDate				
    ,    @a01_Contract_Flag			
    ,    @a02_OperationNumber			
    ,    @a03_OperationID			
    ,    @a04_ContractTerm			
    ,    @a05_OperationType			
    ,    @a06_PaymentType			
    ,    @a07_ExpiryDate			
    ,    @a08_EffectiveDate			
    ,    @a09_PrimaryCurrency			
    ,    @a10_aSecondaryCurrency		
    ,    @a11_AmountPrimaryCurrency		
    ,    @a12_ExchangeRate			
    ,    @a13_ExchangeRateCost			
    ,    @a14_ExchangeRatePoint			
    ,    @a15_AmountSecondaryCurrency		
    ,    @a16_Spread				
    ,    @a17_RatePrimary			
    ,    @a18_RateSecondary			
    ,    @a19_PriceProjected			
    ,    @a20_FairValueAsset			
    ,    @a21_FairValueLiabilities		
    ,    @a22_FairValueNet			
    ,    @a23_PurchaseDate		
    ,    @a24_UnWind			
    ,    @a25_ValuatorFairValueAsset	
    ,    @a26_ValuatorFairValueAssetUM	
    ,    @a27_ValuatorFairValueLiabilities	
    ,    @a28_ValuatorFairValueLiabilitiesUM
    ,    @a29_ValuatorFairValueNet		
    ,    @a30_ValuatorFairValueNetUM		
    ,    @a31_ValuatorFairValueNetCost		
    ,    @a32_ValuatorTerm			
    ,    @a33_ValuatorPrimaryCurrencyRate	
    ,    @a34_ValuatorSecondaryCurrencyRate	
    ,    @a35_ValuatorForwardPriceTheory	
    ,    @a36_MacaulayDuration			
    ,    @a37_ModifiedDuration			
    ,    @a38_Convexity				
    ,    @a39_PriceForwardTheory		
    ,    @a40_RateForwardTheory			
    ,    @a41_CashFlow				
    ,    @a42_ResultDistribution		
    ,    @a43_TransferDistribution		
    ,    @a44_MarktoMarketEfectRate		
    ,    @a45_MarktoMarketRateAdjustment	
    ,    @a46_PointForward			
    ,    @a47_RateUSD				
    ,    @a48_RateCLP				
    ,    @a49_TAB30Days				
    ,    @a50_CarryRateUSD			
    ,    @a51_CarryCostValue			
    ,    @a52_YieldPrimary			
    ,    @a53_YieldSecondary			
    )


END

GO
