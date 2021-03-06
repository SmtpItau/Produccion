USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_REG_MODIFICACIONES_OPT]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT](
	[FechaModificacion] [datetime] NOT NULL,
	[HoraModificacion] [varchar](8) NOT NULL,
	[Modulo] [char](3) NOT NULL,
	[FolioContrato] [numeric](10, 0) NOT NULL,
	[FolioModificacion] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](9, 0) NOT NULL,
	[Item] [varchar](50) NOT NULL,
	[DatosOriginales] [varchar](255) NULL,
	[DatosNuevos] [varchar](255) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT] ADD  CONSTRAINT [df_TBL_REG_MODIFICACIONES_OPT_FechaModificacion]  DEFAULT ('') FOR [FechaModificacion]
GO
ALTER TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT] ADD  CONSTRAINT [df_TBL_REG_MODIFICACIONES_OPT_HoraModificacion]  DEFAULT ('') FOR [HoraModificacion]
GO
ALTER TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT] ADD  CONSTRAINT [df_TBL_REG_MODIFICACIONES_OPT_Modulo]  DEFAULT ('') FOR [Modulo]
GO
ALTER TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT] ADD  CONSTRAINT [df_TBL_REG_MODIFICACIONES_OPT_FolioContrato]  DEFAULT ((0)) FOR [FolioContrato]
GO
ALTER TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT] ADD  CONSTRAINT [df_TBL_REG_MODIFICACIONES_OPT_FolioModificacion]  DEFAULT ((0)) FOR [FolioModificacion]
GO
ALTER TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT] ADD  CONSTRAINT [df_TBL_REG_MODIFICACIONES_OPT_Correlativo]  DEFAULT ((0)) FOR [Correlativo]
GO
ALTER TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT] ADD  CONSTRAINT [df_TBL_REG_MODIFICACIONES_OPT_Items]  DEFAULT ('') FOR [Item]
GO
ALTER TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT] ADD  CONSTRAINT [df_TBL_REG_MODIFICACIONES_OPT_DatosOriginales]  DEFAULT ('') FOR [DatosOriginales]
GO
ALTER TABLE [dbo].[TBL_REG_MODIFICACIONES_OPT] ADD  CONSTRAINT [df_TBL_REG_MODIFICACIONES_OPT_DatosNuevos]  DEFAULT ('') FOR [DatosNuevos]
GO
