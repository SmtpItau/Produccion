USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacTrasRecepLinCre_AyudaCliente]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacTrasRecepLinCre_AyudaCliente] (@clrut     NUMERIC(9) 
                                                    ,@clcodigo  NUMERIC(9) = 0
                                                    )

AS BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	SELECT 	clrut, 
		cldv, 
		clcodigo,
		clnombre  
	
	FROM CLIENTE

		WHERE clrut    = @clrut
                  AND (clcodigo = @clcodigo or @clcodigo  = 0 )

	SET NOCOUNT OFF

END







GO
