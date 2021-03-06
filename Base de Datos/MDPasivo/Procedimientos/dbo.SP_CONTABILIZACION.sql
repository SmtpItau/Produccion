USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTABILIZACION]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTABILIZACION]
			(
                        @iFecha		DATETIME,
			@cTipo_Filtro	CHAR(01) -- T = todos; I = Inventario; C = Conversion
			)
AS BEGIN--INICIO SP

SET DATEFORMAT dmy

DECLARE @CONTADOR                   INTEGER
DECLARE @TOTAL                      INTEGER
DECLARE @CONTADOR_PARAMETRIA        INTEGER
DECLARE @TOTAL_PARAMETRIA           INTEGER
DECLARE @CONTADOR_OPERACION         INTEGER
DECLARE @TOTAL_OPERACION            INTEGER
DECLARE @CODIGO_OPERACION           CHAR   (05)
DECLARE @id_sistema	            CHAR   (03)
DECLARE @cProducto                  VARCHAR(05)
DECLARE @cSistema_ORIG              VARCHAR(03)
DECLARE @cProducto_ORIG             VARCHAR(05)
DECLARE @cGarantia                  VARCHAR(03)
DECLARE @cTipo_Plazo                VARCHAR(01)
DECLARE @cFinanciamiento            VARCHAR(03)
DECLARE @cCodigo_Sector             VARCHAR(01)
DECLARE @cCodigo_Subsector          VARCHAR(02)
DECLARE @cBanco_Corresponsal        VARCHAR(05)
DECLARE @cStatus_Cuota              VARCHAR(01)
DECLARE @cStatus_Colocacion         VARCHAR(01)
DECLARE @cReajustabilidad           VARCHAR(01)
DECLARE @cDivisa                    VARCHAR(03)
DECLARE @cTipo_Divisa               VARCHAR(01)
DECLARE @cTipo_Filtro_Sistema       CHAR(03)
DECLARE @cTipo_Filtro_AUX	    CHAR(03)


DECLARE @CREAJUSTABILIDAD_AUXILIAR  VARCHAR(01)
DECLARE @CDIVISA_AUXILIAR           VARCHAR(03)
DECLARE @CTIPO_DIVISA_AUXILIAR      VARCHAR(01)

DECLARE @codigo_evento              CHAR        (03)
DECLARE @tipo_cuenta                CHAR        (01)
DECLARE @codigo_moneda1             INTEGER
DECLARE @codigo_moneda2             INTEGER
DECLARE @codigo_instrumento         INTEGER
DECLARE @concepto_programa          CHAR       (05)
DECLARE @concepto_programa_antiguo  CHAR       (05)
DECLARE @concepto_programa_AUX      CHAR       (05)
DECLARE @numero_secuencia           INTEGER        
DECLARE @tipo_monto                 CHAR       (01)
DECLARE @moneda                     INTEGER
DECLARE @centro_origen              CHAR       (04)
DECLARE @centro_destino             CHAR       (04)
DECLARE @concepto_contable          CHAR       (05)
DECLARE @cuenta                     CHAR    (15)
DECLARE @ristra                     CHAR    (69)
DECLARE @ristra_sin_procesar        CHAR    (69)
DECLARE @tipo_resultado		    CHAR    (10)
DECLARE @sMonto                     VARCHAR (1500)
DECLARE @monto                      FLOAT
DECLARE @negativo                   CHAR    (01)
DECLARE @divisa                     INTEGER
DECLARE @cInstrumento               CHAR    (07)
DECLARE @nDivisa                    NUMERIC (05)
DECLARE @cOrigen_Moneda             CHAR    (02)
DECLARE @sRistra                    CHAR    (69)
DECLARE @codigo_productor           CHAR    (07)
DECLARE @codigo_operacion_ristra    CHAR    (03)
DECLARE @relacion_BCCH              NUMERIC (1)
DECLARE @mercado                    NUMERIC (1)
DECLARE @fecha_contable             DATETIME
DECLARE @fecha_referencia	    CHAR(08)
DECLARE @reversa                    INT
DECLARE @FECHA1                     DATETIME --FECHA PROCESO
DECLARE @FECHA2                     DATETIME --FECHA PROXIMO PROCESO
DECLARE @FECHA3                     DATETIME --FECHA FIN DE MES O CIERRE
DECLARE @PLAZA                      NUMERIC(5)
DECLARE @PAIS                       NUMERIC(5)

