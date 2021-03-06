USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbXMLTuring]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbXMLTuring](
	[dcSistema] [varchar](3) NOT NULL,
	[dcProducto] [varchar](10) NOT NULL,
	[dcMoneda] [varchar](3) NOT NULL,
	[dcMonedaConversion] [varchar](3) NOT NULL,
	[dcModalidad] [char](1) NOT NULL,
	[dnIndice] [int] NOT NULL,
	[dcTag] [varchar](250) NULL,
	[dcCampo] [varchar](250) NULL,
 CONSTRAINT [pk_tbXmlTuring] PRIMARY KEY CLUSTERED 
(
	[dcSistema] ASC,
	[dcProducto] ASC,
	[dcMoneda] ASC,
	[dcMonedaConversion] ASC,
	[dcModalidad] ASC,
	[dnIndice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
