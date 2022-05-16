USE [MDPasivo]
GO
/****** Object:  Table [dbo].[COMUNA]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMUNA](
	[codigo_comuna] [numeric](5, 0) NOT NULL,
	[codigo_ciudad] [numeric](5, 0) NOT NULL,
	[nombre] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
