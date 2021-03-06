USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Llena_Contabiliza_Saldos_btr]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[Sp_Llena_Contabiliza_Saldos_btr]
           ( @fecha_hoy       DATETIME
           , @id_sistema      CHAR(3)
           , @producto        VARCHAR(5)
           )
AS

BEGIN
 
   SET DATEFORMAT dmy

   DECLARE @control_error    INTEGER
   DECLARE @valor_observado  FLOAT   
   DECLARE @valor_uf         FLOAT   
   DECLARE @valor_ivp        FLOAT   
   DECLARE @rut_central      NUMERIC(10)
   DECLARE @habil            char(1)
   DECLARE @fecha_paso       datetime
   DECLARE @vvista           char(4)
   DECLARE @rut_entidad      NUMERIC(9)
   DECLARE @Codigo_Entidad   NUMERIC(9)
   DECLARE @plaza            numeric(5)
   DECLARE @pais             numeric(5)
   DECLARE @FECHA1           DATETIME
   DECLARE @FECHA2           DATETIME
   DECLARE @fecha_Cierre     DATETIME
   DECLARE @fecha_aux        DATETIME




   SELECT  @valor_observado = 1.0
   SELECT  @valor_observado = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 and vmfecha = @fecha_hoy
   SELECT  @valor_uf        = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 998 and vmfecha = @fecha_hoy
   SELECT  @valor_ivp       = ISNULL(vmvalor,0.0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 997 and vmfecha = @fecha_hoy
   SELECT  @rut_entidad     = (SELECT rut_entidad    FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad = 1)
   SELECT  @Codigo_Entidad  = (SELECT codigo_entidad FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad = 1)

   SELECT  @pais            = (SELECT Codigo_Pais     FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad = 1)
   SELECT  @plaza           = (SELECT TOP 1 Codigo_Plaza    FROM VIEW_PLAZA WHERE CODIGO_PAIS = @pais)

   SELECT  @rut_central = 97029000

   /* ======================================================================================== */
   /* Busca Fecha a Contabilizar para Tasa Mercado                                             */
   /* ======================================================================================== */

   DECLARE @Periodo        CHAR(1)
      ,    @FechaAnt       DATETIME
      ,    @FechaProx      DATETIME
      ,    @FechaProc      DATETIME
      ,    @lflag          INTEGER
      ,    @Habiles        CHAR(1)

   SELECT @Periodo   = 'M'         --- Indica el Perio en que Buscara Fecha
      ,   @Habiles   = 'N'         --- Indica si las Fechas Anteriores seran dias Habiles
      ,   @FechaProc = @fecha_hoy

   SELECT @FechaProx = DATEADD(MONTH,1,@FechaProc)-DATEPART(DAY,@FechaProc)
      
   IF @Periodo = 'M' BEGIN

      SELECT  @FechaAnt   = @FechaProc - DATEPART(DAY,@FechaProc)
      SELECT  @FechaProx  = DATEADD(MONTH,1,@FechaProc)-DATEPART(DAY,@FechaProc)
      SELECT  @FechaProc  = @FechaAnt
      
      IF @FechaProx = @fecha_hoy
      BEGIN 

         SELECT  @FechaAnt   = @fecha_hoy

      END

   END

   SELECT 
             @FECHA1 = fecha_proceso
            ,@FECHA2 = fecha_proxima
   FROM VIEW_DATOS_GENERALES

   CREATE TABLE #FECHA( FECHA DATETIME )
   INSERT INTO #FECHA EXEC SP_CON_FECHA_FERIADO @PAIS , @PLAZA , @fecha_hoy , 2 
   SELECT TOP 1 @FechaProx = FECHA FROM #FECHA
   
   IF MONTH(@FECHA1) <> MONTH(@FECHA2) AND DATEDIFF( DAY , @FECHA2 , @FECHA1 ) > 1 BEGIN              
       CREATE TABLE #FECHA1( FECHA DATETIME , ESPECIAL CHAR(01) )
       INSERT INTO #FECHA1 EXEC SP_CON_FECHA_FERIADO @PAIS , @PLAZA , @fecha_hoy , 1
       SELECT TOP 1 @FechaProx = FECHA FROM #FECHA1
   END

   SELECT @FechaAnt = CASE WHEN @FechaProx > @fecha_hoy AND @FechaProx < (SELECT Fecha_proxima FROM VIEW_DATOS_GENERALES) THEN  @FechaProx ELSE @FechaAnt END


   /* ======================================================================================== */
   /* busca si el sistema esta en una fecha no habil (fin de mes feriado)                      */
   /* ======================================================================================== */

   SELECT @fecha_paso = @fecha_hoy

EXECUTE Sp_Diahabil @fecha_paso OUTPUT

   IF DATEDIFF(DAY, @fecha_hoy, @fecha_paso) <> 0
      SELECT @habil = 'N'
   ELSE
      SELECT @habil = 'S'


--**********************************************************
--**********************************************************
-- RENTA FIJA
--**********************************************************
--**********************************************************


   IF @id_sistema = 'BTR'
   BEGIN

      IF @producto = 'CP'
      BEGIN 



	SELECT	*
	INTO	#TMP_CARTERA_PROPIA
	FROM	CARTERA_PROPIA

	UPDATE	#TMP_CARTERA_PROPIA
	SET	cpnominal	= cpnominal	+ ISNULL((SELECT SUM(vinominal)   FROM CARTERA_VENTA_PACTO WHERE cpnumdocu=vinumdocu AND cpcorrela=vicorrela AND virutcli = @rut_central) ,0)  ,
		cpvalcomp	= cpvalcomp	+ ISNULL((SELECT SUM(vivalcomp)   FROM CARTERA_VENTA_PACTO WHERE cpnumdocu=vinumdocu AND cpcorrela=vicorrela AND virutcli = @rut_central) ,0)  ,
		cpvalcomu 	= cpvalcomu	+ ISNULL((SELECT SUM(vivalcomu)   FROM CARTERA_VENTA_PACTO WHERE cpnumdocu=vinumdocu AND cpcorrela=vicorrela AND virutcli = @rut_central) ,0)  ,
		cpvptirc	= cpvptirc	+ ISNULL((SELECT SUM(vivptirc)    FROM CARTERA_VENTA_PACTO WHERE cpnumdocu=vinumdocu AND cpcorrela=vicorrela AND virutcli = @rut_central) ,0)  ,
		cpinteresc	= cpinteresc	+ ISNULL((SELECT SUM(viinteresv)  FROM CARTERA_VENTA_PACTO WHERE cpnumdocu=vinumdocu AND cpcorrela=vicorrela AND virutcli = @rut_central) ,0)  ,
		cpreajustc	= cpreajustc	+ ISNULL((SELECT SUM(vireajustv)  FROM CARTERA_VENTA_PACTO WHERE cpnumdocu=vinumdocu AND cpcorrela=vicorrela AND virutcli = @rut_central) ,0)



--***********************
--CARTERA PROPIA, CAPITAL
--***********************

         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR

            ,   Valor_Compra     
            ,   Valor_Presente   
            ,   Valor_Venta      
            ,   Utilidad         
            ,   Perdida          
            ,   Interes_Papel    
            ,   Reajuste_Papel   
            ,   Interes_Pacto    
            ,   Reajuste_Pacto   
            ,   Valor_Cupon      
            ,   NominalPesos     
            ,   Nominal            
            ,   Valor_CompraHis    
            ,   Dif_Ant_Pacto_Pos  
            ,   Dif_Ant_Pacto_Neg  
            ,   Dif_Valor_Mercado_Pos 
            ,   Dif_Valor_Mercado_Neg 
            ,   Rev_Valor_Mercado_Pos 
            ,   Rev_Valor_Mercado_Neg 
            ,   Valor_Futuro        
            ,   Valor_Perdida_Usd     
            ,   Valor_Utilidad_Usd    
            ,   Valor_Perdida_Clp     
            ,   Valor_Utilidad_Clp    

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta
	    ,   cProductor	
            ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,	archivo_proceso
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
	    ,	cartera 	

            )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = CASE  WHEN cp.cpcodigo = 20 AND e.emrut =  @rut_entidad THEN 'LCHP'
                                                WHEN cp.cpcodigo = 20 AND e.emrut <> @rut_entidad THEN 'LCHT'
            					WHEN cp.cpcodigo = 15 AND e.emrut <> @rut_central THEN 'BONL'
              					WHEN cp.cpcodigo = 15 AND e.emrut =  @rut_central THEN 'SLSP'
                                                WHEN cp.cpcodigo = 9  OR cp.cpcodigo = 11  THEN 'DPF'
                                                ELSE (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cp.cpcodigo) 
                                          END
            ,   'tipo_plazo'            = CASE WHEN DATEDIFF(DAY, cp.cpfeccomp , cp.cpfecven ) <= 365 THEN 1 ELSE 2 END
            ,   'financiamiento'        = 'A' + (CASE WHEN cp.Codigo_CarteraSuper = 'T' THEN 'T' --TRADING
                                                               WHEN cp.Codigo_CarteraSuper = 'P' THEN 'C' --PERMANENTE
                                                               ELSE '0' 
                                                          END)  + '0'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND E.EMRUT = CLRUT )
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND E.EMRUT = CLRUT )
            ,   'banco_corresponsal'    = (CASE WHEN e.emrut = 97029000
                                                THEN 'B00'
                                                ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE rut_cliente=cp.cprutcart AND codigo_cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
                                          END)
            ,   'status_cuota'          = 'V'
            ,   'status_colocacion'     = 'V'
            ,   'reajustabilidad'       = CASE WHEN a.dimoneda = 999 THEN '0'
                                               WHEN a.dimoneda = 998 THEN '1'
                                               WHEN a.dimoneda = 997 THEN '2'
                                               ELSE '3'
                                          END
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.dimoneda)
            ,   'tipo_divisa'           = CASE WHEN a.dimoneda IN(994, 995, 997, 998, 999) THEN '0'
                                               ELSE '1'
                                          END

            --  VALORES A CONTABILIZAR

            ,   'valor_compra'          = CASE	WHEN cp.cpcodigo = 20 and e.emrut = @rut_entidad
						THEN cp.cpvalcomp + cp.cpinteresc
						ELSE cp.cpvalcomp + cp.cpreajustc
						END
            ,   'valor_presente'        = 0
            ,   'valor_venta'           = 0
            ,   'utilidad'              = 0
            ,   'perdida'               = 0
            ,   'interes_papel'         = 0
            ,   'reajuste_papel'        = 0
            ,   'interes_pacto'         = 0
            ,   'reajuste_pacto'        = 0
            ,   'valor_cupon'           = 0
            ,   'nominalpesos'          = 0
            ,   'nominal'               = 0
            ,   'valor_comprahis'       = CASE	WHEN cp.cpcodigo = 20 and e.emrut = @rut_entidad
						THEN cp.cpvalcomp + cp.cpinteresc + cp.cpreajustc 
						ELSE 0
						END
            ,   'dif_ant_pacto_pos'     = CASE	WHEN cp.cpcodigo = 20 and e.emrut = @rut_entidad
						THEN ROUND( ABS(cp.descuento) / datediff(day, cpfeccomp, cpfecven) *  datediff(day, @fecha_hoy, cpfecven) , 0)
						ELSE 0
						END
            ,   'dif_ant_pacto_neg'     = CASE	WHEN cp.cpcodigo = 20 and e.emrut = @rut_entidad
						THEN ROUND( ABS(cp.premio) / datediff(day, cpfeccomp, cpfecven) *  datediff(day, @fecha_hoy, cpfecven) , 0)
						ELSE 0
						END

            ,   'dif_valor_mercado_pos' = 0
            ,   'dif_valor_mercado_neg' = 0
            ,   'rev_valor_mercado_pos' = 0
            ,   'rev_valor_mercado_neg' = 0
            ,   'valor_futuro'          = 0
            ,   'valor_perdida_usd'     = 0
            ,   'valor_utilidad_usd'    = 0
            ,   'valor_perdida_clp'     = 0
            ,   'valor_utilidad_clp'    = 0

            --  VALORES ADICIONALES
  
            ,   'tipo_cuenta'           = 'A'
  ,   'codigo_productor'      = 'CP'
            ,   'codigo_evento'         = (CASE WHEN cp.cpcodigo = 20 AND e.emrut = @rut_entidad
                            THEN 'ALC'
                                                ELSE 'MOV'
                                           END)
            ,   'codigo_moneda1'        = a.dimoneda
            ,   'codigo_moneda2'        = a.dimoneda
            ,   'codigo_instrumento'    = cp.cpcodigo
            ,   'numero_operacion'      = cp.cpnumdocu
            ,   'numero_documento'      = cp.cpnumdocu
            ,   'correlativo'           = a.dicorrela
