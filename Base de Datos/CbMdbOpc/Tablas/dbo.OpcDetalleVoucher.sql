USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[OpcDetalleVoucher]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpcDetalleVoucher](
	[Numero_Voucher] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Cuenta] [char](20) NULL,
	[Tipo_Monto] [char](1) NULL,
	[Monto] [float] NULL,
	[Moneda] [numeric](3, 0) NULL,
 CONSTRAINT [PK_OpcDetalleVoucher] PRIMARY KEY NONCLUSTERED 
(
	[Numero_Voucher] ASC,
	[Correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
