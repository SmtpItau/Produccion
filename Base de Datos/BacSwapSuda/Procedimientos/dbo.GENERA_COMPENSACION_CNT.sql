USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_COMPENSACION_CNT]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GENERA_COMPENSACION_CNT]  
	(   @Fecha_Vencimiento   DATETIME   )  
AS  
BEGIN  
  
  --declare @Fecha_Vencimiento DATETIME
  --SET @Fecha_Vencimiento = '20141016'
  -- delete BAC_CNT_CONTABILIZA   -- select * from BAC_CNT_CONTABILIZA
  -- GENERA_COMPENSACION_CNT '20150623'
 SET NOCOUNT ON     
  

  
  INSERT INTO BAC_CNT_CONTABILIZA  
   (   id_sistema  
   ,   tipo_movimiento  
   ,   tipo_operacion  
   ,   operacion  
   ,   correlativo  
   ,   codigo_instrumento  
   ,   moneda_instrumento  
   ,   tipo_cliente  
   ,   cartera_inversion  
  ,   Compra_Amortiza  
   ,   Compra_Saldo  
   ,   Venta_Amortiza  
   ,   Venta_Saldo  
   ,   Monto_Utilidad_Valoriza  -- <-- Mpago
   ,   Monto_Perdida_Valoriza   -- <-- MPago
   ,   Forma_de_Pago       
   ,   TipOper             
   ,   Recibimos_Monto_Clp -- <--  ML
   ,   Pagamos_Monto_Clp   -- <--  ML
   )     
   SELECT Sistema                           = 'PCS'  
   ,      TipoMovimiento                    = 'VFL'  
   ,      TipoOperacion                     = CONVERT(CHAR(2),'V' + LTRIM(RTRIM(Producto)))  
   ,      NumeroOperacion                   = Numero_Operacion  
   ,      Correlativo                       = Correlativo  + case when VctoNatural_Anticipo = 'ANTICIPO' then 1 else 0 end   
   ,      Instrumento                       = CASE WHEN Producto = '4' THEN 
                                                                         isnull( 
																		            CONVERT(CHAR(3), Caj.Compra_moneda   
																					               + Caj.venta_moneda * ( case when Caj.Compra_moneda  <> 0 then 0 else 1 end  ) )
																		          , '999' )
    
                                               ELSE '' END -- MAP 20081003 Para permitir distingir según moneda capital    
																            -- select * from BacParamSuda.dbo.TBL_CAJA_DERIVADOS where producto = 4                                                 
																			

   ,      Moneda                            = MonedaM1  
   ,      TipoCliente                       = case when Cli.CltipCli IN(10,11,12,13) then 3 else Cli.CltipCli end   
   ,      Cartera                           = 0 -- Al final no se utiliza  
   ,     'NN Amortizacion Mon Pago Compra' = 0.0 --AMonPagoCom  
   ,     'NN Interes Mon Pago Compra'      = 0.0 --IMonPagoCom  
   ,     'NN Amortizacion Mon Pago Venta'  = 0.0 --AMonPagoVta  
   ,     'NN Interes Mon Pago Venta'     = 0.0 --IMonPagoVta  

   ,     'NN Utilidad Real del Swap'       = CASE WHEN MontoM1 >= 0.0 THEN ABS(MontoM1) ELSE 0.0 END  												
   ,     'NN Perdida Real del Swap'        = CASE WHEN MontoM1 <  0.0 THEN ABS(MontoM1) ELSE 0.0 END  

   ,     'Forma_de_Pago'                   = FormaPago1   
   ,     'TipOper'                         = 'V'  

   ,     'NN Utilidad Real Swap ML'        = round( case when MontoM1Local > 0 then MontoM1Local else 0 end , 0 ) 											
   ,     'NN Perdida  Real Swap ML'        = round( case when MontoM1Local < 0 then -MontoM1Local else 0 end, 0 ) 
     from BacParamSuda.dbo.TBL_CAJA_DERIVADOS Caj	      
		  left join bacparamSuda.dbo.cliente Cli on Cli.Clrut = Rut_Contraparte and Cli.ClCodigo = Codigo_Contraparte   
	   where fechaLiquidacion = @Fecha_Vencimiento
	      and caj.Modalidad_Pago = 'C'
 
END
/*
select * from bacswapsuda.dbo.BAC_CNT_CONTABILIZA where tipo_movimiento = 'VFL' and operacion in ( 1037, 10662, 10717,  10713 )

select * from errores
*/

GO
