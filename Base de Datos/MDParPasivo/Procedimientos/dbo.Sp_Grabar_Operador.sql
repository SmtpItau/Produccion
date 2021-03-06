USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_Operador]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[Sp_Grabar_Operador]( @nrutcli NUMERIC(9) , -- RUT Cliente
                                     @ncodcli NUMERIC(9) , -- codigo cliente
                                     @nrutOpe NUMERIC(9) , -- Rut OPERADOR/Codigo
                                     @cdigOpe CHAR(1)    , -- Digito Rut OPERADOR
                                     @cnomOpe CHAR(40)   ) -- Nombre OPERADOR
AS
BEGIN



   	SET DATEFORMAT DMY
	SET NOCOUNT ON

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
