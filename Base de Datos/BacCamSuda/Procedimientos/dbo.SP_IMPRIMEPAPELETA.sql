USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIMEPAPELETA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPRIMEPAPELETA]
 ( @NumOpe NUMERIC(7) )
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
           @hora        char(8)
   execute Sp_Base_Del_Informe
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
           @hora        OUTPUT
 SET NOCOUNT ON


/*req.7619 cass  06-01-2011
if exists (select * from memo                     ,
             view_cliente a,
             view_forma_de_pago b,
             view_forma_de_pago c,
             view_moneda d,
             view_moneda o,
             meac e
                   Where monumope = @NumOpe        AND
             morutcli = a.clrut        AND
             mocodcli = a.clcodigo     AND
             morecib *= c.codigo       AND
             moentre *= b.codigo       AND
             mocodmon = SUBSTRING(d.MnNemo,1,3)  AND
          mocodcnv = SUBSTRING(o.MnNemo,1,3) 
*/


 if exists (SELECT * FROM  memo LEFT OUTER JOIN view_forma_de_pago b ON morecib = b.codigo 
			 LEFT OUTER JOIN view_forma_de_pago c ON moentre = c.codigo,
             view_cliente a,
             view_moneda d,
             view_moneda o,
             meac e
             Where monumope = 461979				AND
             morutcli = a.clrut						AND
             mocodcli = a.clcodigo					AND
             mocodmon = SUBSTRING(d.MnNemo,1,3)		AND
          mocodcnv = SUBSTRING(o.MnNemo,1,3) 
   )
 begin
    SELECT 'RutEmisor'    = e.acrut                        ,
           'CodigoEmisor' = e.accodigo                     ,
           'DigChkEmisor' = e.acdv                         ,
           'NombreEmisor' = e.acnombre                     ,
           'RutCliente'   = morutcli                       ,
           'DigChkCliente'= a.cldv                         ,
           'NombreCliente'= a.clnombre                     ,
           'DireccionCliente' = a.cldirecc                 ,
           'fechaRecibe'  = CONVERT(CHAR(10),movaluta2,110),
           'fechaEntrega' = CONVERT(CHAR(10),movaluta1,110),
           'MontoOpera'   = momonmo                        ,
           'MontoUSD'     = moussme                        ,
           'MontoCLP'     = momonpe                        ,
           'TipoCamCie'   = moticam                        ,
           'TipoCamTra'   = motctra                        ,
           'PariCie'      = moparme                        ,
           'PariTra'      = mopartr                        ,
           'PariFin'      = moparfi                        ,
           'Modoimpreso'  = moimpreso                      ,
           'Moneda'       = mocodmon                       ,
           'MonedaOpera'  = d.mnglosa                      ,
           'MonedaConve'  = mocodcnv                       ,
           'MonedaConversion' = o.mnglosa                  ,
           'NoOpera'      = monumope                       ,
           'TipoOpera'    = motipope                       ,
           'Entregamos'   = b.glosa                        ,
           'Recibimos'    = c.glosa                        ,
           'Operador'     = mooper                         ,
           'TipoCamTrF'   = motcfin                        ,
           'Retiro'       = morecib                        ,
           'TipoMercado'  = CONVERT(CHAR(40),motipmer)     ,
           'Estado'       = case moestatus when 'A' then 'ANULACION' ELSE ' ' END   ,
           'Exceso_Settle'= SPACE(50)        , 
	   'mofech'       = convert(char(12),mofech,103)       ,
           'hora  '       = convert(char(08),getdate(),108),
           'acfecproc'    = @acfecproc,
           'acfecprox'    = @acfecprox,
           'uf_hoy'       = @uf_hoy,
           'uf_man'       = @uf_man,
           'ivp_hoy'      = @ivp_hoy,
           'ivp_man'      = @ivp_man,
           'do_hoy'       = @do_hoy,
           'do_man'       = @do_man,
           'da_hoy'       = @da_hoy,
           'da_man'       = @da_man,
           'pmnomprop'    = @acnomprop,
           'rut_empresa'  = @rut_empresa,
           'fecha_SERV'   = CONVERT( CHAR(10) , GETDATE(), 103)   
     
      INTO #tempape
      FROM memo LEFT OUTER JOIN view_forma_de_pago b ON morecib = b.codigo 
			 LEFT OUTER JOIN view_forma_de_pago c ON moentre = c.codigo,
           view_cliente a,
           view_moneda d,
           view_moneda o,
           meac e
      WHERE monumope = @NumOpe      AND
           morutcli = a.clrut      AND
           mocodcli = a.clcodigo   AND
           mocodmon = SUBSTRING(d.MnNemo,1,3) AND
           mocodcnv = SUBSTRING(o.MnNemo,1,3) 

