USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[FERIADO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FERIADO](
	[pais] [numeric](5, 0) NOT NULL,
	[plaza] [numeric](5, 0) NOT NULL,
	[fecha] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FERIADO] ADD  CONSTRAINT [DF_FERIADO_pais]  DEFAULT ((0)) FOR [pais]
GO
ALTER TABLE [dbo].[FERIADO] ADD  CONSTRAINT [DF_FERIADO_plaza]  DEFAULT ((0)) FOR [plaza]
GO
ALTER TABLE [dbo].[FERIADO] ADD  CONSTRAINT [DF_FERIADO_fecha]  DEFAULT ('') FOR [fecha]
GO
