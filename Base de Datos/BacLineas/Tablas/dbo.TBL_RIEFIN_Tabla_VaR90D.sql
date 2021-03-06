USE [BacLineas]
GO
/****** Object:  Table [dbo].[TBL_RIEFIN_Tabla_VaR90D]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RIEFIN_Tabla_VaR90D](
	[Fecha] [datetime] NULL,
	[Rut] [int] NULL,
	[Codigo] [int] NULL,
	[Tipo_Operacion] [varchar](20) NULL,
	[Numero_Operacion] [int] NULL,
	[Var90D] [float] NULL,
	[Vehiculo] [varchar](15) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_RIEFIN_Tabla_VaR90D] ADD  CONSTRAINT [DF_TBL_RIEFIN_Tabla_VaR90D_Vehiculo]  DEFAULT ('CORPBANCA') FOR [Vehiculo]
GO
