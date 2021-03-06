USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PRODUCTO_LBTR]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_LBTR](
	[id_Sistema] [char](3) NOT NULL,
	[Producto] [char](5) NOT NULL,
	[Operacion] [char](5) NOT NULL,
	[Movimiento] [char](1) NOT NULL,
	[Producto_LBTR] [char](10) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [Pk_Producto_Lbtr] PRIMARY KEY CLUSTERED 
(
	[id_Sistema] ASC,
	[Producto] ASC,
	[Operacion] ASC,
	[Movimiento] ASC,
	[Producto_LBTR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PRODUCTO_LBTR] ADD  CONSTRAINT [Df_producto_lbtr_Sistema]  DEFAULT ('') FOR [id_Sistema]
GO
ALTER TABLE [dbo].[PRODUCTO_LBTR] ADD  CONSTRAINT [Df_producto_lbtr_Producto]  DEFAULT ('') FOR [Producto]
GO
ALTER TABLE [dbo].[PRODUCTO_LBTR] ADD  CONSTRAINT [Df_producto_lbtr_Operacion]  DEFAULT ('') FOR [Operacion]
GO
ALTER TABLE [dbo].[PRODUCTO_LBTR] ADD  CONSTRAINT [Df_producto_lbtr_Movimiento]  DEFAULT ('M') FOR [Movimiento]
GO
ALTER TABLE [dbo].[PRODUCTO_LBTR] ADD  CONSTRAINT [Df_producto_lbtr_ProductoLbtr]  DEFAULT ('') FOR [Producto_LBTR]
GO
ALTER TABLE [dbo].[PRODUCTO_LBTR] ADD  CONSTRAINT [Df_producto_lbtr_Descripcion]  DEFAULT ('') FOR [Descripcion]
GO
