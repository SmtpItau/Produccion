USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFVOUCHERS_HISTORICO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFVOUCHERS_HISTORICO]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
   SELECT  @dFechaProceso   = '20061222' --acfecproc
   FROM    MFAC

   SELECT 'acfecproc'   = CONVERT(DATETIME,'20061222') -- acfecproc
   ,      'acfecprox'   = CONVERT(DATETIME,'20061226') -- acfecprox
   ,      'UF_Hoy'      = CONVERT(FLOAT, 0)
   ,      'UF_Man'      = CONVERT(FLOAT, 0)
   ,      'IVP_Hoy'     = CONVERT(FLOAT, 0)
   ,      'IVP_Man'     = CONVERT(FLOAT, 0)
   ,      'DO_Hoy'      = CONVERT(FLOAT, 0)
   ,      'DO_Man'      = CONVERT(FLOAT, 0)
   ,      'DA_Hoy'      = CONVERT(FLOAT, 0)
   ,      'DA_Man'      = CONVERT(FLOAT, 0)
   ,      'acnomprop'   = acnomprop
   ,      'rut_empresa' = RTRIM(CONVERT(CHAR(10),acrutprop)) + '-' + acdigprop
   INTO   #Parametros
   FROM   MFAC

   -- RESCATA VALOR DE UF -------------------------------------------------------------- 
   UPDATE #Parametros SET UF_Hoy = ISNULL(vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 998
   UPDATE #Parametros SET UF_Man = ISNULL(vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 998

   --RESCATA VALOR DE IVP ------------------------------------------------------------- 
   UPDATE #Parametros SET IVP_Hoy = ISNULL(vmvalor, 0.0)FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 997
   UPDATE #Parametros SET IVP_Man = ISNULL(vmvalor, 0.0)FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 997

   -- RESCATA VALOR DE DO -------------------------------------------------------------- 
   UPDATE #Parametros SET DO_Hoy = ISNULL(vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 994
   UPDATE #Parametros SET DO_Man = ISNULL(vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 994

   --RESCATA VALOR DE DA -------------------------------------------------------------- 
   UPDATE #Parametros SET DA_Hoy = ISNULL(vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecproc AND vmcodigo = 995
   UPDATE #Parametros SET DA_Man = ISNULL(vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha = acfecprox AND vmcodigo = 995



   IF EXISTS(SELECT 1 FROM DETALLE_VOUCHER_CNT 
                           INNER JOIN VOUCHER_CNT         ON detalle_voucher_cnt.Numero_Voucher = voucher_cnt.Numero_Voucher 
                           INNER JOIN VIEW_PLAN_DE_CUENTA ON view_plan_de_cuenta.Cuenta = detalle_voucher_cnt.Cuenta
                      WHERE voucher_cnt.Fecha_Ingreso = @dFechaProceso)
   BEGIN

      SELECT 'ACFECPROC'     = CONVERT(CHAR(10),CONVERT(DATETIME,'20061222'),103)  -- CONVERT(CHAR(10),ctrl.acfecproc,103)
      ,      'ACFECPROX'     = CONVERT(CHAR(10),CONVERT(DATETIME,'20061226'),103)  -- CONVERT(CHAR(10),ctrl.acfecprox,103)
      ,      'UF_Hoy'        = UF_Hoy
      ,      'UF_Man'        = UF_Man
      ,      'IVP_Hoy'       = IVP_Hoy
      ,      'IVP_Man'       = IVP_Man
      ,      'DO_Hoy'        = DO_Hoy
      ,      'DO_Man'        = DO_Man
      ,      'DA_Hoy'        = DA_Hoy
      ,      'DA_Man'        = DA_Man
      ,      'acnomprop'     = ctrl.acnomprop
      ,      'rut_empresa'   = rut_empresa
      ,      'hora'          = CONVERT(VARCHAR(10),GETDATE(),108)
      ,      'Numero_Voucher'= a.Numero_Voucher
      ,      'Correlativo'   = a.Correlativo
      ,      'Cuenta'        = a.Cuenta
      ,      'Tipo_Monto'    = a.Tipo_Monto
      ,      'Monto'         = a.Monto
      ,      'glosa'         = b.glosa
      ,      'Tipo_Voucher'  = b.Tipo_Voucher
      ,      'Tipo_Operacion'= b.Tipo_Operacion
      ,      'Operacion'     = b.Operacion
      ,      SUBSTRING(b.Glosa,1,43) 
             + ' ' 
             + CASE WHEN LEFT(Tipo_Operacion,1)= 'D' THEN (SELECT RTRIM(mnnemo) FROM VIEW_MONEDA , MFCA WHERE cacodmon1 = mncodmon AND b.Operacion = canumoper) 
                                                  + '/' + (SELECT RTRIM(mnnemo) FROM VIEW_MONEDA , MFCA WHERE cacodmon2 = mncodmon AND b.Operacion = canumoper) 
                    ELSE ' '
               END  
      ,      'Rut'            = ctrl.acrutprop --(SELECT acrutprop FROM MFAC)
      ,      'Dv'             = ctrl.acdigprop --(SELECT acdigprop FROM MFAC)
      ,      'Nom'            = ctrl.acnomprop --(SELECT acnomprop FROM MFAC)
      ,      'Descripcion'    = Descripcion
      FROM   DETALLE_VOUCHER_CNT            a
             INNER JOIN VOUCHER_CNT         b ON a.Numero_Voucher = b.Numero_Voucher 
             INNER JOIN VIEW_PLAN_DE_CUENTA c ON c.Cuenta         = a.Cuenta
      ,      MFAC   ctrl
      ,      #Parametros
      WHERE  b.Fecha_Ingreso = @dFechaProceso
      ORDER BY a.Numero_Voucher 
   END ELSE 
   BEGIN
      SELECT 'ACFECPROC'        = CONVERT(CHAR(10),acfecproc,103)
      ,      'ACFECPROX'        = CONVERT(CHAR(10),acfecprox,103)
      ,      'UF_Hoy'           = UF_Hoy
      ,      'UF_Man'           = UF_Man
      ,      'IVP_Hoy'          = IVP_Hoy
      ,      'IVP_Man'          = IVP_Man
      ,      'DO_Hoy'           = DO_Hoy
      ,      'DO_Man'           = DO_Man
      ,      'DA_Hoy'           = DA_Hoy
      ,      'DA_Man'           = DA_Man
      ,      'acnomprop'        = acnomprop
      ,      'rut_empresa'      = rut_empresa
      ,      'hora'             = CONVERT(VARCHAR(10),GETDATE(),108)
      ,      'Numero_Voucher'   = 0
      ,      'Correlativo'      = 0
      ,      'Cuenta'           = 0
      ,      'Tipo_Monto'       = ' '
      ,      'Monto'            = 0
      ,      'glosa'            = ' '
      ,      'Tipo_Voucher'     = ' '
      ,      'Tipo_Operacion'   = ' '
      ,      'Operacion'        = 0
      ,      'glosa_operacion'  = ' '
      ,      'Rut'              = 0
      ,      'Dv'               = ' '
      ,      'Nom'              = ' '
      ,      'Descripcion'      = ' ' 
      FROM   #parametros          
   END
END

GO
