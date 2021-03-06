USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Plataforma_Leer]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Plataforma_Leer]
         (      @id_sistema    CHAR(3)      = ''
         ,      @producto      VARCHAR(5)   = ''
         ,      @cliente       NUMERIC(9)   = 0
	 ,	@nMoneda       NUMERIC(5)   = 0
	 ,	@cOperacion    CHAR(3)	    = 0
	 ,	@nFormaPago    NUMERIC(3)   = 0
         ,      @fecha         DATETIME     = ''
	 ,      @cOrden	       CHAR(1)	    = 'N'
	 ,      @nOr_Modulo    NUMERIC(1)   = 0
	 ,      @nOr_Producto  NUMERIC(1)   = 0
	 ,      @nOr_Cliente   NUMERIC(1)   = 0	 
         ,      @nOr_Moneda    NUMERIC(1)   = 0
	 ,      @nOr_Operacion NUMERIC(1)   = 0
	 ,      @nOr_FormaPago NUMERIC(1)   = 0
	 ,      @nOr_Asc       NUMERIC(1)   = 1
         )
AS 
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE @cConsulta 		VARCHAR(400)
	DECLARE @cOrdenamiento	 	VARCHAR(400)
	DECLARE @cGrupo			VARCHAR(400)
	DECLARE @nSw			NUMERIC(1)


	CREATE TABLE #TEMPORAL2( 
				[Nombre Sistema]	CHAR(30)
	,   			[Tipo Producto]   	CHAR(62)
	,   			[NºOperación]     	NUMERIC(10)
	,		        [Tipo Oper.]      	CHAR(10)
        ,    			[Fecha Vcto.]     	DATETIME
        ,    			[Cliente]         	CHAR(70)
      	,    			[Moneda Oper.]    	CHAR(15)
        ,    			[Monto Oper.]     	NUMERIC(19,4)
        ,    			[Precio]		NUMERIC(11,4)
        ,    			[Mto. en Pesos]   	NUMERIC(28)
    	,    			[F.Pag.Inic.]     	CHAR(30)
        ,    			[F.Pag.Vcto.]     	CHAR(30)
        ,    			[id_Sistema]      	CHAR(03)
        ,    			[Producto]        	CHAR(05)
        ,    			[Rut_Cartera]     	NUMERIC(10)
	,   			[rut_cliente]     	NUMERIC(10)
        ,    			[fecha]           	DATETIME 
	,    			[TipOper]      	  	CHAR(117)
    	,    			[estado]          	CHAR(01)
        ,    			[estado_Impreso]	CHAR(01)	
        ,    			[Moneda]		NUMERIC(3)
	,    			[TipoOperacion]	  	CHAR(5)
	,    			[PagoRecibimos]	  	NUMERIC(05)
	,    			[PagoEntregamos]  	NUMERIC(05)
	,    			[Control_Backoffice] 	CHAR(01)
	,    			[Contabiliza]	     	CHAR(02)
				)


        /* RENTA FIJA */

	 INSERT  INTO #TEMPORAL2
         SELECT 'RENTA FIJA'			-- Nombre Sistema
            ,   CASE WHEN motipoper = 'IB' THEN
                                       (SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BTR' AND codigo_producto = motipoper) + ' (' + RTRIM(momascara) + ') '
                                    ELSE                    
 					(SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BTR' AND codigo_producto = motipoper)
                                    END		-- Tipo Producto
            ,   monumoper  			-- NºOperación
            ,   CASE WHEN motipoper = 'IB' OR motipoper = 'TD' OR motipoper = 'LBC' OR motipoper = 'VIB' THEN CASE WHEN LEFT(momascara,4) = 'ICOL' THEN 'COLOCACION'
				 WHEN LEFT(momascara,4) = 'ICAP' THEN 'CAPTACION' END ELSE SPACE(10)
                END				-- Tipo Oper.
            ,   GETDATE() 			-- Fecha Vcto.
            ,   ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = morutcli and clcodigo = mocodcli ),'N/A')	-- Cliente
      	    ,   CASE 	WHEN motipoper IN('CP','VP') THEN 'CLP'                                      
		 	WHEN motipoper IN('CI','CIX','VIX','VI','RC','RV','RCA','RVA', 'RP','VRP', 'FLP', 'VFL') THEN (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon =  momonpact)
                        ELSE (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon =  momonemi)
                END				-- Moneda Oper.
            ,   monominal			-- Monto Oper.
            ,   CASE WHEN motipoper IN('CIX','VIX','CI','VI','TD', /*'LBC',*/'IB','RV','RC','RCA','RVA', 'RP','VRP', 'FLP', 'VFL') THEN motaspact ELSE 0
                END				-- Precio
            ,   CASE WHEN motipoper IN('CP','CAP')                THEN movalcomp
                     WHEN motipoper IN('VP','RV','RVA','SLH')     THEN movalven
                     WHEN motipoper IN('CIX','VIX','CI','VI','TD'/*,'LBC'*/,'IB', 'RP','VRP', 'FLP', 'VFL') THEN movalinip
                     WHEN motipoper IN('VCI','VIB')               THEN movalvenp
		     WHEN motipoper IN('IC','AIC')		  THEN movpresen
                     WHEN motipoper IN('RC','RCA')                THEN movalvenp
                     ELSE movalcomp
		END				-- Mto. en Pesos
    	    ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = moforpagi),'N/A')	-- F.Pag.Inic.
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = moforpagv),'N/A')	-- F.Pag.Vcto.
            ,   'BTR'				-- id_Sistema
            ,   motipoper			-- Producto
            ,   morutcart			-- Rut_Cartera
 	    ,   morutcli			-- rut_cliente
            ,   mofecpro          		-- fecha
	    ,   CONVERT(CHAR(5),motipoper) + SPACE(100) + CASE WHEN LEFT(moinstser,4) = 'ICAP' THEN LEFT(moinstser,4) ELSE ' ' END  -- TipOper
    	    ,   mostatreg			-- estado
            ,   moimpreso			-- estado_Impreso
            ,   CASE WHEN motipoper IN('CP','VP') THEN 999
                     WHEN motipoper IN('CI','VI','CIX','VIX','RC','RV','RCA','RVA', 'RP','VRP', 'FLP', 'VFL') THEN momonpact
                     ELSE momonemi
		END				-- Moneda
	    ,   motipoper			-- TipoOperacion
	    ,   moforpagi			-- PagoRecibimos
	    ,   moforpagv			-- PagoEntregamos
	    ,	'Estado_Backoffice'= CASE WHEN mostatreg ='A' then mostatreg ELSE Estado_Backoffice END		-- Control_Backoffice
	    ,   '  '				-- Contabiliza
	 FROM MOVIMIENTO_TRADER WITH (NOLOCK)
         WHERE mofecpro  = @fecha 
	   and	(mostatreg = ' '
           OR  mostatreg = 'A' )


         /* FUTURO */
         INSERT INTO #TEMPORAL2
         SELECT 'FORWARD'			-- Nombre Sistema
            ,   (SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BFW' AND codigo_producto = mocodpos1) -- Tipo Producto
     	    ,   monumoper			-- NºOperación
            ,   CASE motipoper WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END	-- Tipo Oper.
            ,   GETDATE() 			-- Fecha Vcto.
            ,   ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = mocodigo and mocodcli=clcodigo),'N/A') -- Cliente
            ,   (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon =  mocodmon2)	-- Moneda Oper.
            ,   momtomon1			-- Monto Oper.
            ,   motipcam			-- Precio
            ,   moequmon2			-- Mto. en Pesos
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = mofpagomn),'N/A') -- F.Pag.Inic.
	    ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = mofpagomx),'N/A') -- F.Pag.Vcto.
            ,   'BFW'				-- id_Sistema
            ,   mocodpos1			-- Producto
            ,   mocodcart			-- Rut_Cartera
            ,   mocodigo			-- rut_cliente
            ,   mofecha				-- fecha
            ,   mocodpos1			-- TipOper
            ,   moestado 			-- estado
            ,   moimpreso			-- estado_Impreso
	    ,	mocodmon2			-- Moneda
	    ,   motipoper			-- TipoOperacion
	    ,   mofpagomn			-- PagoRecibimos
	    ,   mofpagomx			-- PagoEntregamos
	    ,	'Estado_Backoffice' = case WHEN moestado = 'A' THEN moestado ELSE Estado_Backoffice END		-- Control_Backoffice
	    ,   CASE WHEN Contabiliza = 'S' THEN 'SI' ELSE 'NO' END	-- Contabiliza
	 FROM VIEW_MOVIMIENTO_FORWARD 
         WHERE mofecha = @fecha
	 AND   moestado IN(' ','A','M')
	INSERT INTO #TEMPORAL2
         SELECT 'FORWARD   '					--'Nombre Sistema'  
            ,    (SELECT descripcion FROM VIEW_PRODUCTO a WHERE id_sistema = 'BFW' 
			   AND a.codigo_producto = 7)         --'Tipo Producto'     
	    ,    numero_operacion 				--'NºOperación'     
            ,    CASE tipo_operacion WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END --'Tipo Oper.'      
            ,    GETDATE()  					--fecha_termino
            ,    ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = rut_cliente and codigo_cliente=clcodigo),'N/A')
            ,    (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon =  moneda)		--'Moneda Oper.'    
            ,    valor_compra_um 				--'Monto Oper.'     
            ,    CONVERT(NUMERIC(11,4),valor_tasa_forward)     	--'Precio'           
            ,    CONVERT(NUMERIC(19,0),valor_compra_um)		--'Mto. en Pesos'   
            ,    ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = forma_pago),'N/A') --'F.Pag.Inic.'     
            ,    ' '				 --'F.Pag.Vcto.'     
            ,    'BFW' 				--'id_Sistema'      
            ,    '7'           			--'Producto'        
	    ,    0 				--'Rut_Cartera'     
	    ,    rut_cliente
	    ,    fecha_operacion		--'fecha'           
            ,    '7' 				--'TipOper'         
            ,    estado 
            ,    impreso			--'estado_Impreso'  
	    ,	 moneda				--'Moneda'	  
	    ,	 tipo_operacion 		--'TipoOperacion'	  
	    ,    forma_pago 			--'PagoRecibimos'	  
	    ,    0 				--'PagoEntregamos'  
	    ,   'A'				--'Control_Backoffice' 
	    ,   CASE WHEN Contabiliza = 'S' THEN 'SI' ELSE 'NO' END	-- Contabiliza
         FROM VIEW_MOVIMIENTO_FORWARD_PAPEL 
         WHERE estado IN(' ','A','M')
	 AND  fecha_operacion = @fecha

 
   IF @fecha = '' or @fecha = ( SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES ) BEGIN

         INSERT INTO #TEMPORAL2
         SELECT 'FORWARD'			-- Nombre Sistema
            ,   'VENCIMIENTO DE ' + (SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BFW' AND codigo_producto = cacodpos1)  -- Tipo Producto
	    ,   canumoper			-- NºOperación
            ,   CASE catipoper WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END -- Tipo Oper.
            ,   GETDATE()  			-- Fecha Vcto.

    	    ,   ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = cacodigo and cacodcli=clcodigo),'N/A') -- Cliente
            ,   (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon =  cacodmon2) -- Moneda Oper.
            ,   camtomon1			-- Monto Oper.
            ,   catipcam			-- Precio
            ,   caequmon2			-- Mto. en Pesos
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = cafpagomn),'N/A')	-- F.Pag.Inic.
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = cafpagomx),'N/A')	-- F.Pag.Vcto.
            ,   'BFW'				-- id_Sistema
            ,   cacodpos1			-- Producto

	    ,	cacodcart			-- Rut_Cartera
	    ,   cacodigo			-- rut_cliente
	    ,   cafecvcto			-- fecha
            ,   cacodpos1			-- TipOper
            ,   caestado 			-- estado
            ,   marca 				-- estado_Impreso
	    ,	cacodmon2			-- Moneda
	    ,	catipoper			-- TipoOperacion
	    ,   cafpagomn			-- PagoRecibimos
	    ,   cafpagomx			-- PagoEntregamos
	    ,	'A'				-- Control_Backoffice
            ,   CASE WHEN Contabiliza = 'S' THEN 'SI' ELSE 'NO' END		-- Contabiliza
	
         FROM VIEW_CARTERA_FORWARD
        WHERE cafecvcto = @fecha 
        AND   (caestado = '' OR caestado = 'A')
	INSERT INTO #TEMPORAL2
         SELECT    'FORWARD   '					--'Nombre Sistema'  
            ,    (SELECT descripcion FROM VIEW_PRODUCTO a WHERE id_sistema = 'BFW' 
			   AND a.codigo_producto = 7 )        --'Tipo Producto'     
	    ,    numero_operacion 				--'NºOperación'     
            ,    CASE tipo_operacion WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END --'Tipo Oper.'      
            ,    GETDATE()  					--fecha_termino
            ,    ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = rut_cliente and codigo_cliente=clcodigo),'N/A')
            ,    0 						--'Moneda Oper.'    
            ,    valor_compra_um 				--'Monto Oper.'     
            ,    CONVERT(NUMERIC(11,4),valor_tasa_forward)     	--'Precio'           
            ,    CONVERT(NUMERIC(19,0),valor_compra_um)		--'Mto. en Pesos'   
            ,    ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = forma_pago),'N/A') --'F.Pag.Inic.'     
            ,    ' '				 --'F.Pag.Vcto.'     
            ,    'BFW' 				--'id_Sistema'      
            ,    '7'           			--'Producto'        
	    ,    0 				--'Rut_Cartera'     
	    ,    rut_cliente
	    ,    fecha_operacion		--'fecha'           
            ,    '7' 				--'TipOper'         
            ,    estado 
            ,    0 				--'estado_Impreso'  
	    ,	 0 				--'Moneda'	  
	    ,	 tipo_operacion 		--'TipoOperacion'	  
	    ,    forma_pago 			--'PagoRecibimos'	  
	    ,    0 				--'PagoEntregamos'  
	    ,   'A'				--'Control_Backoffice' 
	    ,   CASE WHEN Contabiliza = 'S' THEN 'SI' ELSE 'NO' END	-- Contabiliza
         FROM VIEW_CARTERA_FORWARD_PAPEL 
        WHERE (estado = '' OR estado = 'A')
	AND fecha_termino = @fecha
   END 
   ELSE BEGIN


         INSERT INTO #TEMPORAL2
         SELECT 'FORWARD'			-- Nombre Sistema
            ,   'VENCIMIENTO DE ' + (SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BFW' AND codigo_producto = cacodpos1)    -- Tipo Producto
	    ,   canumoper			-- NºOperación
            ,   CASE catipoper WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END -- Tipo Oper.
            ,   GETDATE() 			-- Fecha Vcto.
            ,   ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = cacodigo AND clcodigo = cacodcli ),'N/A') -- Cliente
            ,   (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon =  cacodmon2) -- Moneda Oper.
            ,   camtomon1			-- Monto Oper.
            ,   catipcam			-- Precio
      	    ,   caequmon2			-- Mto. en Pesos
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = cafpagomn),'N/A')	-- F.Pag.Inic.
   	    ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = cafpagomx),'N/A')	-- F.Pag.Vcto.
            ,   'BFW'				-- id_Sistema
            ,   cacodpos1			-- Producto
            ,   cacodcart			-- Rut_Cartera
            ,   cacodigo			-- rut_cliente
            ,   cafecvcto			-- fecha
            ,   cacodpos1			-- TipOper
            ,   caestado 			-- estado
            ,   ''				-- estado_Impreso
            ,	cacodmon1			-- Moneda
	    ,   catipoper			-- TipoOperacion


	    ,   cafpagomn			-- PagoRecibimos
	    ,   cafpagomx			-- PagoEntregamos
	    ,	'A'				-- Control_Backoffice
            ,   CASE WHEN Contabiliza = 'S' THEN 'SI' ELSE 'NO' END	-- Contabiliza
        FROM   VIEW_CARTERA_FORWARD_HISTORICA 
        WHERE cafecvcto = @fecha
          AND (caestado = '' OR caestado = 'A')

	INSERT INTO #TEMPORAL2
         SELECT 'FORWARD   '					--'Nombre Sistema'  
            ,    (SELECT descripcion FROM VIEW_PRODUCTO a WHERE id_sistema = 'BFW' 
			   AND a.codigo_producto = 7)         --'Tipo Producto'     
	    ,    numero_operacion 				--'NºOperación'     
            ,    CASE tipo_operacion WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END --'Tipo Oper.'      
            ,    GETDATE()  					--fecha_termino
            ,    ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = rut_cliente and codigo_cliente=clcodigo),'N/A')
            ,    0 						--'Moneda Oper.'    
            ,    valor_compra_um 				--'Monto Oper.'     
            ,    CONVERT(NUMERIC(11,4),valor_tasa_forward)     	--'Precio'           
            ,    CONVERT(NUMERIC(19,0),valor_compra_um)		--'Mto. en Pesos'   
            ,    ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = forma_pago),'N/A') --'F.Pag.Inic.'     
            ,    ' '				 --'F.Pag.Vcto.'     
            ,    'BFW' 				--'id_Sistema'      
            ,    '7'           			--'Producto'        
	    ,    0 				--'Rut_Cartera'     
	    ,    rut_cliente
	    ,    fecha_operacion		--'fecha'           
            ,    '7' 				--'TipOper'         
            ,    estado 
            ,    0 				--'estado_Impreso'  
	    ,	 0 				--'Moneda'	  
	    ,	 tipo_operacion 		--'TipoOperacion'	  
	    ,    forma_pago 			--'PagoRecibimos'	  
	    ,    0 				--'PagoEntregamos'  
	    ,   'A'				--'Control_Backoffice' 
	    ,   CASE WHEN Contabiliza = 'S' THEN 'SI' ELSE 'NO' END	-- Contabiliza
	FROM   VIEW_CARTERA_FORWARD_PAPEL_HISTORICA 
        WHERE (estado = '' OR estado = 'A')
          AND fecha_termino = @fecha
	END


      
   /* CAMBIO */
        INSERT INTO #TEMPORAL2
            SELECT 
                'SPOT'				-- Nombre Sistema
            ,   (SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BCC' AND codigo_producto = motipmer)  -- Tipo Producto
            ,   CONVERT(NUMERIC(10),monumope)	-- NºOperación
            ,   CASE motipope WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END	-- Tipo Oper.
            ,   GETDATE() 			-- Fecha Vcto.
            ,   ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli),'N/A') -- Cliente
            ,   mocodmon			-- Moneda Oper.
            ,   momonmo				-- Monto Oper.
            ,   moticam				-- Precio
            ,   momonpe				-- Mto. en Pesos
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = moentre),'N/A')   -- F.Pag.Inic.
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = morecib),'N/A')   -- F.Pag.Vcto.
            ,   'BCC'				-- id_Sistema
            ,   motipmer			-- Producto
            ,   moentidad			-- Rut_Cartera
            ,   morutcli			-- rut_cliente

            ,   mofech				-- fecha
            ,   motipmer			-- TipOper
            ,   moestatus			-- estado
            ,   moimpreso			-- estado_Impreso
	    ,   ( SELECT mncodmon FROM VIEW_MONEDA WHERE mocodmon = mnnemo ) -- Moneda
            ,	motipope			-- TipoOperacion
	    ,   moentre				-- PagoRecibimos
	    ,   morecib				-- PagoEntregamos
	    ,	'Estado_Backoffice'= CASE WHEN Moestatus='A' THEN Moestatus ELSE Estado_Backoffice END		-- Control_Backoffice
	    ,   CASE WHEN Contabiliza = 'S' THEN 'SI' ELSE 'NO' END	-- Contabiliza
        FROM VIEW_MOVIMIENTO_CAMBIO 
     WHERE mofech    = @fecha 
      AND  (moestatus = ' ' OR  moestatus = 'A')
      AND  mofech    = @fecha 
        INSERT INTO #TEMPORAL2
            SELECT 
                'SPOT'				-- Nombre Sistema
            ,   'VENCIMIENTO DE ' + (SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'BCC' AND codigo_producto = motipmer)  -- Tipo Producto
            ,   CONVERT(NUMERIC(10),monumope)	-- NºOperación
            ,   CASE motipope WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END	-- Tipo Oper.
            ,   GETDATE() 			-- Fecha Vcto.
            ,   ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = morutcli AND clcodigo = mocodcli),'N/A') -- Cliente
            ,   mocodmon			-- Moneda Oper.
            ,   momonmo				-- Monto Oper.
            ,   moticam				-- Precio
            ,   momonpe				-- Mto. en Pesos
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = moentre),'N/A')   -- F.Pag.Inic.
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = morecib),'N/A')   -- F.Pag.Vcto.
            ,   'BCC'				-- id_Sistema
            ,   motipmer			-- Producto
            ,   moentidad			-- Rut_Cartera
            ,   morutcli			-- rut_cliente

            ,   Movaluta2			-- fecha
            ,   motipmer			-- TipOper
            ,   moestatus			-- estado
            ,   moimpreso			-- estado_Impreso
	    ,   ( SELECT mncodmon FROM VIEW_MONEDA WHERE mocodmon = mnnemo ) -- Moneda
            ,	motipope			-- TipoOperacion
	    ,   moentre				-- PagoRecibimos
	    ,   morecib				-- PagoEntregamos
	    ,	'Estado_Backoffice'= CASE WHEN Moestatus='A' THEN Moestatus ELSE Estado_Backoffice END		-- Control_Backoffice
	    ,   CASE WHEN Contabiliza = 'S' THEN 'SI' ELSE 'NO' END	-- Contabiliza
        FROM VIEW_MOVIMIENTO_CAMBIO 
     WHERE Movaluta2    = @fecha 
      AND  (moestatus = ' ' )
      AND  Motipmer    = 'OVER' 


         /* INVERSIONES EN EL EXTERIOR */
         INSERT INTO #TEMPORAL2
         SELECT 'INVERSION EXTERIOR'		-- Nombre Sistema
            ,   ISNULL((SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'INV' AND codigo_producto = motipoper),'')	-- Tipo Producto
            ,   monumoper			-- NºOperación
            ,   CASE WHEN MOTIPOPER = 'CPI' THEN 'COMPRA' WHEN MOTIPOPER = 'VPI' THEN  'VENTA' ELSE '' END -- Tipo Oper.
            ,   GETDATE()			-- Fecha Vcto.
            ,   ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = morutcli and clcodigo = mocodcli ),'N/A') -- Cliente
            ,   CONVERT(CHAR(15),(SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon =  momonemi)) -- Moneda Oper.

            ,   monominal			-- Monto Oper.
            ,   0 				-- Precio
            ,   moprincipal			-- Mto. en Pesos
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = forma_pago),'N/A')   -- F.Pag.Inic.
            ,   ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = forma_pago_recibimos),'N/A')   -- F.Pag.Vcto.
            ,   'INV'				-- id_Sistema
            ,   motipoper			-- Producto
            ,   morutcart			-- Rut_Cartera
            ,   morutcli			-- rut_cliente
            ,   mofecpro			-- fecha
            ,   motipoper			-- TipOper
            ,   mostatreg			-- estado
            ,   impreso				-- estado_Impreso
	    ,	momonemi			-- Moneda
	    ,   motipoper			-- TipoOperacion
	    ,   forma_pago			-- PagoRecibimos
	    ,   forma_pago_recibimos		-- PagoEntregamos
	    ,	'Estado_Backoffice' = CASE WHEN mostatreg='A' THEN mostatreg ELSE Estado_Backoffice END		-- Control_Backoffice
	    ,   '  ' 				-- Contabiliza
        FROM VIEW_MOVIMIENTO_INVERSION_EXTERIOR
        WHERE mofecpro  = @fecha 
          and (mostatreg = ' ' OR  mostatreg = 'A' )

         /* SWAP */
         INSERT INTO #TEMPORAL2
         SELECT DISTINCT
                'SWAPS'				-- Nombre Sistema
            ,   (SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'SWP' AND codigo_producto = Tipo_Swap)  -- Tipo Producto
            ,   Numero_Operacion		-- NºOperación
            ,   CASE Tipo_operacion WHEN 'C' THEN 'COMPRA' ELSE 'VENTA' END	-- Tipo Oper.
            ,   GETDATE() 			-- Fecha Vcto.
            ,   ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = rut_cliente and clcodigo=codigo_cliente),'N/A') -- Cliente
            ,   ' '				-- Moneda Oper.
            ,   0				-- Monto Oper.
            ,   0				-- Precio
            ,   0				-- Mto. en Pesos
	    ,   ' '				-- F.Pag.Inic.
            ,   ' '				-- F.Pag.Vcto.
            ,   'SWP'				-- id_Sistema
            ,   tipo_swap			-- Producto

	    ,   rut_entidad			-- Rut_Cartera
            ,   rut_cliente			-- rut_cliente
            ,   fecha_cierre			-- fecha
            ,   tipo_swap			-- TipOper
            ,   'Estado' = CASE WHEN estado_operacion = 2 THEN 'A' ELSE Control_Backoffice END	-- Estado
            ,   impreso				-- estado_Impreso
	    ,   0				-- Moneda
	    ,   tipo_operacion			-- TipoOperacion
	    ,   0				-- PagoRecibimos
	    ,   0				-- PagoEntregamos
	    ,	Control_Backoffice		-- Control_Backoffice
	    ,   '  '				-- Contabiliza
         FROM VIEW_CONTRATO, VIEW_DATOS_GENERALES
         WHERE fecha_cierre = @fecha
	 AND  tipo_swap <> 'ST'
	 AND  tipo_operacion <> ''
	 AND  Estado_oper_lineas IN(' ','A')

         INSERT INTO #TEMPORAL2
         SELECT DISTINCT
                'SWAPS'				-- Nombre Sistema
            ,   (SELECT descripcion FROM VIEW_PRODUCTO WHERE id_sistema = 'SWP' AND codigo_producto = Tipo_Swap) -- Tipo Producto
            ,   Numero_Operacion		-- NºOperación
            ,   ' '				-- Tipo Oper.
            ,   GETDATE() 			-- Fecha Vcto.
            ,   ISNULL((SELECT clnombre FROM VIEW_CLIENTE WHERE clrut = rut_cliente and clcodigo=codigo_cliente),'N/A') -- Cliente
            ,   ' '				-- Moneda Oper.
	    ,   0				-- Monto Oper.
            ,   0				-- Precio
 
 
            ,   0				-- Mto. en Pesos
            ,   ' '				-- F.Pag.Inic.
            ,   ' '				-- F.Pag.Vcto.
            ,   'SWP'				-- id_Sistema
            ,   tipo_swap			-- Producto
            ,   rut_entidad			-- Rut_Cartera
            ,   rut_cliente			-- rut_cliente
            ,   fecha_cierre			-- fecha
            ,   tipo_swap			-- TipOper
            ,   'Estado' = CASE WHEN estado_operacion = 2 THEN 'A' ELSE Control_Backoffice END	-- Estado
            ,   impreso 			-- estado_Impreso
	    ,   0				-- Moneda
	    ,   ''				-- TipoOperacion
	    ,   0				-- PagoRecibimos
	    ,   0				-- PagoEntregamos
	    ,	Control_Backoffice		--Control_Backoffice
	    ,   '  '				-- Contabiliza
         FROM VIEW_CONTRATO, VIEW_DATOS_GENERALES
         WHERE fecha_cierre = @fecha
	 AND  tipo_swap = 'ST'
	 AND  tipo_operacion <> ''
	 AND  Estado_oper_lineas IN(' ','A')


	--OBTENER TIPO CAMBIO PARA EL MOENTO PAGO EN PESOS : EBQ
        UPDATE #TEMPORAL2 SET
                [Moneda Oper.]    = (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon = SWP.moneda_flujo)
            ,   [Monto Oper.]     = (SELECT SUM(AMORTIZA_CAPITAL) FROM VIEW_CONTRATO_FLUJO_INICIO A WHERE A.numero_operacion = #TEMPORAL2.[NºOperación] AND A.TIPO_FLUJO = 1)
            ,   [Precio]          = SWP.valor_tasa
            ,   [Mto. en Pesos]   = (SELECT vmvalor FROM VIEW_VALOR_MONEDA 
                                     WHERE vmfecha = convert(char(8), @fecha,112) 
                                     AND vmcodigo = SWP.moneda_flujo) * (SELECT SUM(AMORTIZA_CAPITAL) FROM VIEW_CONTRATO_FLUJO_INICIO A 
                                                                         WHERE A.numero_operacion = #TEMPORAL2.[NºOperación] 
                                                                         AND A.TIPO_FLUJO = 1)
            ,   [F.Pag.Inic.]     = ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = SWP.documento_pago_interes),'N/A')
            ,   [F.Pag.Vcto.]     = ISNULL((SELECT glosa FROM VIEW_FORMA_DE_PAGO WHERE codigo = SWP.documento_pago_interes),'N/A')
	    ,	[Moneda]	  = SWP.moneda_flujo
         FROM  VIEW_CONTRATO_FLUJO_INICIO SWP
         WHERE SWP.numero_operacion = #TEMPORAL2.[NºOperación] 
               AND SWP.TIPO_FLUJO = 1

	UPDATE #TEMPORAL2 SET [Tipo Producto]  = RTRIM([Tipo Producto]) + " (MODIFICADA)" 
	FROM VIEW_CONTRATO_LOG
	WHERE [NºOperación]  = numero_operacion
        AND   [id_Sistema]   = 'SWP'

	UPDATE #TEMPORAL2 SET [Tipo Producto]  = RTRIM([Tipo Producto]) + " (MODIFICADA)" 
	FROM VIEW_CARTERA_FORWARD_PAPEL_REGISTRO
	WHERE [NºOperación]  = numero_operacion
        AND   [id_Sistema]   = 'BFW'

       SELECT 
                [Nombre Sistema]
            ,   [Tipo Producto]
            ,   [NºOperación]
            ,   [Tipo Oper.]
            ,   [Fecha Vcto.] 
            ,   [Cliente]
            ,   [Moneda Oper.]
            ,   'MontoOper'     = SUM([Monto Oper.])
            ,   [Precio]
            ,   'Mto.Clp'       = SUM([Mto. en Pesos])
            ,   [F.Pag.Inic.]
            ,   [F.Pag.Vcto.]
            ,   [id_Sistema]
            ,   [Producto]
            ,   [Rut_Cartera]
            ,   [TipOper]
            ,   [estado]
            ,   [estado_Impreso]
	    ,   [Moneda]
	    ,	[TipoOperacion]
	    ,   [PagoRecibimos]
	    ,   [PagoEntregamos]
	    ,   [rut_cliente]
	    ,	[Control_Backoffice]
	    ,   [contabiliza]	
         INTO #TEMP
         FROM #TEMPORAL2
         WHERE 
	   ( [id_Sistema]  = @id_sistema  OR @id_sistema  = '' )
           AND ( [producto]    = @producto    OR @producto    = '' )
           AND ( [rut_cliente] = @cliente     OR @cliente     = 0  )
           AND ( [fecha]       = @fecha )
	   AND ( [Moneda]      = @nMoneda     OR @nMoneda     = 0  )
	   AND ( [TipoOperacion] = @cOperacion OR @cOperacion  = '' )
	   AND ( [PagoRecibimos] = @nFormaPago OR [PagoEntregamos] = @nFormaPago OR @nFormaPago = 0 ) 
         GROUP BY
                      [NºOperación]
                  ,   [Nombre Sistema]
                  ,   [Tipo Producto]
                  ,   [Tipo Oper.]
                  ,   [Fecha Vcto.]
                  ,   [Cliente]
		  ,   [rut_cliente]
                  ,   [Moneda Oper.]
                  ,   [F.Pag.Inic.]
                  ,   [F.Pag.Vcto.]
                  ,   [id_Sistema]
                  ,   [Producto]
                  ,   [Rut_Cartera]
		  ,   [TipOper]
                  ,   [estado]
		  ,   [estado_Impreso]
                  ,   [Precio]
		  ,   [Moneda]
		  ,   [TipoOperacion]
		  ,   [PagoRecibimos]
		  ,   [PagoEntregamos]
		  ,   [Control_Backoffice]
	          ,   [contabiliza]	


 	SELECT @cConsulta = "SELECT *,'count' = ( SELECT COUNT(*) FROM #TEMP ) FROM #TEMP "
        SELECT @cGrupo    = "GROUP BY [NºOperación],[Nombre Sistema],[Tipo Producto],[Tipo Oper.],[Fecha Vcto.],[Cliente],[Moneda Oper.],[MontoOper],[Precio],[Mto.Clp],[F.Pag.Inic.],[F.Pag.Vcto.],[id_Sistema],[Producto],[Rut_Cartera],[TipOper],[estado],[estado_Impreso],[Precio],[Moneda],[TipoOperacion],[PagoRecibimos],[PagoEntregamos], [rut_cliente],[Control_Backoffice], [contabiliza] "	
	IF @cOrden = 'N' 
	BEGIN
	SELECT @cOrdenamiento = " ORDER BY [Nombre Sistema],[NºOperación]"
	END

	IF @cOrden = 'S'
	BEGIN
	SELECT @cOrdenamiento = " ORDER BY "
		SELECT @nSw = 1
		IF @nOr_Modulo = 1 BEGIN 
			IF @nSw = 1 BEGIN
				SELECT @nSw = 2
				SELECT @cOrdenamiento = @cOrdenamiento + "[Nombre Sistema]"
			END ELSE BEGIN
				
	SELECT @cOrdenamiento = @cOrdenamiento + ",[Nombre Sistema]"
			END
 		END
		ELSE IF @nOr_Producto = 1 BEGIN
			IF @nSw = 1 BEGIN
				SELECT @cOrdenamiento = @cOrdenamiento + "[Tipo Producto]"
				SELECT @nSw = 2
			END ELSE BEGIN
				SELECT @cOrdenamiento = @cOrdenamiento + ",[Tipo Producto]"
			END
		END
		ELSE 



        IF @nOr_Cliente = 1 BEGIN
			IF @nSw = 1 BEGIN
				SELECT @cOrdenamiento = @cOrdenamiento + "[Cliente]"
				SELECT @nSw = 2
			END ELSE BEGIN
				SELECT @cOrdenamiento = @cOrdenamiento + ",[Cliente]"
			END
		END
		ELSE IF @nOr_Moneda = 1 BEGIN

			IF @nSw = 1 BEGIN
				SELECT @cOrdenamiento = @cOrdenamiento + "[Moneda Oper.]"
				SELECT @nSw = 2
			END ELSE BEGIN
				SELECT @cOrdenamiento = @cOrdenamiento + ",[Moneda Oper.]"
			END
		END
		ELSE IF @nOr_Operacion = 1 BEGIN
			IF @nSw = 1 BEGIN
				
                                SELECT @cOrdenamiento = @cOrdenamiento + "[Tipo Oper.]"
				SELECT @nSw = 2
			END ELSE BEGIN
				SELECT @cOrdenamiento = @cOrdenamiento + ",[Tipo Oper.]"
			END
		END
		ELSE IF @nOr_FormaPago = 1 BEGIN
			IF @nSw = 1 BEGIN
				SELECT @cOrdenamiento = @cOrdenamiento + "[F.Pag.Inic.]"
				SELECT @nSw = 2
			END ELSE BEGIN
				SELECT @cOrdenamiento = @cOrdenamiento + ",[F.Pag.Inic.]"
			END
		END

		IF @nOr_Asc = 1 BEGIN
			SELECT @cOrdenamiento = @cOrdenamiento + " ASC"
		END ELSE BEGIN
			SELECT @cOrdenamiento = @cOrdenamiento + " DESC"
		END

	END

	EXECUTE (@cConsulta + @cGrupo + @cOrdenamiento)

END

GO
