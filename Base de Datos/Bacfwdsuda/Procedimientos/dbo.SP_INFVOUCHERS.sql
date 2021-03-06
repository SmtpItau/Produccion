USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFVOUCHERS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[SP_INFVOUCHERS]
AS
BEGIN

   SET NOCOUNT ON

SELECT acfecproc,
       acfecprox,
       'UF_Hoy'    = CONVERT(FLOAT, 0),
       'UF_Man'    = CONVERT(FLOAT, 0),
       'IVP_Hoy'   = CONVERT(FLOAT, 0),
       'IVP_Man'   = CONVERT(FLOAT, 0),
       'DO_Hoy'    = CONVERT(FLOAT, 0),
       'DO_Man'    = CONVERT(FLOAT, 0),
       'DA_Hoy'    = CONVERT(FLOAT, 0),
       'DA_Man'    = CONVERT(FLOAT, 0),
       acnomprop,
       'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
  INTO #Parametros
  FROM mfac
-- FROM mfacH WHERE acfecproc = '20091126'  --CBB
-- RESCATA VALOR DE UF -------------------------------------------------------------- 
UPDATE #Parametros SET UF_Hoy = ISNULL(vmvalor, 0.0)
FROM view_valor_moneda
WHERE  vmfecha  = acfecproc AND vmcodigo = 998
UPDATE #Parametros SET UF_Man = ISNULL(vmvalor, 0.0)
FROM view_valor_moneda
WHERE  vmfecha  = acfecprox AND vmcodigo = 998
--RESCATA VALOR DE IVP ------------------------------------------------------------- 
UPDATE #Parametros SET IVP_Hoy = ISNULL(vmvalor, 0.0)
FROM view_valor_moneda
WHERE  vmfecha  = acfecproc AND vmcodigo = 997
UPDATE #Parametros SET IVP_Man = ISNULL(vmvalor, 0.0)
FROM  view_valor_moneda
WHERE  vmfecha  = acfecprox AND vmcodigo = 997
-- RESCATA VALOR DE DO -------------------------------------------------------------- 
UPDATE #Parametros SET DO_Hoy = ISNULL(vmvalor, 0.0)
FROM  view_valor_moneda
WHERE  vmfecha  = acfecproc AND vmcodigo = 994
UPDATE #Parametros SET DO_Man = ISNULL(vmvalor, 0.0)
FROM view_valor_moneda
WHERE  vmfecha  = acfecprox AND vmcodigo = 994
--RESCATA VALOR DE DA -------------------------------------------------------------- 
UPDATE #Parametros SET DA_Hoy = ISNULL(vmvalor, 0.0)
FROM  view_valor_moneda
WHERE  vmfecha  = acfecproc AND vmcodigo = 995
UPDATE #Parametros SET DA_Man = ISNULL(vmvalor, 0.0)
FROM view_valor_moneda
WHERE  vmfecha  = acfecprox AND vmcodigo = 995
--print 'aqui'
IF EXISTS(SELECT * FROM detalle_voucher_cnt , voucher_cnt , view_plan_de_cuenta,#Parametros
                  WHERE detalle_voucher_cnt.Numero_Voucher = voucher_cnt.Numero_Voucher 
                    AND view_plan_de_cuenta.Cuenta = detalle_voucher_cnt.Cuenta
                    and voucher_cnt.Fecha_Ingreso = acfecproc
         ) BEGIN
       SELECT 'ACFECPROC' = CONVERT(CHAR(10), acfecproc, 103),
              'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
              UF_Hoy,
              UF_Man,
              IVP_Hoy,
              IVP_Man,
              DO_Hoy,
              DO_Man,
              DA_Hoy,
              DA_Man,
              acnomprop,
              rut_empresa,
              'hora' = CONVERT(varchar(10), GETDATE(), 108),
              a.Numero_Voucher   ,
              a.Correlativo      ,
              a.Cuenta           ,
              a.Tipo_Monto       ,
              a.Monto            ,
       b.glosa  ,
              b.Tipo_Voucher ,
              b.Tipo_Operacion ,
              b.Operacion ,
              SUBSTRING(b.Glosa,1,43)+' '+ CASE  WHEN LEFT(Tipo_Operacion,1)='D'  
      THEN  ( SELECT RTRIM(mnnemo) FROM view_moneda,mfca WHERE cacodmon1=mncodmon AND b.Operacion = canumoper)+'/'+(SELECT mnnemo FROM view_moneda,mfca WHERE cacodmon2=mncodmon AND b.Operacion = canumoper) ELSE ' ' END  ,
              'Rut' = (SELECT acrutprop FROM mfac)     ,
              'Dv'  = (SELECT acdigprop FROM mfac)     ,
              'Nom' = (SELECT  acnomprop FROM mfac)    ,
              Descripcion,
			  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) 
             
		 /* FROM 
              detalle_voucher_cnt a ,
              voucher_cnt  b ,
              view_plan_de_cuenta c ,
              #parametros          
          WHERE 
   a.Numero_Voucher = b.Numero_Voucher 
           AND c.Cuenta =* a.Cuenta AND Fecha_Ingreso = acfecproc
          ORDER BY
              b.Tipo_Operacion , a.Numero_Voucher */

		 --RQ 7619
          FROM  voucher_cnt  b ,
                view_plan_de_cuenta c  RIGHT OUTER JOIN  detalle_voucher_cnt a ON  c.Cuenta = a.Cuenta,
                #parametros          
          WHERE 
	            a.Numero_Voucher = b.Numero_Voucher 
                AND Fecha_Ingreso = acfecproc
          ORDER BY
              b.Tipo_Operacion , a.Numero_Voucher 
		
 END
   ELSE 
 BEGIN
       SELECT 'ACFECPROC' = CONVERT(CHAR(10), acfecproc, 103),
              'ACFECPROX' = CONVERT(CHAR(10), acfecprox, 103),
              UF_Hoy,
               UF_Man,
              IVP_Hoy,
    IVP_Man,
              DO_Hoy,
              DO_Man,
              DA_Hoy,
              DA_Man,
              acnomprop,
              rut_empresa,
              'hora' = CONVERT(varchar(10), GETDATE(), 108),
              'Numero_Voucher'   = 0,
              'Correlativo'      = 0,
              'Cuenta'           = 0 ,
              'Tipo_Monto'       = ' ' ,
              'Monto'            = 0,
              'glosa'            = ' ' ,
              'Tipo_Voucher'     = ' ' ,
              'Tipo_Operacion'   = ' ' ,
              'Operacion'        = 0,
              'glosa_operacion'  = ' ' ,
              'Rut'              = 0,
              'Dv'               = ' ' ,
              'Nom'              = ' ' ,
              'Descripcion'      = ' ' ,
			  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
  FROM #parametros          
     END
END




GO
