USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_UDP_TURING_FLAG1]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_UDP_TURING_FLAG1]
   (   @ITag                               INT
   ,   @ProcessDate                        DATETIME
   ,   @OperationNumber                    NUMERIC(10)
   ,   @ProductType                        INT
   ,   @CustomerId                         NUMERIC(10)
   ,   @CustomerCode                       CHAR(1)
   ,   @BookId                             INT
   ,   @PortfolioRulesId                   CHAR(1)
   ,   @FinancialPortFolioId               INT
   ,   @OperationType                      CHAR(1)
   ,   @PaymentType                        CHAR(1)
   ,   @PrimaryCurrency                    INT
   ,   @SecondaryCurrency                  INT
   ,   @ExchangeRate                       FLOAT
   ,   @ExchangeRatePoint                  FLOAT
   ,   @ExchangeRateCost                   FLOAT
   ,   @ExchangeRateExpiry                 FLOAT
   ,   @AmountPrimaryCurrency              FLOAT
   ,   @AmountSecondaryCurrency            FLOAT
   ,   @ExpiryDay                          DATETIME
   ,   @EffectuveDay                       DATETIME
   ,   @ContractTem                        NUMERIC(5)
   ,   @MaturityDeadLine                   NUMERIC(5)
   ,   @AfterDeadLine                      NUMERIC(5)
   ,   @PrimaryCurrencyRate                FLOAT
   ,   @SecondaryCurrencyRate              FLOAT
   ,   @FairValuesAsset                    NUMERIC(21,0)
   ,   @FairValuesLiabilities              NUMERIC(21,0)
   ,   @MNemonicsCode                      INT
   ,   @MNemonicsMask                      CHAR(15)
   ,   @MNemonics                          CHAR(15)
   ,   @IssueCode                          CHAR(5)
   ,   @PuchaseDate                        DATETIME
   ,   @DevelonmentTable                   VARCHAR(50)
   ,   @AdvancePointCost                   FLOAT
   ,   @AdvancePointForward                FLOAT
   ,   @DO                                 FLOAT
   ,   @UF                                 FLOAT
   ,   @RateDistribution                   FLOAT
   ,   @UnWind                             CHAR(1)
   ,   @ValuatorFairValuesAsset            FLOAT
   ,   @ValuatorFairValuesAssetUM          FLOAT
   ,   @ValuatorFairValuesLiabilities      FLOAT
   ,   @ValuatorFairValuesLiabilitiesUM    FLOAT
   ,   @ValuatorFairValuesNet              FLOAT
   ,   @ValuatorFairValuesNetUM            FLOAT
   ,   @ValuatorFairValuesNetCost          FLOAT
   ,   @ValuatorTerm                       FLOAT
   ,   @ValuatorPrimaryCurrencyRate        FLOAT
   ,   @ValuatorSecondaryCurrencyRate      FLOAT
   ,   @ValuatorForwardPriceTheory         FLOAT
   ,   @MacaulayDuration                   FLOAT
   ,   @ModifiedDuration                   FLOAT
   ,   @Convexity                          FLOAT
   ,   @PriceForwardTheory                 FLOAT
   ,   @RateForwardTheory                  FLOAT
   ,   @CashFlow                           FLOAT
   ,   @ResultDistribution                 FLOAT
   ,   @TransferDistribution               FLOAT
   ,   @MarkToMarketEfectrate              FLOAT
   ,   @MarkToMarketRateAdjusntmente       FLOAT
   ,   @PointForward                       FLOAT
   ,   @RateUSD                            FLOAT
   ,   @RateCLP                            FLOAT
   ,   @TAB30Day                           FLOAT
   ,   @CarryRateUSD                       FLOAT
   ,   @CarryCostValue                     FLOAT
   ,   @YieldPrimery                       CHAR(15)
   ,   @YieldSecondary                     CHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @ITag = 1 
   BEGIN
      TRUNCATE TABLE TBLWEB_TURING_CONTRACT
   END

   INSERT INTO TBLWEB_TURING_CONTRACT
   (      ProcessDate
   ,      OperationNumber
   ,      ProductType
   ,      CustomerId
   ,      CustomerCode
   ,      BookId
   ,      PortfolioRulesId
   ,      FinancialPortFolioId
   ,      OperationType
   ,      PaymentType
   ,      PrimaryCurrency
   ,      SecondaryCurrency
   ,      ExchangeRate
   ,      ExchangeRatePoint
   ,      ExchangeRateCost
   ,      ExchangeRateExpiry
   ,      AmountPrimaryCurrency
   ,      AmountSecondaryCurrency
   ,      ExpiryDay
   ,      EffectuveDay
   ,      ContractTem
   ,      MaturityDeadLine
   ,      AfterDeadLine
   ,      PrimaryCurrencyRate
   ,      SecondaryCurrencyRate
   ,      FairValuesAsset
   ,      FairValuesLiabilities
   ,      MNemonicsCode
   ,      MNemonicsMask
   ,      MNemonics
   ,      IssueCode
   ,      PuchaseDate
   ,      DevelonmentTable
   ,      AdvancePointCost
   ,      AdvancePointForward
   ,      DO
   ,      UF
   ,      RateDistribution
   ,      UnWind
   ,      ValuatorFairValuesAsset
   ,      ValuatorFairValuesAssetUM
   ,      ValuatorFairValuesLiabilities
   ,      ValuatorFairValuesLiabilitiesUM
   ,      ValuatorFairValuesNet
   ,      ValuatorFairValuesNetUM
   ,      ValuatorFairValuesNetCost
   ,      ValuatorTerm
   ,      ValuatorPrimaryCurrencyRate
   ,      ValuatorSecondaryCurrencyRate
   ,      ValuatorForwardPriceTheory
   ,      MacaulayDuration
   ,      ModifiedDuration
   ,      Convexity
   ,      PriceForwardTheory
   ,      RateForwardTheory
   ,      CashFlow
   ,      ResultDistribution
   ,      TransferDistribution
   ,      MarkToMarketEfectrate
   ,      MarkToMarketRateAdjusntmente
   ,      PointForward
   ,      RateUSD
   ,      RateCLP
   ,      TAB30Day
   ,      CarryRateUSD
   ,      CarryCostValue
   ,      YieldPrimery
   ,      YieldSecondary
   )
   VALUES
   (      @ProcessDate
   ,      @OperationNumber
   ,      @ProductType
   ,      @CustomerId
   ,      @CustomerCode
   ,      @BookId
   ,      @PortfolioRulesId
   ,      @FinancialPortFolioId
   ,      @OperationType
   ,      @PaymentType
   ,      @PrimaryCurrency
   ,      @SecondaryCurrency
   ,      @ExchangeRate
   ,      @ExchangeRatePoint
   ,      @ExchangeRateCost
   ,      @ExchangeRateExpiry
   ,      @AmountPrimaryCurrency
   ,      @AmountSecondaryCurrency
   ,      @ExpiryDay
   ,      @EffectuveDay
   ,      @ContractTem
   ,      @MaturityDeadLine
   ,      @AfterDeadLine
   ,      @PrimaryCurrencyRate
   ,      @SecondaryCurrencyRate
   ,      @FairValuesAsset
   ,      @FairValuesLiabilities
   ,      @MNemonicsCode
   ,      @MNemonicsMask
   ,      @MNemonics
   ,      @IssueCode
   ,      @PuchaseDate
   ,      @DevelonmentTable
   ,      @AdvancePointCost
   ,      @AdvancePointForward
   ,      @DO
   ,      @UF
   ,      @RateDistribution
   ,      @UnWind
   ,      @ValuatorFairValuesAsset
   ,      @ValuatorFairValuesAssetUM
   ,      @ValuatorFairValuesLiabilities
   ,      @ValuatorFairValuesLiabilitiesUM
   ,      @ValuatorFairValuesNet
   ,      @ValuatorFairValuesNetUM
   ,      @ValuatorFairValuesNetCost
   ,      @ValuatorTerm
   ,      @ValuatorPrimaryCurrencyRate
   ,      @ValuatorSecondaryCurrencyRate
   ,      @ValuatorForwardPriceTheory
   ,      @MacaulayDuration
   ,      @ModifiedDuration
   ,      @Convexity
   ,      @PriceForwardTheory
   ,      @RateForwardTheory
   ,      @CashFlow
   ,      @ResultDistribution
   ,      @TransferDistribution
   ,      @MarkToMarketEfectrate
   ,      @MarkToMarketRateAdjusntmente
   ,      @PointForward
   ,      @RateUSD
   ,      @RateCLP
   ,      @TAB30Day
   ,      @CarryRateUSD
   ,      @CarryCostValue
   ,      @YieldPrimery
   ,      @YieldSecondary
   )

END

GO
