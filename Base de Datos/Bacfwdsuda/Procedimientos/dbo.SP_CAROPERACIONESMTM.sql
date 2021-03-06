USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAROPERACIONESMTM]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CAROPERACIONESMTM]
AS
BEGIN
SET NOCOUNT ON
   DECLARE @dfecproc    DATETIME
   DECLARE @cnomprop    CHAR(40)
   DECLARE @cdirprop    CHAR(40)
   SELECT @dfecproc = acfecproc  ,
          @cnomprop = (Select rcnombre from VIEW_ENTIDAD),
          @cdirprop = (Select rcdirecc from VIEW_ENTIDAD)
     FROM MFAC
   /*=======================================================================*/
   /*=======================================================================*/
   SELECT 'NroOperacion' = a.canumoper                             ,  -- 1
          'NomCliente'   = b.clnombre                              ,  -- 2
          'TipoOperacion'= a.catipoper                             ,  -- 3
          'FechaVcto'    = CONVERT( CHAR(10), a.cafecvcto, 103 )   ,  -- 4
          'MonedaConver' = c.mnnemo                                ,  -- 5
          'MontoOrigen'  = a.camtomon1                             ,  -- 6
          'FechaCompra'  = CONVERT(CHAR(10),a.cafecha, 103 )       ,  -- 7
          'PlazoResidual'= DATEDIFF( day, @dfecproc, a.cafecvcto ) ,  -- 8
          'Precio'       = a.catipcam                              ,  -- 9
   'MontoMTM'  = a.camarktomarket      ,  -- 10
   'PrecioFwdMTM' = a.capreciomtm           ,  -- 11
   'FechaProceso' = CONVERT(CHAR(10),@dfecproc, 103 )       ,  -- 12
          'NombrePropie' = @cnomprop                               ,  -- 13
          'DireccPropie' = @cdirprop       ,  -- 14
   'MontoCNV'     = a.camtomon2                             ,  -- 15
   'DolarObserv'  = d.vmvalor                               ,  -- 16
   'UFhoy'        = e.vmvalor                               ,  -- 17
          'Cartera'      = a.cacodpos1                             ,  -- 18
          'CodMoneda'    = a.cacodmon2                             ,  -- 19
          'ValorPte_P_L' = a.camarktomarket                        ,  -- 20
          'CodMonedaOri' = f.mnnemo                         ,  -- 21
   'Hora'  = CONVERT(CHAR(08),GETDATE(),108)
     INTO #Temp
     FROM MFCA                    a,
          VIEW_CLIENTE b,
          VIEW_MONEDA  c,
          VIEW_MONEDA  f,
          VIEW_VALOR_MONEDA d,
   VIEW_VALOR_MONEDA e
    WHERE a.cacodpos1 IN (1,2,3)
      AND a.cacodigo  = b.clrut 
      AND a.cacodcli  = b.clcodigo
      AND a.cacodmon2 = c.mncodmon
      AND a.cacodmon1 = f.mncodmon
      AND a.cafecvcto <> @dfecproc
      AND 994         = d.vmcodigo
      AND @dfecproc   = d.vmfecha
      AND 998         = e.vmcodigo
      AND @dfecproc   = e.vmfecha
    ORDER BY a.canumoper
    ----<< Actualiza P & L descontado (MTM a la fecha)
    UPDATE #Temp 
       SET ValorPte_P_L = ROUND( ValorPte_P_L / 
                          ( 1 + (CASE WHEN CodMoneda = 998 THEN ISNULL(    UF, 1.0) / 360.
                                      WHEN CodMoneda = 999 THEN ISNULL(   CLP, 1.0) /  30.
                                      ELSE ISNULL(LIBOR, 1.0) + ISNULL(SPREAD, 1.0) / 360. END) * PlazoResidual ), 0)
                                    
      FROM VIEW_TASA_FWD
     WHERE PlazoResidual >= Plazo_Ini
       AND PlazoResidual <= Plazo_Fin               
   SELECT *  FROM #Temp  ORDER BY Cartera, NroOperacion
   SET NOCOUNT OFF
   RETURN 0
END

GO
