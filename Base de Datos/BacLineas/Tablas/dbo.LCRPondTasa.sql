USE [BacLineas]
GO
/****** Object:  Table [dbo].[LCRPondTasa]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LCRPondTasa](
	[LCRTasModCod] [char](3) NOT NULL,
	[LCRTasProCod] [char](5) NOT NULL,
	[LCRTasGruMdaCod] [char](8) NOT NULL,
	[LCRTasPla] [float] NOT NULL,
	[LCRTasPon] [float] NOT NULL,
 CONSTRAINT [PK_LCRPondTasa] PRIMARY KEY NONCLUSTERED 
(
	[LCRTasModCod] ASC,
	[LCRTasProCod] ASC,
	[LCRTasGruMdaCod] ASC,
	[LCRTasPla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
