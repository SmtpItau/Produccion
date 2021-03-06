USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MID_Monitor_Eventos]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MID_Monitor_Eventos](
	[IdModulo] [int] NOT NULL,
	[IdEvento] [int] NOT NULL,
	[IdEstado] [int] NOT NULL,
	[Modulo] [char](3) NOT NULL,
	[Evento] [varchar](50) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
	[HoraInicio] [char](8) NOT NULL,
	[HoraTermino] [char](8) NOT NULL,
 CONSTRAINT [Pk_MID_Monitor_Eventos] PRIMARY KEY CLUSTERED 
(
	[IdModulo] ASC,
	[IdEvento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MID_Monitor_Eventos] ADD  CONSTRAINT [df_MID_Monitor_Eventos_IdEstado]  DEFAULT ((-1)) FOR [IdEstado]
GO
ALTER TABLE [dbo].[MID_Monitor_Eventos] ADD  CONSTRAINT [df_MID_Monitor_Eventos_Modulo]  DEFAULT ('') FOR [Modulo]
GO
ALTER TABLE [dbo].[MID_Monitor_Eventos] ADD  CONSTRAINT [df_MID_Monitor_Eventos_Evento]  DEFAULT ('') FOR [Evento]
GO
ALTER TABLE [dbo].[MID_Monitor_Eventos] ADD  CONSTRAINT [df_MID_Monitor_Eventos_Estado]  DEFAULT ('') FOR [Estado]
GO
ALTER TABLE [dbo].[MID_Monitor_Eventos] ADD  CONSTRAINT [df_MID_Monitor_Eventos_HoraInicio]  DEFAULT ('') FOR [HoraInicio]
GO
ALTER TABLE [dbo].[MID_Monitor_Eventos] ADD  CONSTRAINT [df_MID_Monitor_Eventos_HoraTermino]  DEFAULT ('') FOR [HoraTermino]
GO
