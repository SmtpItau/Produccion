USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TABLA_ROLES_USUARIOS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_ROLES_USUARIOS](
	[Usuario] [varchar](50) NOT NULL,
	[Rol] [int] NOT NULL,
	[EMail] [varchar](150) NOT NULL,
 CONSTRAINT [Pk_TABLA_ROLES_USUARIOS] PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TABLA_ROLES_USUARIOS] ADD  CONSTRAINT [df_TABLA_ROLES_USUARIOS_Usuario]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[TABLA_ROLES_USUARIOS] ADD  CONSTRAINT [df_TABLA_ROLES_USUARIOS_Rol]  DEFAULT (0) FOR [Rol]
GO
ALTER TABLE [dbo].[TABLA_ROLES_USUARIOS] ADD  CONSTRAINT [df_TABLA_ROLES_USUARIOS_EMail]  DEFAULT ('') FOR [EMail]
GO
