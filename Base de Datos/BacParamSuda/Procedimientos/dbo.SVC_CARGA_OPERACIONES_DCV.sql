USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_CARGA_OPERACIONES_DCV]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SVC_CARGA_OPERACIONES_DCV]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = ( SELECT acfecproc FROM BacfwdSuda.dbo.MFAC with(nolock) )

   DELETE FROM dbo.TBL_ARCHIVOS_DCV
         WHERE Estado       = 'P'
--         AND Fecha        = @dFechaProceso

   INSERT INTO dbo.TBL_ARCHIVOS_DCV
   SELECT Fecha				= seg.cafecha
      ,   Modulo            = 'BFW'
      ,   Producto          = 12
      ,   Contrato          = seg.var_moneda2
      ,   Estado            = 'P'
      ,   RutCliente        = seg.cacodigo
      ,   CodCliente        = seg.cacodcli
      ,   Moneda            = arb.cacodmon1
      ,   MonedaCnv         = seg.cacodmon2
      ,   fPago             = arb.cafpagomx
      ,   Monto             = arb.camtomon1
      ,   Precio            = seg.catipcam
      ,   FechaVcto         = seg.cafecvcto
      ,   IdGrupo           = 0
      ,   EstadoGrupo       = ''
      ,   Reservado         = ''
	 FROM BacFwdSuda.dbo.MFCA							seg
		  INNER JOIN BacFwdSuda.dbo.MFCA				arb ON arb.canumoper	 = seg.var_moneda2 AND arb.cacodpos1 = 2
		  INNER JOIN BacParamSuda.dbo.FPAGO_CODIGO_DCV fpag ON fpag.fPago		 = arb.cafpagomx
          LEFT  JOIN (SELECT Modulo, Producto, Contrato
						FROM dbo.TBL_ARCHIVOS_DCV) Cargados ON Cargados.Modulo   = 'BFW'
                                                           AND Cargados.Producto = 12
                                                           AND Cargados.Contrato = seg.var_moneda2
	WHERE seg.var_moneda2  <> 0
	  AND seg.caestado      = ''
	  AND seg.cacodpos1		= 1

   INSERT INTO dbo.TBL_ARCHIVOS_DCV
   SELECT Fecha             = car.cafecha
      ,   Modulo            = 'BFW'
      ,   Producto          = car.cacodpos1
      ,   Contrato          = car.canumoper
      ,   Estado            = 'P'
      ,   RutCliente        = car.cacodigo
      ,   CodCliente        = car.cacodcli
      ,   Moneda            = car.cacodmon1
      ,   MonedaCnv         = car.cacodmon2
      ,   fPago             = car.cafpagomn
      ,   Monto             = car.camtomon1
      ,   Precio            = car.catipcam
      ,   FechaVcto         = car.cafecvcto
      ,   IdGrupo           = 0
      ,   EstadoGrupo       = ''
      ,   Reservado         = ''
    FROM  BacFwdsuda.dbo.MFCA                          car
          INNER JOIN BacParamSuda.dbo.FPAGO_CODIGO_DCV fpag ON fpag.fPago = car.cafpagomn
          LEFT  JOIN (SELECT Modulo, Producto, Contrato FROM dbo.TBL_ARCHIVOS_DCV) Cargados ON Cargados.Modulo   = 'BFW'
                                                                                           AND Cargados.Producto = car.cacodpos1
                                                                                           AND Cargados.Contrato = car.canumoper
   WHERE  car.caestado      = ''
     AND  Cargados.Contrato IS NULL
     AND  car.var_moneda2   = 0
--   AND  car.cafecha       = @dFechaProceso

   UNION

   SELECT Fecha              = Mod.cafecha
      ,   Modulo             = 'BFW'
      ,   Producto           = Mod.cacodpos1
      ,   Contrato           = Mod.canumoper
      ,   Estado             = 'P'
      ,   RutCliente         = Mod.cacodigo
      ,   CodCliente         = Mod.cacodcli
      ,   Moneda             = Mod.cacodmon1
      ,   MonedaCnv          = Mod.cacodmon2
      ,   fPago              = Mod.cafpagomn
      ,   Monto              = Mod.camtomon1
      ,   Precio             = Mod.catipcam
      ,   FechaVcto          = Mod.cafecvcto
      ,   IdGrupo            = 0
      ,   EstadoGrupo        = ''
      ,   Reservado          = ''
    FROM  BacFwdsuda.dbo.MFCA_LOG                       Mod
          INNER JOIN BacParamSuda.dbo.FPAGO_CODIGO_DCV fpag ON fpag.fPago    = Mod.cafpagomn
          INNER JOIN BacFwdSuda.dbo.MFCA car                ON car.canumoper = Mod.canumoper
           LEFT JOIN (SELECT Modulo, Producto, Contrato FROM dbo.TBL_ARCHIVOS_DCV) Cargados ON Cargados.Modulo   = 'BFW'
                                                                                           AND Cargados.Producto = Mod.cacodpos1
                                                                                           AND Cargados.Contrato = Mod.canumoper

   WHERE Mod.caestado           = ''
    AND  Cargados.Contrato IS NULL
    AND  car.var_moneda2	= 0
--  AND  Mod.cafecmod           = @dFechaProceso

   SELECT * FROM dbo.TBL_ARCHIVOS_DCV

END

GO
