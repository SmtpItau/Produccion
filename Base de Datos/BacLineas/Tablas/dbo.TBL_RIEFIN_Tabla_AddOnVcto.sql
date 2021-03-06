USE [BacLineas]
GO
/****** Object:  Table [dbo].[TBL_RIEFIN_Tabla_AddOnVcto]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RIEFIN_Tabla_AddOnVcto](
	[Fecha] [datetime] NOT NULL,
	[Rut] [int] NOT NULL,
	[Codigo] [int] NOT NULL,
	[Tipo_Operacion] [varchar](20) NOT NULL,
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[MtoPrinc] [float] NULL,
	[Prc] [float] NULL,
	[AddOnVcto] [float] NULL,
	[MtoM] [float] NULL,
	[Plazo] [float] NULL,
	[Vehiculo] [varchar](15) NOT NULL,
 CONSTRAINT [PK_TBL_RIEFIN_Tabla_AddOnVcto] PRIMARY KEY CLUSTERED 
(
	[Vehiculo] ASC,
	[Fecha] ASC,
	[Rut] ASC,
	[Codigo] ASC,
	[Tipo_Operacion] ASC,
	[Numero_Operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_RIEFIN_Tabla_AddOnVcto] ADD  CONSTRAINT [DF_TBL_RIEFIN_Tabla_AddOnVcto_Vehiculo]  DEFAULT ('CORPBANCA') FOR [Vehiculo]
GO
