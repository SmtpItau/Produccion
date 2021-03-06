USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_val_frm]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_val_frm](
	[cod_familia] [numeric](4, 0) NULL,
	[cod_nemo] [char](20) NULL,
	[fecha_vcto] [datetime] NULL,
	[tipo_cal] [numeric](1, 0) NULL,
	[num_linea] [numeric](2, 0) NULL,
	[variable] [char](50) NULL,
	[formula] [char](100) NULL,
	[tipo_formula] [char](1) NULL,
	[parametro1] [char](15) NULL,
	[parametro2] [char](15) NULL,
	[parametro3] [char](15) NULL,
	[parametro4] [char](15) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_val_frm] ADD  CONSTRAINT [DF__text_val___cod_f__78D3EB5B]  DEFAULT (0) FOR [cod_familia]
GO
ALTER TABLE [dbo].[text_val_frm]  WITH NOCHECK ADD FOREIGN KEY([cod_familia])
REFERENCES [dbo].[text_fml_inm] ([Cod_familia])
GO
