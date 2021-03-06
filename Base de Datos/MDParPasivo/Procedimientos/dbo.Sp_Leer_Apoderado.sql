USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_Apoderado]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Leer_Apoderado] 
			(
			@RutCli  NUMERIC(9) = 0 ,
                        @CodCli  INTEGER    = 0
			)

AS BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON
      SELECT aprutcli   , --  1. RUT Cliente
             apdvcli    , --  2. Digito RUT Cliente
             apcodcli   , --  3. codigo cliente
             aprutapo   , --  4. Rut Apoderado

             apdvapo    , --  5. Digito Rut Apoderado
             apnombre   , --  6. Nombre Apoderado
             apcargo    , --  7. Cargo Apoderado
             apfono     , --  8. Fono Apoderado
             apemail      --  9. E-Mail del Apoderado
                              
        FROM CLIENTE_APODERADO

       WHERE (aprutcli = @RutCli OR @RutCli = 0)
         AND (apcodcli = @CodCli OR @CodCli = 0)
         
SET NOCOUNT OFF
END

GO
