USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[PRUEBA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PRUEBA]
as
begin

SELECT    'cuenta'     = B.Cuenta
 --        ,'moneda'     = B.Moneda
         ,'operacion'  = A.Operacion
         ,'tipo_vou'   = A.TIPO_Voucher
         ,'MONTO'      = B.MONTO
         ,'TIPO'       = B.Tipo_Monto
         ,'fecha'      = A.fecha_ingreso
      INTO #TEMPORAL
      FROM  BAC_CNT_VOUCHER A,BAC_CNT_DETALLE_VOUCHER B 
      WHERE A.numero_voucher  = B.numero_voucher    and 
            A.fecha_ingreso   = '20030221' 
--            C.cpnumdocu       = A.operacion 
--            C.cpfecven         > '20030221'

select * from #TEMPORAL
--select * from mdcp
   SELECT 'cuenta1'   = cuenta,
 --         'moneda1'   = moneda,
          'operacion1'= operacion,
          'tipo_vou1' = tipo_vou,
          'saldo'     = ISNULL((SELECT SUM(MONTO) FROM #TEMPORAL B WHERE B.TIPO= 'H' AND B.OPERACION = A.OPERACION AND B.CUENTA = A.CUENTA GROUP BY B.CUENTA,B.TIPO,B.OPERACION),0)- ISNULL((SELECT SUM(MONTO) FROM #TEMPORAL C WHERE C.TIPO= 'D' 
		AND C.OPERACION = A.OPERACION AND C.CUENTA = A.CUENTA GROUP BY C.CUENTA,C.TIPO,C.OPERACION),0),
          'fecha'     = fecha
          INTO #TEMPORAL1
          FROM #TEMPORAL A
          group by cuenta,operacion,tipo_vou,fecha ORDER BY operacion

SELECT * FROM #TEMPORAL

end

GO
