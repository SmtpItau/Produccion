USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_OPERADOR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Grabar_Operador    fecha de la secuencia de comandos: 03/04/2001 15:18:05 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Grabar_Operador    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_GRABAR_OPERADOR]( @nrutcli NUMERIC(9) , -- RUT Cliente
                                     @ncodcli NUMERIC(9) , -- codigo cliente
                                     @nrutOpe NUMERIC(9) , -- Rut OPERADOR/Codigo
                                     @cdigOpe CHAR(1)    , -- Digito Rut OPERADOR
                                     @cnomOpe CHAR(40)   ) -- Nombre OPERADOR
AS
BEGIN
     IF NOT EXISTS (SELECT 1 FROM CLIENTE_OPERADOR WHERE oprutcli = @nrutcli
                                               AND opcodcli = @ncodcli
                                               AND oprutOpe = @nrutOpe)
     BEGIN
          INSERT INTO CLIENTE_OPERADOR( oprutcli ,
                                  oprutope ,
                                  opdvope  ,
                                  opnombre ,
                                  opcodcli )
                         VALUES( @nrutcli  ,
                                 @nrutOpe  ,
                                 @cdigOpe  ,
                                 @cnomOpe  ,
                                 @ncodcli  )
          IF @@ERROR <> 0   BEGIN
             SELECT 'ERROR no se pudo Agregar Operador'
             RETURN 1
          END
     END ELSE BEGIN
          UPDATE CLIENTE_OPERADOR
             SET opnombre = @cnomOpe
           WHERE oprutcli = @nrutcli
             AND opcodcli = @ncodcli
             AND oprutope = @nrutOpe
          IF @@ERROR <> 0   BEGIN
             SELECT 'ERROR no se pudo Actualizar Operador'
             RETURN 1
          END
     END
END  -- PROCEDURE

GO
