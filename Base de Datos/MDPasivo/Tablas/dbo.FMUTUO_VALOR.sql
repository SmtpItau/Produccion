USE [MDPasivo]
GO
/****** Object:  Table [dbo].[FMUTUO_VALOR]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FMUTUO_VALOR](
	[Serie] [char](12) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Valor] [numeric](19, 6) NULL,
	[Patrimonio] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