--            ,   'instancia_agrupacion'  = 0
            ,	'forma_pago'		= (CASE 
                                               WHEN cp.cpcodigo=20 AND e.emrut = @rut_entidad THEN 0
                                               ELSE 2
                                           END)
            ,   'rut'                   = cp.cprutcli
            ,   'codigo_operacion'      = CASE WHEN ( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.dimoneda ) = 'DO' 
                                               THEN 'USD' 
                                               ELSE ( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.dimoneda )
                                          END
            ,   'mercado'               = c.clmercado
            ,   'fecha_contable'        = @fecha_hoy
	    ,   'archivo_proceso'	= 'DEV'	
	    ,   'fecha_historica'       = @fecha_hoy
            ,   'CP'
            ,   'CP'
	    ,	'Cartera'		= '111'

         FROM	CARTERA_DISPONIBLE	a
            ,   #TMP_CARTERA_PROPIA     cp
            ,   VIEW_CLIENTE	        c

            ,   VIEW_EMISOR	        e
         WHERE 	a.dinumdocu    = cp.cpnumdocu
           AND  a.dicorrela    = cp.cpcorrela
           AND  a.ditipoper    = 'CP'           -- se excluyen en este query los anticipos de captacion
           AND  c.clrut        = cp.cprutcli
           AND  c.clcodigo     = cp.cpcodcli
           AND  e.emgeneric    = a.digenemi
           AND  cp.cpnominal   > 0 


--and cp.cpcodigo = 20
--and e.emrut = @rut_entidad
--and cpnumdocu in (38773, 38774, 38287, 38315, 38396, 38435, 38459, 38476)


--**********************************
--CARTERA PROPIA, INTERES Y REAJUSTE
--**********************************

         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR
            ,   Interes_Papel    
            ,   Reajuste_Papel   

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta
	    ,   cProductor	
            ,   Codigo_Evento      
            ,   Codigo_Moneda1 
            ,   Codigo_Moneda2        
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
   ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,   archivo_proceso
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
	    ,   cartera
            )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = CASE  WHEN cp.cpcodigo = 20 AND e.emrut =  @rut_entidad THEN 'LCHP'
                                                WHEN cp.cpcodigo = 20 AND e.emrut <> @rut_entidad THEN 'LCHT'
            					WHEN cp.cpcodigo = 15 AND e.emrut <> @rut_central THEN 'BONL'
              					WHEN cp.cpcodigo = 15 AND e.emrut =  @rut_central THEN 'SLSP'
                                                WHEN cp.cpcodigo = 9  OR cp.cpcodigo = 11  THEN 'DPF'
                                                ELSE (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cp.cpcodigo)                                                
                                          END
            ,   'tipo_plazo'            = CASE WHEN DATEDIFF(DAY, cp.cpfeccomp , cp.cpfecven ) <= 365 THEN 1 ELSE 2 END
            ,   'financiamiento'        = 'A' + (CASE WHEN cp.Codigo_CarteraSuper = 'T' THEN 'T' --TRADING
                                                               WHEN cp.Codigo_CarteraSuper = 'P' THEN 'C' --PERMANENTE
                                                               ELSE '0' 
                                                          END) + '0'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND E.EMRUT = CLRUT )
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND E.EMRUT = CLRUT )
            ,   'banco_corresponsal'    = (CASE WHEN e.emrut = 97029000
                                                THEN 'B00'
                                                ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE rut_cliente=cp.cprutcart AND codigo_cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
                                          END)
            ,   'status_cuota'          = 'V'
            ,   'status_colocacion'     = 'V'
            ,   'reajustabilidad'       = CASE WHEN a.dimoneda = 999 THEN '0'
                                               WHEN a.dimoneda = 998 THEN '1'
                                               WHEN a.dimoneda = 997 THEN '2'
                                               ELSE '3'
                                          END

            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.dimoneda)
            ,   'tipo_divisa'           = CASE WHEN a.dimoneda IN(994, 995, 997, 998, 999) THEN '0'
                                               ELSE '1'
                                          END

            --  VALORES A CONTABILIZAR
            ,   'interes_papel'         = CASE	WHEN cp.cpcodigo = 20 AND e.emrut = @rut_entidad
						THEN 0
						ELSE cp.cpinteresc
						END
            ,   'reajuste_papel'        = CASE	WHEN cp.cpcodigo = 20 AND e.emrut = @rut_entidad
						THEN cp.cpreajustc
						ELSE 0
						END

            --  VALORES ADICIONALES
  
            ,   'tipo_cuenta'           = 'A'
            ,   'codigo_productor'      = 'CP'
            ,   'codigo_evento'         = (CASE WHEN cp.cpcodigo = 20 AND e.emrut = @rut_entidad
                                                THEN 'DVP'
                                                ELSE 'DEV'
                                           END)
            ,   'codigo_moneda1'        = a.dimoneda
            ,   'codigo_moneda2'        = a.dimoneda
            ,   'codigo_instrumento'    = cp.cpcodigo
            ,   'numero_operacion'      = cp.cpnumdocu
            ,   'numero_documento'      = cp.cpnumdocu
            ,   'correlativo'           = a.dicorrela
