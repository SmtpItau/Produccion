USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[OP_ENVIADAS_DCV_HISTORICO]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO](
	[FechaEnv] [datetime] NOT NULL,
	[HoraEnv] [char](10) NOT NULL,
	[Marcado] [char](1) NOT NULL,
	[Usuario] [varchar](15) NOT NULL,
	[numope] [numeric](10, 0) NOT NULL,
	[monumdocu] [numeric](10, 0) NOT NULL,
	[correla] [numeric](10, 0) NOT NULL,
	[serie] [varchar](15) NOT NULL,
	[moneda] [int] NOT NULL,
	[nominal] [numeric](21, 4) NOT NULL,
	[tir] [numeric](21, 4) NOT NULL,
	[pvpar] [float] NOT NULL,
	[vpressen] [numeric](21, 0) NOT NULL,
	[dcv] [varchar](20) NOT NULL,
	[madurez] [char](1) NOT NULL,
	[motipoper] [varchar](5) NOT NULL,
	[formapago] [char](1) NOT NULL,
	[movimiento] [varchar](5) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[Estado] [char](1) NOT NULL,
	[NumInterfaz] [numeric](10, 0) NOT NULL,
	[Rutcliente] [numeric](10, 0) NOT NULL,
	[CodCliente] [numeric](10, 0) NOT NULL,
	[UsuarioEnv] [varchar](15) NOT NULL,
 CONSTRAINT [Pk_OpEnviadasDcvHist] PRIMARY KEY NONCLUSTERED 
(
	[FechaEnv] ASC,
	[HoraEnv] ASC,
	[fecha] ASC,
	[numope] ASC,
	[monumdocu] ASC,
	[correla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_FechaEnv]  DEFAULT ('N') FOR [FechaEnv]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_HoraEnv]  DEFAULT ('00:00:00') FOR [HoraEnv]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_Marcado]  DEFAULT ('N') FOR [Marcado]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_Usuario]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_numope]  DEFAULT (0) FOR [numope]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_monumdocu]  DEFAULT (0) FOR [monumdocu]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_correla]  DEFAULT (0) FOR [correla]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_serie]  DEFAULT ('') FOR [serie]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_moneda]  DEFAULT (0) FOR [moneda]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_nominal]  DEFAULT (0.0) FOR [nominal]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_tir]  DEFAULT (0.0) FOR [tir]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_pvpar]  DEFAULT (0.0) FOR [pvpar]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_vpressen]  DEFAULT (0.0) FOR [vpressen]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_dcv]  DEFAULT ('') FOR [dcv]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_madurez]  DEFAULT ('') FOR [madurez]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_motipoper]  DEFAULT ('') FOR [motipoper]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_formapago]  DEFAULT ('') FOR [formapago]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_movimiento]  DEFAULT ('') FOR [movimiento]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_fecha]  DEFAULT ('') FOR [fecha]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_estado]  DEFAULT ('P') FOR [Estado]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_NumInterfaz]  DEFAULT (0) FOR [NumInterfaz]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_Rutcliente]  DEFAULT (0) FOR [Rutcliente]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_CodCliente]  DEFAULT (0) FOR [CodCliente]
GO
ALTER TABLE [dbo].[OP_ENVIADAS_DCV_HISTORICO] ADD  CONSTRAINT [df_openviadas_hist_dcv_UsuarioEnv]  DEFAULT ('') FOR [UsuarioEnv]
GO
