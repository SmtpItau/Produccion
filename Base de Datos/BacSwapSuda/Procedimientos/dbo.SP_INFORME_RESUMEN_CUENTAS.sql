USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_RESUMEN_CUENTAS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_RESUMEN_CUENTAS]
   (   @FechaIngreso   DATETIME   
   ,   @cUsuario       VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @FechaProceso   CHAR(10)
   ,       @FechaEmision   CHAR(10)
   ,       @HoraEmision    CHAR(10)

   SELECT  @FechaProceso   = CONVERT(CHAR(10),fechaproc,103)
   ,       @FechaEmision   = CONVERT(CHAR(10),GETDATE(),103)
   ,       @HoraEmision    = CONVERT(CHAR(10),GETDATE(),108)
   FROM    SWAPGENERAL

   SELECT CONVERT(CHAR(16),d.Cuenta)                                                     as Cuenta
   ,      CONVERT(CHAR(40),ISNULL(c.descripcion,'Cta. No Existe en Plan de Ctas'))       as Glosa
   ,      CONVERT(NUMERIC(21,4),0.0)                                                     as MontoDebe
   ,      CONVERT(NUMERIC(21,4),0.0)                                                     as MontoHaber
   ,      Identity(Int)                                                                  as Correlativo
   INTO   #RESUMEN_CUENTAS
   FROM   BAC_CNT_VOUCHER v
          INNER JOIN BAC_CNT_DETALLE_VOUCHER       d ON v.Numero_Voucher = d.Numero_Voucher
          LEFT  JOIN BacParamSuda..PLAN_DE_CUENTA  c ON c.cuenta         = d.Cuenta
   WHERE  v.Fecha_Ingreso = @FechaIngreso
   GROUP BY d.Cuenta , c.descripcion

   SELECT d.Cuenta        AS CtaDebito
   ,      SUM(d.Monto)    AS Debe
   INTO   #DEBE
   FROM   BAC_CNT_VOUCHER v
          INNER JOIN BAC_CNT_DETALLE_VOUCHER d ON v.Numero_Voucher = d.Numero_Voucher
   WHERE  v.Fecha_Ingreso = @FechaIngreso
   AND    d.Tipo_Monto    = 'D'
   GROUP BY d.Cuenta

   SELECT d.Cuenta        AS CtaCredito
   ,      SUM(d.Monto)    AS Haber
   INTO   #HABER
   FROM   BAC_CNT_VOUCHER v
          INNER JOIN BAC_CNT_DETALLE_VOUCHER d ON v.Numero_Voucher = d.Numero_Voucher
   WHERE  v.Fecha_Ingreso = @FechaIngreso
   AND    d.Tipo_Monto    = 'H'
   GROUP BY d.Cuenta

   UPDATE #RESUMEN_CUENTAS
   SET    MontoDebe   = Debe
   FROM   #DEBE
   WHERE  Cuenta      = CtaDebito

   UPDATE #RESUMEN_CUENTAS
   SET    MontoHaber  = Haber
   FROM   #HABER
   WHERE  Cuenta      = CtaCredito

	IF EXISTS( SELECT (1) FROM #RESUMEN_CUENTAS)    
    BEGIN    
	   SELECT 'Cuanta'       = Cuenta
	   ,      'GlosaCta'     = Glosa
	   ,      'MontoDebe'    = MontoDebe
	   ,      'MontoHaber'   = MontoHaber
	   ,      'FechaProceso' = @FechaProceso
	   ,      'FechaEmision' = @FechaEmision
	   ,      'HoraEmision'  = @HoraEmision
	   ,      'Usuario'      = @cUsuario
	   ,      'FechaDatos'   = CONVERT(CHAR(10),@FechaIngreso,103)
	   ,      'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
	   FROM   #RESUMEN_CUENTAS  
    END ELSE    
    BEGIN    
	   SELECT 'Cuanta'       = ''
	   ,      'GlosaCta'     = ''
	   ,      'MontoDebe'    = 0
	   ,      'MontoHaber'   = 0
	   ,      'FechaProceso' = @FechaProceso
	   ,      'FechaEmision' = @FechaEmision
	   ,      'HoraEmision'  = @HoraEmision
	   ,      'Usuario'      = @cUsuario
	   ,      'FechaDatos'   = CONVERT(CHAR(10),@FechaIngreso,103)
	   ,      'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
	END
END

GO
