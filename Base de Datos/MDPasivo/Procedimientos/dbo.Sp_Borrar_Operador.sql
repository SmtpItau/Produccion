USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Borrar_Operador]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_Borrar_Operador]( @codigo   NUMERIC(9) ,
                                     @clrut    NUMERIC(9) ,
                                     @clcodigo NUMERIC(9) )
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


     IF @codigo <> 0  BEGIN

        DELETE FROM cliente_operador WHERE oprutope = @codigo --AND oprutcli = @clrut 

        IF @@ERROR <> 0  BEGIN
           SELECT -1, 'ERROR no se puede Borrar este Operador'
        END

     END ELSE BEGIN

        DELETE FROM CLIENTE_OPERADOR WHERE oprutcli = @clrut AND opcodcli = @clcodigo

        IF @@ERROR <> 0  BEGIN
           SELECT -1, 'ERROR no se puede Borrar este Operador'
        END

     END

END  -- PROCEDURE


GO
