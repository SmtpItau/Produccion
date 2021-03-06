USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_OPERADOR1]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Borrar_Operador1    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
CREATE PROCEDURE [dbo].[SP_BORRAR_OPERADOR1]( @codigo   NUMERIC(9), 
                                      @clrut    NUMERIC(9) , 
                                      @clcodigo NUMERIC(9) ) 
AS
BEGIN
     DELETE FROM CLIENTE_OPERADOR WHERE  oprutcli = @clrut 
                     AND opcodcli = @codigo
                 AND oprutope = @clcodigo
 
     IF @@ERROR <> 0  BEGIN
         SELECT -1, 'ERROR no se puede Borrar este Operador'
     END
END  -- PROCEDURE
GO
