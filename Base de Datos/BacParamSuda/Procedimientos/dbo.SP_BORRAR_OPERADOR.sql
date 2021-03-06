USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_OPERADOR]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Borrar_Operador    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Borrar_Operador    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRAR_OPERADOR]( @codigo   NUMERIC(9) ,
                                     @clrut    NUMERIC(9) ,
                                     @clcodigo NUMERIC(9) )
AS
BEGIN
     IF @codigo <> 0  BEGIN
        DELETE FROM cliente_operador WHERE oprutope = @codigo
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
