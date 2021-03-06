USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CLIENTE_CORRESPONSAL]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE_CORRESPONSAL](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Moneda] [char](3) NOT NULL,
	[Codigo_Nemo] [char](4) NOT NULL,
	[Nombre_Corresponsal] [varchar](50) NOT NULL,
	[Cuenta_Corresponsal] [varchar](30) NOT NULL,
	[Codigo_SWIFT] [char](11) NOT NULL
) ON [PRIMARY]
GO
