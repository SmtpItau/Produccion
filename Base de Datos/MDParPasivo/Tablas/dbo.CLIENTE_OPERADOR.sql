USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CLIENTE_OPERADOR]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE_OPERADOR](
	[oprutcli] [numeric](9, 0) NOT NULL,
	[opcodcli] [numeric](9, 0) NOT NULL,
	[oprutope] [numeric](9, 0) NOT NULL,
	[opdvope] [char](1) NULL,
	[opnombre] [char](40) NULL
) ON [PRIMARY]
GO
