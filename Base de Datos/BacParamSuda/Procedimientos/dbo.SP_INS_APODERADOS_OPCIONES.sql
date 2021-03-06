USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INS_APODERADOS_OPCIONES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INS_APODERADOS_OPCIONES] 
				(  @Orden NUMERIC(5,0)
				,  @Estructura NUMERIC(5,0) 
				,  @RutApod  NUMERIC(9,0)  
				  
    )    
	AS
	BEGIN	

	   INSERT INTO DBO.TBL_APODERADOS_BANCO 
		 (	ORDEN_APODERADO
		 ,	ESTRUCTURA
		 ,	RUT_APODERADO)
	   VALUES  
		 (	@Orden
		 ,	@Estructura
		 ,	@RutApod)
	END	

GO
