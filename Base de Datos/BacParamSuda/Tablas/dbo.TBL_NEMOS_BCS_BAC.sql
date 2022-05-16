USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_NEMOS_BCS_BAC]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_NEMOS_BCS_BAC](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nemo_BCS] [char](15) NULL,
	[Nemo_BAC] [char](5) NULL,
	[Rut] [numeric](9, 0) NULL
) ON [PRIMARY]
GO
