USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LINEA_AFILIADO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_AFILIADO](
	[RutCasaMatriz] [numeric](9, 0) NOT NULL,
	[CodigoCasaMatriz] [numeric](9, 0) NOT NULL,
	[TotalAsignado] [numeric](19, 4) NOT NULL,
	[TotalOcupado] [numeric](19, 4) NOT NULL,
	[TotalDisponible] [numeric](19, 4) NOT NULL,
	[TotalExceso] [numeric](19, 4) NOT NULL,
	[SinRiesgoAsignado] [numeric](19, 4) NOT NULL,
	[SinRiesgoOcupado] [numeric](19, 4) NOT NULL,
	[SinRiesgoDisponible] [numeric](19, 4) NOT NULL,
	[SinRiesgoExceso] [numeric](19, 4) NOT NULL,
	[ConRiesgoAsignado] [numeric](19, 4) NOT NULL,
	[ConRiesgoOcupado] [numeric](19, 4) NOT NULL,
	[ConRiesgoDisponible] [numeric](19, 4) NOT NULL,
	[ConRiesgoExceso] [numeric](19, 4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RutCasaMatriz] ASC,
	[CodigoCasaMatriz] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__Total__6E24801A]  DEFAULT (0) FOR [TotalAsignado]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__Total__6F18A453]  DEFAULT (0) FOR [TotalOcupado]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__Total__700CC88C]  DEFAULT (0) FOR [TotalDisponible]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__Total__7100ECC5]  DEFAULT (0) FOR [TotalExceso]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__SinRi__71F510FE]  DEFAULT (0) FOR [SinRiesgoAsignado]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__SinRi__72E93537]  DEFAULT (0) FOR [SinRiesgoOcupado]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__SinRi__73DD5970]  DEFAULT (0) FOR [SinRiesgoDisponible]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__SinRi__74D17DA9]  DEFAULT (0) FOR [SinRiesgoExceso]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__ConRi__75C5A1E2]  DEFAULT (0) FOR [ConRiesgoAsignado]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__ConRi__76B9C61B]  DEFAULT (0) FOR [ConRiesgoOcupado]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__ConRi__77ADEA54]  DEFAULT (0) FOR [ConRiesgoDisponible]
GO
ALTER TABLE [dbo].[LINEA_AFILIADO] ADD  CONSTRAINT [DF__LINEA_AFI__ConRi__78A20E8D]  DEFAULT (0) FOR [ConRiesgoExceso]
GO
