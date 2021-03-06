USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borrar_Operador1]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sp_Borrar_Operador1]( @codigo   NUMERIC(9), 
                                      @clrut    NUMERIC(9) , 
                                      @clcodigo NUMERIC(9) ) 
AS
BEGIN


 	SET DATEFORMAT DMY
	SET NOCOUNT ON


     DELETE FROM CLIENTE_OPERADOR WHERE 	oprutcli = @clrut	
	             			   	AND opcodcli = @codigo
			         	   	AND oprutope = @clcodigo
	




     IF @@ERROR <> 0  BEGIN
         SELECT -1, 'ERROR no se puede Borrar este Operador'
     END

END  -- PROCEDURE



GO
