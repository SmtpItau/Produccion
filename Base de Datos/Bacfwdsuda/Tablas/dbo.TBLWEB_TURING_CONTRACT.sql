USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[TBLWEB_TURING_CONTRACT]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBLWEB_TURING_CONTRACT](
	[ProcessDate] [datetime] NULL,
	[OperationNumber] [numeric](10, 0) NULL,
	[ProductType] [int] NULL,
	[CustomerId] [numeric](10, 0) NULL,
	[CustomerCode] [char](1) NULL,
	[BookId] [int] NULL,
	[PortfolioRulesId] [char](1) NULL,
	[FinancialPortFolioId] [int] NULL,
	[OperationType] [char](1) NULL,
	[PaymentType] [char](1) NULL,
	[PrimaryCurrency] [int] NULL,
	[SecondaryCurrency] [int] NULL,
	[ExchangeRate] [float] NULL,
	[ExchangeRatePoint] [float] NULL,
	[ExchangeRateCost] [float] NULL,
	[ExchangeRateExpiry] [float] NULL,
	[AmountPrimaryCurrency] [float] NULL,
	[AmountSecondaryCurrency] [float] NULL,
	[ExpiryDay] [datetime] NULL,
	[EffectuveDay] [datetime] NULL,
	[ContractTem] [numeric](5, 0) NULL,
	[MaturityDeadLine] [numeric](5, 0) NULL,
	[AfterDeadLine] [numeric](5, 0) NULL,
	[PrimaryCurrencyRate] [float] NULL,
	[SecondaryCurrencyRate] [float] NULL,
	[FairValuesAsset] [numeric](21, 0) NULL,
	[FairValuesLiabilities] [numeric](21, 0) NULL,
	[MNemonicsCode] [int] NULL,
	[MNemonicsMask] [char](15) NULL,
	[MNemonics] [char](15) NULL,
	[IssueCode] [char](5) NULL,
	[PuchaseDate] [datetime] NULL,
	[DevelonmentTable] [varchar](50) NULL,
	[AdvancePointCost] [float] NULL,
	[AdvancePointForward] [float] NULL,
	[DO] [float] NULL,
	[UF] [float] NULL,
	[RateDistribution] [float] NULL,
	[UnWind] [char](1) NULL,
	[ValuatorFairValuesAsset] [float] NULL,
	[ValuatorFairValuesAssetUM] [float] NULL,
	[ValuatorFairValuesLiabilities] [float] NULL,
	[ValuatorFairValuesLiabilitiesUM] [float] NULL,
	[ValuatorFairValuesNet] [float] NULL,
	[ValuatorFairValuesNetUM] [float] NULL,
	[ValuatorFairValuesNetCost] [float] NULL,
	[ValuatorTerm] [float] NULL,
	[ValuatorPrimaryCurrencyRate] [float] NULL,
	[ValuatorSecondaryCurrencyRate] [float] NULL,
	[ValuatorForwardPriceTheory] [float] NULL,
	[MacaulayDuration] [float] NULL,
	[ModifiedDuration] [float] NULL,
	[Convexity] [float] NULL,
	[PriceForwardTheory] [float] NULL,
	[RateForwardTheory] [float] NULL,
	[CashFlow] [float] NULL,
	[ResultDistribution] [float] NULL,
	[TransferDistribution] [float] NULL,
	[MarkToMarketEfectrate] [float] NULL,
	[MarkToMarketRateAdjusntmente] [float] NULL,
	[PointForward] [float] NULL,
	[RateUSD] [float] NULL,
	[RateCLP] [float] NULL,
	[TAB30Day] [float] NULL,
	[CarryRateUSD] [float] NULL,
	[CarryCostValue] [float] NULL,
	[YieldPrimery] [char](15) NULL,
	[YieldSecondary] [char](15) NULL
) ON [PRIMARY]
GO
