USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCOMUNA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERCOMUNA]
                               (@cod_pai      numeric(6),
                                @cod_ciu      numeric(6),
                                @cod_com      numeric(6) )
as
begin   
 select  cod_com,
         nom_ciu
                
 
        from
         VIEW_CIUDAD_COMUNA      
 where
         cod_pai = @cod_pai
        and     cod_ciu = @cod_ciu
        and     cod_com = @cod_com
      
 order by nom_ciu
   
   
      
         return
end  


GO
