USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEROPERACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEEROPERACION]  
       (
        @numoper	NUMERIC (09),
        @tipoper	NUMERIC (03)
       )
AS
BEGIN

   /*=======================================================================*/
   /*=======================================================================*/
   DECLARE @encabezado	VARCHAR(5000)
   DECLARE @final	VARCHAR(30)


SET NOCOUNT ON         --ADO

   /*=======================================================================*/
   /* Encabezado de la Consulta						    */	
   /*=======================================================================*/
   SELECT @encabezado = 'SELECT '  
		+ ' numero_operacion   ,'  
		+ ' numero_flujo       ,'  
		+ ' tipo_swap    ,'  
		+ ' cartera_inversion  ,'  
		+ ' tipo_operacion ,'  
		+ ' codigo_cliente ,'  	
		+ ' Nombrecli  = ISNULL((SELECT clnombre FROM '  
							+ ' view_cliente WHERE clcodigo = codigo_cliente '  
							+ 'AND clrut = rut_cliente ),'+'''**'''+'), '  
		+ ' CONVERT(CHAR(10), fecha_cierre, 103),'  
		+ ' CONVERT(CHAR(10), fecha_inicio, 103),'       
		+ ' CONVERT(CHAR(10), fecha_termino, 103),'  
		+ ' CONVERT(CHAR(10), fecha_inicio_flujo, 103),'     
		+ ' CONVERT(CHAR(10), fecha_vence_flujo, 103),'     
		+ ' compra_moneda ,'  
		+ ' compra_capital ,'  
		+ ' compra_amortiza ,'  
		+ ' compra_saldo ,'  
		+ ' compra_interes ,'  
		+ ' compra_spread ,'  
		+ ' compra_codigo_tasa ,'  
		+ ' compra_valor_tasa ,'  
		+ ' compra_valor_tasa_hoy,'  
		+ ' compra_codamo_capital,'  
		+ ' compra_mesamo_capital,'  
		+ ' compra_codamo_interes,'  
		+ ' compra_mesamo_interes,'  
		+ ' compra_base  ,'  
		+ ' venta_moneda ,'  
		+ ' venta_capital ,'  
		+ ' venta_amortiza ,'  
		+ ' venta_saldo  ,'  
		+ ' venta_interes ,'  
		+ ' venta_spread ,'  
		+ ' venta_codigo_tasa ,'  
		+ ' venta_valor_tasa ,'  
		+ ' venta_valor_tasa_hoy,'  
		+ ' venta_codamo_capital,'  
		+ ' venta_mesamo_capital,'  
		+ ' venta_codamo_interes,'  
		+ ' venta_mesamo_interes,'  
		+ ' venta_base  ,'  
		+ ' operador  ,'  
		+ ' operador_cliente ,'  
		+ ' estado_flujo ,'  
		+ ' modalidad_pago ,'  
		+ ' pagamos_moneda ,'  
		+ ' pagamos_documento ,'  
		+ ' pagamos_monto ,'  
		+ ' pagamos_monto_USD ,'  
		+ ' pagamos_monto_CLP ,'  
		+ ' recibimos_moneda ,'  
		+ ' recibimos_documento ,'  
		+ ' recibimos_monto ,'  
		+ ' recibimos_monto_USD ,'  
		+ ' recibimos_monto_CLP ,'  
		+ ' observaciones ,'  
		+ ' CONVERT(CHAR(10), fecha_modifica, 103), '  
		+ ' rutcli  = (CONVERT ( CHAR ( 9 ), rut_cliente )) + '+'''-''' 	+ ' 	+   ISNULL((SELECT  C.cldv '  
					+ ' FROM view_cliente C WHERE C.clcodigo = codigo_cliente AND C.clrut = rut_cliente ),'+'''*'''+'),'  
		+ ' tipo_flujo ,'    
		+ ' especial ,'  
		+ ' CONVERT(CHAR(10), fecha_fijacion_tasa, 103) ,'



    /***********************************/
    /*              Tabla              */
    /***********************************/
    IF @tipoper = 1  BEGIN --Tabla Movimiento diario 
 SELECT @encabezado = @encabezado + '  mov_area_responsable , '  
 SELECT @encabezado = @encabezado + '  mov_cartera_normativa  ,'  
 SELECT @encabezado = @encabezado + '  mov_subcartera_normativa , '  
 SELECT @encabezado = @encabezado + '  mov_libro '  

 SELECT @encabezado = @encabezado + ' FROM MovDiario '   

    END ELSE IF @tipoper = 2 BEGIN  -- Tabla Movimiento Historico
 SELECT @encabezado = @encabezado + '  mhi_area_responsable , '  
 SELECT @encabezado = @encabezado + '  mhi_cartera_normativa  ,'  
 SELECT @encabezado = @encabezado + '  mhi_subcartera_normativa , '  
 SELECT @encabezado = @encabezado + '  mhi_libro '  

 SELECT @encabezado = @encabezado + ' FROM MovHistorico '  

    END ELSE IF @tipoper = 3 BEGIN  -- Tabla Cartera
 SELECT @encabezado = @encabezado + '  car_area_responsable , '  
 SELECT @encabezado = @encabezado + '  car_cartera_normativa  ,'  
 SELECT @encabezado = @encabezado + '  car_subcartera_normativa , '  
 SELECT @encabezado = @encabezado + '  car_libro '  

 SELECT @encabezado = @encabezado + ' FROM Cartera '  

    END ELSE IF @tipoper = 4 BEGIN  -- Tabla Cartera Historica
 SELECT @encabezado = @encabezado + '  chi_area_responsable , '  
 SELECT @encabezado = @encabezado + '  chi_cartera_normativa  ,'  
 SELECT @encabezado = @encabezado + '  chi_subcartera_normativa , '  
 SELECT @encabezado = @encabezado + '  chi_libro '  

 SELECT @encabezado = @encabezado + '  FROM CarteraHis '  
    END

   SELECT @encabezado = @encabezado + ' WHERE numero_operacion = ' + CONVERT ( CHAR ( 9 ), @numoper )  
   SELECT @encabezado = @encabezado + ' ORDER BY  tipo_flujo , numero_flujo  ASC '   

   SET NOCOUNT OFF         --ADO

   EXECUTE (@encabezado)
   
   RETURN 0

END
GO
