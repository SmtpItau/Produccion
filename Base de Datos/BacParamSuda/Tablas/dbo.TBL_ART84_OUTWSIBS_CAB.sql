USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_ART84_OUTWSIBS_CAB]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_ART84_OUTWSIBS_CAB](
	[ID_TICKET] [int] NULL,
	[flagCumplimiento] [varchar](1) NULL,
	[correlativoIngresoIBS] [numeric](21, 0) NULL,
	[nombreCliente] [varchar](45) NULL
) ON [PRIMARY]
GO
