USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[tmp_chkinstser_regulariza]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_chkinstser_regulariza](
	[Error] [int] NULL,
	[Mascara] [varchar](12) NULL,
	[Codigo] [int] NULL,
	[Serie] [varchar](12) NULL,
	[RutEmis] [numeric](9, 0) NULL,
	[Monemi] [int] NULL,
	[TasEmi] [float] NULL,
	[BasEmi] [numeric](3, 0) NULL,
	[FecEmi] [datetime] NULL,
	[FecVen] [datetime] NULL,
	[RefNomi] [char](1) NULL,
	[Genemi] [char](10) NULL,
	[NemMon] [char](5) NULL,
	[Corte] [numeric](19, 4) NULL,
	[Seriado] [char](1) NULL,
	[lesemi] [char](6) NULL,
	[FecPro] [char](10) NULL
) ON [PRIMARY]
GO
