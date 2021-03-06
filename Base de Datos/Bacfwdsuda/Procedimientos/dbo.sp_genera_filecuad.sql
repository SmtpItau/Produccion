USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_genera_filecuad]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_genera_filecuad]
AS
BEGIN
   SET NOCOUNT ON
   SELECT          'Cuenta' = a.Cuenta,
                   'Moneda' = a.moneda,
--                   'Monto'  = ABS( SUM( ISNULL( (CASE a.Tipo_Monto WHEN "D" THEN a.Monto ELSE a.Monto * -1 END), 0.0 ) ) )
--                   'Monto'   =  SUM( ISNULL( (CASE WHEN a.Tipo_Monto="D" THEN (case when left(a.cuenta,1)=4  then a.Monto*-1 else a.monto end) ELSE 0 END), 0.0 ) ) ,
--                   'MontoH'  =  SUM( ISNULL( (CASE WHEN a.Tipo_Monto="H" THEN(case when left(a.cuenta,1)=4   then a.monto else a.Monto*-1 end) ELSE 0 END), 0.0 ) ) 
                   'Monto'   =  SUM( ISNULL( (CASE WHEN a.Tipo_Monto="D" THEN (case when c.tipo="P" then a.Monto*-1 else a.monto end) ELSE 0 END), 0.0 ) ) ,
                   'MontoH'  =  SUM( ISNULL( (CASE WHEN a.Tipo_Monto="H" THEN(case when  c.tipo="P" then a.monto else a.Monto*-1 end) ELSE 0 END), 0.0 ) ) 
                   INTO     #tmpfilecuad
          FROM     bac_cnt_detalle_voucher_fc a, bac_cnt_voucher_fc b, cuentas c,MFAC d
          WHERE    a.numero_voucher = b.numero_voucher AND a.cuenta = c.cuenta  --and d.acfecproc=b.FECHA_INGRESO
          GROUP BY a.cuenta, a.moneda
   SELECT       'Campo1' = "FW", 
                'Campo2' = 0, 
                'Moneda' = case when b.moneda=0 then  999 else  ISNULL( b.Moneda, 0 ) end , 
                'Cuenta' = a.Cuenta, 
              --  'Monto'  = ISNULL( b.Monto, 0.0 ),
              --  'Montoh' = ISNULL( b.Montoh, 0.0 ),
              --  'Montosuma' = ISNULL(  b.Montoh + b.monto    , 0.0 )
                'Monto' = ISNULL(  b.Montoh + b.monto    , 0.0 )
          FROM  cuentas a, #tmpfilecuad b 
          WHERE a.cuenta   = b.cuenta 
          ORDER BY a.cuenta, b.moneda        
   SET NOCOUNT OFF
END
GO
