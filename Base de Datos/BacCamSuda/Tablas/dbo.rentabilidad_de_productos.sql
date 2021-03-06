USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[rentabilidad_de_productos]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rentabilidad_de_productos](
	[Codigo_Producto] [numeric](3, 0) NOT NULL,
	[Nemo_Producto] [char](4) NOT NULL,
	[Glosa] [char](20) NOT NULL,
	[Relacion_Compra] [char](1) NOT NULL,
	[Relacion_Venta] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Codigo_Producto] ASC,
	[Nemo_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[rentabilidad_de_productos] ADD  CONSTRAINT [DF__rentabili__Glosa__04F2D6D9]  DEFAULT ('') FOR [Glosa]
GO
