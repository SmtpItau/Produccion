USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbXMLCampo]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbXMLCampo](
	[dcSistema] [varchar](3) NOT NULL,
	[dcCampo] [varchar](250) NOT NULL,
	[dcCampoTabla] [varchar](250) NULL,
	[dgValor] [varchar](250) NULL,
 CONSTRAINT [pk_tbXmlCampo] PRIMARY KEY CLUSTERED 
(
	[dcSistema] ASC,
	[dcCampo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
