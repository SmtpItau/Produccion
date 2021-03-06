USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFVOUCHERS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFVOUCHERS] 
				(
				 @Fecha    Char(8),
				 @Fechatit Char(10)
				)
AS
BEGIN

   SELECT a.Numero_Voucher,
          a.Correlativo   ,
          a.Cuenta        ,
          a.Tipo_Monto    ,
          a.Monto         ,
          b.Tipo_Voucher          ,
          b.Tipo_Operacion        ,
          b.Operacion             ,
          'glosa'  = SUBSTRING(b.Glosa,1,50) +  STR(b.Operacion)   ,
          'Rut'    = d.rut     ,
          'Nombre' = d.nombre  ,
          Descripcion ,
	  Fecha    = @Fechatit
     INTO #VOUCHERS
     FROM bac_cnt_detalle_voucher  a
	      LEFT JOIN View_Plan_de_Cuenta  c ON a.Cuenta = c.Cuenta ,    
          bac_cnt_voucher         	b,
          SwapGeneral             	d
    WHERE Fecha_Ingreso = @Fecha AND 
          a.Numero_Voucher = b.Numero_Voucher 
    ORDER BY a.Numero_Voucher

    IF (SELECT COUNT(*) FROM #VOUCHERS) = 0
       INSERT INTO #VOUCHERS VALUES(0,0,'','',0,'','',0,'',0,'','','')

    SELECT *, 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) FROM #VOUCHERS

END

GO
