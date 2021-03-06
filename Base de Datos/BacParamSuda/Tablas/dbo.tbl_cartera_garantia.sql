USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_cartera_garantia]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cartera_garantia](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Instrumento] [varchar](12) NOT NULL,
	[Mascara] [varchar](12) NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[TIR] [numeric](9, 6) NOT NULL,
	[VPAR] [numeric](9, 6) NOT NULL,
	[Vpvp] [numeric](9, 6) NOT NULL,
	[ValorPresente] [numeric](21, 0) NOT NULL,
	[ValorPresenteAyer] [numeric](21, 4) NOT NULL,
	[Duration] [float] NOT NULL,
	[DurationMod] [float] NOT NULL,
	[Convexidad] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Numer__7347913C]  DEFAULT (0) FOR [NumeroOperacion]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Corre__743BB575]  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Instr__752FD9AE]  DEFAULT ('') FOR [Instrumento]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Masca__7623FDE7]  DEFAULT ('') FOR [Mascara]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Nomin__77182220]  DEFAULT (0) FOR [Nominal]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_cartera__TIR__780C4659]  DEFAULT (0) FOR [TIR]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carter__VPAR__79006A92]  DEFAULT (0) FOR [VPAR]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carter__Vpvp__79F48ECB]  DEFAULT (0) FOR [Vpvp]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Valor__7AE8B304]  DEFAULT (0) FOR [ValorPresente]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Valor__7BDCD73D]  DEFAULT (0) FOR [ValorPresenteAyer]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Durat__7CD0FB76]  DEFAULT (0) FOR [Duration]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Durat__7DC51FAF]  DEFAULT (0) FOR [DurationMod]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] ADD  CONSTRAINT [DF__tbl_carte__Conve__7EB943E8]  DEFAULT (0) FOR [Convexidad]
GO
ALTER TABLE [dbo].[tbl_cartera_garantia]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Cartera_Garantia_tbl_Mov_Garantia] FOREIGN KEY([NumeroOperacion])
REFERENCES [dbo].[tbl_Mov_Garantia] ([NumeroOperacion])
GO
ALTER TABLE [dbo].[tbl_cartera_garantia] CHECK CONSTRAINT [FK_tbl_Cartera_Garantia_tbl_Mov_Garantia]
GO
