USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_MESAS]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_MESAS](
	[Id_Mesa] [int] NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[Definicion] [varchar](100) NOT NULL,
 CONSTRAINT [Pk_TblMesas] PRIMARY KEY CLUSTERED 
(
	[Id_Mesa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_MESAS] ADD  CONSTRAINT [df_tbl_mesas_Id_Mesa]  DEFAULT ((0)) FOR [Id_Mesa]
GO
ALTER TABLE [dbo].[TBL_MESAS] ADD  CONSTRAINT [df_tbl_mesas_Descripcion]  DEFAULT ('') FOR [Descripcion]
GO
ALTER TABLE [dbo].[TBL_MESAS] ADD  CONSTRAINT [df_tbl_mesas_Definicion]  DEFAULT ('') FOR [Definicion]
GO
