USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[tblMitigacion]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMitigacion](
	[codFamilia] [char](6) NOT NULL,
	[iPlazoIni] [int] NOT NULL,
	[iPlazoFin] [int] NOT NULL,
	[fPorcentaje] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[codFamilia] ASC,
	[iPlazoIni] ASC,
	[iPlazoFin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
