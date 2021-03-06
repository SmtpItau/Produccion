USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBNEWCODIGOS]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBNEWCODIGOS](
	[fecha] [datetime] NULL,
	[comercio] [char](6) NULL,
	[concepto] [char](3) NULL,
	[glosa] [varchar](60) NULL,
	[tipo_documento] [numeric](3, 0) NULL,
	[codigo_oma] [numeric](3, 0) NULL,
	[ventanas] [char](10) NULL,
	[pais_remesa] [char](1) NULL,
	[rut_bcch] [char](1) NULL,
	[estadistica] [char](1) NULL,
	[codigo_relacion] [char](6) NULL
) ON [PRIMARY]
GO
