USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[LETRA_HIPOTECARIA_CORTE]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LETRA_HIPOTECARIA_CORTE](
	[codigo_planilla] [numeric](10, 0) NOT NULL,
	[correlativo] [numeric](10, 0) NOT NULL,
	[corte_numero] [numeric](10, 0) NOT NULL,
	[corte_monto] [numeric](19, 4) NOT NULL,
	[corte_nominal] [numeric](19, 4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_planilla] ASC,
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA_CORTE] ADD  CONSTRAINT [DF__LETRA_HIP__corte__73F33360]  DEFAULT (0) FOR [corte_numero]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA_CORTE] ADD  CONSTRAINT [DF__LETRA_HIP__corte__74E75799]  DEFAULT (0) FOR [corte_monto]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA_CORTE] ADD  CONSTRAINT [DF__LETRA_HIP__corte__75DB7BD2]  DEFAULT (0) FOR [corte_nominal]
GO
ALTER TABLE [dbo].[LETRA_HIPOTECARIA_CORTE]  WITH CHECK ADD FOREIGN KEY([codigo_planilla])
REFERENCES [dbo].[LETRA_HIPOTECARIA] ([codigo_planilla])
GO
