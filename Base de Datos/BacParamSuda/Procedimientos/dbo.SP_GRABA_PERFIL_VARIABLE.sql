USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PERFIL_VARIABLE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABA_PERFIL_VARIABLE]
   (   @idsistema   CHAR(3)     ,
       @usuario     CHAR(20)    ,
       @fila        NUMERIC(10) ,
       @valor       CHAR(30)    ,
       @cuenta      CHAR(30)    ,
       @descripcion CHAR(70)    ,
       @perfil      NUMERIC(10)
   )
AS
BEGIN

   SET NOCOUNT ON
 
   INSERT INTO PASO_CNT 
      VALUES(@idsistema,@usuario,@fila ,@valor ,@cuenta ,@descripcion,@perfil)
 
   IF @@ERROR <> 0
   BEGIN
      PRINT 'FALLA AGREGANDO PASO_CNT.'
      SELECT 'ERR'
   END

   SELECT 'OK'

END
GO
