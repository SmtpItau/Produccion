USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RUEBA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RUEBA]
                        ( @fecha_hoy DATETIME)
AS 
BEGIN
DECLARE @registros INTEGER
SET NOCOUNT OFF

CREATE TABLE #TEMP
  ( tipoper CHAR(06) , 
   num     NUMERIC(10,0) IDENTITY (1,1) )
 INSERT INTO #TEMP
 SELECT DISTINCT tipo_operacion
 FROM  BAC_CNT_VOUCHER
 WHERE  Fecha_Ingreso = @Fecha_Hoy

CREATE TABLE 
 #MOVCONT(
  tipovoucher CHAR(06)   ,
  numerovoucher NUMERIC(10,0)    ,
  numcuenta CHAR(20)   ,
  tipomonto CHAR(01)   ,
  montocuenta FLOAT    
  )
 INSERT INTO 
 #MOVCONT(
  tipovoucher ,
  numcuenta ,
  tipomonto ,
  montocuenta 
  )
 SELECT  b.tipo_operacion,
  cuenta   ,
  tipo_monto , 
  SUM(monto) 
 FROM  BAC_CNT_DETALLE_VOUCHER A, 
  BAC_CNT_VOUCHER b
 WHERE  a.numero_voucher = b.numero_voucher
 AND  b.Fecha_Ingreso  = @Fecha_Hoy
 GROUP BY b.tipo_operacion, a.cuenta , a.tipo_monto
 UPDATE #movcont SET numerovoucher =  #TEMP.num
 FROM  #TEMP
 WHERE #TEMP.tipoper = #MOVCONT.tipovoucher
 SELECT @Registros = COUNT(*) FROM #movcont 
 SELECT  @registros ,
  numerovoucher ,
  numcuenta ,
  tipomonto ,
  montocuenta ,
  VIEW_MOVIMIENTO_CNT.tipo_voucher_contab   
 FROM #movcont a, view_Movimiento_cnt
  WHERE a.tipovoucher = view_Movimiento_cnt.tipo_operacion
END

GO
