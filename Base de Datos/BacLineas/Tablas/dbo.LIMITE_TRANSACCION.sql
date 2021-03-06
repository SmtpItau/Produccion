USE [BacLineas]
GO
/****** Object:  Table [dbo].[LIMITE_TRANSACCION]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIMITE_TRANSACCION](
	[FechaOperacion] [datetime] NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[InCodigo] [numeric](5, 0) NULL,
	[MontoTransaccion] [numeric](19, 4) NOT NULL,
	[FechaVencimiento] [datetime] NULL,
	[Operador] [char](15) NOT NULL,
	[Check_Operacion] [varchar](1) NOT NULL,
	[Check_Instrumento] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LIMITE_TRANSACCION] ADD  CONSTRAINT [DF__LIMITE_TR__Monto__1A6DE203]  DEFAULT (0) FOR [MontoTransaccion]
GO
ALTER TABLE [dbo].[LIMITE_TRANSACCION] ADD  CONSTRAINT [DF__LIMITE_TR__Check__1B62063C]  DEFAULT ('') FOR [Check_Operacion]
GO
ALTER TABLE [dbo].[LIMITE_TRANSACCION] ADD  CONSTRAINT [DF__LIMITE_TR__Check__1C562A75]  DEFAULT ('') FOR [Check_Instrumento]
GO