--            ,   'instancia_agrupacion'= 0
	    ,	'forma_pago'		= 0
            ,   'rut'                   = cp.cprutcli
            ,   'codigo_operacion'      = CASE WHEN ( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.dimoneda ) = 'DO' 
                                               THEN 'USD' 
                                               ELSE ( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.dimoneda )
                                          END
            ,   'mercado'               = c.clmercado
            ,   'fecha_contable'        = @fecha_hoy
	    ,   'archivo_proceso'	= 'DEV'	
	    ,   'fecha_historica'       = @fecha_hoy
            ,   'CP'
            ,   'CP'
	    ,	'Cartera'		= '111'
         FROM	CARTERA_DISPONIBLE	a
            ,   #TMP_CARTERA_PROPIA     cp
            ,   VIEW_CLIENTE	        c

            ,   VIEW_EMISOR	        e
         WHERE 	a.dinumdocu    = cp.cpnumdocu
           AND  a.dicorrela    = cp.cpcorrela
           AND  a.ditipoper    = 'CP'           -- se excluyen en este query los anticipos de captacion
           AND  c.clrut        = cp.cprutcli
           AND  c.clcodigo     = cp.cpcodcli
           AND  e.emgeneric    = a.digenemi
           AND  cp.cpnominal   > 0 

         IF @@ERROR <> 0
         BEGIN

            PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA TABLA ##CONTABILIZA 1.'
            RETURN 1

         END

      END

      IF @producto = 'CI'
      BEGIN 

--***********************
-- COMPRA PACTO, CAPITAL
--***********************

         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR
            ,   Valor_Compra     
            ,   Valor_Presente   

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta            
   	    ,   cProductor	
	    ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,   archivo_proceso	
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
	    ,   cartera 	
            )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = 'CI'
            ,   'tipo_plazo'            = ( CASE WHEN DATEDIFF( DAY , a.cifecinip , a.cifecvenp ) <= 365 THEN 1 ELSE 2 END )
            ,   'financiamiento'        = 'A00'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.cirutcli = clrut )
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.cirutcli = clrut )
            ,   'banco_corresponsal'    = (CASE WHEN (SELECT relacion_bcch FROM VIEW_FORMA_DE_PAGO WHERE a.ciforpagi = Codigo) = 1
						THEN 'B00'
						ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=A.cirutcart AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
						END)
            ,   'status_cuota'          = 'V'
            ,   'status_colocacion'     = 'V'
            ,   'reajustabilidad'       = CASE WHEN a.cimonpact = 999 THEN '0'
                                               WHEN a.cimonpact = 998 THEN '1'
                                               WHEN a.cimonpact = 997 THEN '2'
                                               ELSE '3'
                                          END
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.cimonpact)
            ,   'tipo_divisa'           = CASE WHEN a.cimonpact IN(994, 995, 997, 998, 999) THEN '0'
                                               ELSE '1'
                                          END

            --  VALORES A CONTABILIZAR
            ,   'valor_compra'          = CASE WHEN a.cimonpact in (999,998,997,994,995)
                                                 THEN  SUM(a.civalinip)
                                                 ELSE 0
                                          END
            ,   'valor_presente'        = CASE WHEN a.cimonpact NOT in (999,998,997,994,995)
                                                 THEN  SUM(a.civalinip)
                                                 ELSE 0
                                          END


            --  VALORES ADICIONALES

            ,   'tipo_cuenta'           = 'A'
            ,   'codigo_productor'      = 'CI'
            ,   'codigo_evento'         = 'MOV'
            ,   'codigo_moneda1'        = a.cimonpact
            ,   'codigo_moneda2'        = a.cimonpact
            ,   'codigo_instrumento'    = 1
            ,   'numero_operacion'      = a.cinumdocu
            ,   'numero_documento'      = a.cinumdocu
            ,   'correlativo'           = 0
--            ,   'instancia_agrupacion'  = 0
	    ,	'forma_pago'		= 0	
            ,   'rut'                   = a.cirutcli
            ,   'codigo_operacion'      = ( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.cimonpact )
            ,   'mercado'               = c.clmercado
            ,   'fecha_contable'        = @fecha_hoy
	    ,   'archivo_proceso'	= 'DEV'	
	    ,   'fecha_historica'       = @fecha_hoy
            ,   'CI'
            ,   'CI'
	    ,	'Cartera'		= '112'

         FROM   CARTERA_COMPRA_PACTO	a
	    ,	CARTERA_DISPONIBLE	d
            ,   VIEW_CLIENTE	        c
            ,   VIEW_DATOS_GENERALES	m
         WHERE   c.clrut       =  a.cirutcli
	   AND  d.dinumdocu    =  a.cinumdocu
	   AND  d.dicorrela    =  a.cicorrela
           AND  c.clcodigo     =  a.cicodcli
           AND  a.cinominal    > 0           
           GROUP BY                 
                a.cimonpact
	    ,   a.cinumdocu
            ,   a.cimonpact   
            ,   c.cltipcli 
            ,   a.cifecinip
            ,   a.cifecvenp
            ,   a.cirutcli 
            ,   a.citipcart
            ,   c.clmercado
            ,   a.cicodcli
	    ,   a.ciforpagi
            ,   a.cirutcart


--*********************************
-- COMPRA PACTO, INTERES Y REAJUSTE
--*********************************

         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR
            ,   Interes_Papel    
            ,   Reajuste_Pacto   

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta            
   	   ,   cProductor	
	    ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
	    ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
      ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,   archivo_proceso	
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
	    ,   cartera	
            )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = 'CI'
            ,   'tipo_plazo'            = ( CASE WHEN DATEDIFF( DAY , a.cifecinip , a.cifecvenp ) <= 365 THEN 1 ELSE 2 END )
            ,   'financiamiento'        = 'A00'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.cirutcli = clrut )
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.cirutcli = clrut )
            ,   'banco_corresponsal'    = (CASE WHEN (SELECT relacion_bcch FROM VIEW_FORMA_DE_PAGO WHERE a.ciforpagi = Codigo) = 1
						THEN 'B00'
						ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=A.cirutcart AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
						END)
            ,   'status_cuota'          = 'V'
            ,   'status_colocacion'     = 'V'
            ,   'reajustabilidad'       = CASE WHEN a.cimonpact = 999 THEN '0'
                                               WHEN a.cimonpact = 998 THEN '1'
                                               WHEN a.cimonpact = 997 THEN '2'
                                               ELSE '3'
                                          END
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.cimonpact)
            ,   'tipo_divisa'           = CASE WHEN a.cimonpact IN(994, 995, 997, 998, 999) THEN '0'
                                               ELSE '1'
                                          END

            --  VALORES A CONTABILIZAR
            ,   'interes_papel'         = SUM(a.ciinteresci)
            ,   'reajuste_pacto'        = SUM(a.cireajustci)

            --  VALORES ADICIONALES

            ,   'tipo_cuenta'           = 'A'
            ,   'codigo_productor'      = 'CI'
            ,   'codigo_evento'         = 'DVI'
            ,   'codigo_moneda1'        = a.cimonpact
            ,   'codigo_moneda2'        = a.cimonpact
            ,   'codigo_instrumento'    = 0
            ,   'numero_operacion'      = a.cinumdocu
            ,   'numero_documento'      = a.cinumdocu
            ,   'correlativo'        = 0
