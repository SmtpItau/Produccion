USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[mdParametros]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdParametros](
	[fecha_proceso] [datetime] NOT NULL,
	[iniciodia] [char](1) NOT NULL,
	[findia] [char](1) NOT NULL,
	[fecha_proc_pct] [datetime] NOT NULL,
	[iniciodia_pct] [char](1) NOT NULL,
	[finfia_pct] [char](1) NOT NULL,
	[fecha_proc_pcc] [datetime] NOT NULL,
	[iniciodia_pcc] [char](1) NOT NULL,
	[finfia_pcc] [char](1) NOT NULL,
	[fecha_proc_pcf] [datetime] NOT NULL,
	[iniciodia_pcf] [char](1) NOT NULL,
	[finfia_pcf] [char](1) NOT NULL,
	[fecha_proc_pcs] [datetime] NOT NULL,
	[iniciodia_pcs] [char](1) NOT NULL,
	[finfia_pcs] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Fecha__3F3159AB]  DEFAULT ('') FOR [fecha_proceso]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Inici__40257DE4]  DEFAULT ('') FOR [iniciodia]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__FinDi__4119A21D]  DEFAULT ('') FOR [findia]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Fecha__420DC656]  DEFAULT ('') FOR [fecha_proc_pct]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Inici__4301EA8F]  DEFAULT ('') FOR [iniciodia_pct]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__FinFi__43F60EC8]  DEFAULT ('') FOR [finfia_pct]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Fecha__44EA3301]  DEFAULT ('') FOR [fecha_proc_pcc]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Inici__45DE573A]  DEFAULT ('') FOR [iniciodia_pcc]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__FinFi__46D27B73]  DEFAULT ('') FOR [finfia_pcc]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Fecha__47C69FAC]  DEFAULT ('') FOR [fecha_proc_pcf]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Inici__48BAC3E5]  DEFAULT ('') FOR [iniciodia_pcf]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__FinFi__49AEE81E]  DEFAULT ('') FOR [finfia_pcf]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Fecha__4AA30C57]  DEFAULT ('') FOR [fecha_proc_pcs]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__Inici__4B973090]  DEFAULT ('') FOR [iniciodia_pcs]
GO
ALTER TABLE [dbo].[mdParametros] ADD  CONSTRAINT [DF__mdParamet__FinFi__4C8B54C9]  DEFAULT ('') FOR [finfia_pcs]
GO
