USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAPTURAFORWARD]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CAPTURAFORWARD]
AS
BEGIN
	SET NOCOUNT ON    
	
	
	
	DECLARE @total               NUMERIC(03),
	        @moentidad           NUMERIC(10),
	        @monumope            NUMERIC(07),
	        @motipmer            CHAR(04),
	        @motipope            CHAR(01),
	        @morutcli            NUMERIC(09),
	        @mocodcli            NUMERIC(09),
	        @monomcli            CHAR(35),
	        @mocodmon            CHAR(03),
	        @mocodcnv            CHAR(03),
	        @momonmo             NUMERIC(19, 4),
	        @moticam             NUMERIC(19, 4),
	        @moparme             NUMERIC(19, 8),
	        @moprecio            NUMERIC(19, 4),
	        @moussme             NUMERIC(19, 4),
	        @momonpe             NUMERIC(19, 4),
	        @moentre             NUMERIC(03),
	        @morecib             NUMERIC(03),
	        @movaluta1           DATETIME -- entregamos      
	        ,
	        @movaluta2           DATETIME -- recibimos      
	        ,
	        @mooper              CHAR(15) -- MAP 20060920      
	        ,
	        @mofech              DATETIME,
	        @mohora              CHAR(08),
	        @moterm              CHAR(12),
	        @motipcar            NUMERIC(03),
	        @monumfut            NUMERIC(08),
	        @mofecini            DATETIME,
	        @cant_op             NUMERIC(03),
	        @TipCli              NUMERIC(02),
	        @mocodoma            NUMERIC(03),
	        @mocostofo           NUMERIC(19, 4),
	        @mocorres            NUMERIC(10),
	        @nError              NUMERIC(05),
	        @Corresponsal        NUMERIC(10),
	        @RutBco              NUMERIC(15),
	        @Moneda              NUMERIC(15),
	        @swift_corrdonde     CHAR(15),
	        @swift_corrquien     CHAR(15),
	        @swift_corrdesde     CHAR(15),
	        @plaza_corrdonde     NUMERIC(15),
	        @plaza_corrquien     NUMERIC(15),
	        @plaza_corrdesde     NUMERIC(15),
	        @CodigoCntb          NUMERIC(15),
	        @GlosaOpSpot         CHAR(80),
	        @ProdForward         INTEGER      
	
	
	
	SET @GlosaOpSpot = ''      
	
	SET @cant_op = (
	        SELECT COUNT(*)
	        FROM   TBVENCIMIENTOSFORWARD WITH (NOLOCK)
	    )      
	
	
	
	DELETE 
	FROM   TBVENCIMIENTOSFORWARD
	WHERE  mofech <> (
	           SELECT acfecpro
	           FROM   MEAC WITH (NOLOCK)
	       )      
	
	
	
	IF @cant_op > 0
	BEGIN
	    SET @total = 0      
	    
	    
	    
	    WHILE (
	              SELECT COUNT(*)
	              FROM   TBVENCIMIENTOSFORWARD WITH (NOLOCK)
	          ) > 0
	    BEGIN
	        SET ROWCOUNT 1 
	        
	        --------<< carga en variables      
	        
	        SELECT @moentidad = moentidad,
	               @motipmer        = motipmer,
	               @motipope        = motipope,
	               @morutcli        = morutcli,
	               @mocodcli        = mocodcli,
	               @mocodmon        = mocodmon,
	               @mocodcnv        = mocodcnv,
	               @momonmo         = momonmo,
	               @moticam         = moticam,
	               @moparme         = moparme,
	               @moprecio        = moprecio,
	               @moussme         = moussme,
	               @momonpe         = momonpe,
	               @moentre         = moentre,
	               @morecib         = morecib,
	               @movaluta1       = movaluta1,	-- entregamos      
	               
	               @movaluta2       = movaluta2,	-- recibimos      
	               
	               @mooper          = mooper,	-- 'FORWARD'      
	               
	               @mofech          = CONVERT(CHAR(8), mofech, 112),
	               @mohora          = mohora,
	               @moterm          = moterm,
	               @motipcar        = motipcar,
	               @monumfut        = monumfut,
	               @mofecini        = mofecini,
	               @GlosaOpSpot     = ISNULL(
	                   (
	                       SELECT 'Anticipo '
	                       FROM   BacFwdSuda..MFCA WITH (NOLOCK)
	                       WHERE  numerocontratocliente = monumfut
	                              AND caAntici = 'A'
	                   ),
	                   ''
	               ) 
	               
	               + ' Operacion Derivado ' + LTRIM(RTRIM(monumfut)),
	               @ProdForward     = motipcar
	        FROM   TBVENCIMIENTOSFORWARD WITH (NOLOCK)       
	        
	        
	        
	        IF @@ERROR <> 0
	        BEGIN
	            SELECT @@ERROR,
	                   'NO SE PUEDE CARGAR VENCIMIENTO DERIVADOS EN AMBIENTE'    
	            
	            SET NOCOUNT OFF 
	            
	            RETURN
	        END 
	        
	        
	        
	        --------------------<< agregando a movimiento >>--------------------      
	        
	        --------<< captura numero de operacion      
	        
	        
	        
	        SET @monumope = 0      
	        
	        SET @mocorres = 0      
	        
	        
	        
	        SELECT @monumope = monumope
	        FROM   MEMO WITH (NOLOCK)
	        WHERE  monumfut         = @monumfut
	               AND mofecini     = CONVERT(CHAR(8), @mofecini, 112)      
	        
	        
	        
	        IF @monumope = 0
	        BEGIN
	            UPDATE MEAC
	            SET    accorope = (accorope + 1)      
	            
	            SET @monumope = (
	                    SELECT accorope
	                    FROM   MEAC WITH (NOLOCK)
	                )
	        END      
	        
	        
	        
	        SELECT @mofech = CONVERT(CHAR(8), acfecpro, 112),
	               @mohora     = CONVERT(CHAR(8), GETDATE(), 108),
	               @RutBco     = acrut
	        FROM   MEAC WITH (NOLOCK) 
	        
	        
	        
	        -------->> tipo de mercado       
	        
	        SET @TipCli = (
	                SELECT cltipcli
	                FROM   VIEW_CLIENTE WITH (NOLOCK)
	                WHERE  clrut            = @morutcli
	                       AND clcodigo     = @mocodcli
	            )      
	        
	        
	        
	        SET @motipmer = CASE 
	                             WHEN @ProdForward = 12 THEN 'EMPR' --> Deberia Cubrir los Arbitrajes Moneda MX-$
	                             WHEN (@TipCli > 0 AND @TipCli < 4) AND @mocodmon 
	                                  <> 'USD' THEN 'ARBI'
	                             WHEN (@TipCli > 0 AND @TipCli < 4) AND @mocodmon 
	                                  = 'USD' THEN 'PTAS'
	                             ELSE 'EMPR' -- corredoras tipcli = 4
	                        END      
	        
	        
	        
	        
	        
	        SET @mocostofo = 0       
	        
	        
	        
	        IF @motipmer = 'EMPR'
	            SET @mocostofo = @moticam 
	        
	        
	        -------->> codigo oma      
	        
	        IF @motipmer = 'PTAS'
	        BEGIN
	            IF @morutcli NOT IN (1, 2, 3, 4, 5, 70) --> @morutcli <> 1 And @morutcli <> 2 And @morutcli <> 3 And @morutcli <> 4 And @morutcli <> 5 And @morutcli <> 70
	            BEGIN
	                IF @TipCli = 1
	                BEGIN
	                    IF @morutcli = 97029000
	                        SET @mocodoma = 5
	                    ELSE
	                    BEGIN
	                        IF @motipope = 'C'
	                            SET @mocodoma = 2
	                        ELSE
	                            SET @mocodoma = 7
	                    END
	                END
	                ELSE
	                BEGIN
	                    IF @motipope = 'C'
	                        SET @mocodoma = 27
	                    ELSE
	                        SET @mocodoma = 12
	                END
	            END
	            ELSE
	                SET @mocodoma = 0
	        END
	        ELSE
	        BEGIN
	            IF @motipmer = 'EMPR'
	                IF @motipope = 'C'
	                    SET @mocodoma = 27
	                ELSE
	                    SET @mocodoma = 12
	            ELSE
	                SET @mocodoma = 0
	        END 
	        
	        --------<< corresponsal por los arbitrajes y monto en pesos      
	        
	        
	        
	        IF @motipmer = 'ARBI'
	        BEGIN
	            SET @mocorres = (
	                    SELECT accorres
	                    FROM   MEAC WITH (NOLOCK)
	                )      
	            
	            SET @momonpe = CONVERT(NUMERIC(19, 4), ROUND((@moussme * @moticam), 0))
	        END 
	        
	        
	        --------<< captura cliente       
	        
	        SET @monomcli = (
	                SELECT clnombre
	                FROM   VIEW_CLIENTE WITH (NOLOCK)
	                WHERE  clrut            = @morutcli
	                       AND clcodigo     = @mocodcli
	            )      
	        
	        SET @Moneda = (
	                SELECT mncodmon
	                FROM   VIEW_MONEDA WITH (NOLOCK)
	                WHERE  @mocodmon = mnnemo
	            )      
	        
	        
	        
	        SET @Corresponsal = 0      
	        
	        SET @swift_corrdonde = ''      
	        
	        SET @swift_corrquien = ''      
	        
	        SET @swift_corrdesde = ''      
	        
	        SET @plaza_corrdonde = 0      
	        
	        SET @plaza_corrquien = 0      
	        
	        SET @plaza_corrdesde = 0      
	        
	        
	        IF @motipmer IN ('EMPR', 'PTAS')
	        BEGIN
	            SELECT @Corresponsal = ISNULL(Default_iCodCorresponsal, 0)
	            FROM BacParamSuda.dbo.CargaOperaciones_DefectoValores codv WITH (NOLOCK)
