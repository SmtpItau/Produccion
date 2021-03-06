USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_INFORME_TESORERIA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GENERA_INFORME_TESORERIA] ( @fecha_pago     datetime    ,
               @cerrada        char  (1)   
      
     )
                  
as
begin
        create table #PASSX( glosa_operacion char   (40) default ' ' ,
        operacion         numeric(10) default 0   ,
                clnombre         char   (50) default ' ' ,
        monto_operacion float                 ,
        glosa  char   (30) default ' ' ,
        moneda  char   ( 4) default ' ' ,
               fecha_operacion datetime                ,        
        cerrada            char   (1)  default ' ' ,   
        tipo_operacion     char   ( 4) default ' ' ,
        sistema            char   ( 3) default ' ' ,  
               correlativo        numeric( 5) default 0)
    
 insert #PASSX (glosa_operacion ,
                      operacion         ,
               clnombre         ,
        monto_operacion ,
        glosa  ,
        moneda  ,
               fecha_operacion ,      
        cerrada       ,
        tipo_operacion    ,
        sistema     ,
        correlativo )
 select  e.glosa_operacion ,
  b.operacion         ,
  a.clnombre         ,
  b.monto_operacion ,
  c.glosa          ,
  b.moneda  ,
  b.fecha_operacion ,
  b.cerrada               ,
                b.tipo_operacion        ,
  b.id_sistema         ,
  b.correlativo
 from    VIEW_CLIENTE  a, GEN_OPERACIONES b, VIEW_FORMA_DE_PAGO c,  VIEW_MOVIMIENTO_CNT e 
       where  
         b.forma_pago      =  ltrim(str(codigo,4))          and     
  b.rut_cliente     =  a.clrut                       and
                b.codigo_rut      =  a.clcodigo                    and
  b.tipo_operacion  =  e.tipo_operacion              and
                @fecha_pago       =  b.fecha_pago                  and
                cerrada           =  b.cerrada
if @cerrada = 's'
  select     #PASSX.glosa_operacion  ,
                          #PASSX.operacion    ,
                   #PASSX.clnombre    ,
            #PASSX.monto_operacion  ,
            #PASSX.glosa            ,
            #PASSX.moneda    ,
                   #PASSX.fecha_operacion  ,    
             #PASSX.cerrada          ,
             #PASSX.tipo_operacion   ,
      #PASSX.sistema    ,
      #PASSX.correlativo    ,       
      g.monto_operacion    , 
      g.numero_documento      ,         
      'tipo_canje'  = case g.tipo_canje when 'e' then 'entregamos'
                          when 'r' then 'recibimos'
                          else '--'  
                          end 
  from    #PASSX ,GEN_PAGOS_OPERACION g
  where @cerrada              =  #PASSX.cerrada                and   
   g.tipo_operacion      =  #PASSX.tipo_operacion         and
   g.operacion           =  #PASSX.operacion              and
   g.correlativo         =  #PASSX.correlativo            and
   id_sistema            =  #PASSX.sistema                and
   g.estado              =  'a'
else
 select * from #PASSX where @cerrada = #PASSX.cerrada
end
--select * from gen_pagos_operacion
--select * from gen_operaciones

GO
