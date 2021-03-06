USE [BacLineas]
GO
/****** Object:  Table [dbo].[StatusLineaCliente]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusLineaCliente](
	[Rut] [numeric](15, 0) NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [Pk_StatusLineaCliente] PRIMARY KEY CLUSTERED 
(
	[Rut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatusLineaCliente] ADD  CONSTRAINT [df_StatusLineaCliente_Rut]  DEFAULT ((0)) FOR [Rut]
GO
ALTER TABLE [dbo].[StatusLineaCliente] ADD  CONSTRAINT [df_StatusLineaCliente_Status]  DEFAULT ((0)) FOR [Status]
GO
