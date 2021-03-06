USE [MDPasivo]
GO
/****** Object:  Table [dbo].[REGION]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGION](
	[codigo_region] [numeric](5, 0) NOT NULL,
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[nombre] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[REGION] ADD  CONSTRAINT [DF_REGION_codigo_region]  DEFAULT ((0)) FOR [codigo_region]
GO
ALTER TABLE [dbo].[REGION] ADD  CONSTRAINT [DF_REGION_codigo_pais]  DEFAULT ((0)) FOR [codigo_pais]
GO
ALTER TABLE [dbo].[REGION] ADD  CONSTRAINT [DF_REGION_nombre]  DEFAULT ('') FOR [nombre]
GO
