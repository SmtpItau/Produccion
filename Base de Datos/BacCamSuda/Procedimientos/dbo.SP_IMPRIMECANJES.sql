USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPRIMECANJES]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPRIMECANJES] ( @NumOpe NUMERIC(7) )
AS                            
BEGIN
declare @entidad char(40)

select @entidad = acnomprop from VIEW_MDAC

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
             		 morecib  = c.codigo       AND
             		 moentre  = b.codigo       AND
             	 	 mocodmon = SUBSTRING(d.MnNemo,1,3)  AND
          		 mocodcnv = SUBSTRING(o.MnNemo,1,3) 
   )
 begin
    SELECT 'RutEmisor'        = e.acrut                        ,
           'CodigoEmisor'     = e.accodigo                     ,
           'DigChkEmisor'     = e.acdv                         ,
           'NombreEmisor'     = e.acnombre                     ,
           'RutCliente'       = morutcli                       ,
           'DigChkCliente'    = a.cldv                         ,
           'NombreCliente'    = a.clnombre                     ,
           'DireccionCliente' = a.cldirecc                     ,
   	   'TelefonoCliente'  = a.clfono        ,
	   'FaxCliente'     = a.clfax        ,
	   'fechaRecibecom'   = CONVERT(CHAR(10),movaluta2,110),
           'fechaEntregacom'  = CONVERT(CHAR(10),movaluta1,110),
	   'fecharecibevta'   = convert(char(10),valuta_cli_nac,110),
           'fechaentregavta'  = convert(char(10),valuta_cli_ext,110),
	   'entregamoscom'    = (select glosa from view_forma_de_pago b,memo where  monumope=@numope and forma_pago_cli_ext  = b.codigo)    ,
           'recibimoscom'     = (select glosa from view_forma_de_pago c,memo where  monumope=@numope and forma_pago_cli_ext  = c.codigo)    ,
           'entregamosvta'    = (select glosa from view_forma_de_pago h,memo where  monumope=@numope and forma_pago_cli_ext  = h.codigo)    ,
	   'recibimosvta'     = (select glosa from view_forma_de_pago i,memo where  monumope=@numope and forma_pago_cli_nac  = i.codigo)    ,
           'MontoOpera'       = momonmo                        ,
           'MontoUSDCom'      = moussme                        ,
	   'MontoUSDVta'      = mousstr                        ,
           'MontoCLP'         = momonpe                        ,
           'TipoCambioCom'    = moticam                        ,
           'TipoCambioVta'    = motctra                        ,
           'PariCie'          = moparme                        ,
           'PariTra'          = mopartr                        ,
           'PariFin'          = moparfi                        ,
           'Modoimpreso'      = moimpreso                      ,
           'Moneda'           = mocodmon                       ,
           'MonedaOpera'      = d.mnglosa                      ,
           'MonedaConve'      = mocodcnv                       ,
           'MonedaConversion' = o.mnglosa                      ,
           'NoOpera'          = monumope                       ,
           'TipoOpera'        = motipope                       ,
           'Entregamos'       = b.glosa                        ,
           'Recibimos'        = c.glosa                        ,
           'Operador'         = mooper                         ,
           'TipoCamTrF'       = motcfin                        ,
           'Retiro'           = morecib                        ,
           'TipoMercado'      = CONVERT(CHAR(40),motipmer)     ,
           'Estado'           = case moestatus when 'A' then 'ANULACION' ELSE ' ' END   ,
           'Exceso_Settle'    = SPACE(50)        , 
           'mofech'           = convert(char(12),mofech,103)       ,
           'hora  '           = convert(char(08),getdate(),108)    ,
	   'entidad'	      = @entidad 
   
     
      INTO #tempape
      FROM    memo                     ,
           view_cliente a,
           view_forma_de_pago b,
           view_forma_de_pago c,
           view_moneda d,
           view_moneda o,
           meac e
     WHERE   monumope = @NumOpe      AND
           morutcli = a.clrut      AND
           mocodcli = a.clcodigo   AND
           morecib  = c.codigo     AND
           moentre  = b.codigo     AND
           mocodmon = SUBSTRING(d.MnNemo,1,3) AND
        mocodcnv = SUBSTRING(o.MnNemo,1,3) 
   
   ---------------------<< Define Tipo de Mercado
    UPDATE #tempape
       SET TipoMercado  = glosa
      FROM bacparamsuda..ayuda_planilla
     WHERE NoOpera = @NumOpe 
       AND codigo_tabla = 15 AND codigo_caracter = SUBSTRING(RTRIM(TipoMercado),1,4)
    SELECT * FROM #tempape
 end
 else

 SELECT    'RutEmisor'        = 0                      ,
           'CodigoEmisor'     = 0                      ,
           'DigChkEmisor'     = ''                    ,
           'NombreEmisor'     = ''                    ,
           'RutCliente'       = 0                     ,
           'DigChkCliente'    = ''                    ,
           'NombreCliente'    = ''                    ,
           'DireccionCliente' = ''                    ,
           'fechaRecibe'      = ''                    ,
           'fechaEntrega'     = ''                    ,
           'MontoOpera'       = 0                     ,
           'MontoUSD'         = 0                     ,
           'MontoCLP'         = 0                     ,
           'TipoCamCie'       = 0                     ,
           'TipoCamTra'       = 0                     ,
           'PariCie'          = 0                     ,
           'PariTra'          = 0                     ,
           'PariFin'          = 0                     ,
           'Modoimpreso'      = ''                    ,
           'Moneda'           = ''                    ,
           'MonedaOpera'      = ''                    ,
           'MonedaConve'      = ''                    ,
           'MonedaConversion' = ''                    ,
           'NoOpera'          = 0                     ,
           'TipoOpera'        = ''                    ,
           'Entregamos'       = ''                    ,
           'Recibimos'        = ''                    ,
           'Operador'         = ''                    ,
           'TipoCamTrF'       = 0                     ,
           'Retiro'           = 0                     ,
           'TipoMercado'      = ''                    ,
           'Estado'           = ''                    ,
           'Exceso_Settle'    = ''                    ,
     	   'mofech'     = ''                          ,
     	   'hora  '     = convert(char(08),getdate(),108),
	   'entidad'	      = @entidad 
     
END

GO
