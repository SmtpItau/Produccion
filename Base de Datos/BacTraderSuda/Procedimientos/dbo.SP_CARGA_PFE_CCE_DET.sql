USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_PFE_CCE_DET]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGA_PFE_CCE_DET]
/*
  @drut     numeric(10) ,
  @icodigo  numeric(5)  ,
  @tipo_limite char(03) ,
  @PRODUCTO char(10) ) */
as
begin
 select 
  'dias1'  =  a.plazo_ini   ,
  'dias2'  =  a.plazo_fin   ,
  'mtootorgado' = a.monto_asignado  ,
  'montoocup' = a.monto_ocupado          ,
  'rut'  = a.rut    ,
  'codigo' = a.codigo   ,
  'codprod' = a.PRODUCTOs   ,
  'limites' = a.tipo_limite   
 from 
  MD_PFE_CCE  a
 order by
  a.PRODUCTOs
   
      
end
/*
select  * from MD_ART84
select * from MD_PLAZO_SETTLEMENT
select * from MD_PFE_CCE
execute sp_carga_pfe_cce_det 97032000,1,'cce','forward'
*/
                                                                                                                     
                                                                                                                                       

GO
