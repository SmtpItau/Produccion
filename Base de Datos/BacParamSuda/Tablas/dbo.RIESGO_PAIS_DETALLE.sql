USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[RIESGO_PAIS_DETALLE]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RIESGO_PAIS_DETALLE](
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[fechainicio] [datetime] NOT NULL,
	[fechafinal] [datetime] NOT NULL,
	[montooperacion] [numeric](19, 0) NOT NULL,
	[usuario] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_pais] ASC,
	[numero_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RIESGO_PAIS_DETALLE] ADD  CONSTRAINT [DF__RIESGO_PA__Fecha__22028025]  DEFAULT (' ') FOR [fechainicio]
GO
ALTER TABLE [dbo].[RIESGO_PAIS_DETALLE] ADD  CONSTRAINT [DF__RIESGO_PA__Fecha__22F6A45E]  DEFAULT (' ') FOR [fechafinal]
GO
ALTER TABLE [dbo].[RIESGO_PAIS_DETALLE] ADD  CONSTRAINT [DF__RIESGO_PA__Monto__23EAC897]  DEFAULT (0) FOR [montooperacion]
GO
ALTER TABLE [dbo].[RIESGO_PAIS_DETALLE] ADD  CONSTRAINT [DF__RIESGO_PA__Usuar__24DEECD0]  DEFAULT (' ') FOR [usuario]
GO
ALTER TABLE [dbo].[RIESGO_PAIS_DETALLE]  WITH CHECK ADD FOREIGN KEY([codigo_pais])
REFERENCES [dbo].[RIESGO_PAIS] ([codigo_pais])
GO
