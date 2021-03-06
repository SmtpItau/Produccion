USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[RIESGO_PAIS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RIESGO_PAIS](
	[codigo_pais] [numeric](5, 0) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[porcentaje] [numeric](8, 4) NOT NULL,
	[totalasignado] [numeric](19, 0) NOT NULL,
	[totalocupado] [numeric](19, 0) NOT NULL,
	[totaldisponible] [numeric](19, 0) NOT NULL,
	[totalexceso] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_pais] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RIESGO_PAIS] ADD  CONSTRAINT [DF__RIESGO_PA__Porce__1A615E5D]  DEFAULT (0) FOR [porcentaje]
GO
ALTER TABLE [dbo].[RIESGO_PAIS] ADD  CONSTRAINT [DF__RIESGO_PA__Total__1B558296]  DEFAULT (0) FOR [totalasignado]
GO
ALTER TABLE [dbo].[RIESGO_PAIS] ADD  CONSTRAINT [DF__RIESGO_PA__Total__1C49A6CF]  DEFAULT (0) FOR [totalocupado]
GO
ALTER TABLE [dbo].[RIESGO_PAIS] ADD  CONSTRAINT [DF__RIESGO_PA__Total__1D3DCB08]  DEFAULT (0) FOR [totaldisponible]
GO
ALTER TABLE [dbo].[RIESGO_PAIS] ADD  CONSTRAINT [DF__RIESGO_PA__Total__1E31EF41]  DEFAULT (0) FOR [totalexceso]
GO
ALTER TABLE [dbo].[RIESGO_PAIS]  WITH CHECK ADD FOREIGN KEY([codigo_pais])
REFERENCES [dbo].[PAIS] ([codigo_pais])
GO
