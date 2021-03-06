USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_IMPOPERINBANC]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_IMPOPERINBANC]
    (   
        @ENTIDAD     NUMERIC(10)
       ,@OPERADOR    CHAR(30)    
       ,@DESDE       CHAR(8) --DATETIME
       ,@HASTA       CHAR(8) --DATETIME
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
           @OMA         CHAR(3) 
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
           @OMA         OUTPUT
SET NOCOUNT ON
   DECLARE @CONSULT  VARCHAR(255)
   DECLARE @XNOMPROP CHAR(50)
   DECLARE @XRUTPROP NUMERIC(09)
   DECLARE @XDIGPROP CHAR(01)
   DECLARE @XFECPRO  DATETIME
   SELECT @XNOMPROP = acnomprop
         ,@XRUTPROP = acrutprop
         ,@XDIGPROP = acdigprop
  ,@XFECPRO  = acfecproc
    FROM VIEW_MDAC
IF EXISTS ( SELECT 1 FROM MEMO
                         ,VIEW_CLIENTE A
                         ,VIEW_FORMA_DE_PAGO B
                         ,VIEW_FORMA_DE_PAGO C
                         ,VIEW_ENTIDAD D
                   WHERE morutcli  = a.clrut 
                     AND mocodcli  = a.clcodigo
                     AND morecib   = b.codigo
                     AND moentre   = c.codigo
                     AND motipmer  = 'PTAS'
                     AND moentidad = @ENTIDAD
                     AND mofech >= @DESDE
                     AND mofech <= @HASTA
                     AND @HASTA <= @XFECPRO)
BEGIN
         SELECT  'RutEmisor'        = 0
                ,'CodigoEmisor'     = 0
                ,'NombreEmisor'     = SPACE(40)
                ,'NombreCliente'    = a.clnombre
                ,'DireccionCliente' = a.cldirecc
         ,'Tacfecpro'        = CONVERT(CHAR(10),mofech,103)
                ,'NoOpera'          = monumope
                ,'TipoOpera'        = motipope
                ,'MontoCLP'         = momonpe
                ,'MontoUSD'         = moussme
         ,'HoyFecha'         = CONVERT(CHAR(10),mofech,103)
         ,'Hora'             = mohora
                ,'TipoCamCie'       = moticam
                ,'Recib'            = b.glosa
                ,'Entreg' = c.glosa
                ,'DigChkEmisor' = SPACE(1)
                ,d.rcnombre
                ,'Usuario' = @OPERADOR
                ,'TipoOperacion'= motipmer
                ,'Moneda' = mocodmon
                ,'Fecha_Serv' = CONVERT( CHAR(10) , GETDATE() ,103 )
                ,'Desde' = SUBSTRING(@DESDE ,7,2) + '/' +SUBSTRING(@DESDE ,5,2) + '/' +SUBSTRING(@DESDE ,1,4)  --32--CONVERT ( CHAR(10), @DESDE    ,103 )
                ,'Hasta' = SUBSTRING(@HASTA ,7,2) + '/' +SUBSTRING(@HASTA ,5,2) + '/' +SUBSTRING(@HASTA ,1,4)   --CONVERT ( CHAR(10), @HASTA  ,103 )
                ,'MoFech' = CONVERT(CHAR(10),mofech,103)
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
           FROM MEMO
               ,VIEW_CLIENTE A
               ,VIEW_FORMA_DE_PAGO B
               ,VIEW_FORMA_DE_PAGO C
               ,VIEW_ENTIDAD D
          WHERE morutcli  = a.clrut 
            AND mocodcli  = a.clcodigo
            AND morecib   = b.codigo
            AND moentre   = c.codigo
            AND motipmer  = 'PTAS'
            AND moentidad = @ENTIDAD
            AND mofech >= @DESDE
            AND mofech <= @HASTA
            AND @HASTA <= @XFECPRO
            and (MOESTATUS = ' ' OR MOESTATUS = 'M') 
         UPDATE #TEMP
            SET RutEmisor    = @XRUTPROP
               ,CodigoEmisor = accodigo
               ,DigChkEmisor = @XDIGPROP
               ,NombreEmisor = @XNOMPROP
           FROM MEAC
               ,VIEW_CLIENTE
          WHERE acrut = clrut
         SELECT  *   FROM #TEMP
END ELSE 
BEGIN
         SELECT  'RutEmisor'        = ''
                ,'CodigoEmisor'     = ''
                ,'NombreEmisor'     = SPACE(40)
                ,'NombreCliente'    = ''
                ,'DireccionCliente' = ''
         ,'Tacfecpro' = ''
                ,'NoOpera' = ''
                ,'TipoOpera' = ''
                ,'MontoCLP' = ''
                ,'MontoUSD' = ''
         ,'HoyFecha' = CONVERT( CHAR(10), GETDATE(), 103 )
         ,'Hora'  = CONVERT( CHAR(10), GETDATE(), 108 )
                ,'TipoCamCie' = ''
                ,'Recib' = ''
                ,'Entreg' = ''
   ,'DigChkEmisor' = SPACE(1)
                ,'d.rcnombre' = ''
                ,'Usuario' = @OPERADOR
                ,'TipoOperacion'= ''
                ,'Moneda' = ''
                ,'Fecha_Serv' = CONVERT( CHAR(10) , GETDATE() ,103 )
                ,'Desde' = SUBSTRING(@DESDE ,7,2) + '/' +SUBSTRING(@DESDE ,5,2) + '/' +SUBSTRING(@DESDE ,1,4)  --32--CONVERT ( CHAR(10), @DESDE    ,103 )
                ,'Hasta' = SUBSTRING(@HASTA ,7,2) + '/' +SUBSTRING(@HASTA ,5,2) + '/' +SUBSTRING(@HASTA ,1,4)   --CONVERT ( CHAR(10), @HASTA  ,103 )
                ,'MoFech' = ''
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
END

GO
