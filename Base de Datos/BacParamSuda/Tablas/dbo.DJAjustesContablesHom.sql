USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[DJAjustesContablesHom]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DJAjustesContablesHom](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[Contrato] [numeric](10, 0) NULL,
	[Evento] [varchar](30) NULL,
	[SubEvento] [varchar](30) NULL,
	[FechaEvento] [datetime] NULL,
	[COD_EMP] [char](20) NULL,
	[MontoMdaLocal] [numeric](20, 4) NULL,
	[Modulo] [varchar](30) NULL,
	[KeyCntId_sistema] [varchar](3) NULL,
	[Motivo] [varchar](200) NULL,
	[CUENTA] [varchar](30) NULL,
	[FECHAREAL] [datetime] NULL,
	[USUARIO] [varchar](30) NULL,
	[ORIGEN] [nchar](20) NULL,
 CONSTRAINT [PK_DJAjustesContables_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
