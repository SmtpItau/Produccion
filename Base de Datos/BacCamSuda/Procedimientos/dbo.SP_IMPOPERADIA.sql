USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPOPERADIA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPOPERADIA] --1,'ADMINISTRA','20010628','20010628'
            (  
                @ENTIDAD     NUMERIC(10)
               ,@OPERADOR    CHAR(30)
               ,@DESDE       DATETIME
               ,@HASTA       DATETIME
            )
AS
BEGIN   
SET NOCOUNT ON
DECLARE @XNOMPROP CHAR(50)
DECLARE @XRUTPROP NUMERIC(09)
DECLARE @XDIGPROP CHAR(1)
DECLARE @XFECPROC DATETIME
SELECT  @XNOMPROP = acnomprop
       ,@XRUTPROP = acrutprop
       ,@XDIGPROP = acdigprop
  FROM  VIEW_MDAC
SELECT  @XFECPROC = acfecpro FROM  MEAC
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
           @hora        char(8) ,
    @oma  char(3)
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
    @oma  OUTPUT
IF EXISTS ( SELECT 1 FROM MEMO
                         ,VIEW_CLIENTE A
                         ,VIEW_FORMA_DE_PAGO B
                         ,VIEW_FORMA_DE_PAGO C
                         ,VIEW_ENTIDAD D
                         ,VIEW_PRODUCTO P
                    WHERE morutcli          =    a.clrut  
                      AND mocodcli          =    a.clcodigo
                      AND morecib           =    c.codigo
                      AND moentre           =    b.codigo
                      AND ( @ENTIDAD        =    0    OR @ENTIDAD = moentidad )
                      AND d.rccodcar        =    moentidad
                      AND motipope          <>   'A'
                      AND P.ID_SISTEMA      =    'BCC'
                      AND P.codigo_producto =    motipmer
                      AND moestatus         = ' ' OR MOESTATUS = 'M' --'A' 
                      AND mofech >= @DESDE
                      AND mofech <= @HASTA
                      AND @HASTA <= @XFECPROC )
                     
BEGIN
SELECT 
        'RutEmisor'     = @XRUTPROP
       ,'CodigoEmisor'  = 0
       ,'DigChkEmisor'  = @XDIGPROP
       ,'NombreEmisor'  = @XNOMPROP
       ,'NombreCliente' = a.clnombre
       ,'NoOpera'       = monumope
       ,'TipoOpera'     = motipope
       ,'TipoMerc'      = P.descripcion
       ,'MonedaOpera'   = LTRIM(mocodmon)
       ,'MontoOpera'    = momonmo
       ,'TipoCamCie'    = moticam
       ,'PariCie'       = moparme
       ,'TipoCamTrF'    = motcfin
       ,'PariFin'       = moparfi
       ,'Entregamos'    = b.glosa
       ,'Recibimos'     = c.glosa
       ,'UtiliTrad'     = CONVERT(NUMERIC(19),0)
       ,'UtiliPos'      = CONVERT(NUMERIC(19),0)
       ,'TipoCamTra'    = motctra
       ,'PariTra'       = mopartr
       ,'Montoclp'      = momonpe
       ,'fech'          = CONVERT(CHAR(10),mofech,103)
       ,'hora'          = convert(char(08),getdate(),108)
       , d.rcNombre
       ,'Operador'      = @OPERADOR
       ,'fecha_Proceso' = CONVERT(CHAR(10),@XFECPROC,103 )
       ,'FechaServ'     = CONVERT(CHAR(10),GETDATE(),103 )
       ,'Desde'         = CONVERT(CHAR(10),@DESDE,103)
       ,'Hasta'         = CONVERT(CHAR(10),@HASTA,103)
       ,'acfecproc' =@acfecproc
       ,'acfecprox' =@acfecprox
       ,'uf_hoy' =@uf_hoy
       ,'uf_man' =@uf_man
       ,'ivp_hoy' =@ivp_hoy
       ,'ivp_man' =@ivp_man
       ,'do_hoy' =@do_hoy
       ,'do_man' =@do_man
       ,'da_hoy' =@da_hoy
       ,'da_man' =@da_man
       ,'pmnomprop' =@acnomprop
       ,'rut_empresa' =@rut_empresa
       
