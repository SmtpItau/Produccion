USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[VALOR_MONEDA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALOR_MONEDA](
	[vmcodigo] [numeric](5, 0) NOT NULL,
	[vmvalor] [float] NOT NULL,
	[vmptacmp] [float] NOT NULL,
	[vmptavta] [float] NOT NULL,
	[vmfecha] [datetime] NOT NULL,
	[vmparidad] [numeric](19, 4) NOT NULL,
	[vmposini] [numeric](19, 4) NOT NULL,
	[vmposic] [numeric](19, 4) NOT NULL,
	[vmtotco] [numeric](19, 4) NOT NULL,
	[vmtotve] [numeric](19, 4) NOT NULL,
	[vmvalor_BO] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmcodigo]  DEFAULT ((0)) FOR [vmcodigo]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmvalor]  DEFAULT ((0)) FOR [vmvalor]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmptacmp]  DEFAULT ((0)) FOR [vmptacmp]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmptavta]  DEFAULT ((0)) FOR [vmptavta]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmfecha]  DEFAULT ('') FOR [vmfecha]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmparidad]  DEFAULT ((0)) FOR [vmparidad]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmposini]  DEFAULT ((0)) FOR [vmposini]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmposic]  DEFAULT ((0)) FOR [vmposic]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmtotco]  DEFAULT ((0)) FOR [vmtotco]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmtotve]  DEFAULT ((0)) FOR [vmtotve]
GO
ALTER TABLE [dbo].[VALOR_MONEDA] ADD  CONSTRAINT [DF_VALOR_MONEDA_vmvalor_BO]  DEFAULT ((0)) FOR [vmvalor_BO]
GO