--       ,   'instancia_agrupacion'  = 0
	    ,	'forma_pago'		= 0	
            ,   'rut'                   = a.cirutcli
            ,   'codigo_operacion'      = ( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.cimonpact )
	    ,   'mercado'               = c.clmercado
            ,   'fecha_contable'        = @fecha_hoy
	    ,   'archivo_proceso'	= 'DEV'	
	    ,   'fecha_historica'       = @fecha_hoy
            ,   'CI'
            ,   'CI'
	    ,	'Cartera'		= '112'
         FROM   CARTERA_COMPRA_PACTO	a
	    ,	CARTERA_DISPONIBLE	d
            ,   VIEW_CLIENTE	        c
            ,   VIEW_DATOS_GENERALES	m
         WHERE   c.clrut       =  a.cirutcli
	   AND  d.dinumdocu    =  a.cinumdocu
	   AND  d.dicorrela    =  a.cicorrela
           AND  c.clcodigo     =  a.cicodcli
           AND  a.cinominal    > 0  
           GROUP BY                 
                a.cimonpact
	    ,   a.cinumdocu
            ,   a.cimonpact   
            ,   c.cltipcli 
            ,   a.cifecinip
            ,   a.cifecvenp
            ,   a.cirutcli 
            ,   a.citipcart
            ,   c.clmercado
            ,   a.cicodcli
            ,   a.ciforpagi
            ,   a.cirutcart

         IF @@ERROR <> 0
         BEGIN

            PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA TABLA ##CONTABILIZA 2.'
            RETURN 1

         END


--********************************
-- COMPRA PACTO, GARANTIAS CAPITAL
--********************************

         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR
            ,   NominalPesos     

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta            
   	    ,   cProductor	
	    ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,   archivo_proceso
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
	    ,   cartera 
            )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = 'CI' 
            ,   'tipo_plazo'            = ( CASE WHEN DATEDIFF( DAY , a.cifecinip , a.cifecven ) <= 365 THEN 1 ELSE 2 END )
            ,   'financiamiento'   = 'A00'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.cirutcli = clrut AND a.cicodcli = clcodigo)
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.cirutcli = clrut AND a.cicodcli = clcodigo)
	    ,   'banco_corresponsal'    = (CASE	WHEN (SELECT relacion_bcch FROM VIEW_FORMA_DE_PAGO WHERE a.ciforpagi = Codigo) = 1
						THEN 'B00'
						ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE rut_cliente=a.cirutcart AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
						END)
            ,   'status_cuota'          = 'V'
            ,   'status_colocacion'     = 'V'
            ,   'reajustabilidad'       = CASE WHEN d.dimoneda = 999 THEN '0'
                                               WHEN d.dimoneda = 998 THEN '1'
                                               WHEN d.dimoneda = 997 THEN '2'
                                               ELSE '3'
                                          END
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = d.dimoneda)
            ,   'tipo_divisa'           = CASE WHEN d.dimoneda IN(994, 995, 997, 998, 999) THEN '0'
                                               ELSE '1'
                                          END

            --  VALORES A CONTABILIZAR
            ,   'nominalpesos'          = a.cinominalp  + a.cireajumes

            --  VALORES ADICIONALES

            ,   'tipo_cuenta'           = 'A'
            ,   'codigo_productor'      = 'CI'
            ,   'codigo_evento'         = 'MCO'
            ,   'codigo_moneda1'        = d.dimoneda
            ,   'codigo_moneda2'        = d.dimoneda
            ,   'codigo_instrumento'    = a.cicodigo
            ,   'numero_operacion'      = a.cinumdocu
            ,   'numero_documento'      = a.cinumdocu
            ,   'correlativo'           = a.cicorrela
--            ,   'instancia_agrupacion'  = 0
	    ,	'forma_pago'		= 0	
            ,   'rut'                   = a.cirutcli
            ,   'codigo_operacion'      = ( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = d.dimoneda )
            ,   'mercado'               = c.clmercado
            ,   'fecha_contable'        = @fecha_hoy
	    ,   'archivo_proceso'	= 'DEV'	
	    ,   'fecha_historica'       = @fecha_hoy
            ,   'CI'
            ,   'CI'
	    ,	'Cartera'		= '112'
         FROM   CARTERA_COMPRA_PACTO	a
	    ,	CARTERA_DISPONIBLE	d
            ,   VIEW_INSTRUMENTO	b
            ,   VIEW_CLIENTE	        c

            ,   VIEW_EMISOR	        e
            ,   VIEW_DATOS_GENERALES	m
         WHERE  c.clrut       =  a.cirutcli
	   AND  d.dinumdocu   =  a.cinumdocu
	   AND  d.dicorrela   =  a.cicorrela
           AND  c.clcodigo    =  a.cicodcli
           AND  e.emrut       =* a.cirutemi
           AND  b.incodigo    =* a.cicodigo 
           AND  a.cinominal   > 0


      END



      IF @producto = 'VI'
      BEGIN 



--******************************************************
-- INTERMEDIACION VALOR PRESENTE (CONCEPTO VTPC) se ocupar perfil de interes
--******************************************************


         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR
            ,   Interes_Papel    

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta
	    ,   cProductor
            ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,	archivo_proceso		
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
	    ,	cartera
            )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = CASE WHEN a.vitipoper = 'CI'                             THEN 'CI'
                                               WHEN a.virutcli = @rut_central                      THEN 'REPO'
                                               WHEN a.vicodigo = 20 AND a.virutemi =  @rut_entidad THEN 'LCHP'
                                               WHEN a.vicodigo = 20 AND a.virutemi <> @rut_entidad THEN 'LCHT'
					       WHEN a.vicodigo = 15 AND a.virutemi <> @rut_central THEN 'BONL'
					       WHEN a.vicodigo = 15 AND a.virutemi =  @rut_central THEN 'SLSP'
                                               WHEN a.vicodigo = 9  OR  a.vicodigo = 11            THEN 'DPF'
	                                       ELSE (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = a.vicodigo)
              				  END
            ,   'tipo_plazo'            = CASE WHEN DATEDIFF(DD, a.vifeccomp, a.vifecven) <= 365 THEN '1'
                                               WHEN DATEDIFF(DD, a.vifeccomp, a.vifecven)  > 365 THEN '2'
                                               ELSE '0'
                                          END
            ,   'financiamiento'        = 'A' + (CASE WHEN a.codigo_carterasuper = 'T' THEN 'T' --TRADING
                                                                WHEN a.codigo_carterasuper = 'P' THEN 'C' --PERMANENTE
                                                                ELSE '0' --INVESTMENT
                                                          END) + '0'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.VIRUTEMI = CLRUT )
            ,   'codigo_subsector'  = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.VIRUTEMI = CLRUT )
            ,   'banco_corresponsal'    = (CASE WHEN a.virutemi = 97029000
                                                THEN 'B00'
                                                ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE rut_cliente=a.virutcart AND codigo_cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
                                          END)

            ,   'status_cuota'          = 'V'
            ,   'status_colocacion'     = 'V'
            ,   'reajustabilidad'       = CASE WHEN a.vimonemi = 999 THEN '0'
                                               WHEN a.vimonemi = 998 THEN '1'
                                               WHEN a.vimonemi = 997 THEN '2'
                                               ELSE '3'
                                          END
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.vimonemi)
            ,   'tipo_divisa'           = CASE WHEN a.vimonemi IN(994, 995, 997, 998, 999) THEN '0'
                                               ELSE '1'
                                          END

            --  VALORES A CONTABILIZAR
            ,   'interes_papel'         = a.vivptirc

            --  VALORES ADICIONALES
  
            ,   'tipo_cuenta'           = 'A'
            ,   'codigo_productor'      = (CASE WHEN a.vitipoper = 'CI' THEN 'CI'  ELSE 'VI' END)
            ,   'codigo_evento'         = 'DEV'
            ,   'codigo_moneda1'        = a.vimonemi
            ,   'codigo_moneda2'        = a.vimonemi
            ,   'codigo_instrumento'    = a.vicodigo
            ,   'numero_operacion'      = a.vinumoper
            ,   'numero_documento'      = a.vinumdocu
            ,   'correlativo'           = a.vicorrela
