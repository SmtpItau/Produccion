USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[mfutilidadbco]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mfutilidadbco](
	[UB_CORRELA] [numeric](20, 0) NOT NULL,
	[UB_NOPERACION] [numeric](10, 0) NOT NULL,
	[UB_TIPOOP] [numeric](5, 0) NOT NULL,
	[UB_RUTCL] [numeric](10, 0) NOT NULL,
	[UB_CODCL] [numeric](5, 0) NOT NULL,
	[UB_MONEDA] [numeric](5, 0) NOT NULL,
	[UB_CONTRAMONEDA] [numeric](5, 0) NOT NULL,
	[UB_PLAZO_RESIDUAL] [numeric](10, 0) NOT NULL,
	[UB_PORUSAMATRIZ] [numeric](10, 0) NOT NULL,
	[UB_MONTOLPRODUCTO] [numeric](21, 4) NOT NULL,
	[UB_UTILIDAD] [numeric](21, 4) NOT NULL,
	[UB_MTOTOCUPADO] [numeric](21, 4) NOT NULL,
	[UB_MTOTDISPO] [numeric](21, 4) NOT NULL,
	[UB_FECHA] [datetime] NOT NULL,
	[UB_MONTOOP] [numeric](21, 4) NOT NULL,
	[UB_MONTOOPDOLAR] [numeric](21, 4) NOT NULL,
	[UB_CLASE_OP] [char](1) NOT NULL,
	[UB_MONTO_OPMR] [numeric](21, 4) NOT NULL,
 CONSTRAINT [PK_dbo.mfutilidadbco] PRIMARY KEY NONCLUSTERED 
(
	[UB_CORRELA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
