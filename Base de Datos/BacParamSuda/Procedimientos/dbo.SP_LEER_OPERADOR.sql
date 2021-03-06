USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_OPERADOR]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_Operador    fecha de la secuencia de comandos: 03/04/2001 15:18:07 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_Operador    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROCEDURE [dbo].[SP_LEER_OPERADOR]( @Codigo  NUMERIC(9) = 0 ,
                                   @RutCli  NUMERIC(9) = 0 ,
                                   @CodCli  NUMERIC(9) = 0 )
AS
BEGIN
     SELECT oprutcli   ,
            opcodcli   ,
            oprutope   ,   -- Codigo o Rut del Operador
            opdvope    ,
            opnombre
          
       FROM CLIENTE_OPERADOR
      WHERE (oprutope = @Codigo OR @Codigo = 0)
        AND (oprutcli = @RutCli OR @RutCli = 0)
        AND (opcodcli = @CodCli OR @CodCli = 0)
END

GO
