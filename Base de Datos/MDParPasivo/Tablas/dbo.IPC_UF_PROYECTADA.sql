USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[IPC_UF_PROYECTADA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IPC_UF_PROYECTADA](
	[ipcfeccal] [datetime] NOT NULL,
	[ipcvaloruf] [numeric](9, 0) NOT NULL,
	[ipcvaloripc] [numeric](5, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL
) ON [PRIMARY]
GO
