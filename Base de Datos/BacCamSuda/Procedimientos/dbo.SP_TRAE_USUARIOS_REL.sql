USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_USUARIOS_REL]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create Procedure [dbo].[SP_TRAE_USUARIOS_REL]
As
Begin
	Select 	Sistema,
		Usuario_Bac,
		Usuario_Exo,
		Cartera_Bac,
		' ' --b.tbglosa
	from Usuario_Bac_Otc
	Order by Sistema,Usuario_Bac

END










GO
