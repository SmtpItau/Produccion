USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[RespaldoPrevioActualizacion]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RespaldoPrevioActualizacion](
	[rsfecha] [datetime] NOT NULL,
	[rscartera] [char](3) NOT NULL,
	[rstipoper] [char](3) NOT NULL,
	[rsinstser] [char](10) NOT NULL,
	[rsnominal] [numeric](19, 4) NOT NULL,
	[rstir] [numeric](9, 4) NOT NULL,
	[rsvalcomp] [numeric](19, 4) NOT NULL,
	[NewValComp] [float] NULL,
	[rsvalcomu] [numeric](19, 4) NOT NULL,
	[NewValComu] [float] NULL,
	[rsvppresen] [numeric](19, 4) NOT NULL,
	[Newvpressen] [float] NULL,
	[rsvppresenx] [numeric](19, 4) NOT NULL,
	[Newvpressenx] [float] NULL,
	[rsinteres] [numeric](19, 4) NOT NULL,
	[NewInteres] [float] NULL,
	[rsinteres_acum] [numeric](19, 4) NOT NULL,
	[NewInteresAcum] [float] NULL,
	[rsreajuste] [numeric](19, 4) NOT NULL,
	[NewReajuste] [float] NULL,
	[rsreajuste_acum] [numeric](19, 4) NOT NULL,
	[NewReajusteAcum] [float] NULL
) ON [PRIMARY]
GO
