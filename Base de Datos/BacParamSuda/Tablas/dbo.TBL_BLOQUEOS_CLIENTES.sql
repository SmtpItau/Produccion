USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_BLOQUEOS_CLIENTES]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_BLOQUEOS_CLIENTES](
	[rutCliente] [numeric](9, 0) NOT NULL,
	[codCliente] [int] NOT NULL,
	[blqTodos] [char](1) NOT NULL,
	[blqForward] [char](1) NOT NULL,
	[blqSwaps] [char](1) NOT NULL,
	[blqOpciones] [char](1) NOT NULL,
	[blqSpot] [char](1) NOT NULL,
	[blqPactos] [char](1) NOT NULL,
	[codMotivo] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
