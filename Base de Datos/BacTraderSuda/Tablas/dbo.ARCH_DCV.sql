USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[ARCH_DCV]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARCH_DCV](
	[IdArchivoDCV] [numeric](9, 0) IDENTITY(1,1) NOT NULL,
	[ADCV_Fecha_Gen] [datetime] NULL,
	[ADCV_Correlativo] [numeric](9, 0) NULL,
	[ADCV_Nom_Arch] [varchar](8) NULL,
	[ADCV_User] [varchar](10) NULL,
	[ADCV_WorkStation] [varchar](50) NULL
) ON [PRIMARY]
GO
