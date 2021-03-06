USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_PRIVILEGIOS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
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
