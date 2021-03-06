USE [Reportes]
GO
/****** Object:  Table [dbo].[TBL_PROCESO_REPORTES]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_PROCESO_REPORTES](
	[id_reporte] [int] NOT NULL,
	[id_modulo] [int] NOT NULL,
	[proc_fecha] [datetime] NOT NULL,
	[procesado] [bit] NULL,
	[fecha_reg] [datetime] NULL,
	[proc_detalle] [varchar](8000) NULL,
 CONSTRAINT [PK_TBL_PROCESO_REPORTES_1] PRIMARY KEY CLUSTERED 
(
	[id_reporte] ASC,
	[id_modulo] ASC,
	[proc_fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_PROCESO_REPORTES] ADD  DEFAULT ((0)) FOR [procesado]
GO
