USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_CUENTA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_CUENTA](
	[Codigo] [int] NOT NULL,
	[descripcion] [char](40) NOT NULL
) ON [PRIMARY]
GO
