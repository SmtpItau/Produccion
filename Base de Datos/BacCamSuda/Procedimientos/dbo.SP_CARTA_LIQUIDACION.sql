USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTA_LIQUIDACION]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARTA_LIQUIDACION]( @cUsuario  CHAR(40) ,
     @nNumeroOperacion NUMERIC(10) ,
     @cTipoOperacion  CHAR(1)  
              )
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
           @Codigo_Oma  Char(3)
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
           @hora        OUTPUT,
           @Codigo_Oma  OUTPUT
IF @cTipoOperacion = 'C'
SELECT  'Operacion'=monumope     ,--1
  'Fecha'= convert(char(12),mofech,103)   ,--2
  'Cliente'=c.clnombre     ,--3
  'Moneda'=LOWER(m.mnglosa)    ,--4
  'Forma_Pago'=ISNULL(LOWER(f.glosa),'')   ,--5
  'Moneda_Pago'=momonpe     ,--6
  'ctacte'=CASE c.climplic WHEN 'A' THEN '(ABA ' + c.claba + ')'
    WHEN 'S' THEN '(SWIFT ' + c.clswift + ')'
    WHEN 'C' THEN '(CHIPS ' + c.clchips + ')'
    ELSE ' '  END  ,--7
                'mantenemos'='                       (ABA          )' ,--8
--                'mantenemos'='XXXXXXXX XXXX XXX XXXX (ABA XXXXXXXXX)' ,--8
  'valuta'=movaluta2     ,--9
  'moneda_ex'=momonmo     ,--10
  'tipo_cambio'=moticam     ,--11
  'entidad'=acnombre     ,--12
  'Titulo-1'='LIQUIDACION POR COMPRA' ,--13
  'Titulo-2'='DE MONEDA EXTRANJERA'  ,--14
  'simbolo'=m.mnsimbol     ,--15
  'tipo_operacion'=CASE WHEN @cTipoOperacion = 'C' THEN 'compra' ELSE 'venta' END,
  'fecha_SERV'                    =  CONVERT( CHAR(10) , GETDATE(), 103), 
  'acfecproc'    =@acfecproc,
    'acfecprox'           =@acfecprox,
    'uf_hoy'          =@uf_hoy,
    'uf_man'          =@uf_man,
    'ivp_hoy'          =@ivp_hoy,
    'ivp_man'                 =@ivp_man,
    'do_hoy'          =@do_hoy,
    'do_man'          =@do_man,
    'da_hoy'          =@da_hoy,
    'da_man'          =@da_man,
  'hora'     =@hora,
  'usuario'    =@cUsuario
  FROM  memo RIGHT OUTER JOIN view_forma_de_pago f ON moentre = f.codigo ,
   view_cliente       c ,
   view_moneda        m ,
   meac
  WHERE morutcli = c.clrut
  AND mocodmon = mnnemo
  AND monumope=@nNumeroOperacion
  AND (MOESTATUS = ' ' OR MOESTATUS = 'M')  

/*REQ.7619 CASS 06-01-2011
  FROM  memo    ,
   view_cliente       c ,
   view_forma_de_pago f ,
   view_moneda        m ,
   meac
  WHERE f.codigo =* moentre
  AND morutcli = c.clrut
--  AND mocodcli= c.clcodigo
  AND mocodmon=mnnemo
  AND monumope=@nNumeroOperacion
                and    (MOESTATUS = ' ' OR MOESTATUS = 'M')  
*/
  
IF @cTipoOperacion = 'V'
SELECT  'Operacion'=monumope     ,--1
  'Fecha'= convert(char(12),mofech,103)   ,--2
  'Cliente'=c.clnombre     ,--3
  'Moneda'=LOWER(m.mnglosa)    ,--4
  'Forma_Pago'=ISNULL(LOWER(f.glosa),'')   ,--5
  'Moneda_Pago'=momonpe     ,--6
  'ctacte'=CASE c.climplic WHEN 'A' THEN '(ABA ' + c.claba + ')'
    WHEN 'S' THEN '(SWIFT ' + c.clswift + ')'
    WHEN 'C' THEN '(CHIPS ' + c.clchips + ')'
    ELSE ' '  END  ,--7
  'mantenemos'=' '    ,--8
  'valuta'=movaluta1     ,--9
  'moneda_ex'=momonmo      ,--10
  'tipo_cambio'=moticam      ,--11
  'entidad'=acnombre     ,--12
  'Titulo-1'='LIQUIDACION POR VENTA'  ,--13
  'Titulo-2'='DE MONEDA EXTRANJERA'  ,--14
  'simbolo'=m.mnsimbol      ,--15
  'tipo_operacion'=CASE WHEN @cTipoOperacion = 'C' THEN 'compra' ELSE 'venta' END,
  'fecha_SERV'                   =CONVERT( CHAR(10) , GETDATE(), 103) ,
  'acfecproc'    =@acfecproc,
    'acfecprox'           =@acfecprox,
    'uf_hoy'          =@uf_hoy,
    'uf_man'          =@uf_man,
    'ivp_hoy'          =@ivp_hoy,
    'ivp_man'                 =@ivp_man,
    'do_hoy'          =@do_hoy,
    'do_man'          =@do_man,
    'da_hoy'          =@da_hoy,
    'da_man'          =@da_man,
  'hora'     =@hora,
  'usuario'    =@cUsuario
  FROM  memo RIGHT OUTER JOIN view_forma_de_pago f ON f.codigo = morecib ,
   view_cliente       c ,
   view_moneda        m ,
   meac
  WHERE morutcli = c.clrut
  AND mocodmon=mnnemo
  AND monumope=@nNumeroOperacion
  AND (MOESTATUS = ' ' OR MOESTATUS = 'M')

/* REQ.7619 CASS 06-01-2011
   FROM  memo    ,
   view_cliente       c ,
   view_forma_de_pago f ,
   view_moneda        m ,
   meac
  WHERE f.codigo =* morecib
  AND morutcli = c.clrut
--  AND mocodcli= c.clcodigo
  AND mocodmon=mnnemo
  AND monumope=@nNumeroOperacion
  and     (MOESTATUS = ' ' OR MOESTATUS = 'M')
*/

END
--sp_carta_liquidacion 'ADMINISTRA',12,'C'
--select * from memo




GO
