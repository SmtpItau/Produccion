USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_cod_rie]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_cod_rie](
	[clasificador] [char](40) NOT NULL,
	[glosa] [char](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[clasificador] ASC,
	[glosa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_cod_rie] ADD  CONSTRAINT [DF__text_cod___glosa__40F9A68C]  DEFAULT (' ') FOR [glosa]
GO
ALTER TABLE [dbo].[text_cod_rie]  WITH NOCHECK ADD FOREIGN KEY([clasificador])
REFERENCES [dbo].[text_rie] ([clasificador])
GO
