USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TIPO_EMISION]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_EMISION](
	[Codigo_Tipo_Emision] [char](3) NOT NULL,
	[Nemotecnico] [char](3) NOT NULL
) ON [PRIMARY]
GO
