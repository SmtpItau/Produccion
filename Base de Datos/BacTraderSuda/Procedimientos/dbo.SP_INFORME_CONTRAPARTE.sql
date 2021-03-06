USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CONTRAPARTE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_CONTRAPARTE]( @tipo  char(1) )
as
begin
set nocount on
declare @cont         integer
declare @totreg       integer
declare @rutcliente   numeric(10)
declare @codigo       numeric(05)
declare @tipolimite   char(20)
declare @plazo        numeric(05)
create table #CONTRAPARTE( producto      char(10)    null default '',
                           rut_cliente   numeric(10) null default 0 ,
                           codigo_rut    numeric(5)  null default 0 ,
                           grupo         char(40)    null default '',
                           cliente       char(40)    null default '',
                           riesgo        char(10)    null default '',
                           tipo_linea    char(20)    null default '',
                           autorizado    float       null default 0 ,
                           usado         float       null default 0 ,
                           disponible    float       null default 0 ,
                           porc_usado    float       null default 0 ,
                           porc_disp     float       null default 0 ,
                           plazo         numeric(5)  null default 0 )
insert #CONTRAPARTE( producto   ,
                     rut_cliente  ,
                     codigo_rut   ,
                     grupo   ,
                     cliente   ,
                     riesgo   ,
                     tipo_linea   ,
                     autorizado   ,
                     usado   ,
                     disponible   ,
                     porc_usado   ,
                     porc_disp    ,
                     plazo                      )
              select (case productos when 'BFW' then 'FX FORWARD' else 'SECURITIES' end)  ,
                     rut          ,
                     codigo          ,
                     isnull( VIEW_CLIENTE.clnombre,'')        ,  -- REQ. 7619 Se agrega vista cliente, ya que sp no funcionaba
                     isnull( VIEW_CLIENTE.clnombre,'')        ,
                     rtrim(isnull( VIEW_CLIENTE.clcrf,''))+ '/' +rtrim(isnull(VIEW_CLIENTE.clerf,''))   ,
                     tipo_limite         ,
                     case when monto_asignado <> 0 then (monto_asignado/1000.0) else 0 end ,
                     case when monto_ocupado  <> 0 then (monto_ocupado/1000.0) else 0 end ,
                     case when monto_asignado <> 0 then (monto_asignado/1000.0)-(monto_ocupado/1000.0) else 0-(monto_ocupado/1000.0) end,
               case when monto_asignado <> 0 then (round(monto_ocupado/1000.0,0) * 100) / round(monto_asignado/1000.0,0) else 0 end,
                     case when monto_asignado <> 0 then ((round(monto_asignado/1000.0,0) - round(monto_ocupado/1000.0,0)) * 100) / round(monto_asignado/1000.0,0) else 0 end,
                     plazo_fin
                from MD_PFE_CCE,
                     VIEW_CLIENTE  
               where ((@tipo = 'A' and monto_asignado > 0) or (@tipo = 'U' and monto_ocupado > 0.0))
   and rut    = VIEW_CLIENTE.clrut
                 and codigo = VIEW_CLIENTE.clcodigo
/*
update #CONTRAPARTE set grupo = VIEW_CLIENTE.clnombre
from  VIEW_CLIENTE_relacion,
        VIEW_CLIENTE
 where VIEW_CLIENTE_relacion.clrut_hijo     = rut_cliente
   and VIEW_CLIENTE_relacion.clcodigo_hijo  = codigo_rut
   and VIEW_CLIENTE_relacion.clrut_padre    = VIEW_CLIENTE.clrut
   and VIEW_CLIENTE_relacion.clcodigo_padre = VIEW_CLIENTE.clcodigo
*/
if @tipo = 'u'
begin
   select @cont = 1
   select @totreg = count(*) from #CONTRAPARTE
   while @cont <= @totreg
   begin
      set rowcount @cont
      select @rutcliente = rut_cliente,
             @codigo     = codigo_rut,
             @tipolimite = tipo_linea,
             @plazo      = plazo
        from #CONTRAPARTE
      set rowcount 0
      select @cont = @cont + 1
      if not exists(select * from #CONTRAPARTE where rut_cliente = @rutcliente
                                                 and codigo_rut  = @codigo
                                                 and tipo_linea <> @tipolimite 
                                                 and plazo      = @plazo )
         insert #CONTRAPARTE( producto      ,
                              rut_cliente   ,
                              codigo_rut    ,
                              grupo         ,
                              cliente       ,
                              riesgo        ,
                              tipo_linea    ,
                              autorizado    ,
                              usado         ,
                              disponible    ,
                              porc_usado    ,
                              porc_disp     ,
                              plazo         )
                       select (case productos when 'BFW' then 'FX FORWARD' else 'SECURITIES' end)  ,
                              rut          ,
                              codigo          ,
                              isnull(VIEW_CLIENTE.clnombre,'')        ,
                              isnull(VIEW_CLIENTE.clnombre,'')        ,
                              rtrim(isnull(VIEW_CLIENTE.clcrf,''))+ '/' +rtrim(isnull(VIEW_CLIENTE.clerf,''))   ,
                              tipo_limite         ,
                case when monto_asignado <> 0 then (monto_asignado/1000.0)else 0 end ,
                              case when monto_ocupado  <> 0 then (monto_ocupado/1000.0)else 0 end , 
                              case when monto_asignado <> 0 then (monto_asignado/1000.0)-(monto_ocupado/1000.0)else 0-(monto_ocupado/1000.0) end,
                              case when monto_asignado <> 0 then (round(monto_ocupado/1000.0,0) * 100) / round(monto_asignado/1000.0,0) else 0 end,
                              case when monto_asignado <> 0 then ((round(monto_asignado/1000.0,0) - round(monto_ocupado/1000.0,0)) * 100) / round(monto_asignado/1000.0,0) else 0 end,
                              plazo_fin
                         from MD_PFE_CCE,
                              VIEW_CLIENTE  VIEW_CLIENTE
                        where MD_PFE_CCE.rut          = VIEW_CLIENTE.clrut
                          and MD_PFE_CCE.codigo       = VIEW_CLIENTE.clcodigo
                          and MD_PFE_CCE.tipo_limite <> @tipolimite
                          and MD_PFE_CCE.rut          = @rutcliente
                          and MD_PFE_CCE.codigo       = @codigo
                          and MD_PFE_CCE.plazo_fin    = @plazo
   end
