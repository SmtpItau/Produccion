USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Ctr_Int_Pag]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ctr_Int_Pag](
	[actip_car] [numeric](9, 0) NOT NULL,
	[Int_Gan] [numeric](18, 0) NOT NULL,
	[Rea_Gan] [numeric](18, 0) NOT NULL,
	[Dif_pre] [numeric](18, 0) NOT NULL,
	[Int_Pag] [numeric](18, 0) NOT NULL,
	[Ut_Per] [numeric](18, 0) NOT NULL,
	[Inter] [numeric](18, 0) NOT NULL,
	[acut_per] [numeric](18, 0) NOT NULL,
	[ac_inter] [numeric](18, 0) NOT NULL,
	[acInt_Gan] [numeric](18, 0) NOT NULL,
	[acRea_Gan] [numeric](18, 0) NOT NULL,
	[acdif_pre] [numeric](18, 0) NOT NULL,
	[acint_pag] [numeric](18, 0) NOT NULL
) ON [PRIMARY]
GO
