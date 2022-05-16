USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_CONTROL_CAMBIO_RUT_OP]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CONTROL_CAMBIO_RUT_OP](
	[ID_SISTEMA] [char](3) NOT NULL,
	[COD_MOTIVO] [char](1) NOT NULL,
	[NRO_OPERACION] [numeric](7, 0) NOT NULL,
	[FECHA_MODIFICA] [datetime] NOT NULL,
	[RUT_ORIGINAL] [numeric](9, 0) NULL,
	[COD_CLIENTE_ORIGINAL] [numeric](9, 0) NULL,
	[RUT_NUEVO] [numeric](9, 0) NULL,
	[COD_CLIENTE_NUEVO] [numeric](9, 0) NULL,
 CONSTRAINT [PK_TBL_CONTROL_CAMBIO_RUT_OP] PRIMARY KEY NONCLUSTERED 
(
	[ID_SISTEMA] ASC,
	[COD_MOTIVO] ASC,
	[NRO_OPERACION] ASC,
	[FECHA_MODIFICA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
