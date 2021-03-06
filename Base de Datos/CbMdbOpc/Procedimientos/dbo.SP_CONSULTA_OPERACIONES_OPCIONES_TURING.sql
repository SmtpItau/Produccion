USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_OPERACIONES_OPCIONES_TURING]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_OPERACIONES_OPCIONES_TURING]    
     (    
          @PRODUCTO        CHAR(04)      = 'T'
		, @RUTCLI          Numeric(9,0)  = 0  
		, @MONEDA          INT           = 0
		, @USUARIO         CHAR(15)      = 'T'
		, @TIPO_OPERACION  CHAR(01)      = 'T'
		, @FEC_INI         DATETIME      
		, @FEC_FIN         DATETIME       
		, @ORIGEN          CHAR(01)

     )    
AS    
BEGIN    
    
	SET NOCOUNT ON    



/*-----------------------------------------------------------------------------*/
/* OBJETIVO : OPERACIONES DEL DIA DEL OPCIONES                                 */
/*            SE MODIFICA EL ORDEN DEL PROCESO PARA PROVOCAR UNA HOMOLOGACION  */
/*            GENERALIZADA PARA OBTENER LOS RESULTADOS EN LA GRILLA DEL        */
/*   		  PROYECTO TURING REQUERIMIENTO 19162                              */
/* AUTOR    : ROBERTO MORA DROGUETT                                            */
/* FECHA    : 25/03/2014                                                       */
/*          : ORDEN DE PROCEDIMIENTO                                           */
/*-----------------------------------------------------------------------------*/

  --EXEC SP_CONSULTA_OPERACIONES_OPCIONES_TURING 'T',0,0,'T','c','20130403','20140403','V'


/*-----------------------------------------------------------------------------*/
/* SE INSERTAN EN REGISTRO TEMPORAL TODOS LOS CONTRATOS                        */
/*-----------------------------------------------------------------------------*/
  Select * 
    Into #CaEncContrato  
    From CaVenEncContrato  
  Update #CaEncContrato 
     Set CaEstado = 'V'  
  insert into #CaEncContrato  
  select * 
    From CaEnccontrato
	
/*-----------------------------------------------------------------------------*/
/* DETALLE DEL CONTRATO                                                        */
/*-----------------------------------------------------------------------------*/
  Select * 
    Into #CaDetContrato  
    From CaDetContrato  
   Union  
  Select * 
    From CaVenDetContrato 



/*-----------------------------------------------------------------------------*/
/* OPCIONES                                                                    */
/*-----------------------------------------------------------------------------*/
  Select *   
    Into #ConOpcEstado  
    From ConOpcEstado    
  
  Insert into #ConOpcEstado  
  Select 'V'
       , 'Vencido'  
  

/*-----------------------------------------------------------------------------*/
/* MONEDAS                                                                     */
/*-----------------------------------------------------------------------------*/
  SELECT * 
    INTO #Moneda 
	FROM LNKBAC.bacparamsuda.dbo.Moneda      
    
	

