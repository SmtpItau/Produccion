USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_Gar_DireccionEmail]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Gar_DireccionEmail](
	[NombreDestinatario] [varchar](100) NOT NULL,
	[TipoDestinatario] [int] NOT NULL,
	[DireccionEmail] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Gar_DireccionEmail] ADD  CONSTRAINT [DF_tbl_Gar_DireccionEmail_NombreDestinatario]  DEFAULT ('') FOR [NombreDestinatario]
GO
ALTER TABLE [dbo].[tbl_Gar_DireccionEmail] ADD  CONSTRAINT [DF_tbl_Gar_DireccionEmail_TipoDestinatario]  DEFAULT (0) FOR [TipoDestinatario]
GO
ALTER TABLE [dbo].[tbl_Gar_DireccionEmail] ADD  DEFAULT ('') FOR [DireccionEmail]
GO
