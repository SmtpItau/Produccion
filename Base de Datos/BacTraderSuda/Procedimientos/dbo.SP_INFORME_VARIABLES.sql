USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_VARIABLES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_VARIABLES](@id char(3))
AS
BEGIN
   set nocount on
    select a.folio_perfil,
    a.correlativo_perfil,
          a.codigo_cuenta     ,
         'cuenta' = isnull(b.descripcion,'') ,
  'valor' = convert(varchar(30),a.valor_dato_campo),
         'descrip' = convert(varchar(70),''),
  c.codigo_campo_variable
  into #variables 
  from --  REQ. 7619
       view_plan_de_cuenta b  RIGHT OUTER JOIN view_perfil_variable_cnt a ON b.cuenta = a.codigo_cuenta ,
       view_perfil_detalle_cnt c ,
  --  REQ. 7619
  -- view_plan_de_cuenta b,
     view_perfil_cnt d 
         where  a.folio_perfil = c.folio_perfil
       and     d.folio_perfil = a.folio_perfil
      and     a.correlativo_perfil = c.correlativo_perfil  
     --  REQ. 7619
     --   and      b.cuenta =* a.codigo_cuenta
             and  d.id_sistema = @id
     order by a.folio_perfil ,a.correlativo_perfil
     update #variables set descrip = isnull((select tbglosa  from view_tabla_general_detalle
    where tbcodigo1= ltrim(valor) 
  and RTRIM(LTRIM(CONVERT(CHAR(5),tbcateg))) = RTRIM(LTRIM((select distinct right(rtrim(campo_tabla),4) from view_campo_cnt 
  where codigo_campo = codigo_campo_variable 
  and codigo_campo_variable  <> 42 and id_sistema = @id )))),'') 
      update #variables set descrip = isnull((select glosa  from view_forma_de_pago where codigo= ltrim(valor) ),'') 
    where codigo_campo_variable IN(42,900,506,507)
         
    select folio_perfil,
    correlativo_perfil,
          codigo_cuenta     ,
          cuenta,
   valor,
          descrip
   from #variables 
   order by folio_perfil ,correlativo_perfil   
   set nocount off
end



GO
