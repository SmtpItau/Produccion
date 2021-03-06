USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ResFusion_EMISOR]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResFusion_EMISOR](
	[emcodigo] [numeric](9, 0) NOT NULL,
	[emrut] [numeric](9, 0) NOT NULL,
	[emdv] [char](1) NOT NULL,
	[emnombre] [char](40) NOT NULL,
	[emgeneric] [char](10) NOT NULL,
	[emdirecc] [char](40) NULL,
	[emcomuna] [numeric](4, 0) NULL,
	[emtipo] [char](3) NOT NULL,
	[emglosa] [char](20) NULL,
	[embonos] [char](20) NULL,
	[clasificacion1] [char](40) NOT NULL,
	[clasificacion2] [char](40) NOT NULL,
	[tipo_corto1] [char](30) NOT NULL,
	[tipo_largo1] [char](30) NOT NULL,
	[tipo_corto2] [char](30) NOT NULL,
	[tipo_largo2] [char](30) NOT NULL
) ON [PRIMARY]
GO
