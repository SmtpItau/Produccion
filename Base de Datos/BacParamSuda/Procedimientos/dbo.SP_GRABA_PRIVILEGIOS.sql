USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PRIVILEGIOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABA_PRIVILEGIOS]( @Tipo            CHAR(1)  ,
                                  @Tipo_Privilegio CHAR(1)  ,
                                  @Usuario         CHAR(15) ,
                                  @Entidad         CHAR(3)  ,
                                  @Opcion          CHAR(50) ,
                                  @Habilitado      CHAR(1)  )
AS
BEGIN
IF @Tipo = 'E'
BEGIN 
   
   DELETE GEN_PRIVILEGIOS WHERE usuario         = @Usuario 
                            AND tipo_privilegio = @Tipo_Privilegio
                            AND entidad         = @Entidad
   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA BORRANDO PRIVILEGIOS DE USUARIO.'
      RETURN 1
   END
END
IF @Tipo = 'G'
BEGIN
   INSERT GEN_PRIVILEGIOS( tipo_privilegio,
                           usuario,
                           entidad,
                           opcion ,
                           habilitado )
                   VALUES( @Tipo_Privilegio,
                           @Usuario,
                           @Entidad,
                           @Opcion ,
                           @Habilitado )
   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA AGREGANDO PRIVILEGIOS DE USUARIO.'
      RETURN 1
   END
END
RETURN 0
END

GO