--            ,   'instancia_agrupacion'  = 0
	    ,	'forma_pago'		= 0
            ,   'rut'                   = a.virutcli
            ,   'codigo_operacion'      = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.vimonemi )
            ,   'mercado'               = c.clmercado
            ,   'fecha_contable'        = @fecha_hoy
	    ,   'archivo_proceso'	= 'DEV'	
	    ,   'fecha_historica'       = @fecha_hoy
            , 'VI'
            ,   a.vitipoper
	    ,	'Cartera'		= '114'

         FROM   CARTERA_VENTA_PACTO a
            ,   VIEW_INSTRUMENTO    b
            ,   VIEW_CLIENTE	    c

            ,   VIEW_EMISOR	    e
         WHERE  c.clrut        =  a.virutcli
           AND  c.clcodigo     =  a.vicodcli
           AND  e.emrut        =* a.virutemi
           AND  b.incodigo     =* a.vicodigo 
	   AND  a.vitipoper    = 'CP'
	   AND  a.virutcli    <> @rut_central




--******************************************************
-- INTERMEDIACION COMPRA CON PACTO, GARANTIA - CAPITAL
--******************************************************


         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             

            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR
            ,   NominalPesos     

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta
	    ,   cProductor
            ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,   archivo_proceso
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
	    ,   cartera	
            )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = 'CI'
            ,   'tipo_plazo'            = ( CASE WHEN DATEDIFF( DAY , p.cifecinip , p.cifecven ) <= 365 THEN 1 ELSE 2 END )
            ,   'financiamiento'        = 'A00'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND p.cirutcli = clrut AND p.cicodcli = clcodigo)
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND p.cirutcli = clrut AND p.cicodcli = clcodigo)
            ,   'banco_corresponsal'    = (CASE	WHEN (SELECT relacion_bcch FROM VIEW_FORMA_DE_PAGO WHERE p.ciforpagi = Codigo) = 1
						THEN 'B00'
						ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE rut_cliente=a.virutcart AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
						END)
            ,   'status_cuota'          = 'V'
         ,   'status_colocacion'     = 'V'
            ,   'reajustabilidad'       = CASE WHEN a.vimonemi = 999 THEN '0'
                                               WHEN a.vimonemi = 998 THEN '1'
                                               WHEN a.vimonemi = 997 THEN '2'
                                               ELSE '3'
                                          END
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.vimonemi)
            ,   'tipo_divisa'           = CASE WHEN a.vimonemi IN(994, 995, 997, 998, 999) THEN '0'
                                    ELSE '1'
                    END

            --  VALORES A CONTABILIZAR
            ,   'nominalpesos'          = a.vinominalp + a.vireajumesv

            --  VALORES ADICIONALES
  
            ,   'tipo_cuenta'           = 'A'
            ,   'codigo_productor'      = 'CI'
            ,   'codigo_evento'         = 'MVE'
            ,   'codigo_moneda1'        = a.vimonemi
            ,   'codigo_moneda2'        = a.vimonemi
            ,   'codigo_instrumento'    = a.vicodigo
            ,   'numero_operacion'      = a.vinumoper
            ,   'numero_documento'      = a.vinumdocu
            ,   'correlativo'           = a.vicorrela
--            ,   'instancia_agrupacion'  = 0
	    ,	'forma_pago'		= 0
            ,   'rut'                   = a.virutcli
            ,   'codigo_operacion'      = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.vimonemi )
            ,   'mercado'               = c.clmercado
            ,   'fecha_contable'        = @fecha_hoy
	    ,   'archivo_proceso'	= 'DEV'	
	    ,   'fecha_historica'       = @fecha_hoy
            ,   'VI'
            ,   'CI'
	    ,	'Cartera'		= '114'

         FROM   CARTERA_VENTA_PACTO a
            ,   VIEW_INSTRUMENTO    b
            ,   VIEW_CLIENTE	    c

            ,   VIEW_EMISOR	    e
            ,   CARTERA_COMPRA_PACTO p
         WHERE  c.clrut        =  a.virutcli
           AND  c.clcodigo     =  a.vicodcli
           AND  e.emrut        =* a.virutemi
           AND  b.incodigo     =* a.vicodigo 
	   AND  a.vitipoper    = 'CI'
	   AND  p.cinumdocu    = a.vinumdocu
	   AND  p.cicorrela    = a.vicorrela


      END 


      IF @producto = 'IB'
      BEGIN 

--************************
-- INTERBANCARIOS, CAPITAL
--************************

         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
	    ,   cTipo_Divisa     

            --  VALORES A CONTABILIZAR
            ,   Valor_Compra     

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta
	    ,   cProductor
            ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,   archivo_proceso	
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
	    ,   cartera 	
            )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = a.tipo_operacion
            ,   'tipo_plazo'            = CASE	WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN   0 AND   29 THEN  3
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN  30 AND   89 THEN  4
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN  90 AND  365 THEN  5
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN 366 AND 1095 THEN  6
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) > 1095               THEN  7
                                          END
            ,   'financiamiento'        = 'A00'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.rut_cliente = CLRUT )
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.rut_cliente = CLRUT )
            ,   'banco_corresponsal'    = (CASE WHEN a.rut_cliente = @rut_central
                                                THEN 'B00'
                                                ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=a.Rut_Cartera AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
                                          END)
            ,   'status_cuota'          = 'V'
            ,   'status_colocacion'     = 'V'
  ,   'reajustabilidad'       = '0'
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.moneda_pacto)
            ,   'tipo_divisa'           = '1'

            --  VALORES A CONTABILIZAR
            ,   'valor_compra'          = CASE WHEN a.rut_cliente <> @rut_central THEN a.valor_compra + a.Reajuste_Compra ELSE a.valor_compra END

            --  VALORES ADICIONALES
            ,   'tipo_cuenta'           = 'A'
            ,   'codigo_productor'      = 'IB'
            ,   'codigo_evento'         = 'MOV'
            ,   'codigo_moneda1'        = a.moneda_pacto
            ,   'codigo_moneda2'        = a.moneda_pacto
            ,   'codigo_instrumento'    = a.codigo
            ,   'numero_operacion'      = a.numero_operacion
            ,   'numero_documento'      = a.numero_documento
            ,   'correlativo'           = a.correlativo_operacion
--            ,   'instancia_agrupacion'  = 0
	    ,	'forma_pago'		= 0
            ,   'rut'                   = a.rut_cliente
            ,   'codigo_operacion'      = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.moneda_pacto)
            ,   'mercado'               = c.clmercado
            ,   'fecha_contable'        = @fecha_hoy
	    ,   'archivo_proceso'	= 'DEV'	
	    ,   'fecha_historica'       = @fecha_hoy
            ,   'IB'
            ,   'IB'
	    ,	'Cartera'		= '121'
         FROM   CARTERA_INTERBANCARIA a
            ,   VIEW_INSTRUMENTO      b
            ,   VIEW_CLIENTE	      c
         WHERE  c.clrut        =  a.rut_cliente
           AND  c.clcodigo     =  a.codigo_cliente
           AND  b.incodigo     =  a.codigo
           AND  a.codigo IN (995)
	   AND  a.codigo_subproducto = 'IB'
-- select * from cartera_interbancaria


--***********************************
-- INTERBANCARIOS, INTERES
--***********************************

         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR
            ,   Interes_Papel    

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta
	    ,   cProductor
            ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,   archivo_proceso
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
	    ,   cartera 	
            )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = a.tipo_operacion
            ,   'tipo_plazo'            = CASE	WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN   0 AND   29 THEN  3
			          		WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN  30 AND   89 THEN  4
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN  90 AND  365 THEN  5
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN 366 AND 1095 THEN  6
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) > 1095               THEN  7
                                    END
            ,   'financiamiento'        = 'A00'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.rut_cliente = CLRUT )
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.rut_cliente = CLRUT )
            ,   'banco_corresponsal'    = (CASE WHEN a.rut_cliente = @rut_central
                                                THEN 'B00'
                                                ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=a.Rut_Cartera AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
                                          END)
            ,   'status_cuota'          = 'V'
            ,   'status_colocacion'     = 'V'
            ,   'reajustabilidad'       = '0'
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.moneda_pacto)
            ,   'tipo_divisa'           = '1'

            --  VALORES A CONTABILIZAR
            ,   'interes_papel'         = a.Interes_Compra

            --  VALORES ADICIONALES
            ,   'tipo_cuenta'           = 'A'
            ,   'codigo_productor'      = (CASE	WHEN a.serie = 'ICAPX' THEN 'ICAP' 
						WHEN a.serie = 'ICOLX' THEN 'ICOL' 
						ELSE a.serie
					   	END ) 
            ,   'codigo_evento'         = 'DEV'
            ,   'codigo_moneda1'        = a.moneda_pacto
       ,   'codigo_moneda2'        = a.moneda_pacto
            ,   'codigo_instrumento'    = a.codigo
            ,   'numero_operacion'      = a.numero_operacion
            ,   'numero_documento'      = a.numero_documento
            ,   'correlativo'           = a.correlativo_operacion
