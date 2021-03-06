USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FWK_USERS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FWK_USERS](
	[id_aplicacion] [nvarchar](30) NOT NULL,
	[id_user] [nvarchar](30) NOT NULL,
	[Email] [nvarchar](128) NOT NULL,
	[Comment] [nvarchar](255) NULL,
	[PASSWORD] [nvarchar](128) NOT NULL,
	[PasswordQuestion] [nvarchar](255) NULL,
	[PasswordAnswer] [nvarchar](255) NULL,
	[IsApproved] [bit] NULL,
	[LastActivityDate] [datetime] NULL,
	[LastLoginDate] [datetime] NULL,
	[LastPasswordChangedDate] [datetime] NULL,
	[CreationDate] [datetime] NULL,
	[IsOnLine] [bit] NULL,
	[IsLockedOut] [bit] NULL,
	[LastLockedOutDate] [datetime] NULL,
	[FailedPasswordAttemptCount] [int] NULL,
	[FailedPasswordAttemptWindowStart] [datetime] NULL,
	[FailedPasswordAnswerAttemptCount] [int] NULL,
	[FailedPasswordAnswerAttemptWindowStart] [datetime] NULL,
	[Password1] [nvarchar](128) NULL,
	[Password2] [nvarchar](128) NULL,
	[Password3] [nvarchar](128) NULL,
	[Password4] [nvarchar](128) NULL,
	[IsReset] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_aplicacion] ASC,
	[id_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FWK_USERS] ADD  DEFAULT (getdate()) FOR [LastLoginDate]
GO
ALTER TABLE [dbo].[FWK_USERS] ADD  DEFAULT ((0)) FOR [IsReset]
GO
