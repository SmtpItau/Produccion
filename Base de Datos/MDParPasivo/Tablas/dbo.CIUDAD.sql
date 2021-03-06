USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CIUDAD]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CIUDAD](
	[codigo_ciudad] [numeric](5, 0) NOT NULL,
	[codigo_region] [numeric](5, 0) NOT NULL,
	[nombre] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CIUDAD] ADD  CONSTRAINT [DF_CIUDAD_codigo_ciudad]  DEFAULT ((0)) FOR [codigo_ciudad]
GO
ALTER TABLE [dbo].[CIUDAD] ADD  CONSTRAINT [DF_CIUDAD_codigo_region]  DEFAULT ((0)) FOR [codigo_region]
GO
ALTER TABLE [dbo].[CIUDAD] ADD  CONSTRAINT [DF_CIUDAD_nombre]  DEFAULT ('') FOR [nombre]
GO
