USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbl_StdChartered_Spot_Fwd]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_StdChartered_Spot_Fwd](
	[Fecha] [datetime] NOT NULL,
	[Source] [varchar](3) NOT NULL,
	[DealType] [tinyint] NOT NULL,
	[PureDealType] [smallint] NOT NULL,
	[SourceReference] [varchar](20) NOT NULL,
	[TransType] [tinyint] NOT NULL,
	[Revision] [tinyint] NOT NULL,
	[TradeID] [varchar](20) NOT NULL,
	[DealerID] [varchar](20) NOT NULL,
	[DateOfDeal] [datetime] NOT NULL,
	[TimeOfDeal] [varchar](8) NOT NULL,
	[BankDealingCode] [varchar](10) NOT NULL,
	[BankName] [varchar](30) NOT NULL,
	[CounterPartyID] [varchar](10) NOT NULL,
	[Currency1] [varchar](3) NOT NULL,
	[Currency2] [varchar](3) NOT NULL,
	[PointsPremiumRate] [numeric](15, 6) NOT NULL,
	[SpotBasicRate] [float] NULL,
	[RateDirection] [tinyint] NOT NULL,
	[ExchangeRatePeriod] [float] NULL,
	[ValueDatePeriodCurrency1] [datetime] NOT NULL,
	[DealVolumePeriod1Currency1] [numeric](21, 4) NOT NULL,
	[DealVolumePeriod1Currency2] [numeric](21, 4) NOT NULL,
	[RateCurrency1AgainstUsd] [numeric](15, 6) NULL,
	[NumOpeMemo] [numeric](15, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[Source] ASC,
	[SourceReference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
