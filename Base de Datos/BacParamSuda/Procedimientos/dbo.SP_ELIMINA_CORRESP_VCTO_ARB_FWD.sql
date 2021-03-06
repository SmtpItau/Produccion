USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_CORRESP_VCTO_ARB_FWD]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINA_CORRESP_VCTO_ARB_FWD]
as
begin
SET NOCOUNT ON

	DELETE  ARB_FWD_CORRESPONSAL

	If @@error <> 0 
	Begin
	     Select 'NO' AS RESULTADO
	     Return -1
	End
	     Select 'OK' AS RESULTADO
	     Return  0
SET NOCOUNT OFF
end
GO
