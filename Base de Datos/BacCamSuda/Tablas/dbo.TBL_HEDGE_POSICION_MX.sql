USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[TBL_HEDGE_POSICION_MX]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_HEDGE_POSICION_MX](
	[Hedge_Fecha] [datetime] NOT NULL,
	[Hedge_Moneda] [char](3) NOT NULL,
	[Hedge_PosMX] [float] NOT NULL
) ON [PRIMARY]
GO
