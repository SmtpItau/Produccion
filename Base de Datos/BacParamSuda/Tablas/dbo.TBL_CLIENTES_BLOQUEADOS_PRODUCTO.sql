USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_CLIENTES_BLOQUEADOS_PRODUCTO]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CLIENTES_BLOQUEADOS_PRODUCTO](
	[Rut] [numeric](9, 0) NOT NULL,
	[Codigo] [int] NOT NULL,
	[Modulo] [char](3) NOT NULL,
	[Producto] [varchar](5) NOT NULL,
	[Bloqueado] [char](1) NOT NULL,
 CONSTRAINT [Pk_TBL_CLIENTES_BLOQUEADOS_PRODUCTO] PRIMARY KEY CLUSTERED 
(
	[Rut] ASC,
	[Codigo] ASC,
	[Modulo] ASC,
	[Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_CLIENTES_BLOQUEADOS_PRODUCTO] ADD  CONSTRAINT [df_TBL_CLIENTES_BLOQUEADOS_PRODUCTO_Rut]  DEFAULT (0) FOR [Rut]
GO
ALTER TABLE [dbo].[TBL_CLIENTES_BLOQUEADOS_PRODUCTO] ADD  CONSTRAINT [df_TBL_CLIENTES_BLOQUEADOS_PRODUCTO_Codigo]  DEFAULT (0) FOR [Codigo]
GO
ALTER TABLE [dbo].[TBL_CLIENTES_BLOQUEADOS_PRODUCTO] ADD  CONSTRAINT [df_TBL_CLIENTES_BLOQUEADOS_PRODUCTO_Modulo]  DEFAULT ('') FOR [Modulo]
GO
ALTER TABLE [dbo].[TBL_CLIENTES_BLOQUEADOS_PRODUCTO] ADD  CONSTRAINT [df_TBL_CLIENTES_BLOQUEADOS_PRODUCTO_Producto]  DEFAULT ('') FOR [Producto]
GO
ALTER TABLE [dbo].[TBL_CLIENTES_BLOQUEADOS_PRODUCTO] ADD  CONSTRAINT [df_TBL_CLIENTES_BLOQUEADOS_PRODUCTO_Bloqueado]  DEFAULT ('') FOR [Bloqueado]
GO
