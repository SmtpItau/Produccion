USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINARCOM]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_EliminarCom    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_EliminarCom    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ELIMINARCOM](@COD_PAI NUMERIC(6),
                                @COD_CIU NUMERIC(6),
           @COD_COM NUMERIC(6))
                  
AS
BEGIN
    DELETE CIUDAD_COMUNA WHERE cod_pai = @COD_PAI AND cod_ciu = @COD_CIU AND cod_com = @COD_COM
  
    
   RETURN
END
GO
