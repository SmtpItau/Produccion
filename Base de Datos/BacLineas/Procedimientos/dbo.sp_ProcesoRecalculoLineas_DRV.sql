USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[sp_ProcesoRecalculoLineas_DRV]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ProcesoRecalculoLineas_DRV]
AS
BEGIN
-- The UPDATE permission was denied on the object 'DWT_MontoLineas', database 'BacLineas', schema 'dbo'.
	SET NOCOUNT ON 
	declare @query varchar(1) = 'N'
	

/*** Req: LD1  ***/
/** 	Nuevo proceso de recalculo derivados ODS debe:
		a)	Sumar para cada Cliente el total del Monto Corporativo.
		b)	Actualizar tablas: Linea_General, Linea_Sistema y  LINEA_PRODUCTO_POR_PLAZO.
		c)	En los clientes con metodología 3 y 6 se debe actualizar ID_sistema  DRV.
		d)	Para cada registro de la Interfaz generar un registro en la tabla Linea_Transaccion.
**/

----> Operaciones de Cliente en DWT_MontoLineas - IDSistema DRV

	------> Variables Cursor 1
	DECLARE @nNumeroOperacion			NUMERIC(7,0)
	,	@nSistema						VARCHAR(10)
	,	@nMontoCorporativo				NUMERIC(21,4)
	,	@nMetodologia					INT
	,	@nRutCliente					NUMERIC(10,0)
	,	@nDVCliente						CHAR(1)
	,	@nCodigoCliente					NUMERIC(3,0)	
	,   @nFacility						CHAR(3)

	,	@Resultado						VARCHAR(100)
	,   @VerificaOperacion_en_Modulos       VARCHAR(3) -- 'X--' => Existe operacion en Swap ,No es Forward No ,en Opciones
	,   @VerificaOperacion_un_Modulo        varchar(1)
	,   @CntLineaProdPlazo                  numeric(5)

	------> Variables a usar para identificar sistema x operacion
	DECLARE @Sistema						VARCHAR(10)
	,	@Producto						VARCHAR(10)
	,	@ProductoSwap					VARCHAR(10)
	,	@Plazo							INT
	,	@FechaInicial					DATETIME
	,	@FechaTermino					DATETIME
	,   @CodigoCliente					NUMERIC(3,0)	

	------> FIN 

	-- Variables Update: LINEA_GENERAL
	DECLARE @TotalMontoCorporativo_GeneralCLP	NUMERIC(19,4)
		,   @TotalMontoCorporativo_General		NUMERIC(19,4)
		,	@TotalExceso_General				NUMERIC(19,4)
		,	@TotalDisponible_General			NUMERIC(19,4)
		,	@TotalAsignado_General				NUMERIC(19,4)
		,	@TotalOcupado_GeneralCLP			NUMERIC(19,4)
		,	@TotalOcupado_General				NUMERIC(19,4)

	DECLARE @TotalMontoCorporativo_sistemaCLP	NUMERIC(19,4)
		,   @TotalMontoCorporativo_sistema	    NUMERIC(19,4)
		,	@TotalExceso_Sistema			    NUMERIC(19,4)
		,	@TotalDisponible_Sistema		    NUMERIC(19,4)
		,	@TotalAsignado_Sistema			    NUMERIC(19,4)
		,	@TotalOcupado_Sistema			    NUMERIC(19,4)
		,   @CodMoneda						    CHAR(3)
		,   @CodMonedaLG                        CHAR(3)
	--	,   @CodMonedaLinSistema				CHAR(3)


    -- Variables Update: LINEA_PRODUCTO_POR_PLAZO
	DECLARE @TotalMontoCorporativo_ProductoCLP	NUMERIC(19,4)
	,   @TotalMontoCorporativo_Producto	NUMERIC(19,4)
	,	@TotalExceso_Producto			NUMERIC(19,4)
	,	@TotalDisponible_Producto		NUMERIC(19,4)
	,	@TotalAsignado_Producto			NUMERIC(19,4)
	,	@TotalOcupado_Producto			NUMERIC(19,4)

	declare @TotalConsumoCLP numeric(20)
	declare @TotalCosumoMdaLinea numeric(20)


	
	---> FechaProc - usuada en LineaTransacción y DWTErrores 
	DECLARE @FechaProceso DATETIME
		SET @FechaProceso = (SELECT acfecproc  FROM BacTraderSuda..MDAC)

	---> FechaProc Anterior para obtener monena (cxonvertir monto según moneda de Op)
	DECLARE @FechaProcesoAnt DATETIME
		SET @FechaProcesoAnt = (SELECT acfecante  FROM BacTraderSuda..MDAC)

    /* Pendiente: agregar el campo Monto a la DWT_MontoLineas_Errores
	              para poder cuadrar la carga                          */
	/*Limpiar Tabla de errores*/
	if @query = 'N'
	  DELETE FROM dbo.DWT_MontoLineas_Errores WHERE Fecha_proceso = @FechaProceso 
    select * into #DWT_MontoLineas_Errores from dbo.DWT_MontoLineas_Errores where 1 = 2
    -- Chequea si hay operaciones
	declare @HayOperaciones varchar(1) = 'N'
	select  @HayOperaciones = 'S' from Baclineas..DWT_MontoLineas      -- select * from Baclineas..DWT_MontoLineas where fecha_proceso = (SELECT acfecproc  FROM BacTraderSuda..MDAC) 
	where Fecha_proceso = @FechaProceso


	-- select '@HayOperaciones', @HayOperaciones 
	if @HayOperaciones = 'N'
	Begin
	    --  buscar con la fecha anterior a @FechaProceso

	        if @query = 'N'

			INSERT INTO dbo.DWT_MontoLineas_Errores 
			   VALUES ( 0 -- Operacion
					   ,0 -- Rut
					   , 0 --  Codigo Cliente
					   , ' ' -- Sistema
					   , ' ' -- Producto
					   , @FechaProceso
					   , 'NO HAY registros en DWT_MontoLineas'
					   , ''
					   , 0
					   )
			else
			begin
			   INSERT INTO #DWT_MontoLineas_Errores 
			   VALUES ( 0 -- Operacion
					   ,0 -- Rut
					   , 0 --  Codigo Cliente
					   , ' ' -- Sistema
					   , ' ' -- Producto
					   , @FechaProceso
					   , 'NO HAY registros en DWT_MontoLineas'
					   , ''
					   , 0
					   )				  
		   end

		   select  @FechaProceso = @FechaProcesoAnt
		   select @FechaProcesoAnt = acfecante from BacTraderSuda.dbo.fechas_proceso where acfecproc = @FechaProcesoAnt

		   set @HayOperaciones = 'N'	
	       select  @HayOperaciones = 'S' from Baclineas..DWT_MontoLineas      -- select * from Baclineas..DWT_MontoLineas where fecha_proceso = (SELECT acfecproc  FROM BacTraderSuda..MDAC) 
	         where Fecha_proceso = @FechaProceso

	       if @HayOperaciones = 'N'
	       Begin
	       

	        if @query = 'N'

			INSERT INTO dbo.DWT_MontoLineas_Errores 
			   VALUES ( 0 -- Operacion
					   ,0 -- Rut
					   , 0 --  Codigo Cliente
					   , ' ' -- Sistema
					   , ' ' -- Producto
					   , @FechaProceso
					   , 'NO HAY registros en DWT_MontoLineas'
					   , ''
					   , 0
					   )
			else
			begin
			   INSERT INTO #DWT_MontoLineas_Errores 
			   VALUES ( 0 -- Operacion
					   ,0 -- Rut
					   , 0 --  Codigo Cliente
					   , ' ' -- Sistema
					   , ' ' -- Producto
					   , @FechaProceso
					   , 'NO HAY registros en DWT_MontoLineas'
					   , ''
					   , 0
					   )				  
		   end
		   goto FIN -- ho realizará nada
		   end
	end
	
    select * into #DWT_MontoLineas
	from Baclineas..DWT_MontoLineas where Fecha_proceso = @FechaProceso
	---and rut = 97004000 -- PRUEBA AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA

	select * into #Linea_Producto_Por_Plazo from baclineas.dbo.LINEA_PRODUCTO_POR_PLAZO where 1 = 2
    
    ----> Tabla Temporal para separar los registros 
	CREATE TABLE #LineasDRV
	(
		  nNumeroOperacion  NUMERIC(7,0)
		, nRutCliente		NUMERIC (10,0)
		, nCodigoCliente    NUMERIC(3,0)
		, nMontoCorporativo NUMERIC(21,4)
		, nSistema			VARCHAR(10)
		, nProducto			VARCHAR(10)			
		, nMetodologia		INT
		, nPlazo			INT
		, nfechavencimiento DATETIME -- usado para Linea_Transaccion (FechaVencimiento) 
		, nPadreHijo        numeric(1)
		, nMonedaLineaSistema numeric(5)
		, nMonedaLineaGeneral numeric(5)
		, nMontoCorporativoLS float
		, nMontoCorporativoLG float
	)


	/*Cursor para completar informacion de operaciones*/
	DECLARE @Cursor   CURSOR
	SET     @Cursor	= CURSOR FOR

	SELECT nNumeroOperacion		= Numero_Operacion
		,  nSistema				= ID_SISTEMA
		,  nMontoCorporativo	= Monto_Corporativo
		,  nMetodologia			= Metodologia
		,  nRutCliente			= Rut
		,  nDVCliente			= DV
		,  nFacility		    = Facility
	FROM #DWT_MontoLineas WITH(NOLOCK)
