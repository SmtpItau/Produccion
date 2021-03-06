USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_APODERADO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_Apoderado    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Leer_Apoderado    fecha de la secuencia de comandos: 14/02/2001 09:58:28 ******/
CREATE PROCEDURE [dbo].[SP_LEER_APODERADO]( @RutCli  NUMERIC(9) = 0 ,
                                    @CodCli  INTEGER    = 0 )
AS
BEGIN
      SELECT aprutcli   , --  1. RUT Cliente
             apdvcli    , --  2. Digito RUT Cliente
             apcodcli   , --  3. codigo cliente
             aprutapo   , --  4. Rut Apoderado
             apdvapo    , --  5. Digito Rut Apoderado
             apnombre   , --  6. Nombre Apoderado
             apcargo    , --  7. Cargo Apoderado
             apfono     , --  8. Fono Apoderado
             apemail      --  9. email Apoderado

        FROM CLIENTE_APODERADO

       WHERE (aprutcli = @RutCli OR @RutCli = 0)
         AND (apcodcli = @CodCli OR @CodCli = 0)
         
END
GO
