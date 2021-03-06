USE [MDPasivo]
GO
/****** Object:  Table [dbo].[LINEA_CREDITO_BCCH]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_CREDITO_BCCH](
	[id_sistema] [char](3) NOT NULL,
	[codigo_linea] [varchar](5) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[fechaasignacion] [datetime] NOT NULL,
	[fechavencimiento] [datetime] NOT NULL,
	[fechafinContrato] [datetime] NOT NULL,
	[bloqueado] [varchar](1) NOT NULL,
	[totalasignado] [numeric](19, 4) NOT NULL,
	[totalocupado] [numeric](19, 4) NOT NULL,
	[totaldisponible] [numeric](19, 4) NOT NULL,
	[totalexceso] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