/*	            
	            WHERE  (idProducto           = @motipmer)
	                   AND (idPlataforma     = @motipmer)      
	*/            
	  
	            WHERE  (idProducto           = CASE when @motipmer ='PTAS' THEN 4 
 													when @motipmer ='EMPR' THEN 5
 													when @motipmer ='ARBI' THEN 6 END) 
	                   AND (idPlataforma     = CASE WHEN @motipmer ='PTAS' THEN 4 
													WHEN @motipmer ='EMPR' THEN 5
													WHEN @motipmer ='ARBI' THEN 6 END )
	            
	            SET @Corresponsal = ISNULL(@Corresponsal, 0)
	        END      
	        
	        IF @motipmer = 'ARBI'
	        BEGIN
	            IF @motipope = 'C'
	            BEGIN
	                SELECT @CodigoCntb = CoCodigo_Contable,
	                       @swift_corrquien = CoCorrela --> cod_corresponsal      
	                       ,
	                       @swift_corrdesde = CoCorrela --> cod_corresponsal
	                FROM   BacParamSuda..ARB_FWD_CORRESPONSAL WITH (NOLOCK)
	                WHERE  CoTipo_Op        = @motipope
	                       AND CoMoneda     = 13 
	                
	                
	                
	                /*      
	                
	                SELECT @swift_corrquien = cod_corresponsal      
	                
	                , @swift_corrdesde = cod_corresponsal      
	                
	                */    
	                
	                
	                
	                SELECT @plaza_corrquien = codigo_plaza,
	                       @plaza_corrdesde = codigo_plaza
	                FROM   BacParamSuda..CORRESPONSAL WITH (NOLOCK)
	                WHERE  codigo_contable = CONVERT(CHAR(4), @CodigoCntb)
	                       AND rut_cliente = @RutBco
	                       AND codigo_moneda = 13      
	                
	                
	                
	                SELECT @CodigoCntb = CoCodigo_Contable,
	                       @swift_corrdonde = CoCorrela --> cod_corresponsal
	                FROM   BacParamSuda..ARB_FWD_CORRESPONSAL WITH (NOLOCK)
	                WHERE  CoTipo_Op        = @motipope
	                       AND CoMoneda     = @Moneda 
	                
	                
	                
	                /*    
	                
	                SELECT @swift_corrdonde = cod_corresponsal        
	                
	                */    
	                
	                
	                SELECT @plaza_corrdonde = codigo_plaza
	                FROM   BacParamSuda..CORRESPONSAL WITH (NOLOCK)
	                WHERE  codigo_contable = CONVERT(CHAR(4), @CodigoCntb)
	                       AND rut_cliente = @RutBco
	                       AND codigo_moneda = @Moneda
	            END
	            ELSE
	            BEGIN
	                SELECT @CodigoCntb = CoCodigo_Contable,
	                       @swift_corrquien = CoCorrela --> cod_corresponsal      
	                       ,
	                       @swift_corrdesde = CoCorrela --> cod_corresponsal
	                FROM   BacParamSuda..ARB_FWD_CORRESPONSAL WITH (NOLOCK)
	                WHERE  CoTipo_Op        = @motipope
	                       AND CoMoneda     = @Moneda 
	                
	                
	                
	                /*    
	                
	                SELECT @swift_corrquien = cod_corresponsal      
	                
	                , @swift_corrdesde = cod_corresponsal      
	                
	                */    
	                
	                SELECT @plaza_corrquien = codigo_plaza,
	                       @plaza_corrdesde = codigo_plaza
	                FROM   BacParamSuda..CORRESPONSAL WITH (NOLOCK)
	                WHERE  codigo_contable = CONVERT(CHAR(4), @CodigoCntb)
	                       AND rut_cliente = @RutBco
	                       AND codigo_moneda = @Moneda      
	                
	                
	                
	                SELECT @CodigoCntb = CoCodigo_Contable,
	                       @swift_corrdonde = CoCorrela --> cod_corresponsal
	                FROM   BacParamSuda..ARB_FWD_CORRESPONSAL WITH (NOLOCK)
	                WHERE  CoTipo_Op        = @motipope
	                       AND CoMoneda     = 13 
	                
	                
	                
	                /*    
	                
	                SELECT @swift_corrdonde = cod_corresponsal      
	                
	                */    
	                
	        	                
	                
	                SELECT @plaza_corrdonde = codigo_plaza
	                FROM   BacParamSuda..CORRESPONSAL WITH (NOLOCK)
	                WHERE  codigo_contable = CONVERT(CHAR(4), @CodigoCntb)
	                       AND rut_cliente = @RutBco
	                       AND codigo_moneda = 13
	            END
	        END 
	        
	        
	        
	        --------<< graba movimiento      
	        
	        EXECUTE SP_GMOVTO 
	        
	        @monumope , -- 1      
	        
	        @motipmer , -- 2      
	        
	        @motipope , -- 3      
	        
	        @morutcli , -- 4      
	        
	        @mocodcli , -- 5      
	        
	        @monomcli , -- 6      
	        
	        @mocodmon , -- 7      
	        
	        @mocodcnv , -- 8      
	        
	        @momonmo , -- 9      
	        
	        @moticam , -- 10     
	        
	        @moticam , -- 11 t/c costo      
	        
	        @moparme , -- 12      
	        
	        @moparme , -- 13 paridad costo      
	        
	        @moussme , -- 14      
	        
	        @moussme , -- 15 monto us$ costo      
	        
	        @momonpe , -- 16      
	        
	        @moentre , -- 17      
	        
	        @morecib , -- 18      
	        
	        @mooper , -- 19      
	        
	        @moterm , -- 20      
	        
	        @mofech , -- 21      
	        
	        @mocodoma , -- 22 codigo oma      
	        
	        '', -- 23 estatus      
	        
	        0, -- 24      
	        
	        @movaluta1, -- 25 entregamos      
	        
	        @movaluta2, -- 26 recibimos      
	        
	        0, -- 27       
	        
	        '', -- 28      
	        
	        @moentidad, -- 29      
	        
	        @moprecio , -- 30      
	        
	        @moprecio , -- 31 precio costo      
	        
	        0, -- 32      
	        
	        '', -- 33      
	        
	        '', -- 34      
	        
	        @GlosaOpSpot, -- 35      
	        
	        @swift_corrdonde, -- 36      
	        
	        @swift_corrquien, -- 37      
	        
	        @swift_corrdesde, -- 38      
	        
	        @plaza_corrdonde, -- 39      
	        
	        @plaza_corrquien, -- 40      
	        
	        @plaza_corrdesde, -- 41      
	        
	        0, -- 42      
	        
	        0, -- 43      
	        
	        '', -- 44      
	        
	        '', -- 45      
	        
	        '', -- 46      
	        
	        '', -- 47      
	        
	        '', -- 48 --      
	        
	        0, -- 49      
	        
	        0, -- 50      
	        
	        0, -- 51      
	        
	        0, -- 52      
	        
	        0, -- 53      
	        
	        @mocostofo, -- 54      
	        
	        0, -- 55      
	        
	        0, -- 56      
	        
	        '', -- 57      
	        
	        0, -- 58      
	        
	        @mocorres, -- 59      
	        
	        'S', -- 60 Operacion de Forward      
	        
	        @monumfut, -- 61 Número de Forward      
	        
	        @mofecini, -- 62 Fecha de Inicio de Forward      
	        
	        @mofech, -- 63 Fecha de Vcto. de Forward      
	        
	        @moprecio, -- 64 Precio de Forward      
	        
	        @motipcar, -- 65 Producto de Forward      
	        
	        0, -- 66      
	        
	        0, -- 67      
	        
	        'S', -- 68 Controla la Transacción      
	        
	        @Corresponsal -- 69 Corresponsal de la Operación      
	        
	        
	        
	        IF NOT EXISTS (
	               SELECT monumope
	               FROM   MEMO WITH (NOLOCK)
	               WHERE  monumope = @monumope
	           )
	        BEGIN
	            SELECT -1,
	                   'NO SE PUEDE INGRESAR DERIVADO ' + CONVERT(CHAR(8), @monumfut) 
	            
	            RETURN
	        END      
	        
	        
	        
	        SET @total = @total + 1 
	        
	        ---------------------<< movimiento  agregado >>--------------------      
	        
	        SET ROWCOUNT 0 
	        
	        
	        
	        -- Inserta los Vencimientos Fwd entrega Fisica en las tablas de movimientos de Lineas para que queden       
	        
	        -- pendientes para aprobacion (VGS 09/2004)      
	        
	        
	        
	        
	        
	        SET @nError = 0 
	        
	        EXECUTE SP_GRABA_VCTOS_FWDSPOT_LINEAS @monumfut, @monumope, @nError 
	        OUTPUT      
	        
	        
	        
	        IF @nError <> 0
	        BEGIN
	            SELECT -1,
	                   'NO SE PUEDE INGRESAR DERIVADO EN TABLAS DE LINEAS ' + 
	                   CONVERT(CHAR(8), @monumfut) 
	            
	            RETURN
	        END      
	        
	        
	        
	        DELETE 
	        FROM   TBVENCIMIENTOSFORWARD
	        WHERE  motipcar = @motipcar
	               AND monumfut = @monumfut
	               AND mofecini = @mofecini
	    END -- while      
	    
	    
	    
	    IF @total > 0
	        SELECT @total,
	               'SE TRANSFIRIERON ' + LTRIM(RTRIM(@total)) + 
	               ' DERIVADOS A SPOT'
	END
	ELSE
	    SELECT @cant_op,
	           'NO EXISTEN DATOS A TRANSFERIR'
END
 
 
 
 
 
GO