--	ORDER 
--	BY nRutCliente


	---->   BUSCAR A QUE SISTEMA CORRESPONDE LA OPERACION 				
	OPEN @Cursor 

	FETCH NEXT FROM @Cursor INTO @nNumeroOperacion
						  ,  @nSistema
						  ,	 @nMontoCorporativo
						  ,	 @nMetodologia
						  ,	 @nRutCliente
						  ,	 @nDVCliente
						  ,  @nFacility
	
	WHILE (@@FETCH_STATUS <> -1)	
	BEGIN
		IF(@@FETCH_STATUS <> -2)
		BEGIN	
			----> 1° BUSCAR A QUE SISTEMA CORRESPONDE LA OPERACION 				
			SET @Sistema	= ''
			SET @Producto	= ''

			-----> Si Las metodologías 2, 3, 5, 6 son DRV, ID_Sistema tiene que ser DRV
			IF(@nMetodologia <> 1 AND @nMetodologia <> 0)
			BEGIN -- Clientes es DRV - Buscara si el Cliente DRV Tiene Cartera										    
				---/Buscar en PCS 

				IF EXISTS (SELECT top 1 numero_operacion FROM BacSwapSuda..Cartera WITH(NOLOCK) 
				       WHERE numero_operacion = @nNumeroOperacion 
					     AND rut_cliente = @nRutCliente 
						 AND @nFacility = (SELECT Tipo_Facility 
						                    FROM BacParamSuda.dbo.PRODUCTOS_PRIMA_FACILITY 
											WITH(NOLOCK) WHERE CODIGOS_FACILITY = 
											(SELECT MIN(Codigo_Facility) 
											  FROM BacParamSuda.dbo.PRODUCTOS_MESA_FACILITY 
											  WHERE Id_sistema = 'PCS')))  /*(701) Facility => 880 SWAP */
				BEGIN
					SET @Sistema		= 'DRV'
					SET @Producto		= 'DRV'
					SET @Plazo			= 0      ----> No existe plazo
					SET @CodigoCliente  = 0
					SET @FechaTermino   = '19000101'
					SELECT TOP 1 @CodigoCliente  = codigo_cliente
					           , @FechaTermino   = fecha_termino
					         FROM BacSwapSuda..Cartera WITH(NOLOCK)  
							 WHERE numero_operacion = @nNumeroOperacion AND rut_cliente = @nRutCliente                 
					SET @VerificaOperacion_un_Modulo = 'X'	 
				END 
				ELSE
				BEGIN
				    SET @VerificaOperacion_un_Modulo = '-'	
				END
				SET @VerificaOperacion_en_Modulos = @VerificaOperacion_un_Modulo	-- Acumula en los siguientes
				--/Buscar en FWD
				IF EXISTS (SELECT top 1 canumoper FROM Bacfwdsuda..mfca WITH(NOLOCK) 
				              WHERE canumoper = @nNumeroOperacion 
							     AND cacodigo = @nRutCliente 
								 AND @nFacility = (SELECT Tipo_Facility 
								 FROM BacParamSuda.dbo.PRODUCTOS_PRIMA_FACILITY WITH(NOLOCK) 
								 WHERE CODIGOS_FACILITY = (SELECT MIN(Codigo_Facility) 
								 FROM BacParamSuda.dbo.PRODUCTOS_MESA_FACILITY WHERE Id_sistema = 'BFW') ))  /* (640) Facility => 863 FORWARD */
				BEGIN
					SET @Sistema	    = 'DRV'
					SET @Producto	    = 'DRV'
					SET @Plazo		    = 0		----> No existe plazo
					SET @CodigoCliente  = 0
					SET @FechaTermino   = '19000101'
					SELECT @CodigoCliente  = cacodcli 
					  , @FechaTermino   = cafecvcto  
					    FROM Bacfwdsuda..mfca WITH(NOLOCK) WHERE canumoper = @nNumeroOperacion AND cacodigo = @nRutCliente 
                    set @VerificaOperacion_un_Modulo = 'X'
				END
				ELSE
				BEGIN
				    set @VerificaOperacion_un_Modulo = '-'
				END
				SET @VerificaOperacion_en_Modulos = @VerificaOperacion_en_Modulos + @VerificaOperacion_un_Modulo
				--/Buscar en OPCIONES
				IF EXISTS (select top 1 CaNumContrato from CbMdbOpc..CaEncContrato 
				             with(nolock) where CaNumContrato = @nNumeroOperacion 
							       AND CarutCliente = @nRutCliente 
								   AND @nFacility = (SELECT Tipo_Facility 
								                      FROM BacParamSuda.dbo.PRODUCTOS_PRIMA_FACILITY 
													  WITH(NOLOCK) 
													  WHERE CODIGOS_FACILITY = (SELECT MIN(Codigo_Facility) 
													  FROM BacParamSuda.dbo.PRODUCTOS_MESA_FACILITY WHERE Id_sistema = 'OPT'))) 
													  /* (730) Facility => 882 OPCIONES */
				BEGIN
					SET @Sistema		= 'DRV'
					SET @Producto		= 'DRV'
					SET @CodigoCliente  = 0
					SET @FechaTermino   = '19000101'
					SELECT @CodigoCliente  = cacodigo  					    
					       FROM CbMdbOpc..CaEncContrato WITH(NOLOCK) 
						   WHERE CaNumContrato = @nNumeroOperacion AND CarutCliente = @nRutCliente 
					SET @Plazo			= 0		----> No existe plazo
					SET @FechaTermino	= (SELECT TOP 1 CaFechaVcto FROM CbMdbOpc..CaDetContrato 
					WITH(NOLOCK) WHERE CaNumContrato = @nNumeroOperacion )
					SET @VerificaOperacion_un_Modulo = 'X'
				END	
				ELSE
				BEGIN
				    SET @VerificaOperacion_un_Modulo = '-'
				END	
				SET @VerificaOperacion_en_Modulos = @VerificaOperacion_en_Modulos + @VerificaOperacion_un_Modulo
					
			END 
			ELSE	--- fin del if de metodologia			
			BEGIN		
				--Para Derivados: PCS, BFW y OPT  
				---/Buscar en PCS 
				IF EXISTS (SELECT top 1 numero_operacion FROM BacSwapSuda..Cartera WITH(NOLOCK) 
				             WHERE numero_operacion = @nNumeroOperacion AND rut_cliente = @nRutCliente 
							   AND @nFacility = (SELECT Tipo_Facility 
							                       FROM BacParamSuda.dbo.PRODUCTOS_PRIMA_FACILITY 
												   WITH(NOLOCK) WHERE CODIGOS_FACILITY = 
												   (SELECT MIN(Codigo_Facility) 
												   FROM BacParamSuda.dbo.PRODUCTOS_MESA_FACILITY WHERE Id_sistema = 'PCS')))  /* (701)  Facility => 880 SWAP  */
				BEGIN
					SET @Sistema		= 'PCS'
					select top 1 @Producto	= tipo_Swap  
					  , @FechaInicial   =  @FechaProceso
					  , @FechaTermino   =  fecha_termino
					  , @CodigoCliente  =  Codigo_cliente    
					  FROM BacSwapSuda..Cartera WITH(NOLOCK)  
					  WHERE numero_operacion = @nNumeroOperacion AND rut_cliente = @nRutCliente
					SET @Plazo			= DATEDIFF(DAY, @FechaProceso, @FechaTermino)
					SET @VerificaOperacion_un_Modulo = 'X'
				END 
				ELSE
				BEGIN
				    SET @VerificaOperacion_un_Modulo = '-'
				END
				SET @VerificaOperacion_en_Modulos = @VerificaOperacion_un_Modulo
				--/Buscar en FWD
				IF EXISTS (SELECT top 1 canumoper FROM Bacfwdsuda..mfca WITH(NOLOCK) 
				       WHERE canumoper = @nNumeroOperacion 
					    AND cacodigo = @nRutCliente 
						AND @nFacility = (SELECT Tipo_Facility 
						                    FROM BacParamSuda.dbo.PRODUCTOS_PRIMA_FACILITY 
											 WITH(NOLOCK) WHERE CODIGOS_FACILITY = (SELECT MIN(Codigo_Facility) 
											        FROM BacParamSuda.dbo.PRODUCTOS_MESA_FACILITY WHERE Id_sistema = 'BFW') ))  /*(640) Facility => 863 FORWARD */
				BEGIN
					SET @Sistema	    = 'BFW'
					SELECT top 1 @Producto	= cacodpos1  
					, @Plazo		        = datediff( dd, @FechaProceso, CafecVcto )    
					, @CodigoCliente        = cacodcli   
					, @FechaTermino         = cafecvcto  FROM Bacfwdsuda..mfca WITH(NOLOCK) WHERE  canumoper = @nNumeroOperacion AND cacodigo = @nRutCliente 
					SET @VerificaOperacion_un_Modulo = 'X'  
				END
				ELSE
				BEGIN
				    SET @VerificaOperacion_un_Modulo = '-' 
				END
				SET @VerificaOperacion_en_Modulos = @VerificaOperacion_en_Modulos + @VerificaOperacion_un_Modulo
				--/Buscar en Opciones
				IF EXISTS (select top 1 CaNumContrato from CbMdbOpc..CaEncContrato with(nolock) 
				              where CaNumContrato = @nNumeroOperacion 
							    AND CarutCliente = @nRutCliente 
								AND @nFacility = (SELECT Tipo_Facility 
								         FROM BacParamSuda.dbo.PRODUCTOS_PRIMA_FACILITY WITH(NOLOCK) 
										    WHERE CODIGOS_FACILITY = (SELECT MIN(Codigo_Facility) 
											FROM BacParamSuda.dbo.PRODUCTOS_MESA_FACILITY WHERE Id_sistema = 'OPT'))) /*(730) Facility => 882 OPCIONES */
				BEGIN
					SET @Sistema		= 'OPT'
					SELECT @Producto	   = CaCodEstructura   
					     , @CodigoCliente  = cacodigo          
					     , @FechaInicial   = @FechaProceso   FROM CbMdbOpc..CaEncContrato WITH(NOLOCK)  
					WHERE CaNumContrato = @nNumeroOperacion AND CarutCliente = @nRutCliente 
					SET @FechaTermino	= (SELECT TOP 1 CaFechaVcto FROM CbMdbOpc..CaDetContrato WITH(NOLOCK)  WHERE CaNumContrato = @nNumeroOperacion )
					SET @Plazo			= DATEDIFF(DAY, @FechaInicial, @FechaTermino)
					SET @VerificaOperacion_un_Modulo = 'X'  
				END
				ELSE
				BEGIN
				    SET @VerificaOperacion_un_Modulo = '-'  
				END
		        SET @VerificaOperacion_en_Modulos = @VerificaOperacion_en_Modulos + @VerificaOperacion_un_Modulo
			END --- fin del else de metodología
			-- Cartera
			-- Informa si la operación
			-- no está
			if @VerificaOperacion_en_Modulos not like '%X%'
			if @query = 'N'
			INSERT INTO dbo.DWT_MontoLineas_Errores 
		   VALUES (  @nNumeroOperacion -- Operacion
		           , @nRutCliente -- Rut
				   , 0 --  Codigo Cliente
				   , ' ' -- Sistema
				   , ' ' -- Producto
				   , @FechaProceso
				   , 'NO ESTA operación en cartera derivados'
				   , 'Facility ' + @nFacility 
				   , @nMontoCorporativo
				   )
            else
			INSERT INTO #DWT_MontoLineas_Errores
            select  
			  @nNumeroOperacion -- Operacion
		           , @nRutCliente -- Rut
				   , 0 --  Codigo Cliente
				   , ' ' -- Sistema
				   , ' ' -- Producto
				   , @FechaProceso
				   , 'NO ESTA operación en cartera derivados'
				   , 'Facility ' + @nFacility
		           ,  @nMontoCorporativo
			/*Crear registo en tabla temporal*/
			--IF(@Sistema <> '') AND (@Producto <> '') AND (@CodigoCliente IS NOT NULL)
			if @VerificaOperacion_en_Modulos like '%X%' -- Está vigente en algun modulo
			BEGIN
				BEGIN TRY
					/*Separa las operaciones por sistema */
					INSERT INTO #LineasDRV VALUES (@nNumeroOperacion, @nRutCliente, @CodigoCliente, @nMontoCorporativo, @Sistema, @Producto, @nMetodologia, @Plazo, @FechaTermino, 0, 0, 0, 0, 0)

					IF @@ERROR <> 0 --> Devuelve 0 si no hay error
					BEGIN 
						SET @Resultado = '-1 Error Insert Tabla tmp #LineasDRV'
					END ELSE
					BEGIN 
						SET @Resultado = '1'
					END
				END TRY
				BEGIN CATCH
				    if @query = 'N'
					INSERT INTO dbo.DWT_MontoLineas_Errores VALUES (@nNumeroOperacion, @nRutCliente, @CodigoCliente,  @Sistema, @Producto, @FechaProceso, ERROR_MESSAGE(), 'Error Insert Tabla Temporal #LineasDRV' , @nMontoCorporativo )
					else insert into #DWT_MontoLineas_Errores VALUES (@nNumeroOperacion, @nRutCliente, @CodigoCliente,  @Sistema, @Producto, @FechaProceso, ERROR_MESSAGE(), 'Error Insert Tabla Temporal #LineasDRV', @nMontoCorporativo)
				END CATCH

				BEGIN TRY
			
					/*Identificar operacion en tabla DWT */
					if @query = 'N'
					Begin
						UPDATE	DWT_MontoLineas
						SET		ID_SISTEMA			= @Sistema 
							,	Codigo				= @CodigoCliente
						WHERE	Numero_Operacion	= @nNumeroOperacion 
						AND		Rut					= @nRutCliente
						AND     Fecha_proceso       = @FechaProceso
						IF @@ERROR <> 0 --> Devuelve 0 si no hay error
						BEGIN 
							SET @Resultado = '-1 Error Update Tabla DWT_MontoLineas'
						END ELSE
						BEGIN 
							SET @Resultado = '1'
						END    
					End
					
                    if @query = 'S'
					Begin
						UPDATE	#DWT_MontoLineas
						SET		ID_SISTEMA			= @Sistema 
							,	Codigo				= @CodigoCliente
						WHERE	Numero_Operacion	= @nNumeroOperacion 
						AND		Rut					= @nRutCliente
						AND     Fecha_proceso       = @FechaProceso
						IF @@ERROR <> 0 --> Devuelve 0 si no hay error
						BEGIN 
							SET @Resultado = '-1 Error Update Tabla #DWT_MontoLineas'
						END ELSE
						BEGIN 
							SET @Resultado = '1'
						END 
				    End			
				END TRY
				BEGIN CATCH
				    -- select * from DWT_MontoLineas_Errores
				    if @query = 'N'
					   INSERT INTO dbo.DWT_MontoLineas_Errores VALUES (@nNumeroOperacion, @nRutCliente, @nCodigoCliente,  @Sistema, @Producto, @FechaProceso, ERROR_MESSAGE(),@Resultado , @nMontoCorporativo   )
					else INSERT INTO #DWT_MontoLineas_Errores select @nNumeroOperacion, @nRutCliente, @nCodigoCliente,  @Sistema, @Producto, @FechaProceso, ERROR_MESSAGE() ,@Resultado , @nMontoCorporativo
				END CATCH
			END
	     END --fin del if
	FETCH	NEXT 
	FROM	@cursor 
	INTO	@nNumeroOperacion
		,	@nSistema
		,	@nMontoCorporativo
		,	@nMetodologia
		,	@nRutCliente
		,	@nDVCliente
		,	@nFacility

	END
	CLOSE @cursor 
	DEALLOCATE @cursor

	---> FIN CURSOR:  BUSCAR A QUE SISTEMA CORRESPONDE LA OPERACION 			


	-- Imputacion sobre el padre
	-- para familias en que
	-- no imputa el hijo
	update #LineasDRV
	    set nRutCliente = clrut_padre
		 ,  nCodigoCliente = clcodigo_padre
		 ,  nPadreHijo     = 0
	from BacLineas.dbo.CLIENTE_RELACIONADO CliRel    -- select * from  BacLineas.dbo.CLIENTE_RELACIONADO where clrut_padre = 76240079
	where CliRel.clrut_hijo = nrutCliente 
	  and Clirel.clcodigo_hijo = nCodigoCliente 
	  and CliRel.Afecta_Lineas_Hijo = 0

   insert into #LineasDRV
   select  nNumeroOperacion
         , nRutCliente  = clrut_padre
		 , nCodigoCliente = clcodigo_padre
		 , nMontoCorporativo, nSistema, nProducto, nMetodologia, nPlazo, nfechavencimiento , nPadreHijo = 1, 0, 0, 0, 0
   from #LineasDRV 
      RIGTH join BacLineas.DBO.CLIENTE_RELACIONADO cr  ON clrut_hijo = nRutCliente AND clcodigo_hijo = nCodigoCliente AND CR.Afecta_Lineas_Hijo = 1




