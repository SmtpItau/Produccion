USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[RESPALDO_CLIENTES_26_08_2015]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESPALDO_CLIENTES_26_08_2015](
	[Rut] [numeric](9, 0) NOT NULL,
	[Codigo] [numeric](9, 0) NOT NULL,
	[Nombre] [char](70) NULL,
	[BILATERAL] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
