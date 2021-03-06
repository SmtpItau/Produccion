USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTASFILT_CONTR2]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTASFILT_CONTR2]      
   (   @fechaCons	DATETIME   
   ,   @operacion	NUMERIC(03)
   ,   @FINANCIEROS	CHAR(1) = 'N'
   ,   @EMPRESAS	CHAR(1) = 'N'
   )
AS
BEGIN

   SET NOCOUNT ON

   /***********************************/
   /*              Tabla              */
   /***********************************/

   IF @operacion = 1
   BEGIN --Tabla Movimiento diario 	

      SELECT DISTINCT  
             'Swap' 		  = CASE WHEN Tipo_Swap = 1 THEN 'TASA   '
                                         WHEN Tipo_Swap = 2 THEN 'MONEDA '
                                         WHEN Tipo_Swap = 3 THEN 'FRA    '
                                         WHEN Tipo_Swap = 4 THEN 'CAMARA '
                                    END
      ,      'Numero_Operacion'   = Numero_Operacion
      ,      'Codigo_Cliente'     = Codigo_Cliente
      ,      'Nombrecli'          = ISNULL(clnombre,'**')
      ,      'Tipo_operacion'     = Tipo_operacion
      ,      'NombreOp'           = CASE WHEN Tipo_operacion = 'C' THEN 'COMPRA ' ELSE 'VENTA ' END
      ,      'FechaInicio'        = CONVERT(CHAR(10),Fecha_inicio,103)
      ,      'FechaCierre'        = CONVERT(CHAR(10),Fecha_Cierre,103)
      ,      'MonedaOperacion'    = CASE WHEN Tipo_operacion = 'C' THEN compra_moneda ELSE venta_moneda END
      ,      'NombreMoneda'       = CASE WHEN Tipo_operacion = 'C' THEN ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = compra_moneda),' ')  
                                         ELSE                           ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = venta_moneda),' ') 
                                    END
      ,      'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END
      ,      'TasaBase'           = CASE WHEN Tipo_operacion = 'C' THEN Compra_Base      ELSE Venta_Base        END
      ,      'MontoConversion'    = CASE WHEN Tipo_operacion = 'C' THEN Venta_capital    ELSE Compra_capital    END
      ,      'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END
      ,      'Modalidad'          = ISNULL((CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' ')
      ,      'rutcli'             = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL(cldv ,'*')
      ,      'clmercado'          = clmercado
      ,      'Direccion'          = ISNULL(cldirecc ,'**')
      ,      'FechaCondGral'      = isnull(CONVERT(CHAR(10),clFechaFirma_cond,103),' ')
      ,      'cltipcli'           = cltipcli
      ,	     'COMUNA'		  = ISNULL((SELECT nombre FROM BACPARAMSUDA..COMUNA 
						WHERE	codigo_comuna = ISNULL(BacParamSuda..CLIENTE.Clcomuna,'') 
						AND	codigo_ciudad = ISNULL(CASE WHEN BacParamSuda..CLIENTE.Clcomuna = 3201 THEN 3201 
										    ELSE BacParamSuda..CLIENTE.Clciudad END,'')),'')
      ,	     'CIUDAD'		  = ISNULL((SELECT nombre FROM BACPARAMSUDA..CIUDAD
						WHERE	codigo_ciudad	=  ISNULL(CASE WHEN BacParamSuda..CLIENTE.Clcomuna = 3201 THEN 3201 
										    ELSE BacParamSuda..CLIENTE.Clciudad END,'')
--						AND	codigo_region	= ISNULL(BacParamSuda..CLIENTE.Clregion,'')
					),'')
      INTO    #TMP_1
      FROM    MOVDIARIO
              LEFT JOIN BacParamSuda..CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo
      WHERE   estado_flujo   = 1 
      AND   ((cltipcli       <  5 AND @FINANCIEROS = 'S')
         OR  (cltipcli       >  4 AND @EMPRESAS    = 'S')
            ) and estado <> 'C'
	 AND fecha_cierre = @fechaCons
		
      UPDATE #TMP_1
      SET    MonedaOperacion    = a.compra_moneda
      ,      NombreMoneda       = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.compra_moneda) , ' ')
      ,      MontoOperacion 	= a.Compra_capital 	
      ,      TasaBase	        = a.Compra_Base 		
      FROM   MOVDIARIO  a , #tmp_1
      WHERE  a.Numero_Operacion = #TMP_1.Numero_Operacion
      AND    a.estado_flujo     = 1 
 AND    a.tipo_flujo       = 1

      UPDATE #TMP_1
      SET    MonedaOperacion = a.venta_moneda
      ,      NombreMoneda	= ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.Venta_moneda),' ')  
      ,      MontoOperacion 	= a.Venta_capital
      ,      TasaBase	        = a.Venta_Base
      FROM   MOVDIARIO a, #tmp_1
      WHERE  a.Numero_Operacion = #TMP_1.Numero_Operacion
      AND    a.estado_flujo     = 1 
      AND    a.tipo_flujo       = 2

      SELECT * FROM #TMP_1 ORDER BY numero_operacion

   END ELSE 

   IF @operacion = 2 
   BEGIN  -- Tabla Movimiento Historico

    SELECT DISTINCT  
           'Swap' 		= CASE WHEN Tipo_Swap = 1 THEN 'TASA   '
                                       WHEN Tipo_Swap = 2 THEN 'MONEDA '
                                       WHEN Tipo_Swap = 3 THEN 'FRA    '
                                       WHEN Tipo_Swap = 4 THEN 'CAMARA '
                                  END
      ,    'Numero_Operacion'   = Numero_Operacion
      ,    'Codigo_Cliente'     = Codigo_Cliente
      ,    'Nombrecli'		= ISNULL(clnombre,'**')
      ,    'Tipo_operacion'     = Tipo_operacion
      ,    'NombreOp'		= CASE WHEN Tipo_operacion = 'C' THEN 'COMPRA ' ELSE 'VENTA ' END
      ,    'FechaInicio'	= CONVERT(CHAR(10), Fecha_inicio, 103)
      ,    'FechaCierre'	= CONVERT(CHAR(10), Fecha_Cierre, 103)
      ,    'MonedaOperacion' 	= CASE WHEN Tipo_operacion = 'C' THEN compra_moneda ELSE venta_moneda END
      ,    'NombreMoneda'	= CASE WHEN Tipo_operacion = 'C' THEN ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = compra_moneda),' ')
				       ELSE                           ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = venta_moneda),' ')
                                  END
      ,    'MontoOperacion'     = CASE WHEN Tipo_operacion = 'C' THEN Compra_capital   ELSE Venta_capital     END
      ,    'TasaBase'           = CASE WHEN Tipo_operacion = 'C' THEN Compra_Base      ELSE Venta_Base        END
      ,    'MontoConversion'	= CASE WHEN Tipo_operacion = 'C' THEN Venta_capital    ELSE Compra_capital    END
      ,    'TasaConversion'     = CASE WHEN Tipo_operacion = 'C' THEN Venta_valor_tasa ELSE Compra_valor_tasa END
      ,    'Modalidad'          = ISNULL((CASE WHEN Modalidad_Pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END),' ')
      ,    'rutcli'             = RTRIM(CONVERT(CHAR(9),rut_cliente)) + '-' + ISNULL(cldv,'*')
      ,    'clmercado'          = clmercado
      ,    'Direccion'		= ISNULL(cldirecc,'**')
      ,    'FechaCondGral'	= ISNULL(CONVERT(CHAR(10),clFechaFirma_cond,103),' ')
      ,    'cltipcli'           = cltipcli
      ,	     'COMUNA'		  = ISNULL((SELECT nombre FROM BACPARAMSUDA..COMUNA 
						WHERE	codigo_comuna = ISNULL(BacParamSuda..CLIENTE.Clcomuna,'') 
						AND	codigo_ciudad = ISNULL(CASE WHEN BacParamSuda..CLIENTE.Clcomuna = 3201 THEN 3201 
										    ELSE BacParamSuda..CLIENTE.Clciudad END,'')),'')
      ,	     'CIUDAD'		  = ISNULL((SELECT nombre FROM BACPARAMSUDA..CIUDAD
						WHERE	codigo_ciudad	=  ISNULL(CASE WHEN BacParamSuda..CLIENTE.Clcomuna = 3201 THEN 3201 
										    ELSE BacParamSuda..CLIENTE.Clciudad END,'')
--						AND	codigo_region	= ISNULL(BacParamSuda..CLIENTE.Clregion,'')
),'')
      INTO #TMP_2
      FROM MOVHISTORICO
           LEFT JOIN BacParamSuda..CLIENTE ON rut_cliente = clrut AND codigo_cliente = clcodigo
      WHERE numero_flujo       = (SELECT MIN(numero_flujo) FROM MOVHISTORICO B WHERE B.numero_operacion = MOVHISTORICO.numero_operacion ) --> 1 
      AND  ((cltipcli          <  5 AND @FINANCIEROS = 'S')
         OR (cltipcli          >  4 AND @EMPRESAS    = 'S')
           ) and estado <> 'C'
	  AND fecha_cierre = @fechaCons	
      UPDATE #TMP_2
      SET    MonedaOperacion   = a.compra_moneda
      ,      NombreMoneda      = ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.compra_moneda),' ')
      ,      MontoOperacion    = a.Compra_capital
      ,      TasaBase	       = a.Compra_Base
      FROM   MOVHISTORICO a, #TMP_2
      WHERE  a.Numero_Operacion = #TMP_2.Numero_Operacion
      AND    a.estado_flujo     = 1
      AND    a.tipo_flujo       = 1

      UPDATE #TMP_2
      SET    MonedaOperacion    = a.venta_moneda
      ,      NombreMoneda	= ISNULL((SELECT mnglosa FROM BacParamSuda..MONEDA WHERE mncodmon = a.Venta_moneda),' ')
      ,      MontoOperacion 	= a.Venta_capital
      ,      TasaBase	        = a.Venta_Base
      FROM   MOVHISTORICO a, #TMP_2
      WHERE  a.Numero_Operacion = #TMP_2.Numero_Operacion
      AND    a.estado_flujo     = 1 
      AND    a.tipo_flujo       = 2

      SELECT * FROM #TMP_2 ORDER BY numero_operacion
   END
END
GO
