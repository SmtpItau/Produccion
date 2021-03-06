USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_gar_fRedondeo]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_gar_fRedondeo](
	[MontoInicio] [numeric](21, 4) NOT NULL,
	[MontoFinal] [numeric](21, 4) NOT NULL,
	[MontoRequerido] [numeric](21, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_gar_fRedondeo] ADD  DEFAULT (0.0000) FOR [MontoInicio]
GO
ALTER TABLE [dbo].[tbl_gar_fRedondeo] ADD  DEFAULT (0.0000) FOR [MontoFinal]
GO
ALTER TABLE [dbo].[tbl_gar_fRedondeo] ADD  DEFAULT (0.0000) FOR [MontoRequerido]
GO
