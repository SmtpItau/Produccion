USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIMEPAPELETASOPE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_IMPRIMEPAPELETASOPE] --1254
           ( @numope numeric(7) )
as                            
begin
if exists ( select *  from    MEMO                  ,
             VIEW_CLIENTE A ,
             VIEW_FORMA_DE_PAGO B  ,
             VIEW_FORMA_DE_PAGO C  ,
             VIEW_MONEDA D  ,
             VIEW_MONEDA O  ,
      MEAC E
       
   where monumope = @numope      
     and morutcli = a.clrut    
     and mocodcli = a.clcodigo 
     and morecib  = c.codigo   
     and moentre  = b.codigo   
     and mocodmon = substring(d.mnnemo,1,3) 
     and mocodcnv = substring(o.mnnemo,1,3) 
     
  
        )
begin
   select 'rutemisor'         = e.acrut                        ,
          'codigoemisor'      = e.accodigo                     ,
          'digchkemisor'      = e.acdv                         ,
          'nombreemisor'      = e.acnombre                     ,
          'rutcliente'        = morutcli                       ,
          'digchkcliente'     = a.cldv                         ,
          'nombrecliente'     = a.clnombre                     ,
          'direccioncliente'  = a.cldirecc                     ,
   'telefonocliente'   = a.clfono         ,
   'faxcliente'       = a.clfax         ,
   'fecharecibe'       = convert(char(10),movaluta2,110),
          'fechaentrega'      = convert(char(10),movaluta1,110),
          'montoopera'        = momonmo                        ,
          'montousd'          = moussme                        ,
          'montoclp'          = momonpe                        ,
          'tipocamcie'        = moticam                        ,
          'tipocamtra'        = motctra                        ,
          'paricie'           = moparme                        ,
          'paritra'           = mopartr                        ,
          'parifin'           = moparfi                        ,
          'modoimpreso'       = moimpreso                      ,
          'moneda'            = mocodmon                       ,
          'monedaopera'       = d.mnglosa                      ,
          'monedaconve'       = mocodcnv                       ,
          'monedaconversion'  = o.mnglosa                      ,
          'noopera'           = monumope                       ,
          'tipoopera'         = motipope                       ,
          'entregamos'        = b.glosa                        ,
          'recibimos'         = c.glosa                        ,
          'operador'          = mooper                         ,
          'tipocamtrf'        = motcfin                        ,
          'retiro'            = morecib                        ,
          'tipomercado'       = convert(char(40),motipmer)     ,
          'estado'            = moestatus                      ,
          'exceso_settle'     = space(50)         , 
   'mofech'       = convert(char(12),mofech,103)   ,
   'hora'       = convert(char(08),getdate(),108),
   'areaproducto'      = codigo_area
 
     into #TEMPAPE
     from MEMO                     ,
          VIEW_CLIENTE A,
          VIEW_FORMA_DE_PAGO B,
          VIEW_FORMA_DE_PAGO C,
          VIEW_MONEDA D,
          VIEW_MONEDA O,
   MEAC E
    where monumope = @numope      
     and morutcli = a.clrut    
     and mocodcli = a.clcodigo 
     and morecib  = c.codigo   
     and moentre  = b.codigo   
     and mocodmon = substring(d.mnnemo,1,3) 
     and mocodcnv = substring(o.mnnemo,1,3) 
    
         
   ---------------------<< define tipo de mercado
   update #TEMPAPE
      set tipomercado  = glosa
     from VIEW_AYUDA_PLANILLA
    where noopera = @numope 
      and codigo_tabla = 15 and codigo_caracter = substring(rtrim(tipomercado),1,4)
   select * from #TEMPAPE
end 
else
begin
   select  'rutemisor'        = e.acrut                        
          ,'codigoemisor'     = e.accodigo                     
          ,'digchkemisor'     = e.acdv         
          ,'nombreemisor'     = e.acnombre                     
          ,'rutcliente'       = 0                       
          ,'digchkcliente'    = 0                         
          ,'nombrecliente'    = ''                     
          ,'direccioncliente' = ''                     
          ,'telefonocliente'  = 0
          ,'faxcliente'       = ''
          ,'fecharecibe'      = ''    
          ,'fechaentrega'     = ''    
          ,'montoopera'       = 0                        
          ,'montousd'         = 0                        
          ,'montoclp'         = 0                        
          ,'tipocamcie'       = 0                        
          ,'tipocamtra'       = 0                        
          ,'paricie'          = 0                        
          ,'paritra'          = 0                        
          ,'parifin'          = 0                        
          ,'modoimpreso'      = ''                      
          ,'moneda'           = ''                       
          ,'monedaopera'      = ''                      
          ,'monedaconve'      = ''                      
          ,'monedaconversion' = ''                      
          ,'noopera'          = 0                       
          ,'tipoopera'        = ''                       
          ,'entregamos'       = ''                       
          ,'recibimos'        = ''                       
          ,'operador'         = ''                       
          ,'tipocamtrf'       = 0                        
          ,'retiro'           = 0                        
          ,'tipomercado'      = ''
          ,'estado'           = ''                            
          ,'exceso_settle'    = ''
          ,'mofech'           = convert(char(12),acfecpro,103)
          ,'hora  '           = convert(char(08),getdate(),108)
     from 
          MEAC E
end
end

GO
