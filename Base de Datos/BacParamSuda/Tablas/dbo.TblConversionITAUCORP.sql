USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TblConversionITAUCORP]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblConversionITAUCORP](
	[idParametro] [smallint] NOT NULL,
	[idDatoITAU] [varchar](100) NULL,
	[idDatoCORP] [varchar](100) NULL,
	[sTipoDato] [char](1) NOT NULL,
	[Campo] [varchar](50) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[CodRel] [smallint] NOT NULL
) ON [PRIMARY]
GO
