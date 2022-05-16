USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MID_HoraEjecucion]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MID_HoraEjecucion](
	[Hora] [char](10) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MID_HoraEjecucion] ADD  CONSTRAINT [df_MID_HoraEjecucion_Hora]  DEFAULT ('') FOR [Hora]
GO
