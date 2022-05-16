USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_OPERADOR1]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Buscar_Operador1    fecha de la secuencia de comandos: 03/04/2001 15:17:59 ******/
CREATE PROCEDURE [dbo].[SP_BUSCAR_OPERADOR1]( @oprutope NUMERIC(9) ) 
AS
BEGIN
     SELECT 
  oprutcli,
  opcodcli,
  oprutope,
  opdvope,
  opnombre
     FROM CLIENTE_OPERADOR WHERE  oprutope = @oprutope
 
     IF @@ERROR <> 0  BEGIN
         SELECT -1, 'ERROR no se puede Borrar este Operador'
     END
END  -- 
GO
