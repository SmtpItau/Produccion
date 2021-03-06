USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[POSICION_SPT]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POSICION_SPT](
	[vmcodigo] [char](3) NOT NULL,
	[vmfecha] [datetime] NOT NULL,
	[vmposini] [numeric](19, 4) NULL,
	[vmpreini] [float] NULL,
	[vmposic] [numeric](19, 4) NULL,
	[vmtotco] [numeric](19, 4) NULL,
	[vmpmeco] [float] NULL,
	[vmtotcous] [numeric](19, 4) NULL,
	[vmtotcope] [numeric](19, 4) NULL,
	[vmtotve] [numeric](19, 4) NULL,
	[vmpmeve] [float] NULL,
	[vmtotveus] [numeric](19, 4) NULL,
	[vmtotvepe] [numeric](19, 4) NULL,
	[vmutili] [numeric](19, 4) NULL,
	[vmprecierre] [float] NULL,
	[vmparidad] [float] NULL,
	[vmparcom] [float] NULL,
	[vmparven] [float] NULL,
	[vmtotcopo] [numeric](19, 4) NULL,
	[vmpmecopo] [float] NULL,
	[vmtotvepo] [numeric](19, 4) NULL,
	[vmpmevepo] [float] NULL,
	[vmutilipo] [numeric](19, 4) NULL,
	[vmutiltot] [numeric](19, 4) NULL,
	[vmparmes] [float] NULL,
	[vmpositini] [float] NULL,
	[vmposition] [float] NULL,
	[vmnegocio] [numeric](3, 0) NULL,
	[VMLIMITE] [numeric](19, 4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[vmcodigo] ASC,
	[vmfecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpos__7ECE5281]  DEFAULT (0) FOR [vmposini]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpre__7FC276BA]  DEFAULT (0) FOR [vmpreini]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpos__00B69AF3]  DEFAULT (0) FOR [vmposic]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmtot__01AABF2C]  DEFAULT (0) FOR [vmtotco]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpme__029EE365]  DEFAULT (0) FOR [vmpmeco]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmtot__0393079E]  DEFAULT (0) FOR [vmtotcous]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmtot__04872BD7]  DEFAULT (0) FOR [vmtotcope]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmtot__057B5010]  DEFAULT (0) FOR [vmtotve]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpme__066F7449]  DEFAULT (0) FOR [vmpmeve]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmtot__07639882]  DEFAULT (0) FOR [vmtotveus]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmtot__0857BCBB]  DEFAULT (0) FOR [vmtotvepe]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmuti__094BE0F4]  DEFAULT (0) FOR [vmutili]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpre__0A40052D]  DEFAULT (0) FOR [vmprecierre]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpar__0B342966]  DEFAULT (0) FOR [vmparidad]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpar__0C284D9F]  DEFAULT (0) FOR [vmparcom]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpar__0D1C71D8]  DEFAULT (0) FOR [vmparven]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmtot__0E109611]  DEFAULT (0) FOR [vmtotcopo]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpme__0F04BA4A]  DEFAULT (0) FOR [vmpmecopo]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmtot__0FF8DE83]  DEFAULT (0) FOR [vmtotvepo]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpme__10ED02BC]  DEFAULT (0) FOR [vmpmevepo]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmuti__11E126F5]  DEFAULT (0) FOR [vmutilipo]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmuti__12D54B2E]  DEFAULT (0) FOR [vmutiltot]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpar__13C96F67]  DEFAULT (0) FOR [vmparmes]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpos__14BD93A0]  DEFAULT (0) FOR [vmpositini]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmpos__15B1B7D9]  DEFAULT (0) FOR [vmposition]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___Vmneg__16A5DC12]  DEFAULT (0) FOR [vmnegocio]
GO
ALTER TABLE [dbo].[POSICION_SPT] ADD  CONSTRAINT [DF__POSICION___VMLIM__390777BC]  DEFAULT (0) FOR [VMLIMITE]
GO
