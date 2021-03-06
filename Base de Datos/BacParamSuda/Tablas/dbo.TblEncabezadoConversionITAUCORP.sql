USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TblEncabezadoConversionITAUCORP]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblEncabezadoConversionITAUCORP](
	[idParametro] [smallint] NOT NULL,
	[sDescripcion] [varchar](200) NOT NULL,
 CONSTRAINT [PK_TblEncabezadoConversionITAUCORP] PRIMARY KEY CLUSTERED 
(
	[idParametro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
