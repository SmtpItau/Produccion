USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DELMETODOLOGIAREC]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_DELMETODOLOGIAREC]	(  @RecMtdCod NUMERIC(5,0)	
					)
AS
BEGIN

	SET NOCOUNT ON 

	DELETE	 BacLineas..Tbl_MetodologiaRec
	WHERE	 RecMtdCod = @RecMtdCod
	

	SET NOCOUNT OFF


END
GO
