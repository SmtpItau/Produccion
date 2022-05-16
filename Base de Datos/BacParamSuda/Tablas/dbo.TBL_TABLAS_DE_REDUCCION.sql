USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_TABLAS_DE_REDUCCION]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_TABLAS_DE_REDUCCION](
	[Segmento] [int] NOT NULL,
	[Internacional] [int] NOT NULL,
	[Nacional] [int] NOT NULL,
	[Porcentaje] [numeric](3, 0) NOT NULL,
	[Monto] [numeric](21, 4) NOT NULL,
 CONSTRAINT [Pk_TBL_TABLAS_DE_REDUCCION] PRIMARY KEY CLUSTERED 
(
	[Segmento] ASC,
	[Internacional] ASC,
	[Nacional] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_TABLAS_DE_REDUCCION] ADD  CONSTRAINT [df_TBL_TABLAS_DE_REDUCCION_Segmento]  DEFAULT (0) FOR [Segmento]
GO
ALTER TABLE [dbo].[TBL_TABLAS_DE_REDUCCION] ADD  CONSTRAINT [df_TBL_TABLAS_DE_REDUCCION_Internacional]  DEFAULT (0) FOR [Internacional]
GO
ALTER TABLE [dbo].[TBL_TABLAS_DE_REDUCCION] ADD  CONSTRAINT [df_TBL_TABLAS_DE_REDUCCION_Nacional]  DEFAULT (0) FOR [Nacional]
GO
ALTER TABLE [dbo].[TBL_TABLAS_DE_REDUCCION] ADD  CONSTRAINT [df_TBL_TABLAS_DE_REDUCCION_Procentaje]  DEFAULT (0.0) FOR [Porcentaje]
GO
ALTER TABLE [dbo].[TBL_TABLAS_DE_REDUCCION] ADD  CONSTRAINT [df_TBL_TABLAS_DE_REDUCCION_Monto]  DEFAULT (0.0) FOR [Monto]
GO
