USE [MDPasivo]
GO
/****** Object:  Table [dbo].[MONEDA_FORMA_DE_PAGO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONEDA_FORMA_DE_PAGO](
	[mfcodmon] [numeric](5, 0) NOT NULL,
	[mfcodfor] [numeric](5, 0) NOT NULL,
	[mfmonpag] [numeric](5, 0) NOT NULL,
	[mfsistema] [char](3) NOT NULL,
	[mfestado] [char](1) NOT NULL
) ON [PRIMARY]
GO
