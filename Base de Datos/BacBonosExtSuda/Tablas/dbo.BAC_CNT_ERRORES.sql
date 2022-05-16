USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_ERRORES]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_ERRORES](
	[FECHA_PROCESO] [datetime] NULL,
	[CODIGO] [numeric](5, 0) NULL,
	[MENSAJE] [varchar](255) NULL
) ON [PRIMARY]
GO
