USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_Mov_Garantia]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Mov_Garantia](
	[RutCliente] [numeric](9, 0) NOT NULL,
	[CodCliente] [numeric](5, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[TipoMovimiento] [varchar](3) NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[FactorAditivo] [numeric](18, 4) NOT NULL,
	[TotalMovimiento] [numeric](21, 0) NOT NULL,
	[FechaVigencia] [datetime] NOT NULL,
	[Estado] [varchar](1) NOT NULL,
	[Observaciones] [varchar](255) NOT NULL,
	[Usuario] [varchar](15) NOT NULL,
	[TipoGarantia] [tinyint] NOT NULL,
 CONSTRAINT [PK_tbl_Mov_Garantia] PRIMARY KEY CLUSTERED 
(
	[NumeroOperacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  DEFAULT (0) FOR [RutCliente]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  DEFAULT (0) FOR [CodCliente]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  DEFAULT ('') FOR [TipoMovimiento]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  DEFAULT (0) FOR [NumeroOperacion]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  DEFAULT (0) FOR [FactorAditivo]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  CONSTRAINT [DF_Table_1_VPAR]  DEFAULT (0) FOR [TotalMovimiento]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  CONSTRAINT [DF_tbl_Mov_Garantia_FechaVigencia]  DEFAULT ('') FOR [FechaVigencia]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  CONSTRAINT [DF_Table_1_ValorPresente]  DEFAULT ('') FOR [Estado]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  CONSTRAINT [DF_Table_1_FechaEmision]  DEFAULT ('') FOR [Observaciones]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  CONSTRAINT [DF_tbl_Mov_Garantia_Usuario]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[tbl_Mov_Garantia] ADD  DEFAULT (1) FOR [TipoGarantia]
GO
