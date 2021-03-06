USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_OPERACIONES_PENDIENTES]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_FILTRO_OPERACIONES_PENDIENTES '20200430', 'CFEA7478', ' ', ' ', '', '', '', 0
CREATE PROCEDURE [dbo].[SP_FILTRO_OPERACIONES_PENDIENTES]
		(@cFecha		DATETIME      
		,@Usuario		CHAR(15)      
		,@Modulo		CHAR(3)      
		,@T_Operacion   CHAR(255)      
		,@Operador      CHAR(10)      
		,@Moneda		CHAR(3)      
		,@Digitador		CHAR(15)=''	--- Nuevo
		,@aprueba_linea	NUMERIC(1) = 0 -->busca error linea
		)      
AS      
BEGIN      

   SET NOCOUNT ON      
      
   DECLARE @Fecha_Proceso CHAR(08)      
	--> +++ cvegasan 2017.08.08 Control Lineas IDD
	IF OBJECT_ID('tempdb..#TEMP')IS NOT NULL 
		DROP TABLE #TEMP

	IF OBJECT_ID('tempdb..#TEMP2')IS NOT NULL 
		DROP TABLE #TEMP2
	--< --- cvegasan 2017.08.08 Control Lineas IDD
	CREATE TABLE #TEMP      
		( 
		Sistema  CHAR(5),    
		Glo_Producto CHAR (40) ,      
		numoper  NUMERIC(10) ,      
		cliente  CHAR(80) ,      
		moneda	CHAR(05) ,      
		Monto	NUMERIC(19,4) ,      
		Operador CHAR(15) ,      
		ErrorG   CHAR(02)     
		--> +++ cvegasan 2017.08.08 Control Lineas IDD
		,Correlativo	NUMERIC(3)
		--< --- cvegasan 2017.08.08 Control Lineas IDD
		)
      
	CREATE TABLE #TEMP2      
		( 
		Sistema  CHAR (5),    
		Tipoper  CHAR (80) ,       
		Glo_Producto CHAR (40) ,      
		numoper  NUMERIC(10) ,      
		cliente  CHAR(80) ,      
		moneda  CHAR(05) ,      
		Monto  NUMERIC(19,4) ,      
		Operador CHAR(15) ,      
		ErrorG   CHAR(02) ,      
		Codprod  CHAR(20) ,      
		RutCart  NUMERIC(09) ,      
		FirmaOpe CHAR(15) ,         
		FirmaSup1 CHAR(15) ,      
		FirmaSup2 CHAR(15) ,      
		Producto  VARCHAR(15)     ,      
		TipoCliente  INTEGER,
		Digitador	CHAR(15)
		--> +++ cvegasan 2017.08.08 Control Lineas IDD
		,Numero_IDD				NUMERIC (9)
		,Correlativo			NUMERIC(3)
		,Flag_Afecta_Linea		VARCHAR(1)
		,Flag_Linea_Especial	VARCHAR(1)
		--< --- cvegasan 2017.08.08 Control Lineas IDD
		)      
      
   EXECUTE dbo.Sp_Importacion_Opciones @Usuario       
      

--select 'fre',@cFecha ,@Usuario, @aprueba_linea           

   INSERT #TEMP EXECUTE Sp_Lineas_LeerOpPendientes  @cFecha ,@Usuario, @aprueba_linea            
    
	
