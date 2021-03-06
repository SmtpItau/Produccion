USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MELIN]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MELIN](
	[LIN_RUT] [float] NULL,
	[LIN_NOMBRE] [nvarchar](46) NULL,
	[LIN_LINEA] [float] NULL,
	[LIN_MTOOCU] [float] NULL,
	[LIN_MTODIS] [float] NULL,
	[LIN_ESTADO] [float] NULL,
	[LIN_PUNTAS] [float] NULL,
	[LIN_FECVEN] [smalldatetime] NULL
) ON [PRIMARY]
GO
