USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_PFE_CCE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_PFE_CCE]
as
begin
set nocount on
 create table 
 #TEMP1(
   rut numeric(10,0) ,
   cod numeric(10,0) ,
   prod   char(10) ,
   lim char(03) )
   
 insert into  
 #TEMP1
 select
  distinct 
  a.rut    ,
  a.codigo   ,
  a.PRODUCTOs   ,
  a.tipo_limite   
 from 
  MD_PFE_CCE  a
 select 
  a.rut    ,
  a.cod    ,
  a.prod    ,
  a.lim    ,
  isnull(c.clnombre,'')  ,
  case a.prod when 'BFW' then 'FORWARD' when 'BTR' then 'SECURITIES' else ' ' end
 from 
  #TEMP1   a,
  VIEW_CLIENTE   c,
                VIEW_SISTEMA_CNT     s
 where 
  c.clrut     = a.rut
 and c.clcodigo  = a.cod
 and  a.prod      = s.id_sistema
 order by
  c.clnombre ,
  a.prod
   
      
end
/*
select  * from MD_ART84
select * from MD_PLAZO_SETTLEMENT
select * from MD_SETTLEMENT
*/
                                                                                                                     
                                                                                                                                       

GO
