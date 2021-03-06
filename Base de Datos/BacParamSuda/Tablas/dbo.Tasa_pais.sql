USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Tasa_pais]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tasa_pais](
	[Cod_tasa_pais] [int] IDENTITY(1,1) NOT NULL,
	[Cod_tasa] [int] NOT NULL,
	[Pais] [int] NOT NULL,
	[SpotLag] [int] NOT NULL,
 CONSTRAINT [PK_Tasa_pais_1] PRIMARY KEY CLUSTERED 
(
	[Cod_tasa_pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
