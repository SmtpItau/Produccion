USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[cortesh_desarro]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cortesh_desarro](
	[cornumoper] [decimal](10, 0) NOT NULL,
	[corcorrela] [decimal](3, 0) NOT NULL,
	[corfecvcto] [datetime] NOT NULL,
	[cormonto] [decimal](21, 4) NOT NULL,
	[cormontocomp] [decimal](21, 4) NOT NULL,
	[cormontodia] [decimal](21, 4) NOT NULL,
	[corprecio] [float] NOT NULL,
	[corpreciodia] [float] NOT NULL,
	[correscnv] [decimal](21, 4) NOT NULL,
	[corsaldo] [decimal](21, 0) NOT NULL,
	[corsaldoAcu] [decimal](21, 0) NOT NULL,
	[corsalAcum] [decimal](21, 4) NOT NULL,
	[correajac] [decimal](21, 0) NOT NULL,
	[corresclp] [decimal](21, 0) NOT NULL,
	[corultimo] [char](1) NOT NULL,
	[cortastab] [float] NOT NULL,
	[corestado] [decimal](1, 0) NOT NULL,
	[corbase] [decimal](4, 0) NOT NULL,
	[cointeresac] [decimal](21, 0) NOT NULL,
	[correajayer] [decimal](21, 0) NOT NULL,
	[corinteresayer] [decimal](21, 0) NOT NULL
) ON [PRIMARY]
GO
