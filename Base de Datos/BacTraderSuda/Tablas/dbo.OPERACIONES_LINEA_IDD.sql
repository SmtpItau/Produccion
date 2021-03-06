USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[OPERACIONES_LINEA_IDD]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OPERACIONES_LINEA_IDD](
	[Codigo_producto] [char](5) NOT NULL,
	[Numdocu] [numeric](10, 0) NOT NULL,
	[Monto_IDD] [float] NOT NULL,
	[Correlativo] [numeric](2, 0) NOT NULL,
 CONSTRAINT [PK_OPERACIONES_LINEA_IDD] PRIMARY KEY CLUSTERED 
(
	[Codigo_producto] ASC,
	[Numdocu] ASC,
	[Monto_IDD] ASC,
	[Correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OPERACIONES_LINEA_IDD] ADD  CONSTRAINT [df_operaciones_linea_idd_Codigo_producto]  DEFAULT ('') FOR [Codigo_producto]
GO
ALTER TABLE [dbo].[OPERACIONES_LINEA_IDD] ADD  CONSTRAINT [df_operaciones_linea_idd_Numdocu]  DEFAULT ((0)) FOR [Numdocu]
GO
ALTER TABLE [dbo].[OPERACIONES_LINEA_IDD] ADD  CONSTRAINT [df_operaciones_linea_idd_Monto_IDD]  DEFAULT ((0.0)) FOR [Monto_IDD]
GO
ALTER TABLE [dbo].[OPERACIONES_LINEA_IDD] ADD  CONSTRAINT [df_operaciones_linea_idd_Correlativo]  DEFAULT ((0)) FOR [Correlativo]
GO
