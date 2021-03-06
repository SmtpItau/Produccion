USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MDLBTR_MX]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDLBTR_MX](
	[Sistema] [char](3) NOT NULL,
	[Operacion] [numeric](9, 0) NOT NULL,
	[BancoReceptor] [varchar](50) NOT NULL,
	[SwiftReceptor] [varchar](50) NOT NULL,
	[CtaContable] [varchar](50) NOT NULL,
	[SwiftIntermediario] [varchar](50) NOT NULL,
	[BancoIntermediario] [varchar](50) NOT NULL,
	[CtaCte] [varchar](50) NOT NULL,
	[SwiftBeneficiario] [varchar](50) NOT NULL,
	[BancoBeneficiario] [varchar](50) NOT NULL,
	[DirBeneficiario] [varchar](50) NOT NULL,
	[CiuBeneficiario] [varchar](50) NOT NULL,
 CONSTRAINT [pk_MdlbtrMx] PRIMARY KEY NONCLUSTERED 
(
	[Sistema] ASC,
	[Operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_Sistema]  DEFAULT ('') FOR [Sistema]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_Operacion]  DEFAULT (0) FOR [Operacion]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_BancoReceptor]  DEFAULT ('') FOR [BancoReceptor]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_SwiftReceptor]  DEFAULT ('') FOR [SwiftReceptor]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_CtaContable]  DEFAULT ('') FOR [CtaContable]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_SwiftIntermediario]  DEFAULT ('') FOR [SwiftIntermediario]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_BancoIntermediario]  DEFAULT ('') FOR [BancoIntermediario]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_CtaCte]  DEFAULT ('') FOR [CtaCte]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_SwiftBeneficiario]  DEFAULT ('') FOR [SwiftBeneficiario]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_BancoBeneficiario]  DEFAULT ('') FOR [BancoBeneficiario]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_DirBeneficiario]  DEFAULT ('') FOR [DirBeneficiario]
GO
ALTER TABLE [dbo].[MDLBTR_MX] ADD  CONSTRAINT [dfMdlbtrMx_CiuBeneficiario]  DEFAULT ('') FOR [CiuBeneficiario]
GO
