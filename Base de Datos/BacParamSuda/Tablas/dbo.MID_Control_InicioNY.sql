USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MID_Control_InicioNY]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MID_Control_InicioNY](
	[Estado] [int] NULL,
	[HoraInicio] [char](8) NOT NULL,
	[HoraTermino] [char](8) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[FechaProx] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MID_Control_InicioNY] ADD  CONSTRAINT [df_MID_Control_InicioNY_HoraInicio]  DEFAULT ('00:00:00') FOR [HoraInicio]
GO
ALTER TABLE [dbo].[MID_Control_InicioNY] ADD  CONSTRAINT [df_MID_Control_InicioNY_HoraTermino]  DEFAULT ('00:00:00') FOR [HoraTermino]
GO
ALTER TABLE [dbo].[MID_Control_InicioNY] ADD  CONSTRAINT [df_MID_Control_InicioNY_Fecha]  DEFAULT ('1900-01-01') FOR [Fecha]
GO
ALTER TABLE [dbo].[MID_Control_InicioNY] ADD  CONSTRAINT [df_MID_Control_InicioNY_NextDate]  DEFAULT ('1900-01-01') FOR [FechaProx]
GO
