USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_PRIVILEGIOS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_PRIVILEGIOS]
            (   @tipo_privilegio char(1)  ,
                @entidad         char(3)  ,
                @usuario         char(15) 
            )
AS
BEGIN
   SELECT opcion,
       habilitado        
   FROM VIEW_GEN_PRIVILEGIOS 
   WHERE tipo_privilegio = @tipo_privilegio 
   and usuario         = @usuario
   and entidad         = @entidad
END

GO
