USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEL_APODERADOS_OPCIONES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DEL_APODERADOS_OPCIONES] 
				(  @Orden NUMERIC(5,0) =0
				,  @Estructura NUMERIC(5,0) =0
				,  @RutCli  NUMERIC(10,0) =0 
				  
    )    
	AS
	BEGIN	
		
	   DELETE FROM DBO.TBL_APODERADOS_BANCO 

	END	

GO
