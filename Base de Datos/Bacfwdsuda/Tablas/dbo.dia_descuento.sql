USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[dia_descuento]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dia_descuento](
	[DIA] [int] NOT NULL,
	[X] [int] NOT NULL,
	[Y] [int] NOT NULL,
	[Z] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dia_descuento] ADD  CONSTRAINT [DF__dia_descuen__DIA__59EA13F1]  DEFAULT (0) FOR [DIA]
GO
ALTER TABLE [dbo].[dia_descuento] ADD  CONSTRAINT [DF__dia_descuento__X__5ADE382A]  DEFAULT (0) FOR [X]
GO
ALTER TABLE [dbo].[dia_descuento] ADD  CONSTRAINT [DF__dia_descuento__Y__5BD25C63]  DEFAULT (0) FOR [Y]
GO
ALTER TABLE [dbo].[dia_descuento] ADD  CONSTRAINT [DF__dia_descuento__Z__5CC6809C]  DEFAULT (0) FOR [Z]
GO
