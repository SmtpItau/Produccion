USE [Reportes]
GO
/****** Object:  Table [dbo].[ReportesMercadoCliente]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportesMercadoCliente](
	[ReSistema] [varchar](10) NOT NULL,
	[ReId] [varchar](10) NOT NULL,
	[ReDescripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TBL_ESTRUCTURAS_RELACION] PRIMARY KEY CLUSTERED 
(
	[ReDescripcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
