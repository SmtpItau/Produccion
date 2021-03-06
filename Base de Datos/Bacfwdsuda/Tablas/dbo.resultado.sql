USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[resultado]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resultado](
	[fecha] [datetime] NOT NULL,
	[tipo] [char](9) NOT NULL,
	[saldo_usd] [numeric](21, 4) NOT NULL,
	[saldo_uf] [numeric](21, 4) NOT NULL,
	[variacion_tc] [numeric](21, 0) NOT NULL,
	[variacion_uf] [numeric](21, 0) NOT NULL,
	[devengo] [numeric](21, 0) NOT NULL,
	[devengo_pesos] [numeric](21, 0) NOT NULL,
	[devengo_uf] [numeric](21, 0) NOT NULL,
	[neto_dia] [numeric](21, 0) NOT NULL,
	[acumulado_tc] [numeric](21, 0) NOT NULL,
	[acumulado_uf] [numeric](21, 0) NOT NULL,
	[acumulado_devengo] [numeric](21, 0) NOT NULL,
	[acumulado_devengo_pesos] [numeric](21, 0) NOT NULL,
	[acumulado_devengo_uf] [numeric](21, 0) NOT NULL,
	[acumulado_neto] [numeric](21, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__fecha__1415EA2F]  DEFAULT (' ') FOR [fecha]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__tipo__150A0E68]  DEFAULT (' ') FOR [tipo]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__saldo__15FE32A1]  DEFAULT (0) FOR [saldo_usd]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__saldo__16F256DA]  DEFAULT (0) FOR [saldo_uf]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__varia__17E67B13]  DEFAULT (0) FOR [variacion_tc]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__varia__18DA9F4C]  DEFAULT (0) FOR [variacion_uf]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__deven__19CEC385]  DEFAULT (0) FOR [devengo]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__deven__1AC2E7BE]  DEFAULT (0) FOR [devengo_pesos]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__deven__1BB70BF7]  DEFAULT (0) FOR [devengo_uf]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__neto___1CAB3030]  DEFAULT (0) FOR [neto_dia]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__acumu__1D9F5469]  DEFAULT (0) FOR [acumulado_tc]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__acumu__1E9378A2]  DEFAULT (0) FOR [acumulado_uf]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__acumu__1F879CDB]  DEFAULT (0) FOR [acumulado_devengo]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__acumu__207BC114]  DEFAULT (0) FOR [acumulado_devengo_pesos]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__acumu__216FE54D]  DEFAULT (0) FOR [acumulado_devengo_uf]
GO
ALTER TABLE [dbo].[resultado] ADD  CONSTRAINT [DF__resultado__acumu__22640986]  DEFAULT (0) FOR [acumulado_neto]
GO
