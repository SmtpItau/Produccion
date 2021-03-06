USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_TblOperacionesRevision]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MonitorFX_TblOperacionesRevision] (@idPosicion BIGINT)
AS
BEGIN
	DECLARE @POSICION BIGINT ;
	 
	
	
	--> 1,0 Declaracion de variables utilizadas en la parametria del proceso  // Como uso constantes 
	
	--> ========================================================================================================================================================
	
	--> Constantes para proceso
	
	DECLARE @CONST_MERCADO_PTAS CHAR(4) ;
	SET @CONST_MERCADO_PTAS = 'PTAS'	;
	
	
	DECLARE @CONST_MERCADO_EMPR CHAR(4) ;
	SET @CONST_MERCADO_EMPR = 'EMPR'	;
	
	
	DECLARE @CONST_MERCADO_ARBI CHAR(4) ;
	SET @CONST_MERCADO_ARBI = 'ARBI'	;
	
	
	
	--> 1.2 Declaracion de codibo de productos
	
	--> ------------------------------------------------------------------------------------------------------------- 
	
	DECLARE @CONST_PRODUCTO_SPOT SMALLINT;
	SET @CONST_PRODUCTO_SPOT = 1 ;
	
	
	
	DECLARE @CONST_PRODUCTO_FWD SMALLINT;
	SET @CONST_PRODUCTO_FWD = 2 ;
	
	
	
	DECLARE @CONST_PRODUCTO_SWAP SMALLINT;
	SET @CONST_PRODUCTO_SWAP = 3 ;
	
	
	
	DECLARE @CONST_PRODUCTO_SPTI SMALLINT;
	SET @CONST_PRODUCTO_SPTI = 4 ;
	
	
	
	DECLARE @CONST_PRODUCTO_SPTE SMALLINT;
	SET @CONST_PRODUCTO_SPTE = 5 ;
	
	
	
	DECLARE @CONST_PRODUCTO_SPTA SMALLINT;
	SET @CONST_PRODUCTO_SPTA = 6 ;
	
	
	
	--> 1.4 Declaracion de archivos a trabajar y subir desde el Servicio wde, 
	
	--> ------------------------------------------------------------------------------------------------------------- 
	
	DECLARE @CONST_ARCHIVO_1 SMALLINT; --> BACDODYN
		SET @CONST_ARCHIVO_1 = 1 ; 
	
	DECLARE @CONST_ARCHIVO_2 SMALLINT; --> TC
		SET @CONST_ARCHIVO_2 = 2 ;
	
	DECLARE @CONST_ARCHIVO_3 SMALLINT; --> TRANSMON
		SET @CONST_ARCHIVO_3 = 3 ;
	
	DECLARE @CONST_ARCHIVO_4 SMALLINT; --> REUTERS
		SET @CONST_ARCHIVO_4 = 4 ;

	DECLARE @CONST_ARCHIVO_5 SMALLINT; --> BARCLAYS
		SET @CONST_ARCHIVO_5 = 5 ;

	DECLARE @CONST_ARCHIVO_6 SMALLINT; --> STANDART CHARTERED
		SET @CONST_ARCHIVO_6 = 6 ;

	DECLARE @CONST_ARCHIVO_8 SMALLINT; --> SWAPS DODD FRANK
		SET @CONST_ARCHIVO_8 = 8 ;
	
	
	
	--> ========================================================================================================================================================
	DECLARE @gs_Ex_Forma_Pago_Mn	SMALLINT 
	DECLARE @gs_Ex_Forma_Pago_Mx	SMALLINT
	DECLARE @gs_Ex_CodCart			SMALLINT
	DECLARE @gs_Ex_Broker			SMALLINT
	DECLARE @gs_Ex_TipRetiro		SMALLINT
			
	
	
	DECLARE @gs_Ex_AreaResponsable_Fwd VARCHAR(10)
	DECLARE @gs_Ex_CodSubCartNorm VARCHAR(10)
	DECLARE @gs_Ex_CodCartNorm_Fwd VARCHAR(10)
	DECLARE @gs_Ex_CodLibro VARCHAR(10)
	DECLARE @gs_Ex_Operador VARCHAR(10)
	
	DECLARE @idArchivo SMALLINT
	
	DECLARE @sHora CHAR(10),
	        @sCliente VARCHAR(30),
	        @sUsuario VARCHAR(30),
	        @sContraparte VARCHAR(30),
	        @sOperacion VARCHAR(01),
	        @xOperacion VARCHAR(01),
	        @sEquivalente VARCHAR(30),
	        @sClase VARCHAR(05),
	        @sMoneda1 VARCHAR(03),
	        @sMoneda2 VARCHAR(03),
	        @sTipoDolar VARCHAR(10),
	        @sMercado VARCHAR(04),
	        @sMonto VARCHAR(50),
	        @sPrecio VARCHAR(50),
	        @sNula VARCHAR(01),
	        @sEstado VARCHAR(01),
	        @sFecha VARCHAR(10) ;
	
	DECLARE @iRut INT,
	        @iRutBusqueda INT,
	        @iCodCliente INT ;
	
	DECLARE @fMonto FLOAT,
	        @fPrecio FLOAT
	
	
	DECLARE @iMoneda1 SMALLINT,
	        @iOperacion SMALLINT,
	        @PureDealType SMALLINT,	--> Copia del VB6
	        @iMoneda2 SMALLINT ;	 
	
	DECLARE @iFormaPagoMN SMALLINT,
	        @iFormaPagomx SMALLINT,
	        @iCodigoOMA VARCHAR(06),
	        @iCodigoComercio VARCHAR(06),
	        @iCodigoConcepto VARCHAR(06),
	        @sIdentificacion VARCHAR(40)
	
	
	
	DECLARE @fFechaArchivo DATETIME		
	DECLARE @dFecha DATETIME
	
	
	
	DECLARE @sVencimiento VARCHAR(10)		
	
	
	
	DECLARE @fMonto1 VARCHAR(30),
	        @fMonto2 VARCHAR(30),
	        @fPrecio1 VARCHAR(20),
	        @fPrecio2 VARCHAR(20),
	        @fPrecio3 VARCHAR(20)		
	
	DECLARE @iClPais SMALLINT ;
	
	--> ---------------------------------------------------------------------------------------------------------
	--> Variables para la ejecutcion de otros Procedimientos
	--> ---------------------------------------------------------------------------------------------------------
	DECLARE @SQLString NVARCHAR(500),
	        @ParmDefinition NVARCHAR(500) ;
	
	
	DECLARE @bentra BIT
	DECLARE @bentra1 BIT 

	IF @idArchivo = @CONST_ARCHIVO_3
	BEGIN 
		IF NOT EXISTS(
			   SELECT 1
				 FROM dbo.MonitorFX_TblOperaciones f WITH(NOLOCK)
				INNER 
				 JOIN dbo.MonitorFX_TblOperacionesTMP INSERTED WITH(NOLOCK)
						   ON  f.idArchivo = INSERTED.idArchivo
			               AND CONVERT(CHAR(10), f.Oper_sFecha, 121) = CONVERT(CHAR(10), f.Oper_sFecha, 121)
						   AND RTRIM(LTRIM(f.Oper_Hora)) = RTRIM(LTRIM(INSERTED.Oper_Hora))
						   AND RTRIM(LTRIM(f.Oper_sCodComprador)) = RTRIM(LTRIM(INSERTED.Oper_sCodComprador))
						   AND RTRIM(LTRIM(f.Oper_fMontoOrigen)) = RTRIM(LTRIM(INSERTED.Oper_fMontoOrigen))
						   AND RTRIM(LTRIM(f.Oper_fPrecio)) = RTRIM(LTRIM(INSERTED.Oper_fPrecio    ))
						   AND RTRIM(LTRIM(f.Oper_sIdentificacion)) = RTRIM(LTRIM(INSERTED.Oper_sIdentificacion))
						   AND RTRIM(LTRIM(f.Oper_sCliente)) =  RTRIM(LTRIM(INSERTED.Oper_sCliente))
						   AND RTRIM(LTRIM(f.oper_scontraparte)) = RTRIM(LTRIM(INSERTED.oper_scontraparte))
						   AND RTRIM(LTRIM(f.Oper_sEquivalencia)) = RTRIM(LTRIM(INSERTED.Oper_sEquivalencia))
						   AND RTRIM(LTRIM(f.Oper_sUsuario)) = RTRIM(LTRIM(INSERTED.Oper_sUsuario))
						   AND RTRIM(LTRIM(f.Oper_sMercado)) = RTRIM(LTRIM(INSERTED.Oper_sMercado))
						      
						   AND INSERTED.idPosicion = @idPosicion)
						   
						   
			SET @bentra1 = 1
		ELSE 				
			SET @bentra1 = 0
	END ELSE BEGIN
		IF NOT EXISTS(
			   SELECT 1
				 FROM dbo.MonitorFX_TblOperaciones f WITH(NOLOCK)
				INNER 
				 JOIN dbo.MonitorFX_TblOperacionesTMP INSERTED WITH(NOLOCK)
						   ON  f.idArchivo = INSERTED.idArchivo
			               AND CONVERT(CHAR(10), f.Oper_sFecha, 121) = CONVERT(CHAR(10), f.Oper_sFecha, 121)
						   AND RTRIM(LTRIM(f.Oper_Hora)) = RTRIM(LTRIM(INSERTED.Oper_Hora))
						   AND RTRIM(LTRIM(f.Oper_sIdentificacion)) = RTRIM(LTRIM(INSERTED.Oper_sIdentificacion))
						   AND RTRIM(LTRIM(f.Oper_sCodComprador)) = RTRIM(LTRIM(INSERTED.Oper_sCodComprador))
						   AND RTRIM(LTRIM(f.Oper_sCodVendedor)) = RTRIM(LTRIM(INSERTED.Oper_sCodVendedor))
						   AND INSERTED.idPosicion = @idPosicion)
						   
			SET @bentra1 = 1
		ELSE 				
			SET @bentra1 = 0
		
		 
	END  

		
	if (SELECT COUNT(1)
	FROM   MonitorFX_TblOperacionestmp ok WITH (NOLOCK)
	INNER JOIN ( SELECT * FROM dbo.MonitorFX_TblOperacionestmp WHERE idPosicion  =@idPosicion) AS Exis
	ON Exis.idArchivo = ok.idArchivo
	AND Exis.Oper_Hora = ok.Oper_Hora
	AND Exis.Oper_sFecha = ok.Oper_sFecha
	AND Exis.Oper_sMercado = ok.Oper_sMercado
	AND Exis.Oper_sContraparte = ok.Oper_sContraparte
	AND Exis.Oper_sUsuario = ok.Oper_sUsuario
	AND Exis.Oper_sCliente = ok.Oper_sCliente
	AND Exis.Oper_sIdentificacion = ok.Oper_sIdentificacion
	AND Exis.Oper_sEquivalencia = ok.Oper_sEquivalencia
	AND Exis.Oper_sNula = ok.Oper_sNula
	AND Exis.Oper_sOperacion = ok.Oper_sOperacion
	AND Exis.Oper_fPrecio = ok.Oper_fPrecio
	AND Exis.Oper_fMontoOrigen = ok.Oper_fMontoOrigen 
	AND Exis.Oper_sCodComprador = ok.Oper_sCodComprador )>1 
		SET @bentra1 = 0
	
	
	
	
