USE [MDPasivo]
GO
/****** Object:  Table [dbo].[LOG_EVENTO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOG_EVENTO](
	[codigo_evento] [varchar](2) NOT NULL,
	[descripcion] [varchar](60) NOT NULL
) ON [PRIMARY]
GO
