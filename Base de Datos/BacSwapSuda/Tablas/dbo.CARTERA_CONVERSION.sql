USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[CARTERA_CONVERSION]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARTERA_CONVERSION](
	[numero_operacion] [numeric](7, 0) NOT NULL,
	[numero_flujo] [numeric](3, 0) NOT NULL,
	[tipo_flujo] [numeric](1, 0) NOT NULL,
	[fecha_rescate] [datetime] NOT NULL,
	[valor] [float] NOT NULL,
	[digitaSN] [char](1) NULL,
	[TCMoParidad] [varchar](10) NOT NULL,
 CONSTRAINT [PK_TBL_CAJA_DERIVADOS_1] PRIMARY KEY CLUSTERED 
(
	[numero_operacion] ASC,
	[numero_flujo] ASC,
	[tipo_flujo] ASC,
	[TCMoParidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
