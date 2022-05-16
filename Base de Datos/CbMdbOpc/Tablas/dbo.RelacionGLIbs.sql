USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[RelacionGLIbs]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelacionGLIbs](
	[Producto] [varchar](10) NULL,
	[FechaEjecucion] [datetime] NULL,
	[NumeroVoucher] [int] NULL,
	[NumeroGL] [int] NULL
) ON [PRIMARY]
GO
