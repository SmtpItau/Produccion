USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_REGISTRO_INGRESO_OPERACION]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_REGISTRO_INGRESO_OPERACION](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReAplicacion] [varchar](30) NOT NULL,
	[RePantalla] [varchar](50) NOT NULL,
	[ReModuloBac] [varchar](10) NOT NULL,
	[ReOperacion] [numeric](10, 0) NOT NULL,
	[ReFechaApp] [datetime] NOT NULL,
	[RefechaSys] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
