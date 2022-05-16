USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS](
	[Codigo] [char](10) NOT NULL,
	[Descripcion] [char](50) NOT NULL,
	[Ubicacion] [varchar](255) NOT NULL,
	[Nombre_Archivo] [varchar](50) NOT NULL,
	[Indice_Orden] [int] NOT NULL,
	[Categoria_Dcto] [char](10) NOT NULL,
	[Default_Swap] [char](1) NOT NULL,
	[Default_Forward] [char](1) NOT NULL,
	[Sistema] [char](5) NOT NULL,
	[Activo] [char](1) NOT NULL,
 CONSTRAINT [PK__TBL_DCTOS_CONTRATOS_DERIVADOS] PRIMARY KEY CLUSTERED 
(
	[Sistema] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [CODIGO]  DEFAULT ('') FOR [Codigo]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [Descripcion]  DEFAULT ('') FOR [Descripcion]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [Ubicacion]  DEFAULT ('') FOR [Ubicacion]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [Nombre_Archivo]  DEFAULT ('') FOR [Nombre_Archivo]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [Indice_Orden]  DEFAULT (0) FOR [Indice_Orden]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [Categoria_Dcto]  DEFAULT ('') FOR [Categoria_Dcto]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [Default_Swap]  DEFAULT ('') FOR [Default_Swap]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [Default_Forward]  DEFAULT ('') FOR [Default_Forward]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [TBL_DCTOS_CONTRATOS_DERIVADOS_SISTEMA]  DEFAULT ('') FOR [Sistema]
GO
ALTER TABLE [dbo].[TBL_DCTOS_CONTRATOS_DERIVADOS] ADD  CONSTRAINT [TBL_DCTOS_CONTRATOS_DERIVADOS_ACTIVO]  DEFAULT ('S') FOR [Activo]
GO
