USE [BacLineas]
GO
/****** Object:  Table [dbo].[POSICION_GRUPO_PRODUCTO]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POSICION_GRUPO_PRODUCTO](
	[codigo_producto] [char](5) NOT NULL,
	[codigo_grupo] [varchar](5) NOT NULL,
	[totalcompra] [numeric](19, 4) NOT NULL,
	[totalventa] [numeric](19, 4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_producto] ASC,
	[codigo_grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_PRODUCTO] ADD  CONSTRAINT [DF__POSICION___Total__391AEFA7]  DEFAULT (0) FOR [totalcompra]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_PRODUCTO] ADD  CONSTRAINT [DF__POSICION___Total__3A0F13E0]  DEFAULT (0) FOR [totalventa]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_PRODUCTO]  WITH CHECK ADD FOREIGN KEY([codigo_grupo])
REFERENCES [dbo].[POSICION_GRUPO] ([codigo_grupo])
GO
