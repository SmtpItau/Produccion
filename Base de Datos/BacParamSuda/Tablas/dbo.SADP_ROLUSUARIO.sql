USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_ROLUSUARIO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_ROLUSUARIO](
	[Usuario] [varchar](15) NOT NULL,
	[RolInterno] [smallint] NOT NULL,
	[Email] [varchar](30) NOT NULL
) ON [PRIMARY]
GO
