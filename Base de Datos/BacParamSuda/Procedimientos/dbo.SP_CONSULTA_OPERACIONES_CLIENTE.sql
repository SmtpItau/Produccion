USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_OPERACIONES_CLIENTE]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from USUARIO where usuario = 'sbrinck'

--select caestado, cacodigo,* from bacfwdsuda..mfca where canumoper = 577938
--select moestado, mocodigo,* from Bacfwdsuda..mfmo where monumoper = 577938

--select distinct(moestado) from Bacfwdsuda..mfmo where monumoper = 577938

--sp_helptext SP_CONSULTA_OPERACIONES_CLIENTE 97947000,1
--Garantia.sp_Obtener_Operaciones_Relacionadas 97947000,1
--EXEC SP_CONSULTA_OPERACIONES_CLIENTE 97947000,1
--EXEC SP_CONSULTA_OPERACIONES_CLIENTE 97947000,1


CREATE PROCEDURE [dbo].[SP_CONSULTA_OPERACIONES_CLIENTE]    
     (   @RutCliente                    Numeric(10,0)           -- RUT CLIENTE
       , @Codigo                        Int                     -- CODIGO RUT
         )

AS    
BEGIN    
    
       SET NOCOUNT ON   

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : EXTRAER OPERACIONES DE CLIENTES DE LOS SISTEMAS BAC         */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* REQUERIMIENTO : PRD -10966 MANTENEDOR DE GARANTIAS                          */
   /* FECHA CRACION : 22/04/2014                                                  */
   /* PRUEBA        : EXEC SP_CONSULTA_OPERACIONES_CLIENTE 97036000,1             */
   /* MODIFICACIÓN: 06-03-2015 --> PRD21082: CARGA DE OPERACIONES EXTERNAS		  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

   /*=============================================================================*/
   /* CREACION DE TABLA TEMPORAL DONDE RESIDIRAN LOS DATOS                        */
   /*=============================================================================*/
     DECLARE @SALIDA TABLE
       (ID                INT IDENTITY 
       ,NUMERO_OPERACION  NUMERIC(10,0)
       ,COD_PRODUCTO      VARCHAR(05)
       ,PRODUCTO          VARCHAR(50)
       ,COD_MONEDA        VARCHAR(05)
       ,MONEDA            VARCHAR(50)
       ,FECHA_INICIO      DATETIME
       ,FECHA_VENCIMIENTO DATETIME
       ,RUT_CLI           NUMERIC(10,0)
       ,CODIGO_CLI        INT
       ,SISTEMA           VARCHAR(05)
       ,MTM               NUMERIC(21,4)
	   ,OPERACION_EXTERNA BIT
	   )


   /*=============================================================================*/
   /* SALIDA DE REGISTROS FORWARD                                                 */
   /*=============================================================================*/
     INSERT INTO @SALIDA
     SELECT NRO_OPERACION
           ,COD_PRODUCTO
           ,PRODUCTO
           ,CODIGO_MONEDA
           ,MONEDA
           ,FECHA_INICIO
           ,FECHA_VENCIMIENTO 
           ,RUT
           ,CODIGO
           ,SISTEMA
           ,MTM
		   ,OPERACION_EXTERNA
       FROM(SELECT Convert(numeric(10,0),
                   CASE
                   WHEN A.var_moneda2 > 0  
                   THEN A.var_moneda2 
                   Else F.canumoper 
                   End )                              AS NRO_OPERACION 
                  ,CASE 
                   WHEN A.var_moneda2 > 0 Then 12 
                   Else F.cacodpos1
                   END                                AS COD_PRODUCTO
                  ,CASE 
                   WHEN A.var_moneda2 > 0 Then 'ARBITRAJE MONEDA MX-$' 
                   Else lTrim(rTrim(C.descripcion)) 
                   END                                AS PRODUCTO
                  ,F.cacodmon1                        AS CODIGO_MONEDA
                  ,d.mnnemo                           AS MONEDA
                  ,F.cafecha                          AS FECHA_INICIO
                  ,F.cafecvcto                        AS FECHA_VENCIMIENTO
                  ,f.cacodigo                         AS RUT
                  ,f.cacodcli                         AS CODIGO
                  ,'BFW'                              AS SISTEMA
                  , case	
				    when f.catipoper = 'C' then f.ValorRazonableActivo 
					else f.ValorRazonablePasivo 
					end                                AS MTM
                   ,CASE 
                    WHEN A.var_moneda2 = 0 Then A.canumoper 
                    Else A.var_moneda2
                    END                                AS VALIDACION
                   ,A.canumoper                        AS OPERACION
                   ,CASE 
                    WHEN F.catipoper = 'C' THEN 'COMPRA' 
                    ELSE 'VENTA'
                    END                                AS TIPOPER
				  , 0								   AS OPERACION_EXTERNA
              FROM BacfwdSuda.dbo.mfca                F WITH(NOLOCK)
             INNER JOIN    
                   BacfwdSuda.dbo.view_producto       C WITH(NOLOCK)
                ON C.id_sistema                     = 'BFW'             
               AND C.codigo_producto                = F.cacodpos1 
             INNER JOIN
                   BacfwdSuda.dbo.view_moneda         d WITH(NOLOCK)
                ON F.cacodmon1                      = d.mncodmon 
             INNER  JOIN
                   BacfwdSuda.dbo.mfca                A WITH(NOLOCK)  
                ON A.canumoper                      = F.canumoper  
             WHERE F.cacodigo                       = @RutCliente
               AND F.cacodcli                       = @codigo
               AND F.caestado                       not in  ('P','R')                                     

                                 
         ) AS TABLA
     WHERE VALIDACION  = OPERACION  
     ORDER BY OPERACION

       

   /*=============================================================================*/
   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS OPCIONES                                                */
   /*-----------------------------------------------------------------------------*/
   /*=============================================================================*/


   /*-----------------------------------------------------------------------------*/
   /* SE INSERTAN EN REGISTRO TEMPORAL TODOS LOS CONTRATOS                        */
   /*-----------------------------------------------------------------------------*/
     SELECT *  into #CaEncContrato  
       From lnkopc.cbmdbopc.dbo.CaEnccontrato with(nolock)
      WHERE CaRutCliente                   = @RutCliente
        AND CaCodigo                       = @codigo      
       

   /*-----------------------------------------------------------------------------*/
   /* DETALLE DEL CONTRATO                                                        */
   /*-----------------------------------------------------------------------------*/
     Select D.*
       Into #CaDetContrato  
       From lnkopc.cbmdbopc.dbo.CaDetContrato  D with(nolock)
      Inner Join
            #CaEncContrato                     C
         ON C.CaNumContrato                  = D.CaNumContrato
     

   /*-----------------------------------------------------------------------------*/
   /* OPCIONES                                                                    */
   /*-----------------------------------------------------------------------------*/
     Select *   
       Into #ConOpcEstado  
       From lnkopc.cbmdbopc.dbo.ConOpcEstado    with(nolock)
  
 

   /*-----------------------------------------------------------------------------*/
   /* MONEDAS                                                                     */
   /*-----------------------------------------------------------------------------*/
     SELECT * 
       INTO #Moneda 
          FROM LNKBAC.bacparamsuda.dbo.Moneda    with(nolock)



   /*-----------------------------------------------------------------------------*/
   /* CLIENTE                                                                     */
   /*-----------------------------------------------------------------------------*/
     SELECT *  
       INTO #Cliente    
          FROM LNKBAC.bacparamsuda.dbo.VIEW_CLIENTEParaOpc with(nolock) 
      WHERE ClRut IN ( SELECT CaRutCliente FROM #CaEncContrato with(nolock) ) 


     UPDATE #Cliente     
           SET ClNombre = substring( ClNOmbre, 1 , PATINDEX('%&%', ClNombre ) - 1  )    
                          + substring( ClNOmbre, PATINDEX('%&%', ClNombre ) + 1 , len(ClNOmbre))    
      WHERE clnombre like ('%&%')




   /*-----------------------------------------------------------------------------*/
   /* OPERACIONES DE REGISTROS                                                    */
   /*-----------------------------------------------------------------------------*/
    SELECT    'NumContrato'       = CONVERT( NUMERIC(8)    , Cartera.CaNumContrato ) 
            , 'Cod_Producto'      = Cartera.CaCodEstructura 
            , 'OpcEstDsc'         = CONVERT( VARCHAR(20)   , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )  
            , 'CodMoneda'         = CONVERT( NUMERIC(5,0)  , det.CaCodMon1) 
            , 'Moneda'            = Moneda.mnnemo
            , 'FechaContrato'     = CONVERT( DATETIME      , Cartera.CaFechaContrato,112)
            , 'FechaVencimiento'  = CONVERT( DATETIME      , det.CaFechaVcto,112)   
            , 'Rut_Cliente'       = Cartera.CaRutCliente
            , 'Codigo'            = Cartera.CaCodigo 
            , 'SISTEMA'           = 'OPT'          
            , 'MTM'               = Cartera.CaVr
			, 'OPERACION_EXTERNA' = 0
       INTO #Encabezado    
       FROM #CaEncContrato                 Cartera  with(nolock)
	   LEFT JOIN 
	        #CaDetContrato                 Det               
         ON Cartera.CaNumContrato        = Det.CaNumcontrato
       LEFT JOIN 
	        lnkopc.cbmdbopc.dbo.OpcionEstructura  Estructura with(nolock)
         ON Estructura.OpcEstCod         = Cartera.CaCodEstructura   
	   Left JOIN #Moneda                        Moneda
         ON Moneda.mncodmon              = det.CaCodMon1  
      GROUP BY 
	        Cartera.CaNumContrato
		   ,Cartera.CaCodEstructura
		   ,Estructura.OpcEstDsc
	       ,det.CaCodMon1
		   ,Moneda.mnnemo
           ,Cartera.CaFechaContrato
		   ,det.CaFechaVcto
		   ,Cartera.CaRutCliente
		   ,Cartera.CaCodigo 
		   ,Cartera.CaVr


       INSERT INTO @SALIDA
       SELECT * FROM #Encabezado

       /*-----------------------------------------------------------------------------*/
       /* ELIMINO TABLA DEL SISTEMA                                                   */
       /*-----------------------------------------------------------------------------*/
      DROP TABLE #CaEncContrato
      DROP TABLE #CaDetContrato
      DROP TABLE #ConOpcEstado
      DROP TABLE #Moneda
      DROP TABLE #Cliente
      DROP TABLE #Encabezado

   /*=============================================================================*/
   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE SWAP                                                              */
   /*-----------------------------------------------------------------------------*/
   /*=============================================================================*/
     INSERT INTO @SALIDA
	 SELECT	'NUMERO_OPERACION'	= car.Numero_Operacion
		,	'COD_PRODUCTO'		= car.Tipo_Swap
		,	'PRODUCTO'			= CASE	car.Tipo_Swap	WHEN 1 THEN 'TASA'
														WHEN 2 THEN 'MONEDA'
														WHEN 3 THEN 'FRA'
														ELSE		'PROMEDIO CAMARA'
													END
		,	'MONEDAOPERACION'	= CASE car.tipo_flujo	WHEN 1 THEN car.compra_moneda 
														ELSE		car.venta_moneda 
													END
		,	'MONEDA'			= CASE car.tipo_flujo	WHEN 1 THEN (SELECT mnnemo FROM BacSwapSuda.dbo.VIEW_MONEDA WHERE MNCODMON = car.compra_moneda) 
														ELSE		(SELECT mnnemo FROM BacSwapSuda.dbo.VIEW_MONEDA WHERE MNCODMON = car.venta_moneda)   
													END
		,	'FECHAINICIO'		= car.Fecha_Cierre
		,	'FECHATERMINO'		= car.Fecha_termino
		,	'RUT_CLIENTE'		= car.rut_cliente
		,	'CODIGO'			= car.codigo_cliente
		,	'SISTEMA'			= 'PCS'
		,	'MTM'				= MTM.xMTM	
		,	'OPERACION_EXTERNA' = 0
	FROM	BacSwapSuda.dbo.CARTERA	car with(nolock) 
			inner join	(	select	distinct 
									Folio		= numero_operacion
								,	xMTM		= MtmAct.vMTM - MtmPas.vMTM
							from	BacSwapSuda.dbo.CARTERA car with(nolock)
									left join	(	select	distinct Folio = numero_operacion, vMTM = compra_mercado_clp 
													from	BacSwapSuda.dbo.CARTERA with(nolock)
													where	tipo_flujo = 1
												)	MtmAct	On MtmAct.Folio = car.numero_operacion

									left join	(	select	distinct Folio = numero_operacion, vMTM = venta_mercado_clp 
													from	BacSwapSuda.dbo.CARTERA with(nolock)
													where	tipo_flujo = 2
												)	MtmPas	On MtmPas.Folio = car.numero_operacion
							where	car.rut_cliente			= @RUTCLIENTE
							and		car.codigo_cliente		= @codigo
						)	MTM		On MTM.Folio	= car.Numero_Operacion

	WHERE	car.tipo_flujo			IN(1,2)
	AND		car.estado_flujo		= 1
	AND		car.Estado				<> 'C'
	and		car.tipo_flujo			= 1
	

	--/*OPERACIONES EXTERNAS  PRD21082*/
	
	INSERT INTO @SALIDA
	select  'NUMERO_OPERACION'	= toe.NumeroOperacion
		, 'COD_PRODUCTO'		= CONVERT(varchar(5), toe.IdTipoOperacion)
		, 'PRODUCTO'			= toe.GlosaProducto	
		, 'COD_MONEDA'			= toe.Moneda1
		
		, 'MONEDA'				= (select mnnemo 
									from BacParamSuda..Moneda with(nolock) 
									where mncodmon = toe.Moneda2)	
		, 'FECHA_INICIO'		= toe.FechaOperacion
		, 'FECHA_VENCIMIENTO'	= toe.FechaVencimiento		

		, 'RUT_CLI'				= toe.RutCliente
		, 'CODIGO_CLI'			= toe.CodigoCliente
		
	
		, 'SISTEMA'				= (select Nemo 
									from BDBOMESA.Garantia.TBL_GeneralDetalle with(nolock) 
									where IdCategoria = 31 and IdCodigo = toe.IdTipoOperacion)		
		
		
		, 'MTM'					= toe.ValorMTM
		, 'OPERACION_EXTERNA'   = 1
	from BDBOMESA.Garantia.TBL_OperacionesExternas toe with(nolock)
	where toe.RutCliente		= @RutCliente
	AND	toe.CodigoCliente		= @Codigo


   /*=============================================================================*/
   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS TODOS LOS PRODUCTOS                                     */
   /*-----------------------------------------------------------------------------*/
   /*=============================================================================*/
     SELECT ID
              ,NUMERO_OPERACION 
              ,COD_PRODUCTO      
              ,PRODUCTO          
              ,COD_MONEDA        
              ,MONEDA            
              ,FECHA_INICIO      
              ,FECHA_VENCIMIENTO 
              ,RUT_CLI           
              ,CODIGO_CLI        
              ,SISTEMA    
              ,MTM    
			  ,OPERACION_EXTERNA    
         FROM @SALIDA

END
GO
