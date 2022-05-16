USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEECI]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEECI]
                           (@cod_pai numeric(3),
                           @cod_com numeric(3))
                  
as
begin
    select cod_ciu, nom_ciu 
      from VIEW_CIUDAD_COMUNA 
     where cod_pai = @cod_pai 
       and cod_com = @cod_com
    return
end


GO
