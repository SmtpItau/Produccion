USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PERIODO_TASA_BIDASK]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERIODO_TASA_BIDASK](
	[pecodigo] [numeric](3, 0) NOT NULL,
	[peperiodo] [char](6) NOT NULL,
	[penumero] [numeric](4, 0) NOT NULL,
	[petipo] [char](1) NOT NULL,
	[peglosa] [char](15) NOT NULL
) ON [PRIMARY]
GO