/*-----------------------------------------------------------------------------*/
/* CLIENTE                                                                     */
/*-----------------------------------------------------------------------------*/
  SELECT *  
    INTO #Cliente    
	FROM LNKBAC.bacparamsuda.dbo.VIEW_CLIENTEParaOpc      
   WHERE ClRut IN ( SELECT CaRutCliente FROM #CaEncContrato ) 


  UPDATE #Cliente     
	 SET ClNombre = substring( ClNOmbre, 1 , PATINDEX('%&%', ClNombre ) - 1  )    
				  + substring( ClNOmbre, PATINDEX('%&%', ClNombre ) + 1 , len(ClNOmbre))    
   WHERE clnombre like ('%&%')  


/*-----------------------------------------------------------------------------*/
/* OPERACIONES DE REGISTROS                                                    */
/*-----------------------------------------------------------------------------*/
    SELECT 'Objeto'            = CONVERT( VARCHAR(40)   , 'CONSULTA CARTERA' )    
         , 'NumContrato'       = CONVERT( NUMERIC(8)    , Cartera.CaNumContrato )   
         , 'NumEstructura'     = CONVERT( NUMERIC(6,0)  , det.CaNumEstructura)
		 , 'CaCodEstructura'   = CONVERT( VARCHAR(10)   , Cartera.CaCodEstructura)
         , 'TipoOperacion'	   = CONVERT( VARCHAR(1)    , Cartera.CaCVEstructura)
         , 'TipoTransaccion'   = CONVERT( VARCHAR(10)   , Cartera.CaTipoTransaccion )  
         , 'NumFolio'          = CONVERT( NUMERIC(8)    , Cartera.CaNumFolio )    
         , 'FechaContrato'     = CONVERT( DATETIME      , Cartera.CaFechaContrato,112)
         , 'FechaVencimiento'  = CONVERT( DATETIME	    , det.CaFechaVcto,112)   
         , 'Moneda'			   = CONVERT( NUMERIC(5,0)  , det.CaCodMon1) 
         , 'Monto'			   = CONVERT( NUMERIC(21,6) , det.CaMontoMon1)
         , 'Strike'			   = CONVERT( FLOAT         , det.CaStrike)
         , 'Moneda2'		   = CONVERT( NUMERIC(5,0)  , det.CaCodMon2) 
         , 'Monto2'	           = CONVERT( NUMERIC(21,6) , det.CaMontoMon2)
         , 'ConOpcEstCod'      = CONVERT( VARCHAR(1)    , Cartera.CaEstado )    
         , 'ConOpcEstDsc'      = CONVERT( VARCHAR(30)   , isnull( Estado.ConOpcEstDsc,  'Preparacion' ) )    
         , 'CliRut'            = CONVERT( NUMERIC(13)   , Cartera.CaRutCliente )    
         , 'CliCod'            = CONVERT( NUMERIC(5)    , Cartera.CaCodigo )    
         , 'CliDv'             = CONVERT( VARCHAR(1)    , isnull( Cliente.ClDv, ' '   ) )    
         , 'CliNom'            = CONVERT( VARCHAR(100)  , isnull( Cliente.ClNombre, 'Cliente no existe, Crear en BAC'  ) )    
         , 'Operador'          = CONVERT( VARCHAR(15)   , Cartera.CaOperador )    
         , 'OpcEstCod'         = CONVERT( VARCHAR(2)    , Cartera.CaCodEstructura  )    
         , 'OpcEstDsc'         = CONVERT( VARCHAR(20)   , isnull( Estructura.OpcEstDsc, 'Estructura no Existe'  ) )      
         , 'Contrapartida'     = CONVERT( VARCHAR(8)    , Cartera.CaTipoContrapartida )    
         , 'Pay_OffCod'        = CONVERT( VARCHAR(2)    , isnull(  CaTipoPayOff , 'NH' ))     
         , 'Pay_OffDsc'        = CONVERT( VARCHAR(20)   , '' )  
         , 'CARTNORM'          = CONVERT( VARCHAR(50)   ,ISNULL((SELECT tbglosa 
							                                       FROM BacParamSuda.DBO.TABLA_GENERAL_DETALLE
										                          WHERE tbcateg   = 1111 
										                            AND tbcodigo1 = Cartera.CaCarNormativa),'No Especificado'))
         , 'SUBCART'           = CONVERT( VARCHAR(50)   ,ISNULL((SELECT tbglosa 
							                                       FROM BacParamSuda.DBO.TABLA_GENERAL_DETALLE 
										                          WHERE tbcateg   = 1554 
										                            AND tbcodigo1 = Cartera.CaSubCarNormativa ),'No Especificado') )   
         , 'LIBRO'             = CONVERT( VARCHAR(50)   ,ISNULL((SELECT tbglosa 
					  		                     		           FROM BacParamSuda.DBO.TABLA_GENERAL_DETALLE
										                          WHERE tbcateg   = 1552 
										                            AND tbcodigo1 = Cartera.CaLibro),'No Especificado'))  
	     , 'CARTERAFINAN'      = CONVERT( VARCHAR(50)   ,ISNULL((SELECT tbglosa 
										                           FROM BacParamSuda.DBO.TABLA_GENERAL_DETALLE
										                          WHERE tbcateg   = 204 
 										                            AND tbcodigo1 = Cartera.CaCarteraFinanciera),'No Especificado'))  
         , 'PLAZO'             = isnull(DATEDIFF(dd,Cartera.CaFechaContrato,det.CaFechaVcto),0)     
		 , 'CACALLPUT'         = CONVERT( VARCHAR(10), det.CACALLPUT) 
		 , 'MODALIDAD'		   = CONVERT( VARCHAR(10), ISNULL((CASE LTRIM(RTRIM(Det.CaModalidad)) 
	                                    WHEN 'C' THEN  'COMPENSADO' 
		                                ELSE 'FISICO' 
									    END),' ')) 
      INTO #Encabezado    
	  FROM #CaEncContrato               Cartera  
 LEFT JOIN #CaDetContrato               Det			
        ON Cartera.CaNumContrato      = Det.CaNumcontrato
 LEFT JOIN #Cliente                     Cliente				
        ON Cartera.CaRutCliente       = Cliente.ClRut    
       AND Cartera.CaCodigo           = Cliente.ClCodigo    
 LEFT JOIN OpcionEstructura             Estructura	
        ON Estructura.OpcEstCod       = Cartera.CaCodEstructura     
 LEFT JOIN #ConOpcEstado                Estado		
        ON Estado.ConOpcEstCod        = Cartera.CaEstado 
     WHERE (Cartera.CaCodEstructura   = @PRODUCTO    OR   @PRODUCTO        ='T')
       AND (Cartera.CaRutCliente      = @RUTCLI         OR   @RUTCLI          = 0 )
	   AND (DET.CaCodMon1             = @MONEDA         OR   @MONEDA          = 0)
	   AND (Cartera.CaOperador        = @USUARIO        OR   @USUARIO         ='T')
	   AND (Cartera.CaCVEstructura    = @TIPO_OPERACION OR   @TIPO_OPERACION  ='T')
	   AND  Cartera.CaFechaContrato   Between   @FEC_INI And   @FEC_FIN	


/*-----------------------------------------------------------------------------*/
/* SETEOS                                                                      */
/*-----------------------------------------------------------------------------*/
  UPDATE #Encabezado     
	 SET Pay_OffCod = ISNULL( (	SELECT 'VA'    
	       						  FROM #CaDetContrato Det   
								 WHERE Det.CanumCOntrato  = #Encabezado.NumCOntrato     
								   AND Det.CaTipoPayOff  <> Pay_OffCod )  , Pay_OffCod )    
    
  UPDATE #Encabezado     
	 SET Pay_OffDsc = ISNULL( (	SELECT PayOffTipDsc    
								  FROM PayOffTipo PO     
								 WHERE PO.PayOffTipCod = #Encabezado.Pay_OffCod ) , 'Varios Pay Off' )   


/*-----------------------------------------------------------------------------*/
/* SALIDA DE DATOS                                                             */
/*-----------------------------------------------------------------------------*/
  SELECT   Objeto            
         , NumContrato
         , NumEstructura
         , CaCodEstructura   
         , TipoOperacion	   
         , TipoTransaccion
         , NumFolio          
         , FechaContrato     
         , FechaVencimiento
         , Moneda			   
         , Monto			   
         , Strike			   
         , Moneda2		   
         , Monto2	           
         , ConOpcEstCod
         , ConOpcEstDsc      
         , CliRut            
         , CliCod
         , CliDv             
         , CliNom
         , Operador          
         , OpcEstCod         
         , OpcEstDsc         
         , Contrapartida     
         , Pay_OffCod        
         , Pay_OffDsc        
         , CARTNORM          
         , SUBCART           
         , LIBRO             
	     , CARTERAFINAN      
         , PLAZO             
		 , CACALLPUT    
		 , MODALIDAD     
   FROM #Encabezado
  WHERE (@ORIGEN = 'V' 
             AND (ConOpcEstCod != 'V')
        ) 
		OR
		(@ORIGEN = 'H' 
            AND (ConOpcEstCod   = 'V')
        ) 
  ORDER BY NumContrato


/*-----------------------------------------------------------------------------*/
/* ELIMINO TABLA DEL SISTEMA                                                   */
/*-----------------------------------------------------------------------------*/
  DROP TABLE #CaEncContrato
  DROP TABLE #CaDetContrato
  DROP TABLE #ConOpcEstado
  DROP TABLE #Moneda
  DROP TABLE #Cliente
  DROP TABLE #Encabezado


    
END








GO
