USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SEGMENTOSCOMERCIALES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_SEGMENTOSCOMERCIALES]	
					  					 					 					 
AS
BEGIN

     SET NOCOUNT ON 
 
		SELECT 	SgmCod		
		,	SgmNem		
		,	SgmDesc		
		,	RecMtdCod	
  
		FROM   TBL_SEGMENTOSCOMERCIALES
		
END
SET NOCOUNT OFF
GO
