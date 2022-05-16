USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_PLAZOS_INTER]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_PLAZOS_INTER](
	[codigo_inter] [char](5) NULL,
	[descripcion] [char](5) NULL,
	[dia_inicial] [int] NULL,
	[dia_final] [int] NULL,
	[orden] [int] NULL
) ON [PRIMARY]
GO
