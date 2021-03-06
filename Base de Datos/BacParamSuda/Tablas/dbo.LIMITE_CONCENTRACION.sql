USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LIMITE_CONCENTRACION]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIMITE_CONCENTRACION](
	[Codigo_Limite] [decimal](18, 0) NOT NULL,
	[Incodigo] [decimal](3, 0) NOT NULL,
	[Rut_Emisor] [decimal](9, 0) NOT NULL,
	[Outstanding] [float] NOT NULL,
	[Outstanding_Filial] [float] NOT NULL,
	[Outstandig_Total] [float] NOT NULL,
	[Monto_Emision] [float] NOT NULL,
	[Porc_Limite] [decimal](18, 0) NOT NULL,
	[Monto_Limite] [float] NOT NULL,
	[Disponible] [float] NOT NULL
) ON [PRIMARY]
GO
