USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Tbl_Operaciones_C18_Mesa]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Operaciones_C18_Mesa](
	[FechaCurse] [datetime] NOT NULL,
	[Moneda] [int] NOT NULL,
	[MedioPasgo] [int] NOT NULL,
	[Monto] [float] NOT NULL,
	[FechaVcto] [datetime] NOT NULL,
	[Codificacion] [numeric](9, 0) NOT NULL,
	[Origen] [char](3) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_Operaciones_C18_Mesa] ADD  CONSTRAINT [Df_Tbl_Operaciones_C18_Mesa_FechaCurse]  DEFAULT ('') FOR [FechaCurse]
GO
ALTER TABLE [dbo].[Tbl_Operaciones_C18_Mesa] ADD  CONSTRAINT [Df_Tbl_Operaciones_C18_Mesa_Moneda]  DEFAULT ((0)) FOR [Moneda]
GO
ALTER TABLE [dbo].[Tbl_Operaciones_C18_Mesa] ADD  CONSTRAINT [Df_Tbl_Operaciones_C18_Mesa_MedioPasgo]  DEFAULT ((0)) FOR [MedioPasgo]
GO
ALTER TABLE [dbo].[Tbl_Operaciones_C18_Mesa] ADD  CONSTRAINT [Df_Tbl_Operaciones_C18_Mesa_Monto]  DEFAULT ((0.0)) FOR [Monto]
GO
ALTER TABLE [dbo].[Tbl_Operaciones_C18_Mesa] ADD  CONSTRAINT [Df_Tbl_Operaciones_C18_Mesa_FechaVcto]  DEFAULT ('') FOR [FechaVcto]
GO
ALTER TABLE [dbo].[Tbl_Operaciones_C18_Mesa] ADD  CONSTRAINT [Df_Tbl_Operaciones_C18_Mesa_Codificacion]  DEFAULT ('') FOR [Codificacion]
GO
ALTER TABLE [dbo].[Tbl_Operaciones_C18_Mesa] ADD  CONSTRAINT [Df_Tbl_Operaciones_C18_Mesa_Origen]  DEFAULT ('') FOR [Origen]
GO
