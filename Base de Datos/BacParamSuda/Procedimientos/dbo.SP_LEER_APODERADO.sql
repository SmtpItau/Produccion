USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_APODERADO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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
             apemail    , --  9. email Apoderado
	     fecha_escritura ---10.fecha_escritura

       FROM CLIENTE_APODERADO

       WHERE (aprutcli = @RutCli OR @RutCli = 0)
         AND (apcodcli = @CodCli OR @CodCli = 0)
         
END

GO
