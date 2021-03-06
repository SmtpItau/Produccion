USE [BacLineas]
GO
/****** Object:  Table [dbo].[TBL_RieFinTabla_Max_Exp]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RieFinTabla_Max_Exp](
	[Fecha] [datetime] NOT NULL,
	[Rut] [int] NOT NULL,
	[Codigo] [int] NOT NULL,
	[MtM] [float] NULL,
	[Maxima_Exposicion] [float] NULL,
	[Vehiculo] [varchar](15) NOT NULL,
 CONSTRAINT [PK_TBL_RieFinTabla_Max_Exp] PRIMARY KEY CLUSTERED 
(
	[Vehiculo] ASC,
	[Fecha] ASC,
	[Rut] ASC,
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_RieFinTabla_Max_Exp] ADD  CONSTRAINT [DF_TBL_RieFinTabla_Max_Exp_Vehiculo]  DEFAULT ('CORPBANCA') FOR [Vehiculo]
GO
