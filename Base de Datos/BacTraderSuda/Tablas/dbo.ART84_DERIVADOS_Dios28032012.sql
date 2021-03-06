USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[ART84_DERIVADOS_Dios28032012]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ART84_DERIVADOS_Dios28032012](
	[Fecha_Proc] [datetime] NOT NULL,
	[NumOpe] [numeric](10, 0) NOT NULL,
	[Correla] [numeric](3, 0) NOT NULL,
	[Modulo] [char](3) NOT NULL,
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
	[AVR] [numeric](19, 4) NOT NULL,
	[Vigencia_Dias] [numeric](10, 0) NOT NULL,
	[Valor_Moneda] [float] NOT NULL,
	[Nocional_CLP] [numeric](19, 4) NOT NULL,
	[Factor] [numeric](21, 4) NOT NULL,
	[Sum_AVR_Positivo] [float] NOT NULL,
	[Max_Sum_AVR_Cero] [float] NOT NULL,
	[Equiv_Credito] [float] NOT NULL,
	[Monto_Matriz] [float] NOT NULL,
	[Acu_Comp_Bilateral] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
