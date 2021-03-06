USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOVIMIENTOFRA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MOVIMIENTOFRA]  
				@Cartera Integer	
AS

Declare @Glosa_Cartera 	Char (20)

Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'PCS'
     And  rcrut     = @Cartera
	--ORDER BY rcrut  

  if @Glosa_Cartera = '' 
	Select @Glosa_Cartera = '< TODAS >'  

SELECT 'Nro'     = m.numero_operacion       ,
       'Cartera' = (SELECT Distinct IsNull(rcnombre,'') FROM BacParamSuda..TIPO_CARTERA WHERE rcsistema = 'PCS' And  rcrut = cartera_inversion),
       'Tipo'    = m.Tipo_Operacion         ,
       'Rut'     = ISNULL(m.rut_cliente,'0') ,
       'DV'      = ISNULL(b.cldv,'') ,
       'Cliente' = ISNULL(b.clnombre,'')  ,
       'Cierre'  = CONVERT(CHAR(10),m.fecha_cierre      ,103),
       'Fijacion'= CONVERT(CHAR(10),m.fecha_inicio_flujo,103),
       'Liquida' = CONVERT(CHAR(10),m.fecha_vence_flujo ,103),
       'CodMon'  = m.compra_moneda ,
       'Moneda'  = ISNULL(c.mnnemo, CONVERT(CHAR(5),m.compra_moneda)),
       'Capital' = m.compra_capital         ,
       'Tasa'    = ISNULL(SUBSTRING(d.tbglosa,1,15), CONVERT(CHAR(10),m.compra_codigo_tasa)),
       'Valor'   = m.compra_valor_tasa      ,
       'Periodo' = ISNULL(SUBSTRING(e.glosa  ,1,15), CONVERT(CHAR(10),m.compra_codamo_interes)),
       'FPago'   = ISNULL(f.glosa2, CONVERT(CHAR(10),m.pagamos_documento)),
       'Trader'  = m.operador,   
       'NombreBco'= ISNULL(p.Nombre ,'***'),
       'Hora'	=  CONVERT (CHAR (8) , getdate(),114),		
       'FechaProc'= CONVERT (CHAR (10) , p.fechaproc ,103)		             ,
       'Tipo_Cartera' =  @Glosa_Cartera

  FROM Cartera     		     m
       LEFT JOIN view_cliente                b ON m.codigo_cliente  = b.clcodigo  AND m.rut_cliente         = b.clrut	
       LEFT JOIN view_moneda                 c ON compra_moneda     = c.mncodmon
       LEFT JOIN view_tabla_general_detalle  d ON d.TBCATEG         = 1042        AND compra_codigo_tasa    = d.TBCODIGO1   -- Tasas
       LEFT JOIN View_Periodo_Amortizacion 	 e ON e.tabla           = 1044        AND compra_codamo_interes = e.codigo   -- Amortizacion de Intereses
       LEFT JOIN view_forma_de_pago          f ON pagamos_documento = f.codigo,   -- Formas de Pago
       SwapGeneral 			 p    -- Parametros

 WHERE tipo_swap = 3
   AND fecha_cierre = CONVERT(CHAR(8),p.fechaproc,112)
   And   (cartera_inversion = @Cartera Or @Cartera = 0)
GO
