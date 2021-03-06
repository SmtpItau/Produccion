USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CarteraCorregida]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarteraCorregida](
	[rsfecha] [datetime] NOT NULL,
	[rscartera] [char](3) NOT NULL,
	[rsnumoper] [numeric](10, 0) NOT NULL,
	[rsfecctb] [datetime] NOT NULL,
	[rsnumdocu] [numeric](10, 0) NOT NULL,
	[rscorrela] [numeric](3, 0) NOT NULL,
	[rsnominal] [numeric](19, 4) NOT NULL,
	[rstipoper] [char](3) NOT NULL,
	[rsinteres] [numeric](19, 4) NOT NULL,
	[rsreajuste] [numeric](19, 4) NOT NULL,
	[rsvppresen] [numeric](19, 4) NOT NULL,
	[rsvppresenx] [numeric](19, 4) NOT NULL,
	[rstir] [numeric](9, 4) NOT NULL,
	[serie] [char](10) NOT NULL,
	[rsvalcomp] [numeric](19, 4) NOT NULL,
	[cpvalcomp] [float] NULL,
	[rsvalcomu] [numeric](19, 4) NOT NULL,
	[cpvalcomu] [float] NULL,
	[RsInt_Originales] [numeric](19, 4) NOT NULL,
	[RsRea_Originales] [numeric](19, 4) NOT NULL,
	[cpvptirc] [float] NULL,
	[ValorAnterior] [float] NULL,
	[rsmonemi] [numeric](3, 0) NOT NULL,
	[rsfecemis] [datetime] NOT NULL,
	[rsfecvcto] [datetime] NOT NULL,
	[Rsfeccomp] [datetime] NULL,
	[Rsvalcomp_ori] [numeric](19, 4) NOT NULL,
	[iRegistro] [bigint] NULL
) ON [PRIMARY]
GO