/*******************************************************************************************************************************/
/*********************************************** Revision LInea Producto Plazo ********************************/
/*******************************************************************************************************************************/
/*******************************************************************************************************************************/


	---Variables cursor 3 ---> Para Lineas Sistema y Lineas Producto
	DECLARE @nRutCliente_Detalle		NUMERIC(10,0)	
	,	@nCodigoCliente_Detalle		NUMERIC(3,0)	
	,	@nMetodologia_Detalle		INT
	,	@nSistema_Detalle			VARCHAR(10)
	,	@nProducto					VARCHAR(10)
	,	@nPlazo						INT
	,	@nNumeroOperacionDetalle	NUMERIC(7,0)
	
	/*Cursor para validar linea_producto_plazo */
	DECLARE @cursorDetalle CURSOR	
	SET     @cursorDetalle = CURSOR FOR	

	SELECT   
	        RutCliente			= nRutCliente			
		,	CodigoCliente		= nCodigoCliente
		,	Metodologia			= nMetodologia
		,	Sistema				= nSistema
		,	Producto			= nProducto
		,	Plazo				= nPlazo
		,	NumeroOperacion		= nNumeroOperacion
	FROM	#LineasDRV

	OPEN @cursorDetalle 
	FETCH NEXT FROM @cursorDetalle INTO  @nRutCliente_Detalle							
									   , @nCodigoCliente_Detalle							
									   , @nMetodologia_Detalle
									   , @nSistema_Detalle 
									   , @nProducto
									   , @nPlazo
									   , @nNumeroOperacionDetalle
	WHILE (@@FETCH_STATUS <> -1)	
		BEGIN
			IF(@@FETCH_STATUS <> -2)
			BEGIN	
			
			
			BEGIN TRY
				--- Tipo Moneda Cliente 
				SET @CodMoneda					    = ( SELECT max(Moneda)
													    FROM   BacLineas..LINEA_SISTEMA
													    WHERE Rut_Cliente		= @nRutCliente_Detalle
														AND Codigo_Cliente	    = @nCodigoCliente_Detalle
														AND Id_Sistema		    = @nSistema_Detalle)

				SET @CodMonedaLG					    = ( SELECT max(Moneda)
													    FROM   BacLineas..LINEA_GENERAL
													    WHERE Rut_Cliente		= @nRutCliente_Detalle
														AND Codigo_Cliente	    = @nCodigoCliente_Detalle
														)



 
			END TRY 
			BEGIN CATCH
			    if @query = 'N'
					INSERT INTO dbo.DWT_MontoLineas_Errores values (@nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, ERROR_MESSAGE() ,  'Error rescate  @CodMoneda' , @nMontoCorporativo)
				else
				    INSERT INTO #DWT_MontoLineas_Errores values ( @nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, ERROR_MESSAGE() ,  'Error rescate  @CodMoneda',  @nMontoCorporativo )
			END CATCH
			
			/*******************************************************************************************************************************/
			/*********************************************** REVISION  PRODUCTO  POR PLAZO ***************************************************/
			/*******************************************************************************************************************************/
			/*******************************************************************************************************************************/
						

			-- IF(@nMetodologia_Detalle <> 3 AND @nMetodologia_Detalle <> 6)
			IF(@nMetodologia_Detalle = 1 or @nMetodologia_Detalle = 0 )  -- Cambio de logica para no marear la lógica con otras metodologias DRV
			BEGIN

			BEGIN TRY
				delete #Linea_Producto_Por_Plazo
				insert into #Linea_Producto_Por_Plazo
				select * from BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO LP
				  where Rut_Cliente = @nRutCliente_Detalle 
				   and Codigo_Cliente = @nCodigoCliente_Detalle
				   and Id_Sistema =  @nSistema_Detalle
				   and LP.Codigo_Producto = @nProducto
				   	AND plazodesde <= @nPlazo
				    AND Plazohasta  >= @nPlazo
				 Set @CntLineaProdPlazo = @@ROWCOUNT 
				 if @CntLineaProdPlazo = 0
					  if @query = 'N' 
				  	     INSERT INTO dbo.DWT_MontoLineas_Errores values (@nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, 'FALTA Linea Porducto-Plazo' ,  'Plazo buscado' + convert( varchar(10), @nPlazo )  , @nMontoCorporativo  )
				      else
				         INSERT INTO #DWT_MontoLineas_Errores
				          values ( 0, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, 'FALTA Linea Porducto-Plazo' ,  'Plazo buscado' + convert( varchar(10), @nPlazo ) , @nMontoCorporativo )
                 if @CntLineaProdPlazo > 1
					  if @query = 'N' 
				  	     INSERT INTO dbo.DWT_MontoLineas_Errores values (@nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, 'Error Linea Porducto-Plazo' ,  'Plazos solapados' , @nMontoCorporativo )
				      else
				         INSERT INTO #DWT_MontoLineas_Errores
				          values ( 0, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, 'Error Linea Porducto-Plazo' ,  'Plazos solapados' , @nMontoCorporativo)

	    


				END TRY
				BEGIN CATCH
				     if @query = 'N'
							INSERT INTO dbo.DWT_MontoLineas_Errores values (@nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, ERROR_MESSAGE(), 'Error analisis lineas por plazo' , @nMontoCorporativo )
					 else
					        Insert into 
					        #DWT_MontoLineas_Errores values ( @nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, ERROR_MESSAGE(), 'Error analisis lineas por plazo',  @nMontoCorporativo )
				END CATCH
	

				END --- fin del if de metodologia
				ELSE
				BEGIN

				BEGIN TRY
					/*Producto Por Plazo para DRV*/
					---a)	Sumar para cada Cliente - Sistema el total del Monto Corporativo.

				 delete #Linea_Producto_Por_Plazo
				 insert into #Linea_Producto_Por_Plazo
				  select * from BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO LP
				  where Rut_Cliente = @nRutCliente_Detalle 
				   and Codigo_Cliente = @nCodigoCliente_Detalle
				   and Id_Sistema =  @nSistema_Detalle
				 set @CntLineaProdPlazo = @@ROWCOUNT
				 if @CntLineaProdPlazo = 0
					  if @query = 'N' 
				  	     INSERT INTO dbo.DWT_MontoLineas_Errores values (@nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, 'FALTA Linea Porducto-Plazo' ,  '' , @nMontoCorporativo )
				      else
				         INSERT INTO #DWT_MontoLineas_Errores
				          values ( @nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, 'FALTA Linea Porducto-Plazo' ,  '' , @nMontoCorporativo )
                 if @CntLineaProdPlazo > 1
					  if @query = 'N' 
				  	     INSERT INTO dbo.DWT_MontoLineas_Errores values (@nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, 'Error Linea Porducto-Plazo' ,  'Plazos solapados' , @nMontoCorporativo)
				      else
				         INSERT INTO #DWT_MontoLineas_Errores
				          values ( @nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, 'Error Linea Porducto-Plazo' ,  'Plazos solapados' , @nMontoCorporativo)
				END TRY
				BEGIN CATCH
				    if @query = 'N'
					INSERT INTO dbo.DWT_MontoLineas_Errores values (@nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, ERROR_MESSAGE(), 'Error analisis Linea Producto x Plazo'   , @nMontoCorporativo )
					else 
					INSERT INTO #DWT_MontoLineas_Errores values ( @nNumeroOperacionDetalle, @nRutCliente_Detalle, @nCodigoCliente_Detalle,  @nSistema_Detalle, @nProducto, @FechaProceso, ERROR_MESSAGE(), 'Error analisis Linea Producto x Plazo' , @nMontoCorporativo )
				END CATCH
			END
				
			END --fin del if
			update #LineasDRV
				     set nMonedaLineaGeneral = @CodMonedaLG
					   , nMonedaLineaSistema = @CodMoneda
             where nRutCliente = @nRutCliente_Detalle 
			    and nCodigoCliente = @nCodigoCliente_Detalle
			    and nSistema = @nSistema_Detalle			

		FETCH NEXT FROM @cursorDetalle INTO @nRutCliente_Detalle							
							, @nCodigoCliente_Detalle							
							, @nMetodologia_Detalle
							, @nSistema_Detalle 
							, @nProducto
							, @nPlazo
						    , @nNumeroOperacionDetalle

		END
	CLOSE @cursorDetalle 
	DEALLOCATE @cursorDetalle ---> Cursor que recorre tabla temporal



