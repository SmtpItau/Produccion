USE [Reportes]
GO
/****** Object:  Table [dbo].[RNT_INT_MTX_CONTABLE]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RNT_INT_MTX_CONTABLE](
	[CUENTA] [varchar](20) NULL,
	[INTERFAZ] [varchar](10) NULL,
	[COD_CLS_SALDO] [varchar](1) NULL,
	[COD_T_SALDO] [varchar](1) NULL,
	[COD_TIP_IE] [varchar](2) NULL,
	[CATEGORIA] [varchar](10) NULL
) ON [Reportes_Data_01]
GO
