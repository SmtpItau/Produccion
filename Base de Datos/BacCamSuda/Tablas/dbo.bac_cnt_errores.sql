USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[bac_cnt_errores]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bac_cnt_errores](
	[FECHA_PROCESO] [datetime] NOT NULL,
	[CODIGO] [numeric](5, 0) NOT NULL,
	[MENSAJE] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
