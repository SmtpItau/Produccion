USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[mdctres]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdctres](
	[CTNOMSIST] [nvarchar](2) NULL,
	[CTCODTRANS] [nvarchar](32) NULL,
	[CTARCHIVO] [float] NULL,
	[CTGLOSACOM] [float] NULL,
	[CTTIPVAL] [nvarchar](1) NULL,
	[CTSECCION] [float] NULL,
	[CTTIPMONAS] [float] NULL,
	[CTCORRELA] [float] NULL,
	[CTOPERA] [nvarchar](20) NULL,
	[CTDEB_HAB] [nvarchar](1) NULL,
	[CTCENCOSTO] [float] NULL,
	[CTCUENTA] [float] NULL,
	[CTVOUCHER] [float] NULL,
	[CTTIPCOMP] [nvarchar](1) NULL,
	[FECACT] [smalldatetime] NULL,
	[CTTIPCTA] [float] NULL,
	[CTTIPMDA] [nvarchar](1) NULL,
	[FOLIO] [float] NULL
) ON [PRIMARY]
GO
