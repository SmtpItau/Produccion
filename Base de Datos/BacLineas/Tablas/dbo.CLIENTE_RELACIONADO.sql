USE [BacLineas]
GO
/****** Object:  Table [dbo].[CLIENTE_RELACIONADO]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE_RELACIONADO](
	[clrut_padre] [numeric](9, 0) NOT NULL,
	[clcodigo_padre] [numeric](5, 0) NOT NULL,
	[clrut_hijo] [numeric](9, 0) NOT NULL,
	[clcodigo_hijo] [numeric](5, 0) NOT NULL,
	[clporcentaje] [float] NULL,
	[Afecta_Lineas_Hijo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[clrut_padre] ASC,
	[clcodigo_padre] ASC,
	[clrut_hijo] ASC,
	[clcodigo_hijo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CLIENTE_RELACIONADO] ADD  CONSTRAINT [DF__CLIENTE_R__Clpor__2C2B08DD]  DEFAULT (0) FOR [clporcentaje]
GO
ALTER TABLE [dbo].[CLIENTE_RELACIONADO] ADD  DEFAULT ((0)) FOR [Afecta_Lineas_Hijo]
GO
