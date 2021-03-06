USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CargaOperaciones_Productos]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CargaOperaciones_Productos](
	[idProducto] [smallint] NOT NULL,
	[sDescripcion] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CargaOperaciones_Productos] ADD  DEFAULT ((0)) FOR [idProducto]
GO
ALTER TABLE [dbo].[CargaOperaciones_Productos] ADD  DEFAULT ('') FOR [sDescripcion]
GO
