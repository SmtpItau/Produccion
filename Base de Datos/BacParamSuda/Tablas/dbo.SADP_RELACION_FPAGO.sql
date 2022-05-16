USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_RELACION_FPAGO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_RELACION_FPAGO](
	[cOrigen] [varchar](5) NOT NULL,
	[nCodExterno] [varchar](20) NOT NULL,
	[cDescripcion] [varchar](50) NOT NULL,
	[nCodInterno] [smallint] NOT NULL
) ON [PRIMARY]
GO
