USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TblRelacionPCtasContables]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblRelacionPCtasContables](
	[idCodigo] [smallint] NOT NULL,
	[sFamilia] [varchar](6) NOT NULL,
	[iMoneda] [smallint] NOT NULL,
	[idCartera] [varchar](2) NOT NULL,
	[CtaIBS] [varchar](15) NOT NULL,
	[CtaSUPER] [varchar](40) NOT NULL,
	[CtaCOSIF] [varchar](40) NOT NULL,
	[CtaGLCODE] [varchar](40) NOT NULL,
	[CtaCOSIF_GER] [varchar](40) NOT NULL,
	[CtaOTRA1] [varchar](40) NOT NULL,
	[CtaOTRA2] [varchar](40) NOT NULL,
	[CtaOTRA3] [varchar](40) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TblRelacionPCtasContables] ADD  DEFAULT ('') FOR [idCartera]
GO
ALTER TABLE [dbo].[TblRelacionPCtasContables] ADD  DEFAULT ('') FOR [CtaIBS]
GO
ALTER TABLE [dbo].[TblRelacionPCtasContables] ADD  DEFAULT ('') FOR [CtaSUPER]
GO
ALTER TABLE [dbo].[TblRelacionPCtasContables] ADD  DEFAULT ('') FOR [CtaCOSIF]
GO
ALTER TABLE [dbo].[TblRelacionPCtasContables] ADD  DEFAULT ('') FOR [CtaGLCODE]
GO
ALTER TABLE [dbo].[TblRelacionPCtasContables] ADD  DEFAULT ('') FOR [CtaCOSIF_GER]
GO
ALTER TABLE [dbo].[TblRelacionPCtasContables] ADD  DEFAULT ('') FOR [CtaOTRA1]
GO
ALTER TABLE [dbo].[TblRelacionPCtasContables] ADD  DEFAULT ('') FOR [CtaOTRA2]
GO
ALTER TABLE [dbo].[TblRelacionPCtasContables] ADD  DEFAULT ('') FOR [CtaOTRA3]
GO
