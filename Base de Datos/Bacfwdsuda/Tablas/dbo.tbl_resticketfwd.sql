USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[tbl_resticketfwd]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_resticketfwd](
	[Fecha] [datetime] NOT NULL,
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[Numero_Operacion_Relacion] [numeric](18, 0) NOT NULL,
	[Valorizacion] [float] NOT NULL,
	[Val_Obtenido] [float] NOT NULL,
	[Res_Obtenido] [float] NOT NULL,
	[ValorRazonableActivo] [float] NOT NULL,
	[ValorRazonablePasivo] [float] NOT NULL,
 CONSTRAINT [PK_tbl_resticketfwd] PRIMARY KEY NONCLUSTERED 
(
	[Fecha] ASC,
	[Numero_Operacion] ASC,
	[Numero_Operacion_Relacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_resticketfwd] ADD  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[tbl_resticketfwd] ADD  DEFAULT (0) FOR [Numero_Operacion]
GO
ALTER TABLE [dbo].[tbl_resticketfwd] ADD  DEFAULT (0) FOR [Numero_Operacion_Relacion]
GO
ALTER TABLE [dbo].[tbl_resticketfwd] ADD  DEFAULT (0) FOR [Valorizacion]
GO
ALTER TABLE [dbo].[tbl_resticketfwd] ADD  DEFAULT (0) FOR [Val_Obtenido]
GO
ALTER TABLE [dbo].[tbl_resticketfwd] ADD  DEFAULT (0) FOR [Res_Obtenido]
GO
ALTER TABLE [dbo].[tbl_resticketfwd] ADD  DEFAULT (0) FOR [ValorRazonableActivo]
GO
ALTER TABLE [dbo].[tbl_resticketfwd] ADD  DEFAULT (0) FOR [ValorRazonablePasivo]
GO