/*	GROUP BY
		   idArchivo,
		   Oper_Hora,
		   Oper_sCodComprador,
		   Oper_fMontoOrigen,
		   Oper_fPrecio,
		   Oper_sOperacion,
		   Oper_sNula,
		   Oper_sEquivalencia,
		   Oper_sIdentificacion,
		   Oper_sCliente,
		   Oper_sUsuario,
		   Oper_sContraparte,
		   Oper_sMercado,
		   Oper_sFecha
        
		*/
			
	IF @bentra1 = 1 
	BEGIN
 

	    SELECT @idArchivo = idArchivo,
	           @sHora               = mftot.Oper_Hora,
	           @sCliente            = CASE 
	                            WHEN idArchivo = @CONST_ARCHIVO_3 THEN mftot.Oper_sCliente
	                            ELSE mftot.Oper_sNemoComprador
	                       END,
	           @sUsuario            = mftot.Oper_sUsuario,
	           @sContraparte        = CASE 
	                                WHEN idArchivo IN (@CONST_ARCHIVO_3, @CONST_ARCHIVO_4) THEN 
	                                     mftot.Oper_sContraparte
	                                ELSE mftot.Oper_sNemoVendedor
	                           END,
	           @sOperacion          = mftot.Oper_sOperacion,
	           @xOperacion          = mftot.Oper_sNula,	-->mftot.Oper_sOperacion,
	           @sEquivalente        = mftot.Oper_sEquivalencia,
	           @sClase              = mftot.Oper_sNula,
	           @sTipoDolar          = mftot.Oper_sCodComprador,
	           @sMonto              = mftot.Oper_fMontoOrigen,
	           @sPrecio             = mftot.Oper_fPrecio,
	           @sMoneda1            = mftot.Oper_sCodComprador,
	           @sVencimiento        = mftot.Oper_fVencimiento,
	           @sMoneda2            = mftot.Oper_sCodVendedor,
	           @sFecha              = mftot.oper_sFecha,
	           @sMercado            = mftot.Oper_sMercado,
	           @sIdentificacion     = mftot.Oper_sIdentificacion --> sourceReference
	           ,
	           @fMonto1             = ISNULL(mftot.Oper_fMonto1, 0),
	           @fMonto2             = ISNULL(mftot.Oper_fMonto2, 0),
	           @fPrecio1            = ISNULL(mftot.Oper_fPrecio1, 0),
	           @fPrecio2            = ISNULL(mftot.Oper_fPrecio2, 0),
	           @fPrecio3            = ISNULL(mftot.Oper_fPrecio3, 0)
	           
	    FROM   dbo.MonitorFX_TblOperacionesTMP mftot WITH(NOLOCK)
	    WHERE  idPosicion           = @idPosicion
	    
	    
	    
	    IF SUBSTRING(@sfecha, 2, 1) = '/'
	    BEGIN
	        SET @sfecha = SUBSTRING(@sfecha, 6, 4) + '0' + SUBSTRING(@sfecha, 1, 1)
	            + SUBSTRING(@sfecha, 3, 2)
	    END
	    
	    
	    
	    IF SUBSTRING(@sfecha, 3, 1) = '/'
	    BEGIN
	        SET @sfecha = SUBSTRING(@sfecha, 6, 4) + SUBSTRING(@sfecha, 1, 2) +
	            SUBSTRING(@sfecha, 3, 2)
	    END
	    
	    IF ISNULL(@sfecha, '') = ''
	        SET @sfecha = CONVERT(
	                CHAR(10),
	                (
	                    SELECT acfecpro
	                    FROM   baccamsuda.dbo.meac
	                ),
	                112
	            )


SELECT @susuario 	    
--SELECT 'aca',@sMonto,@sPrecio,	@fMonto1    ,CONVERT(FLOAT, REPLACE(@fMonto1, '.', '')), CONVERT(FLOAT, REPLACE(@sPrecio, ',', '.'))
	    SET @fFechaArchivo = CONVERT(DATETIME, @sfecha, 112)
	    		
	    SET @dFecha = @fFechaArchivo;
	    SET @iOperacion = CASE 
	                 WHEN @sOperacion = 'C' THEN 1
	                           ELSE 2
	                      END
 	    
	    IF @idArchivo = @CONST_ARCHIVO_1
	    BEGIN
	        SET @fMonto = CONVERT(FLOAT, REPLACE(@fMonto1, '.', ''))
	        SET @fPrecio = CONVERT(FLOAT, REPLACE(@sPrecio, ',', '.'))
	    END
	    ELSE
	    BEGIN

	        SET @fMonto = CONVERT(FLOAT, @fMonto1)
	        SET @fPrecio = CONVERT(FLOAT, REPLACE(@sPrecio, ',', '.')) --CONVERT(FLOAT, @sPrecio)

	    END 
	    
	    IF CONVERT(INT,SUBSTRING(@sHora,1,2)) >13
	    BEGIN
	    	SET @fFechaArchivo = (SELECT ACFECPRX FROM   baccamsuda.dbo.meac)

	    END
	    
--SELECT 'aca1'				
	    
	    /*	==============================================================================================================================================================================
	    *	Incio de proceso de lectura grabacion de operaciones de archivo TRANSMON,TXT a SPOT 
	    *	==============================================================================================================================================================================*/
--select 'aca	    ddd ',@shora
	    
	    IF @idArchivo = @CONST_ARCHIVO_3
	       OR @idArchivo = @CONST_ARCHIVO_1
	    BEGIN
	        SET @sMoneda1 = 'USD' ; 
	        SET @iMoneda1 = 13	
	        
	        SET @sMoneda2 = 'CLP' ; 
	        SET @iMoneda2 = 999
	        
	        
	        
	        SET @sEstado = 'D'
	        
	        
	        IF @idArchivo = @CONST_ARCHIVO_3
	        BEGIN 
				IF (
					   CONVERT(INT, SUBSTRING(@shora, 1, 2)) > 14
					   AND CONVERT(INT, SUBSTRING(@shora, 3, 2)) > 0
					   AND CONVERT(INT, SUBSTRING(@shora, 5, 2)) > 0
				   )
				BEGIN
					SET @sEstado = 'F'
				END
			END ELSE 
			BEGIN
				IF (
					   CONVERT(INT, SUBSTRING(@shora, 1, 2)) > 14
					   AND CONVERT(INT, SUBSTRING(@shora, 4, 2)) > 0
					   AND CONVERT(INT, SUBSTRING(@shora, 7, 2)) > 0
				   )
				BEGIN
					SET @sEstado = 'F'
				END
				
				 
			END 				        
   
	        SET @sEquivalente = RTRIM(LTRIM(@sEquivalente))
	        
	        SET @sUsuario = RTRIM(LTRIM(@sUsuario))
	        
select @sUsuario	        
	        IF @idArchivo = @CONST_ARCHIVO_3
	        BEGIN
	            IF @sCliente <> 'CORPBANCA'
	            BEGIN
	                SET @sUsuario = ( 
	                        SELECT top 1 Usuario_Bac
	                        FROM   BacCamSuda.dbo.Usuario_Bac_Otc
	                        WHERE  Sistema = 'DATATEC'
	                               AND Usuario_Exo = @sEquivalente
	                    )
	                
	                SET @sOperacion = CASE 
	                                       WHEN @sOperacion = 'D' THEN 'V'
	                                       ELSE 'C'
	                                  END
	            END
	            ELSE
	            BEGIN
	                SET @sUsuario = (
	                        SELECT top 1  Usuario_Bac
	                        FROM   BacCamSuda.dbo.Usuario_Bac_Otc
	                        WHERE  Sistema = 'DATATEC'
	                               AND Usuario_Exo = @sUsuario
	                    )
	                
	                SET @sCliente = @sContraparte										
	                
	    SET @sOperacion = CASE 
	                                       WHEN @sOperacion = 'O' THEN 'V'
	                                       ELSE 'C'
	                                  END
	                
	                SET @sContraparte = 'CORPBANCA'
	            END
	            
	            
	            
	            SET @sNula = CASE 
	                              WHEN @sClase = '50' THEN 'E'
	                              ELSE 'A'
	                         END
	        END
	        ELSE
	        BEGIN
	            SET @sUsuario = 'BOLSA'
	            
	            SET @sOperacion = CASE 
	                                   WHEN @sCliente = 'CORP' THEN 'C'
	                                   ELSE 'V'
	                              END ;  		
	            
	            SET @sMercado = 'PTAS';			
	            
	            SET @sNula = CASE 
	                              WHEN @xOperacion <> 'I' THEN 'E'
	            ELSE ''
	                        END ;
	            
	            SET @sCliente = CASE 
	                                 WHEN @sCliente = 'CORP' THEN @sContraparte
	                                 ELSE @sCliente
	                            END ;
	        END  
	        
	        
