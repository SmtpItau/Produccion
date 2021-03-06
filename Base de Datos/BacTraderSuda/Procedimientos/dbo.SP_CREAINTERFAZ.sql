USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREAINTERFAZ]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CREAINTERFAZ]
            ( @parinter char(04), @parsistema  char(03) )
as
begin
 if @parinter ='pv01'
  select 
   header   ,
   san   ,
   emer_mark  ,
   latamericam  ,
   trading  ,
   ano         ,
   ir
  from  
   BAC_INTER_PV01
  where   
   id_sistema=@parsistema
  order by
   emer_mark  ,
   ano        
 else
  select 
   informat  ,
   method  ,
   lon_sho  ,
   asset_al  ,
   risk_cla       ,
   product     ,
   bucket   ,
   currency  ,
   llave   ,
   pv01
  from 
   BAC_INTER_PV02
  order by
   informat ,
   product  , 
   bucket
end


GO
