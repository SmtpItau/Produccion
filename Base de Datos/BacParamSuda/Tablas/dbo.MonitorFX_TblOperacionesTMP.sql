USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MonitorFX_TblOperacionesTMP]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MonitorFX_TblOperacionesTMP](
	[idPosicion] [bigint] IDENTITY(1,1) NOT NULL,
	[idArchivo] [smallint] NOT NULL,
	[Oper_dFecha] [datetime] NULL,
	[Oper_Hora] [varchar](20) NULL,
	[Oper_sCodComprador] [varchar](3) NULL,
	[Oper_sNemoComprador] [varchar](4) NULL,
	[Oper_sCodVendedor] [varchar](3) NULL,
	[Oper_sNemoVendedor] [varchar](4) NULL,
	[Oper_fMontoOrigen] [varchar](50) NULL,
	[Oper_fPrecio] [varchar](50) NULL,
	[Oper_sOperacion] [varchar](1) NULL,
	[Oper_sNula] [varchar](3) NULL,
	[Oper_sEquivalencia] [varchar](40) NULL,
	[Oper_sIdentificacion] [varchar](40) NULL,
	[Oper_sCliente] [varchar](40) NULL,
	[Oper_sUsuario] [varchar](40) NULL,
	[Oper_sContraparte] [varchar](40) NULL,
	[Oper_sMercado] [varchar](3) NULL,
	[Oper_sFecha] [varchar](10) NULL,
	[Oper_fMonto1] [varchar](30) NULL,
	[Oper_fMonto2] [varchar](30) NULL,
	[Oper_fPrecio1] [varchar](20) NULL,
	[Oper_fPrecio2] [varchar](20) NULL,
	[Oper_fPrecio3] [varchar](20) NULL,
	[Oper_fVencimiento] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[idPosicion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