--/*******************************************************************************************************************************/
--/*********************************************** UPDATE  LINEA PRODUCTO POR PLAZO *********************************************************/
--/*******************************************************************************************************************************/
--/*******************************************************************************************************************************/


---Variables cursor 2 ---> Para Lineas Generales
DECLARE @nRutCliente_DWT		NUMERIC(10,0)
	,	@nDVCliente_DWT			CHAR(1)
	,	@nCodigoCliente_DWT		NUMERIC(3,0)	
	,	@nMetodologia_DWT		INT
	,   @nPlazoDesde_DWT             numeric(10)
	,   @nPlazHasta_DWT           numeric(10)
	,   @nProducto_DWT             varchar(3)
	,   @nIdSistema_DWT            varchar(3)



/*Cursor para datos generales*/
	DECLARE @cursorDWT CURSOR	
	SET @cursorDWT = CURSOR FOR	
 
	SELECT	DISTINCT RutCliente			= Rut_Cliente
				,	DVCliente			= 0
				,	CodigoCliente		= Codigo_Cliente
				,	Metodologia			= baclineas.dbo.FN_RIEFIN_METODO_LCR( Rut_Cliente,  Codigo_Cliente, Rut_Cliente, Codigo_Cliente )
				,   Id_Sistema
				,   Codigo_Producto
				,   plazodesde
				,   Plazohasta

	FROM  LINEA_PRODUCTO_POR_PLAZO WITH(NOLOCK)
	 where Rut_Cliente * 1000 + Codigo_Cliente in ( select nRutCliente * 1000 + nCodigoCliente from #LineasDRV )
	    and Id_Sistema not in ( 'BEX', 'BTR' , 'BCC', 'OPT' )  -- Ojo OPciones no actualizará las líneas

	--GROUP BY nRutCliente, nCodigoCliente, nMetodologia
	-- select * from LINEA_PRODUCTO_POR_PLAZO

	OPEN @cursorDWT 
	FETCH NEXT FROM @cursorDWT into  @nRutCliente_DWT
								   , @nDVCliente_DWT
								   , @nCodigoCliente_DWT					
								   , @nMetodologia_DWT
								   , @nIdSistema_DWT		
								   , @nproducto_DWT
								   , @nPlazoDesde_DWT
								   , @nPlazHasta_DWT

	WHILE (@@FETCH_STATUS <> -1)	
		BEGIN
			IF(@@FETCH_STATUS <> -2)
			BEGIN	

		BEGIN TRY

				--a)	Sumar para cada Cliente el total del Monto Corporativo para el producto - plazo correspondiente

				    SET @TotalCosumoMdaLinea = 0
				    SET @TotalCosumoMdaLinea = isnull( (SELECT  BacParamSuda.dbo.fx_convierte_monto(  @FechaProcesoAnt , 999, SUM(nMontoCorporativo), nMonedaLineaSistema )
															  FROM #LineasDRV with(nolock)
															  WHERE nRutCliente	   = @nRutCliente_DWT
															    and nCodigoCliente = @nCodigoCliente_DWT
																and nSistema       = @nIdSistema_DWT
																and nProducto      = @nproducto_DWT
																and nPlazo         >= @nPlazoDesde_DWT
																and nPlazo         <= @nPlazHasta_DWT	
														group by nMonedaLineaSistema														  
															  ) , 0 )

				    if @TotalCosumoMdaLinea <> 0 or 1 = 1 -- Ojo que podría cuestionarse funcionalmente
					Begin
					  -- select 'debug', @nPlazoDesde_DWT, @nPlazHasta_DWT, @nproducto_DWT, @nIdSistema_DWT, @TotalCosumoMdaLinea
                       update BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO
					   set TotalOcupado = @TotalCosumoMdaLinea
					     , TotalDisponible = case when TotalAsignado - @TotalCosumoMdaLinea > 0 then TotalAsignado - @TotalCosumoMdaLinea else 0 end
						 , TotalExceso     = case when TotalAsignado - @TotalCosumoMdaLinea > 0 then 0  else -(TotalAsignado - @TotalCosumoMdaLinea) end
					      
					   where    Rut_Cliente	   = @nRutCliente_DWT
							and Codigo_Cliente = @nCodigoCliente_DWT
					        and Id_Sistema       = @nIdSistema_DWT
						    and Codigo_Producto  = @nproducto_DWT
							and plazodesde       = @nPlazoDesde_DWT
							and Plazohasta       = @nPlazHasta_DWT
					    IF @@ERROR <> 0 --> Devuelve 0 si no hay error
								begin 
									SET @Resultado = '-2 Error LGPrdPlazo'									
									--insert into #ErroresLineasDRV values (CONVERT(varchar(10),@nRutCliente_DWT), CONVERT(varchar(3),@nCodigoCliente_DWT), CONVERT(varchar(1), @nMetodologia_DWT), '0','','', @Resultado )
									if @query = 'N'
									   insert into dbo.DWT_MontoLineas_Errores values (0, @nRutCliente_DWT, @nCodigoCliente_DWT, @nIdSistema_DWT, @nproducto_DWT, @FechaProceso, ERROR_MESSAGE(),  @Resultado, @TotalCosumoMdaLinea )
									   --  select * from dbo.DWT_MontoLineas_Errores
                                    else 
									   insert into #DWT_MontoLineas_Errores values (0, @nRutCliente_DWT, @nCodigoCliente_DWT, @nIdSistema_DWT, @nproducto_DWT, @FechaProceso,   ERROR_MESSAGE(),  @Resultado,  @TotalCosumoMdaLinea) 
								end
							else
								begin 
									SET @Resultado = '1'
								end
					End
			end try 
			begin catch	
					SET @Resultado = '-2 Error LGPrdPlazo catch'			
									if @query = 'N'
									   insert into dbo.DWT_MontoLineas_Errores values (0, @nRutCliente_DWT, @nCodigoCliente_DWT, @nIdSistema_DWT, @nproducto_DWT, @FechaProceso,   ERROR_MESSAGE(),  @Resultado, @TotalCosumoMdaLinea  )
                                    else 
									   insert into #DWT_MontoLineas_Errores values (0, @nRutCliente_DWT, @nCodigoCliente_DWT, @nIdSistema_DWT, @nproducto_DWT, @FechaProceso,  ERROR_MESSAGE(),  @Resultado, @TotalCosumoMdaLinea) 
							
			end catch

			end --fin del if

		

	FETCH NEXT FROM @cursorDWT INTO   @nRutCliente_DWT
								   , @nDVCliente_DWT
								   , @nCodigoCliente_DWT					
								   , @nMetodologia_DWT
								   , @nIdSistema_DWT		
								   , @nproducto_DWT
								   , @nPlazoDesde_DWT
								   , @nPlazHasta_DWT
	END
	CLOSE @cursorDWT 
	DEALLOCATE @cursorDWT


	Begin try 

		Update BacLineas.dbo.LINEA_SISTEMA  
		   set TotalOcupado = isnull( ( select sum( totalOcupado ) from BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO LPP 
									  where LPP.id_sistema = BacLineas.dbo.LINEA_SISTEMA.Id_Sistema
										   and LPP.Rut_Cliente = BacLineas.dbo.LINEA_SISTEMA.Rut_Cliente
										   and LPP.Codigo_Cliente = BacLineas.dbo.LINEA_SISTEMA.Codigo_Cliente
									   ) , 0 )
		 where Rut_Cliente * 1000 + Codigo_Cliente in ( select nRutCliente * 1000 + nCodigoCliente from #LineasDRV )
			and Id_Sistema not in ( 'BEX', 'BTR' , 'BCC', 'OPT' )

		Update BacLineas.dbo.LINEA_SISTEMA
		   set TotalDisponible = case when TotalAsignado - TotalOcupado > 0 then TotalAsignado - TotalOcupado else 0 end
			 , TotalExceso     = case when TotalAsignado - TotalOcupado > 0 then 0  else -(TotalAsignado - TotalOcupado) end
		where 
			 Rut_Cliente * 1000 + Codigo_Cliente in ( select nRutCliente * 1000 + nCodigoCliente from #LineasDRV )
			and Id_Sistema not in ( 'BEX', 'BTR' , 'BCC', 'OPT' )

	   -- PENDIENTE CONVERSION
		Update BacLineas.dbo.LINEA_GENERAL  
		   set TotalOcupado =  BacParamSuda.dbo.fx_convierte_monto( @FechaProcesoAnt, 999
								 , ( select sum( BacParamSuda.dbo.fx_convierte_monto(  @FechaProcesoAnt , LS.Moneda, LS.TotalOcupado , 999 ) )
										   from BacLineas.dbo.Linea_sistema LS where LS.Rut_Cliente = BacLineas.dbo.LINEA_GENERAL.Rut_Cliente
																	  and LS.Codigo_Cliente = BacLineas.dbo.LINEA_GENERAL.Codigo_Cliente )	
								 , BacLineas.dbo.LINEA_GENERAL.Moneda )
	                      												 		  
																   
		 where Rut_Cliente * 1000 + Codigo_Cliente in ( select nRutCliente * 1000 + nCodigoCliente from #LineasDRV )

    
		Update BacLineas.dbo.LINEA_GENERAL
		   set TotalDisponible = case when TotalAsignado - TotalOcupado > 0 then TotalAsignado - TotalOcupado else 0 end
			 , TotalExceso     = case when TotalAsignado - TotalOcupado > 0 then 0  else -(TotalAsignado - TotalOcupado) end
		where 
			 Rut_Cliente * 1000 + Codigo_Cliente in ( select nRutCliente * 1000 + nCodigoCliente from #LineasDRV )
	end try
	begin catch	
					SET @Resultado = '-2 Error Actualizacion Linea general y Linea sistema'			
									if @query = 'N'
									   insert into dbo.DWT_MontoLineas_Errores values (0, @nRutCliente_DWT, @nCodigoCliente_DWT, @nIdSistema_DWT, @nProducto, @FechaProceso,   ERROR_MESSAGE(),  @Resultado, 0  )
                                    else 
									   insert into #DWT_MontoLineas_Errores values (0, @nRutCliente_DWT, @nCodigoCliente_DWT, @nIdSistema_DWT, @nProducto, @FechaProceso,  ERROR_MESSAGE(),  @Resultado, 0) 
							
	end catch
	 
--/*******************************************************************************************************************************/
--/*********************************************** UPDATE  LINEA TRANSACCION *****************************************************/
--/*******************************************************************************************************************************/
--/*******************************************************************************************************************************/

	-------> d)	Para cada registro de la Interfaz generar un registro en la tabla Linea_Transaccion.
	
	BEGIN TRY
	--Eliminar registros
	DELETE FROM BacLineas..LINEA_TRANSACCION 
		WHERE EXISTS (SELECT ldrv.nNumeroOperacion
						FROM #LineasDRV ldrv									
						WHERE ldrv.nNumeroOperacion = LINEA_TRANSACCION.NumeroOperacion
						AND ldrv.nRutCliente		= LINEA_TRANSACCION.Rut_Cliente
						AND ldrv.nCodigoCliente		= LINEA_TRANSACCION.Codigo_Cliente
						AND ldrv.nSistema			= LINEA_TRANSACCION.Id_Sistema 
						)

				IF @@ERROR <> 0 --> Devuelve 0 si no hay error
			begin 
				SET @Resultado = '-1 Error Delete'
			--	insert into #ErroresLineasDRV values (0, 0, 0, 0,'', 0, (@Resultado + ' Eliminar Linea Transaccion') )
			--	insert into dbo.DWT_MontoLineas_Errores values (0, 0, 0,  '', '', @FechaProceso, (@Resultado + ' Eliminar Linea Transaccion'))
			end
			else
			begin 
				SET @Resultado = '1'
			end
	end try
	begin catch
			insert into dbo.DWT_MontoLineas_Errores values (0, 0, 0,  '', '', @FechaProceso, ERROR_MESSAGE(), 'Error Eliminar datos Linea Transaccion', 0)
	end catch

	BEGIN TRY
			INSERT INTO BacLineas..LINEA_TRANSACCION 
			 (
			  NumeroOperacion, --1
			  NumeroDocumento,--2
			  NumeroCorrelativo,--3
			  Rut_Cliente,--4
			  Codigo_Cliente,--5
			  Id_Sistema,--6
			  Codigo_Producto,--7
			  Tipo_Operacion,--8
			  Tipo_Riesgo,--9
			  FechaInicio, --10
			  FechaVencimiento,--11
			  MontoOriginal, --12			
			  TipoCambio,--13
			  MatrizRiesgo, --14
			  MontoTransaccion, --15
			  Operador,--16
			  Activo,--17
			  APROBACION1,--18
			  APROBACION2,--19
			  APROBACION3,--20
			  APROBACION4,--21
			  Resultado,--22
			  MetodoLCR,--23
			  Garantia--24
			  )
			SELECT 
				  nNumeroOperacion --1
				, nNumeroOperacion --2
				, 0						--> Correlativo --3
				, nRutCliente --4
				, nCodigoCliente --5
				, nSistema				--> Sistema 6
				, nProducto				--> CodigoProducto 7
				, ''					--> Tipo_Operacion 8
				, 'C'					--> Tipo_riesgo 9
				, @FechaProceso		    --> Fecha Inicio --------> Fecha de proceso
				, nfechavencimiento  	--> Fecha Vencimiento 11
				, nMontoCorporativo		--> Monto Original 12
				, 0						--> TipoCambio 13
				, 0						--> Matriz Riesgo 14
				, 0 -- nMontoCorporativo		--> MontoTransaccion 15 -- 
				, ''					--> Operador 16
				, 'S'					--> Activo 17
				, ''					--> Aprobacion 18
				, ''					--> Aprobacion 19
				, ''					--> Aprobacion 20
				, ''					--> Aprobacion 21
				, 0						--> Resultado 22
				, 0						--> MetodoLCR 23 
				, 0						--> Garantia 24
			FROM #LineasDRV 
			


			IF @@ERROR <> 0 --> Devuelve 0 si no hay error
								BEGIN 
									SET @Resultado = '-1 Error LTransaccion'
							--		insert into #ErroresLineasDRV values (0, 0, 0, 0,'', 0, (@Resultado + ' Insert Linea Transaccion') )
										--	insert into dbo.DWT_MontoLineas_Errores values (0, 0, 0,  '', '', @FechaProceso, (@Resultado + ' Insert Linea Transaccion'))
								END
							ELSE
								BEGIN 
									SET @Resultado = '1'
								END


			
		END TRY
		BEGIN CATCH
					INSERT INTO dbo.DWT_MontoLineas_Errores VALUES (0, 0, 0,  '', '', @FechaProceso, ERROR_MESSAGE(), 'Error Insert datos Linea Transaccion', 0)
		END CATCH
		
		Begin try				
        delete BacLineas.dbo.DWT_LineasDRV
		insert into BacLineas.dbo.DWT_LineasDRV select * from  #LineasDRV
		End try
		BEGIN CATCH
					INSERT INTO dbo.DWT_MontoLineas_Errores VALUES (0, 0, 0,  '', '', @FechaProceso, ERROR_MESSAGE(), 'Error delete DWT_LineasDRV', 0)
		END CATCH


    declare @TotalValidado float = 0.0
	select @TotalValidado = sum(nMontoCorporativo) from #LineasDRV where nPadreHijo = 0

	declare @OperacionNoExistentes float = 0.0
	select @OperacionNoExistentes = sum(Monto) from DWT_MontoLineas_Errores 
	   where Error = 'NO ESTA operación en cartera derivados'  and Fecha_proceso = @FechaProceso 

	declare @totalArchivo float = 0.0
	select @totalArchivo = sum( Monto_Corporativo ) from  DWT_MontoLineas where Fecha_proceso = @FechaProceso 

	-- select '@TotalValidado' = @TotalValidado, '@OperacionNoExistentes' = @OperacionNoExistentes, '@diferencia debe ser cero' = @totalArchivo - @TotalValidado - @OperacionNoExistentes 

FIN:
	IF EXISTS (SELECT 1 FROM DWT_MontoLineas_Errores)
		BEGIN
		   if  @totalArchivo - @TotalValidado - @OperacionNoExistentes <> 0
			  SELECT TOP 1 '0', 'Error ', ' Errores varios ', ' ', ' ', ' ', ' '
			 
		    else SELECT    '1', 'OK'    , 'Calculo Exitoso'  , '',  '' , '' , ''
			--SELECT @Resultado as Resultado
		END 
	ELSE
		BEGIN 

			SELECT '1', 'OK' , 'Calculo Exitoso', '','','',''

			--	SELECT '1 - Calculo Exitoso' as Resultado
		END
/*
	drop table #DWT_MontoLineas_Errores
	drop table #LineasDRV
	drop table #DWT_MontoLineas
	drop table #Linea_Producto_Por_Plazo
*/


	
END

/*
select * from DWT_MontoLineas_Errores where rut_Cliente = 484315828-- where error  not like '%UPDATE%'
select * from DWT_MontoLineas
order by error
select distinct nRutCliente, nCodigoCliente, clnombre, nMonedaLineaSistema, nMonedaLineaGeneral from #LineasDRV 
 left join BacParamSuda.dbo.cliente on clrut = nRutCliente and Clcodigo = nCodigoCliente 
 where nRutCliente in ( select rut_cliente from baclineas.dbo.LINEA_GENERAL LG 
 where rut_cliente = nRutCliente and TotalAsignado <> 0 -- and nMonedaLineaSistema <> nMonedaLineaGeneral
   )
   and 
    clnombre like '%banco%'

	select * from #LineasDRV where nRutCliente = 97004000
*/


-- select * from DWT_MontoLineas where rut = 97004000
-- select * from linea_producto_por_plazo where rut_cliente = 484315828 and id_sistema not in ('BTR', 'BCC' )
-- select * from linea_sistema where rut_cliente = 484315828 and id_sistema not in ('BTR', 'BCC' )





GO
