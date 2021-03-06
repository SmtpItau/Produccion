USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ConsulHijos]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_ConsulHijos] 
                                (@rutpadre NUMERIC(10),
				 @codigo   NUMERIC( 3) )
AS
BEGIN   		

	SET DATEFORMAT DMY
	SET NOCOUNT ON


	SELECT  clrut_hijo    ,
		clcodigo_hijo ,
		clporcentaje  ,
		(SELECT clnombre  FROM CLIENTE WHERE clrut = clrut_hijo)
	
        FROM
        	CLIENTE_RELACIONADO	
     	WHERE

        	clrut_padre    = @rutpadre AND
                clcodigo_padre = @codigo
		
     	
	ORDER BY clrut_hijo
  	
END  



GO
