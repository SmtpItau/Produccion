USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ClienteTuring]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClienteTuring](
	[DetailCustomerID] [int] NULL,
	[CustomerID] [int] NULL,
	[Secuencia] [int] NULL,
	[Rut] [int] NULL,
	[CodigoCliente] [int] NULL,
	[Mnemotecnico] [varchar](255) NULL,
	[descripcion] [varchar](255) NULL,
	[locationid] [int] NULL,
	[StatusID] [int] NULL,
	[CreatorUserID] [int] NULL,
	[CreatorDate] [datetime] NULL
) ON [PRIMARY]
GO
