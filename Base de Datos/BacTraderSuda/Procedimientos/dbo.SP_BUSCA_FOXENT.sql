USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_FOXENT]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_FOXENT](@xmenu char(40),@xentidad char(03))
as
begin
  
 select entidadfox from GEN_MENU where nombre_opcion = @xmenu and entidad = @xentidad
end


GO
