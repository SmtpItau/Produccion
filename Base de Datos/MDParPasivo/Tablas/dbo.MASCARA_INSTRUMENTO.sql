USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[MASCARA_INSTRUMENTO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MASCARA_INSTRUMENTO](
	[msmascara] [char](12) NOT NULL,
	[msnemo] [char](12) NOT NULL,
	[msfamilia] [char](12) NOT NULL,
	[msarchivo] [char](2) NOT NULL,
	[Codigo_Instrumento] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO
