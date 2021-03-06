USE [BacLineas]
GO
/****** Object:  Table [dbo].[RIESGOINTERNO]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RIESGOINTERNO](
	[codigo_riesgo] [int] NOT NULL,
	[glosa_riesgo] [char](30) NOT NULL,
	[descripcion] [char](70) NOT NULL,
 CONSTRAINT [Pk_RIESGOINTERNO] PRIMARY KEY CLUSTERED 
(
	[codigo_riesgo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RIESGOINTERNO] ADD  CONSTRAINT [df_RiesgoInterno_codigo_riesgo]  DEFAULT (0) FOR [codigo_riesgo]
GO
ALTER TABLE [dbo].[RIESGOINTERNO] ADD  CONSTRAINT [df_RiesgoInterno_glosa_riesgo]  DEFAULT ('') FOR [glosa_riesgo]
GO
ALTER TABLE [dbo].[RIESGOINTERNO] ADD  CONSTRAINT [df_RiesgoInterno_descripcion]  DEFAULT ('') FOR [descripcion]
GO
