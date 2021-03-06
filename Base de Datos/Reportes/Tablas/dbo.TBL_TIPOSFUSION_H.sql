USE [Reportes]
GO
/****** Object:  Table [dbo].[TBL_TIPOSFUSION_H]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_TIPOSFUSION_H](
	[id_desctipo] [int] NOT NULL,
	[id_reporte] [int] NOT NULL,
	[id_descreporte] [int] NOT NULL,
	[tipos_codreporte] [varchar](50) NOT NULL,
	[tipos_descreporte_h] [varchar](50) NULL,
	[tipos_codreporte_h] [varchar](10) NULL,
	[flag_activo] [bit] NOT NULL,
	[facha_ins] [datetime] NULL,
 CONSTRAINT [PK_TBL_TIPOSFUSION_H] PRIMARY KEY CLUSTERED 
(
	[id_desctipo] ASC,
	[id_reporte] ASC,
	[id_descreporte] ASC,
	[tipos_codreporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
