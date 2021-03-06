USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_OPE_DAT_EMI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_OPE_DAT_EMI] 
( 
   @rut		NUMERIC	(9)	,
   @cod_cli	numeric(9)	
)
AS 
BEGIN

	IF (SELECT COUNT(*) FROM text_emi_itl WHERE rut_emi = @rut and @cod_cli = codigo)=0 BEGIN 
    		SELECT 0
	END
	ELSE BEGIN
		SELECT	nom_emi
		FROM	text_emi_itl
		WHERE	rut_emi= @rut   
		and 	codigo = @cod_cli
	
	end
END	

GO
