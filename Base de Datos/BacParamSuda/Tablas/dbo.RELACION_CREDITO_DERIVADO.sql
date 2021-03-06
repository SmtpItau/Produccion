USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[RELACION_CREDITO_DERIVADO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RELACION_CREDITO_DERIVADO](
	[Fecha_Relacion] [datetime] NOT NULL,
	[Numero_Credito] [numeric](9, 0) NOT NULL,
	[Numero_Derivado] [numeric](9, 0) NOT NULL,
	[Modulo_Derivado] [char](3) NOT NULL,
	[Producto_Derivado] [int] NOT NULL,
	[Ajuste_Nocionales] [char](1) NOT NULL,
	[Estado] [int] NOT NULL,
	[RutCliente] [numeric](9, 0) NOT NULL,
	[CodCliente] [int] NOT NULL,
 CONSTRAINT [Pk_RELACION_CREDITO_DERIVADO] PRIMARY KEY CLUSTERED 
(
	[Numero_Credito] ASC,
	[Numero_Derivado] ASC,
	[Modulo_Derivado] ASC,
	[Producto_Derivado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RELACION_CREDITO_DERIVADO] ADD  CONSTRAINT [df_RELACION_CREDITO_DERIVADO_Fecha_Relacion]  DEFAULT ('') FOR [Fecha_Relacion]
GO
ALTER TABLE [dbo].[RELACION_CREDITO_DERIVADO] ADD  CONSTRAINT [df_RELACION_CREDITO_DERIVADO_Numero_Credito]  DEFAULT (0) FOR [Numero_Credito]
GO
ALTER TABLE [dbo].[RELACION_CREDITO_DERIVADO] ADD  CONSTRAINT [df_RELACION_CREDITO_DERIVADO_Numero_Derivado]  DEFAULT (0) FOR [Numero_Derivado]
GO
ALTER TABLE [dbo].[RELACION_CREDITO_DERIVADO] ADD  CONSTRAINT [df_RELACION_CREDITO_DERIVADO_Modulo_Derivado]  DEFAULT (0) FOR [Modulo_Derivado]
GO
ALTER TABLE [dbo].[RELACION_CREDITO_DERIVADO] ADD  CONSTRAINT [df_RELACION_CREDITO_DERIVADO_Producto_Derivado]  DEFAULT (0) FOR [Producto_Derivado]
GO
ALTER TABLE [dbo].[RELACION_CREDITO_DERIVADO] ADD  CONSTRAINT [df_RELACION_CREDITO_DERIVADO_Ajuste_Nocionales]  DEFAULT ('') FOR [Ajuste_Nocionales]
GO
ALTER TABLE [dbo].[RELACION_CREDITO_DERIVADO] ADD  CONSTRAINT [df_RELACION_CREDITO_DERIVADO_Estado]  DEFAULT (0) FOR [Estado]
GO
ALTER TABLE [dbo].[RELACION_CREDITO_DERIVADO] ADD  CONSTRAINT [df_RELACION_CREDITO_DERIVADO_RutCliente]  DEFAULT (0) FOR [RutCliente]
GO
ALTER TABLE [dbo].[RELACION_CREDITO_DERIVADO] ADD  CONSTRAINT [df_RELACION_CREDITO_DERIVADO_CodCliente]  DEFAULT (0) FOR [CodCliente]
GO
