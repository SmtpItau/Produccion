USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[forma_de_pago_AUX]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[forma_de_pago_AUX](
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
	[COSTO_DE_FONDO] [numeric](5, 4) NOT NULL
) ON [PRIMARY]
GO
