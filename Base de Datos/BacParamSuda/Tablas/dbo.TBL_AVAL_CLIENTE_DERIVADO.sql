USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_AVAL_CLIENTE_DERIVADO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Cod_Cliente] [int] NOT NULL,
	[Rut_Aval] [numeric](9, 0) NOT NULL,
	[DV_Aval] [char](1) NOT NULL,
	[Nombre_Aval] [char](70) NOT NULL,
	[Razon_Social_Aval] [char](70) NOT NULL,
	[Profesion_Aval] [char](50) NOT NULL,
	[Direccion_Aval] [char](40) NOT NULL,
	[Comuna_Aval] [char](20) NOT NULL,
	[Ciudad_Aval] [char](30) NOT NULL,
	[Rut_Apod_Aval_1] [numeric](9, 0) NOT NULL,
	[Dv_RAA_1] [char](1) NOT NULL,
	[Nom_Apod_Aval_1] [char](70) NOT NULL,
	[Rut_Apod_Aval_2] [numeric](9, 0) NOT NULL,
	[Dv_RAA_2] [char](1) NOT NULL,
	[Nom_Apod_Aval_2] [char](70) NOT NULL,
	[Regimen_Conyuga_Aval] [char](50) NOT NULL,
	[Rut_Conyuge_Aval] [numeric](9, 0) NOT NULL,
	[Dv_RCA] [char](1) NOT NULL,
	[Nom_Conyuge_Aval] [char](70) NOT NULL,
	[Profesion_Conyuge_Aval] [char](50) NOT NULL,
 CONSTRAINT [PK__TBL_AVAL_CLIENTE_DERIVADO] PRIMARY KEY CLUSTERED 
(
	[Rut_Cliente] ASC,
	[Cod_Cliente] ASC,
	[Rut_Aval] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Rut_cliente]  DEFAULT (0) FOR [Rut_Cliente]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Cod_Cliente]  DEFAULT (0) FOR [Cod_Cliente]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Rut_Aval]  DEFAULT (0) FOR [Rut_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [DV_Aval]  DEFAULT ('') FOR [DV_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Nombre_Aval]  DEFAULT ('') FOR [Nombre_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Razon_Social_Aval]  DEFAULT ('') FOR [Razon_Social_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Profesion_Aval]  DEFAULT ('') FOR [Profesion_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Direccion_Aval]  DEFAULT ('') FOR [Direccion_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Comuna_Aval]  DEFAULT ('') FOR [Comuna_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Ciudad_Aval]  DEFAULT ('') FOR [Ciudad_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Rut_Apod_Aval_1]  DEFAULT (0) FOR [Rut_Apod_Aval_1]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Dv_RAA_1]  DEFAULT ('') FOR [Dv_RAA_1]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Nom_Apod_Aval_1]  DEFAULT ('') FOR [Nom_Apod_Aval_1]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Rut_Apod_Aval_2]  DEFAULT (0) FOR [Rut_Apod_Aval_2]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Dv_RAA_2]  DEFAULT ('') FOR [Dv_RAA_2]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Nom_Apod_Aval_2]  DEFAULT ('') FOR [Nom_Apod_Aval_2]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Regimen_Conyuga_Aval]  DEFAULT ('') FOR [Regimen_Conyuga_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Rut_Conyuge_Aval]  DEFAULT (0) FOR [Rut_Conyuge_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Dv_RCA]  DEFAULT ('') FOR [Dv_RCA]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Nom_Conyuge_Aval]  DEFAULT ('') FOR [Nom_Conyuge_Aval]
GO
ALTER TABLE [dbo].[TBL_AVAL_CLIENTE_DERIVADO] ADD  CONSTRAINT [Profesion_Conyuge_Aval]  DEFAULT ('') FOR [Profesion_Conyuge_Aval]
GO
