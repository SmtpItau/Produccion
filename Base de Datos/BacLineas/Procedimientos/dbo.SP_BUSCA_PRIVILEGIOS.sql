USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_PRIVILEGIOS]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_PRIVILEGIOS]
               (
                @tipo_privilegio CHAR(1)
               ,@entidad         CHAR(3)
               ,@usuario         CHAR(15)
               )
AS
BEGIN
 SET NOCOUNT ON 

   IF @tipo_privilegio = 'T' AND @entidad = 'SPT'
      SET @entidad = 'SCF'

   SELECT opcion
   ,      habilitado        
     FROM VIEW_GEN_PRIVILEGIOS 
    WHERE tipo_privilegio = @tipo_privilegio 
      AND usuario         = @usuario
      AND entidad         = @entidad

SET NOCOUNT OFF
END
GO