SET NOCOUNT ON

	IF NOT EXISTS ( SELECT 1 FROM TEMPDB..SYSOBJECTS WHERE NAME = '##CONTABILIZA') BEGIN
		SELECT 'SI'
		RETURN
	END

        SELECT TOP 1 
                 @FECHA1     = fecha_proceso
                ,@FECHA2     = fecha_proxima
                ,@PLAZA      = codigo_plaza
                ,@PAIS       = codigo_pais
        FROM VIEW_DATOS_GENERALES

        /* FECHA DE FIN DE MES 
        ---------------------- */
        CREATE TABLE #FECHA1( FECHA DATETIME , ESPECIAL CHAR(01) )
        INSERT INTO #FECHA1 EXEC SP_CON_FECHA_FERIADO @PAIS , @PLAZA , @iFecha , 1 , 0
        SELECT TOP 1 @fecha3 = FECHA FROM #FECHA1

	CREATE TABLE #CUENTA(
                             sCuenta    char(15)
                            ,sRistra    char(69)
                            ,sRistra_sin_procesar    char(69)
                        )

	CREATE TABLE #OPERACION(
                              sCodigo_Operacion   char(3)
                             ,nReversa            int
			     ,procesado 	  CHAR(1)
			     ,contador            NUMERIC(10) IDENTITY(1, 1)
			)


	CREATE TABLE #PARAMETRIA(
			      CONCEPTO_PROGRAMA		CHAR       (05)
                             ,NUMERO_SECUENCIA		INTEGER        
                             ,TIPO_MONTO		CHAR       (01)
                             ,MONEDA			INTEGER
                             ,CENTRO_ORIGEN		CHAR       (04)
                             ,CENTRO_DESTINO		CHAR       (04)
                             ,CONCEPTO_CONTABLE		CHAR       (05)
			     ,procesado 	  	CHAR(1)
			     ,contador            	NUMERIC(10) IDENTITY(1, 1)
			)


	IF EXISTS ( SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME='##ERRORES_CNT' ) BEGIN
		DROP TABLE [DBO].[##ERRORES_CNT]
	END
	CREATE TABLE ##ERRORES_CNT
			(
                         sCodigo             Char(20)
                        ,sDescripcion        Varchar(255)
                        ,sId_Sistema         char(3)
                        ,sProducto           char(7)
                        ,sConcepto_Contable  char(5)
                        ,sTipo_Plazo         char(1)
                        ,sFinanciamiento     char(3)
                        ,sSector             char(1)
                        ,sSub_Sector         char(2)
                        ,sCorresponsal       char(5)
                        ,sCuota              char(1)
                        ,sColocacion         char(1)
                        ,sReajustabilidad    char(1)
                        ,sDivisa             char(3)
                        ,sTipo_Divisa        char(1)
                        ,nNumero_Documento   numeric(10)
                        ,nNumero_Operacion   numeric(10)
                        ,nCorrelativo        numeric(3)
                        ,sCodigo_evento      char(3)
                        ,sCodigo_programa    char(5)
                        ,sCodigo_operacion   char(5)
                        ,sRistra             char(69)
                        ,sTipo_Cuenta        char(01)
                        )

	CREATE TABLE #exepciones_inventario(
			EI_id_sistema		CHAR(03),
			EI_codigo_producto	CHAR(05),
			EI_codigo_operacion	CHAR(03),
			EI_concepto_contable	CHAR(05))

	-- La Tabla #exepciones_inventario, sirve para no inventarear operaciones que tienen 2 conceptos contables
	-- inventarebles en la misma linea contable, por lo tanto se elimina 1 de ellos y se inventarea por otro evento
	-- contable que no sea el ALTA (MQ)

	INSERT INTO #exepciones_inventario SELECT 'BFW', '3'	,'AAU', 'CAPI'
	INSERT INTO #exepciones_inventario SELECT 'BFW', '3'	,'APU', 'CAPI'
	INSERT INTO #exepciones_inventario SELECT 'BTR', 'LCHP'	,'DRL', 'LCHR'
	INSERT INTO #exepciones_inventario SELECT 'BTR', 'LCHP'	,'DLC', 'LCHR'
	INSERT INTO #exepciones_inventario SELECT 'BFW', 'FWP'	,'AFB', 'CAPI'
	INSERT INTO #exepciones_inventario SELECT 'BFW', 'FWP'	,'ABO', 'CAPI'


	SELECT @cTipo_Filtro_Sistema=''

	IF @cTipo_Filtro='I'	SELECT @cTipo_Filtro_Sistema = 'INV'
	IF @cTipo_Filtro='C'	SELECT @cTipo_Filtro_Sistema = 'CON'

	IF @cTipo_Filtro='I'	SELECT @cTipo_Filtro_AUX = 'INV'
	IF @cTipo_Filtro='C'	SELECT @cTipo_Filtro_AUX = 'CVN'
	IF @cTipo_Filtro='T'	SELECT @cTipo_Filtro_AUX = 'CON'



	DELETE VIEW_RESULTADO_CONTABLE WHERE fecha_proceso = @iFecha AND tipo_resultado = @cTipo_Filtro_AUX

	SELECT *, contador = CONVERT(NUMERIC(10),0), procesado = 'N'  INTO #CONTABILIZA2  FROM ##CONTABILIZA

	SELECT nCampo = CONVERT(FLOAT,0), *, contador = CONVERT(NUMERIC(10),0), procesado = 'N' INTO #MONTO FROM ##CONTABILIZA

	DELETE #MONTO


	SELECT @TOTAL = COUNT(1) FROM ##CONTABILIZA

	SELECT @CONTADOR = 0

	SELECT @id_sistema  = '*' 

        SELECT 
             id_sistema
            ,cProducto              
            ,cTipo_Plazo            
            ,cFinanciamiento        
            ,cCodigo_Sector         
            ,cCodigo_Subsector      
            ,cBanco_Corresponsal    
            ,cStatus_Cuota          
            ,cStatus_Colocacion     
            ,cReajustabilidad       
            ,cDivisa                
            ,cTipo_Divisa      
            ,tipo_cuenta
            ,cproductor
            ,codigo_evento
            ,codigo_moneda1        
            ,codigo_moneda2        
            ,codigo_instrumento
            ,codigo_operacion
            ,Forma_pago
            ,mercado
            ,fecha_contable
  	    ,contador = IDENTITY( NUMERIC(10), 1, 1)
	    ,procesado = 'N'
	    ,fecha_referencia
	    ,cSistema_ORIG
	    ,cProducto_ORIG
        INTO #CONTABILIZADOR
	FROM #contabiliza2
	WHERE procesado = 'N'
	GROUP BY              
	     id_sistema
            ,cProducto              
            ,cTipo_Plazo            
            ,cFinanciamiento        
            ,cCodigo_Sector         
            ,cCodigo_Subsector      
            ,cBanco_Corresponsal    
            ,cStatus_Cuota          
            ,cStatus_Colocacion     
            ,cReajustabilidad       
            ,cDivisa                
            ,cTipo_Divisa      
            ,tipo_cuenta
            ,cproductor
            ,codigo_evento
            ,codigo_moneda1        
            ,codigo_moneda2        
            ,codigo_instrumento
            ,codigo_operacion
            ,Forma_pago
            ,mercado
            ,fecha_contable
	    ,fecha_referencia
	    ,cSistema_ORIG
	    ,cProducto_ORIG
        SET ROWCOUNT 0


