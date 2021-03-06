USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[cliente_corresponal]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente_corresponal](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Moneda] [char](3) NOT NULL,
	[Codigo] [char](4) NOT NULL,
	[Nombre_Corresponsal] [varchar](50) NOT NULL,
	[Cuenta_Corresponsal] [varchar](30) NOT NULL,
	[Codigo_SWIFT] [char](11) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Rut_Cliente] ASC,
	[Codigo_Cliente] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
