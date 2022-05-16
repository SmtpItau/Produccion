USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_DATOS_ENVIO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_DATOS_ENVIO](
	[Id] [int] NOT NULL,
	[cHost] [varchar](20) NOT NULL,
	[cName] [varchar](50) NOT NULL,
	[cPort] [varchar](10) NOT NULL,
	[cUser] [varchar](20) NOT NULL,
	[cService] [varchar](100) NOT NULL,
	[cDescription] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
