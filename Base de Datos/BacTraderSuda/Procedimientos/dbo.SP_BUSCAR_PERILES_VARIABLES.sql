USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_PERILES_VARIABLES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCAR_PERILES_VARIABLES]
                                            (@folio_perfil    numeric(10),
                                             @correlativo     numeric(10),
                                             @perfil          numeric(10))
as
begin
set nocount on
    select valor,cuenta,descripcion ,*
      from VIEW_CNT_PASO
     where perfil = @perfil
set nocount off
end


GO
