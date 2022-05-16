USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[MDTB21]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDTB21](
	[NOMSIST] [nvarchar](2) NULL,
	[COD_ARCH] [float] NULL,
	[CODIGO] [float] NULL,
	[GLOSA] [nvarchar](20) NULL,
	[VARIABLE] [nvarchar](10) NULL,
	[VLD_MTO] [nvarchar](40) NULL,
	[MONEDA] [float] NULL
) ON [PRIMARY]
GO
