USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FORMA_DE_PAGO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMA_DE_PAGO](
	[codigo] [numeric](3, 0) NOT NULL,
	[glosa] [char](30) NOT NULL,
	[perfil] [char](9) NOT NULL,
	[codgen] [numeric](3, 0) NOT NULL,
	[glosa2] [char](8) NOT NULL,
	[cc2756] [char](1) NOT NULL,
	[afectacorr] [char](1) NOT NULL,
	[diasvalor] [numeric](3, 0) NOT NULL,
	[numcheque] [char](1) NOT NULL,
	[ctacte] [char](1) NOT NULL,
	[COSTO_DE_FONDO] [numeric](5, 4) NOT NULL,
	[DiasLineas] [int] NOT NULL,
	[CodigoBolsa] [int] NULL,
 CONSTRAINT [PK__FORMA_DE_PAGO__579DE019] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF__FORMA_DE___COSTO__67F770CF]  DEFAULT (0.0) FOR [COSTO_DE_FONDO]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [df_formasPago_DiasLineas]  DEFAULT (0) FOR [DiasLineas]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  DEFAULT (0) FOR [CodigoBolsa]
GO
