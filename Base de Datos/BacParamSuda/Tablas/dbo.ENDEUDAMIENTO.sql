USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ENDEUDAMIENTO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ENDEUDAMIENTO](
	[Activo_Circulante] [numeric](19, 2) NULL,
	[Pend_Inst_Finan] [numeric](5, 2) NULL,
	[Pmax_End_Inst_Finan] [numeric](5, 2) NULL,
	[PFwp_Perd_Dif] [numeric](5, 2) NULL
) ON [PRIMARY]
GO
