USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[POSICION_GRUPO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POSICION_GRUPO](
	[codigo_grupo] [varchar](5) NOT NULL,
	[porcentaje] [numeric](10, 4) NOT NULL,
	[totalposicion] [numeric](19, 4) NOT NULL,
	[totalocupado] [numeric](19, 4) NOT NULL,
	[totalcompra] [numeric](19, 4) NOT NULL,
	[totalventa] [numeric](19, 4) NOT NULL,
	[totaldisponible] [numeric](19, 4) NOT NULL,
	[totalexcedido] [numeric](19, 4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[POSICION_GRUPO] ADD  CONSTRAINT [DF__POSICION___Porce__12F546BF]  DEFAULT (0) FOR [porcentaje]
GO
ALTER TABLE [dbo].[POSICION_GRUPO] ADD  CONSTRAINT [DF__POSICION___Total__13E96AF8]  DEFAULT (0) FOR [totalposicion]
GO
ALTER TABLE [dbo].[POSICION_GRUPO] ADD  CONSTRAINT [DF__POSICION___Total__14DD8F31]  DEFAULT (0) FOR [totalocupado]
GO
ALTER TABLE [dbo].[POSICION_GRUPO] ADD  CONSTRAINT [DF__POSICION___Total__15D1B36A]  DEFAULT (0) FOR [totalcompra]
GO
ALTER TABLE [dbo].[POSICION_GRUPO] ADD  CONSTRAINT [DF__POSICION___Total__16C5D7A3]  DEFAULT (0) FOR [totalventa]
GO
ALTER TABLE [dbo].[POSICION_GRUPO] ADD  CONSTRAINT [DF__POSICION___Total__17B9FBDC]  DEFAULT (0) FOR [totaldisponible]
GO
ALTER TABLE [dbo].[POSICION_GRUPO] ADD  CONSTRAINT [DF__POSICION___Total__18AE2015]  DEFAULT (0) FOR [totalexcedido]
GO
ALTER TABLE [dbo].[POSICION_GRUPO]  WITH CHECK ADD FOREIGN KEY([codigo_grupo])
REFERENCES [dbo].[GRUPO_POSICION] ([codigo_grupo])
GO
