USE [Reportes]
GO
/****** Object:  Table [dbo].[Extraccion_Back]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Extraccion_Back](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FechaExtraccion] [datetime] NULL,
	[Nro_Operacion] [varchar](12) NULL,
	[Correlativo] [varchar](10) NULL,
	[Estado] [varchar](12) NULL,
	[Cod_Producto] [varchar](40) NULL,
	[Producto] [varchar](40) NULL,
	[Tipo_Operacion] [varchar](50) NULL,
	[Codigo_Cliente] [numeric](9, 0) NULL,
	[Rut_Cliente] [numeric](9, 0) NULL,
	[Nombre_Cliente] [varchar](70) NULL,
	[Cod_Cartera_Financiera] [varchar](30) NULL,
	[Cartera_Financiera] [varchar](30) NULL,
	[Cod_Libro] [varchar](30) NULL,
	[Libro] [varchar](30) NULL,
	[Cod_Cartera_Normativa] [varchar](30) NULL,
	[Cartera_Normativa] [varchar](30) NULL,
	[Cod_SubCartera_Normativa] [varchar](30) NULL,
	[SubCartera_Normativa] [varchar](30) NULL,
	[PayOff] [varchar](30) NULL,
	[CallPut] [varchar](10) NULL,
	[Fecha_Inicio] [datetime] NULL,
	[Fecha_Vencimiento] [datetime] NULL,
	[Fecha_Ejercicio] [datetime] NULL,
	[Moneda1] [varchar](10) NULL,
	[Monto1] [varchar](10) NULL,
	[Precio1] [varchar](10) NULL,
	[Moneda2] [varchar](10) NULL,
	[Monto2] [varchar](10) NULL,
	[Precio2] [varchar](10) NULL,
	[Modalidad] [varchar](15) NULL,
	[Valor_Razonable] [varchar](10) NULL,
	[Prima] [varchar](15) NULL,
	[Operador] [varchar](15) NULL,
	[ExtGuid] [uniqueidentifier] NOT NULL,
	[InterfazId] [int] NOT NULL,
	[UsuarioModificaId] [int] NOT NULL,
	[FechaModificacionId] [datetime] NOT NULL,
 CONSTRAINT [PK_Extraccion_Back] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Reportes_Data_01]
) ON [Reportes_Data_01]
GO
ALTER TABLE [dbo].[Extraccion_Back] ADD  CONSTRAINT [DF_Extraccion_Back_ExtGuid]  DEFAULT (newid()) FOR [ExtGuid]
GO
