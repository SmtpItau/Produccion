USE [BacLineas]
GO
/****** Object:  Table [dbo].[TBL_RIEFIN_General_REC_FIL]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RIEFIN_General_REC_FIL](
	[Fecha] [datetime] NOT NULL,
	[Rut] [int] NOT NULL,
	[Codigo] [int] NOT NULL,
	[Codigo_Metodologia] [int] NULL,
	[Nombre] [varchar](70) NULL,
	[Linea] [float] NULL,
	[Treshold] [float] NULL,
	[Valor_Mercado] [float] NULL,
	[Exposicion_Maxima] [float] NULL,
	[VaR90D] [float] NULL,
	[AddOnAlVcto] [float] NULL,
	[Garantia_Ejecutada] [char](2) NULL,
	[Consumo_Linea] [float] NULL,
	[Holgura] [float] NULL,
	[Estado_Linea] [varchar](50) NULL,
	[Rec_Tradicional] [float] NULL,
	[Met_ConNettingConTreshold] [float] NULL,
	[Met_ConNettingSinTreshold] [float] NULL,
	[Tipo_Cambio] [float] NULL,
	[Vehiculo] [varchar](15) NOT NULL,
 CONSTRAINT [PK_TBL_RIEFIN_General_REC_FIL] PRIMARY KEY CLUSTERED 
(
	[Vehiculo] ASC,
	[Fecha] ASC,
	[Rut] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
