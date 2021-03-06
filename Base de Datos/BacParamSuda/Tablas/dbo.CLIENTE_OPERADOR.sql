USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CLIENTE_OPERADOR]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE_OPERADOR](
	[oprutcli] [numeric](9, 0) NOT NULL,
	[opcodcli] [numeric](9, 0) NOT NULL,
	[oprutope] [numeric](9, 0) NOT NULL,
	[opdvope] [char](1) NULL,
	[opnombre] [char](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[oprutcli] ASC,
	[opcodcli] ASC,
	[oprutope] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CLIENTE_OPERADOR] ADD  CONSTRAINT [DF__CLIENTE_O__Opdvo__285A77F9]  DEFAULT ('') FOR [opdvope]
GO
ALTER TABLE [dbo].[CLIENTE_OPERADOR] ADD  CONSTRAINT [DF__CLIENTE_O__Opnom__294E9C32]  DEFAULT ('') FOR [opnombre]
GO
