USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CARGASOMA]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARGASOMA](
	[Fecha_Proceso] [datetime] NOT NULL,
	[Hora_Ingreso] [char](15) NULL,
	[Numdocu] [numeric](9, 0) NOT NULL,
	[Numoper] [numeric](9, 0) NOT NULL,
	[Correlativo] [numeric](3, 0) NOT NULL,
	[Instserie] [char](12) NULL,
	[Tipo_operacion] [char](3) NULL,
	[Nominal] [numeric](19, 4) NULL,
	[Plazo_residual] [numeric](6, 0) NULL,
	[Tasa_referencial] [numeric](19, 4) NULL,
	[Valor_referencial] [numeric](19, 4) NULL,
	[Margen] [float] NULL,
	[Valor_Inicial] [numeric](19, 4) NULL,
	[Valor_Final] [numeric](19, 4) NULL,
	[Cta_destino] [numeric](11, 0) NULL,
	[Cta_Lbtr] [numeric](11, 0) NULL,
	[Cta_Dcv] [numeric](7, 0) NULL,
	[Estado_Dcv] [char](20) NULL,
	[Correlativo_SOMA] [numeric](3, 0) NULL,
	[Observacion] [char](70) NULL,
	[diferencia] [numeric](19, 4) NULL,
	[CorrelOpe] [numeric](10, 0) NOT NULL,
	[HairCut] [float] NOT NULL,
	[FolioBCCH] [numeric](9, 0) NOT NULL,
	[CorrelaBCCH] [numeric](3, 0) NOT NULL,
 CONSTRAINT [PK_CARGASOMA] PRIMARY KEY CLUSTERED 
(
	[Fecha_Proceso] ASC,
	[Numdocu] ASC,
	[Numoper] ASC,
	[Correlativo] ASC,
	[CorrelOpe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CARGASOMA] ADD  CONSTRAINT [df_CARGASOMA_HairCut]  DEFAULT (0.0) FOR [HairCut]
GO
ALTER TABLE [dbo].[CARGASOMA] ADD  CONSTRAINT [df_CARGASOMA_FolioBCCH]  DEFAULT (0) FOR [FolioBCCH]
GO
ALTER TABLE [dbo].[CARGASOMA] ADD  CONSTRAINT [df_CARGASOMA_CorrelaBCCH]  DEFAULT (0) FOR [CorrelaBCCH]
GO
