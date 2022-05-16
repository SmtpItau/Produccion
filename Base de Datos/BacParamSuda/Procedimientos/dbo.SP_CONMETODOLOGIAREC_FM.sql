USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONMETODOLOGIAREC_FM]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONMETODOLOGIAREC_FM]
					  					 					 					 
AS
BEGIN

     SET NOCOUNT ON 
 
		SELECT	RecMtdCod			
		,		RecMtdNemo			
		,		RecMtdDsc		
  
		FROM	BacLineas..Tbl_MetodologiaRec
        WHERE	RecMtdCod NOT IN (2,3,5)
		 
END
SET NOCOUNT OFF
GO