SELECT @susuario, @sEquivalente
 	        
	        SET @bentra = 0
	        
	        IF @fMonto = 0
	            SET @sNula = 'E'
	        
	        
	        -- Solo se procesan los registros clase 5 mercado 31 o 39
	        IF @idArchivo = @CONST_ARCHIVO_1
	        BEGIN
	            IF @sClase = 'I'
	                SET @bentra = 1
	            ELSE
	                SET @bentra = 0
	        END
	        
	        IF @idArchivo = @CONST_ARCHIVO_3
	        BEGIN
	            IF (
	                   (
	                       (CONVERT(INT, @sClase) = 5 OR CONVERT(INT, @sClase) = 50)
	                       AND (
	                               CONVERT(INT, @sTipoDolar) = 31
	                               OR CONVERT(INT, @sTipoDolar) = 39
	                           )
	                   )
	               )
	                SET @bentra = 1
	        END   
	        
	        
	        IF @bentra = 1
	        BEGIN
	            INSERT INTO [dbo].[MonitorFX_TblOperaciones]
	              (
	                [idArchivo],
	                [Oper_dFecha],
	                [Oper_Hora],
	                [Oper_sCodComprador],
	                [Oper_sNemoComprador],
	                [Oper_sCodVendedor],
	                [Oper_sNemoVendedor],
	                [Oper_fMontoOrigen],
	                [Oper_fPrecio],
	                [Oper_sOperacion],
	                [Oper_sNula],
	                [Oper_sEquivalencia],
	                [Oper_sIdentificacion],
	                [Oper_sCliente],
	                [Oper_sUsuario],
	                [Oper_sContraparte],
	                [Oper_sMercado],
	                [Oper_sFecha]
	              )
	            SELECT [idArchivo],
	                   [Oper_dFecha],
	                   [Oper_Hora],
	                   [Oper_sCodComprador],
	                   [Oper_sNemoComprador],
	                   [Oper_sCodVendedor],
	                   [Oper_sNemoVendedor],
	                   [Oper_fMontoOrigen],
	                   [Oper_fPrecio],
	                   [Oper_sOperacion],
	                   [Oper_sNula],
	                   [Oper_sEquivalencia],
	                   [Oper_sIdentificacion],
	                   [Oper_sCliente],
	                   [Oper_sUsuario],
	                   [Oper_sContraparte],
	                   [Oper_sMercado],
	                   [Oper_sFecha]
	            FROM   dbo.MonitorFX_TblOperacionesTMP
	            WHERE  idPosicion = @idPosicion
	            
	            
	            
	            SET @POSICION = SCOPE_IDENTITY()
	        END
	        
	        
	        --> Obtengo Rut de Cliente de la transaccion 
	        
	        --> ======================================================================================================================================================
	        
	        IF (@idArchivo = @CONST_ARCHIVO_3)
	        BEGIN
	            SELECT @iRut = rut,
	                   @iCodCliente = codigo
	            FROM   baccamsuda.dbo.view_cliente_datatec WITH (NOLOCK)
	            WHERE  RTRIM(LTRIM(nombre)) = RTRIM(LTRIM(@sCliente))
	        END
	        ELSE
	        BEGIN
	        	
	            SELECT @iRut = clrut,
	                   @iCodCliente     = clcodigo
	            FROM   bacparamsuda..sinacofi
	            WHERE  bolsa            = @sCliente
	        END 
	        
	        
	        DECLARE @nTipCli SMALLINT ;
	        
	        --> Obtengo tipo de cliente y mercado asociado    	
	        --> ======================================================================================================================================================
	        
	     SELECT @nTipCli = (
	                   SELECT cltipcli
	                   FROM   baccamsuda.dbo.view_cliente
	                   WHERE  clrut = @iRut
	                          AND clcodigo = @iCodCliente
	               );
	        
	        
	        
	        SET @sMercado = (CASE WHEN @nTipCli = 1 THEN 'PTAS' ELSE 'EMPR' END);
	        
	        --> Busca los valores por defecto 
	        --> ==========================================================================================
	        
	        SET @iRutBusqueda = 0
	        
	        --> Se define valor en 0 para default de Busqueda 
	        
	        
	        
	        IF EXISTS(
	               SELECT 1
	               FROM   dbo.CargaOperaciones_DefectoValores codv
	               WHERE  codv.idProducto = (
	                          CASE 
	                               WHEN @sMercado = 'PTAS' THEN @CONST_PRODUCTO_SPTI
	                               ELSE @CONST_PRODUCTO_SPTE
	                          END
	                      )
	                      AND codv.idOperacion = @iOperacion
	                      AND codv.idMoneda1 = @iMoneda1
	                      AND codv.idMoneda2 = @iMoneda2
	                          
	                          --AND codv.idPlataforma	= (CASE WHEN @sMercado ='PTAS' THEN @CONST_MERCADO_PTAS ELSE @CONST_MERCADO_EMPR END)
	                      AND codv.idPlataforma = (
	                              CASE 
	                                   WHEN @sMercado = 'PTAS' THEN @CONST_PRODUCTO_SPTI
	                                   ELSE @CONST_PRODUCTO_SPTE
	                              END
	                          )
	                      AND codv.idCliente = @iRut
	           )
	            SET @iRutBusqueda = @iRut 
	        
	        
	        
	        SELECT @iFormaPagoMN = codv.Default_iFormaPagoMN,
	               @iFormaPagomx        = codv.Default_iFormaPagoMX,
	               @iCodigoOMA          = codv.Default_sCodigoComercio,
	               @iCodigoComercio     = codv.Default_sCodigoOMA,
	               @iCodigoConcepto     = codv.Default_sCodigoConcepto
	        FROM   dbo.CargaOperaciones_DefectoValores codv
	        WHERE  codv.idProducto = (
	                   CASE 
	                        WHEN @sMercado = 'PTAS' THEN @CONST_PRODUCTO_SPTI
	                        ELSE @CONST_PRODUCTO_SPTE
	                   END
	               )
	               AND codv.idOperacion = @iOperacion
	               AND codv.idMoneda1 = @iMoneda1
	               AND codv.idMoneda2 = @iMoneda2
	               AND codv.idPlataforma = (
	                       CASE 
	                            WHEN @sMercado = 'PTAS' THEN @CONST_PRODUCTO_SPTI
	                            ELSE @CONST_PRODUCTO_SPTE
	                       END
	                   )
	               AND codv.idCliente = @iRutBusqueda
	        
	        DECLARE @iVamos SMALLINT 
	        SET @iVamos = CASE 
	                           WHEN @sOperacion = 'C' THEN 0
	                           ELSE 1
	                      END 
	        
	        
	        
	        DECLARE @fCostoFondo FLOAT,
	                @fTipoCambio FLOAT,
	                @fParidad FLOAT,
	                @fMontoUSD FLOAT,
	                @fMontoPesos FLOAT,
	                @fCostoParidad FLOAT,
	                @fCostoPrecio FLOAT,
	                @fCostoMontoUSD FLOAT,
	                @fCostoTipoCambio FLOAT ;
	        
	        
	        DECLARE @sCodigoPais_Entregamos VARCHAR(20) ;       
	        DECLARE @sCodigoPais_Recibimos VARCHAR(20) ;	        
	        DECLARE @dRecibimosValuta DATETIME	        
	        DECLARE @dEntregamosValuta DATETIME 
	        DECLARE @sNombreCliente VARCHAR(80) ;
	        DECLARE @iDias INT
	        
	        
	        SET @fCostoFondo = (
	                SELECT CASE 
	                            WHEN @sOperacion = 'C' THEN accoscomp
	       ELSE accosvent
	                       END
	                FROM   baccamsuda.dbo.meac
	            )
	        
	        
	        
	        SET @fParidad = 1;
	        
	        SET @fTipoCambio = @fPrecio
	        SET @fMontoUSD = @fMonto * @fParidad
	        SET @fMontoPesos = @fMontoUSD * @fTipoCambio  
	        SET @fCostoParidad = @fParidad 
	        SET @fCostoPrecio = @fCostoFondo
	        SET @fCostoMontoUSD = @fMontoUSD
	        SET @fCostoTipoCambio = @fCostoFondo
	        SET @sCodigoPais_Entregamos = CASE 
	                                           WHEN @sOperacion = 'C' THEN 
	                                                ';225;'
	                                           ELSE ';6;'
	                                      END
	        
	        SET @sCodigoPais_Recibimos = CASE 
	                                          WHEN @sOperacion = 'C' THEN ';6;'
	                                          ELSE ';225;'
	                                     END 
	        
	        
	        
	        SET @SQLString		= N'EXEC SP_MUESTRAFECHAVALIDA @Fecha OUTPUT, @Codigo, @profundidad'
	        
	        SET @ParmDefinition = N'@fecha DATETIME OUTPUT, @codigo VARCHAR(100),@profundidad INT'
	        
	        
	        SET @iDias = (
	                SELECT diasvalor
	                FROM   bacparamsuda.dbo.FORMA_DE_PAGO
	                       INNER 
	                
	                JOIN bacparamsuda.dbo.MONEDA_FORMA_DE_PAGO
	                            ON  codigo = mfcodfor
	                WHERE  mfcodmon         = @iMoneda2
	                       AND mfcodfor     = @iFormaPagoMN
	            )
	        
	        SET @sNombreCliente = (
	                SELECT c.Clnombre
	                FROM   BacParamSuda.dbo.CLIENTE c
	                WHERE  c.Clrut = @iRut
	                       AND c.Clcodigo = @iCodCliente
	            );		
	        
	        SET @dRecibimosValuta = DATEADD(DAY, @iDias, @dFecha)
	        
	        --> Recibimos Valuta 				
	        
	        
	        EXECUTE sp_executesql @SQLString,@ParmDefinition,@fecha = @dRecibimosValuta 
	        OUTPUT,@codigo = @sCodigoPais_Recibimos,@profundidad = 0
	        
	        SET @iDias = (
	                SELECT top 1 diasvalor
	                FROM   bacparamsuda.dbo.FORMA_DE_PAGO
	                       INNER 
	                
	                JOIN bacparamsuda.dbo.MONEDA_FORMA_DE_PAGO
	                            ON  codigo = mfcodfor
	                WHERE  mfcodmon         = @iMoneda1
	                       AND mfcodfor     = @iFormaPagoMX
	            )
	        
	        
	        
	        SET @dEntregamosValuta = DATEADD(DAY, @iDias, @dFecha)
	        
	        EXECUTE sp_executesql @SQLString, @ParmDefinition,@fecha = @dEntregamosValuta 
	        OUTPUT,@codigo = @sCodigoPais_Entregamos,@profundidad = 0   
	        
	        IF @dEntregamosValuta IS NULL
	            SET @dEntregamosValuta = @fFechaArchivo
	        

	        IF @dRecibimosValuta IS NULL
	            SET @dRecibimosValuta = @fFechaArchivo
	        
	        
	        
