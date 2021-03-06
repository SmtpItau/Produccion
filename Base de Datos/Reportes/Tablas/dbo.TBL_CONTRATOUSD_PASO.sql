USE [Reportes]
GO
/****** Object:  Table [dbo].[TBL_CONTRATOUSD_PASO]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CONTRATOUSD_PASO](
	[id] [int] NOT NULL,
	[nombre_cliente] [varchar](500) NOT NULL,
	[rut_cliente] [varchar](20) NOT NULL,
	[tipo_contrato] [varchar](20) NULL,
	[cliente_usa] [bit] NULL,
	[cliente_relacionado] [bit] NULL
) ON [Reportes_Data_01]
GO
