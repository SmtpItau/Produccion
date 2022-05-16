USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSERIEGENERICO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSERIEGENERICO] (  	@Serie 	      CHAR(12) 				  			  
				    )
					 
					 
AS
BEGIN
SET NOCOUNT ON        
	
	        SELECT	trincodigo
		,	trserie
		,	trtipoper
		,	trtasareferencial
	        ,       trrutemisor
	        ,       tricodemisor
	        ,       trgenericemisor
		FROM	tasa_referencia_soma
		WHERE	trserie		= @Serie 
		     
END
SET NOCOUNT OFF
GO
