USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_ART84_INPWSIBS_OPE_TICK]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_ART84_INPWSIBS_OPE_TICK](
	[ID_TICKET] [int] NULL,
	[NRO_OPERACION] [int] NULL,
	[SISTEMA] [varchar](4) NULL,
	[correlativoIngresoIBS] [numeric](21, 0) NULL
) ON [PRIMARY]
GO
