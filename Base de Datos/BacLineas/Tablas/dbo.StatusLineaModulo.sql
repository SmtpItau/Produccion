USE [BacLineas]
GO
/****** Object:  Table [dbo].[StatusLineaModulo]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusLineaModulo](
	[Btr] [int] NOT NULL,
	[Bex] [int] NOT NULL,
	[Bcc] [int] NOT NULL,
	[Bfw] [int] NOT NULL,
	[Opt] [int] NOT NULL,
	[Pcs] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatusLineaModulo] ADD  CONSTRAINT [df_StatusLineaModulo_Btr]  DEFAULT ((-1)) FOR [Btr]
GO
ALTER TABLE [dbo].[StatusLineaModulo] ADD  CONSTRAINT [df_StatusLineaModulo_Bex]  DEFAULT ((-1)) FOR [Bex]
GO
ALTER TABLE [dbo].[StatusLineaModulo] ADD  CONSTRAINT [df_StatusLineaModulo_Bcc]  DEFAULT ((-1)) FOR [Bcc]
GO
ALTER TABLE [dbo].[StatusLineaModulo] ADD  CONSTRAINT [df_StatusLineaModulo_Bfw]  DEFAULT ((-1)) FOR [Bfw]
GO
ALTER TABLE [dbo].[StatusLineaModulo] ADD  CONSTRAINT [df_StatusLineaModulo_Opt]  DEFAULT ((-1)) FOR [Opt]
GO
ALTER TABLE [dbo].[StatusLineaModulo] ADD  CONSTRAINT [df_StatusLineaModulo_Pcs]  DEFAULT ((-1)) FOR [Pcs]
GO
