USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_APODERADO]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_APODERADO]( @nrutcli  NUMERIC(9)  , -- RUT Cliente
                                          @cdigcli  CHAR(1)     , -- Digito RUT Cliente
                                          @ncodcli  NUMERIC(9)  , -- codigo Cliente
                                          @nrutapo  NUMERIC(9)  , -- Rut Apoderado
                                          @cdigapo  CHAR(1)     , -- Digito Rut Apoderado
                                          @cnomapo  CHAR(40)    , -- Nombre Apoderado
                                          @ccargo   CHAR(40)    , -- Cargo del Apoderado
                                          @cfono    CHAR(15)    , -- Fono del Apoderado
		   		          @email    char(40)    ,
					  @fecha_escritura DATETIME) -- e-mail del apoderado	
AS
BEGIN
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
				   apemail  ,
				   fecha_escritura)

                          VALUES( @nrutcli  ,
                                  @cdigcli  ,
                                  @ncodcli  ,
                                  @nrutapo  ,
                                  @cdigapo  ,
                                  @cnomapo  ,
                                  @ccargo   ,
                                  @cfono    ,
				  @email    ,
				  @fecha_escritura)

          IF @@ERROR <> 0    BEGIN
             SELECT -1, 'ERROR no se pudo Insertar este Apoderado'
             RETURN 1
          END
     END ELSE BEGIN
         UPDATE CLIENTE_APODERADO
            SET apnombre = @cnomapo ,
                apcargo  = @ccargo  ,
                apfono   = @cfono   ,
		apemail  = @email   ,
		fecha_escritura=@fecha_escritura

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
