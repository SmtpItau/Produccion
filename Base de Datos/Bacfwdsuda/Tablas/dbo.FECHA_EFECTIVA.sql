USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[FECHA_EFECTIVA]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FECHA_EFECTIVA](
	[Producto] [varchar](5) NOT NULL,
	[Modalidad] [char](1) NOT NULL,
	[Signo] [char](1) NOT NULL,
	[Diasvalor] [numeric](9, 0) NOT NULL,
 CONSTRAINT [PrimaryKeyFechaEfectiva] PRIMARY KEY CLUSTERED 
(
	[Producto] ASC,
	[Modalidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FECHA_EFECTIVA] ADD  CONSTRAINT [df_fechaefectiva_producto]  DEFAULT ('') FOR [Producto]
GO
ALTER TABLE [dbo].[FECHA_EFECTIVA] ADD  CONSTRAINT [df_fechaefectiva_modalidad]  DEFAULT ('') FOR [Modalidad]
GO
ALTER TABLE [dbo].[FECHA_EFECTIVA] ADD  CONSTRAINT [df_fechaefectiva_Signo]  DEFAULT ('') FOR [Signo]
GO
ALTER TABLE [dbo].[FECHA_EFECTIVA] ADD  CONSTRAINT [df_fechaefectiva_diasvalor]  DEFAULT (0) FOR [Diasvalor]
GO
