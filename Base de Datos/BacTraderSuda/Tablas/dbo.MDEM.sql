USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDEM]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDEM](
	[EMRUT] [float] NULL,
	[EMDV] [nvarchar](1) NULL,
	[EMGENERIC] [nvarchar](5) NULL,
	[EMCLASLH] [nvarchar](2) NULL,
	[EMCLASDPF] [nvarchar](2) NULL,
	[EMCLASOTR] [nvarchar](2) NULL,
	[EMNOMBRE] [nvarchar](40) NULL,
	[EMTIPO] [nvarchar](1) NULL,
	[MARCA] [nvarchar](3) NULL,
	[EMCLASIF] [float] NULL,
	[EMTIPEMILI] [float] NULL
) ON [PRIMARY]
GO
