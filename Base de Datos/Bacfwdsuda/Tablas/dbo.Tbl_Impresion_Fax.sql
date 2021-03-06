USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[Tbl_Impresion_Fax]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Impresion_Fax](
	[Modulo] [char](5) NOT NULL,
	[Folio] [numeric](9, 0) NOT NULL,
	[Usuario] [varchar](15) NOT NULL,
	[FechaProceso] [datetime] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Hora] [char](10) NOT NULL,
	[FechaContrato] [datetime] NOT NULL,
	[Modifica] [int] NOT NULL,
	[FechaModifica] [datetime] NOT NULL,
 CONSTRAINT [Pk_Tbl_Impresion_Fax] PRIMARY KEY CLUSTERED 
(
	[Modulo] ASC,
	[Folio] ASC,
	[Usuario] ASC,
	[FechaProceso] ASC,
	[Fecha] ASC,
	[Hora] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_Impresion_Fax] ADD  CONSTRAINT [df_Tbl_Impresion_Fax_Modulo]  DEFAULT ('') FOR [Modulo]
GO
ALTER TABLE [dbo].[Tbl_Impresion_Fax] ADD  CONSTRAINT [df_Tbl_Impresion_Fax_Folio]  DEFAULT ((0)) FOR [Folio]
GO
ALTER TABLE [dbo].[Tbl_Impresion_Fax] ADD  CONSTRAINT [df_Tbl_Impresion_Fax_Usuario]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[Tbl_Impresion_Fax] ADD  CONSTRAINT [df_Tbl_Impresion_Fax_FechaProceso]  DEFAULT ('') FOR [FechaProceso]
GO
ALTER TABLE [dbo].[Tbl_Impresion_Fax] ADD  CONSTRAINT [df_Tbl_Impresion_Fax_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[Tbl_Impresion_Fax] ADD  CONSTRAINT [df_Tbl_Impresion_Fax_Hora]  DEFAULT ('') FOR [Hora]
GO
ALTER TABLE [dbo].[Tbl_Impresion_Fax] ADD  CONSTRAINT [df_Tbl_Impresion_Fax_FechaContrato]  DEFAULT ('') FOR [FechaContrato]
GO
ALTER TABLE [dbo].[Tbl_Impresion_Fax] ADD  CONSTRAINT [df_Tbl_Impresion_Fax_Modifica]  DEFAULT ((0)) FOR [Modifica]
GO
ALTER TABLE [dbo].[Tbl_Impresion_Fax] ADD  CONSTRAINT [df_Tbl_Impresion_Fax_FechaModifica]  DEFAULT ('') FOR [FechaModifica]
GO
