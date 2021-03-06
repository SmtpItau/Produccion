USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LIMITE_TOTAL_ENDEUDAMIENTO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIMITE_TOTAL_ENDEUDAMIENTO](
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[outstanding] [numeric](19, 2) NULL,
	[activo_circulante] [numeric](19, 2) NULL,
	[estado] [int] NULL,
	[captaciones_Dolares] [numeric](19, 2) NULL
) ON [PRIMARY]
GO
