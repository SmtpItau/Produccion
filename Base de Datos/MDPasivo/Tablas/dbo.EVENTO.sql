USE [MDPasivo]
GO
/****** Object:  Table [dbo].[EVENTO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EVENTO](
	[codigo_evento] [char](5) NOT NULL,
	[descripcion_campo] [char](60) NOT NULL
) ON [PRIMARY]
GO
