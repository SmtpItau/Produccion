USE [MDPasivo]
GO
/****** Object:  Table [dbo].[MDLG]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLG](
	[NOMSIST] [nvarchar](2) NULL,
	[CODTRANS] [nvarchar](32) NULL,
	[COD_ARCH] [float] NULL,
	[GLOSACOM] [float] NULL,
	[TIPMONAS] [float] NULL,
	[CORR_CT] [float] NULL,
	[CORRELA] [float] NULL,
	[CORRELA2] [float] NULL,
	[OPERA] [nvarchar](20) NULL,
	[DEB_HAB] [nvarchar](1) NULL,
	[CENCOSTO] [float] NULL,
	[CUENTA] [float] NULL,
	[TIPMDA] [nvarchar](1) NULL,
	[FOLIO] [float] NULL
) ON [PRIMARY]
GO
