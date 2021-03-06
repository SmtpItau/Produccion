USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIMENUEVA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPRIMENUEVA] --412
 ( @numope NUMERIC(7) )
AS                            
BEGIN
  DECLARE  @acfecproc   char(10),
           @acfecprox   char(10),
           @uf_hoy      float,
           @uf_man      float,
           @ivp_hoy     float,
           @ivp_man     float,
           @do_hoy      float,
           @do_man      float,
           @da_hoy      float,
           @da_man      float,
           @acnomprop   char(40),
           @rut_empresa char(12),
           @hora        char(8),
    @para_que char(8)
   EXECUTE Sp_Base_Del_Informe
           @acfecproc   OUTPUT,
           @acfecprox   OUTPUT,
           @uf_hoy      OUTPUT,
           @uf_man      OUTPUT,
           @ivp_hoy     OUTPUT,
           @ivp_man     OUTPUT,
           @do_hoy      OUTPUT,
           @do_man      OUTPUT,
           @da_hoy      OUTPUT,
           @da_man      OUTPUT,
           @acnomprop   OUTPUT,
           @rut_empresa OUTPUT,
           @hora        OUTPUT,
    @para_que OUTPUT
IF EXISTS ( SELECT *  FROM    MEMO                  ,
             VIEW_CLIENTE A ,
             VIEW_FORMA_DE_PAGO B  ,
             VIEW_FORMA_DE_PAGO C  ,
             VIEW_MONEDA D  ,
             VIEW_MONEDA O  ,
      VIEW_PLAZA  P         ,
      VIEW_CORRESPONSAL R   ,
             MEAC E
       
   WHERE monumope = @numope      
     and morutcli = a.clrut    
     and mocodcli = a.clcodigo 
     and morecib  = c.codigo   
     and moentre  = b.codigo   
     and mocodmon = substring(d.mnnemo,1,3) 
     and mocodcnv = substring(o.mnnemo,1,3) 
                   and swift_corresponsal=r.codigo_swift 
  
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
   'plazarecibimos'   =( select nombre from view_plaza p, memo where p.codigo_plaza=plaza_recibimos and monumope=@numope),
   'plazaentregamos'  =( select nombre from view_plaza p, memo where p.codigo_plaza=plaza_entregamos and monumope=@numope),
   'plaza_corresponsal'=( select nombre from view_plaza p, memo where p.codigo_plaza=plaza_corresponsal and monumope=@numope),
   'swift_corresponsal'=( select nombre from view_corresponsal c, memo where c.codigo_swift = swift_corresponsal and swift_corresponsal = codigo_swift and monumope=@numope),
   'swift_recibimos'   =( select nombre from view_corresponsal c, memo where c.codigo_swift = swift_recibimos and swift_recibimos = codigo_swift and monumope=@numope),
   'swift_entregamos'  =( select nombre from view_corresponsal c, memo where c.codigo_swift = swift_entregamos and swift_entregamos = codigo_swift and monumope=@numope),
   'ctacte_corresponsal'=( select cuenta_corriente from view_corresponsal c, memo where c.codigo_swift = swift_corresponsal and swift_corresponsal = codigo_swift and monumope=@numope),
          'fecharecibe'       = convert(char(10),movaluta2,110),
          'fechaentrega'      = convert(char(10),movaluta1,110),
          'montoopera'        = momonmo                        ,
          'montousd'          = moussme                        ,
          'montoclp'          = momonpe                        ,
          'tipocamcie'        = moticam                        ,
          'tipocamtra'        = motctra                        ,
          'paricie'           = moparme                        ,
          'paritra'           = mopartr                        ,
          'parifin'           = moparfi  ,
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
   'hora'       = convert(char(08),getdate(),108) ,
   'fecha_SERV'        = CONVERT( CHAR(10) , GETDATE(), 103),
   'acfecproc'       =@acfecproc,
   'acfecprox'        =@acfecprox,
   'uf_hoy'       =@uf_hoy,
   'uf_man'       =@uf_man,
   'ivp_hoy'       =@ivp_hoy,
   'ivp_man'       =@ivp_man,
   'do_hoy'       =@do_hoy,
   'do_man'       =@do_man,
   'da_hoy'       =@da_hoy,
   'da_man'       =@da_man,
   'pmnomprop'       =@acnomprop,
   'rut_empresa'       =@rut_empresa
 
     into #TEMPAPE
     from MEMO                     ,
          VIEW_CLIENTE A,
          VIEW_FORMA_DE_PAGO B,
          VIEW_FORMA_DE_PAGO C,
          VIEW_MONEDA D,
          VIEW_MONEDA O,
   VIEW_PLAZA  P,
   VIEW_CORRESPONSAL R,
          MEAC E
    where monumope = @numope      
     and morutcli = a.clrut    
     and mocodcli = a.clcodigo 
     and morecib  = c.codigo   
     and moentre  = b.codigo   
     and mocodmon = substring(d.mnnemo,1,3) 
     and mocodcnv = substring(o.mnnemo,1,3) 
     and swift_corresponsal=r.codigo_swift 
         
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
   ,'plazarecibimos'   = ''         
    ,'plazaentregamos'  = ''         
   ,'plaza_corresponsal'= ''
   ,'swift_corresponsal'= ''  
   ,'swift_recibido'    = ''
   ,'swift_entregado'   = ''
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
   ,'mofech'       = convert(char(12),acfecpro,103)
   ,'hora  '       = convert(char(08),getdate(),108)
     ,'fecha_SERV'       = CONVERT( CHAR(10) , GETDATE(), 103) 
   ,'acfecproc'       =@acfecproc
   ,'acfecprox'        =@acfecprox
   ,'uf_hoy'       =@uf_hoy
   ,'uf_man'       =@uf_man
   ,'ivp_hoy'       =@ivp_hoy
   ,'ivp_man'       =@ivp_man
   ,'do_hoy'       =@do_hoy
   ,'do_man'       =@do_man
   ,'da_hoy'       =@da_hoy
   ,'da_man'       =@da_man
   ,'pmnomprop'       =@acnomprop
   ,'rut_empresa'      =@rut_empresa
     from 
          MEAC E
end
end

GO
