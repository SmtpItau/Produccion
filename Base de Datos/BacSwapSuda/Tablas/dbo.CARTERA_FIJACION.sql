USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[CARTERA_FIJACION]    Script Date: 13-05-2022 11:14:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARTERA_FIJACION](
	[numero_operacion] [numeric](7, 0) NOT NULL,
	[numero_flujo] [numeric](3, 0) NOT NULL,
	[tipo_flujo] [numeric](1, 0) NOT NULL,
	[fecha_rescate] [datetime] NOT NULL,
	[valor_tasa] [float] NOT NULL,
	[digitaSN] [char](1) NULL
) ON [PRIMARY]
GO
