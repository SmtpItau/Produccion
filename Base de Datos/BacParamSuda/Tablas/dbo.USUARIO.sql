USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIO](
	[usuario] [char](15) NOT NULL,
	[clave] [char](15) NOT NULL,
	[nombre] [char](40) NOT NULL,
	[tipo_usuario] [char](15) NOT NULL,
	[fecha_expira] [datetime] NOT NULL,
	[cambio_clave] [char](1) NOT NULL,
	[bloqueado] [char](1) NOT NULL,
	[clase] [char](2) NOT NULL,
	[clave_anterior1] [char](15) NOT NULL,
	[clave_anterior2] [char](15) NOT NULL,
	[clave_anterior3] [char](15) NOT NULL,
	[Largo_Clave] [numeric](2, 0) NOT NULL,
	[Tipo_Clave] [char](1) NOT NULL,
	[Dias_Expiracion] [numeric](5, 0) NOT NULL,
	[reset_psw] [char](1) NOT NULL,
	[Trader] [char](1) NOT NULL,
	[RutUsuario] [varchar](12) NOT NULL,
	[Clave_Anterior4] [varchar](15) NOT NULL,
	[Clave_Anterior5] [varchar](15) NOT NULL,
	[codigomesa] [smallint] NOT NULL,
	[email] [varchar](50) NULL,
	[IdTuring] [int] NULL,
	[usuario_original] [char](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__clave__16677B9E]  DEFAULT ('') FOR [clave]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__nombre__175B9FD7]  DEFAULT ('') FOR [nombre]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__tipo_us__184FC410]  DEFAULT ('') FOR [tipo_usuario]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__fecha_e__1943E849]  DEFAULT ('') FOR [fecha_expira]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__cambio___1A380C82]  DEFAULT ('') FOR [cambio_clave]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__bloquea__1B2C30BB]  DEFAULT ('') FOR [bloqueado]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__clase__1C2054F4]  DEFAULT ('') FOR [clase]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__clave_a__1D14792D]  DEFAULT ('') FOR [clave_anterior1]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__clave_a__1E089D66]  DEFAULT ('') FOR [clave_anterior2]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__clave_a__1EFCC19F]  DEFAULT ('') FOR [clave_anterior3]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__Largo_C__1FF0E5D8]  DEFAULT (0) FOR [Largo_Clave]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__Tipo_Cl__20E50A11]  DEFAULT ('') FOR [Tipo_Clave]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__Dias_Ex__21D92E4A]  DEFAULT (0) FOR [Dias_Expiracion]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [DF__USUARIO__reset_p__39FB9BF5]  DEFAULT (0) FOR [reset_psw]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [dfUsuarioTrader]  DEFAULT ('N') FOR [Trader]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [df_USUARIO_RutUsuario]  DEFAULT ('') FOR [RutUsuario]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [df_USUARIO_Clave_Anterior4]  DEFAULT ('') FOR [Clave_Anterior4]
GO
ALTER TABLE [dbo].[USUARIO] ADD  CONSTRAINT [df_USUARIO_Clave_Anterior5]  DEFAULT ('') FOR [Clave_Anterior5]
GO
ALTER TABLE [dbo].[USUARIO] ADD  DEFAULT (0) FOR [codigomesa]
GO
ALTER TABLE [dbo].[USUARIO] ADD  DEFAULT ('') FOR [usuario_original]
GO