end
/* busca los limites asignados por emisor -------------------------------------------- */
insert #CONTRAPARTE( producto  ,
                     rut_cliente ,
                     codigo_rut  ,
                     grupo  ,
                     cliente  ,
                     riesgo  ,
                     tipo_linea  ,
                     autorizado  ,
                     usado  ,
                     disponible  ,
                     porc_usado  ,
                     porc_disp   ,
                     plazo              )
              select (case instrumento 
                      when 'MM' then 'M. MARKET'
                      when 'FI' then 'F. INCOME'
                      else 'S. TERM' 
                     end)         ,
                     rut         ,
                     1          ,
                     isnull(VIEW_CLIENTE.clnombre,'')       ,
                     isnull(VIEW_CLIENTE.clnombre,'')       ,
                     rtrim(isnull(VIEW_CLIENTE.clcrf,''))+ '/' +rtrim(isnull(VIEW_CLIENTE.clerf,''))  ,
                     ''          ,
                     case when monto_asignado <> 0 then (monto_asignado/1000.0) else 0 end ,
                     case when monto_ocupado  <> 0 then (monto_ocupado/1000.0) else 0 end ,
                     case when monto_asignado <> 0 then (monto_asignado/1000.0)-(monto_ocupado/1000.0) else 0-(monto_ocupado/1000.0) end,
                     case when monto_asignado <> 0 then (round(monto_ocupado/1000.0,0) * 100.0) / round(monto_asignado/1000.0,0) else 0 end,
                     case when monto_asignado <> 0 then ((round(monto_asignado/1000.0,0) - round(monto_ocupado/1000.0,0)) * 100) / round(monto_asignado/1000.0,0) else 0 end,
                     plazo_fin
                from MD_EMISOR_INST_PLAZO,
                     VIEW_CLIENTE  VIEW_CLIENTE
               where ((@tipo = 'A' and monto_asignado > 0) or (@tipo = 'U' and monto_ocupado > 0.0))
                 and VIEW_CLIENTE.clrut    = rut
   and VIEW_CLIENTE.clcodigo = 1 
   and ( rut <> 97029000 and  instrumento  <> 'FI' ) 
update #CONTRAPARTE set grupo = VIEW_CLIENTE_relacionado
from  VIEW_CLIENTE_RELACIONADO,
        VIEW_CLIENTE  
 where VIEW_CLIENTE_relacionado.clrut_hijo     = rut_cliente
   and VIEW_CLIENTE_relacionado.clcodigo_hijo  = codigo_rut
   and VIEW_CLIENTE_relacionado.clrut_padre    = VIEW_CLIENTE.clrut
   and VIEW_CLIENTE_relacionado.clcodigo_padre = VIEW_CLIENTE.clcodigo
select producto       ,
       ltrim(str(rut_cliente))+'/'+ltrim(str(codigo_rut)) ,
       grupo       ,
       cliente       ,
       riesgo       ,
       tipo_linea      ,
       'autorizado' = isnull(autorizado,0.0)   ,
       'usado' = isnull(usado,0.0)    ,
       'disponible' = isnull(disponible,0.0)   ,
       'porc_usado' = isnull(porc_usado,0.0)    ,
       'porc_disp' = isnull(porc_disp,0.0)   ,
       plazo
  from #CONTRAPARTE
 order by grupo,
          cliente,
          producto,
   plazo,
   tipo_linea
end /* fin procedimiento */
-- sp_informe_contraparte 'u'
-- select * from VIEW_CLIENTE
-- select * from MD_PFE_CCE order by rut
-- select * from md_emisor_inst_plazo


GO
