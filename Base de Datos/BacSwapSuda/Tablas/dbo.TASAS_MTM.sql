USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[TASAS_MTM]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASAS_MTM](
	[Curva] [char](15) NOT NULL,
	[Tasa] [numeric](6, 2) NOT NULL,
	[Fecha] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TASAS_MTM] ADD  CONSTRAINT [DF__TASAS_MTM__Curva__17CE3F1E]  DEFAULT ('') FOR [Curva]
GO
ALTER TABLE [dbo].[TASAS_MTM] ADD  CONSTRAINT [DF__TASAS_MTM__Tasa__18C26357]  DEFAULT (0) FOR [Tasa]
GO
ALTER TABLE [dbo].[TASAS_MTM] ADD  CONSTRAINT [DF__TASAS_MTM__Fecha__19B68790]  DEFAULT (0) FOR [Fecha]
GO
