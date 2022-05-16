USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[OPE_COLATERAL]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OPE_COLATERAL](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Cod_Cliente] [numeric](3, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[numero_operacion] [numeric](9, 0) NOT NULL,
	[Cod_Colateral] [varchar](5) NOT NULL
) ON [PRIMARY]
GO
