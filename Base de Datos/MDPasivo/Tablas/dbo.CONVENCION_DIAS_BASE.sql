USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CONVENCION_DIAS_BASE]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONVENCION_DIAS_BASE](
	[codigo_convenciondiasbase] [int] NOT NULL,
	[descripcion] [char](30) NOT NULL,
	[convenciondias] [int] NOT NULL,
	[convencionbase] [int] NOT NULL,
	[codigo_BT] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
