USE [MDPasivo]
GO
/****** Object:  Table [dbo].[PRODUCTO_MONEDA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_MONEDA](
	[mpsistema] [char](3) NOT NULL,
	[mpproducto] [char](5) NOT NULL,
	[mpcodigo] [numeric](5, 0) NOT NULL,
	[mpestado] [char](1) NULL,
	[mptipoper] [char](4) NULL,
	[mpmoneda] [numeric](3, 0) NULL
) ON [PRIMARY]
GO
