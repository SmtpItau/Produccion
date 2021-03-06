USE [BacLineas]
GO
/****** Object:  Table [dbo].[TBL_RIEFIN_General_REC]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RIEFIN_General_REC](
	[Fecha] [datetime] NULL,
	[Rut] [int] NULL,
	[Codigo] [int] NULL,
	[Codigo_Metodologia] [int] NULL,
	[Nombre] [varchar](70) NULL,
	[Linea] [float] NULL,
	[Treshold] [float] NULL,
	[Valor_Mercado] [float] NULL,
	[Exposicion_Maxima] [float] NULL,
	[VaR90D] [float] NULL,
	[AddOnAlVcto] [float] NULL,
	[Garantia_Ejecutada] [char](2) NULL,
	[Consumo_Linea] [float] NULL,
	[Holgura] [float] NULL,
	[Estado_Linea] [varchar](50) NULL
) ON [PRIMARY]
GO
