USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_ART84_OUTWSIBS_ALE]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_ART84_OUTWSIBS_ALE](
	[ID_Alerta] [int] IDENTITY(1,1) NOT NULL,
	[ID_TICKET] [int] NOT NULL,
	[flagAlerta] [varchar](1) NULL,
	[codigoAlerta] [varchar](4) NULL,
	[descripcionAlerta] [varchar](80) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Alerta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
