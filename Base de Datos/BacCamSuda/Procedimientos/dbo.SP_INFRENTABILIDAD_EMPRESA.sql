USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFRENTABILIDAD_EMPRESA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFRENTABILIDAD_EMPRESA]
     ( @Fecha_Inicio  CHAR(10) ,
      @Fecha_Termino  CHAR(10) ,
      @Rut_Cliente  NUMERIC(10) ,
      @Usuario  CHAR(40)
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
    @oma  char(3),
           @fec_ini      datetime,
           @fec_ter      datetime
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
           @oma         OUTPUT
           select @fec_ini = convert(datetime, @Fecha_Inicio,112)
           select @fec_ter = convert(datetime, @Fecha_Termino,112)
    
    
 SELECT  'Fecha_Proceso'  = @acfecproc     ,
  'Hora'   = @Hora      ,
  'Titulo'  = 'RANKING RENTABILIDAD DE EMPRESAS' ,
  'Empresa'  = clnombre     ,
  'Numero_Compras' = CASE WHEN motipope = 'C' THEN 1 ELSE 0 END ,
  'Numero_Ventas'  = CASE WHEN motipope = 'V' THEN 1 ELSE 0 END ,
  'Total_Compra_Venta' = 0,
  'Dolares_Compra' = CASE  WHEN mocodmon =  'USD' AND motipope = 'C'   THEN ( motctra-moticam )*moussme/vmvalor
         WHEN mocodmon <> 'USD' AND motipope = 'C' AND mocodcnv = 'CLP'  THEN ( motctra-moticam )*moussme/vmvalor
        ELSE 0 
       END ,
  'Dolares_Venta'  = CASE  WHEN mocodmon =  'USD' AND motipope = 'V'    THEN ( moticam-motctra )*moussme/vmvalor
         WHEN mocodmon <> 'USD' AND motipope = 'V' AND mocodcnv = 'CLP'  THEN ( moticam-motctra )*moussme/vmvalor
        ELSE 0 
       END ,
  'Dolares_Total'  = 0,
  'Monedas_Compra' = CASE  WHEN mocodmon <> 'USD' AND motipope = 'C' THEN ( ( (1/mopartr)-(1/moparme) )* momonmo ) 
      ELSE 0 
       END ,
  'Monedas_Venta'  = CASE  WHEN mocodmon <> 'USD' AND motipope = 'V' THEN ( ( (1/moparme)-(1/mopartr) )* momonmo ) 
      ELSE 0 
       END ,
  'Monedas_Total'  = 0,
  'Totales_Compra' = 0,
  'Totales_Venta'  = 0,
  'Totales_Total'  = 0,
  'Dolar_Calculo'  = vmvalor,
  'fecha_SERV'         = CONVERT( CHAR(10) , GETDATE(), 103),
  'acfecproc'        =@acfecproc,
  'acfecprox'         =@acfecprox,
  'uf_hoy'        =@uf_hoy,
  'uf_man'        =@uf_man,
  'ivp_hoy'        =@ivp_hoy,
  'ivp_man'        =@ivp_man,
  'do_hoy'        =@do_hoy,
  'do_man'        =@do_man,
  'da_hoy'        =@da_hoy,
  'da_man'        =@da_man,
  'pmnomprop'        =@acnomprop,
  'rut_empresa'        =@rut_empresa,
  'usuario'  =@Usuario,
                'fecha_inicio'          =       convert(CHAR(10), @Fec_Ini,103),
                'fecha_termino'          =       convert(CHAR(10), @Fec_TER,103)
  INTO #Renta_Empresa
  FROM  memo  ,
   view_cliente ,
   view_valor_moneda
  WHERE mofech >= @Fecha_Inicio
  AND   mofech <= @Fecha_Termino
  AND   (morutcli  = @Rut_Cliente OR @Rut_cliente = 0)
  AND    ( morutcli  = clrut
  AND    mocodcli  = clcodigo )
                AND    motipmer='EMPR'             
                AND   (moestatus = ' ' OR moestatus ='M')
  AND   (CONVERT(CHAR(8),vmfecha ,112 ) = CONVERT(CHAR(8),mofech ,112 )
                AND    vmcodigo = 994 )  
 INSERT #Renta_Empresa
 SELECT  'Fecha_Proceso'  = @acfecproc     ,
  'Hora'   = @Hora      ,
  'Titulo'  = 'RANKING RENTABILIDAD DE EMPRESAS  ' ,
  'Empresa'  = clnombre     ,
  'Numero_Compras' = CASE WHEN motipope = 'C' THEN 1 ELSE 0 END ,
  'Numero_Ventas'  = CASE WHEN motipope = 'V' THEN 1 ELSE 0 END ,
  'Total_Compra_Venta' = 0,
  'Dolares_Compra' = CASE  WHEN mocodmon =  'USD' AND motipope = 'C'    THEN ( motctra-moticam )*moussme/vmvalor
         WHEN mocodmon <> 'USD' AND motipope = 'C' AND mocodcnv = 'CLP'  THEN ( motctra-moticam )*moussme/vmvalor 
        ELSE 0 
       END ,
  'Dolares_Venta'  = CASE  WHEN mocodmon =  'USD' AND motipope = 'V'    THEN ( moticam-motctra )*moussme/vmvalor
         WHEN mocodmon <> 'USD' AND motipope = 'V' AND mocodcnv = 'CLP'  THEN ( moticam-motctra )*moussme/vmvalor 
        ELSE 0 
       END ,
  'Dolares_Total'  = 0,
  'Monedas_Compra' = CASE  WHEN mocodmon <> 'USD' AND motipope = 'C' THEN ( ( (1/mopartr)-(1/moparme) )* momonmo ) 
      ELSE 0 
       END ,
  'Monedas_Venta'  = CASE  WHEN mocodmon <> 'USD' AND motipope = 'V' THEN ( ( (1/moparme)-(1/mopartr) )* momonmo ) 
      ELSE 0 
       END ,
  'Monedas_Total'  = 0,
  'Totales_Compra' = 0,
  'Totales_Venta'  = 0,
  'Totales_Total'  = 0,
  'Dolar_Calculo'  = vmvalor,
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
  'rut_empresa'       =@rut_empresa,
  'usuario'       =@Usuario,
                'fecha_inicio'        =       convert(CHAR(10), @Fec_Ini,103),
                'fecha_termino'       =       convert(CHAR(10), @Fec_TER,103)
  FROM  memoh  ,
   view_cliente ,
   view_valor_moneda
  WHERE mofech >= @Fecha_Inicio
  AND   mofech <= @Fecha_Termino
  AND  (morutcli = @Rut_Cliente OR @Rut_cliente = 0)
  AND  ( morutcli = clrut
   AND    mocodcli = clcodigo )
                AND   motipmer='EMPR'
                AND  (moestatus = ' ' OR moestatus ='M')
  AND   (CONVERT(CHAR(8),vmfecha ,112 ) = CONVERT(CHAR(8),mofech ,112 )
                AND    vmcodigo = 994 )  
 IF NOT EXISTS(SELECT * FROM #Renta_Empresa)
  SELECT  'Fecha_Proceso'=CONVERT(CHAR(10),@acfecproc,103)  ,
   'Hora'=CONVERT(CHAR(08),GETDATE(),108)    ,
   'Titulo'='RANKING RENTABILIDAD DE EMPRESAS'  ,
   'Empresa'='No existen datos para ' + RTRIM(clnombre)  ,
   'Numero_Compras'= 0    ,
   'Numero_Ventas' = 0    ,
   'Total_Compra_Venta'=0    ,
   'Dolares_Compra'=0    ,
   'Dolares_Venta' =0    ,
   'Dolares_Total' =0    ,
   'Monedas_Compra'=0    ,
   'Monedas_Venta' =0    ,
   'Monedas_Total' =0    ,
   'Totales_Compra'=0    ,
   'Totales_Venta' =0    ,
   'Totales_Total' =0    ,
   'Dolar_Calculo' = 0,
   'fecha_SERV' = CONVERT( CHAR(10) , GETDATE(), 103),
   'acfecproc' =@acfecproc,
   'acfecprox' =@acfecprox,
   'uf_hoy' =@uf_hoy,
   'uf_man' =@uf_man,
   'ivp_hoy' =@ivp_hoy,
   'ivp_man' =@ivp_man,
   'do_hoy' =@do_hoy,
   'do_man' =@do_man,
   'da_hoy'        =@da_hoy,
   'da_man' =@da_man,
   'pmnomprop' =@acnomprop,
   'rut_empresa' =@rut_empresa,
   'hora'  =@hora,
   'usuario' =@Usuario,
                        'fecha_inicio'  =       convert(CHAR(10), @Fec_Ini,103),
                        'fecha_termino' =       convert(CHAR(10), @Fec_TER,103)
   FROM view_cliente
   WHERE (clrut = @Rut_Cliente or @Rut_Cliente = 0)
--                          AND  cltipcli = 7
 ELSE
  SELECT  'Fecha_Proceso'=CONVERT(CHAR(10),Fecha_Proceso,103)  ,
   Hora        ,
   Titulo        ,
   Empresa        ,
   'Numero_Compras'= SUM(Numero_Compras)    ,
   'Numero_Ventas' = SUM(Numero_Ventas)    ,
   'Total_Compra_Venta'=SUM(Numero_Compras) + SUM(Numero_Ventas) ,
   'Dolares_Compra'=SUM(Dolares_Compra)    ,
   'Dolares_Venta' =SUM(Dolares_Venta)    ,
   'Dolares_Total' =SUM(Dolares_Compra) +  SUM(Dolares_Venta) ,
   'Monedas_Compra'=SUM(Monedas_Compra)    ,
   'Monedas_Venta' =SUM(Monedas_Venta)    ,
   'Monedas_Total' =SUM(Monedas_Compra) + SUM(Monedas_Venta) ,
   'Totales_Compra'=SUM(Dolares_Compra) +  SUM(Monedas_Compra) ,
   'Totales_Venta' =SUM(Dolares_Venta) + SUM(Monedas_Venta) ,
   'Totales_Total' =(SUM(Dolares_Compra) + SUM(Monedas_Compra) + SUM(Dolares_Venta) + SUM(Monedas_Venta)),
   'fecha_SERV' = CONVERT( CHAR(10) , GETDATE(), 103),
   'acfecproc' =@acfecproc,
   'acfecprox' =@acfecprox,
   'uf_hoy' =@uf_hoy,
   'uf_man' =@uf_man,
   'ivp_hoy' =@ivp_hoy,
   'ivp_man' =@ivp_man,
   'do_hoy' =@do_hoy,
   'do_man' =@do_man,
   'da_hoy'        =@da_hoy,
   'da_man' =@da_man,
   'pmnomprop' =@acnomprop,
   'rut_empresa' =@rut_empresa,
   'hora'  =@hora,
   'usuario' =@Usuario,
                         'fecha_inicio'          =       convert(CHAR(10), @Fec_Ini,103),
                         'fecha_termino'          =       convert(CHAR(10), @Fec_TER,103)
  FROM #Renta_Empresa
  GROUP BY Fecha_Proceso ,
    Hora  ,
    Titulo  ,
    Empresa  
  ORDER BY Empresa
END

GO
