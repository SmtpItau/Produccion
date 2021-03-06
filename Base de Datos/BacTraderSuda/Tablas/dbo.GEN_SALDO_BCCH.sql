USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_SALDO_BCCH]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_SALDO_BCCH](
	[saldo_inicio] [float] NULL,
	[saldo_final] [float] NULL,
	[saldo_camara] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_SALDO_BCCH] ADD  CONSTRAINT [DF__GEN_SALDO__Saldo__564CF689]  DEFAULT (0) FOR [saldo_inicio]
GO
ALTER TABLE [dbo].[GEN_SALDO_BCCH] ADD  CONSTRAINT [DF__GEN_SALDO__Saldo__57411AC2]  DEFAULT (0) FOR [saldo_final]
GO
ALTER TABLE [dbo].[GEN_SALDO_BCCH] ADD  CONSTRAINT [DF__GEN_SALDO__Saldo__58353EFB]  DEFAULT (0) FOR [saldo_camara]
GO
