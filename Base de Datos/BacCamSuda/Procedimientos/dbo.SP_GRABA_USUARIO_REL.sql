USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_USUARIO_REL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [dbo].[SP_GRABA_USUARIO_REL] (	@Sistema 	Char(10),
					@UserBac 	Char(15),
					@UserExo 	Char(40),
					@nCodCart	Numeric(05)
					)

As
Begin
	If Exists(Select 1 From Usuario_Bac_Otc Where Sistema = @Sistema And Usuario_Bac = @UserBac ) 
		Update Usuario_Bac_Otc 
		Set 	Usuario_Exo = @UserExo,
			Cartera_Bac = 0 -- @nCodCart
		Where Sistema = @Sistema And Usuario_Bac = @UserBac

	Else
		Insert into Usuario_Bac_Otc values (	@Sistema,
							@UserBac,
							@UserExo,
							0) --@nCodCart)

END

GO
