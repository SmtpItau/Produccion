USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[SECTOR_ECONOMICO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SECTOR_ECONOMICO](
	[Codigo_Sector] [numeric](5, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL
) ON [PRIMARY]
GO
