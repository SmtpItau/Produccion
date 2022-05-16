USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[GRUPO_POSICION]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRUPO_POSICION](
	[codigo_grupo] [varchar](5) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[plazo_desde] [numeric](5, 0) NOT NULL,
	[plazo_hasta] [numeric](5, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GRUPO_POSICION] ADD  CONSTRAINT [DF__GRUPO_POS__Descr__0E3091A2]  DEFAULT ('') FOR [descripcion]
GO
ALTER TABLE [dbo].[GRUPO_POSICION] ADD  CONSTRAINT [DF__GRUPO_POS__Plazo__0F24B5DB]  DEFAULT (0) FOR [plazo_desde]
GO
ALTER TABLE [dbo].[GRUPO_POSICION] ADD  CONSTRAINT [DF__GRUPO_POS__Plazo__1018DA14]  DEFAULT (0) FOR [plazo_hasta]
GO
