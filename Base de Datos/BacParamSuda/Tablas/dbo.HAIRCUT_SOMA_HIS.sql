USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[HAIRCUT_SOMA_HIS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HAIRCUT_SOMA_HIS](
	[Hct_Fecha_Proceso] [datetime] NOT NULL,
	[Hct_hcincodigo] [numeric](3, 0) NOT NULL,
	[Hct_hcClasificacionRiesgo] [char](3) NOT NULL,
	[Hct_hctipoper] [char](3) NOT NULL,
	[Hct_hchaircut] [float] NOT NULL
) ON [PRIMARY]
GO
