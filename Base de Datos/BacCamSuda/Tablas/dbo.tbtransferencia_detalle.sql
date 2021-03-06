USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbtransferencia_detalle]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbtransferencia_detalle](
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[moneda] [char](3) NOT NULL,
	[monto] [numeric](19, 4) NOT NULL,
	[paridad] [numeric](10, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbtransferencia_detalle] ADD  CONSTRAINT [DF__tbtransfe__numer__039569A3]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[tbtransferencia_detalle] ADD  CONSTRAINT [DF__tbtransfe__moned__04898DDC]  DEFAULT ('') FOR [moneda]
GO
ALTER TABLE [dbo].[tbtransferencia_detalle] ADD  CONSTRAINT [DF__tbtransfe__monto__057DB215]  DEFAULT (0) FOR [monto]
GO
ALTER TABLE [dbo].[tbtransferencia_detalle] ADD  CONSTRAINT [DF__tbtransfe__parid__0671D64E]  DEFAULT (0) FOR [paridad]
GO
