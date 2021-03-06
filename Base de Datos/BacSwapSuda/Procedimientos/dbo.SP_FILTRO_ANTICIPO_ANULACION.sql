USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_ANTICIPO_ANULACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_FILTRO_ANTICIPO_ANULACION]
AS
BEGIN

   SET NOCOUNT ON 
   
   DECLARE @fecha_Hoy             DATETIME
       SET @fecha_Hoy             = (SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock))

   SELECT DISTINCT 
          'Estado'                = Estado
      ,   'Swap'                  = CASE WHEN Tipo_Swap = 1 THEN 'TASA           '
                                         WHEN Tipo_Swap = 2 THEN 'MONEDA         '
                                         WHEN Tipo_Swap = 3 THEN 'FRA            '
                                         ELSE                    'PROMEDIO CAMARA'
                                    END
      ,   'Numero_Operacion'      = Numero_Operacion
      ,   'Codigo_Cliente'        = clcodigo
      ,   'rut_cliente'           = clrut
      ,   'Nombrecli'             = isnull(clnombre, '')
      ,   'NombreOp'	          = CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END
      ,   'Monto_Saldo_Recibimos' = Compra_capital
      ,   'Monto_Amortiza_Recibimos' = compra_amortiza
      ,   'Moneda_Compra'         = ISNULL((SELECT mnglosa FROM VIEW_MONEDA WHERE mncodmon = compra_moneda), ' ')
      ,   'Monto_Saldo_Pagamos'   = Venta_capital
      ,   'Monto_Amortiza_Pagamos'= Venta_amortiza 
      ,   'tipo_Flujo'            = tipo_Flujo
      ,   'Moneda_Venta'          = ISNULL((SELECT mnglosa FROM VIEW_MONEDA WHERE mncodmon = venta_moneda), ' ')
      INTO #Tabla
   FROM    BacSwapSuda.dbo.CARTERA_UNWIND
           INNER JOIN (SELECT Documento = numero_operacion, Flujo = MIN(numero_flujo), Tipo = tipo_flujo
                         FROM BacSwapSuda.dbo.CARTERA_UNWIND
                     GROUP BY numero_operacion, tipo_flujo) dis ON dis.Documento = numero_operacion and dis.Tipo = tipo_flujo
           LEFT JOIN BacParamSuda.dbo.CLIENTE                   ON clrut         = rut_cliente      and clcodigo = codigo_cliente
   WHERE   FechaAnticipo = @fecha_Hoy
   ORDER BY Numero_Operacion


   SELECT Estado
      ,   Swap
      ,   Numero_Operacion
      ,   Codigo_Cliente
      ,   rut_cliente
      ,   Nombrecli
      ,   NombreOp
      ,   Moneda_Compra
      ,   Moneda_Venta
      ,  'Monto_Saldo_Recibimos'   = SUM(Monto_Saldo_Recibimos)
      ,  'Monto_Amortiza_Recibimos'= SUM(Monto_Amortiza_Recibimos)
      ,  'Monto_Saldo_Pagamos'     = SUM(Monto_Saldo_Pagamos)
      ,  'Monto_Amortiza_Pagamos'  = SUM(Monto_Amortiza_Pagamos )
   FROM  #Tabla
    GROUP BY Estado, Swap,Numero_Operacion , Codigo_Cliente, rut_cliente, Nombrecli, NombreOp ,Moneda_Compra, Moneda_Venta

END
GO
