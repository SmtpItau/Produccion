USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_TDE_VER_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_TDE_VER_DAT] 
(
        @cod_familia	NUMERIC		   (5) ,
	@cod_nemo		CHAR		   (20),
	@fecha_vcto	DATETIME		
)
					    
AS
BEGIN
	IF (SELECT COUNT(*) FROM TEXT_DSA WHERE cod_familia=@cod_familia AND cod_nemo=@cod_nemo and fecha_vcto = @fecha_vcto)=0 BEGIN 
    		SELECT 0
	END
	ELSE BEGIN
		SELECT 1   
	END
END

GO
