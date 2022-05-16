USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[HAIRCUT_SOMA]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HAIRCUT_SOMA](
	[hcincodigo] [numeric](3, 0) NOT NULL,
	[hcClasificacionRiesgo] [char](3) NOT NULL,
	[hctipoper] [char](3) NOT NULL,
	[hchaircut] [float] NOT NULL
) ON [PRIMARY]
GO
