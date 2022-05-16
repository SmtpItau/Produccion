USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PRODUCTOS_PRIMA_FACILITY]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTOS_PRIMA_FACILITY](
	[CODIGOS_FACILITY] [char](4) NOT NULL,
	[Plazo] [int] NOT NULL,
	[Tipo_Limite] [char](1) NOT NULL,
	[Descipion_RCO] [varchar](30) NOT NULL,
	[Tipo_Facility] [char](4) NOT NULL
) ON [PRIMARY]
GO
