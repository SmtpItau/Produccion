USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONMETODOLOGIAREC]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CONMETODOLOGIAREC]	
					  					 					 					 
AS
BEGIN

     SET NOCOUNT ON 
 
		SELECT 	 RecMtdCod			
			,RecMtdNemo			
			,RecMtdDsc		
  
		FROM   BacLineas..Tbl_MetodologiaRec
		
END
SET NOCOUNT OFF
GO