WHILE 1=1 BEGIN

        SET ROWCOUNT 1


        SELECT
             @id_sistema	        = '*'

        SELECT
             @id_sistema	        = id_sistema
            ,@cProducto                 = cProducto              
            ,@cTipo_Plazo               = cTipo_Plazo            
            ,@cFinanciamiento           = cFinanciamiento        
            ,@cCodigo_Sector            = cCodigo_Sector         
            ,@cCodigo_Subsector         = cCodigo_Subsector      
            ,@cBanco_Corresponsal       = cBanco_Corresponsal    
            ,@cStatus_Cuota             = cStatus_Cuota          
            ,@cStatus_Colocacion        = cStatus_Colocacion     
            ,@cReajustabilidad          = cReajustabilidad       
            ,@cDivisa                   = cDivisa                
            ,@cTipo_Divisa              = cTipo_Divisa           
            ,@tipo_cuenta               = tipo_cuenta
            ,@codigo_productor          = cproductor
            ,@codigo_evento             = codigo_evento
            ,@codigo_moneda1            = codigo_moneda1        
            ,@codigo_moneda2            = codigo_moneda2        
            ,@codigo_instrumento        = codigo_instrumento
            ,@codigo_operacion_ristra   = codigo_operacion
            ,@relacion_BCCH             = Forma_pago
            ,@mercado                   = mercado
            ,@fecha_contable            = fecha_contable
	    ,@CONTADOR			= contador
	    ,@fecha_referencia		= fecha_referencia
	    ,@cSistema_ORIG		= csistema_ORIG
	    ,@cProducto_ORIG		= cProducto_ORIG
        FROM  #CONTABILIZADOR
	WHERE procesado = 'N'


        SET ROWCOUNT 0

	IF @id_sistema  = '*' 	BREAK

	UPDATE	#CONTABILIZA2
	SET	CONTADOR = @CONTADOR

	WHERE	@id_sistema	        = id_sistema	
	AND	@cProducto                 = cProducto              
	AND	@cTipo_Plazo               = cTipo_Plazo            
	AND	@cFinanciamiento           = cFinanciamiento        
	AND	@cCodigo_Sector            = cCodigo_Sector         
	AND	@cCodigo_Subsector         = cCodigo_Subsector      
	AND	@cBanco_Corresponsal       = cBanco_Corresponsal    
	AND	@cStatus_Cuota             = cStatus_Cuota          
	AND	@cStatus_Colocacion        = cStatus_Colocacion     
	AND	@cReajustabilidad          = cReajustabilidad       
	AND	@cDivisa                   = cDivisa                
	AND	@cTipo_Divisa              = cTipo_Divisa           
	AND	@tipo_cuenta               = tipo_cuenta
	AND	@codigo_productor          = cproductor
	AND	@codigo_evento             = codigo_evento
	AND	@codigo_moneda1            = codigo_moneda1        
	AND	@codigo_moneda2            = codigo_moneda2        
	AND	@codigo_instrumento        = codigo_instrumento
	AND	@codigo_operacion_ristra   = codigo_operacion
	AND	@relacion_BCCH             = Forma_pago
	AND	@mercado                   = mercado
	AND	@cSistema_ORIG		   = csistema_orig
	AND	@cProducto_ORIG		   = cProducto_ORIG



        /* BUSCA LOS CODIGOS DE OPERACION QUE SE CONTABILIZARAN
           ---------------------------------------------------- */
        DELETE #OPERACION

        IF @ID_SISTEMA IN ( 'BTR' , 'INV' , 'SWP' , 'BCC', 'PSV', 'BFW', 'SVL' )  BEGIN
            INSERT INTO #OPERACION  SELECT  codigo_operacion
                                           ,reversa
					   ,'N'
                                      FROM VIEW_CODIGO_OPERACION_CONTABLE 
                                     WHERE @id_sistema                                 = id_sistema        AND
                                           @codigo_productor                           = codigo_producto   AND
                                           @codigo_evento                              = evento            AND
                                           @tipo_cuenta                                = tipo_cuenta       AND                                           
                                           ISNULL(@relacion_BCCH,0)                    = relacion_BCCH     AND
                                           (@codigo_instrumento = instrumento OR instrumento= -1)          AND
                                           (@codigo_moneda1     = moneda1     OR moneda1    = -1)          AND
                                           (@codigo_moneda2     = moneda2     OR moneda2    = -1)          AND
                                           (@mercado            = mercado     OR mercado    = -1)

        END ELSE BEGIN

            SELECT @codigo_productor = @cProducto

            INSERT INTO #OPERACION  SELECT  codigo_operacion 
                                           ,reversa
                                           ,'N'
                                      FROM VIEW_CODIGO_OPERACION_CONTABLE
                                     WHERE @id_sistema                  = id_sistema        AND
                                           @cProducto                   = codigo_producto   AND
                                           @codigo_evento               = evento            AND
                                           @tipo_cuenta                 = tipo_cuenta       AND
                                           ISNULL(@relacion_BCCH,0)     = relacion_BCCH     AND
                                           (@codigo_moneda1=moneda1 OR moneda1=-1)          AND
                                           (@codigo_moneda2=moneda2 OR moneda2=-1)          AND
                                           (@mercado      = mercado OR mercado=-1)

        END
      
        /* CODIGOS DE OPERACION
        ----------------------- */
        IF (SELECT COUNT(1) FROM #OPERACION ) = 0 BEGIN
            
            INSERT ##ERRORES_CNT    
	    SELECT                       'NO CODIGO' 
                                        ,'NO EXISTE CODIGO DE OPERACION' 
                                        ,ISNULL(@ID_SISTEMA,' ')          
                                        ,ISNULL(@codigo_productor,' ' )
                                        ,ISNULL(@Concepto_Contable,' ')   
                                        ,ISNULL(@cTipo_Plazo,' ')         
                                        ,ISNULL(@cFinanciamiento,' ')     
                                        ,ISNULL(@cCodigo_Sector,' ')      
                                        ,ISNULL(@cCodigo_Subsector,' ')   
					,ISNULL(@cBanco_Corresponsal,' ') 
                                        ,ISNULL(@cStatus_Cuota,' ')       
					,ISNULL(@cStatus_Colocacion,' ')  
                                        ,ISNULL(@cReajustabilidad,' ')    
                                	,ISNULL(@cDivisa,' ')             
                                        ,ISNULL(@cTipo_Divisa,' ')        
                                        ,Numero_Documento
                                        ,Numero_Operacion
                                        ,Correlativo
                                        ,@codigo_evento
                                        ,@concepto_programa
                                        ,@codigo_operacion
                                        ,' '
                                        ,@tipo_cuenta
				FROM	#contabiliza2
				WHERE	CONTADOR = @CONTADOR
				                                      

	    UPDATE #CONTABILIZADOR SET procesado = 'S' WHERE contador = @CONTADOR

            CONTINUE

        END ELSE BEGIN                        

            WHILE 1=1
            BEGIN

                SET ROWCOUNT 1
                
                SELECT   @CODIGO_OPERACION   = '*'

                SELECT   @CODIGO_OPERACION   = sCodigo_Operacion
                        ,@REVERSA            = nReversa
			,@CONTADOR_OPERACION = CONTADOR
                FROM #OPERACION
		WHERE procesado = 'N'

                SET ROWCOUNT 0


		IF @CODIGO_OPERACION   = '*'	BREAK

                /* CURSOR DE PARAMETRIA_CONTABLE (PERFIL)
                ----------------------------------------- */
                IF @ID_SISTEMA IN ( 'BTR' , 'INV' , 'SWP' , 'BCC', 'PSV', 'BFW', 'SVL' ) BEGIN

                    SELECT @TOTAL_PARAMETRIA = COUNT(1)
                            FROM  VIEW_PARAMETRIA_CONTABLE	AS A
			    INNER JOIN VIEW_CONCEPTO_CONTABLE	AS B ON
                            	  A.id_sistema       = @id_sistema                 AND
                                  A.codigo_producto  = @codigo_productor           AND
                                  A.codigo_operacion = @CODIGO_OPERACION           AND
				  A.concepto_contable= B.concepto_contable         AND
                                  ((B.inventario     = 1 AND @reversa = -1)         OR
				   ( @cTipo_Filtro  = 'T'))

                END ELSE BEGIN
                    SELECT @TOTAL_PARAMETRIA = COUNT(1)
                            FROM  VIEW_PARAMETRIA_CONTABLE	AS A
			    INNER JOIN VIEW_CONCEPTO_CONTABLE	AS B ON
				  A.id_sistema       = @id_sistema                 AND
                                  A.codigo_producto  = @cProducto                  AND
				  A.codigo_operacion = @CODIGO_OPERACION           AND
				  A.concepto_contable= B.concepto_contable         AND
                                  ((B.inventario     = 1 AND @reversa = -1)         OR
				   ( @cTipo_Filtro  = 'T'))

                END


                SELECT @CONTADOR_PARAMETRIA = 1                
   
                IF @TOTAL_PARAMETRIA=0 BEGIN
    
                    IF ( @reversa <> 0 AND @cTipo_Filtro  = 'T' ) BEGIN
                        INSERT ##ERRORES_CNT 
			SELECT			     'NO PERFIL'
                                                    ,'NO SE HA ENCONTRADO EL PERFIL A CONTABILIZAR---'  
                                                    ,ISNULL(@ID_SISTEMA,' ')          
                                                    --,ISNULL(@CPRODUCTO,' ')           
                                                    ,ISNULL(@codigo_productor,' ' )
                                                    ,ISNULL(@CONCEPTO_CONTABLE,' ')   
                                                    ,ISNULL(@CTIPO_PLAZO,' ')         
                                                    ,ISNULL(@CFINANCIAMIENTO,' ')     
                                                    ,ISNULL(@CCODIGO_SECTOR,' ')      
                                                    ,ISNULL(@CCODIGO_SUBSECTOR,' ')   
                                                    ,ISNULL(@CBANCO_CORRESPONSAL,' ') 
                                                    ,ISNULL(@CSTATUS_CUOTA,' ')       
                                                    ,ISNULL(@CSTATUS_COLOCACION,' ')  
                                                    ,ISNULL(@CREAJUSTABILIDAD,' ')    
                                                    ,ISNULL(@CDIVISA,' ')             
                                                    ,ISNULL(@CTIPO_DIVISA,' ')        
                                                    ,NUMERO_DOCUMENTO
                                                    ,NUMERO_OPERACION
                                                    ,CORRELATIVO
                                                    ,@CODIGO_EVENTO
                                                    ,@CONCEPTO_PROGRAMA
                                                    ,@CODIGO_OPERACION
                                                    ,' '
                                                    ,@tipo_cuenta
				FROM	#contabiliza2
				WHERE	CONTADOR = @CONTADOR

                    END


		    UPDATE #OPERACION SET  procesado = 'S' WHERE contador = @CONTADOR_OPERACION
                    CONTINUE

                END
             
                WHILE @CONTADOR_PARAMETRIA <= @TOTAL_PARAMETRIA
                BEGIN                                
    
                    /* INFORMACION DE PARAMETRIA
                    ---------------------------- */
                    SET ROWCOUNT @CONTADOR_PARAMETRIA

                    IF @ID_SISTEMA IN ( 'BTR' , 'INV' , 'SWP' , 'BCC', 'PSV', 'BFW', 'SVL' ) BEGIN
                        SELECT       @CONCEPTO_PROGRAMA = CONCEPTO_PROGRAMA
                                    ,@NUMERO_SECUENCIA  = NUMERO_SECUENCIA
                                    ,@TIPO_MONTO        = TIPO_MONTO
                                    ,@MONEDA            = MONEDA
                                    ,@CENTRO_ORIGEN     = CENTRO_ORIGEN
                          	    ,@CENTRO_DESTINO    = CENTRO_DESTINO
                                    ,@CONCEPTO_CONTABLE = A.CONCEPTO_CONTABLE
                        FROM  VIEW_PARAMETRIA_CONTABLE		AS A
			INNER JOIN VIEW_CONCEPTO_CONTABLE	AS B ON
                              A.ID_SISTEMA       = @ID_SISTEMA             AND
                              A.CODIGO_PRODUCTO  = @codigo_productor       AND
                              A.CODIGO_OPERACION = @CODIGO_OPERACION	   AND
			      A.CONCEPTO_CONTABLE= B.CONCEPTO_CONTABLE     AND
                              ((B.INVENTARIO     =                  1)     OR
			       (@CTIPO_FILTRO  = 'T'              )) 
                              ORDER BY A.CONCEPTO_PROGRAMA

                    END ELSE BEGIN
                            SELECT       @CONCEPTO_PROGRAMA = CONCEPTO_PROGRAMA
                                        ,@NUMERO_SECUENCIA  = NUMERO_SECUENCIA
                                        ,@TIPO_MONTO        = TIPO_MONTO
      					,@MONEDA            = MONEDA
                                        ,@CENTRO_ORIGEN     = CENTRO_ORIGEN
                                        ,@CENTRO_DESTINO    = CENTRO_DESTINO
                                        ,@CONCEPTO_CONTABLE = A.CONCEPTO_CONTABLE
                            FROM       VIEW_PARAMETRIA_CONTABLE		AS A
	    	            INNER JOIN VIEW_CONCEPTO_CONTABLE	        AS B ON
			          A.ID_SISTEMA       = @ID_SISTEMA             AND
                                  A.CODIGO_PRODUCTO  = @CPRODUCTO              AND
                                  A.CODIGO_OPERACION = @CODIGO_OPERACION       AND
           			  A.CONCEPTO_CONTABLE= B.CONCEPTO_CONTABLE     AND
                                  ((B.INVENTARIO     =                  1)     OR   
                                   (@CTIPO_FILTRO    =                'T')) 
                            ORDER BY A.CONCEPTO_PROGRAMA
                    END                    


                    SET ROWCOUNT 0


		    IF @CTIPO_FILTRO  IN('I','C')
		    BEGIN

			IF EXISTS(	SELECT	*
					FROM	#exepciones_inventario
					WHERE	ei_id_sistema        = @id_sistema
					AND	ei_codigo_producto   = @cproducto
					AND	ei_codigo_operacion  = @codigo_operacion
					AND	ei_concepto_contable = @concepto_contable	)
			BEGIN
				SELECT @CONTADOR_PARAMETRIA  = @CONTADOR_PARAMETRIA + 1
	                        CONTINUE
			END
                    END                


                    /* TRAER MONTO 
                    -------------- */
                    SELECT @SMONTO = ''
                    DELETE #MONTO
                    IF @ID_SISTEMA IN ( 'BTR' , 'INV' , 'SWP' , 'BCC', 'PSV', 'BFW', 'SVL' ) BEGIN
                        SELECT @NEGATIVO = NEGATIVO
                                              FROM VIEW_CONCEPTO_PROGRAMA_CONTABLE 
                                             WHERE @ID_SISTEMA         = ID_SISTEMA        AND
				            @codigo_productor   = CODIGO_PRODUCTO       AND
                                          @CONCEPTO_PROGRAMA  = CONCEPTO_PROGRAMA

                        SELECT @SMONTO   = NOMBRE_CAMPO 
                                              FROM VIEW_CONCEPTO_PROGRAMA_CONTABLE 
                                             WHERE @ID_SISTEMA         = ID_SISTEMA            AND
                                                   @codigo_productor   = CODIGO_PRODUCTO       AND
                                                   @CONCEPTO_PROGRAMA  = CONCEPTO_PROGRAMA
                    END ELSE BEGIN
                        SELECT @NEGATIVO = NEGATIVO
                                              FROM VIEW_CONCEPTO_PROGRAMA_CONTABLE 
                                             WHERE @ID_SISTEMA         = ID_SISTEMA            AND
                                                   @CPRODUCTO          = CODIGO_PRODUCTO       AND
                                                   @CONCEPTO_PROGRAMA  = CONCEPTO_PROGRAMA
                        SELECT @SMONTO   = NOMBRE_CAMPO 
                                              FROM VIEW_CONCEPTO_PROGRAMA_CONTABLE 
                                             WHERE @ID_SISTEMA         = ID_SISTEMA            AND
                                                   @CPRODUCTO          = CODIGO_PRODUCTO       AND
                                                   @CONCEPTO_PROGRAMA  = CONCEPTO_PROGRAMA
                    END
   
                    IF ISNULL(@SMONTO,'NO') = 'NO' OR LEN(@SMONTO) = 0 BEGIN

                        INSERT ##ERRORES_CNT
			SELECT			     'NO CAMPO'
                                                    ,'NO SE HA ENCONTRADO LA RELACION CON EL CAMPO PARA' 
						    ,ISNULL(@ID_SISTEMA,' ')          
                                                    ,ISNULL(@codigo_productor,' ' )
                                                    ,ISNULL(@CONCEPTO_CONTABLE,' ')   
                                                    ,ISNULL(@CTIPO_PLAZO,' ')         
                                                    ,ISNULL(@CFINANCIAMIENTO,' ')     
                                                    ,ISNULL(@CCODIGO_SECTOR,' ')      
                                                    ,ISNULL(@CCODIGO_SUBSECTOR,' ')   
                                                    ,ISNULL(@CBANCO_CORRESPONSAL,' ') 
                                                    ,ISNULL(@CSTATUS_CUOTA,' ')       
                                                    ,ISNULL(@CSTATUS_COLOCACION,' ')  
                                                    ,ISNULL(@CREAJUSTABILIDAD,' ')    
                                                    ,ISNULL(@CDIVISA,' ')             
                                                    ,ISNULL(@CTIPO_DIVISA,' ')        
                                                    ,NUMERO_DOCUMENTO
                                                    ,NUMERO_OPERACION
                                                    ,CORRELATIVO
                                                    ,@CODIGO_EVENTO
                                                    ,@CONCEPTO_PROGRAMA
                                                    ,@CODIGO_OPERACION
                                                    ,' '
                                                    ,@tipo_cuenta
				FROM	#contabiliza2
				WHERE	CONTADOR = @CONTADOR

    
			SELECT @CONTADOR_PARAMETRIA  = @CONTADOR_PARAMETRIA + 1
                        CONTINUE
                    END                
    

		    SELECT @CORIGEN_MONEDA = ''


                    IF @ID_SISTEMA IN ( 'BCC' ) BEGIN                    
 		       SELECT @CORIGEN_MONEDA = ISNULL(ORIGEN_MONEDA, 'N') 
			 FROM VIEW_NOMBRE_CAMPO_CONTABLE
		        WHERE @ID_SISTEMA         = ID_SISTEMA	     AND
			      @cProducto          = CODIGO_PRODUCTO AND
    			      @SMONTO             = NOMBRE_CAMPO

                    END ELSE BEGIN
                        SELECT @CORIGEN_MONEDA = ISNULL(ORIGEN_MONEDA, 'N') 
			  FROM VIEW_NOMBRE_CAMPO_CONTABLE
                         WHERE @ID_SISTEMA         = ID_SISTEMA	     AND
    			       @codigo_productor   = CODIGO_PRODUCTO AND
    			       @SMONTO             = NOMBRE_CAMPO
                    END


                    SELECT @SMONTO ='SELECT ' + @SMONTO + ',* FROM #CONTABILIZA2 WHERE contador = ' + STR(@CONTADOR)

                    INSERT INTO #MONTO EXEC (@SMONTO)

                    SELECT @MONTO = NCAMPO FROM #MONTO


                        SELECT @CDIVISA_AUXILIAR          = @CDIVISA --@CODIGO_OPERACION_RISTRA
                          ,    @CTIPO_DIVISA_AUXILIAR     = @CTIPO_DIVISA
                          ,    @CREAJUSTABILIDAD_AUXILIAR = @CREAJUSTABILIDAD



			IF @ID_SISTEMA = 'BTR' AND @CDIVISA = 'USD' AND @CORIGEN_MONEDA = 'N' AND @CODIGO_EVENTO NOT IN ('TXU','TXP')
				SELECT @CORIGEN_MONEDA = 'D'



                        IF @CORIGEN_MONEDA = 'N'
			BEGIN

                                SELECT @CDIVISA_AUXILIAR          = 'CLP'
                                  ,    @CTIPO_DIVISA_AUXILIAR     = '0'
  	                          ,    @CREAJUSTABILIDAD_AUXILIAR = (CASE WHEN @CDIVISA = 'CLP' THEN '0'
                                                                      	  WHEN @CDIVISA = 'CLF' THEN '1' 
                                                                          WHEN @CDIVISA = 'CLI' THEN '2'
                                                                          WHEN @CDIVISA = 'USR' THEN '3'
                                                                          ELSE '0'
									  END)

	          		SELECT @MONEDA = ISNULL(MNCODMON, 999) FROM VIEW_MONEDA WHERE LEFT(mnsimbol,3) = @CDIVISA_AUXILIAR

			END



                        IF @CORIGEN_MONEDA = 'N1'
			BEGIN

                                SELECT @CDIVISA_AUXILIAR          = 'CLP'
                                  ,    @CTIPO_DIVISA_AUXILIAR     = '0'
  	                          ,    @CREAJUSTABILIDAD_AUXILIAR = (CASE WHEN @CDIVISA = 'CLP' THEN '0'
                                                                      	  WHEN @CDIVISA = 'CLF' THEN '1' 
                                                                          WHEN @CDIVISA = 'CLI' THEN '2'
                                                                          WHEN @CDIVISA = 'USR' THEN '3'
                                                                          ELSE '0'
									  END)

	          		SELECT @MONEDA = ISNULL(MNCODMON, 999) FROM VIEW_MONEDA WHERE LEFT(mnsimbol,3) = (CASE WHEN @cDivisa IN ('CLF', 'CLI', 'USR') THEN @cDivisa ELSE 'CLP' END)


			END



			IF @CORIGEN_MONEDA = 'D'
			BEGIN
				SELECT	@CDIVISA_AUXILIAR          = 'USD'
				,	@CTIPO_DIVISA_AUXILIAR     = '1'
				,	@CREAJUSTABILIDAD_AUXILIAR = '0'

				SELECT @MONEDA = ISNULL(MNCODMON, 999) FROM VIEW_MONEDA WHERE LEFT(mnsimbol,3) = @CDIVISA_AUXILIAR

			END



			IF @CORIGEN_MONEDA = '1'
			BEGIN
				SELECT @CDIVISA_AUXILIAR          = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = @CODIGO_MONEDA1 )
				SELECT @CTIPO_DIVISA_AUXILIAR     = (CASE WHEN @CDIVISA_AUXILIAR     IN ('CLP','CLF','CLI','USR') THEN '0' ELSE '1' END)
				SELECT @CREAJUSTABILIDAD_AUXILIAR = (CASE	WHEN @CDIVISA_AUXILIAR = 'CLP' THEN '0'
										WHEN @CDIVISA_AUXILIAR = 'CLF' THEN '1' 
                                                                                WHEN @CDIVISA_AUXILIAR = 'CLI' THEN '2'
                                                                                WHEN @CDIVISA_AUXILIAR = 'USR' THEN '3'
                                                                                ELSE '0' 
										END)

				SELECT @MONEDA = ISNULL(MNCODMON, 999) FROM VIEW_MONEDA WHERE LEFT(mnsimbol,3) = @CDIVISA_AUXILIAR

			END


			IF @CORIGEN_MONEDA = '2' BEGIN
				SELECT @CDIVISA_AUXILIAR          = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = @CODIGO_MONEDA2 )
				SELECT @CTIPO_DIVISA_AUXILIAR     = (CASE	WHEN @CDIVISA_AUXILIAR     IN ('CLP','CLF','CLI','USR') THEN '0' ELSE '1' END)
				SELECT @CREAJUSTABILIDAD_AUXILIAR = (CASE	WHEN @CDIVISA_AUXILIAR = 'CLP' THEN '0'
										WHEN @CDIVISA_AUXILIAR = 'CLF' THEN '1' 
										WHEN @CDIVISA_AUXILIAR = 'CLI' THEN '2'
										WHEN @CDIVISA_AUXILIAR = 'USR' THEN '3'
										ELSE '0' 
										END)

				SELECT @MONEDA = ISNULL(MNCODMON, 999) FROM VIEW_MONEDA WHERE LEFT(mnsimbol,3) = @CDIVISA_AUXILIAR


			END
                           



			IF @CORIGEN_MONEDA = 'P1'
			BEGIN
                                SELECT @CDIVISA_AUXILIAR          = 'CLP'
                                  ,    @CTIPO_DIVISA_AUXILIAR     = '0'
  	                          ,    @CREAJUSTABILIDAD_AUXILIAR = (CASE WHEN @CDIVISA = 'CLP' THEN '0'
                                                                      	  WHEN @CDIVISA = 'CLF' THEN '1' 
                                                                          WHEN @CDIVISA = 'CLI' THEN '2'
                                                                          WHEN @CDIVISA = 'USR' THEN '3'
                                                                          ELSE '0'
									  END)

	          		SELECT @MONEDA = ISNULL(MNCODMON, 999) FROM VIEW_MONEDA WHERE LEFT(mnsimbol,3) = @CDIVISA_AUXILIAR
				SELECT @CODIGO_OPERACION_RISTRA = LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = @CODIGO_MONEDA1

			END


			IF @CORIGEN_MONEDA = 'P2' BEGIN
                                SELECT @CDIVISA_AUXILIAR          = 'CLP'
                                  ,    @CTIPO_DIVISA_AUXILIAR     = '0'
  	                          ,    @CREAJUSTABILIDAD_AUXILIAR = (CASE WHEN @CDIVISA = 'CLP' THEN '0'
                                                                      	  WHEN @CDIVISA = 'CLF' THEN '1' 
                                                                          WHEN @CDIVISA = 'CLI' THEN '2'
                                                                          WHEN @CDIVISA = 'USR' THEN '3'
                                                                          ELSE '0'
									  END)

	          		SELECT @MONEDA = ISNULL(MNCODMON, 999) FROM VIEW_MONEDA WHERE LEFT(mnsimbol,3) = @CDIVISA_AUXILIAR
				SELECT @CODIGO_OPERACION_RISTRA = LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = @CODIGO_MONEDA2
			END


			IF @CORIGEN_MONEDA = 'X' BEGIN
				SELECT @CDIVISA_AUXILIAR          = @CDIVISA_AUXILIAR
				SELECT @CTIPO_DIVISA_AUXILIAR     = (CASE WHEN @CDIVISA_AUXILIAR     IN ('CLP','CLF','CLI','USR') THEN '0' ELSE '1' END)
				SELECT @CREAJUSTABILIDAD_AUXILIAR = (CASE	WHEN @CDIVISA_AUXILIAR = 'CLP' THEN '0'
										WHEN @CDIVISA_AUXILIAR = 'CLF' THEN '1' 
										WHEN @CDIVISA_AUXILIAR = 'CLI' THEN '2'
										WHEN @CDIVISA_AUXILIAR = 'USR' THEN '3'
										ELSE '0' 
										END)

				SELECT @MONEDA = ISNULL(MNCODMON, 999) FROM VIEW_MONEDA WHERE LEFT(mnsimbol,3) = @CDIVISA_AUXILIAR

			END









                        /* SOLO PARA INVENTARIO
                        ----------------------- */

			SELECT @CONCEPTO_PROGRAMA_ANTIGUO = @CONCEPTO_PROGRAMA

                        IF @cTipo_Filtro IN('I', 'C') BEGIN

				SELECT	@concepto_programa_AUX = ''                            
				SELECT	@concepto_programa_AUX = CONCEPTO_PROGRAMA,
				 	@TIPO_MONTO 	       = TIPO_MONTO
				FROM	VIEW_PARAMETRIA_CONTABLE
				WHERE	ID_SISTEMA        = 'SCE' 
				AND	CODIGO_PRODUCTO   = @cTipo_Filtro_Sistema
				AND	CODIGO_OPERACION  = @cTipo_Filtro_Sistema
				AND	CONCEPTO_CONTABLE = @CONCEPTO_CONTABLE 

				IF @CONCEPTO_PROGRAMA <> @concepto_programa_AUX  AND  @concepto_programa_AUX <> ''
					SELECT @CONCEPTO_PROGRAMA = @concepto_programa_AUX

                          
                        END

