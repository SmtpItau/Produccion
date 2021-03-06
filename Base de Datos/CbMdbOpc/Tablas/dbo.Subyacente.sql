USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[Subyacente]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subyacente](
	[Subyacente] [char](3) NOT NULL,
	[SubyacenteDescripcion] [varchar](40) NOT NULL,
	[Riesgo_Normativo] [int] NULL,
	[Riesgo_Interno] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Subyacente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
