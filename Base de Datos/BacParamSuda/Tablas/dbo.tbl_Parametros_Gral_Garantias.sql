USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_Parametros_Gral_Garantias]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Parametros_Gral_Garantias](
	[SubjectEmail] [varchar](255) NULL,
	[ACNumGarantias] [numeric](10, 0) NOT NULL,
	[ACNumGarantiasOtorgadas] [numeric](10, 0) NOT NULL,
	[MensajeEmail] [varchar](2000) NULL,
	[UltPeriodoInterfaces] [char](6) NULL,
	[FolioAsocia] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Parametros_Gral_Garantias] ADD  CONSTRAINT [DF_tbl_Parametros_Gral_Garantias_ACNumGarantias]  DEFAULT (0) FOR [ACNumGarantias]
GO
ALTER TABLE [dbo].[tbl_Parametros_Gral_Garantias] ADD  CONSTRAINT [DF_tbl_Parametros_Gral_Garantias_ACNumGarantiasOtorgadas]  DEFAULT (0) FOR [ACNumGarantiasOtorgadas]
GO
ALTER TABLE [dbo].[tbl_Parametros_Gral_Garantias] ADD  CONSTRAINT [DF_tbl_Parametros_Gral_Garantias_FolioAsocia]  DEFAULT (0) FOR [FolioAsocia]
GO
