USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[MDEM]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDEM](
	[EMRUT] [float] NULL,
	[EMDV] [nvarchar](1) NULL,
	[EMGENERIC] [nvarchar](5) NULL,
	[EMRELAC] [nvarchar](1) NULL,
	[EMCLASLH] [nvarchar](2) NULL,
	[EMCLASDPF] [nvarchar](2) NULL,
	[EMCLASOTR] [nvarchar](2) NULL,
	[EMNOMBRE] [nvarchar](40) NULL,
	[EMTIPO] [nvarchar](1) NULL,
	[MARCA] [nvarchar](3) NULL,
	[EMSPREAD] [float] NULL,
	[EMCOD_BBU] [nvarchar](12) NULL,
	[EMCODINT_F] [float] NULL,
	[EMACTIVI] [nvarchar](10) NULL,
	[EMLINEAS] [nvarchar](1) NULL,
	[EMNACIONAL] [nvarchar](1) NULL,
	[EMSOBERANO] [nvarchar](1) NULL,
	[EMCOD_PAIS] [nvarchar](3) NULL,
	[EMSUB_PAIS] [float] NULL,
	[EMRESIDEN] [nvarchar](1) NULL
) ON [PRIMARY]
GO
