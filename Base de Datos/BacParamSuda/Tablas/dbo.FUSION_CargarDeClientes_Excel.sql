USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FUSION_CargarDeClientes_Excel]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUSION_CargarDeClientes_Excel](
	[rutCliente] [varchar](10) NULL,
	[dvCliente] [char](1) NULL,
	[secuencia] [varchar](10) NULL,
	[codAS400] [varchar](10) NULL,
	[codCGI] [char](12) NULL
) ON [PRIMARY]
GO
