USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tbTransferencia]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbTransferencia](
	[numero_operacion] [numeric](7, 0) NOT NULL,
	[tipo] [char](1) NOT NULL,
	[correlativo] [numeric](2, 0) NOT NULL,
	[codigo] [numeric](3, 0) NOT NULL,
	[swift] [varchar](11) NOT NULL,
	[receptor] [varchar](50) NOT NULL,
	[mt_20] [varchar](16) NOT NULL,
	[mt_21] [varchar](16) NOT NULL,
	[mt_32a_fecha] [varchar](10) NOT NULL,
	[mt_32a_monto] [numeric](19, 2) NOT NULL,
	[mt_32a_moneda] [varchar](3) NOT NULL,
	[mt_50] [varchar](250) NOT NULL,
	[mt_52_cuenta] [varchar](35) NOT NULL,
	[mt_52_swift] [varchar](11) NOT NULL,
	[mt_52_direccion] [varchar](150) NOT NULL,
	[mt_53_cuenta] [varchar](35) NOT NULL,
	[mt_53_swift] [varchar](11) NOT NULL,
	[mt_53_sucursal] [varchar](35) NOT NULL,
	[mt_53_direccion] [varchar](150) NOT NULL,
	[mt_54_cuenta] [varchar](35) NOT NULL,
	[mt_54_swift] [varchar](11) NOT NULL,
	[mt_54_sucursal] [varchar](35) NOT NULL,
	[mt_54_direccion] [varchar](150) NOT NULL,
	[mt_56_cuenta] [varchar](35) NOT NULL,
	[mt_56_swift] [varchar](11) NOT NULL,
	[mt_56_direccion] [varchar](150) NOT NULL,
	[mt_57_cuenta] [varchar](35) NOT NULL,
	[mt_57_swift] [varchar](11) NOT NULL,
	[mt_57_sucursal] [varchar](35) NOT NULL,
	[mt_57_direccion] [varchar](150) NOT NULL,
	[mt_58_cuenta] [varchar](35) NOT NULL,
	[mt_58_swift] [varchar](11) NOT NULL,
	[mt_58_direccion] [varchar](150) NOT NULL,
	[mt_59] [varchar](250) NOT NULL,
	[mt_70] [varchar](250) NOT NULL,
	[mt_71a] [varchar](3) NOT NULL,
	[mt_72] [varchar](250) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[usuario] [varchar](15) NOT NULL,
	[estado] [char](1) NOT NULL,
	[usuario1] [varchar](16) NOT NULL,
	[entidad] [char](50) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__numer__712CA0A5]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfer__tipo__7220C4DE]  DEFAULT ('') FOR [tipo]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__corre__7314E917]  DEFAULT (0) FOR [correlativo]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__codig__74090D50]  DEFAULT (0) FOR [codigo]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__swift__74FD3189]  DEFAULT ('') FOR [swift]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__recep__75F155C2]  DEFAULT ('') FOR [receptor]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_20__76E579FB]  DEFAULT ('') FOR [mt_20]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_21__77D99E34]  DEFAULT ('') FOR [mt_21]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_32__78CDC26D]  DEFAULT ('') FOR [mt_32a_fecha]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_32__79C1E6A6]  DEFAULT (0) FOR [mt_32a_monto]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_32__7AB60ADF]  DEFAULT ('') FOR [mt_32a_moneda]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_50__7BAA2F18]  DEFAULT ('') FOR [mt_50]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_52__7C9E5351]  DEFAULT ('') FOR [mt_52_cuenta]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_52__7D92778A]  DEFAULT ('') FOR [mt_52_swift]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_52__7E869BC3]  DEFAULT ('') FOR [mt_52_direccion]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_53__7F7ABFFC]  DEFAULT ('') FOR [mt_53_cuenta]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_53__006EE435]  DEFAULT ('') FOR [mt_53_swift]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_53__0163086E]  DEFAULT ('') FOR [mt_53_sucursal]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_53__02572CA7]  DEFAULT ('') FOR [mt_53_direccion]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_54__034B50E0]  DEFAULT ('') FOR [mt_54_cuenta]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_54__043F7519]  DEFAULT ('') FOR [mt_54_swift]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_54__05339952]  DEFAULT ('') FOR [mt_54_sucursal]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_54__0627BD8B]  DEFAULT ('') FOR [mt_54_direccion]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_56__071BE1C4]  DEFAULT ('') FOR [mt_56_cuenta]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_56__081005FD]  DEFAULT ('') FOR [mt_56_swift]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_56__09042A36]  DEFAULT ('') FOR [mt_56_direccion]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_57__09F84E6F]  DEFAULT ('') FOR [mt_57_cuenta]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_57__0AEC72A8]  DEFAULT ('') FOR [mt_57_swift]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_57__0BE096E1]  DEFAULT ('') FOR [mt_57_sucursal]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_57__0CD4BB1A]  DEFAULT ('') FOR [mt_57_direccion]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_58__0DC8DF53]  DEFAULT ('') FOR [mt_58_cuenta]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_58__0EBD038C]  DEFAULT ('') FOR [mt_58_swift]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_58__0FB127C5]  DEFAULT ('') FOR [mt_58_direccion]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_59__10A54BFE]  DEFAULT ('') FOR [mt_59]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_70__11997037]  DEFAULT ('') FOR [mt_70]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_71__128D9470]  DEFAULT ('') FOR [mt_71a]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__mt_72__1381B8A9]  DEFAULT ('') FOR [mt_72]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__fecha__1475DCE2]  DEFAULT ('') FOR [fecha]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__usuar__156A011B]  DEFAULT ('') FOR [usuario]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF__tbTransfe__estad__165E2554]  DEFAULT ('P') FOR [estado]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF_tbTransferencia_usuario1]  DEFAULT (' ') FOR [usuario1]
GO
ALTER TABLE [dbo].[tbTransferencia] ADD  CONSTRAINT [DF_tbTransferencia_entidad]  DEFAULT (' ') FOR [entidad]
GO
