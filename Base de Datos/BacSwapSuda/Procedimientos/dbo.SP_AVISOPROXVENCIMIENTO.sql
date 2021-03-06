USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AVISOPROXVENCIMIENTO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_AVISOPROXVENCIMIENTO]   
       (
        @numoperacion	NUMERIC ( 10 )
       )
AS
BEGIN
	

	DECLARE @Dia		VARCHAR(02)
        DECLARE @Anio	  	VARCHAR(04)
	DECLARE @FechaSistema  	DATETIME

	SELECT  @FechaSistema	= fechaproc 
	FROM    SwapGeneral

	SELECT @Dia = CONVERT(CHAR(2) ,DATEPART(DAY, @FechaSistema))
	SELECT @Anio = CONVERT(CHAR(4) ,DATEPART(YEAR,@FechaSistema))


	SELECT DISTINCT  
	'Swap'			    = (CASE Tipo_Swap WHEN 1 THEN 'TASA   ' ELSE 'MONEDA ' END), 
	 Numero_Operacion, 
	'Codigo_Cliente'	= Codigo_Cliente	, 
	'Nombrecli'		    = ISNULL((SELECT clnombre FROM view_cliente WHERE clcodigo = codigo_cliente and clrut = rut_cliente ),'  '), 
	'Banco'			    = ISNULL((SELECT nombre FROM swapgeneral ),'  '),
	 Tipo_operacion 	,
	'NombreOp'		    = (CASE Tipo_operacion WHEN 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END),   	 
	'FechaInicio'		= CONVERT(CHAR(10), Fecha_inicio, 103), 
	'FechaCierre'   	= CONVERT(CHAR(10), Fecha_Cierre, 103), 
	'MonedaOperacion'	= (CASE Tipo_operacion WHEN 'C' THEN compra_moneda ELSE venta_moneda END), 
	'NombreMoneda'		= (CASE Tipo_operacion WHEN 'C' THEN 
			   		ISNULL((SELECT mnglosa FROM view_moneda WHERE mncodmon = compra_moneda) , ' ') 
			   		ELSE ISNULL((SELECT mnglosa FROM view_moneda WHERE  mncodmon = venta_moneda), ' ') END), 
	'MontoOperacion'	= (CASE Tipo_operacion WHEN 'C' THEN Compra_capital ELSE Venta_capital END), 		
	'BaseFija'		    = Compra_Base, 		
	'MontoConversion'	= (CASE Tipo_operacion WHEN 'C' THEN Venta_capital ELSE Compra_capital END), 		
	'TasaRec'		    = Compra_valor_tasa , 		
	'TasaPAg'		    = venta_valor_tasa , 		
	'NombreTasaPAg'		= ISNULL((Select tbglosa From view_tabla_general_detalle Where 
					TBcodigo1 = Venta_codigo_tasa And tbcateg = 1042),'  '),
	'NombreTasaRec'		= ISNULL((Select tbglosa From view_tabla_general_detalle Where 
					TBcodigo1 = Compra_codigo_tasa And tbcateg = 1042),'  ') , 		
	'BaseVariable'		= Venta_base , 		
	 Numero_Flujo    ,  	
	 Fecha_Inicio_Flujo , 
	 Fecha_Vence_Flujo  ,  -- select * from view_tabla_general_detalle
	'Ciudad'		    = (ISNULL((SELECT Ciudad from SwapGeneral),' ' )),
	'diaCarta'		    = @DIA,
	'AnioCARTA'		    = @ANIO ,
	'dias'			    = DATEDIFF(dd, Fecha_inicio, Fecha_vence_flujo),
	'DiaSemana'		    =  datepart(dw, @FechaSistema),
	'MesCarta'		    = '8'
	 FROM Cartera  WHERE Numero_operacion = @numoperacion  --  CONVERT ( CHAR ( 19 ), @numoperacion ) 

END
GO
