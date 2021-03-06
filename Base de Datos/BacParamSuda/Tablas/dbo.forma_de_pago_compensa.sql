USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[forma_de_pago_compensa]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[forma_de_pago_compensa](
	[codigo] [decimal](3, 0) NOT NULL,
	[glosa] [char](30) NOT NULL,
	[perfil] [char](9) NOT NULL,
	[codgen] [decimal](3, 0) NOT NULL,
	[glosa2] [char](8) NOT NULL,
	[cc2756] [char](1) NOT NULL,
	[afectacorr] [char](1) NOT NULL,
	[diasvalor] [decimal](3, 0) NOT NULL,
	[numcheque] [char](1) NOT NULL,
	[ctacte] [char](1) NOT NULL,
	[COSTO_DE_FONDO] [decimal](5, 4) NOT NULL
) ON [PRIMARY]
GO
