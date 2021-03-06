USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_USERS_PROFILES]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_USERS_PROFILES](
	[id_aplicacion] [nvarchar](30) NOT NULL,
	[id_user] [nvarchar](30) NOT NULL,
	[nombres] [nvarchar](100) NOT NULL,
	[apellidos] [nvarchar](100) NOT NULL,
	[cargo] [nvarchar](60) NOT NULL,
	[fono] [nvarchar](30) NOT NULL,
	[rut] [int] NOT NULL,
	[dv_rut_par] [char](1) NOT NULL,
	[sw_vigente] [char](1) NOT NULL,
	[fecha_eliminacion] [datetime] NOT NULL,
	[UserBacinver] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_aplicacion] ASC,
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FWK_USERS_PROFILES] ADD  DEFAULT ('19000101') FOR [fecha_eliminacion]
GO
ALTER TABLE [dbo].[FWK_USERS_PROFILES] ADD  DEFAULT ('') FOR [UserBacinver]
GO
