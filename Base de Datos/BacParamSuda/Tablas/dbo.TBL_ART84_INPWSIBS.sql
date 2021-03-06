USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_ART84_INPWSIBS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_ART84_INPWSIBS](
	[ID_TICKET] [int] NULL,
	[COD_ENTIDAD] [varchar](2) NULL,
	[COD_USUARIO] [varchar](20) NULL,
	[TIMESTAMP] [varchar](20) NULL,
	[rutCliente] [varchar](15) NULL,
	[codigoMonedaIBS] [varchar](4) NULL,
	[montoReserva] [decimal](17, 2) NULL,
	[montoGarantizado] [decimal](17, 2) NULL,
	[cantidadDiasPermanencia] [int] NULL,
	[numeroSolicitudSistemaOrigen] [varchar](25) NULL,
	[codigoDeuda] [int] NULL,
	[codigoTransaccion] [int] NULL,
	[codigoProductoIBS] [varchar](4) NULL,
	[codigoPaisSBIF] [int] NULL,
	[Indicador] [varchar](1) NULL
) ON [PRIMARY]
GO
