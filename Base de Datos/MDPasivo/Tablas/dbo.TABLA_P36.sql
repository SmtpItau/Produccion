USE [MDPasivo]
GO
/****** Object:  Table [dbo].[TABLA_P36]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TABLA_P36](
	[Nombre_serie] [varchar](15) NULL,
	[Clasificadora_de_Riesgo_1] [numeric](3, 0) NULL,
	[Clasificacion_de_Riesgo_1] [varchar](5) NULL,
	[Clasificadora_de_Riesgo_2] [numeric](3, 0) NULL,
	[Clasificacion_de_Riesgo_2] [varchar](5) NULL,
	[Numero_de_inscripcion] [varchar](15) NULL,
	[Fecha_de_inscripcion] [varchar](8) NULL,
	[Fecha_límite_para_la_colocacion] [varchar](8) NULL,
	[Monto_inscrito] [numeric](14, 0) NULL,
	[gasto_col_ult_mes] [numeric](14, 0) NULL
) ON [PRIMARY]
GO