--            ,   'instancia_agrupacion'  = 0
	    ,	'forma_pago'		= 0
            ,   'rut'                   = a.rut_cliente
            ,   'codigo_operacion'      = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.moneda_pacto)
            ,   'mercado'               = c.clmercado
            ,   'fecha_contable'        = @fecha_hoy
	    ,   'archivo_proceso'	= 'DEV'	
	    ,   'fecha_historica'       = @fecha_hoy
            ,   'IB'
            ,   'IB'
	    ,	'Cartera'		= '121'
         FROM   CARTERA_INTERBANCARIA a
     ,   VIEW_INSTRUMENTO      b
            ,   VIEW_CLIENTE	      c
         WHERE  c.clrut        =  a.rut_cliente
           AND  c.clcodigo     =  a.codigo_cliente
           AND  b.incodigo     =  a.codigo
           AND  a.codigo IN (995)
	   AND  a.codigo_subproducto = 'IB'

         IF @@ERROR <> 0
         BEGIN

            PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA 3.'
            RETURN 1

         END

      END 



      IF @producto = 'CFM' 
      BEGIN

--******************
-- CUOTA FONDO MUTUO 
--******************

       INSERT INTO ##CONTABILIZA (
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
           --Valores a contabilizar
           ,valor_compra     
	   --Valores Adicionales
           ,tipo_cuenta
           ,cProductor                  
           ,codigo_evento              
           ,codigo_moneda1             
           ,codigo_moneda2             
           ,codigo_instrumento         
           ,numero_operacion           
           ,numero_documento           
           ,correlativo                
--           ,nInstancia_Agrupacion
           ,forma_pago	
           ,rut
           ,codigo_operacion
           ,mercado
           ,fecha_contable
	   ,fecha_historica
           ,tipoper
           ,tipoperO
           )
       SELECT
            'BTR'			
           ,'CMF'    
           ,( CASE WHEN DATEDIFF( DAY , @FECHA_HOY , A.cpfecven ) <= 365 THEN 1 ELSE 2 END )
           ,'A00'
           ,( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad AND A.CPRUTCLI = CLRUT AND A.CPCODCLI = Clcodigo )
           ,( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad AND A.CPRUTCLI = CLRUT AND A.CPCODCLI = Clcodigo )
           ,ISNULL((SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=A.CPRUTCART AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S'),'')
           ,'V'
           ,'V'
           ,'0'
           ,'CLP'
           ,'0'
    --Valores a contabilizar
           ,'valor_compra'              =   a.cpvalcomp
-- select cpvptirc, CPCAPITALC, * from cartera_propia
-- select * from resultado_devengo
    --Datos -------
            ,'A'
            ,'CFM'
            ,'MCO'
    	    ,f.codigo_moneda
    	    ,f.codigo_moneda
            ,a.cpcodigo
            ,a.cpnumdocu
            ,a.cpnumdocu
            ,a.cpcorrela
            ,0
            ,a.cprutcli
            ,(SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = f.codigo_moneda)
            ,c.clmercado
            ,'fecha_conatble'        = @fecha_hoy
            ,@fecha_hoy
            ,'CFM'
            ,'CFM'
-- select * from CARTERA_PROPIA
       FROM	CARTERA_PROPIA		a,
        	VIEW_INSTRUMENTO	b,
        	VIEW_CLIENTE	        c,
        	VIEW_DATOS_GENERALES	m,
                VIEW_PRODUCTO           p,
                VIEW_CALIDAD_JURIDICA   j,
		VIEW_FMUTUO_SERIE	F
       WHERE 	(c.clrut              = a.cprutcli
           AND	c.clcodigo            = a.cpcodcli)
           AND	b.incodigo            = a.cpcodigo
           AND  Codigo_Subproducto    = @producto
           AND  p.codigo_producto     = a.Codigo_Subproducto
           AND  a.Codigo_Subproducto    = 'CFM'
           AND  c.Clcalidadjuridica   = j.Codigo_Calidad
	   AND  f.serie 	      = cpinstser
	   AND	cpnominal	      > 0



         IF @@ERROR <> 0
         BEGIN

            PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA 3.'
            RETURN 1

         END




       INSERT INTO ##CONTABILIZA (
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
           --Valores a contabilizar
           ,Interes_Papel
	   --Valores Adicionales
           ,tipo_cuenta
           ,cProductor                  
           ,codigo_evento              
           ,codigo_moneda1             
           ,codigo_moneda2             
           ,codigo_instrumento         
           ,numero_operacion           
           ,numero_documento           
           ,correlativo                
--           ,nInstancia_Agrupacion
           ,forma_pago	
           ,rut
           ,codigo_operacion
           ,mercado
           ,fecha_contable
	   ,fecha_historica
           ,tipoper
           ,tipoperO
           )
       SELECT
            'BTR'			
           ,'CMF'    
           ,( CASE WHEN DATEDIFF( DAY , @FECHA_HOY , A.cpfecven ) <= 365 THEN 1 ELSE 2 END )
           ,'A00'
           ,( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad AND A.CPRUTCLI = CLRUT AND A.CPCODCLI = Clcodigo )
           ,( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad AND A.CPRUTCLI = CLRUT AND A.CPCODCLI = Clcodigo )
           ,ISNULL((SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=A.CPRUTCART AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S'),'')
           ,'V'
           ,'V'
           ,'0'
           ,'CLP'
           ,'0'
    --Valores a contabilizar
           ,'Interes_Papel'              =   a.cpinteresc
-- select cpvptirc, CPCAPITALC, * from cartera_propia
-- select * from resultado_devengo
    --Datos -------
            ,'A'
            ,'CFM'
            ,'DEV'
    	    ,f.codigo_moneda
    	    ,f.codigo_moneda
            ,a.cpcodigo
            ,a.cpnumdocu
            ,a.cpnumdocu
            ,a.cpcorrela
            ,0
            ,a.cprutcli
            ,(SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = f.codigo_moneda)
            ,c.clmercado
            ,'fecha_conatble'        = @fecha_hoy
            ,@fecha_hoy
            ,'CFM'
            ,'CFM'
-- select * from CARTERA_PROPIA
       FROM	CARTERA_PROPIA		a,
        	VIEW_INSTRUMENTO	b,
        	VIEW_CLIENTE	        c,
        	VIEW_DATOS_GENERALES	m,
                VIEW_PRODUCTO           p,
                VIEW_CALIDAD_JURIDICA   j,
		VIEW_FMUTUO_SERIE	F
       WHERE 	(c.clrut              = a.cprutcli
           AND	c.clcodigo            = a.cpcodcli)
           AND	b.incodigo            = a.cpcodigo
           AND  Codigo_Subproducto    = @producto
           AND  p.codigo_producto     = a.Codigo_Subproducto
           AND  a.Codigo_Subproducto    = 'CFM'
           AND  c.Clcalidadjuridica   = j.Codigo_Calidad
	   AND  f.serie 	      = cpinstser
	   AND	cpnominal	      > 0



         IF @@ERROR <> 0
         BEGIN

            PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA 3.'
            RETURN 1

         END



      END




      IF @producto = 'LBC' 
      BEGIN

--************************
-- LINEA BANCO CENTRAL CLP
--************************
            
         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

       --  VALORES A CONTABILIZAR
            ,   Valor_Compra     

            --  VALORES ADICIONALES

  ,   Tipo_Cuenta
	    ,   cProductor
            ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
        )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = a.tipo_operacion
            ,   'tipo_plazo'            = CASE	WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN   0 AND   29 THEN  3
			          		WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN  30 AND   89 THEN  4
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN  90 AND  365 THEN  5
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN 366 AND 1095 THEN  6
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) > 1095               THEN  7
                                          END
            ,   'financiamiento'        = 'P00'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.rut_cliente = CLRUT )
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.rut_cliente = CLRUT )
            ,   'banco_corresponsal'    = (CASE WHEN a.rut_cliente = 97029000
                                                THEN 'B00'
                                                ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=a.Rut_Cartera AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
                                          END)
            ,   'status_cuota'          = '0'
            ,   'status_colocacion'     = '0'
            ,   'reajustabilidad'       = '0'
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.moneda_pacto)
            ,   'tipo_divisa'           = '1'

            --  VALORES A CONTABILIZAR
            ,   'valor_compra'          = a.valor_compra

            --  VALORES ADICIONALES
            ,   'tipo_cuenta'           = 'P'
            ,   'codigo_productor'      = 'LBC'
            ,   'codigo_evento'         = 'MOV'
            ,   'codigo_moneda1'        = a.moneda_pacto
            ,   'codigo_moneda2'        = a.moneda_pacto
            ,   'codigo_instrumento'    = a.codigo
            ,   'numero_operacion'      = a.numero_operacion
            ,   'numero_documento'     = a.numero_documento
            ,   'correlativo'           = a.correlativo_operacion
