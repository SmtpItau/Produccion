USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Mid_Eventos_Hora]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mid_Eventos_Hora](
	[Hora] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Mid_Eventos_Hora] ADD  CONSTRAINT [df_Mid_Eventos_Hora_Hora]  DEFAULT ('') FOR [Hora]
GO
