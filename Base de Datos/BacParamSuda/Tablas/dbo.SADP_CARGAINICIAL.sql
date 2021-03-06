USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_CARGAINICIAL]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_CARGAINICIAL](
	[idCargaInicial] [int] IDENTITY(1,1) NOT NULL,
	[dFechaCarga] [datetime] NOT NULL,
	[sSistema] [varchar](5) NOT NULL,
	[sTipMercado] [varchar](10) NOT NULL,
	[iFormaPago] [smallint] NOT NULL,
	[dMonto] [numeric](21, 4) NOT NULL,
	[iCantidad] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SADP_CARGAINICIAL] ADD  DEFAULT ('') FOR [dFechaCarga]
GO
ALTER TABLE [dbo].[SADP_CARGAINICIAL] ADD  DEFAULT ('') FOR [sSistema]
GO
ALTER TABLE [dbo].[SADP_CARGAINICIAL] ADD  DEFAULT ('') FOR [sTipMercado]
GO
ALTER TABLE [dbo].[SADP_CARGAINICIAL] ADD  DEFAULT ((0)) FOR [iFormaPago]
GO
ALTER TABLE [dbo].[SADP_CARGAINICIAL] ADD  DEFAULT ((0)) FOR [dMonto]
GO
ALTER TABLE [dbo].[SADP_CARGAINICIAL] ADD  DEFAULT ((0)) FOR [iCantidad]
GO
