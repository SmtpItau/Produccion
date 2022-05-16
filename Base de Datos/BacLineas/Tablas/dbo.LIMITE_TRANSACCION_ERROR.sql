USE [BacLineas]
GO
/****** Object:  Table [dbo].[LIMITE_TRANSACCION_ERROR]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIMITE_TRANSACCION_ERROR](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Monto] [numeric](19, 4) NOT NULL,
	[Mensaje] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LIMITE_TRANSACCION_ERROR] ADD  CONSTRAINT [DF__LIMITE_TR__Monto__65C50F9A]  DEFAULT (0) FOR [Monto]
GO
ALTER TABLE [dbo].[LIMITE_TRANSACCION_ERROR] ADD  CONSTRAINT [DF__LIMITE_TR__Mensa__66B933D3]  DEFAULT ('') FOR [Mensaje]
GO
