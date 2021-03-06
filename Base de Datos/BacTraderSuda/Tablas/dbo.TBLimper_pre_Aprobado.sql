USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBLimper_pre_Aprobado]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBLimper_pre_Aprobado](
	[Cartera] [numeric](1, 0) NULL,
	[Instrumento] [varchar](10) NOT NULL,
	[Plazo_minimo] [numeric](6, 0) NULL,
	[Plazo_maximo] [numeric](6, 0) NULL,
	[Usuario_Administrativo] [varchar](12) NOT NULL,
	[Usuario_Supervisor] [varchar](12) NOT NULL,
	[Fecha_de_actualizacion] [datetime] NOT NULL,
	[Fecha_de_aprobacion] [datetime] NOT NULL,
	[Codigo_Estado_de_Informacion] [int] NOT NULL,
	[Codigo_Estado_de_Accion] [int] NOT NULL
) ON [PRIMARY]
GO
