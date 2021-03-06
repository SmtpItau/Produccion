USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_PRIVILEGIOS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[SP_BUSCA_PRIVILEGIOS]
 (       @tipo_privilegio char(1)  ,
                @entidad         char(3)  ,
                @usuario         char(15)      )
as
begin
select opcion,
       habilitado        
  from VIEW_GEN_PRIVILEGIOS
 where tipo_privilegio = @tipo_privilegio 
   and usuario         = @usuario
   and entidad         = @entidad
end   /* fin procedimiento */



GO
