USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_tsp_ctr]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_tsp_ctr](
	[cprutcart] [numeric](9, 0) NOT NULL,
	[trfectraspaso] [datetime] NOT NULL,
	[cpnumdocu] [char](12) NOT NULL,
	[cod_familia] [numeric](4, 0) NULL,
	[cod_nemo] [char](20) NOT NULL,
	[id_instrum] [char](20) NOT NULL,
	[cpfecemi] [datetime] NOT NULL,
	[cpfecven] [datetime] NOT NULL,
	[tptir_ant] [numeric](19, 7) NOT NULL,
	[tppvp_ant] [numeric](19, 7) NOT NULL,
	[tpval_ant] [numeric](19, 4) NOT NULL,
	[tptir_nue] [numeric](19, 7) NOT NULL,
	[tppvp_nue] [numeric](19, 7) NOT NULL,
	[tpval_nue] [numeric](19, 4) NOT NULL,
	[ajuste] [numeric](19, 4) NOT NULL,
	[moneda] [numeric](3, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[cprutcart] ASC,
	[trfectraspaso] ASC,
	[cpnumdocu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___cprut__689D8392]  DEFAULT (0) FOR [cprutcart]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___trfec__6991A7CB]  DEFAULT (' ') FOR [trfectraspaso]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___cpnum__6A85CC04]  DEFAULT (' ') FOR [cpnumdocu]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___cod_f__6B79F03D]  DEFAULT (0) FOR [cod_familia]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___cod_n__6C6E1476]  DEFAULT (' ') FOR [cod_nemo]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___id_in__6D6238AF]  DEFAULT (' ') FOR [id_instrum]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___cpfec__6E565CE8]  DEFAULT (' ') FOR [cpfecemi]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___cpfec__6F4A8121]  DEFAULT (' ') FOR [cpfecven]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___tptir__703EA55A]  DEFAULT (0) FOR [tptir_ant]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___tppvp__7132C993]  DEFAULT (0) FOR [tppvp_ant]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___tpval__7226EDCC]  DEFAULT (0) FOR [tpval_ant]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___tptir__731B1205]  DEFAULT (0) FOR [tptir_nue]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___tppvp__740F363E]  DEFAULT (0) FOR [tppvp_nue]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___tpval__75035A77]  DEFAULT (0) FOR [tpval_nue]
GO
ALTER TABLE [dbo].[text_tsp_ctr] ADD  CONSTRAINT [DF__text_tsp___ajust__75F77EB0]  DEFAULT (0) FOR [ajuste]
GO
ALTER TABLE [dbo].[text_tsp_ctr]  WITH CHECK ADD FOREIGN KEY([cod_familia])
REFERENCES [dbo].[text_fml_inm] ([Cod_familia])
GO
ALTER TABLE [dbo].[text_tsp_ctr]  WITH CHECK ADD FOREIGN KEY([cprutcart])
REFERENCES [dbo].[text_arc_ctl_dri] ([acrutprop])
GO
