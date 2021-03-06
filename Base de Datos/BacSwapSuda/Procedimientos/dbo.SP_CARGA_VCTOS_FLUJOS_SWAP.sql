USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_VCTOS_FLUJOS_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CARGA_VCTOS_FLUJOS_SWAP]
   (   
		@Fecha   DATETIME
   )  
AS  
BEGIN 

/*
declare  @Fecha   DATETIME
select @Fecha   = '20150204' 
*/

  
  
 SET NOCOUNT ON  
 -- SP_CARGA_VCTOS_FLUJOS_SWAP '20150623'
 
 DECLARE @dFechaAnterior   DATETIME  
 DECLARE @dFechaProceso    DATETIME  
 DECLARE @dFechaProxima    DATETIME  

 DECLARE @nContador		   NUMERIC(9)  
 DECLARE @nRegistros	   NUMERIC(9)  
 DECLARE @nNumOper	       NUMERIC(9)
 DECLARE @dFecProc         DATETIME    

 CREATE TABLE #TEMP_FLUJOS_VCTOS_SPOT
      (   FechaProceso		  DATETIME     
      ,   NumeroOperacion     NUMERIC(7)   
      ,   TipoOperacion       CHAR(1)      
      ,   TipoSwap            NUMERIC(1)   
      ,   Estado              INTEGER      
      ,   Puntero             NUMERIC(9) Identity(1,1)  
      )
