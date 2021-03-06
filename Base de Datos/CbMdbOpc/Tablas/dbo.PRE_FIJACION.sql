USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[PRE_FIJACION]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRE_FIJACION](
	[Usuario] [varchar](15) NOT NULL,
	[NumContrato] [numeric](8, 0) NOT NULL,
	[NumEstructura] [numeric](8, 0) NOT NULL,
	[NumFijacion] [numeric](8, 0) NOT NULL,
	[FechaFijacion] [datetime] NOT NULL,
	[Valor] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC,
	[NumContrato] ASC,
	[NumEstructura] ASC,
	[NumFijacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
