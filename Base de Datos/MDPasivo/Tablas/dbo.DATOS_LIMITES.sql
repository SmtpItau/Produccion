USE [MDPasivo]
GO
/****** Object:  Table [dbo].[DATOS_LIMITES]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DATOS_LIMITES](
	[Total_Cartera_Lchr] [numeric](19, 4) NOT NULL,
	[Limite_Inversion_Cartera_Asignado] [float] NOT NULL,
	[Limite_Inversion_Cartera_Ocupado] [float] NOT NULL,
	[Total_Cartera_Lchr_Ocupado] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
