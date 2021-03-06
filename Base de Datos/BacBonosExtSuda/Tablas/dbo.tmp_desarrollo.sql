USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[tmp_desarrollo]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_desarrollo](
	[Cod_familia] [numeric](4, 0) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[num_cupon] [numeric](3, 0) NOT NULL,
	[fecha_vcto] [datetime] NOT NULL,
	[fecha_vcto_cupon] [datetime] NOT NULL,
	[interes] [float] NOT NULL,
	[amortizacion] [float] NOT NULL,
	[flujo] [float] NOT NULL,
	[saldo] [float] NOT NULL,
	[Factor] [float] NOT NULL
) ON [PRIMARY]
GO
