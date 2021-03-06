USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[CLCP]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLCP](
	[CL_CLIENTE] [nvarchar](40) NULL,
	[CL_RUTCLI] [float] NULL,
	[CL_DIGVER] [nvarchar](1) NULL,
	[CL_DIRCLI] [nvarchar](40) NULL,
	[CL_NUMCLI] [float] NULL,
	[CL_TELEFO] [float] NULL,
	[OTRO] [float] NULL,
	[CL_FAX] [float] NULL,
	[CL_CONTAC] [nvarchar](35) NULL,
	[CL_CODEJE] [nvarchar](3) NULL,
	[CL_EJECTA] [nvarchar](35) NULL,
	[CL_CODSUC] [float] NULL,
	[CL_NOMSUC] [nvarchar](20) NULL,
	[CL_CTACLP] [float] NULL,
	[CL_CTAUSD] [float] NULL,
	[CLTIPO] [float] NULL,
	[CLCONTAB] [float] NULL,
	[CL_COSTO] [float] NULL,
	[CL_CIUDAD] [float] NULL,
	[CL_COMUNA] [float] NULL,
	[CLCONLINEA] [bit] NOT NULL
) ON [PRIMARY]
GO