--            , 'instancia_agrupacion'  = 0
	    ,	'forma_pago'		= 0
        ,   'rut'                   = a.rut_cliente
            ,   'codigo_operacion'      = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.moneda_pacto)
            ,   'mercado'               = c.clmercado
            ,   'fecha_conatble'        = @fecha_hoy
	    ,   @fecha_hoy
            ,   'LBC'
            ,   'LBC'
         FROM   CARTERA_INTERBANCARIA a
            ,   VIEW_INSTRUMENTO      b
            ,   VIEW_CLIENTE	      c
         WHERE  c.clrut          =  a.rut_cliente
           AND  c.clcodigo       =  a.codigo_cliente
           AND  b.incodigo       =  a.codigo
           AND  a.tipo_operacion =  'LBC'  --(solo linea credito BCCH)

         IF @@ERROR <> 0
         BEGIN

            PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA 3.'
            RETURN 1

         END


--***********************************
-- LINEA BANCO CENTRAL CLP, INTERES
--***********************************

         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
  ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR
            ,   Interes_Papel    

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta
	    ,   cProductor
            ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,	fecha_historica
            ,   tipoper
            ,   tipoperO
  )
         SELECT 'id_sistema'            = 'BTR'
            ,   'codigo_producto'       = a.tipo_operacion
            ,   'tipo_plazo'            = CASE	WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN   0 AND   29 THEN  3
			          		WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN  30 AND   89 THEN  4
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN  90 AND  365 THEN  5
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) BETWEEN 366 AND 1095 THEN  6
			                        WHEN DATEDIFF( DAY , a.fecha_inicio_pacto , a.fecha_vencimiento_pacto ) > 1095               THEN  7
                                          END
            ,   'financiamiento'        = 'P00'
            ,   'codigo_sector'         = ( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.rut_cliente = CLRUT )
            ,   'codigo_subsector'      = ( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND a.rut_cliente = CLRUT )
            ,   'banco_corresponsal'    = (CASE WHEN a.rut_cliente = @rut_central
                                                THEN 'B00'
                                                ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=a.Rut_Cartera AND Codigo_Cliente=1 AND @Plaza=Codigo_Plaza AND defecto='S') , '')
                                          END)
            ,   'status_cuota'          = '0'
            ,   'status_colocacion'     = '0'
            ,   'reajustabilidad'       = '0'
            ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.moneda_pacto)
            ,   'tipo_divisa'           = '1'

            --  VALORES A CONTABILIZAR
            ,   'interes_papel'         = a.Interes_Compra

            --  VALORES ADICIONALES
            ,   'tipo_cuenta'           = 'A'
            ,   'codigo_productor'      = 'LBC'
            ,   'codigo_evento'         = 'DEV'
            ,   'codigo_moneda1'        = a.moneda_pacto
            ,   'codigo_moneda2'        = a.moneda_pacto
            ,   'codigo_instrumento'    = a.codigo
            ,   'numero_operacion'      = a.numero_operacion
            ,   'numero_documento'      = a.numero_documento
            ,   'correlativo'           = a.correlativo_operacion
--            ,   'instancia_agrupacion'  = 0
	    ,	'forma_pago'		= 0
            ,   'rut'                   = a.rut_cliente
            ,   'codigo_operacion'      = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = a.moneda_pacto)
    ,   'mercado'               = c.clmercado
            ,  'fecha_conatble'        = @fecha_hoy
	    ,   @fecha_hoy
            ,   'LBC'
            ,   'LBC'
         FROM   CARTERA_INTERBANCARIA a
            ,   VIEW_INSTRUMENTO      b
            ,   VIEW_CLIENTE	      c
         WHERE  c.clrut        =  a.rut_cliente
           AND  c.clcodigo     =  a.codigo_cliente
           AND  b.incodigo     =  a.codigo
           AND  a.tipo_operacion =  'LBC'  --(solo linea credito BCCH)

      END 





      IF @id_sistema = 'BTR' AND @producto = 'MM'
      BEGIN


--*********************
-- VALORIAZCION MERCADO
--*********************

    -- Contabilizacion al día de proceso.
       SELECT  @plaza           = ( SELECT Codigo_Plaza    FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad=1 )
       SELECT  @pais            = ( SELECT Codigo_Pais     FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad=1 )
       SELECT  @FECHAPROX       = ( SELECT Fecha_Proxima   FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad=1 )

       CREATE TABLE #FECHA2( FECHA DATETIME , ESPECIAL CHAR(01) )
       INSERT INTO #FECHA2 EXEC SP_CON_FECHA_FERIADO @PAIS , @PLAZA , @fecha_hoy , 1 , 0
       SELECT TOP 1 @fecha_Cierre = FECHA FROM #FECHA2

       IF @fecha_Cierre > @fecha_hoy AND @fecha_Cierre < @FECHAPROX
           SELECT @fecha_aux = @fecha_Cierre
       ELSE
           SELECT @fecha_aux = @fecha_hoy



	SELECT	*
	INTO	#TMP_VALORIZACION_MERCADO
		FROM	VALORIZACION_MERCADO
	WHERE	fecha_valorizacion = @fecha_aux


	UPDATE	#TMP_VALORIZACION_MERCADO
	SET	tipo_operacion   = 'CP',
		numero_operacion = numero_documento
	FROM	CARTERA_VENTA_PACTO
	WHERE	#TMP_VALORIZACION_MERCADO.tipo_operacion  = 'VI'
	AND	virutcli	= @rut_central
	AND	vinumoper	= numero_operacion
	AND	vinumdocu	= numero_documento
	AND	vicorrela	= correlativo


         INSERT INTO ##CONTABILIZA
            (   Id_Sistema
            ,   cProducto                  
            ,   cTipo_Plazo                
            ,   cFinanciamiento            
            ,   cCodigo_Sector             
            ,   cCodigo_Subsector          
            ,   cBanco_Corresponsal        
            ,   cStatus_Cuota              
            ,   cStatus_Colocacion         
            ,   cReajustabilidad           
            ,   cDivisa                    
            ,   cTipo_Divisa               

            --  VALORES A CONTABILIZAR
            ,   Dif_Ant_Pacto_Pos  
            ,   Dif_Ant_Pacto_Neg  
            ,   Dif_Valor_Mercado_Pos 
            ,   Dif_Valor_Mercado_Neg 
            ,   Rev_Valor_Mercado_Pos 
            ,   Rev_Valor_Mercado_Neg 
            ,   Valor_Futuro        
            ,   Valor_Perdida_Usd     
            ,   Valor_Utilidad_Usd    
            ,   Valor_Perdida_Clp     
            ,   Valor_Utilidad_Clp    

            --  VALORES ADICIONALES

            ,   Tipo_Cuenta
	    ,   cProductor	
            ,   Codigo_Evento              
            ,   Codigo_Moneda1             
            ,   Codigo_Moneda2             
            ,   Codigo_Instrumento         
            ,   Numero_Operacion           
            ,   Numero_Documento           
            ,   Correlativo
--            ,   nInstancia_Agrupacion
	    ,	Forma_pago	
            ,   rut
            ,   codigo_operacion
            ,   mercado
            ,   fecha_contable
	    ,   archivo_proceso	
	    ,	fecha_historica
   ,   tipoper
            ,   tipoperO
	    ,   cartera 	  	
      )

       SELECT
    	 a.id_sistema
            ,'codigo_producto'           =  (CASE WHEN A.instrumento=20 AND A.rut_emisor= @rut_entidad THEN 'LCHP'
                        	                  WHEN A.instrumento=20 AND A.rut_emisor<>@rut_entidad THEN 'LCHT'
                            	                  WHEN A.instrumento=15 AND A.rut_emisor<>@rut_central THEN 'BONL'
                                    	          WHEN A.instrumento=15 AND A.rut_emisor= @rut_central THEN 'SLSP'
WHEN A.instrumento=9 OR   A.instrumento=11 THEN 'DPF'
                                                  ELSE  ( SELECT INSERIE FROM VIEW_INSTRUMENTO WHERE INCODIGO = A.instrumento )
    	                                 END)
            ,( CASE WHEN DATEDIFF( DAY , @FECHA_HOY , A.fecha_vencimiento) <= 365 THEN 1 ELSE 2 END )
            ,'A' +   (CASE
                              WHEN A.Codigo_CarteraSuper = 'T' THEN 'T' --TRADING                     
                                     WHEN A.Codigo_CarteraSuper = 'P' THEN 'C' --PERMANENTE
                                     ELSE                                  '0' --INVEST
                               END) +'0'
            ,(SELECT TOP 1 LEFT ( ISNULL(Codigo_Calidad_Contable,'J00') ,1) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = a.rut_emisor AND CA.Codigo_Calidad = CL.Clcalidadjuridica )                
            ,(SELECT TOP 1 RIGHT( ISNULL(Codigo_Calidad_Contable,'J00') ,2) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = a.rut_emisor AND CA.Codigo_Calidad = CL.Clcalidadjuridica ) 
            ,'     '
            ,'V'
            ,'V'
            ,CASE 
                 WHEN A.moneda_emision = 999 THEN '0'
                 WHEN A.moneda_emision = 998 THEN '1'
                 WHEN A.moneda_emision = 997 THEN '2'
                 ELSE '3'         
             END
           , (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.moneda_emision ) 
           , CASE 
                 WHEN A.moneda_emision = 999 THEN '0' 
                 WHEN A.moneda_emision = 998 THEN '0' 
                 WHEN A.moneda_emision = 997 THEN '0' 
                 WHEN A.moneda_emision = 995 THEN '0' 
                 WHEN A.moneda_emision = 994 THEN '0' 
                 ELSE '1'           
             END
    
    --Valores a contabilizar
    

           ,'dif_ant_pacto_pos'         =   0
           ,'dif_ant_pacto_neg'         =   0

