USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[EVENTO_CONTABLE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EVENTO_CONTABLE](
	[codigo_evento] [char](3) NOT NULL,
	[descripcion_campo] [char](60) NOT NULL
) ON [PRIMARY]
GO
