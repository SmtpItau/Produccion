USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_PRIVILEGIOS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_PRIVILEGIOS](
	[Tipo] [char](1) NOT NULL,
	[Nombre] [varchar](20) NOT NULL,
	[Opcion] [varchar](20) NOT NULL,
	[Habilitado] [int] NOT NULL
) ON [PRIMARY]
GO