/* REQ.7619 CASS 
      FROM memo                     ,
           view_cliente a,
           view_forma_de_pago b,
           view_forma_de_pago c,
           view_moneda d,
           view_moneda o,
           meac e
     WHERE monumope = @NumOpe      AND
           morutcli = a.clrut      AND
           mocodcli = a.clcodigo   AND
           morecib *= c.codigo     AND
           moentre *= b.codigo     AND
           mocodmon = SUBSTRING(d.MnNemo,1,3) AND
        mocodcnv = SUBSTRING(o.MnNemo,1,3) 
 */  
   ---------------------<< Define Tipo de Mercado
    UPDATE #tempape
       SET TipoMercado  = glosa
      FROM bacparamsuda..ayuda_planilla
     WHERE NoOpera = @NumOpe 
       AND codigo_tabla = 15 AND codigo_caracter = SUBSTRING(RTRIM(TipoMercado),1,4)
    SELECT * FROM #tempape
 end
 else
 SELECT   'RutEmisor'        = 0                       ,
          'CodigoEmisor'     = 0                       ,
           'DigChkEmisor'     = ''          ,
           'NombreEmisor'     = ''                             ,
           'RutCliente'       = 0                       ,
           'DigChkCliente'    = ''                             ,
           'NombreCliente'    = ''                             ,
           'DireccionCliente' = ''                             ,
           'fechaRecibe'      = ''                             ,
           'fechaEntrega'     = ''                             ,
           'MontoOpera'       = 0                       ,
           'MontoUSD'         = 0                       ,
           'MontoCLP'         = 0                       ,
           'TipoCamCie'       = 0                       ,
           'TipoCamTra'       = 0                       ,
           'PariCie'          = 0                       ,
           'PariTra'          = 0                       ,
           'PariFin'          = 0                       ,
           'Modoimpreso'      = ''                             ,
           'Moneda'           = ''                             ,
           'MonedaOpera'      = ''                             ,
           'MonedaConve'      = ''                             ,
           'MonedaConversion' = ''                             ,
           'NoOpera'          = 0                       ,
           'TipoOpera'        = ''                             ,
           'Entregamos'       = ''                             ,
           'Recibimos'        = ''                             ,
           'Operador'         = ''                             ,
           'TipoCamTrF'       = 0                       ,
           'Retiro'           = 0                       ,
           'TipoMercado'      = ''                             ,
            'Estado'           = ''  ,
            'Exceso_Settle'    = ''                             ,
     'mofech'     = ''                             ,
     'hora  '     = convert(char(08),getdate(),108),
   'acfecproc' =@acfecproc,
     'acfecprox' =@acfecprox,
     'uf_hoy' =@uf_hoy,
     'uf_man' =@uf_man,
     'ivp_hoy' =@ivp_hoy,
     'ivp_man' =@ivp_man,
     'do_hoy' =@do_hoy,
     'do_man' =@do_man,
     'da_hoy' =@da_hoy,
     'da_man' =@da_man,
     'pmnomprop' =@acnomprop,
     'rut_empresa' =@rut_empresa,
   'fecha_SERV' = CONVERT( CHAR(10) , GETDATE(), 103) 
  SET NOCOUNT OFF
END

GO