--	select 'fre',* from #temp
	   
	INSERT INTO #TEMP2          
	SELECT Sistema      
	,''      
	,Glo_Producto      
	,numoper          
	,cliente      
	,moneda      
	,Monto                       
	,Operador      
	,ErrorG         
	,''       
	,0       
	,''      
	,''       
	,''      
	, ''      
	, 0      
	,''
	--> +++ cvegasan 2017.08.08 Control Lineas IDD
	,0				-- Numero IDD
	,correlativo	-- Correlativo
	,'N'			-- Flag Afecta Linea
	,'N'			-- Flag Linea Especial
	--< --- cvegasan 2017.08.08 Control Lineas IDD
	FROM  #TEMP      
      
	------------------------------------------Spot-------------------------------------------------------
	UPDATE	#TEMP2
	SET		Tipoper			= descripcion
	,		Digitador		= memo.moDigitador
	,		Glo_Producto	= case	when memo.motipmer	= 'PTAS' then descripcion + ' PUNTA'
									when memo.motipmer	= 'EMPR' then descripcion + ' EMPRESA'      
									when memo.motipmer	= 'ARBI' then descripcion + ' ARBITRAJE'      
									else descripcion + memo.motipmer
								end
	,		Codprod			= memo.motipmer
	,		Producto		= memo.motipmer
	,		TipoCliente		= clien.cltipcli
	FROM	baccamsuda.dbo.memo memo  with(nolock)
			inner join 
			(	select	clrut, clcodigo, cltipcli 
				from	bacparamsuda.dbo.cliente with(nolock)
			)	clien	on	clien.clrut		= memo.morutcli
						and	clien.clcodigo	= memo.mocodcli
			inner join
			(	select	id_sistema, descripcion, codigo
				from	Bacparamsuda..OPERACION_PRODUCTO a with(nolock)
			)	prod	On	prod.Id_Sistema	= 'BCC'
						and prod.codigo		= memo.motipope
	WHERE	numoper			= memo.monumope
	------------------------------------------Spot----------------------------------------------------------      
      
	------------------------------------------Forward-------------------------------------------------------
	UPDATE	#TEMP2    
	SET		Tipoper      = op.descripcion    
	,		Digitador    = ca.moDigitador 
	,		Glo_Producto = CASE WHEN ca.monroopemxclp > 0 AND ca.mocodpos1 <> 1 THEN op.descripcion + ' ARBITRAJE MX-CLP'
								WHEN ca.monroopemxclp > 0 AND ca.mocodpos1  = 1 THEN op.descripcion + ' ARBITRAJE MX-CLP (SC)'
								ELSE CASE	WHEN ca.mocodpos1 = 1 THEN glo_producto 
											ELSE op.descripcion + ' ' + glo_producto
										END
							END
     ,		Codprod      = CONVERT(CHAR(10), ca.mocodpos1)
     ,		Producto     = ca.mocodpos1
     ,		TipoCliente  = cl.cltipcli
    FROM	BacFwdSuda.dbo.MFMO ca								with(nolock)	
			INNER JOIN BacParamSuda.dbo.CLIENTE            cl	with(nolock) ON cl.clrut      = ca.mocodigo and cl.clcodigo        = ca.mocodcli
			INNER JOIN BacParamSuda.dbo.PRODUCTO           pr	with(nolock) ON pr.id_sistema = 'BFW'       and pr.codigo_producto = ca.mocodpos1
			INNER JOIN BacParamSuda.dbo.OPERACION_PRODUCTO op	with(nolock) ON op.id_sistema = 'BFW'       and op.codigo          = ca.motipoper
	WHERE	ca.monumoper   = numoper

	UPDATE	#TEMP2
	SET		Tipoper      = op.descripcion
	,		Digitador    = ca.caoperador
	,		Glo_Producto = CASE WHEN ca.var_moneda2 > 0 AND ca.cacodpos1 <> 1 THEN op.descripcion + ' ARBITRAJE MX-CLP'
								WHEN ca.var_moneda2 > 0 AND ca.cacodpos1  = 1 THEN op.descripcion + ' ARBITRAJE MX-CLP (SC)'
								ELSE CASE	WHEN ca.cacodpos1 = 1 THEN glo_producto
											ELSE op.descripcion + ' ' + glo_producto
										END
							END
     ,		Codprod      = CONVERT(CHAR(10), ca.cacodpos1)
     ,		Producto     = ca.cacodpos1
     ,		TipoCliente  = cl.cltipcli
    FROM	BacFwdSuda.dbo.MFCA	ca								with(nolock)
			INNER JOIN BacParamSuda.dbo.CLIENTE            cl	with(nolock) ON cl.clrut = ca.cacodigo and cl.clcodigo = ca.cacodcli
			INNER JOIN BacParamSuda.dbo.PRODUCTO           pr	with(nolock) ON pr.id_sistema = 'BFW' and pr.codigo_producto = ca.cacodpos1
			INNER JOIN BacParamSuda.dbo.OPERACION_PRODUCTO op	with(nolock) ON op.id_sistema = 'BFW' and op.codigo = ca.catipoper
	WHERE	ca.canumoper   = numoper
	------------------------------------------Forward----------------------------------------------------------  
      
	------------------------------------------Renta Fija-------------------------------------------------------
	UPDATE	#TEMP2
	SET		Tipoper			= a.descripcion --Case when motipoper ='IB' then substring(a.descripcion,1,14) else a.descripcion end      
    ,		Digitador		= moDigitador
	,		Glo_Producto	= a.descripcion      
	,		Codprod			= motipoper      
	,		RutCart			= morutcart      
	,		Producto		= case when motipoper ='IB' then moinstser else motipoper end
	,		TipoCliente		= cl.cltipcli
	FROM	view_mdmo  with(nolock) 
			INNER JOIN BacParamSuda.dbo.CLIENTE cl with(nolock) ON cl.clrut = morutcli and cl.clcodigo = mocodcli
			INNER JOIN BacParamSuda.dbo.OPERACION_PRODUCTO a with(nolock) ON	a.id_sistema = 'BTR'       
																		  and	a.codigo = case	when motipoper = 'IB' then moinstser 
																								else motipoper 
																							end
	WHERE	monumoper		= numoper
	------------------------------------------Renta Fija-------------------------------------------------------
      
	------------------------------------------Swap-------------------------------------------------------------
	UPDATE	#TEMP2
	SET		Tipoper				= case	when tipo_swap = 1 then 'ST'
										when tipo_swap = 2 then 'SM'
										when tipo_swap = 3 then 'FR'
										when tipo_swap = 4 then 'SP'
									end
	,		Digitador			= moDigitador
	,		Producto			= case	when tipo_swap = 1 then 'ST'
										when tipo_swap = 2 then 'SM'
										when tipo_swap = 3 then 'FR'
										when tipo_swap = 4 then 'SP'
									end
	,		TipoCliente			= cl.cltipcli
	FROM	view_movdiario   with(nolock)
			INNER JOIN BacParamSuda.dbo.CLIENTE cl with(nolock) ON cl.clrut = rut_cliente and cl.clcodigo = codigo_cliente
	WHERE	numero_operacion	= numoper
	and		Sistema				= 'PCS'

	UPDATE	#TEMP2        
	SET		Tipoper				= a.descripcion
	,		Glo_Producto		= a.descripcion + ' ' + b.descripcion
	,		Codprod				= case	when  tipo_swap = 1 then 'TASA'
										when  tipo_swap = 2 then 'MONEDA'
										when  tipo_swap = 3 then 'FRA'
										when  tipo_swap = 4 then 'PROMEDIO CAMARA'
									end
	FROM	view_movdiario with(nolock)
	,		Bacparamsuda..OPERACION_PRODUCTO	a	with(nolock)
	,		Bacparamsuda..PRODUCTO				b	with(nolock)      
	WHERE	numero_operacion	= numoper
	and		Sistema				= a.id_sistema
	and		tipoper				= b.codigo_producto
	------------------------------------------Swap-------------------------------------------------------

	------------------------------------------Bonos------------------------------------------------------
	UPDATE	#TEMP2
	SET		Tipoper				= b.descripcion
	,		Glo_Producto		= c.descripcion
	,		Digitador			= a.moDigitador
	,		Codprod				= a.motipoper
	,		Producto			= a.motipoper
	,		Correlativo			= a.mocorrelativo
	,		TipoCliente			=	(	select	cltipcli
										from	BacParamSuda.dbo.CLIENTE with(nolock)
										where	clrut		= morutcli
										and		clcodigo	= mocodcli
									)
	FROM	VIEW_text_mvt_dri					a with(nolock)
	,		Bacparamsuda..OPERACION_PRODUCTO	b with(nolock)
	,		Bacparamsuda..PRODUCTO				c with(nolock)
	WHERE	a.monumoper			= numoper
	and		a.motipoper			= b.codigo
	and		a.motipoper			= substring(c.codigo_producto,1,2)
	and		Sistema				= 'BEX'
	and     b.id_sistema		= Sistema
	------------------------------------------Bonos------------------------------------------------------
      
	------------------------------------------Opciones---------------------------------------------------
	UPDATE	#TEMP2
	SET		Tipoper						= b.descripcion
	,		Glo_Producto				= case when CodEstructura in(8) then 'FORWARD AMERICANO' else b.descripcion + ' ' + c.descripcion END
	,		Codprod						= convert(char(10),'OPT')
	,		Producto					= convert(Varchar(15),'OPT')
	,		TipoCliente					= (select cltipcli FROM BacParamSuda.dbo.CLIENTE WHERE clrut = a.RutCliente and clcodigo = a.Codigo)
	FROM	DBO.TAB_Importada_MoEncContrato		a	with(nolock)
	,		Bacparamsuda..OPERACION_PRODUCTO	b	with(nolock)
	,		Bacparamsuda..PRODUCTO				c	with(nolock)
	WHERE	a.NumContrato = numoper
	and		a.CVEstructura = b.codigo
	and		convert (char(05),'OPT')	= c.codigo_producto
	and		Sistema						= 'OPT'
	and		b.id_sistema				= 'OPT'
	------------------------------------------Opciones---------------------------------------------------

	------------------------------------------ FIRMAS ---------------------------------------------------
	UPDATE	#TEMP2        
	SET		FirmaOpe	= Operador_Origen		-->	CASE WHEN  Firma1=Operador_Origen THEN Operador_Origen ELSE Operador_Origen END
	,		FirmaSup1	= CASE	WHEN	Firma1 <> '' 
									OR	Firma1 <> 'FALTA'	THEN	Firma1 
								ELSE	'FALTA' 
							END
	,		FirmaSup2	= CASE	WHEN	Firma2	= ''		THEN 'FALTA'
								WHEN	Firma1	= Firma2	THEN 'FALTA'
								ELSE	Firma2
							END
	FROM	DETALLE_APROBACIONES	with(nolock)
	WHERE   Fecha_Operacion			= @cFecha
	AND		Sistema					= case	when Id_Sistema = 'BTR' then Sistema else Id_Sistema end
	AND     Numero_Operacion		= numoper
	------------------------------------------ FIRMAS ---------------------------------------------------

	--> +++ cvegasan 2017.08.08 Control Lineas IDD
	------------------------------------------ ACTUALIZACION NUMERO IDD ---------------------------------
	UPDATE	#TEMP2
	SET
		Numero_IDD			= IDD.nNumeroIdd
		,Flag_Afecta_Linea	= 'S'
		,Flag_Linea_Especial= IDD.sControlLinea
	FROM	Transacciones_IDD	IDD with(nolock)
	WHERE   Sistema		= IDD.cModulo
	AND		numoper		= IDD.nOperacion
	AND		correlativo	= idd.iCorrelativo	
	AND		Codprod		= CASE WHEN Sistema <> 'PCS' AND Sistema <> 'BEX' AND IDD.cProducto <> 'ICOL' THEN IDD.cProducto  
								WHEN Sistema = 'BTR' AND IDD.cProducto = 'ICOL' THEN 'IB' 
								WHEN Sistema = 'BEX' AND IDD.cProducto = 'CPX' THEN 'CP'
								WHEN Sistema = 'BEX' AND IDD.cProducto = 'VPX' THEN 'VP'
							
						  ELSE
								CASE WHEN  IDD.cProducto = 1 then 'TASA'
								WHEN  IDD.cProducto = 2 then 'MONEDA'
								WHEN  IDD.cProducto = 3 then 'FRA'
								WHEN  IDD.cProducto = 4 then 'PROMEDIO CAMARA'
								END
							END
	
	
	------------------------------------------ ACTUALIZACION NUMERO IDD ---------------------------------
	--< --- cvegasan 2017.08.08 Control Lineas IDD
	
	---------------------------------------- CTRL USUARIO -----------------------------------------------
	DELETE	FROM	#TEMP2
			WHERE	SISTEMA	NOT IN(	SELECT	DISTINCT sistema 
									FROM	BacLineas.dbo.PERFIL_USUARIO_LINEAS 
									WHERE	usuario		= @Usuario 
									AND		activado	= 1)

	SELECT	tmp.* 
	FROM	#TEMP2                                         tmp    
			INNER JOIN BacLineas.dbo.PERFIL_USUARIO_LINEAS usr	ON	usr.Usuario      = @Usuario
																and usr.sistema      = tmp.sistema
																and usr.Producto     = CASE WHEN tmp.sistema = 'BEX' AND tmp.Producto = 'CP' THEN 'CPX'
																							WHEN tmp.sistema = 'BEX' AND tmp.Producto = 'VP' THEN 'VPX'
																							ELSE tmp.Producto
																						END
																and usr.Tipo_Cliente = tmp.TipoCliente
																and usr.Activado     = 1
	WHERE (tmp.SISTEMA  = @Modulo      OR @Modulo      = '')
	AND   (tmp.TIPOPER  = @T_Operacion OR @T_Operacion = '')
	AND   (tmp.OPERADOR = @Operador    OR @Operador    = '')
	AND   (tmp.MONEDA   = @Moneda      OR @Moneda      = '')
	AND   (tmp.DIGITADOR= @Digitador   OR @Digitador   = '')
	ORDER 
	BY		tmp.Sistema
		,	tmp.numoper
	---------------------------------------- CTRL USUARIO -----------------------------------------------

END
GO
