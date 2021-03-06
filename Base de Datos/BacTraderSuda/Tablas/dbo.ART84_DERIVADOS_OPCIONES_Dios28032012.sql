USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[ART84_DERIVADOS_OPCIONES_Dios28032012]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ART84_DERIVADOS_OPCIONES_Dios28032012](
	[Fecha_Proc] [datetime] NOT NULL,
	[NumOpe] [numeric](10, 0) NOT NULL,
	[Correla] [numeric](3, 0) NOT NULL,
	[Modulo] [char](3) NOT NULL,
	[Fecha_Fixing] [datetime] NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[Instrumento] [char](20) NOT NULL,
	[Mascara] [char](20) NOT NULL,
	[Nocional] [numeric](19, 4) NOT NULL,
	[fecha_Cierre] [datetime] NOT NULL,
	[fecha_inicio] [datetime] NOT NULL,
	[Seriado] [char](1) NOT NULL,
	[Codigo] [numeric](5, 0) NOT NULL,
	[Tir] [numeric](19, 4) NOT NULL,
	[Moneda] [numeric](5, 0) NOT NULL,
	[Producto] [char](3) NOT NULL,
	[Desc_Prod] [varchar](50) NOT NULL,
	[AVR_OPC] [numeric](19, 4) NOT NULL,
	[AVR_DETALLE] [numeric](19, 4) NOT NULL,
	[Vigencia_Dias] [numeric](10, 0) NOT NULL,
	[Valor_Moneda] [float] NOT NULL,
	[Moneda_Valor_Raz] [numeric](5, 0) NOT NULL,
	[Valor_Moneda_Val_Raz] [float] NOT NULL,
	[Nocional_CLP] [float] NOT NULL,
	[Factor] [numeric](21, 4) NOT NULL,
	[IndicadorRec] [varchar](5) NOT NULL,
	[Vinculacion] [varchar](15) NOT NULL,
	[TipoPayOff] [varchar](15) NOT NULL,
	[Moneda_Delta] [numeric](5, 0) NOT NULL,
	[DeltaFwd] [float] NOT NULL,
	[DeltaFwd_CLP] [float] NOT NULL,
	[Ponderador] [float] NOT NULL,
	[Sum_AVR_Positivo] [float] NOT NULL,
	[Max_Sum_AVR_Cero] [float] NOT NULL,
	[CompraoVenta] [varchar](1) NOT NULL,
	[Equiv_Credito] [float] NOT NULL,
	[Monto_Matriz] [float] NOT NULL,
	[Acu_Comp_Bilateral] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
