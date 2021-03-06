USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Grabar_Apoderado]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_Grabar_Apoderado]( @nrutcli  NUMERIC(9)  , -- RUT Cliente
                                      @cdigcli  CHAR(1)     , -- Digito RUT Cliente
                                      @ncodcli  NUMERIC(9)  , -- codigo Cliente
                                      @nrutapo  NUMERIC(9)  , -- Rut Apoderado
                                      @cdigapo  CHAR(1)     , -- Digito Rut Apoderado
                                      @cnomapo  CHAR(40)    , -- Nombre Apoderado
                                      @ccargo   CHAR(40)    , -- Cargo del Apoderado
                                      @cfono    CHAR(15)    , -- Fono del Apoderado
                                      @cemail   CHAR(40)    ) -- eMail del Apoderado
AS
BEGIN




   	SET DATEFORMAT DMY
	SET NOCOUNT ON

     IF NOT EXISTS ( SELECT aprutcli FROM CLIENTE_APODERADO
                                    WHERE aprutcli = @nrutcli
                                      AND apcodcli = @ncodcli
                                      AND aprutapo = @nrutapo)
     BEGIN
          INSERT INTO CLIENTE_APODERADO( aprutcli ,
                                   apdvcli  ,
                                   apcodcli ,
                                   aprutapo ,
                                   apdvapo  ,
                                   apnombre ,
                                   apcargo  ,
                                   apfono   ,   
                                   apemail   )
                          VALUES( @nrutcli  ,
                                  @cdigcli  ,
                                  @ncodcli  ,
                                  @nrutapo  ,
                                  @cdigapo  ,
                                  @cnomapo  ,
                                  @ccargo   ,
                                  @cfono    ,
                                  @cemail   )

          IF @@ERROR <> 0    BEGIN
             SELECT -1, 'ERROR no se pudo Insertar este Apoderado'
             RETURN 1
          END

     END ELSE BEGIN

         UPDATE CLIENTE_APODERADO
            SET apnombre = @cnomapo ,
                apcargo  = @ccargo  ,
                apfono   = @cfono   ,
                apemail  = @cemail  

          WHERE aprutcli = @nrutcli
            AND apcodcli = @ncodcli
            AND aprutapo = @nrutapo

          IF @@ERROR <> 0    BEGIN
             SELECT -1, 'ERROR no se pudo Actualizar este Apoderado'
             RETURN 1
          END

     END

END  -- PROCEDURE


GO
