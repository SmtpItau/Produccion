USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[OpcVoucher]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpcVoucher](
	[Numero_Voucher] [numeric](10, 0) NOT NULL,
	[Fecha_Ingreso] [datetime] NULL,
	[Glosa] [char](70) NULL,
	[Tipo_Voucher] [char](1) NULL,
	[Tipo_Operacion] [varchar](5) NOT NULL,
	[Operacion] [numeric](10, 0) NULL,
	[Componente] [numeric](8, 0) NULL,
	[Folio_Perfil] [numeric](5, 0) NULL,
 CONSTRAINT [PK_OpcVoucher] PRIMARY KEY NONCLUSTERED 
(
	[Numero_Voucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
