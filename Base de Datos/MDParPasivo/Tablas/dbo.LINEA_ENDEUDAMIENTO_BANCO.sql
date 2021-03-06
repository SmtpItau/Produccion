USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[LINEA_ENDEUDAMIENTO_BANCO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_ENDEUDAMIENTO_BANCO](
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[digito_cliente] [char](1) NOT NULL,
	[nombre_cliente] [char](100) NOT NULL,
	[monto_inte1446] [float] NOT NULL,
	[monto_derivado] [float] NOT NULL,
	[monto_divPend] [float] NOT NULL,
	[monto_ventaPac] [float] NOT NULL,
	[monto_total] [float] NOT NULL,
	[margen_indivudual] [float] NOT NULL,
	[monto_dispo] [float] NOT NULL,
	[bloqueado] [char](1) NOT NULL,
	[monto_captacion] [float] NOT NULL,
	[monto_pasivos] [float] NOT NULL
) ON [PRIMARY]
GO
