USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Tbl_Tributarios_Ajustes]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Tributarios_Ajustes](
	[Fecha] [datetime] NOT NULL,
	[Origen] [char](3) NOT NULL,
	[Contrato] [numeric](9, 0) NOT NULL,
	[Monto] [numeric](21, 4) NOT NULL,
	[Cuenta] [varchar](50) NOT NULL,
	[CuentaRes] [varchar](50) NULL,
 CONSTRAINT [Pk_Tbl_Tributarios_Ajustes] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[Origen] ASC,
	[Contrato] ASC,
	[Monto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_Tributarios_Ajustes] ADD  CONSTRAINT [Df_Tbl_Tributarios_Ajustes_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[Tbl_Tributarios_Ajustes] ADD  CONSTRAINT [Df_Tbl_Tributarios_Ajustes_Origen]  DEFAULT ('') FOR [Origen]
GO
ALTER TABLE [dbo].[Tbl_Tributarios_Ajustes] ADD  CONSTRAINT [Df_Tbl_Tributarios_Ajustes_Contrato]  DEFAULT ((0)) FOR [Contrato]
GO
ALTER TABLE [dbo].[Tbl_Tributarios_Ajustes] ADD  CONSTRAINT [Df_Tbl_Tributarios_Ajustes_Monto]  DEFAULT ((0.0)) FOR [Monto]
GO
ALTER TABLE [dbo].[Tbl_Tributarios_Ajustes] ADD  CONSTRAINT [df_Tbl_Tributarios_Ajustes_Cuenta]  DEFAULT ('') FOR [Cuenta]
GO
