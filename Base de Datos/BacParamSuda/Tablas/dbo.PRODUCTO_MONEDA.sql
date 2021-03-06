USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PRODUCTO_MONEDA]    Script Date: 13-05-2022 10:58:10 ******/
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
	[mpmoneda] [numeric](3, 0) NULL,
 CONSTRAINT [PK__PRODUCTO_MONEDA__68C86C1B] PRIMARY KEY CLUSTERED 
(
	[mpsistema] ASC,
	[mpproducto] ASC,
	[mpcodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PRODUCTO_MONEDA] ADD  CONSTRAINT [DF__PRODUCTO___Mpest__4A10717F]  DEFAULT ('') FOR [mpestado]
GO
ALTER TABLE [dbo].[PRODUCTO_MONEDA] ADD  CONSTRAINT [DF__PRODUCTO___Mptip__4B0495B8]  DEFAULT ('') FOR [mptipoper]
GO
ALTER TABLE [dbo].[PRODUCTO_MONEDA] ADD  CONSTRAINT [DF__PRODUCTO___Mpmon__4BF8B9F1]  DEFAULT (0) FOR [mpmoneda]
GO
