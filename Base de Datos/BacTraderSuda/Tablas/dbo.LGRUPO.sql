USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[LGRUPO]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LGRUPO](
	[rut_grupo] [numeric](9, 0) NOT NULL,
	[glosa] [char](40) NOT NULL,
	[mtomax] [numeric](19, 4) NULL,
	[mtocupfwd] [numeric](19, 4) NULL,
	[mtocupspt] [numeric](19, 4) NULL,
	[mtocupotr] [numeric](19, 4) NULL,
	[mtocuptrd] [numeric](19, 4) NULL,
	[mtocupado] [numeric](19, 4) NULL,
	[mtodispon] [numeric](19, 4) NULL,
	[grupo] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[rut_grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LGRUPO] ADD  CONSTRAINT [DF__lgrupo__Mtomax__468862B0]  DEFAULT (0) FOR [mtomax]
GO
ALTER TABLE [dbo].[LGRUPO] ADD  CONSTRAINT [DF__lgrupo__Mtocupfw__477C86E9]  DEFAULT (0) FOR [mtocupfwd]
GO
ALTER TABLE [dbo].[LGRUPO] ADD  CONSTRAINT [DF__lgrupo__Mtocupsp__4870AB22]  DEFAULT (0) FOR [mtocupspt]
GO
ALTER TABLE [dbo].[LGRUPO] ADD  CONSTRAINT [DF__lgrupo__mtocupot__4964CF5B]  DEFAULT (0) FOR [mtocupotr]
GO
ALTER TABLE [dbo].[LGRUPO] ADD  CONSTRAINT [DF__lgrupo__Mtocuptr__4A58F394]  DEFAULT (0) FOR [mtocuptrd]
GO
ALTER TABLE [dbo].[LGRUPO] ADD  CONSTRAINT [DF__lgrupo__Mtocupad__4B4D17CD]  DEFAULT (0) FOR [mtocupado]
GO
ALTER TABLE [dbo].[LGRUPO] ADD  CONSTRAINT [DF__lgrupo__Mtodispo__4C413C06]  DEFAULT (0) FOR [mtodispon]
GO
ALTER TABLE [dbo].[LGRUPO] ADD  CONSTRAINT [DF__lgrupo__Grupo__4D35603F]  DEFAULT (' ') FOR [grupo]
GO
