USE [BacLineas]
GO
/****** Object:  Table [dbo].[IngresoDWT_BacLineas]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngresoDWT_BacLineas](
	[fechaIngreso] [datetime] NULL,
	[seq] [int] NULL,
	[registro] [varchar](100) NULL,
	[nombreArchivo] [varchar](30) NULL
) ON [PRIMARY]
GO
