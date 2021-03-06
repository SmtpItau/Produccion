USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGACARTERAPARABLOQUEOPACTO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CARGACARTERAPARABLOQUEOPACTO]    ( @OPCION               INT     = 0 -- 1 = Filtro 2=Cartera
							 ,@CartFinanciera 	CHAR(15)= ''
							 ,@CartSuper		CHAR(15)= ''
	 						 )	
AS
BEGIN
SET NOCOUNT ON

declare @Fecha_hoy  datetime
declare @Fecha_Ant datetime



	-- SP_CargaCarteraParaBloqueoPacto 2, '3', 'ffsdfd'
	--declare @Fecha_hoy  datetime
	--declare @Fecha_Ant datetime
	select    @Fecha_hoy = acfecproc 
        ,         @Fecha_Ant = acfecAnte  from BacTraderSuda..mdac
	
	-- MDDI	                : Tabla que contiene la Cartera Disponible para Vender Definitivo y hacer Pactos. Su origen 
	--                        puede ser una Compra con Pacto o Compra Definitiva. Corresponde a la tabla base de los
	--                        queries unidos con UNION.
	-- MDCI                 : Información de los papeles comprados con Pacto.
	-- MDCP                 : Información de los papeles comprados definitivos.
	-- MDCO                 : Multiplos en que se debe vender un papel que se exige para ciertos papeles.
	-- MDVI                 : Registro de las operaciones de Venta con Pacto.
	-- BlqPact              : Tabla de bloqueo para Pacto, esa es la que llenará Patricio Angulo
	-- INSTRUMENTO          : parámetros del instrumento 
	-- EMISOR               : Los papeles de renta fija son instrumentos de Deuda, el deudor es el Emisor.
	-- VALORIZACION_MERCADO : Según tasas que se cargan para cada papel este es valorizado.
	
	-- Instrumentos de Deuda: papeles que formalizan las empresas privadas o del gobierno
	--                        en que solicitan financiamiento para ser devuelto según
	--                        calendarios de pago (varias fechas o una)
	-- Tabla de Desarrollo  : cuando un papel tiene más de un pago estos se registran en 
	--                        tablas de desarrollo.
	-- Compra Definitiva    : los instrumentos de Deuda se transan en el mercado y por tanto se
	--                        compran con el fin de invertir. Por ejemplo cuando Corpbanca compra
	--                        un papel, en la base de datos se registra una 'CP'.
	-- Compra con Pacto	: bajo el punto de vista del Banco Corpbanca una Compra con Pacto 
	--                        representa solicitar dinero prestado y dejar instrumentos cuya
	--                        valorización sea equivalente al monto. Para esto debe haber un 
	--                        acuerdo entre las partes para valorizar los instrumentos y además
	--                        acordar la tasa de financiamiento con que se calcula el interés
	--                        del préstamo. Al vencer el pacto CorpBanca devuelve los fondos 
	--                        solicitados más un monto de interés.
	--                        Un plus de las compras con Pacto es que los instrumentos del pacto
	--                        pueden formar parte de la cartera y por tanto pueden ser utilizados
	--                        en Ventas con Pacto y por esta razón deben participar en el query
	--                        de instrumentos a bloquear para pacto.
	
	-- MAP 20101013 Antes era CI...
	Select fecha_valorizacion, 
	       id_sistema, 
	       rmnumdocu, 
	       rmcorrela, 
	       Tasa_Compra   = max( tasa_compra ), 
	       Tasa_Mercado  = Max( tasa_Mercado ),
	       Valor_Mercado = sum( Valor_Mercado ) 
	into #VALORIZACION_MERCADO  
	from BacTraderSuda..VALORIZACION_MERCADO 
	where fecha_valorizacion = @Fecha_Ant
	group by fecha_valorizacion, id_sistema, rmnumdocu, rmcorrela
	
	SELECT    'EMISOR'        = R.digenemi 
	   ,      'SERIE'         = R.Diinstser 
	   ,      'ORIGEN'        = R.ditipoper
	   ,      'COMPRA' = R.Dinumdocu
	   ,      'CORRELATIVO'   = R.Dicorrela
	   ,	  'NUMERO COMPRA' = CAST(R.Dinumdocu AS VARCHAR)+'-'+ CAST(R.Dicorrela AS VARCHAR)
	   ,      'NOMINAL'       = R.DiNominal - isnull( BlqPact.bpnominal , 0 ) + isnull( PactoVig.ViNominal , 0 )
	   ,      'BLOQUEO PACTO'   =   isnull( BlqPact.bpnominal , 0 )
	   ,      'NOMINAL TOTAL' = R.DiNominal + isnull( PactoVig.ViNominal , 0 )
	   ,      'NOMINAL EN PACTO ' = isnull( PactoVig.ViNominal , 0 )
	   ,      'CORTE MINIMO'  = isnull( Cort.comtocort   , 0 )
	   ,      'TIR DE COMPRA' = R.DiTirComp
	   ,      'COD CART.'	  = R.Tipo_Cartera_Financiera			
	   ,      'CARTERA FIN.'  = LTRIM(RTRIM(R.Tipo_Cartera_Financiera)) + '/' + LTRIM(RTRIM(cFinan.tbglosa))     
	   ,      'INSTRUMENTO'   = Instr.inserie
	   ,	  'COD LIBRO'	  = R.id_libro
	   ,      'LIBRO       '  = LTRIM(RTRIM(R.id_libro)) + '/' + LTRIM(RTRIM(Libro.tbglosa))
	   ,	  'COD CART.SUP'  = R.codigo_carterasuper                    
	   ,      'CARTERA SUPER' = LTRIM(RTRIM(R.codigo_carterasuper)) + '/' + LTRIM(RTRIM(cNorma.tbglosa))
	   ,      'FECHA COMPRA'  = convert(char(10), Comp.CpFeccomp,103)   
	   ,      'VALOR PRESENTE'= R.Divptirc  
	   ,      'VALOR MERCADO' = isnull( M.valor_mercado, 0 )
	   ,      'DIF VAL. MERC' = R.Divptirc - isnull( M.valor_mercado , 0 )
	   ,      'TIR DE MERCADO'= isnull( M.tasa_mercado, 0 )
	   ,      'MONEDA EMISION' = Instr.inmonemi 
	   ,      'DURACION MOD.' = Comp.CpDurmod  
	   ,      'CONVEXIDAD'    = Comp.CpConvex
	   ,      'PER. EN CART.' = DATEDIFF(DAY, Comp.CpFeccomp,@Fecha_Hoy )
	   ,      'PLAZO RES'     = DATEDIFF(DAY, @Fecha_Hoy , R.difecsal ) 
	
	   FROM   BacTraderSuda..MDDI R 
	                 JOIN BacTraderSuda..MDCP                        Comp    ON Comp.CpNumdocu = R.DiNumdocu and Comp.Cpcorrela = R.DiCorrela
	            LEFT JOIN BacTraderSuda..MDCO                         Cort   ON Cort.CoNumDocu  = R.DiNumDocu and Cort.CoCorrela = R.DiCorrela
	            LEFT JOIN BacTraderSuda..MDVI                        PactoVig ON PactoVig.ViNumDocu = R.DiNumDocu and PactoVig.ViCorrela = R.DiCorrela
	            LEFT JOIN BacTraderSuda..bloqueadoPacto              BlqPact  ON BlqPact.BpNumDocu  = R.DiNumDocu and BlqPact.BpCorrela  = R.DiCorrela
	            LEFT JOIN BacParamSuda..INSTRUMENTO                  Instr   ON Comp.CpCodigo = Instr.incodigo
	            LEFT JOIN BacParamSuda..EMISOR                       Emi    ON Instr.inrutemi = Emi.emrut
	            LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE        EmiTip ON tbcateg = 210 and Emi.emtipo = tbcodigo1
	            LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE cNorma ON cNorma.tbcateg = 1111 AND R.codigo_carterasuper = cNorma.tbcodigo1
	            LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE cFinan ON cFinan.tbcateg = 204  AND R.Tipo_Cartera_Financiera = cFinan.tbcodigo1
	            LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Libro  ON Libro.tbcateg = 1552  AND R.id_libro = Libro.tbcodigo1
	            LEFT JOIN #VALORIZACION_MERCADO   M    ON M.fecha_valorizacion = @Fecha_Ant  AND M.rmNumdocu = R.DiNumdocu and  M.rmcorrela = R.DiCorrela -- MAP 20101013 Antes era Fisica
	
	   where DiNominal <> 0  AND (         ( @CartFinanciera = '' or CHARINDEX( LTRIM(RTRIM(R.Tipo_Cartera_Financiera)), @CartFinanciera ) > 0) 
				         AND   ( @CartSuper  = ''     or CHARINDEX( LTRIM(RTRIM(R.codigo_carterasuper)), @CartSuper)      > 0) 
                                         AND     @Opcion = 1                                         

                                        OR
				             R.Tipo_Cartera_Financiera = @CartFinanciera 
                                         AND     @Opcion = 2 
                                       )
	
	UNION  
	
	SELECT    'EMISOR'        = R.digenemi 
	   ,      'SERIE'         = R.Diinstser 
	   ,      'ORIGEN'        = R.ditipoper
	   ,      'COMPRA' = R.Dinumdocu
	   ,      'CORRELATIVO'   = R.Dicorrela
	   ,	  'NUMERO COMPRA' = CAST(R.Dinumdocu AS VARCHAR)+'-'+ CAST(R.Dicorrela AS VARCHAR)
	   ,      'NOMINAL'       = R.DiNominal - isnull( BlqPact.bpnominal , 0 ) + isnull( PactoVig.ViNominal , 0 )
	   ,      'BLOQUEO PACTO'   =   isnull( BlqPact.bpnominal , 0 )
	   ,      'NOMINAL TOTAL' = R.DiNominal + isnull( PactoVig.ViNominal , 0 )
	   ,      'NOMINAL EN PACTO ' = isnull( PactoVig.ViNominal , 0 )
	   ,      'CORTE MINIMO'  = isnull( Cort.comtocort   , 0 )
	   ,      'TIR DE COMPRA' = R.DiTirComp
	   ,	  'COD CART'	  = R.Tipo_Cartera_Financiera
	   ,      'CARTERA FIN.'  = LTRIM(RTRIM(R.Tipo_Cartera_Financiera)) + '/' + LTRIM(RTRIM(cFinan.tbglosa))     
	   ,      'INSTRUMENTO'   = Instr.inserie
	   ,	  'COD LIBRO'	  = R.id_libro	
	   ,      'LIBRO       '  = LTRIM(RTRIM(R.id_libro)) + '/' + LTRIM(RTRIM(Libro.tbglosa))  
	   ,	  'COD CART.SUP'  = R.codigo_carterasuper
	   ,      'CARTERA SUPER' = LTRIM(RTRIM(R.codigo_carterasuper)) + '/' + LTRIM(RTRIM(cNorma.tbglosa))
	   ,      'FECHA COMPRA'  = convert(char(10), Comp.CiFeccomp,103)                      
	   ,      'VALOR PRESENTE'= R.Divptirc  
	   ,      'VALOR MERCADO' = isnull( M.valor_mercado, 0 )
	   ,      'DIF VAL. MERC' = R.Divptirc - isnull( M.valor_mercado , 0 )
	   ,      'TIR DE MERCADO'= isnull( M.tasa_mercado , 0 )
	   ,      'MONEDA EMISION' = Instr.inmonemi 
	   ,      'DURACION MOD.' = Comp.CiDurmod  
	   ,      'CONVEXIDAD'    = Comp.CiConvex
	   ,      'PER. EN CART.' = DATEDIFF(DAY, Comp.CiFeccomp,@Fecha_Hoy )
	   ,      'PLAZO RES'    = DATEDIFF(DAY, @Fecha_Hoy , R.difecsal ) 
	   FROM   BacTraderSuda..MDDI R 
	                 JOIN BacTraderSuda..MDCI                        Comp    ON Comp.CiNumdocu = R.DiNumdocu and Comp.Cicorrela = R.DiCorrela
	            LEFT JOIN BacTraderSuda..MDCO                        Cort   ON Cort.CoNumDocu  = R.DiNumDocu and Cort.CoCorrela = R.DiCorrela
	            LEFT JOIN BacTraderSuda..MDVI                        PactoVig ON PactoVig.ViNumDocu = R.DiNumDocu and PactoVig.ViCorrela = R.DiCorrela
	            LEFT JOIN BacTraderSuda..bloqueadoPacto              BlqPact  ON BlqPact.BpNumDocu  = R.DiNumDocu and BlqPact.BpCorrela  = R.DiCorrela
	            LEFT JOIN BacParamSuda..INSTRUMENTO                  Instr   ON Comp.CiCodigo = Instr.incodigo
	            LEFT JOIN BacParamSuda..EMISOR                       Emi    ON Instr.inrutemi = Emi.emrut
	            LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE        EmiTip ON tbcateg = 210 and Emi.emtipo = tbcodigo1
	            LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE cNorma ON cNorma.tbcateg = 1111 AND R.codigo_carterasuper = cNorma.tbcodigo1
	            LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE cFinan ON cFinan.tbcateg = 204  AND R.Tipo_Cartera_Financiera = cFinan.tbcodigo1
	            LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE Libro  ON Libro.tbcateg = 1552  AND R.id_libro = Libro.tbcodigo1
	            LEFT JOIN #VALORIZACION_MERCADO   M    ON M.fecha_valorizacion = @Fecha_Ant  AND M.rmNumdocu = R.DiNumdocu and  M.rmcorrela = R.DiCorrela -- MAP 20101013 Antes era Fisica
	   where DiNominal <> 0  AND (         ( @CartFinanciera = '' or CHARINDEX( LTRIM(RTRIM(R.Tipo_Cartera_Financiera)), @CartFinanciera ) > 0) 
				         AND   ( @CartSuper  = ''     or CHARINDEX( LTRIM(RTRIM(R.codigo_carterasuper)), @CartSuper)      > 0) 
                                         AND     @Opcion = 1                                         

                                        OR
				             R.Tipo_Cartera_Financiera = @CartFinanciera 
                                         AND     @Opcion = 2 
                                       )
  

END

GO
