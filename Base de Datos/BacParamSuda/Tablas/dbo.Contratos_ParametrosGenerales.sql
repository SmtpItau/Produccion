USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Contratos_ParametrosGenerales]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contratos_ParametrosGenerales](
	[RutEntidad] [int] NULL,
	[DigitoVerificador] [int] NULL,
	[CodigoEntidad] [int] NULL,
	[RazonSocial] [nvarchar](200) NULL,
	[NombreFantasia] [nvarchar](200) NULL,
	[DireccionLegal] [nvarchar](200) NULL,
	[TelefonoLegal] [nvarchar](200) NULL,
	[Comuna] [nvarchar](200) NULL,
	[Ciudad] [nvarchar](200) NULL,
	[Logo] [image] NULL,
	[BannerCorto] [image] NULL,
	[BannerLargo] [image] NULL,
	[BannerLargoContrato] [image] NULL,
	[DireccionLegalPieFirma] [nvarchar](200) NULL,
	[URLBanco] [nvarchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
