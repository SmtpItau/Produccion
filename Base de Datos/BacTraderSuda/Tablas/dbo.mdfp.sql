USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdfp]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdfp](
	[NOMBRE] [int] NULL,
	[GLOSA] [nvarchar](30) NULL,
	[perfil] [nvarchar](9) NULL,
	[codgen] [int] NULL,
	[glosa2] [nvarchar](8) NULL,
	[cc2757] [nvarchar](8) NULL,
	[afectacorr] [nvarchar](1) NULL,
	[diasvalor] [int] NULL,
	[numcheque] [nvarchar](1) NULL,
	[ctacte] [nvarchar](1) NULL
) ON [PRIMARY]
GO
