USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[SINACOFI]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SINACOFI](
	[clrut] [numeric](9, 0) NOT NULL,
	[clcodigo] [numeric](9, 0) NOT NULL,
	[clnumsinacofi] [char](4) NOT NULL,
	[clnomsinacofi] [char](10) NOT NULL,
	[datatec] [char](30) NOT NULL,
	[bolsa] [char](10) NOT NULL,
	[cuenta_DCV] [char](8) NOT NULL,
	[nombre_cliente_datatec] [char](30) NOT NULL
) ON [PRIMARY]
GO