INTO #TEMP
  FROM  MEMO
       ,VIEW_CLIENTE A
       ,VIEW_FORMA_DE_PAGO B
       ,VIEW_FORMA_DE_PAGO C
       ,VIEW_ENTIDAD D
       ,VIEW_PRODUCTO P
 WHERE morutcli          =    a.clrut  
   AND mocodcli          =    a.clcodigo
   AND morecib           =    c.codigo
   AND moentre           =    b.codigo
   AND ( @ENTIDAD        =    0    OR @ENTIDAD = moentidad )
   AND d.rccodcar        =    moentidad
   AND motipope          <>   'A'
   AND P.ID_SISTEMA      =    'BCC'
   AND P.codigo_producto =    motipmer
   AND moestatus         <>   'A' AND moestatus <> 'R' AND moestatus <> 'P'
   AND mofech >= @DESDE
   AND mofech <= @HASTA
   AND @HASTA <= @XFECPROC
   
UPDATE #TEMP
   SET CodigoEmisor = accodigo
      ,UtiliTrad    = vmutilipo
      ,UtiliPos     = vmutiltot
  FROM MEAC 
      ,VIEW_CLIENTE
      ,VIEW_POSICION_SPT 
 WHERE acrut = clrut 
   AND vmfecha = acfecpro
   AND vmcodigo = 'USD'
----<< Resultado
   SELECT * 
     FROM #TEMP 
 ORDER BY NombreCliente
         ,TipoOpera
         ,NoOpera
END ELSE
BEGIN
SELECT 
        'RutEmisor'     = ''
       ,'CodigoEmisor'  = ''
       ,'DigChkEmisor'  = ''
       ,'NombreEmisor'  = ''
       ,'NombreCliente' = ''
       ,'NoOpera'       = ''
       ,'TipoOpera'     = ''
       ,'TipoMerc'      = ''
       ,'MonedaOpera'   = ''
       ,'MontoOpera'    = ''
       ,'TipoCamCie'    = ''
       ,'PariCie'       = ''
       ,'TipoCamTrF'    = ''
       ,'PariFin'       = ''
       ,'Entregamos'    = ''
       ,'Recibimos'     = ''
       ,'UtiliTrad'     = ''
       ,'UtiliPos'      = ''
       ,'TipoCamTra'    = ''
       ,'PariTra'       = ''
       ,'Montoclp'      = ''
       ,'fech'          = CONVERT( CHAR(10), GETDATE() ,103 )
       ,'hora'          = CONVERT( CHAR(08), GETDATE(), 108 )
       ,'d.rcNombre'    = ''
       ,'Operador'      = @OPERADOR
       ,'fecha_Proceso' = CONVERT ( CHAR(10), @XFECPROC ,103 )
       ,'FechaServ'     = CONVERT ( CHAR(10), GETDATE() ,103 )
       ,'Desde'         = CONVERT ( CHAR(10), @DESDE    ,103 )
       ,'Hasta'         = CONVERT ( CHAR(10), @HASTA  ,103 )
       ,'acfecproc' =@acfecproc
       ,'acfecprox' =@acfecprox
       ,'uf_hoy' =@uf_hoy
       ,'uf_man' =@uf_man
       ,'ivp_hoy' =@ivp_hoy
       ,'ivp_man' =@ivp_man
       ,'do_hoy' =@do_hoy
       ,'do_man' =@do_man
       ,'da_hoy' =@da_hoy
       ,'da_man' =@da_man
       ,'pmnomprop' =@acnomprop
       ,'rut_empresa' =@rut_empresa
END
SET NOCOUNT OFF
END

GO
