USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tblConversionClientes_loaded]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblConversionClientes_loaded](
	[idRut_ITAU] [numeric](9, 0) NULL,
	[iCod_ITAU] [int] NULL,
	[sNom_ITAU] [varchar](400) NULL,
	[idRut_CORP] [numeric](9, 0) NULL,
	[iCod_CORP] [int] NULL,
	[sNom_CORP] [varchar](400) NULL,
	[iNewCod_CORP] [int] NULL
) ON [PRIMARY]
GO
