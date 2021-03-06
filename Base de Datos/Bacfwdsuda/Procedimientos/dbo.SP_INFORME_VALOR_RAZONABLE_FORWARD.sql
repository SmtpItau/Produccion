USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_VALOR_RAZONABLE_FORWARD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INFORME_VALOR_RAZONABLE_FORWARD]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso DATETIME

       SET @dFechaProceso = (SELECT acfecproc FROM BacFwdSuda..MFAC with(nolock))

   SELECT 'Operacion'   = canumoper
   ,      'Producto'    = cacodpos1
   ,      'Descripcion' = CONVERT(CHAR(25),p.descripcion)
   ,      'Moneda'      = cacodmon1
   ,      'NemoMon'     = m.mnnemo
   ,      'MonedaCnv'   = cacodmon2
   ,      'Tipo'        = CASE WHEN catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
   ,      'Modalidad'   = CASE WHEN catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END 
   ,      'Cliente'     = c.clnombre
   ,      'vRazonable'  = fres_obtenido
   ,      'vValor'      = CASE WHEN cacodpos1 IN(10,11) THEN catasa_efectiva_moneda1 ELSE fval_obtenido END
   ,      'TasaM1'      = CONVERT(NUMERIC(21,4),catasasinteticam1)
   ,      'TasaM2'      = CONVERT(NUMERIC(21,4),catasasinteticam2)
   ,      'TEfectivaM1' = CONVERT(NUMERIC(21,4),catasadolar) --> catasaEfectMon1)   
   ,      'TEfectivaM2' = CONVERT(NUMERIC(21,4),catasaufclp) --> catasaEfectMon2)
   ,      'PlazoRes'    = DATEDIFF(DAY, @dFechaProceso, cafecEfectiva) --cafecvcto)
   ,      'FechaProceso'= CONVERT(CHAR(10),@dFechaProceso,103)
   ,      'FechaEmision'= CONVERT(CHAR(10),GETDATE(),103)
   ,      'HoraEmision' = CONVERT(CHAR(10),GETDATE(),108)
   ,      'FechaOp'     = CONVERT(CHAR(10),cafecha,103)
   ,      'Curva Activo'= CASE WHEN catipoper = 'C' THEN caOrgCurvaMon ELSE caOrgCurvaCnv END
   ,      'Curva Pasivo'= CASE WHEN catipoper = 'C' THEN caOrgCurvaCnv ELSE caOrgCurvaMon END
   ,      'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
   FROM   BacFwdSuda..MFCA                    with(nolock)
          INNER JOIN BacParamSuda..CLIENTE  C with(nolock) ON cacodigo     = c.clrut AND cacodcli = c.clcodigo
          INNER JOIN BacParamSuda..PRODUCTO P with(nolock) ON p.id_sistema = 'BFW' AND cacodpos1 = p.codigo_producto
          INNER JOIN BacParamSuda..MONEDA   M with(nolock) ON m.mncodmon   = cacodmon1
   WHERE  cafecha      <= @dFechaProceso
	AND caantici <> 'A'
	and cafecvcto > @dFechaProceso
   ORDER BY cacodpos1, cacodigo, cacodcli, catipoper, canumoper, catipmoda

END





GO
