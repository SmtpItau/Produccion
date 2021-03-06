USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Tbl_Control_Silencioso]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Control_Silencioso](
	[codModulo] [char](3) NULL,
	[numOper] [numeric](9, 0) NOT NULL,
	[codProducto] [varchar](5) NULL,
	[tipoOp] [char](1) NULL,
	[Plazo] [int] NULL,
	[Tasa] [numeric](19, 4) NOT NULL,
	[Diferencia] [numeric](19, 4) NOT NULL,
	[Mensaje] [varchar](255) NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[BandaSuperior] [numeric](19, 4) NULL,
	[BandaInferior] [numeric](19, 4) NULL,
	[FechaProceso] [datetime] NULL,
	[Correlativo] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_Control_Silencioso] ADD  DEFAULT ((1)) FOR [Correlativo]
GO