--         ,'dif_valor_mercado_pos'     =   SUm( (CASE WHEN diferencia_mercado >= 0 THEN diferencia_mercado      ELSE 0 END)  * (-1) )
--         ,'dif_valor_mercado_neg'     =   SUM( (CASE WHEN diferencia_mercado <  0 THEN ABS(diferencia_mercado) ELSE 0 END) ) 

           ,'dif_valor_mercado_pos'     =  SUM( (CASE WHEN diferencia_mercado >= 0 THEN CASE WHEN mnextranj = '0' THEN ROUND(diferencia_mercado * @valor_observado,0) ELSE diferencia_mercado END ELSE 0 END) * (-1))
           ,'dif_valor_mercado_neg'     =  SUM( (CASE WHEN diferencia_mercado <  0 THEN ABS(CASE WHEN mnextranj = '0' THEN ROUND(diferencia_mercado * @valor_observado,0) ELSE diferencia_mercado END ) ELSE 0 END) )
           ,'rev_valor_mercado_pos'     =  SUM( (CASE WHEN diferencia_mercado >= 0 THEN diferencia_mercado      ELSE 0 END) * (-1) )
           ,'rev_valor_mercado_neg'     =  SUM( (CASE WHEN diferencia_mercado <  0 THEN ABS(diferencia_mercado) ELSE 0 END) )
           ,'valor_futuro'              =  CONVERT(NUMERIC(19),0.0)
           ,'Valor_perdida_usd'         =  SUM(CASE WHEN diferencia_mercado <  0 THEN ABS(diferencia_mercado) ELSE 0 END       ) / CASE WHEN mnextranj = '0' or a.moneda_emision = 999 THEN 1 ELSE (SELECT ISNULL(vmvalor,1) from VIEW_VALOR_MONEDA WHERE vmcodigo = a.moneda_emision AND vmfecha = @fecha_aux ) END
           ,'Valor_utilidad_usd'        =  SUM(CASE WHEN diferencia_mercado >= 0 THEN diferencia_mercado      ELSE 0 END * (-1)) / CASE WHEN mnextranj = '0' or a.moneda_emision = 999 THEN 1 ELSE (SELECT ISNULL(vmvalor,1) from VIEW_VALOR_MONEDA WHERE vmcodigo = a.moneda_emision AND vmfecha = @fecha_aux ) END
           ,'Valor_perdida_clp'         =  SUM(CASE WHEN diferencia_mercado <  0 THEN ABS(diferencia_mercado) ELSE 0 END       ) / CASE WHEN mnextranj = '0' or a.moneda_emision = 999 THEN 1 ELSE ISNULL((SELECT vmvalor from VIEW_VALOR_MONEDA WHERE vmcodigo = a.moneda_emision AND vmfecha = @fecha_aux ),1) END
           ,'Valor_utilidad_clp'        =  SUM(CASE WHEN diferencia_mercado >= 0 THEN diferencia_mercado      ELSE 0 END * (-1)) / CASE WHEN mnextranj = '0' or a.moneda_emision = 999 THEN 1 ELSE ISNULL((SELECT vmvalor from VIEW_VALOR_MONEDA WHERE vmcodigo = a.moneda_emision AND vmfecha = @fecha_aux ),1) END

        --Valores Adicionales
           ,'A'    
           , a.tipo_operacion
	   ,'codigo_evento'             =   CASE WHEN SUM( diferencia_mercado ) >= 0 AND a.instrumento NOT IN (38,39) THEN 'TMU'
					         WHEN SUM( diferencia_mercado ) <  0 AND a.instrumento NOT IN (38,39) THEN 'TMP'
					         WHEN SUM( diferencia_mercado ) >= 0 AND a.instrumento IN (38,39)     THEN 'TXU'
                                                 ELSE 'TXP'
                                             END
           ,'codigo_moneda1'            =   a.moneda_emision
           ,'codigo_moneda2'            =   a.moneda_emision
           ,'codigo_instrumento'        =   a.instrumento
           ,'numero_operacion'          =   a.numero_operacion
           ,'numero_documento'          =   a.numero_documento
           ,'correlativo'               =   a.correlativo
--           ,'instancia_agrupacion'      =   0
           ,'forma_pago'		=   0 
           ,'rut'                       =   a.rut_emisor
           ,'codigo_operacion'          =   CASE WHEN a.moneda_emision = 13 THEN 'USD'
                                           	     ELSE ( SELECT TOP 1 LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.moneda_emision )
                                            END
           ,'mercado'    =   c.clmercado
           ,'fecha_contable'        = @fecha_hoy
	   ,'archivo_proceso'	    = 'VAL'	
	   ,'fecha_historica'       = @fecha_hoy
           ,a.tipo_operacion
           ,'CP'
           ,'cartera'			    =  	(CASE WHEN a.tipo_operacion = 'CP' THEN '111' ELSE '114' END)
    
       FROM	
    	   #TMP_VALORIZACION_MERCADO   a,
    	   VIEW_INSTRUMENTO	       b,
    	   VIEW_CLIENTE	               c,
    	   VIEW_EMISOR	               e,
           VIEW_PRODUCTO               p,
           VIEW_MONEDA
       WHERE   c.clrut           	= a.rut_emisor 
         AND   e.emrut           	= a.rut_emisor
         AND   b.incodigo        	= a.instrumento
         AND   a.fecha_valorizacion     = @fecha_aux
         AND   p.codigo_producto 	= a.tipo_operacion
         AND   a.codigo_area            = (SELECT ISNULL(codigo_area,'MNAC') FROM VIEW_AREA_PRODUCTO WHERE contabilidad_btr=1)   
         AND   a.id_sistema             = 'BTR'
         AND   NOT (b.incodigo          = 20 AND a.rut_emisor = a.rut_cartera)
         AND   mncodmon			= a.moneda_emision
   GROUP BY
	a.id_sistema,
	A.instrumento,
	A.rut_emisor,
	A.fecha_vencimiento,
	A.Codigo_CarteraSuper,
	A.moneda_emision,
	a.tipo_operacion,
	a.numero_operacion,
	a.numero_documento,
	a.correlativo,
	c.clmercado,
        a.fecha_valorizacion,
	mnextranj


         IF @@ERROR <> 0
         BEGIN
            PRINT 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA 3.'
            RETURN 1
         END



      END

   END

END

GO