CREATE INDEX #idptro_TEMP_FLUJOS_VCTOS_SPOT ON #TEMP_FLUJOS_VCTOS_SPOT (Puntero)  


  SELECT     @dFechaAnterior   = fechaant  
       ,     @dFechaProceso    = fechaproc  
       ,     @dFechaProxima    = fechaprox  
  FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock)  

  SELECT vmfecha, vmcodigo, vmvalor, vmptacmp, vmptavta   INTO #Valor_Moneda
  FROM   BacParamSuda..VALOR_MONEDA  with(nolock) WHERE vmfecha = @Fecha -- between @FechaDesde and @FechaHasta
   
   INSERT INTO #Valor_Moneda 
   SELECT vmfecha, 999, 1.0, 0.0, 0.0
   FROM   #VALOR_MONEDA       
   WHERE  vmcodigo = 998

   INSERT INTO #Valor_Moneda 
   SELECT vmfecha, 13, vmvalor, 0.0, 0.0
   FROM   #VALOR_MONEDA
   WHERE  vmcodigo = 994


  IF  @Fecha =  @dFechaProceso 

  BEGIN -- IF  @Fecha =  @dFechaProceso THEN 
       delete FLUJOS_VCTOS_SPOT where fechaProceso = @Fecha and Estado = 0 
	   INSERT INTO FLUJOS_VCTOS_SPOT   -- select * from FLUJOS_VCTOS_SPOT  select * from BacParamSuda.dbo.TBL_CAJA_DERIVADOS where modalidad_pago = 'E'
	                                   -- select * from BacParamSuda.dbo.TBL_CAJA_DERIVADOS_DETALLE where numero_operacion = 10776
			SELECT  FechaProceso    = @Fecha -- PagFechaProceso 
				  , NumeroOperacion = Caj.Numero_Operacion 
				  , TipoOperacion   = case when Caj.MontoM1 > 0 then 'C' else 'V' end											
				  , TipoSwap        = Caj.Producto                    
				  , RutCliente      = CajRes.Rut_Contraparte
				  , CodCliente      = CajRes.Codigo_Contraparte  
				  , Moneda			= Caj.MonedaM1
				  , Monto           = abs( Caj.MontoM1 )
				  , MonedaCNV       = CajRes.MonedaM2           
				  , MontoCNV        = abs( Caj.MontoM1Local)         
		 
				  , TipoCambio      = Caj.ValorUSDCLP
									      

				  , Paridad       = ParidadMdaPago 
				  , ForPagEntre   = case when caj.MontoM1 > 0 then cajRes.formaPago2 else cajRes.formaPago1 end
				  , ForPagRecib   = case when caj.MontoM1 > 0 then cajRes.formaPago1 else cajRes.formaPago2 end                     
                  , FechaInicio   = CajRes.fecha_inicio_flujo
                  , FechaVcto     = CajRes.fecha_vence_flujo
                  , FechaLiq      = Caj.FechaLiquidacion
                  , FechaValuta1  = @Fecha
                  , FechaValuta2  = @Fecha
                  , Operador      = CajRes.Operador 
                
 				  , Estado         = 0
                  , EstadoEnvio    = 0
                  , NumOperSpot    = 0
                  , VentaCodigoTasa   = 0 -- PagVentaCodigoTasa PENDIENTE 
                  , CompraCodigoTasa  = 0 -- RecCompraCodigoTasa PENDIENTE ... ya es viable para todas los tipos de tasa              

			FROM   BacParamSuda.dbo.TBL_CAJA_DERIVADOS_DETALLE Caj	
			       left join BacParamSuda.dbo.TBL_CAJA_DERIVADOS CajRes	on CajRes.Modulo = 'PCS' 
				                                and CajRes.NUmero_operacion =  Caj.Numero_operacion 
												and cajRes.fechaLiquidacion = Caj.fechaLiquidacion	
												and CajRes.MonedaM1 = Caj.MonedaM1	        
			       Left join BacParamSuda.dbo.Moneda  Mda1 on Mda1.mncodmon = Caj.MonedaM1 
				   left join FLUJOS_VCTOS_SPOT Vcto on Vcto.NumeroOperacion = Caj.Numero_Operacion 
			WHERE Caj.fechaLiquidacion = @Fecha
			  and caj.Modulo = 'PCS'
			  and CajRes.Modalidad_Pago = 'E' 
			  and isnull( Vcto.Estado, 0 ) = 0			  
			  and Caj.MontoM1 <> 0

 	   UPDATE FLUJOS_VCTOS_SPOT   
	   SET    NumOperSpot = ISNULL(CASE WHEN A.MOESTATUS = 'A' THEN  0 ELSE MONUMOPE END,0)
	   FROM   BacCamSuda..MEMO A 
	   WHERE  A.MOFECH    = @Fecha
	   AND    A.MONUMFUT  =  NumeroOperacion
	   AND    FechaProceso  = @Fecha
   END
   ELSE
   BEGIN

      IF NOT EXISTS( SELECT 1 FROM BacSwapSuda.dbo.FLUJOS_VCTOS_SPOT WHERE FechaProceso = @Fecha)
      BEGIN
    			   SELECT 0
					, ''
					, ''
					, 'NO EXISTE INFORMACIÓN'
					, ''
					, 0     
					, ''
					, 0  
					, 0.0
					, 0.0
					, ''
					, ''
					, ''
			        , ''
					, ''
					, ''
					, ''
					, ''
         
      END
         

   END

    SELECT NumeroOperacion
         , TipOper   = CASE WHEN TipoOperacion = 'C' THEN  'COMPRA' ELSE 'VEMTA' END
         , TipProd   = CASE WHEN TipoSwap = 1 THEN 'TASA   '
                            WHEN TipoSwap = 2 THEN 'MONEDA '
                            WHEN TipoSwap = 3 THEN 'FRA    '
                            WHEN TipoSwap = 4 THEN 'PROM   ' 
                       END
         , Nombrecli = ISNULL(clnombre,'*Conflicto con Nombre*') 
         , Moneda    = Mda.mnnemo
         , Monto     
         , Moneda    = MdaCnv.mnnemo
         , MontoCNV  
         , TipoCambio
         , Paridad
         , ForPagEnt = Entre.glosa 
         , ForPagRec = Recib.glosa 
         , FechaInicio
         , FechaVcto
         , FechaLiq
         , Operador
         , Estado  
         , GlosaEstadoEnvio = CASE  WHEN EstadoEnvio = 0 and (VentaCodigoTasa + CompraCodigoTasa) <> 13 THEN 'EN ESPERA'
                                    WHEN EstadoEnvio = 1 and (VentaCodigoTasa + CompraCodigoTasa) <> 13 THEN 'ENVIADA'
                                   ELSE  'NO SE ENVIARA' END 
         , CASE WHEN (VentaCodigoTasa + CompraCodigoTasa) = 13  THEN 2  ELSE  EstadoEnvio END
         , FechaProceso
         , NumOperSpot         
         , VentaCodigoTasa
         , CompraCodigoTasa

    FROM FLUJOS_VCTOS_SPOT   
         LEFT JOIN BACPARAMSUDA..CLIENTE ON clcodigo = CodCliente AND clrut = RutCliente
		 LEFT JOIN BACPARAMSUDA..MONEDA Mda     ON Mda.mncodmon    = Moneda
		 LEFT JOIN BACPARAMSUDA..MONEDA MdaCnv  ON MdaCnv.mncodmon = MonedaCNV
         LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO Entre  ON Entre.codigo = ForPagEntre
         LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO Recib  ON Recib.codigo = ForPagRecib
   WHERE FechaProceso = @Fecha


END
GO