-- sp_helptext SP_CON_BUSCAR_CUENTA   

                        /* BUSCAR LA CUENTA Y LA RISTRA
                        ------------------------------- */

                        DELETE #CUENTA                                                                              
                        INSERT #CUENTA EXEC SP_CON_BUSCAR_CUENTA   @CONCEPTO_CONTABLE
                                                               ,   @CPRODUCTO
                                                               ,   @CTIPO_PLAZO
                                                               ,   @CFINANCIAMIENTO
           						       ,   @CCODIGO_SECTOR
                                                               ,   @CCODIGO_SUBSECTOR
                                                               ,   @CBANCO_CORRESPONSAL
                                                               ,   @CSTATUS_CUOTA
                                                               ,   @CSTATUS_COLOCACION
                                                               ,   @CREAJUSTABILIDAD_AUXILIAR
						               ,   @CDIVISA_AUXILIAR
                                                               ,   @CTIPO_DIVISA_AUXILIAR
                                                               ,   @CODIGO_OPERACION_RISTRA
                                                               ,   @ID_SISTEMA
    
    


                        IF ( SELECT SCUENTA FROM #CUENTA ) = ' ' BEGIN    
                               
		           SET @SRISTRA = ( SELECT SRISTRA FROM #CUENTA )

                            UPDATE #CUENTA 
                            SET SCUENTA = REPLICATE('0',15)
--                                SRISTRA = 'RISTRA DE PRUEBAS'
    
                        END

                        SELECT	@CUENTA              = ISNULL(SCUENTA,'') ,
				@RISTRA              = ISNULL(SRISTRA,'') ,
				@RISTRA_SIN_PROCESAR = ISNULL(SRISTRA_SIN_PROCESAR,'') 
			FROM	#CUENTA





                        INSERT VIEW_RESULTADO_CONTABLE
    				(
                                                     FECHA_PROCESO               
                                                    ,NUMERO_OPERACION 
                                                    ,NUMERO_DOCUMENTO 
                                                    ,CORRELATIVO  
                                                    ,ID_SISTEMA     
                                                    ,CODIGO_PRODUCTO 
                                                    ,CODIGO_OPERACION 
                                                    ,CONCEPTO_PROGRAMA
				                    ,NUMERO_SECUENCIA 
                                                    ,FECHA_CONTABLE              
                                                    ,DIVISA      
                                                    ,CUENTA_CONTABLE 
						    ,TIPO_MONTO 
                                                    ,CENTRO_ORIGEN 
                                                    ,CENTRO_DESTINO
                                                    ,CONCEPTO_CONTABLE 
                                                    ,MONTO 
						    ,RISTRA_CONTABLE
                                                    ,RISTRA_SIN_PROCESAR
                                                    ,TIPO_RESULTADO
                                                    ,RUT_CLIENTE
                                                    ,CODIGO_MONEDA1
                                                    ,CODIGO_MONEDA2
                                                    ,CONCEPTO_PROGRAMA_ANTIGUO
						    ,fecha_contabiliza
						    ,fecha_referencia
                                                    ,sucursal_contabiliza
						    ,sistema_original
						    ,producto_original
                                                )
                                          SELECT    DISTINCT
                                                     @IFECHA
                                                    ,NUMERO_OPERACION      
                                                    ,NUMERO_DOCUMENTO      
                                                    ,CORRELATIVO           
                                                    ,@ID_SISTEMA 
                                                    ,( CASE	WHEN @ID_SISTEMA IN ( 'BTR' , 'INV' , 'SWP' , 'BCC', 'PSV', 'BFW', 'SVL') THEN @codigo_productor
--								WHEN @ID_SISTEMA IN ( 'SVL' ) THEN @cProducto_ORIG
								ELSE @CPRODUCTO END )
                                                    ,@CODIGO_OPERACION
                                                    ,@CONCEPTO_PROGRAMA 
                                                    ,@NUMERO_SECUENCIA 
                                                    ,@IFECHA
                                                    ,@MONEDA 
                                                    ,@CUENTA --CUENTA
                                                    ,@TIPO_MONTO 
                                                    ,@CENTRO_ORIGEN 
                                                    ,@CENTRO_DESTINO 
                                                    ,@CONCEPTO_CONTABLE 
                                                    ,nCampo  --MONTO
                                                    ,@RISTRA --RISTRA
                                                    ,@RISTRA_SIN_PROCESAR
                                                    ,@cTipo_Filtro_AUX
                                             	    ,RUT
                                                    ,@CODIGO_MONEDA1
                                                    ,@CODIGO_MONEDA2
						    ,@CONCEPTO_PROGRAMA_ANTIGUO
						    ,CASE WHEN @reversa = 0 THEN @FECHA2 
						                            ELSE @iFecha
			  		             END	
						    ,@fecha_referencia
                                                    ,sucursal_contable
						    ,@cSistema_ORIG
						    ,@cProducto_ORIG
				FROM	#MONTO
				WHERE	CONTADOR = @CONTADOR
				and	nCampo <> 0





                        
			SELECT @CONTADOR_PARAMETRIA  = @CONTADOR_PARAMETRIA + 1

	        
--                    END                

            END
                        
                UPDATE #OPERACION SET  procesado = 'S' WHERE contador = @CONTADOR_OPERACION

            END

--------------------------------------------------------------       

        END                

        UPDATE #CONTABILIZADOR SET procesado = 'S' WHERE contador = @CONTADOR

    END


	SET ROWCOUNT 0

	if @cTipo_Filtro <> 'C'
	BEGIN
-- select * from VIEW_CONTABILIZA_MAYOR

		DELETE	VIEW_CONTABILIZA_MAYOR
		WHERE	fecha       = @iFecha
		AND	Tipo_Filtro = @cTipo_Filtro

		INSERT INTO VIEW_CONTABILIZA_MAYOR(
			fecha
			,Tipo_Filtro		    
			,id_sistema	            
			,cProducto                  
			,cTipo_Plazo                
			,cFinanciamiento            
			,cCodigo_Sector             
			,cCodigo_Subsector          
			,cBanco_Corresponsal        
			,cStatus_Cuota              
			,cStatus_Colocacion         
			,cReajustabilidad           
			,cDivisa                    
			,cTipo_Divisa               
			,valor_compra	            
			,valor_presente	            
			,valor_venta	            
			,utilidad	            
			,perdida	            
			,interes_papel	            
			,reajuste_papel	            
			,interes_pacto	            
			,reajuste_pacto	            
			,valor_cupon	            
			,nominalpesos	            
			,nominal	            
			,valor_comprahis	    
			,dif_ant_pacto_pos	    
			,dif_ant_pacto_neg	    
			,dif_valor_mercado_pos	    
			,dif_valor_mercado_neg	    
			,rev_valor_mercado_pos	    
			,rev_valor_mercado_neg	    
			,valor_futuro	            
			,Valor_perdida_usd	    
			,Valor_utilidad_usd	    
			,Valor_perdida_clp	    
			,Valor_utilidad_clp
			,pago_parcial
			,recaudacion_parcial
			,diferencia_recibida
			,swp_perdida_mercado		
			,swp_capital_moneda1		
			,swp_capital_moneda2		
			,swp_diferencia_cambio		
			,swp_diferencia_recibida	
			,swp_diferencia_recibida_CP	
			,swp_diferencia_recibida_SP	
			,swp_diferencia_recibida_LB	
			,swp_entrega_principales_m1	
			,swp_entrega_principales_m2	
			,swp_interes_cobrado		
			,swp_interes_cobrado_SP		
			,swp_interes_cobrado_CP		
			,swp_interes_cobrado_LB		
			,swp_interes_pagado		
			,swp_interes_pagado_SP		
			,swp_interes_pagado_CP		
			,swp_interes_pagado_LB		
			,swp_perd_dif_pre_CP		
			,swp_perd_dif_pre_SP		
			,swp_perd_dif_pre_LB		
			,swp_perd_diferida		
			,swp_diferencia_contra		
			,swp_dif_pagada_SP		
			,swp_dif_pagada_CP		
			,swp_dif_pagada_LB		
			,swp_reajuste_dev		
			,swp_reajuste			
			,swp_util_dif_pre_CP		
			,swp_util_dif_pre_SP		
			,swp_util_dif_pre_LB		
			,swp_util_diferida		
			,swp_dif_recibida_SP		
			,swp_dif_recibida_CP		
			,swp_dif_recibida_LB		
			,swp_diferencia_favor		
			,fwd_capital_mx1
			,fwd_capital_mx2
			,fwd_dif_cambio
			,fwd_dif_pago_cp
			,fwd_dif_pago_sp
			,fwd_dif_pago_lb
			,fwd_perdida_cp
			,fwd_perdida_sp
			,fwd_perdida_lb
			,fwd_utilidad_cp
			,fwd_utilidad_sp
			,fwd_utilidad_lb
			,fwd_difpre_util
			,fwd_difval_util
			,fwd_difpre_Perd
			,fwd_difval_Perd

			,fwd_difpre_util_rv
			,fwd_difpre_Perd_rv
			,fwd_reajuste


			,tipo_cuenta                
			,cproductor                 
			,codigo_evento              
			,codigo_moneda1             
			,codigo_moneda2             
			,codigo_instrumento         
			,numero_operacion           
			,numero_documento           
			,correlativo                
			,forma_pago                 
			,rut                        
			,Codigo_Operacion           
			,mercado                    
			,fecha_contable             
			,archivo_proceso	    
			,fecha_historica	    
			,tipoper		    
			,tipopero		    
			,cartera		    
			,numero_SPOT
			,sistema_original)


		SELECT	@iFecha
			,@cTipo_Filtro
			,id_sistema	            
			,cProducto                  
			,cTipo_Plazo                
			,cFinanciamiento            
			,cCodigo_Sector             
			,cCodigo_Subsector          
			,cBanco_Corresponsal        
			,cStatus_Cuota              
			,cStatus_Colocacion         
			,cReajustabilidad           
			,cDivisa                    
			,cTipo_Divisa               
			,valor_compra	            
			,valor_presente	            
			,valor_venta	            
			,utilidad	            
			,perdida	            
			,interes_papel	            
			,reajuste_papel	            
			,interes_pacto	            
			,reajuste_pacto	            
			,valor_cupon	            
			,nominalpesos	            
			,nominal	            
			,valor_comprahis	    
			,dif_ant_pacto_pos	    
			,dif_ant_pacto_neg	    
			,dif_valor_mercado_pos	    
			,dif_valor_mercado_neg	    
			,rev_valor_mercado_pos	    
			,rev_valor_mercado_neg	    
			,valor_futuro	            
			,Valor_perdida_usd	    
			,Valor_utilidad_usd	    
			,Valor_perdida_clp	    
			,Valor_utilidad_clp
			,pago_parcial
			,recaudacion_parcial
			,diferencia_recibida
			,swp_perdida_mercado		
			,swp_capital_moneda1		
			,swp_capital_moneda2		
			,swp_diferencia_cambio		
			,swp_diferencia_recibida	
			,swp_diferencia_recibida_CP	
			,swp_diferencia_recibida_SP	
			,swp_diferencia_recibida_LB	
			,swp_entrega_principales_m1	
			,swp_entrega_principales_m2	
			,swp_interes_cobrado		
			,swp_interes_cobrado_SP		
			,swp_interes_cobrado_CP		
			,swp_interes_cobrado_LB		
			,swp_interes_pagado		
			,swp_interes_pagado_SP		
			,swp_interes_pagado_CP		
			,swp_interes_pagado_LB		
			,swp_perd_dif_pre_CP		
			,swp_perd_dif_pre_SP		
			,swp_perd_dif_pre_LB		
			,swp_perd_diferida		
			,swp_diferencia_contra		
			,swp_dif_pagada_SP		
			,swp_dif_pagada_CP		
			,swp_dif_pagada_LB		
			,swp_reajuste_dev		
			,swp_reajuste			
			,swp_util_dif_pre_CP		
			,swp_util_dif_pre_SP		
			,swp_util_dif_pre_LB		
			,swp_util_diferida		
			,swp_dif_recibida_SP		
			,swp_dif_recibida_CP		
			,swp_dif_recibida_LB		
			,swp_diferencia_favor		
			,fwd_capital_mx1
			,fwd_capital_mx2
			,fwd_dif_cambio
			,fwd_dif_pago_cp
			,fwd_dif_pago_sp
			,fwd_dif_pago_lb
			,fwd_perdida_cp
			,fwd_perdida_sp
			,fwd_perdida_lb
			,fwd_utilidad_cp
			,fwd_utilidad_sp
			,fwd_utilidad_lb
			,fwd_difpre_util
			,fwd_difval_util
			,fwd_difpre_Perd
			,fwd_difval_Perd

			,fwd_difpre_util_rv
			,fwd_difpre_Perd_rv
			,fwd_reajuste

			,tipo_cuenta                
			,cproductor                 
			,codigo_evento              
			,codigo_moneda1             
			,codigo_moneda2             
			,codigo_instrumento         
			,numero_operacion           
			,numero_documento           
			,correlativo                
			,forma_pago                 
			,rut                        
			,Codigo_Operacion           
			,mercado                    
			,fecha_contable             
			,archivo_proceso	    
			,fecha_historica	    
			,tipoper		    
			,tipopero		    
			,cartera		    
			,numero_SPOT
			,csistema_orig
/*

			id_sistema		,
			cProducto		,
			cTipo_Plazo		,
			cFinanciamiento		,
			cCodigo_Sector		,
			cCodigo_Subsector	,
			cBanco_Corresponsal	,
			cStatus_Cuota		,
			cStatus_Colocacion	,
			cReajustabilidad	,
			cDivisa			,
			cTipo_Divisa		,
			valor_compra		,
			valor_presente		,
			valor_venta		,
			utilidad		,
			perdida			,
			interes_papel		,
			reajuste_papel		,
			interes_pacto		,
			reajuste_pacto		,
			valor_cupon		,
			nominalpesos		,
			nominal			,
			valor_comprahis		,
			dif_ant_pacto_pos	,
			dif_ant_pacto_neg	,
			dif_valor_mercado_pos	,
			dif_valor_mercado_neg	,
			rev_valor_mercado_pos	,
			rev_valor_mercado_neg	,
			valor_futuro		,
			Valor_perdida_usd	,
			Valor_utilidad_usd	,
			Valor_perdida_clp	,
			Valor_utilidad_clp	,
			tipo_cuenta		,
			cproductor		,
			codigo_evento		,
			codigo_moneda1		,
			codigo_moneda2		,
			codigo_instrumento	,
			numero_operacion	,
			numero_documento	,
			correlativo		,
			forma_pago		,
			rut			,
			Codigo_Operacion	,
			mercado			,
			fecha_contable		,
			archivo_proceso		,
			fecha_historica		,
			tipoper			,
			tipoperO		,
			cartera			,
			numero_SPOT		,
			swp_perdida_mercado		
			swp_capital_moneda1		
			swp_capital_moneda2		
			swp_diferencia_cambio		
			swp_diferencia_recibida	
			swp_diferencia_recibida_CP	
			swp_diferencia_recibida_SP	
			swp_diferencia_recibida_LB	
			swp_entrega_principales_m1	
			swp_entrega_principales_m2	
			swp_interes_cobrado		
			swp_interes_cobrado_SP		
			swp_interes_cobrado_CP		
			swp_interes_cobrado_LB		
			swp_interes_pagado		
			swp_interes_pagado_SP		
			swp_interes_pagado_CP		
			swp_interes_pagado_LB		
			swp_perd_dif_pre_CP		
			swp_perd_dif_pre_SP		
			swp_perd_dif_pre_LB		
			swp_perd_diferida		
			swp_diferencia_contra		
			swp_dif_pagada_SP		
			swp_dif_pagada_CP		
			swp_dif_pagada_LB		
			swp_reajuste_dev		
			swp_reajuste			
			swp_util_dif_pre_CP		
			swp_util_dif_pre_SP		
			swp_util_dif_pre_LB		
			swp_util_diferida		
			swp_dif_recibida_SP		
			swp_dif_recibida_CP		
			swp_dif_recibida_LB		
			swp_diferencia_favor
*/
		FROM	##contabiliza

	END


	DELETE ERRORES

-- drop table ##contabiliza
        DROP TABLE ##CONTABILIZA

	IF (SELECT COUNT(1) FROM ##ERRORES_CNT) = 0 BEGIN

		SELECT 'SI'

	END ELSE BEGIN

		INSERT INTO errores
		SELECT	@iFecha,
			1,
			RTRIM(LTRIM(sDescripcion)) + '  -  ' +
			'SISTEMA: ' + RTRIM(LTRIM(sId_Sistema))  + '  -  ' + 
			'PRODUCTO: ' + RTRIM(LTRIM(sProducto))  + '  -  ' +
			'OPERACION: (' + RTRIM(LTRIM(CONVERT(CHAR(10),nNumero_Documento)))  + '-' + 
			RTRIM(LTRIM(CONVERT(CHAR(10),nNumero_Operacion)))  + '-' + 
			RTRIM(LTRIM(CONVERT(CHAR(10),nCorrelativo )))   + ')  -  ' +
			'EVENTO: ' + RTRIM(LTRIM(sCodigo_evento))  + '  -  ' +
			'TIPO CTA: ' + RTRIM(LTRIM(sTipo_Cuenta))
		from ##errores_cnt

		SELECT 'NO'
	END



	SET NOCOUNT OFF

END


GO