--select @sUsuario	        
	        UPDATE [MonitorFX_TblOperaciones]
	        SET    --SELECT 
	               
	               ARR_numero_operacion      = 0,
	               ARR_tipo_producto_nombre = @sMercado,
	               ARR_compra_venta          = @sOperacion,
	               ARR_cliente_rut           = @iRut,
	               ARR_cliente_Codigo        = @iCodCliente,	-- 05 
	               ARR_cliente               = @sNombreCliente,	-- 06  
	               ARR_moneda                = @sMoneda1,	-- 07
	               ARR_moneda_conversion     = @sMoneda2,	-- 08
	               ARR_monto                 = @fMontoUSD,	-- 09
	               
	               ARR_tipo_cambio_cierre = CASE 
	                                             WHEN @fTipoCambio = 0 THEN @fCostoTipoCambio
	                                             ELSE @fTipoCambio
	                                        END,	-- 10
	               ARR_tipo_cambio_transferencia = @fCostoTipoCambio,	-- 11
	               ARR_paridad_cierre_usd = @fParidad,	-- 12	
	               ARR_paridad_transferencia_usd = @fCostoParidad,	-- 13
	               ARR_equivalente_cierre_us = @fMontoUSD,	-- 14 
	               ARR_equivalente_transferencia_us = @fCostoMontoUSD,	-- 15
	               ARR_equivalente_transferencia_peso = @fMontoPesos,	-- 16
	               ARR_forma_pago_entregamos = @iFormaPagoMN,	-- 17
	               ARR_forma_pago_recibimos = @iFormaPagomx,	-- 18
	               ARR_usuario               = @sUsuario, -->'TSALGADO',	-- 19
	               ARR_origen                = case WHEN @idArchivo =3 THEN 'DATATEC' WHEN @idArchivo =1 THEN 'BOLSA' END,    -- 20 											, -- 20
	                                       	--ARR_fecha_proceso         = '2015-06-23',	--@sFecha, --|CONVERT(char(10),GETDATE(),112),								-- 21
	               ARR_fecha_proceso         = CONVERT(CHAR(10), @fFechaArchivo, 112),
	               ARR_codigo_oma            = @iCodigoOMA,	-- 22
	               ARR_estado                = @sEstado,	-- 23
	               ARR_codeject              = 0,	-- 24
	               ARR_valuta_entregamos     = CONVERT(CHAR(10), @dEntregamosValuta, 112),	-- 25
	               ARR_valuta_recibimos      = CONVERT(CHAR(10), @dRecibimosValuta, 112),	-- 26
	               ARR_rentabilidad          = 0,	-- 27
	               ARR_linea                 = '',	-- 28
	               ARR_entidad               = 1,	-- 29
	               ARR_precio_cierre_clp     = CASE 
	                                            WHEN @fPrecio = 0 THEN @fCostoTipoCambio
	                                            ELSE @fPrecio
	                                       END,	-- 30
	               ARR_precio_transferencia_clp = @fCostoPrecio,	-- 31
	               ARR_estado_captura_fwd = 0,	-- 32
	               ARR_tipo_operacion        = @sOperacion,	-- 33
	               ARR_contabiliza           = 'N',	-- 34
	               ARR_observacion           = '-',	-- 35
	               
	               ARR_en_donde_recibe_corresponsal = '',	-- 36
	               ARR_quien_entrega_corresponsal = '',	-- 37
	               ARR_desde_entrega_corresponsal = '',	-- 38
	               ARR_plaza_corrdonde       = 0,	-- 39
	               ARR_plaza_corrdesde       = 0,	-- 41                          
	               ARR_fpagomxcli            = 0,	-- 42
	               ARR_fpagomncli            = 0,	-- 43
	               ARR_fechaMnCl             = '',	-- 44                               
	               ARR_fechaMxCl             = '',	-- 45
	               ARR_codigo_area           = @sMercado,	-- 46
	               ARR_codigo_Comercio       = @iCodigoComercio,	-- 47
	               ARR_codigo_concepto       = @iCodigoConcepto,	-- 48
	               ARR_casamatriz            = 0,	-- 49
	               ARR_montofinal            = 0,	-- 50
	               ARR_dias                  = 0,	-- 51
	               ARR_girador_rut           = 0,	-- 52
				   ARR_girador_codigo        = 0,	-- 53
	               ARR_costofondo            = @fCostoFondo,	-- 54
	               ARR_arb_utilidad_peso     = 0,	-- 55
	               ARR_arb_tipo_cambio_MX = 0,	-- 56
	               ARR_fechavcto             = '',	-- 57
	               ARR_vamos                 = @iVamos,	-- 58
	               ARR_cod_corresponsal      = 0,	-- 59               
	               ARR_p_indFWD              = 'N',	-- 60
	               ARR_p_numFWD              = 0,	-- 61
	               ARR_fechaFwdini           = '',	-- 62
	               ARR_fechaFwdvcto          = '',	-- 63
	               ARR_mtipo_cambioFwd       = 0,	-- 64
	               ARR_prodFWD               = 0,	-- 65
	               ARR_netting               = 0,	-- 66
	               ARR_numero_tbtx           = 0,	-- 67
	               ARR_controla_tran         = 'N',	-- 68
	               ARR_gs_Corresponsal       = 0,	-- 69
	               ARR_p_ind_origen_manual = 1,	-- 70
	               ARR_cmx_punta_pizarra     = 0,	-- 71
	               ARR_cmx_tc_costo_trad     = 0,	-- 72
	               ARR_nResultadoTrans_Mo = 0,	-- 73
	               ARR_nResultadoTrans_Clp = 0,	-- 74
	               ARR_sCanal      = 0,	-- 75
	               ARR_usuario_digitador     = ''
	        WHERE  idPosicion                = @POSICION
	    END
	    
	    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	    -- ARCHIVOS EXTRANJEROS 
	    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	    
	    IF @idArchivo = @CONST_ARCHIVO_4 OR @idArchivo = @CONST_ARCHIVO_5 OR @idArchivo = @CONST_ARCHIVO_6
	    BEGIN
	        INSERT INTO [dbo].[MonitorFX_TblOperaciones]
	          (
	            [idArchivo],
	            [Oper_dFecha],
	            [Oper_Hora],
	            [Oper_sCodComprador],
	            [Oper_sNemoComprador],
	            [Oper_sCodVendedor],
	            [Oper_sNemoVendedor],
	            [Oper_fMontoOrigen],
	            [Oper_fPrecio],
	            [Oper_sOperacion],
	            [Oper_sNula],
	            [Oper_sEquivalencia],
	            [Oper_sIdentificacion],
	            [Oper_sCliente],
	            [Oper_sUsuario],
	            [Oper_sContraparte],
	            [Oper_sMercado],
	            [Oper_sFecha]
	          )
	        SELECT [idArchivo],
	               [Oper_dFecha],
	               [Oper_Hora],
	               [Oper_sCodComprador],
	               [Oper_sNemoComprador],
	               [Oper_sCodVendedor],
	               [Oper_sNemoVendedor],
	               [Oper_fMontoOrigen],
	               [Oper_fPrecio],
	               [Oper_sOperacion],
	               [Oper_sNula],
	               [Oper_sEquivalencia],
	               [Oper_sIdentificacion],
	               [Oper_sCliente],
	               [Oper_sUsuario],
	               [Oper_sContraparte],
	               [Oper_sMercado],
	               [Oper_sFecha]
	        FROM   dbo.MonitorFX_TblOperacionesTMP
	        WHERE  idPosicion = @idPosicion
	        
	        
	        
	        SET @POSICION = SCOPE_IDENTITY()
	        
	        
	        --SELECT @POSICION AS 'POSICION DEL ARCHIVO FINAL' 
	        -->	 Seleccion de Par de Monedas
	        
	        DECLARE @SourceBac             CHAR(3),
	                @BankDealinkCoded      VARCHAR(20),
	                @Terminal              VARCHAR(20),
	                @System                VARCHAR(50),
	                @SOfData               INT,
	                @CodigoSwifth          VARCHAR(20),
	                @PlataformaExterna     BIT
	        
	        IF (@sUsuario='acunan')
				SET @sUsuario= 'NACUNA'
	        
	        
	        IF @idArchivo = @CONST_ARCHIVO_4
	  BEGIN 
				SET @irut = 411885828 ;
				SET @iCodCliente = 1;
	        END
	         
	        IF @idArchivo = @CONST_ARCHIVO_5
	        BEGIN 
				SET @irut = 403770828 ;
				SET @iCodCliente = 1;
	        END
	        IF @idArchivo = @CONST_ARCHIVO_6
	        BEGIN 
				SET @irut = 472655828 ;
				SET @iCodCliente = 1;
	        END
	         

			SET @sNombreCliente = (
	                SELECT c.Clnombre
	                FROM   BacParamSuda.dbo.CLIENTE c
	                WHERE  c.Clrut = @iRut
	                       AND c.Clcodigo = @iCodCliente
	            );		


	        --> =========================================================================================================================
	        --> Saco informacion tabla de Sinacofi
	        --> =========================================================================================================================					    
	        DECLARE @BankDealingCode VARCHAR(30),
	                @BankName VARCHAR(30) ;
	        
	        SELECT @SourceBac = SourceBac,
	               @BankDealinkCoded        = BankDealinkCoded,
	               @Terminal                = Terminal,
	               @System                  = SYSTEM,
	               @SOfData                 = SOfData,
	               @CodigoSwifth            = CodigoSwifth,
	               @BankName				= substring(nombredata,1,30),
	               @PlataformaExterna       = PlataformaExterna
	        FROM   bacparamsuda.dbo.sinacofi
	        WHERE  PlataformaExterna        = 1
	        AND clrut = @IRUT 
	               --AND BankDealinkCoded     = @sCliente --> CITG  es para Citibank

	        
	        IF @idArchivo = @CONST_ARCHIVO_5 OR @idArchivo = @CONST_ARCHIVO_6 
	        BEGIN
	        	 SET @PureDealType = @sEquivalente
	        END
	        
	        ELSE BEGIN  
				SET @PureDealType = CASE 
											WHEN @sEquivalente = 'SPOT' THEN 2
											WHEN @sEquivalente = 'FORWARD' THEN 4
											WHEN @sEquivalente = 'SWAP' THEN 8
											WHEN @sEquivalente = 'NDF' THEN 4
									END
	        
	        END 
	        
	        DECLARE @TransType SMALLINT				                    
	        
	        SET @TransType = CASE 
	                              WHEN @sMercado = 'NEW' THEN 0
	                              ELSE 1
	                         END --> Corresponde si es una operacion nueva
	        

	        --> ============================================================================================================================================
	        --> Ejecucion de Procedimiento BACCamSuda.dbo.SP_GET_STDCHTDFILE_STATUS 
	        --> ============================================================================================================================================
	        
	        DECLARE @STATUS AS VARCHAR(100)
	        DECLARE @CORRELATIVO AS NUMERIC(10)
	        
	        
	        
	        CREATE TABLE #tmpSTATUS
	        (
	        	STATUS          VARCHAR(100),
	        	CORRELATIVO     NUMERIC(10)
	        )
	        
	        
	        INSERT INTO #tmpSTATUS
	        EXECUTE BACCamSuda.dbo.SP_GET_STDCHTDFILE_STATUS @fFechaArchivo, @SourceBac, 
	        @sIdentificacion, @PureDealType, @sFecha, @sHora,0, 0
	        SELECT @STATUS = STATUS,
	               @CORRELATIVO = correlativo
	        FROM   #tmpSTATUS 
	        
	        
	        
	        DROP TABLE #tmpSTATUS
	        
	        --> ============================================================================================================================================
	        
	        
	        
	        
	        
	        
	        SET @BankDealingCode = @sContraparte  
	        --SET @BankName = @sCliente 
	        
        
	        
	        --> DealerID == @sUsuario 
	           
	        SET @sOperacion = CASE WHEN @sEquivalente ='1' THEN 'C' ELSE 'V' END         
	        
	        
	        
	        DECLARE @TAKER_BUYS_BASE BIT 
	        
	        SET @TAKER_BUYS_BASE = CASE 
	                                    WHEN @sOperacion = 'Y' THEN 1
	                                    ELSE 0
	                               END ;
	        
	        
	        
	        DECLARE @IS_MX_BASE BIT
	        
	        SET @IS_MX_BASE = 0 ;
	        
	        
	        
	        DECLARE @DealType INT 
	        
	        SET @DealType = CASE 
	                             WHEN @TAKER_BUYS_BASE = @IS_MX_BASE THEN 1
	                             ELSE 2
	                    END; 
	        
	        
	        IF @idArchivo  = @CONST_ARCHIVO_5 OR @idArchivo = @CONST_ARCHIVO_6 
				SET @DealType = @sEquivalente 
	        
        
	        
	        IF @sMoneda2 = 'USD'
	        BEGIN
	            SET @iMoneda1 = (
	                    SELECT mncodmon
	                    FROM   MONEDA
	                    WHERE  mnnemo = @sMoneda1
	                ) ;
	            
	            SET @iMoneda2 = (
	                    SELECT mncodmon
	                    FROM   MONEDA
	                    WHERE  mnnemo = @sMoneda2
	                ) ;
	        END
	        ELSE
	        BEGIN
	            SET @iMoneda1 = (
	                    SELECT mncodmon
	                    FROM   MONEDA
	                    WHERE  mnnemo = @sMoneda2
	                ) ;
	            
	            SET @iMoneda2 = (
	                    SELECT mncodmon
	                    FROM   MONEDA
	                    WHERE  mnnemo = @sMoneda1
	                ) ;
	            
	            
	            
	            SET @sMoneda1 = @sMoneda2 ;
	            
	            SET @sMoneda2 = 'USD' ;
	        END
	        
	        
	        
	        DECLARE @DealVolumePeriod1Currency1 FLOAT,
	                @DealVolumePeriod1Currency2 FLOAT ;
	        
	        
	        
	        SET @DealVolumePeriod1Currency1 = CONVERT(FLOAT, @fMonto1)
	        
	        SET @DealVolumePeriod1Currency2 = CONVERT(FLOAT, @fMonto2)
	        
    
	        
	        
	        
	        DECLARE @SpotBasicRate FLOAT
	        DECLARE @ExchangeRatePeriod FLOAT 
	        DECLARE @RateCurrency1AgainstUsd FLOAT 
	        DECLARE @ValueDatePeriodCurrency1 DATETIME
	        
	        SET @SpotBasicRate = @fPrecio1
	        SET @ExchangeRatePeriod = @fPrecio2
	        SET @RateCurrency1AgainstUsd = @ExchangeRatePeriod
	        SET @ValueDatePeriodCurrency1 = CONVERT(DATETIME, @sVencimiento, 112)
	        
	        
	        
	        --> ==============================================================================================================================================
	        --> Si la operacion de Forward tiene fecha de vencimiento de HOY se Cambia a SPOT
	        --> ==============================================================================================================================================	
	        
	        IF @ValueDatePeriodCurrency1 = @dFecha
	           AND @PureDealType = 4
	        BEGIN
	            EXECUTE BACCamSuda.dbo.SP_STDCHARTERED_Change_PureDealType @dFecha, @sIdentificacion, 2 
	            
	            SET @PureDealType = 2
	        END
	        
	        --> ================================================================================================================================================	
	        
	        DECLARE @PointsPremiumRate FLOAT 
	        
	        DECLARE @FwdSpread FLOAT
	        
	        
	        SET @sOperacion = CASE  when @DealType = 1 THEN  'C' ELSE  'V'END 
	        SET @FwdSpread = 0
	        
	        
	        
	        IF @PureDealType = 4
	            SET @PointsPremiumRate = CONVERT(FLOAT, @fPrecio1) ;
			ELSE
				SET @PointsPremiumRate = 0 ;
	    

	        SET @PointsPremiumRate = CONVERT(FLOAT, @fPrecio1) ;
	        SET @SpotBasicRate = CONVERT(FLOAT, @fPrecio2) ;
	        SET @ExchangeRatePeriod = CONVERT(FLOAT, @fPrecio3) ;
	    
	    
	    CREATE TABLE #Resultado
	    (
	   	Estado1       INT,
	    	operacion     VARCHAR(200),
	    	estado        CHAR(3),
	    	rut           INT,
	    	CODIGO        INT,
	    	NOMBRE        VARCHAR(200),
	    	PAIS          INT
	    )
	    
	    
	    
	    
	    
	    
	    

	    
	    INSERT INTO #Resultado
	    EXECUTE BacCamSuda.dbo.SP_INSERT_STDCHARTERED_SPOT_FWD 
	    @dFecha , 
	    @iRut ,				
	    @iCodCliente ,
	    @SourceBac ,		
	    @DealType ,
	    @PureDealType ,		
	    @sIdentificacion, 
	    @TransType ,		
	    0 , --> Revision
	    @sIdentificacion,
	    @sUsuario ,
	    @dFecha ,
	    @sHora ,
	    @BankDealingCode,
	    @BankName ,
	    '' ,
	    @sMoneda1 ,
	    @sMoneda2 ,
	    @PointsPremiumRate,
	    @SpotBasicRate ,
	    
	    @sMercado ,
	    
	    @ExchangeRatePeriod,
	    @ValueDatePeriodCurrency1,
	    @DealVolumePeriod1Currency1,
	    @DealVolumePeriod1Currency2,
	    @ExchangeRatePeriod
    
 
	    
	    
	    --> Operacion SPOT																			
	    
	    --> ==================================[ Grabacion de SPOT Arbitrajes ]==================================
	    
	    IF @PureDealType = 2
	    BEGIN
	        SET @sMercado = 'ARBI'
	    END
	    
	    
	    
	    DECLARE @gs_Direction VARCHAR(1)
	    
	    
	    
	    SELECT @iMoneda1 = mncodmon,
	           @gs_Direction     = mnrrda
	    FROM   bacparamsuda.dbo.MONEDA
	    WHERE  mnnemo            = @sMoneda1
	    
	    
	    
	    SET @iMoneda2 = 13;
	    
	    SET @sMoneda2 = 'USD'; 
	    
	    
	    
	    --SELECT 'VB5 --> primer control'
	    
	    
	    
	    DECLARE @gs_Ex_Forma_Pago_Entregamos		SMALLINT 
	    DECLARE @gs_Ex_Forma_Pago_Recibimos			SMALLINT
	    DECLARE	@gs_Ex_Cod_Corresponsal				SMALLINT
	    DECLARE @gs_Ex_Corresponsal_Desde			SMALLINT
	    DECLARE @gs_Ex_Corresponsal_Donde			SMALLINT
	    DECLARE @gs_Ex_Corresponsal_Quien			SMALLINT
	    DECLARE @gs_Ex_PL_Corresponsal_Desde		SMALLINT
	    DECLARE @gs_Ex_PL_Corresponsal_Donde		SMALLINT
	    DECLARE @gs_Ex_PL_Corresponsal_Quien		SMALLINT
	    DECLARE @gs_Ex_Codigo_Oma					SMALLINT
	    DECLARE @gs_Ex_Codigo_Comercio VARCHAR(10)
	    DECLARE @gs_Ex_Codigo_Concepto VARCHAR(10)
	    
	    
	    
	    
	    DECLARE @idPlataforma SMALLINT 
	    
	    SET @idPlataforma = CASE 
	                             WHEN @PureDealType = 2 THEN @CONST_PRODUCTO_SPOT
	                             WHEN @PureDealType = 4 THEN @CONST_PRODUCTO_FWD
	                        END 					
	    
	    SET @iRutBusqueda = 0
	    
	    
	    
	    IF EXISTS(
	           SELECT 1
				 FROM   dbo.CargaOperaciones_DefectoValores codv
	           WHERE  codv.idProducto = 3 --> Citibank
	                  AND codv.idOperacion = @iOperacion
	                  AND codv.idMoneda1 = @iMoneda1
	                  AND codv.idMoneda2 = @iMoneda2
	                  AND codv.idPlataforma = @idPlataforma
	                  AND codv.idCliente = @iRut
	       )
	        SET @iRutBusqueda = @iRut 
	    
	    
	    SELECT @gs_Ex_Cod_Corresponsal = codv.Default_iCodCorresponsal,
	           @gs_Ex_Corresponsal_Desde     = codv.Default_iCodCorresponsal_Desde,
	           @gs_Ex_Corresponsal_Donde     = codv.Default_iCodCorresponsal_Donde,
	           @gs_Ex_Corresponsal_Quien     = codv.Default_iCodCorresponsal_Quien,
	           @gs_Ex_PL_Corresponsal_Desde = codv.Default_iPL_Corres_Desde,
	           @gs_Ex_PL_Corresponsal_Donde = codv.Default_iPL_Corres_Donde,
	           @gs_Ex_PL_Corresponsal_Quien = codv.Default_iPL_Corres_Quien,
	           @gs_Ex_Forma_Pago_Entregamos = codv.Default_iFormaPagoMN,
	           @gs_Ex_Forma_Pago_Recibimos = codv.Default_iFormaPagoMX,
	           @gs_Ex_Codigo_Oma             = codv.Default_sCodigoOMA,
	           @gs_Ex_Codigo_Comercio        = codv.Default_sCodigoComercio,
	           @gs_Ex_Codigo_Concepto        = codv.Default_sCodigoConcepto,
	           @gs_Ex_Operador               = codv.Default_sCodigoUsuario
