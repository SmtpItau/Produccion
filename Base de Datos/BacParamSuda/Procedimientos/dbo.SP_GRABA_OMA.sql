USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_OMA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Graba_OMA    fecha de la secuencia de comandos: 03/04/2001 15:18:04 ******/
CREATE PROCEDURE [dbo].[SP_GRABA_OMA]( @codigo   NUMERIC (10),
                               @glosa    CHAR    (50),
                               @tipope   CHAR    (10)       -- ver observaciones arriba
                              )
AS
BEGIN
   SET NOCOUNT ON
   IF NOT EXISTS (SELECT codigo_numerico FROM AYUDA_PLANILLA WHERE codigo_numerico = @codigo AND codigo_tabla=14) BEGIN
      --INSERT INTO tbcodigosoma ( codigo_numerico, codigo_caracter,  glosa, codigo_tabla )
 INSERT INTO Ayuda_Planilla( codigo_numerico, codigo_caracter,  glosa, codigo_tabla )
             VALUES            (         @codigo,         @tipope, @glosa,           14 )
 SELECT 'OK'
 RETURN  
   END ELSE BEGIN
      UPDATE AYUDA_PLANILLA
             SET   codigo_numerico = @codigo,
                   codigo_caracter = @tipope,
                   glosa           = @glosa
             WHERE codigo_numerico = @codigo   AND
                   codigo_tabla    = 14
   END
   SELECT 'OK'
   SET NOCOUNT OFF
END
GO
