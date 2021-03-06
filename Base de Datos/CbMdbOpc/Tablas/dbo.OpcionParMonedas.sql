USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[OpcionParMonedas]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpcionParMonedas](
	[OpcParMdaCod] [varchar](7) NOT NULL,
	[OpcParMda1] [numeric](5, 0) NOT NULL,
	[OpcParMda2] [numeric](5, 0) NOT NULL,
	[OpcFPagoMda1] [numeric](5, 0) NOT NULL,
	[OpcFPagoMda2] [numeric](5, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OpcParMdaCod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OpcionParMonedas] ADD  DEFAULT ('') FOR [OpcParMdaCod]
GO
ALTER TABLE [dbo].[OpcionParMonedas] ADD  DEFAULT ((0)) FOR [OpcParMda1]
GO
ALTER TABLE [dbo].[OpcionParMonedas] ADD  DEFAULT ((0)) FOR [OpcParMda2]
GO
ALTER TABLE [dbo].[OpcionParMonedas] ADD  DEFAULT ((0)) FOR [OpcFPagoMda1]
GO
ALTER TABLE [dbo].[OpcionParMonedas] ADD  DEFAULT ((0)) FOR [OpcFPagoMda2]
GO
