USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_REL_USU_CART_VOLCKER_RULE]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_REL_USU_CART_VOLCKER_RULE](
	[Ucvr_Usuario] [char](15) NOT NULL,
	[Ucvr_Sistema] [char](5) NOT NULL,
	[Ucvr_Producto] [char](5) NOT NULL,
	[Ucvr_Codigo_Cart] [char](10) NOT NULL,
	[Ucvr_Default] [char](1) NOT NULL,
 CONSTRAINT [PK_TBL_REL_USU_CART_VOLCKER_RULE] PRIMARY KEY CLUSTERED 
(
	[Ucvr_Usuario] ASC,
	[Ucvr_Sistema] ASC,
	[Ucvr_Producto] ASC,
	[Ucvr_Codigo_Cart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_REL_USU_CART_VOLCKER_RULE] ADD  CONSTRAINT [df_tbl_rel_usu_cart_volcker_rule_Ucvr_Usuario]  DEFAULT ('') FOR [Ucvr_Usuario]
GO
ALTER TABLE [dbo].[TBL_REL_USU_CART_VOLCKER_RULE] ADD  CONSTRAINT [df_tbl_rel_usu_cart_volcker_rule_Ucvr_Sistema]  DEFAULT ('') FOR [Ucvr_Sistema]
GO
ALTER TABLE [dbo].[TBL_REL_USU_CART_VOLCKER_RULE] ADD  CONSTRAINT [df_tbl_rel_usu_cart_volcker_rule_Ucvr_Producto]  DEFAULT ('') FOR [Ucvr_Producto]
GO
ALTER TABLE [dbo].[TBL_REL_USU_CART_VOLCKER_RULE] ADD  CONSTRAINT [df_tbl_rel_usu_cart_volcker_rule_Ucvr_Codigo_Cart]  DEFAULT ('') FOR [Ucvr_Codigo_Cart]
GO
ALTER TABLE [dbo].[TBL_REL_USU_CART_VOLCKER_RULE] ADD  CONSTRAINT [df_tbl_rel_usu_cart_volcker_rule_Ucvr_Default]  DEFAULT ('') FOR [Ucvr_Default]
GO