FROM   dbo.CargaOperaciones_DefectoValores codv
	    WHERE  codv.idProducto = CASE 
	                                  WHEN @PureDealType = 2 THEN 1
	                                  ELSE 2
	                             END --> Citibank
	           AND codv.idOperacion = @iOperacion
	           AND codv.idMoneda1 = @iMoneda1
	           AND codv.idMoneda2 = @iMoneda2
	           AND codv.idPlataforma = 3 -->@idPlataforma
	           AND codv.idCliente = @iRutBusqueda
	    
	    
	    
	    SELECT @iOperacion,
	           @iMoneda1,
	           @iMoneda2,
	           @idPlataforma,
	           @iRutBusqueda
	    
	    
	    
	    
	    
	    --SELECT 'QUEDE ACA 3'
	    
	    DECLARE @iGirador_Rut SMALLINT
	    DECLARE @Girador_Codigo SMALLINT
	    DECLARE @fParidadBCCH FLOAT  
	    
	    
	    
	    SET @iGirador_Rut = 0
	    SET @Girador_Codigo = 0
	    SET @fCostoParidad = 0 
	    SET @fCostoPrecio = 0 
	    SET @fCostoMontoUSD = 0 
	    SET @fCostoTipoCambio = 0
	    SET @fCostoFondo = 0 
	    SET @fParidadBCCH = 0
	    
	    
	    
	    
	    
	    SET @SQLString = 
	        N'EXEC SP_MUESTRAFECHAVALIDA @Fecha OUTPUT, @Codigo, @profundidad'
	    
	    SET @ParmDefinition = 
	        N'@fecha DATETIME OUTPUT, @codigo VARCHAR(100),@profundidad INT'
	    
	    SET @iDias = (
	            SELECT top 1 diasvalor
	            FROM   bacparamsuda.dbo.FORMA_DE_PAGO
	                   INNER 
	            
	            JOIN bacparamsuda.dbo.MONEDA_FORMA_DE_PAGO
	                        ON  codigo = mfcodfor
	            WHERE  mfcodmon         = @iMoneda1
	                   AND mfcodfor     = @gs_Ex_Forma_Pago_Recibimos
	        )
	    
	    
	    
	    SET @dRecibimosValuta = DATEADD(DAY, @iDias, @dFecha)
	    
	    
	    EXECUTE sp_executesql @SQLString,@ParmDefinition,@fecha = @dRecibimosValuta 
	    OUTPUT,@codigo = @sCodigoPais_Entregamos,@profundidad = 0
	    
	    
	    
	    
	    
	    SET @iDias = (
	            SELECT TOP 1 diasvalor
	            FROM   bacparamsuda.dbo.FORMA_DE_PAGO
	                   INNER 
	            
	            JOIN bacparamsuda.dbo.MONEDA_FORMA_DE_PAGO
	                        ON  codigo = mfcodfor
	            WHERE  mfcodmon         = @iMoneda1
	                   AND mfcodfor     = @gs_Ex_Forma_Pago_Recibimos
	        )
	    
	    
	    
	    SET @dEntregamosValuta = DATEADD(DAY, @iDias, @dFecha)
	    
	    SET @SQLString =N'EXEC SP_MUESTRAFECHAVALIDA @Fecha OUTPUT, @Codigo, @profundidad'
	    
	    SET @ParmDefinition =N'@fecha DATETIME OUTPUT, @codigo VARCHAR(100),@profundidad INT'
	    
	    
	    
	    EXECUTE sp_executesql @SQLString, @ParmDefinition,@fecha = @dEntregamosValuta 
	    OUTPUT,@codigo = @sCodigoPais_Recibimos,@profundidad = 0 
	    
	    
	    SELECT @iMoneda1 = mncodmon,
	           @gs_Direction     = mnrrda
	    FROM   bacparamsuda.dbo.MONEDA
	    WHERE  mnnemo            = @sMoneda1
	    
	    
	    
	    SET @iMoneda2 = 13;
	    
	    SET @sMoneda2 = 'USD';				  
	    
	    SET @iRutBusqueda = 0
	    
	    
	    IF EXISTS(
	           SELECT 1
	           FROM   dbo.CargaOperaciones_DefectoValores codv
	           WHERE  codv.idProducto = CASE WHEN @idArchivo = @CONST_ARCHIVO_4 THEN 3 
											WHEN @idArchivo = @CONST_ARCHIVO_5 THEN 2
											WHEN @idArchivo = @CONST_ARCHIVO_6 THEN 1 
									   END --> Citibank
	                  AND codv.idOperacion = @iOperacion
	                  AND codv.idMoneda1 = @iMoneda1
	                  AND codv.idMoneda2 = @iMoneda2
	                  AND codv.idPlataforma = @idPlataforma
	                  AND codv.idCliente = @iRut
	       )
	        SET @iRutBusqueda = @iRut
	    
	    SELECT @gs_Ex_Forma_Pago_Mn = codv.Default_iFormaPagoMN,
	           @gs_Ex_Forma_Pago_Mx       = codv.Default_iFormaPagoMX,
	           @gs_Ex_AreaResponsable_Fwd = codv.Default_sCodAreaResponable,
	           @gs_Ex_CodCartNorm_Fwd     = codv.Default_sCodCartNormativa,
	           @gs_Ex_CodSubCartNorm      = codv.Default_sCodSubCartNormativa,
	           @gs_Ex_CodLibro            = codv.Default_sCodigoLibro,
	           @gs_Ex_CodCart             = codv.Default_iCodidogCartera,
	           @gs_Ex_Broker              = codv.Default_iCodigoBroker,
	           @gs_Ex_TipRetiro           = codv.Default_iTipRetiro,
	           @gs_Ex_Operador            = codv.Default_sCodigoUsuario
	    FROM   dbo.CargaOperaciones_DefectoValores codv
	    WHERE  codv.idProducto = CASE 
	                                  WHEN @PureDealType = 2 THEN 1
	                                  ELSE 2
	                             END --> Citibank
	           AND codv.idOperacion = @iOperacion
	           AND codv.idMoneda1 = @iMoneda1
	           AND codv.idMoneda2 = @iMoneda2
	           AND codv.idPlataforma = CASE WHEN @idArchivo = @CONST_ARCHIVO_4 THEN 3 
											WHEN @idArchivo = @CONST_ARCHIVO_5 THEN 2 
									   END 		 
	           AND codv.idCliente = @iRutBusqueda
	    
	    
	    
	    
