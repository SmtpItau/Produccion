USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[RPTPLANILLON]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RPTPLANILLON](
	[fechaemision] [varchar](40) NULL,
	[fechainforme] [char](10) NULL,
	[entidad] [char](3) NULL,
	[nombre] [varchar](40) NULL,
	[iglosa_1] [varchar](40) NULL,
	[icant_1] [int] NULL,
	[imonto_1] [float] NULL,
	[iglosa_2] [varchar](40) NULL,
	[icant_2] [int] NULL,
	[imonto_2] [float] NULL,
	[iglosa_3] [varchar](40) NULL,
	[icant_3] [int] NULL,
	[imonto_3] [float] NULL,
	[iglosa_4] [varchar](40) NULL,
	[icant_4] [int] NULL,
	[imonto_4] [float] NULL,
	[iglosa_5] [varchar](40) NULL,
	[icant_5] [int] NULL,
	[imonto_5] [float] NULL,
	[iglosa_6] [varchar](40) NULL,
	[icant_6] [int] NULL,
	[imonto_6] [float] NULL,
	[iglosa_7] [varchar](40) NULL,
	[icant_7] [int] NULL,
	[imonto_7] [float] NULL,
	[iglosa_8] [varchar](40) NULL,
	[icant_8] [int] NULL,
	[imonto_8] [float] NULL,
	[iglosa_9] [varchar](40) NULL,
	[icant_9] [int] NULL,
	[imonto_9] [float] NULL,
	[iglosa_10] [varchar](40) NULL,
	[icant_10] [int] NULL,
	[imonto_10] [float] NULL,
	[iglosa_11] [varchar](40) NULL,
	[icant_11] [int] NULL,
	[imonto_11] [float] NULL,
	[iglosa_12] [varchar](40) NULL,
	[icant_12] [int] NULL,
	[imonto_12] [float] NULL,
	[eglosa_1] [varchar](40) NULL,
	[ecant_1] [int] NULL,
	[emonto_1] [float] NULL,
	[eglosa_2] [varchar](40) NULL,
	[ecant_2] [int] NULL,
	[emonto_2] [float] NULL,
	[eglosa_3] [varchar](40) NULL,
	[ecant_3] [int] NULL,
	[emonto_3] [float] NULL,
	[eglosa_4] [varchar](40) NULL,
	[ecant_4] [int] NULL,
	[emonto_4] [float] NULL,
	[eglosa_5] [varchar](40) NULL,
	[ecant_5] [int] NULL,
	[emonto_5] [float] NULL,
	[eglosa_6] [varchar](40) NULL,
	[ecant_6] [int] NULL,
	[emonto_6] [float] NULL,
	[eglosa_7] [varchar](40) NULL,
	[ecant_7] [int] NULL,
	[emonto_7] [float] NULL,
	[eglosa_8] [varchar](40) NULL,
	[ecant_8] [int] NULL,
	[emonto_8] [float] NULL,
	[eglosa_9] [varchar](40) NULL,
	[ecant_9] [int] NULL,
	[emonto_9] [float] NULL,
	[eglosa_10] [varchar](40) NULL,
	[ecant_10] [int] NULL,
	[emonto_10] [float] NULL,
	[eglosa_11] [varchar](40) NULL,
	[ecant_11] [int] NULL,
	[emonto_11] [float] NULL,
	[eglosa_12] [varchar](40) NULL,
	[ecant_12] [int] NULL,
	[emonto_12] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__Fecha__3A1A00D8]  DEFAULT ('') FOR [fechaemision]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__Fecha__3B0E2511]  DEFAULT ('') FOR [fechainforme]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__Entid__3C02494A]  DEFAULT ('') FOR [entidad]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__Nombr__3CF66D83]  DEFAULT ('') FOR [nombre]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__3DEA91BC]  DEFAULT ('') FOR [iglosa_1]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__3EDEB5F5]  DEFAULT (0) FOR [icant_1]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__3FD2DA2E]  DEFAULT (0) FOR [imonto_1]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__40C6FE67]  DEFAULT ('') FOR [iglosa_2]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__41BB22A0]  DEFAULT (0) FOR [icant_2]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__42AF46D9]  DEFAULT (0) FOR [imonto_2]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__43A36B12]  DEFAULT ('') FOR [iglosa_3]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__44978F4B]  DEFAULT (0) FOR [icant_3]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__458BB384]  DEFAULT (0) FOR [imonto_3]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__467FD7BD]  DEFAULT ('') FOR [iglosa_4]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__4773FBF6]  DEFAULT (0) FOR [icant_4]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__4868202F]  DEFAULT (0) FOR [imonto_4]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__495C4468]  DEFAULT ('') FOR [iglosa_5]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__4A5068A1]  DEFAULT (0) FOR [icant_5]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__4B448CDA]  DEFAULT (0) FOR [imonto_5]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__4C38B113]  DEFAULT ('') FOR [iglosa_6]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__4D2CD54C]  DEFAULT (0) FOR [icant_6]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__4E20F985]  DEFAULT (0) FOR [imonto_6]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__4F151DBE]  DEFAULT ('') FOR [iglosa_7]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__500941F7]  DEFAULT (0) FOR [icant_7]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__50FD6630]  DEFAULT (0) FOR [imonto_7]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__51F18A69]  DEFAULT ('') FOR [iglosa_8]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__52E5AEA2]  DEFAULT (0) FOR [icant_8]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__53D9D2DB]  DEFAULT (0) FOR [imonto_8]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__54CDF714]  DEFAULT ('') FOR [iglosa_9]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__55C21B4D]  DEFAULT (0) FOR [icant_9]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__56B63F86]  DEFAULT (0) FOR [imonto_9]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__57AA63BF]  DEFAULT ('') FOR [iglosa_10]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__589E87F8]  DEFAULT (0) FOR [icant_10]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__5992AC31]  DEFAULT (0) FOR [imonto_10]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__5A86D06A]  DEFAULT ('') FOR [iglosa_11]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__5B7AF4A3]  DEFAULT (0) FOR [icant_11]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__5C6F18DC]  DEFAULT (0) FOR [imonto_11]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iGlos__5D633D15]  DEFAULT ('') FOR [iglosa_12]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iCant__5E57614E]  DEFAULT (0) FOR [icant_12]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__iMont__5F4B8587]  DEFAULT (0) FOR [imonto_12]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__603FA9C0]  DEFAULT ('') FOR [eglosa_1]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__6133CDF9]  DEFAULT (0) FOR [ecant_1]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__6227F232]  DEFAULT (0) FOR [emonto_1]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__631C166B]  DEFAULT ('') FOR [eglosa_2]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__64103AA4]  DEFAULT (0) FOR [ecant_2]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__65045EDD]  DEFAULT (0) FOR [emonto_2]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__65F88316]  DEFAULT ('') FOR [eglosa_3]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__66ECA74F]  DEFAULT (0) FOR [ecant_3]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__67E0CB88]  DEFAULT (0) FOR [emonto_3]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__68D4EFC1]  DEFAULT ('') FOR [eglosa_4]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__69C913FA]  DEFAULT (0) FOR [ecant_4]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__6ABD3833]  DEFAULT (0) FOR [emonto_4]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__6BB15C6C]  DEFAULT ('') FOR [eglosa_5]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__6CA580A5]  DEFAULT (0) FOR [ecant_5]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__6D99A4DE]  DEFAULT (0) FOR [emonto_5]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__6E8DC917]  DEFAULT ('') FOR [eglosa_6]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__6F81ED50]  DEFAULT (0) FOR [ecant_6]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__70761189]  DEFAULT (0) FOR [emonto_6]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__716A35C2]  DEFAULT ('') FOR [eglosa_7]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__725E59FB]  DEFAULT (0) FOR [ecant_7]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__73527E34]  DEFAULT (0) FOR [emonto_7]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__7446A26D]  DEFAULT ('') FOR [eglosa_8]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__753AC6A6]  DEFAULT (0) FOR [ecant_8]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__762EEADF]  DEFAULT (0) FOR [emonto_8]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__77230F18]  DEFAULT ('') FOR [eglosa_9]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__78173351]  DEFAULT (0) FOR [ecant_9]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__790B578A]  DEFAULT (0) FOR [emonto_9]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__79FF7BC3]  DEFAULT ('') FOR [eglosa_10]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__7AF39FFC]  DEFAULT (0) FOR [ecant_10]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__7BE7C435]  DEFAULT (0) FOR [emonto_10]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__7CDBE86E]  DEFAULT ('') FOR [eglosa_11]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__7DD00CA7]  DEFAULT (0) FOR [ecant_11]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__7EC430E0]  DEFAULT (0) FOR [emonto_11]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eGlos__7FB85519]  DEFAULT ('') FOR [eglosa_12]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eCant__00AC7952]  DEFAULT (0) FOR [ecant_12]
GO
ALTER TABLE [dbo].[RPTPLANILLON] ADD  CONSTRAINT [DF__rptPlanil__eMont__01A09D8B]  DEFAULT (0) FOR [emonto_12]
GO
