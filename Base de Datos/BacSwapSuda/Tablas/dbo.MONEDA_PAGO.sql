USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[MONEDA_PAGO]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONEDA_PAGO](
	[id_Sistema] [char](3) NOT NULL,
	[Moneda_Operacion] [numeric](9, 0) NOT NULL,
	[Moneda_Pago] [numeric](9, 0) NOT NULL,
 CONSTRAINT [pk_MONEDA_PAGO] PRIMARY KEY CLUSTERED 
(
	[id_Sistema] ASC,
	[Moneda_Operacion] ASC,
	[Moneda_Pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MONEDA_PAGO] ADD  CONSTRAINT [df_MONEDA_PAGO_id_sistema]  DEFAULT ('') FOR [id_Sistema]
GO
ALTER TABLE [dbo].[MONEDA_PAGO] ADD  CONSTRAINT [df_MONEDA_PAGO_Moneda_Operacion]  DEFAULT (0) FOR [Moneda_Operacion]
GO
ALTER TABLE [dbo].[MONEDA_PAGO] ADD  CONSTRAINT [df_MONEDA_PAGO_Moneda_Pago]  DEFAULT (0) FOR [Moneda_Pago]
GO
