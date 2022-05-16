USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAREA_USUARIO_REL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[SP_PAREA_USUARIO_REL] (	@Sistema 	Char(10),
					@UserExo 	Char(40)
					)

As
Begin
	If Exists(Select 1 From Usuario_Bac_Otc Where Sistema = @Sistema And Usuario_Exo = @UserExo ) 
		Select  Usuario_Bac
		From Usuario_Bac_Otc
		Where Sistema = @Sistema And Usuario_Exo = @UserExo
		

END
GO
