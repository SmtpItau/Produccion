USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_AYUDACLIENTESYGRUPO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_AYUDACLIENTESYGRUPO]
( 
           @tipo INTEGER = 0 
)
AS 
BEGIN
   SET NOCOUNT ON


	IF @tipo <> 0
		BEGIN
		    SELECT 'RUT'  = STR(clrut) + '-' + cldv
    			,      clcodigo
			,      clnombre
    			,      STR(clrut)
    			,      cldv  
			FROM 	VIEW_CLIENTE , 
				CLIENTE_RELACIONADO 
			WHERE	cltipcli = @tipo 	AND
			 	clrut_hijo    <> clrut  
			ORDER BY
				clnombre

		END
	ELSE
		BEGIN
		    SELECT 'RUT'  = STR(clrut) + '-' + cldv
    			,      clcodigo
			,      clnombre
    			,      STR(clrut)
    			,      cldv  
			FROM 	VIEW_CLIENTE ,
				CLIENTE_RELACIONADO 
			WHERE	cltipcli 	<> 1	AND
			 	clrut_hijo	<> clrut  
			ORDER BY
				clnombre

		END

   SET NOCOUNT OFF

END
GO
