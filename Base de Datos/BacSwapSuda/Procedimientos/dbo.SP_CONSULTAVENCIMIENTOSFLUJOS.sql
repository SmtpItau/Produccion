USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTAVENCIMIENTOSFLUJOS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CONSULTAVENCIMIENTOSFLUJOS]
   ( 
	 @FechaInicio   VARCHAR(10)
	,@FechaTermino   VARCHAR(10)
   )
AS
BEGIN

  -- SP_CONSULTAVENCIMIENTOSFLUJOS '20150623', '20150623'

   SET NOCOUNT ON
   /*****************************************/
   /*		DECLARACIONES DE VARIABLES		*/
   /*****************************************/
   DECLARE @FechaSistema		DATETIME
   DECLARE @iFoundIcp			FLOAT
   DECLARE @CatClasificaCtes	INT
   DECLARE @CodSistemaOrigen	CHAR(3)

   /*****************************************/
   /*		SETEO DE VARIABLES				*/
   /*****************************************/
   SET @CatClasificaCtes = 72
   SET @CodSistemaOrigen = 'PCS'  /*PCS = SWAP*/



   /*****************************************/
   /*	OBTENGO VALOR DE FECHA SISTEMA		*/
   /*****************************************/
   SELECT  @FechaSistema  = fechaproc 
   FROM    SWAPGENERAL
   

/* 1 */				SELECT Swap               = CASE WHEN Tipo_Swap = 1 THEN 'TASA   '
                                       WHEN Tipo_Swap = 2 THEN 'MONEDA '
                                       WHEN Tipo_Swap = 3 THEN 'FRA    '
                                       WHEN Tipo_Swap = 4 THEN 'PROM   '
                    END
/* 2 */		 ,      cartera.Numero_Operacion  
/* 3 */		 ,      Nombrecli          = ISNULL(clnombre,'*Conflicto con Nombre*')
/* 4 */      ,      Tipo_operacion     = Tipo_operacion
/* 5 */      ,      NombreOp           = CASE WHEN Tipo_operacion = 'C' THEN 'COMPRA ' ELSE 'VENTA  ' END
/* 6 */      ,      NombreMoneda       = CASE WHEN cartera.tipo_flujo = 1  THEN ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = compra_moneda) ,' ')  
												ELSE                           ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = venta_moneda)  ,' ') 
                                  END
/* 7 */      ,     cartera.Numero_Flujo     
/* 8 */      ,      Fecha_Inicio_Flujo 
/* 9 */      ,      Modalidad          = ISNULL((CASE WHEN Modalidad_Pago = 'C' THEN 'COMP.' ELSE 'ENT. FIS.' END),' ')
/* 10 */     ,      Tipo_Swap          = Tipo_Swap
/* 11 */	 ,      fecha_vence_flujo		= fecha_vence_flujo
/* 12 */	 ,		FechaLiquidacion		= FechaLiquidacion

/* 13 */	 ,		FeriadoFlujoChile  = FeriadoFlujoChile
/* 14 */	 ,		FeriadoFlujoEEUU  = FeriadoFlujoEEUU
/* 15 */	 ,		FeriadoFlujoEnglan  = FeriadoFlujoEnglan
/* 16 */	 ,		FeriadoLiquiChile  = FeriadoLiquiChile
/* 17 */	 ,		FeriadoLiquiEEUU  = FeriadoLiquiEEUU
/* 18 */	 ,		FeriadoLiquiEnglan  = FeriadoLiquiEnglan
/* 19 */	 ,		valor_tipo_cambio 
						= CASE WHEN cartera.tipo_flujo = 1  /* Flujo Activo */
							THEN  
										CASE WHEN compra_moneda <> 13 
														THEN 
															dbo.ObtieneValorMoneda(fecha_vence_flujo,13) 
														ELSE
															dbo.ObtieneValorMoneda(fecha_vence_flujo,compra_moneda) 
														END
							ELSE 
										CASE WHEN venta_moneda <> 13 
													THEN 
														dbo.ObtieneValorMoneda(fecha_vence_flujo,13) 
													ELSE
														dbo.ObtieneValorMoneda(fecha_vence_flujo,venta_moneda) 
													END
							END
/* 20 */	 ,	    Modalidad_Pago = Modalidad_Pago
/* 21 */	 ,      compra_moneda		= compra_moneda
/* 22 */	 ,      venta_moneda		= venta_moneda
/* 23 */	 ,		Fecha_Ref_Mercado   = FechaEfectiva
/* 24 */	 ,		tipo_flujo			= cartera.tipo_flujo
/* 25 */	 ,		Dias_Valor			= isnull(Ref.diasValor,0)
/* 26 */	 ,		tipo_Cliente		= tCte.tbglosa
/* 27 */	 ,		MonedaCompensa		=  CASE WHEN cartera.tipo_flujo = 2  THEN ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = pagamos_moneda ) ,' ')  
												ELSE                           ISNULL((SELECT mnnemo FROM BacParamSuda..MONEDA WHERE mncodmon = recibimos_moneda)  ,' ') 
                                  END

/* 28 */	 ,		CodMonCompensa		=  CASE WHEN cartera.tipo_flujo = 2  THEN ISNULL(pagamos_moneda , ' ')
												ELSE                           ISNULL( recibimos_moneda  ,' ') 
                                  END
/* 29 */	,	tipo_cambio_propuesto 
						= ISNULL(dbo.FX_ObtieneTC_Conversion(cartera.Numero_Operacion, cartera.Numero_Flujo, cartera.tipo_flujo)	, 0)

