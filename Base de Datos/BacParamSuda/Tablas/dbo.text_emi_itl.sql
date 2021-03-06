USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[text_emi_itl]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_emi_itl](
	[rut_emi] [numeric](9, 0) NOT NULL,
	[codigo] [numeric](1, 0) NOT NULL,
	[digito_ver] [char](1) NOT NULL,
	[nom_emi] [char](60) NOT NULL,
	[clasificacion1] [char](40) NULL,
	[clasificacion2] [char](40) NULL,
	[tipo_corto1] [char](30) NOT NULL,
	[tipo_largo1] [char](30) NOT NULL,
	[tipo_corto2] [char](30) NOT NULL,
	[tipo_largo2] [char](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[rut_emi] ASC,
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_emi_itl] ADD  CONSTRAINT [DF__text_emi___digit__4959E263]  DEFAULT ('') FOR [digito_ver]
GO
ALTER TABLE [dbo].[text_emi_itl] ADD  CONSTRAINT [DF__text_emi___nom_e__4A4E069C]  DEFAULT ('') FOR [nom_emi]
GO
ALTER TABLE [dbo].[text_emi_itl] ADD  CONSTRAINT [DF__text_emi___tipo___4B422AD5]  DEFAULT ('') FOR [tipo_corto1]
GO
ALTER TABLE [dbo].[text_emi_itl] ADD  CONSTRAINT [DF__text_emi___tipo___4C364F0E]  DEFAULT ('') FOR [tipo_largo1]
GO
ALTER TABLE [dbo].[text_emi_itl] ADD  CONSTRAINT [DF__text_emi___tipo___4D2A7347]  DEFAULT ('') FOR [tipo_corto2]
GO
ALTER TABLE [dbo].[text_emi_itl] ADD  CONSTRAINT [DF__text_emi___tipo___4E1E9780]  DEFAULT ('') FOR [tipo_largo2]
GO
