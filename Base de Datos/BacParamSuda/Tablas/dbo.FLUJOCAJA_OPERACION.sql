USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FLUJOCAJA_OPERACION]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FLUJOCAJA_OPERACION](
	[codigo_concepto] [numeric](3, 0) NOT NULL,
	[fechaoperacion] [datetime] NOT NULL,
	[montooperacion] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_concepto] ASC,
	[fechaoperacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FLUJOCAJA_OPERACION] ADD  CONSTRAINT [DF__FLUJOCAJA__Monto__1E66F96B]  DEFAULT (0) FOR [montooperacion]
GO
ALTER TABLE [dbo].[FLUJOCAJA_OPERACION]  WITH CHECK ADD FOREIGN KEY([codigo_concepto])
REFERENCES [dbo].[TIPOCONCEPTO_FLUJOCAJA] ([codigo_concepto])
GO