--SELECT *  FROM 	CargaOperaciones_DefectoValores WHERE idProducto =      
	    
	    
	    SET @iClPais = (
	            SELECT Clpais
	            FROM   baccamsuda.dbo.view_cliente
	            WHERE  clrut            = @iRut
	                   AND clcodigo     = @iCodCliente
	        );
	    
	    
	    
	    DECLARE @cTipModa VARCHAR(1)
	    
	    SET @cTipModa = ISNULL(
	            (
	                SELECT 'C'
	                FROM   BacParamSuda.dbo.TABLA_GENERAL_DETALLE
	                WHERE  tbcateg        = 7000
	                       AND tbtasa     = @iMoneda1
	            ),
	            'E'
	        ) 
	    
	    
	    
	    DECLARE @gsBAC_DolarOBs FLOAT 		
	    
	    SET @gsBAC_DolarOBs = (
	            SELECT ISNULL(vmvalor, 0.0)
	            FROM   view_valor_moneda
	            WHERE  vmcodigo        = case when @iMoneda1 =13 then 994 ELSE @iMoneda1 END 
	                   AND vmfecha     = @dFecha
	        );
	    
	    
	    UPDATE BacParamSuda.dbo.MonitorFX_TblOperaciones
	    SET    ARR_cAreaResponsable			= @gs_Ex_AreaResponsable_Fwd,
	           ARR_cCodCartNorm				= @gs_Ex_CodCartNorm_Fwd,
	           ARR_cCodSubCartNorm			= @gs_Ex_CodSubCartNorm,
	           ARR_cCodLibro				= @gs_Ex_CodLibro,
	           ARR_nCodCart					= @gs_Ex_CodCart,
	           ARR_nBroker					= @gs_Ex_Broker,
	           ARR_cTipRetiro				= @gs_Ex_TipRetiro,
	           ARR_nEquUSD1					= @fmonto2,
	           ARR_nEquMda1					= @fmonto2 * @gsBAC_DolarOBs,
	           ARR_nMtoMda2					= @fmonto2,
	           ARR_nEquUSD2					= @fmonto2,
	           ARR_nEquMda2					= @fmonto2 * @gsBAC_DolarOBs,
	           ARR_nParMda1					= @fPrecio2,
			   ARR_nPreMda1					= @fMonto1 * @gsBAC_DolarOBs,
	           ARR_nParMda2					= @fPrecio2,
	           ARR_nPreMda2					= @gsBAC_DolarOBs,
	           ARR_nSpread					= @fPrecio3,
	           ARR_nPrecal					= 0,
	           ARR_nPlazo					= DATEDIFF(DAY, @dFecha, @ValueDatePeriodCurrency1),
	           ARR_nTasaUSD					= 0,
	           ARR_nTasaCon					= 0,
	           ARR_nMtoInMon1				= @fMonto1,
	           ARR_nMtoFiMon1				= @fMonto1,
	           ARR_nMtoInMon2				= @fMonto2,

	           ARR_nMtoFiMon2				= @fMonto2,
	           ARR_nMtodif					= 0,
	           ARR_nPrecioTransfer			= @fPrecio2,
	           ARR_cTipoSintetico			= ' ',
	           ARR_nPrecioSpot				= 0,
	           ARR_nPaisOrigen				= @iClPais,
	           ARR_nMonedaCompensacion		= 0,
	           ARR_cRiesgoSintetico			= ' ',
	           ARR_nPrecioReversaSint		= 0,
	           ARR_nPremio					= 0,
	           ARR_cTipOpc					= ' ',
	           ARR_nPrecioPunta				= 0,
	           ARR_nRemunera				= 0,
	           ARR_iMoneda1					= @iMoneda1,
	           ARR_iMoneda2					= @iMoneda2,
	           ARR_nTasa_Efectiva_Moneda1	= 0,
	           ARR_nTasa_Efectiva_Moneda2	= 0,
	           ARR_cOper_Rela_Spot			= '01',
	           ARR_cliente					= @sNombreCliente ,
	           ARR_monto					= @fMonto1,
	           ARR_forma_pago_recibimos =  @gs_Ex_Forma_Pago_Mn,
	           ARR_forma_pago_entregamos =  @gs_Ex_Forma_Pago_Mx
	           
	           	           
	    WHERE  idPosicion = @POSICION
	    
	    
	    
	    
	    
	    DECLARE @p_IndOrigenManual CHAR(1)   
	    DECLARE @p_NumFWD INT = 0	    
	    DECLARE @p_IndFWD CHAR(1) = 'N'	    
	    DECLARE @ProdFWD CHAR(1)
	    
			SET @p_IndOrigenManual = '0'   
			SET @p_NumFWD = 0	    
			SET @p_IndFWD = 'N'
	    
	    
	    
	    IF (@p_IndFWD = 'S')
	    BEGIN
	        SET @ProdFWD = 1
	    END
	    ELSE
	    BEGIN
	        SET @ProdFWD = 0
	    END
	    
	    
	    
	    SET @sEstado = ' ';
	    SET @iCodigoComercio = '' 
	    SET @iCodigoConcepto = ''
	    
	    
	    
	    UPDATE [MonitorFX_TblOperaciones]
	    SET    ARR_numero_operacion          = 0,
	           ARR_tipo_producto_nombre      = 'ARBI', -->CASE when @sMercado ,
	           ARR_compra_venta              = @sOperacion,
	           ARR_cliente_rut               = @iRut,
	           ARR_cliente_Codigo            = @iCodCliente,	-- 05 
	           ARR_cliente                   = @sNombreCliente,	-- 06  
	           ARR_moneda                    = @sMoneda1,	-- 07
	           ARR_moneda_conversion         = @sMoneda2,	-- 08
	           -->ARR_monto                     = @fMontoUSD,	-- 09
	           ARR_tipo_cambio_cierre        = @fPrecio2 ,-- @fTipoCambio,	-- 10
	           ARR_tipo_cambio_transferencia = @fCostoTipoCambio,	-- 11
	           ARR_paridad_cierre_usd        = @fParidad,	-- 12	
	           ARR_paridad_transferencia_usd = @fCostoParidad,	-- 13
	           ARR_equivalente_cierre_us     = @fMontoUSD,	-- 14 
	           ARR_equivalente_transferencia_us = @fCostoMontoUSD,	-- 15
	           ARR_equivalente_transferencia_peso = @fMontoPesos,	-- 16
			   

	      --     ARR_forma_pago_entregamos     = @gs_Ex_Corresponsal_DESDE,	-- 17
	      --     ARR_forma_pago_recibimos      = @gs_Ex_Corresponsal_Donde,	-- 18
	           ARR_usuario                   = @sUsuario											,							-- 19
	           ARR_origen                    = CASE 
													WHEN @idArchivo = 4 THEN 'REUTERS'
													WHEN @idArchivo = 5 THEN 'BARCLAYS'
													WHEN @idArchivo = 6 THEN 'STANDART'
											   END,	-- 20 											, -- 20
	           
	           ARR_fecha_proceso             = @sFecha,	--|CONVERT(char(10),GETDATE(),112),								-- 21
	           ARR_codigo_oma                = @iCodigoOMA,	-- 22
	           ARR_estado                    = @sEstado,	-- 23
	           ARR_codeject                  = @sVencimiento,	-- 24
	           ARR_valuta_entregamos         = CONVERT(CHAR(10), @dEntregamosValuta, 112),	-- 25
	           ARR_valuta_recibimos          = CONVERT(CHAR(10), @dRecibimosValuta, 112),	-- 26
	           ARR_rentabilidad              = 0,	-- 27
	           ARR_linea                     = '',	-- 28
	           ARR_entidad                   = 1,	-- 29
	           ARR_precio_cierre_clp         = @fPrecio,	-- 30
	           ARR_precio_transferencia_clp = @fCostoPrecio,	-- 31
	           ARR_estado_captura_fwd        = 0,	-- 32
	           ARR_tipo_operacion            = @sOperacion,	-- 33
	           ARR_contabiliza               = 'N',	-- 34
	           ARR_observacion               = '-',	-- 35
	           ARR_en_donde_recibe_corresponsal = @gs_Ex_Corresponsal_Donde,	-- 36
	           ARR_quien_entrega_corresponsal = @gs_Ex_Corresponsal_Quien,	-- 37
	           ARR_desde_entrega_corresponsal = @gs_Ex_Corresponsal_DESDE,	-- 38
	           ARR_plaza_corrdonde           = @gs_Ex_PL_Corresponsal_Donde,	-- 39
	           ARR_plaza_corrdesde           = @gs_Ex_PL_Corresponsal_Desde,	-- 41                          
	           ARR_plaza_corrquien           = @gs_Ex_PL_Corresponsal_Quien,
	           ARR_fpagomxcli                = 0,	-- 42
			   ARR_fpagomncli                = 0,	-- 43
	           ARR_fechaMnCl                 = '',	-- 44                               
	           ARR_fechaMxCl                 = '',	-- 45
	           ARR_codigo_area               = 'ARBI',	-- 46
	           ARR_codigo_Comercio           = @iCodigoComercio,	-- 47
	           ARR_codigo_concepto           = @iCodigoConcepto,	-- 48
	           ARR_casamatriz                = 0,	-- 49
	           ARR_montofinal                = 0,	-- 50
	           ARR_dias                      = 0,	-- 51
	           ARR_girador_rut               = 0,	-- 52
	           ARR_girador_codigo            = 0,	-- 53
	           ARR_costofondo                = @fCostoFondo,	-- 54
	           ARR_arb_utilidad_peso         = 0,	-- 55
	           ARR_arb_tipo_cambio_MX        = 0,	-- 56
	           ARR_fechavcto                 = '',	-- 57
	           ARR_vamos                     = @iVamos,	-- 58
	           ARR_cod_corresponsal          = @gs_Ex_Cod_Corresponsal,	-- 59
	           ARR_p_indFWD                  = 'N',	-- 60
	           ARR_p_numFWD                  = 0,	-- 61
	           ARR_fechaFwdini               = '',	-- 62
	           ARR_fechaFwdvcto              = '',	-- 63
	           ARR_mtipo_cambioFwd           = 0,	-- 64
	           ARR_prodFWD                   = 0,	-- 65ARR_netting =0, -- 66
	           ARR_numero_tbtx               = 0,	-- 67
	           ARR_controla_tran             = 'S',	-- 68
	           ARR_gs_Corresponsal           = '',	-- 69 PreGrabado_TxOnLine
	           ARR_p_ind_origen_manual       = 1,	-- 70
	           ARR_cmx_punta_pizarra         = 0,	-- 71
	           ARR_TipModa = 'E',
	           ARR_cmx_tc_costo_trad         = 0,	-- 72
	           ARR_nResultadoTrans_Mo        = 0,	-- 73ARR_nResultadoTrans_Clp=0, -- 74
	           ARR_sCanal                    = 0,	-- 75
	    ARR_usuario_digitador         = ''
	    WHERE  idPosicion                    = @POSICION
	END 
	
	
	
	IF @idArchivo = @CONST_ARCHIVO_8
	BEGIN
	    INSERT INTO [dbo].[MonitorFX_TblOperaciones]
	      (
	        [idArchivo],
	        [Oper_dFecha],
	        [Oper_Hora],
	        [Oper_sCodComprador],
	        [Oper_sNemoComprador],
	        [Oper_sCodVendedor],
	        [Oper_sNemoVendedor],
	        [Oper_fMontoOrigen],
	        [Oper_fPrecio],
	        [Oper_sOperacion],
	        [Oper_sNula],
	        [Oper_sEquivalencia],
	        [Oper_sIdentificacion],
	        [Oper_sCliente],
	        [Oper_sUsuario],
	        [Oper_sContraparte],
	        [Oper_sMercado],
	        [Oper_sFecha]
	      )
	    SELECT [idArchivo],
	           [Oper_dFecha],
	           [Oper_Hora],
	           [Oper_sCodComprador],
	           [Oper_sNemoComprador],
	           [Oper_sCodVendedor],
	           [Oper_sNemoVendedor],
	           [Oper_fMontoOrigen],
	           [Oper_fPrecio],
	           [Oper_sOperacion],
	           [Oper_sNula],
	           [Oper_sEquivalencia],
	           [Oper_sIdentificacion],
	           [Oper_sCliente],
	           [Oper_sUsuario],
	           [Oper_sContraparte],
	           [Oper_sMercado],
	           [Oper_sFecha]
	    FROM   dbo.MonitorFX_TblOperacionesTMP
	    WHERE  idPosicion = @idPosicion
	    
	    
	    
	    SET @POSICION = SCOPE_IDENTITY()
	    
	    
	    
	    DECLARE @FrecuenciaPago CHAR(10),
	            @sPeriodo VARCHAR(20),
	            @nFrecuenciaPago INT,
	            @nFrecuenciaCapital INT,
	            @FrecuenciaCapital INT
	    
	    
	    
	    DECLARE @Operador CHAR(10)
	    DECLARE @TipoFlujo INT  	
	    DECLARE @TipoSwap INT
	    DECLARE @Modalidad INT 				
	    
	    SELECT @idArchivo = idArchivo,
	           @sHora            = CONVERT(CHAR(8), GETDATE(), 108),
	           @sCliente         = 'STANDARD CHARTERED BANK',
	           @sUsuario         = 'IHAMEL',
	           @sContraparte     = '',
	           @sOperacion       = mftot.Oper_sOperacion,
	           @xOperacion       = mftot.Oper_sOperacion,
	           @sEquivalente     = mftot.Oper_sEquivalencia,
	           @sClase           = mftot.Oper_sNula,
	           @sTipoDolar       = mftot.Oper_sCodComprador,
	           @sMonto           = mftot.Oper_fMontoOrigen,
	           @sPrecio          = mftot.Oper_fPrecio,
	           @sMoneda1         = mftot.Oper_sCodComprador,
	           @sVencimiento     = mftot.Oper_fVencimiento,
	           @sMoneda2         = mftot.Oper_sCodVendedor,
	           @sPeriodo         = mftot.Oper_sCliente,
	           @iRut             = 472655828,
	           @iCodCliente      = 1,
	           @Operador         = 'IHAMEL',
	           @Modalidad        = 2,	--> Compensacion 
	           @TipoFlujo        = 1,	--> Activo
	           @TipoSwap         = 1,	--> IRS
	           @iMoneda1         = 13,
	           @iMoneda2         = 999 --> Moneda
	           
	           --@sMonto			 -->  Nocional		Monto --> @sMonto			= mftot.Oper_fMontoOrigen	,
	    FROM   dbo.MonitorFX_TblOperacionesTMP mftot
	    WHERE  idPosicion        = @idPosicion
	    
	    
	    
	    
	    
	    --> Se asigna Frecuencia Pago 							
	    
	    IF (@sPeriodo = 'ANNUAL')
	        SET @FrecuenciaPago = '1200360'
	    
	    IF (@sPeriodo = 'SEMMI-ANNUAL')
	        SET @FrecuenciaPago = '600180'
	    
	    IF (@sPeriodo = 'QUARTERLY')
	        SET @FrecuenciaPago = '30090'
	    
	    IF (@sPeriodo = 'MONTHLY')
	        SET @FrecuenciaPago = '10030'
	    
	    IF (@sPeriodo = 'SEMANAL')
	        SET @FrecuenciaPago = '0007'
	    
	    
	    
	    --> Se asigna codigo de Periocidad		
	    
	    IF (@sPeriodo = 'ANNUAL')
	        SET @nFrecuenciaPago = 1
	    
	    IF (@sPeriodo = 'SEMMI-ANNUAL')
	        SET @nFrecuenciaPago = 2
	    
	    IF (@sPeriodo = 'QUARTERLY')
	        SET @nFrecuenciaPago = 3
	    
	    IF (@sPeriodo = 'MONTHLY')
	        SET @nFrecuenciaPago = 4
	    
	    IF (@sPeriodo = 'SEMANAL')
	        SET @nFrecuenciaPago = 7
	    
	    
	    
	    SET @FrecuenciaCapital = 6
	    SET @nFrecuenciaCapital = 0
	    
	    
	    
	    DECLARE @ConteoDias SMALLINT               
	    DECLARE @Base SMALLINT    
	    DECLARE @CodigoBase SMALLINT
	    DECLARE @MonedaPago SMALLINT               
	    DECLARE @MedioPago SMALLINT
	    DECLARE @ConvenciosDias SMALLINT	
	    DECLARE @DiasReset SMALLINT
	    DECLARE @IntercambioNocional SMALLINT
	    DECLARE @indicador SMALLINT
	    DECLARE @sIndicador VARCHAR(50)	
	    
			SET @sIndicador = '1'
			SET @ConvenciosDias = 1			
			SET @DiasReset = 1
			SET @IntercambioNocional = 0 --> Falso
			SET @ConteoDias = 1                   
			SET @Base = 1    
			SET @CodigoBase = 1 
			SET @MonedaPago = 13                   
			SET @MedioPago = 128            
			SET @ConvenciosDias = 1			
			SET @DiasReset = 1
			SET @IntercambioNocional = 0 --> Falso 
	    
	    
	    
	    UPDATE MonitorFX_TblOperaciones
	    SET    Oper_sNemoComprador           = @sMoneda1,
	           Oper_sNemoVendedor            = @sMoneda2,
	           ARR_cliente_rut               = @irut,
	           ARR_cliente                   = @sCliente,
	           ARR_iMoneda1                  = @iMoneda1,
	           Oper_sUsuario                 = @operador,
	           ARR_iMoneda2                  = @iMoneda2,
	           ARR_FLACT_Modalidad           = @Modalidad,
	           ARR_FLACT_TipoFlujo           = 1,
	           ARR_FLACT_TipoSwap            = @TipoSwap,
	           ARR_FLACT_FrecuenciaPago      = @FrecuenciaPago,
	           ARR_FLACT_nFrecuenciaPago     = @nFrecuenciaPago,
	           ARR_FLACT_FrecuenciaCapital   = @FrecuenciaCapital,
	           ARR_FLACT_nFrecuenciaCapital  = @nFrecuenciaCapital,
	           ARR_FLACT_Indicador           = CONVERT(SMALLINT, @sIndicador),
	           ARR_FLACT_ConteoDias          = @ConteoDias,
	           ARR_FLACT_Base                = @Base,
	           ARR_FLACT_CodigoBase    = @CodigoBase,
	           ARR_FLACT_FechaEfectiva       = @dFecha,
	           ARR_FLACT_PrimerPago          = @dFecha,
	           ARR_FLACT_PenultimoPago       = '1900-01-01',
	           ARR_FLACT_Madurez             = CONVERT(DATETIME, @sVencimiento, 101),
	           ARR_FLACT_MonedaPago          = @MonedaPago,
	           ARR_FLACT_MedioPago           = @MedioPago,
	           ARR_FLACT_ConvenciosDias      = @ConvenciosDias,
	           ARR_FLACT_DiasReset           = @DiasReset,
	           ARR_FLACT_IntercambioNocional = @IntercambioNocional,
	           ARR_FLPAS_Modalidad           = @Modalidad,
	           ARR_FLPAS_TipoFlujo           = 2,
	           ARR_FLPAS_TipoSwap            = @TipoSwap,
	           ARR_FLPAS_FrecuenciaPago      = @FrecuenciaPago,
	           ARR_FLPAS_nFrecuenciaPago     = @nFrecuenciaPago,
	           ARR_FLPAS_FrecuenciaCapital   = @FrecuenciaCapital,
	           ARR_FLPAS_nFrecuenciaCapital  = @nFrecuenciaCapital,
	           ARR_FLPAS_Indicador           = CONVERT(SMALLINT, @sIndicador),
	           ARR_FLPAS_ConteoDias          = @ConteoDias,
	           ARR_FLPAS_Base                = @Base,
	           ARR_FLPAS_CodigoBase          = @CodigoBase,
	           ARR_FLPAS_FechaEfectiva       = @dFecha,
	           ARR_FLPAS_PrimerPago          = @dFecha,
	           ARR_FLPAS_PenultimoPago       = '1900-01-01',
	           ARR_FLPAS_Madurez             = CONVERT(DATETIME, @sVencimiento, 101),
	           ARR_FLPAS_MonedaPago          = @MonedaPago,
	           ARR_FLPAS_MedioPago           = @MedioPago,
	           ARR_FLPAS_ConvenciosDias      = @ConvenciosDias,
	           ARR_FLPAS_DiasReset           = @DiasReset,
	           ARR_FLPAS_IntercambioNocional = @IntercambioNocional,
	           ARR_nPrecioSpot               = @fPrecio,
	           ARR_monto                     = @fmonto,
	           ARR_nSpread                   = 0
	    WHERE  idPosicion                    = @POSICION
	END
	END
	ELSE BEGIN
		DELETE FROM  dbo.MonitorFX_TblOperacionesTMP WHERE idPosicion = @idPosicion 
	END   
END

GO
