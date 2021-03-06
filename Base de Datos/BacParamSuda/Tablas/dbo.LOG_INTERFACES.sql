USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LOG_INTERFACES]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LOG_INTERFACES](
	[Nombre_interfaz] [varchar](4) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Hora] [char](10) NOT NULL,
	[Numero_operacion] [numeric](20, 0) NOT NULL,
	[Numero_documento] [numeric](20, 0) NOT NULL,
	[Numero_correlativo] [numeric](20, 0) NOT NULL,
	[Error_detectado] [varchar](200) NOT NULL,
	[Usuario] [varchar](30) NOT NULL,
	[Sistema] [varchar](3) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LOG_INTERFACES] ADD  CONSTRAINT [df_LOG_INTERFACES_Nombre_interfaz]  DEFAULT ('') FOR [Nombre_interfaz]
GO
ALTER TABLE [dbo].[LOG_INTERFACES] ADD  CONSTRAINT [df_LOG_INTERFACES_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[LOG_INTERFACES] ADD  CONSTRAINT [df_LOG_INTERFACES_Hora]  DEFAULT ('') FOR [Hora]
GO
ALTER TABLE [dbo].[LOG_INTERFACES] ADD  CONSTRAINT [df_LOG_INTERFACES_Numero_operacion]  DEFAULT ((0)) FOR [Numero_operacion]
GO
ALTER TABLE [dbo].[LOG_INTERFACES] ADD  CONSTRAINT [df_LOG_INTERFACES_Numero_documento]  DEFAULT ((0)) FOR [Numero_documento]
GO
ALTER TABLE [dbo].[LOG_INTERFACES] ADD  CONSTRAINT [df_LOG_INTERFACES_Numero_correlativo]  DEFAULT ((0)) FOR [Numero_correlativo]
GO
ALTER TABLE [dbo].[LOG_INTERFACES] ADD  CONSTRAINT [df_LOG_INTERFACES_Error_detectado]  DEFAULT ('') FOR [Error_detectado]
GO
ALTER TABLE [dbo].[LOG_INTERFACES] ADD  CONSTRAINT [df_LOG_INTERFACES_Usuario]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[LOG_INTERFACES] ADD  CONSTRAINT [df_LOG_INTERFACES_Sistema]  DEFAULT ('') FOR [Sistema]
GO
