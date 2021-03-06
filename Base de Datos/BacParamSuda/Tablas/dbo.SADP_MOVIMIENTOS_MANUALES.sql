USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_MOVIMIENTOS_MANUALES]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES](
	[id_Transaccion] [numeric](15, 0) IDENTITY(1,1) NOT NULL,
	[dFechaCarga] [datetime] NOT NULL,
	[dFechaMovto] [datetime] NOT NULL,
	[idTX_Carga] [numeric](15, 0) NOT NULL,
	[sOrigen] [varchar](10) NOT NULL,
	[Movimiento] [varchar](1) NOT NULL,
	[Tipo_Operacion] [varchar](25) NOT NULL,
	[RutCliente] [int] NOT NULL,
	[CodCliente] [tinyint] NOT NULL,
	[sNombreCliente] [varchar](60) NOT NULL,
	[iFormadPago] [smallint] NOT NULL,
	[Monto] [numeric](21, 4) NOT NULL,
	[sMoneda] [smallint] NOT NULL,
	[iBanco] [int] NOT NULL,
	[sCuenta] [varchar](40) NOT NULL,
	[iRutBeneficiario] [int] NULL,
	[sDvBeneficiario] [varchar](1) NULL,
	[sBeneficiario] [varchar](40) NOT NULL,
	[idNumeroSistema] [numeric](15, 0) NOT NULL,
	[sUserNT] [varchar](20) NOT NULL,
	[sUserAutoriza] [varchar](15) NOT NULL,
	[iOperOriginal] [numeric](10, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_Transaccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [dFechaCarga]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [dFechaMovto]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ((0)) FOR [idTX_Carga]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [sOrigen]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [Movimiento]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [Tipo_Operacion]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ((0)) FOR [RutCliente]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ((1)) FOR [CodCliente]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [sNombreCliente]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ((0)) FOR [iFormadPago]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ((0)) FOR [Monto]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ((0)) FOR [sMoneda]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ((0)) FOR [iBanco]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [sCuenta]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [sBeneficiario]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ((0)) FOR [idNumeroSistema]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [sUserNT]
GO
ALTER TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES] ADD  DEFAULT ('') FOR [sUserAutoriza]
GO
