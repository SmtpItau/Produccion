USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_ASIG_SETTLEMENT]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_ASIG_SETTLEMENT]
as
begin
create table #SETTLEMENT( rut_cliente   numeric(10) null default 0 ,
                          codigo_rut    numeric(5)  null default 0 ,
                          grupo         char(30)    null default '',
                          cliente       char(30)    null default '',
                          riesgo        char(10)    null default '',
                          dia0          float       null default 0 ,
                          dia1          float       null default 0 ,
                          dia2          float       null default 0 ,
                          dia3          float       null default 0 ,
                          dia4_10       float       null default 0 ,
     producto char(10)    null default '')
insert #SETTLEMENT( rut_cliente,
                    codigo_rut,
                    grupo,
                    cliente,
                    riesgo,
                    dia0,
                    dia1,
                    dia2,
                    dia3,
                    dia4_10,
                    producto)
             select rut,
                    codigo,
                    isnull(VIEW_CLIENTE.clnombre,''),
                    isnull(VIEW_CLIENTE.clnombre,''),
                    rtrim(isnull(VIEW_CLIENTE.clcrf,''))+ '/' +rtrim(isnull(VIEW_CLIENTE.clerf,'')),
                    (monto_asignado/1000.0),
                    (monto_asignado/1000.0),
                    (monto_asignado/1000.0),
                    (monto_asignado/1000.0),
                    (monto_asignado/1000.0),
                     case productos when 'BCC' then 'FX SPOT'
        when 'BTR' then 'SECURITIES' end
               from MD_SETTLEMENT,
                    VIEW_CLIENTE  VIEW_CLIENTE
              where monto_asignado > 0
                and rut    = VIEW_CLIENTE.clrut
                and codigo = VIEW_CLIENTE.clcodigo
update #SETTLEMENT set grupo = VIEW_CLIENTE.clnombre
  from VIEW_CLIENTE_RELACIONADO,
       VIEW_CLIENTE  
 where VIEW_CLIENTE_relacionado.clrut_hijo     = rut_cliente
   and VIEW_CLIENTE_relacionado.clcodigo_hijo  = codigo_rut
   and VIEW_CLIENTE_relacionado.clrut_padre    = cliente.clrut
   and VIEW_CLIENTE_relacionado.clcodigo_padre = cliente.clcodigo
select ltrim(str(rut_cliente))+'/'+ltrim(str(codigo_rut)),
       grupo,
       cliente,
       riesgo,
       dia0,
       dia1,
       dia2,
       dia3,
       dia4_10,
       producto
  from #SETTLEMENT
 order by grupo,
          cliente
end   /* fin procedimiento */
--sp_inf_asig_settlement
--select * from md_settlement


GO
