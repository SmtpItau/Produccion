USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[Tmoneda_c08]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tmoneda_c08](
	[Tasa] [float] NOT NULL,
	[Spreed] [float] NOT NULL,
	[SpotCompra] [float] NOT NULL,
	[SpotVenta] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tmoneda_c08] ADD  DEFAULT (0.0) FOR [Tasa]
GO
ALTER TABLE [dbo].[Tmoneda_c08] ADD  DEFAULT (0.0) FOR [Spreed]
GO
ALTER TABLE [dbo].[Tmoneda_c08] ADD  DEFAULT (0.0) FOR [SpotCompra]
GO
ALTER TABLE [dbo].[Tmoneda_c08] ADD  DEFAULT (0.0) FOR [SpotVenta]
GO
