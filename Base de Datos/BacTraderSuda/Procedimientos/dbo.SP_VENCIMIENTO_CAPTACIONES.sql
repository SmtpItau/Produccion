USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VENCIMIENTO_CAPTACIONES]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VENCIMIENTO_CAPTACIONES]
AS
BEGIN
SELECT acfecproc,
       acfecprox,
       'uf_hoy'    = CONVERT(FLOAT, 0),
       'uf_man'    = CONVERT(FLOAT, 0),
       'ivp_hoy'   = CONVERT(FLOAT, 0),
       'ivp_man'   = CONVERT(FLOAT, 0),
       'do_hoy'    = CONVERT(FLOAT, 0),
       'do_man'    = CONVERT(FLOAT, 0),
       'da_hoy'    = CONVERT(FLOAT, 0),
       'da_man'    = CONVERT(FLOAT, 0),
       acnomprop,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
  INTO #PARAMETROS
  FROM MDAC
/* RESCATA VALOR DE UF -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET uf_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
  FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
  WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
   AND VIEW_VALOR_MONEDA.vmcodigo = 998
 UPDATE #PARAMETROS SET uf_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 998
/* RESCATA VALOR DE IVP ------------------------------------------------------------- */
 UPDATE #PARAMETROS SET ivp_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
 UPDATE #PARAMETROS SET ivp_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 997
/* RESCATA VALOR DE DO -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET do_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
 UPDATE #PARAMETROS SET do_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 994
/* RESCATA VALOR DE DA -------------------------------------------------------------- */
 UPDATE #PARAMETROS SET da_hoy = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecproc
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
 UPDATE #PARAMETROS SET da_man = ISNULL(VIEW_VALOR_MONEDA.vmvalor, 0.0)
                FROM VIEW_VALOR_MONEDA VIEW_VALOR_MONEDA
                WHERE VIEW_VALOR_MONEDA.vmfecha  = acfecprox
                 AND VIEW_VALOR_MONEDA.vmcodigo = 995
 DECLARE @Fecha_Proceso  DATETIME
 SELECT @Fecha_Proceso = acfecproc FROM MDAC
  
        SELECT  
                'ACFECPROC' = CONVERT(CHAR(10), acfecproc, 103),
                'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
                uf_hoy,
                uf_man,
                ivp_hoy,
                ivp_man,
                do_hoy,
                do_man,
                da_hoy,
                da_man,
                acnomprop,
                rut_empresa,
                'hora' = CONVERT(varchar(10), GETDATE(), 108),
                'Numero_Operacion' = Numero_Operacion ,
  'Cliente'  = clnombre  ,
  'Fecha_Vencimiento' = CONVERT(CHAR(10),Fecha_Vencimiento,103),
  'Tasa'   = Tasa   ,
  'Moneda'  = mnnemo  ,   
  'Capital$'  = Monto_inicio_Pesos ,
  'Intereses_x_Cobrar$' = interes_acumulado ,
  'Reajustes_x_Cobrar$' = reajuste_acumulado ,
  'Valor_Actual$'  = valor_presente  ,
  'Dias'                  = (SELECT DATEDIFF(dd,@Fecha_Proceso,Fecha_Vencimiento)),
  'Codigo_Captacion'      = (CASE Moneda WHEN 999 THEN 'N'
             WHEN 998 THEN 'R'
             WHEN 994 THEN 'R' 
             WHEN 995 THEN 'R' 
             ELSE  'M'   
             END)     , 
  'tipo_operacion'        = (CASE Moneda WHEN 999 THEN 'No Reajustable'
             WHEN 998 THEN 'Reajustable'
             WHEN 994 THEN 'Reajustable' 
             WHEN 995 THEN 'Reajustable' 
             ELSE  'Moneda Extranjera'        
             END) 
 FROM  
  GEN_CAPTACION ,
  VIEW_CLIENTE  ,
  VIEW_MONEDA            ,
                #parametros
 WHERE   
  clrut     = rut_Cliente
   AND   clcodigo   = codigo_Rut
 AND   mnCodMon   = moneda
 ORDER BY 
  Dias  ,
  Numero_Operacion
      
END

GO
