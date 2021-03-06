USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDAPGRABAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MDAPGRABAR]
       (
        @nrutcli     NUMERIC(9,0)    , -- RUT Cliente
        @cdigcli     CHAR(1)         , -- Digito RUT Cliente
        @nrutapo     NUMERIC(9,0)    , -- Rut Apoderado
        @cdigapo     CHAR(1)         , -- Digito Rut Apoderado
        @cnomapo     CHAR(40)        , -- Nombre Apoderado
 @ccargo      CHAR(40)      , -- Cargo del Apoderado  
 @cfono      CHAR(15)      , -- Fono del Apoderado
 @ncodcli     NUMERIC(9,0)     -- codigo Cliente
       )
AS
BEGIN
SET NOCOUNT ON
   /*=======================================================================*/
   IF NOT EXISTS (
                   SELECT       aprutcli
                          FROM  VIEW_CLIENTE_APODERADO
                          WHERE (aprutcli = @nrutcli    AND
                                apcodcli = @ncodcli )  AND                  
                                aprutapo = @nrutapo
                 ) BEGIN
      /*====================================================================*/
      INSERT INTO VIEW_CLIENTE_APODERADO (
                        aprutcli   , -- 01 RUT Cliente
                        apdvcli    , -- 02 Digito RUT Cliente
                        aprutapo   , -- 03 Rut Apoderado
                        apdvapo    , -- 04 Digito Rut Apoderado
                        apnombre   , -- 05 Nombre Apoderado
   apcargo    , --    Cargo Apoderado
   apfono    , --    Fono Apoderado 
                        apcodcli     --    codigo cliente      
                        )
             VALUES    (
                        @nrutcli    , -- 01 RUT Cliente
                        @cdigcli    , -- 02 Digito RUT Cliente
                        @nrutapo    , -- 03 Rut Apoderado
                        @cdigapo    , -- 04 Digito Rut Apoderado
                        @cnomapo    , -- 05 Nombre Apoderado
   @ccargo     , --    Cargo Apoderado
   @cfono      , --    Fono Apoderado 
                        @ncodcli     
                       )
    /*======================================================================*/
    END ELSE BEGIN
       /*===================================================================*/
       UPDATE       VIEW_CLIENTE_APODERADO
              SET   apnombre = @cnomapo         , -- Nombre Apoderado
      apcargo  = @ccargo  , -- Cargo Apoderado
      apfono   = @cfono             -- Fono Apoderado
              WHERE (aprutcli = @nrutcli   AND  apcodcli =@ncodcli ) AND
                    aprutapo = @nrutapo
    END
    /*======================================================================*/
    SELECT 'OK', ''
    /*======================================================================*/
    RETURN 0
   SET NOCOUNT OFF
END

GO
