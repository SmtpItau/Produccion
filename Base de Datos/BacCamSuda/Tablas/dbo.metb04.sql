USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[metb04]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[metb04](
	[CODCOM] [float] NULL,
	[DIGCOM] [nvarchar](1) NULL,
	[CODCNP] [float] NULL,
	[DIGCNP] [nvarchar](1) NULL,
	[DESCRI] [nvarchar](40) NULL,
	[CODOPE] [float] NULL,
	[SPOT] [bit] NOT NULL
) ON [PRIMARY]
GO
