USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_PERFILES_VARIABLES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCAR_PERFILES_VARIABLES]
                                  (@filas   numeric(8))
as
begin
    select * from VIEW_CNT_PASO where fila = @filas
end


GO
