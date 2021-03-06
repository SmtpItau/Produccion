USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tmp_TBL_PATRIMONIO]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_TBL_PATRIMONIO](
	[Fecha] [datetime] NOT NULL,
	[Origen] [varchar](5) NOT NULL,
	[Contrato] [numeric](21, 0) NOT NULL,
	[Cuenta] [varchar](20) NOT NULL,
	[Ajuste] [numeric](21, 4) NOT NULL,
	[CuentaResultado] [varchar](20) NOT NULL
) ON [PRIMARY]
GO
