USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[SwapGeneral_Sim]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwapGeneral_Sim](
	[numero_operacion] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SwapGeneral_Sim] ADD  DEFAULT (0) FOR [numero_operacion]
GO
