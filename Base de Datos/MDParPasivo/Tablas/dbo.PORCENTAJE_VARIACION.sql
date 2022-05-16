USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PORCENTAJE_VARIACION]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PORCENTAJE_VARIACION](
	[pvcodigo] [numeric](3, 0) NOT NULL,
	[pvserie] [char](12) NOT NULL,
	[pvporcentaje] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
