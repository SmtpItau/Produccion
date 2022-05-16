USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLIENTE_APODERADO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLIENTE_APODERADO] 
	(    
          @RutCli NUMERIC(9)    
        , @Codigo NUMERIC(2)   
    )    
AS 
BEGIN
	SELECT	aprutapo 
	,		apnombre 
	FROM	CLIENTE_APODERADO
	WHERE	aprutcli=@RutCli 
	AND		apcodcli =@Codigo
	
END

GO
