USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[Saldo_Cuentas]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Saldo_Cuentas](
	[CUENTA] [char](12) NULL,
	[SALDO_BANCO] [numeric](21, 0) NULL,
	[SALDO_BAC] [numeric](21, 0) NULL,
	[MONEDA] [numeric](3, 0) NULL,
	[IMPRIME] [numeric](1, 0) NULL,
	[TIPO_BRECHA] [char](7) NULL
) ON [PRIMARY]
GO
