USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PRODUCTO_EVENTO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_EVENTO](
	[codigo_producto] [char](5) NOT NULL,
	[codigo_evento] [char](5) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_producto] ASC,
	[codigo_evento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PRODUCTO_EVENTO]  WITH CHECK ADD FOREIGN KEY([codigo_producto])
REFERENCES [dbo].[PRODUCTO] ([codigo_producto])
GO
