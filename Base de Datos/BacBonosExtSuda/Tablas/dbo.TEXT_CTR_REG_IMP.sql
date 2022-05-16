USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[TEXT_CTR_REG_IMP]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TEXT_CTR_REG_IMP](
	[imnumdocu] [char](12) NOT NULL,
	[imcorrelativo] [numeric](18, 0) NOT NULL,
	[imPorcentajeImp] [numeric](5, 0) NOT NULL,
	[imMtoImpuesto] [numeric](19, 4) NOT NULL
) ON [PRIMARY]
GO
