USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TEMPAPE]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEMPAPE](
	[rutemisor] [numeric](9, 0) NULL,
	[codigoemisor] [numeric](9, 0) NULL,
	[digchkemisor] [char](1) NULL,
	[nombreemisor] [char](34) NULL,
	[rutcliente] [numeric](5, 0) NULL,
	[digchkcliente] [char](1) NULL,
	[nombrecliente] [char](70) NULL,
	[direccioncliente] [char](40) NULL,
	[fecharecibe] [varchar](10) NULL,
	[fechaentrega] [varchar](10) NULL,
	[montoopera] [numeric](19, 4) NULL,
	[montousd] [numeric](19, 4) NULL,
	[montoclp] [numeric](19, 4) NULL,
	[tipocamcie] [numeric](19, 4) NULL,
	[tipocamtra] [numeric](19, 4) NULL,
	[paricie] [numeric](19, 8) NULL,
	[paritra] [numeric](19, 8) NULL,
	[parifin] [numeric](19, 8) NULL,
	[modoimpreso] [char](1) NULL,
	[monedaopera] [varchar](8) NULL,
	[monedaconve] [char](3) NULL,
	[noopera] [numeric](7, 0) NULL,
	[tipoopera] [char](1) NULL,
	[entregamos] [char](30) NULL,
	[recibimos] [char](30) NULL,
	[operador] [char](10) NULL,
	[tipocamtrf] [numeric](19, 4) NULL,
	[retiro] [numeric](2, 0) NULL,
	[monope] [char](3) NULL
) ON [PRIMARY]
GO