/* 30 */	,	digitaSN=ISNULL(CV_TCM.digitaSN,'')
         
		    ,   Paridad_Conversion
			            = ISNULL(dbo.FX_ObtieneParidad_Conversion(cartera.Numero_Operacion, cartera.Numero_Flujo, cartera.tipo_flujo)	, 0)
            
			,   RequiereTCM     = case when MdaCap.MnMx = ' '  and MdaLiq.MnMx = ' ' -- Mda Cap y Liq son Locales 
			                        then 'N' else 'S' end
			,   RequiereParidad = case when MdaCap.MnMx = 'C' and MdaCap.MnCodMon <> 13 -- Mda Cap es Mx no USD
			                                then 'S'
                                       when Mdaliq.MnMx = 'C' and MdaLiq.MnCodMon <> 13 -- Mda liq es Mx no USD 
									        then 'S'
                                       else
									    'N'
                                   end
			 , MxCap = MdaCap.MnMx                      
			 , MxLiq = MdaLiq.MnMx
			 , ValorMinimoTCM =  UsdObs.vmvalor - UsdObs.vmvalor * 0.20 
			 , ValorMaximoTCM =  UsdObs.vmvalor + UsdObs.vmvalor * 0.20 
			 , ValorMinimoParidad = convert( float, 0.0 )
			 , ValorMaximoParidad = convert( float, 0.0 ) 
			 , Moneda_Necesita_Paridad = Case when MdaCap.MnMx = 'C' and MdaCap.MnCodMon <> 13 
			                                      /* Moneda Cap es extranjera no USD */
			                                      then MdaCap.MnCodMon 
										      else 
											  	   case when Mdaliq.MnMx = 'C' and MdaLiq.MnCodMon <> 13 /* Moneda Liq extranjera no USD */	  
												        then MdaLiq.MnCodMon 
														else 0 
												   end
                							  end
			 , DescMoneda_Necesita_Paridad = replicate('',40)			 
			 , Dias_Valor_Mx			 = isnull(Ref2.diasValor,0)
			 , fechaUSDCLP = isnull( cartera.fechaUSDCLP , '19000101' )			  
			 , fechaMexUSD = isnull( Cartera.FechaMEXUSD , '19000101' )

      INTO   #TMP1
      FROM   CARTERA cartera
             LEFT JOIN BacParamSuda.dbo.MONEDA MdaCap on MdaCap.MnCodMon = Compra_moneda + Venta_Moneda
			 LEFT JOIN BacParamSuda.dbo.MONEDA MdaLiq on MdaLiq.MnCodMon = recibimos_moneda + Pagamos_moneda

             LEFT JOIN BacParamSuda..CLIENTE 
					ON clcodigo = codigo_cliente AND clrut = rut_cliente
			 LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE tCte  
					ON tCte.tbcateg =	@CatClasificaCtes AND tCte.tbcodigo1 = Cltipcli

			 LEFT JOIN bacparamsuda.dbo.REFERENCIA_MERCADO_PRODUCTO Ref 
					ON ref.producto = tipo_Swap AND modalidad_pago = Ref.Modalidad 
					AND ref.id_sistema = @CodSistemaOrigen AND ref.Referencia = cartera.ReferenciaUSDCLP

			 LEFT JOIN bacparamsuda.dbo.REFERENCIA_MERCADO_PRODUCTO Ref2 
					ON ref2.producto = tipo_Swap AND modalidad_pago = Ref2.Modalidad 
					AND ref2.id_sistema = @CodSistemaOrigen AND ref2.Referencia = cartera.ReferenciaMEXUSD 

			left JOIN CARTERA_CONVERSION CV_TCM
					ON CV_TCM.numero_operacion=Cartera.numero_operacion
					and CV_TCM.numero_flujo=Cartera.numero_flujo
					and CV_TCM.tipo_flujo=Cartera.tipo_flujo
					and CV_TCM.TCMoParidad = 'TCM' 
            left join BacParamSuda.dbo.Valor_moneda USDObs on USDObs.vmcodigo = 994 and USDObs.vmfecha = @FechaSistema


      WHERE  FechaLiquidacion BETWEEN  @FechaInicio  AND @FechaTermino
      AND    tipo_swap         <> 3
      AND    Estado            not in ( 'C' , 'N' )
	--  AND	 (pagamos_moneda = 13 OR  recibimos_moneda= 13)  /* 13 = DOLAR USA */
   --  AND	 Modalidad_Pago = 'C'  /*C = Compensación*/
	  --En una primera instancia era sólo bancos extranjeros
	  --AND	 Cltipcli = 2	/* Cltipcli = 2	: Bancos extranjeros*/

	  update #TMP1
	     set ValorMinimoParidad = vmPtaCmp -  vmPtaCmp * 0.20  
		   , ValorMaximoParidad = vmPtaVta +  vmPtaVta * 0.20  
		   , DescMoneda_Necesita_Paridad = 'Par. ' + Mda.mnnemo  
		 from BacParamSuda.dbo.valor_moneda vm 
		   ,  BacParamSuda.dbo.Moneda Mda  
         where vmcodigo = Moneda_Necesita_Paridad and vmfecha = @FechaSistema
		   and Mda.MncodMon = Moneda_Necesita_Paridad

      SELECT * FROM #TMP1
	  order by Numero_Operacion, Numero_Flujo,tipo_flujo
END


GO
