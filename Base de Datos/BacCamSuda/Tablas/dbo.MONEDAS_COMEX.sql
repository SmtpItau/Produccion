USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MONEDAS_COMEX]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONEDAS_COMEX](
	[mpUnegocio] [char](3) NOT NULL,
	[mpproducto] [char](5) NOT NULL,
	[mpcodmon] [numeric](5, 0) NOT NULL,
	[mpestado] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MONEDAS_COMEX] ADD  CONSTRAINT [df_MONEDAS_COMEX_mpUnegocio]  DEFAULT ('') FOR [mpUnegocio]
GO
ALTER TABLE [dbo].[MONEDAS_COMEX] ADD  CONSTRAINT [df_MONEDAS_COMEX_mpproducto]  DEFAULT ('') FOR [mpproducto]
GO
ALTER TABLE [dbo].[MONEDAS_COMEX] ADD  CONSTRAINT [df_MONEDAS_COMEX_mpcodmon]  DEFAULT ((0)) FOR [mpcodmon]
GO
ALTER TABLE [dbo].[MONEDAS_COMEX] ADD  CONSTRAINT [df_MONEDAS_COMEX_mpestado]  DEFAULT ('') FOR [mpestado]
GO
