USE [BacLineas]
GO
/****** Object:  Table [dbo].[TBL_RIEFIN_Parametros_Metodologia]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RIEFIN_Parametros_Metodologia](
	[Cod_Metodologia] [int] NOT NULL,
	[AddOn] [int] NOT NULL,
	[Porc_Confianza] [float] NOT NULL
) ON [PRIMARY]
GO
