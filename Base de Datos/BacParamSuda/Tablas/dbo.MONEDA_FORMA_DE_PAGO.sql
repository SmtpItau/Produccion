USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MONEDA_FORMA_DE_PAGO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MONEDA_FORMA_DE_PAGO](
	[mfcodmon] [numeric](5, 0) NOT NULL,
	[mfcodfor] [numeric](5, 0) NOT NULL,
	[mfmonpag] [numeric](5, 0) NOT NULL,
	[mfsistema] [char](3) NOT NULL,
	[mfestado] [char](1) NOT NULL,
 CONSTRAINT [PK__MONEDA_FORMA_DE___04A65C11] PRIMARY KEY CLUSTERED 
(
	[mfcodmon] ASC,
	[mfcodfor] ASC,
	[mfmonpag] ASC,
	[mfsistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
