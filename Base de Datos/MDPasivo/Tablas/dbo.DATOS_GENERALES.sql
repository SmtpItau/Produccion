USE [MDPasivo]
GO
/****** Object:  Table [dbo].[DATOS_GENERALES]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DATOS_GENERALES](
	[Rut_Entidad] [numeric](10, 0) NOT NULL,
	[Digito_Entidad] [char](1) NOT NULL,
	[Nombre_Entidad] [char](50) NOT NULL,
	[Codigo_Entidad] [numeric](10, 0) NOT NULL,
	[Direccion_Entidad] [char](50) NULL,
	[Comuna_Entidad] [numeric](5, 0) NULL,
	[Ciudad_Entidad] [numeric](5, 0) NULL,
	[Fono_Entidad] [char](10) NULL,
	[Fax_Entidad] [char](10) NULL,
	[Fecha_Proceso] [datetime] NOT NULL,
	[Fecha_Anterior] [datetime] NULL,
	[Fecha_Proxima] [datetime] NULL,
	[Numero_Operacion_Btr] [numeric](10, 0) NULL,
	[Numero_Operacion_Swp] [numeric](10, 0) NULL,
	[Numero_Operacion_Inv] [numeric](10, 0) NULL,
	[Numero_Operacion_Fwd] [numeric](10, 0) NULL,
	[Numero_Operacion_Spt] [numeric](10, 0) NULL,
	[Numero_Operacion_Spt_Planilla] [numeric](10, 0) NULL,
	[Numero_Operacion_Spt_Swift] [numeric](10, 0) NULL,
	[Numero_Operacion_Pas] [numeric](10, 0) NULL,
	[Max_Papeletas] [numeric](5, 0) NULL,
	[Clave_DCV] [numeric](10, 0) NULL,
	[Plazo_UF] [numeric](10, 0) NULL,
	[Plazo_DO] [numeric](10, 0) NULL,
	[Plazo_$$] [numeric](10, 0) NULL,
	[Dias_Renovacion] [numeric](10, 0) NULL,
	[Canasta_Credito_Hoy] [numeric](19, 4) NULL,
	[Canasta_Credito_Yes] [numeric](19, 4) NULL,
	[Computable_Debito_Hoy] [numeric](19, 4) NULL,
	[Computable_Debito_Yes] [numeric](19, 4) NULL,
	[Computable_Credito_Hoy] [numeric](19, 4) NULL,
	[Computable_Credito_Yes] [numeric](19, 4) NULL,
	[Tiempo_Otc] [numeric](9, 0) NULL,
	[Rut_Bcch] [numeric](9, 0) NULL,
	[Codigo_Pais] [numeric](5, 0) NULL,
	[Codigo_Plaza] [numeric](5, 0) NULL,
	[Capital_Reserva] [numeric](19, 4) NULL,
	[Capital_Basico] [numeric](19, 4) NULL,
	[Moneda_Control] [numeric](5, 0) NULL,
	[Valor_Moneda] [numeric](10, 4) NULL,
	[Numero_Traspaso] [numeric](10, 0) NULL,
	[Porcen_Con_Riesgo] [numeric](10, 4) NULL,
	[Porcen_Sin_Riesgo] [numeric](10, 4) NULL,
	[Porcen_Invext] [numeric](10, 4) NULL,
	[Monto_Con_Riesgo] [numeric](19, 4) NULL,
	[Monto_Sin_Riesgo] [numeric](19, 4) NULL,
	[Invext_Total] [numeric](19, 4) NULL,
	[Invext_Ocupado] [numeric](19, 4) NULL,
	[Invext_Disponible] [numeric](19, 4) NULL,
	[Invext_Exceso] [numeric](19, 4) NULL,
	[Primer_Tramo] [numeric](19, 4) NULL,
	[Segundo_Tramo] [numeric](19, 4) NULL,
	[Tercer_Tramo] [numeric](19, 4) NULL,
	[Margen_Institucion] [numeric](19, 4) NULL,
	[Total_Cartera_Lchr] [numeric](19, 4) NULL,
	[Total_Por_Folio] [numeric](19, 4) NULL,
	[Caja_Pesos] [numeric](19, 4) NULL,
	[Caja_Bcch] [numeric](19, 4) NULL,
	[Total_Inversiones] [numeric](19, 4) NULL,
	[Dias_Pactado_Papel_No_Central] [numeric](5, 0) NULL,
	[Codigo_Area] [varchar](5) NULL,
	[Limite_Inversion_Cartera_Asignado] [float] NULL,
	[Limite_Inversion_Cartera_Ocupado] [float] NULL,
	[Estado_Reajuste] [char](1) NULL,
	[Total_Cartera_Lchr_Ocupado] [numeric](19, 4) NULL,
	[Numero_Operacion_MMarket] [numeric](10, 0) NULL,
	[Valida_Linea] [char](1) NULL,
	[RUT_CORREDORA] [numeric](18, 0) NOT NULL,
	[CODIGO_CORREDORA] [numeric](18, 0) NOT NULL,
	[PUNTO_CORREDORA] [numeric](22, 4) NOT NULL,
	[puerto_UDP] [numeric](5, 0) NULL,
	[FFMMDiasMaximo] [numeric](5, 0) NOT NULL,
	[Inicio_Dia] [numeric](1, 0) NULL,
	[Fin_Dia] [numeric](1, 0) NULL,
	[Devengamiento] [numeric](1, 0) NULL,
	[Contabilidad] [numeric](1, 0) NULL
) ON [PRIMARY]
GO
