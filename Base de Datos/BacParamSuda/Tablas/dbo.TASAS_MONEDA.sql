USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TASAS_MONEDA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASAS_MONEDA](
	[Codigo_Moneda] [numeric](5, 0) NOT NULL,
	[Codigo_Tasa] [numeric](5, 0) NOT NULL,
 CONSTRAINT [pk_tasas_moneda] PRIMARY KEY NONCLUSTERED 
(
	[Codigo_Moneda] ASC,
	[Codigo_Tasa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TASAS_MONEDA] ADD  CONSTRAINT [df_tasas_moneda_codigo_moneda]  DEFAULT (0) FOR [Codigo_Moneda]
GO
ALTER TABLE [dbo].[TASAS_MONEDA] ADD  CONSTRAINT [df_tasas_moneda_codigo_tasa]  DEFAULT (0) FOR [Codigo_Tasa]
GO
