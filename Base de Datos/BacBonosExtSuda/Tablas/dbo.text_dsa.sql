USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_dsa]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_dsa](
	[Cod_familia] [numeric](4, 0) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[num_cupon] [numeric](3, 0) NOT NULL,
	[fecha_vcto] [datetime] NOT NULL,
	[fecha_vcto_cupon] [datetime] NOT NULL,
	[interes] [float] NOT NULL,
	[amortizacion] [float] NOT NULL,
	[flujo] [float] NOT NULL,
	[saldo] [float] NOT NULL,
	[Factor] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Cod_familia] ASC,
	[cod_nemo] ASC,
	[num_cupon] ASC,
	[fecha_vcto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_dsa] ADD  CONSTRAINT [DF__text_dsa__Cod_fa__3EDC53F0]  DEFAULT (0) FOR [Cod_familia]
GO
ALTER TABLE [dbo].[text_dsa] ADD  CONSTRAINT [DF__text_dsa__cod_ne__3FD07829]  DEFAULT (' ') FOR [cod_nemo]
GO
ALTER TABLE [dbo].[text_dsa] ADD  CONSTRAINT [DF__text_dsa__num_cu__40C49C62]  DEFAULT (0) FOR [num_cupon]
GO
ALTER TABLE [dbo].[text_dsa] ADD  CONSTRAINT [DF__text_dsa__fecha___41B8C09B]  DEFAULT (' ') FOR [fecha_vcto]
GO
ALTER TABLE [dbo].[text_dsa] ADD  CONSTRAINT [DF__text_dsa__fecha___42ACE4D4]  DEFAULT (' ') FOR [fecha_vcto_cupon]
GO
ALTER TABLE [dbo].[text_dsa] ADD  CONSTRAINT [DF__text_dsa__intere__43A1090D]  DEFAULT (0) FOR [interes]
GO
ALTER TABLE [dbo].[text_dsa] ADD  CONSTRAINT [DF__text_dsa__amorti__44952D46]  DEFAULT (0) FOR [amortizacion]
GO
ALTER TABLE [dbo].[text_dsa] ADD  CONSTRAINT [DF__text_dsa__flujo__4589517F]  DEFAULT (0) FOR [flujo]
GO
ALTER TABLE [dbo].[text_dsa] ADD  CONSTRAINT [DF__text_dsa__saldo__467D75B8]  DEFAULT (0) FOR [saldo]
GO
ALTER TABLE [dbo].[text_dsa] ADD  DEFAULT (1) FOR [Factor]
GO
ALTER TABLE [dbo].[text_dsa]  WITH NOCHECK ADD  CONSTRAINT [FK__text_dsa__4356F04A] FOREIGN KEY([Cod_familia], [cod_nemo], [fecha_vcto])
REFERENCES [dbo].[text_ser] ([Cod_familia], [cod_nemo], [fecha_vcto])
GO
ALTER TABLE [dbo].[text_dsa] CHECK CONSTRAINT [FK__text_dsa__4356F04A]
GO
