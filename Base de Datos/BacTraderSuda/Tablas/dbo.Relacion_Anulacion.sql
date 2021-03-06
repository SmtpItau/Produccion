USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Relacion_Anulacion]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Relacion_Anulacion](
	[fecha_operacion] [datetime] NOT NULL,
	[numero_operacion] [numeric](10, 0) NOT NULL,
	[numero_certificado_dcv] [numeric](13, 0) NOT NULL,
	[CodigoCtaCliente] [char](20) NULL,
	[SecImposicion] [char](5) NULL
) ON [PRIMARY]
GO
