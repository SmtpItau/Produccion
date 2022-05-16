USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tmp_Tbl_Tributarios_Ajustes]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Tbl_Tributarios_Ajustes](
	[Fecha] [datetime] NOT NULL,
	[Origen] [char](3) NOT NULL,
	[Contrato] [numeric](9, 0) NOT NULL,
	[Monto] [numeric](21, 4) NOT NULL,
	[Cuenta] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
