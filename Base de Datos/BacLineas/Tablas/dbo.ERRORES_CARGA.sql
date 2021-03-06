USE [BacLineas]
GO
/****** Object:  Table [dbo].[ERRORES_CARGA]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERRORES_CARGA](
	[Fecha_Proceso] [datetime] NOT NULL,
	[Sistema] [char](3) NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Cod_Cliente] [numeric](9, 0) NOT NULL,
	[Cod_Producto] [char](5) NOT NULL,
	[Fecha_Vencimiento] [datetime] NOT NULL,
	[Numero_operacion] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ERRORES_CARGA] ADD  CONSTRAINT [DF__ERRORES_C__Fecha__1A89E4E1]  DEFAULT ('') FOR [Fecha_Proceso]
GO
ALTER TABLE [dbo].[ERRORES_CARGA] ADD  CONSTRAINT [DF__ERRORES_C__Siste__1B7E091A]  DEFAULT ('') FOR [Sistema]
GO
ALTER TABLE [dbo].[ERRORES_CARGA] ADD  CONSTRAINT [DF__ERRORES_C__Rut_C__1C722D53]  DEFAULT (0) FOR [Rut_Cliente]
GO
ALTER TABLE [dbo].[ERRORES_CARGA] ADD  CONSTRAINT [DF__ERRORES_C__Cod_C__1D66518C]  DEFAULT (0) FOR [Cod_Cliente]
GO
ALTER TABLE [dbo].[ERRORES_CARGA] ADD  CONSTRAINT [DF__ERRORES_C__Cod_P__1E5A75C5]  DEFAULT ('') FOR [Cod_Producto]
GO
ALTER TABLE [dbo].[ERRORES_CARGA] ADD  CONSTRAINT [DF__ERRORES_C__Fecha__1F4E99FE]  DEFAULT ('') FOR [Fecha_Vencimiento]
GO
ALTER TABLE [dbo].[ERRORES_CARGA] ADD  CONSTRAINT [DF__ERRORES_C__Numer__2042BE37]  DEFAULT (0) FOR [Numero_operacion]
GO
