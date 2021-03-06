USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CREDITOS_IBS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CREDITOS_IBS](
	[Numero_Credito] [numeric](9, 0) NOT NULL,
	[Rut_Cliente] [numeric](10, 0) NOT NULL,
	[Dv_Cliente] [char](1) NOT NULL,
	[Codigo_Cliente] [int] NOT NULL,
	[Nombre_Cliente] [varchar](70) NOT NULL,
	[Moneda] [int] NOT NULL,
	[Monto_Capital] [float] NOT NULL,
	[Fecha_Vencimiento] [datetime] NOT NULL,
	[Estado] [int] NOT NULL,
 CONSTRAINT [Pk_CREDITOS_IBS] PRIMARY KEY CLUSTERED 
(
	[Numero_Credito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CREDITOS_IBS] ADD  CONSTRAINT [df_CREDITOS_IBS_Numero_Credito]  DEFAULT (0) FOR [Numero_Credito]
GO
ALTER TABLE [dbo].[CREDITOS_IBS] ADD  CONSTRAINT [df_CREDITOS_IBS_Rut_Cliente]  DEFAULT (0) FOR [Rut_Cliente]
GO
ALTER TABLE [dbo].[CREDITOS_IBS] ADD  CONSTRAINT [df_CREDITOS_IBS_Dv_Cliente]  DEFAULT ('') FOR [Dv_Cliente]
GO
ALTER TABLE [dbo].[CREDITOS_IBS] ADD  CONSTRAINT [df_CREDITOS_IBS_Codigo_Cliente]  DEFAULT (0) FOR [Codigo_Cliente]
GO
ALTER TABLE [dbo].[CREDITOS_IBS] ADD  CONSTRAINT [df_CREDITOS_IBS_Nombre_Cliente]  DEFAULT ('') FOR [Nombre_Cliente]
GO
ALTER TABLE [dbo].[CREDITOS_IBS] ADD  CONSTRAINT [df_CREDITOS_IBS_Moneda]  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[CREDITOS_IBS] ADD  CONSTRAINT [df_CREDITOS_IBS_Monto_Capital]  DEFAULT (0) FOR [Monto_Capital]
GO
ALTER TABLE [dbo].[CREDITOS_IBS] ADD  CONSTRAINT [df_CREDITOS_IBS_Fecha_Vencimiento]  DEFAULT ('') FOR [Fecha_Vencimiento]
GO
ALTER TABLE [dbo].[CREDITOS_IBS] ADD  CONSTRAINT [df_CREDITOS_IBS_Estado]  DEFAULT (0) FOR [Estado]
GO
