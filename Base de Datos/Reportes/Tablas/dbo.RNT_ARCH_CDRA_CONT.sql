USE [Reportes]
GO
/****** Object:  Table [dbo].[RNT_ARCH_CDRA_CONT]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RNT_ARCH_CDRA_CONT](
	[CUENTA] [varchar](20) NULL,
	[CONCEPTO] [varchar](20) NULL,
	[NOMBRE_CUENTA] [varchar](70) NULL,
	[MONEDA] [varchar](5) NULL,
	[CRITERIO_01] [varchar](50) NULL,
	[CRITERIO_02] [varchar](50) NULL,
	[CRITERIO_03] [varchar](50) NULL,
	[CRITERIO_04] [varchar](50) NULL,
	[CRITERIO_05] [varchar](50) NULL,
	[CRITERIO_06] [varchar](50) NULL,
	[CRITERIO_07] [varchar](50) NULL,
	[CRITERIO_08] [varchar](50) NULL,
	[CRITERIO_09] [varchar](50) NULL,
	[CRITERIO_10] [varchar](50) NULL,
	[PRODUCTO] [varchar](60) NULL,
	[FAMILIA] [varchar](100) NULL,
	[SISTEMA] [varchar](5) NULL,
	[CAMPO] [varchar](200) NULL
) ON [Reportes_Data_01]
GO
