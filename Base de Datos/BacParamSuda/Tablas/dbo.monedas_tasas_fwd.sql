USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[monedas_tasas_fwd]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[monedas_tasas_fwd](
	[codigo] [numeric](5, 0) NULL,
	[nemotecnico] [char](5) NULL,
	[glosa] [char](30) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[monedas_tasas_fwd] ADD  CONSTRAINT [DF__monedas_t__codig__3536E6D8]  DEFAULT (0) FOR [codigo]
GO
ALTER TABLE [dbo].[monedas_tasas_fwd] ADD  CONSTRAINT [DF__monedas_t__nemot__362B0B11]  DEFAULT (' ') FOR [nemotecnico]
GO
ALTER TABLE [dbo].[monedas_tasas_fwd] ADD  CONSTRAINT [DF__monedas_t__glosa__371F2F4A]  DEFAULT (' ') FOR [glosa]
GO
