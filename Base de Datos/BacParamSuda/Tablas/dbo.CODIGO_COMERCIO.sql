USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CODIGO_COMERCIO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CODIGO_COMERCIO](
	[fecha] [datetime] NULL,
	[comercio] [char](6) NOT NULL,
	[concepto] [char](3) NOT NULL,
	[glosa] [varchar](60) NULL,
	[tipo_documento] [numeric](3, 0) NULL,
	[codigo_oma] [numeric](3, 0) NULL,
	[codigo_planilla] [numeric](3, 0) NOT NULL,
	[pais_remesa] [char](1) NOT NULL,
	[rut_bcch] [char](1) NULL,
	[estadistica] [char](1) NULL,
	[ventanas] [char](10) NULL,
	[CODIGO_RELACION] [char](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[comercio] ASC,
	[concepto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CODIGO_COMERCIO] ADD  CONSTRAINT [DF__CODIGO_CO__Glosa__3787ACF0]  DEFAULT ('') FOR [glosa]
GO
ALTER TABLE [dbo].[CODIGO_COMERCIO] ADD  CONSTRAINT [DF__CODIGO_CO__Tipo___387BD129]  DEFAULT (0) FOR [tipo_documento]
GO
ALTER TABLE [dbo].[CODIGO_COMERCIO] ADD  CONSTRAINT [DF__CODIGO_CO__Codig__396FF562]  DEFAULT (0) FOR [codigo_oma]
GO
ALTER TABLE [dbo].[CODIGO_COMERCIO] ADD  CONSTRAINT [DF__codigo_co__codig__44792A68]  DEFAULT (0) FOR [codigo_planilla]
GO
ALTER TABLE [dbo].[CODIGO_COMERCIO] ADD  CONSTRAINT [DF__codigo_co__pais___456D4EA1]  DEFAULT ('S') FOR [pais_remesa]
GO
ALTER TABLE [dbo].[CODIGO_COMERCIO] ADD  CONSTRAINT [DF__codigo_co__rut_b__466172DA]  DEFAULT ('S') FOR [rut_bcch]
GO
ALTER TABLE [dbo].[CODIGO_COMERCIO] ADD  CONSTRAINT [DF__codigo_co__estad__47559713]  DEFAULT ('N') FOR [estadistica]
GO
ALTER TABLE [dbo].[CODIGO_COMERCIO] ADD  CONSTRAINT [DF__codigo_co__venta__4849BB4C]  DEFAULT ('1100111') FOR [ventanas]
GO
ALTER TABLE [dbo].[CODIGO_COMERCIO] ADD  CONSTRAINT [DF__CODIGO_CO__CODIG__0C26B6F1]  DEFAULT ('') FOR [CODIGO_RELACION]
GO
