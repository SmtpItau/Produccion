USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Llena_Contabiliza_BTR]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Llena_Contabiliza_BTR]
            ( @fecha_hoy       DATETIME
            , @fecha_Anterior  DATETIME
            , @fecha_Cierre    DATETIME
            , @producto        VARCHAR(5)
            , @error           VARCHAR(512) OUTPUT )
AS
BEGIN

	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE @control_error    integer
	DECLARE @valor_observado  float   
	DECLARE @valor_uf         float   
	DECLARE @valor_ivp        float   
	DECLARE @rut_central      numeric(10)
	DECLARE @habil            char(1)
	DECLARE @fecha_paso       datetime
	DECLARE @vvista           char(4)
	DECLARE @plaza            numeric(5)
	DECLARE @pais             numeric(5)
	DECLARE @rut_entidad      numeric(9)
	DECLARE @Codigo_Entidad   numeric(9)

	DECLARE @FECHA1           DATETIME
	DECLARE @FECHA2           DATETIME
	DECLARE @fecha_aux        DATETIME
	DECLARE @nRut_BCCH        NUMERIC(9)

	SELECT  @rut_central     = 97029000
	SELECT  @valor_observado = 1.0
	SELECT  @valor_observado = isnull(vmvalor,0.0) from VIEW_VALOR_MONEDA  where vmcodigo = 994 and vmfecha = @fecha_hoy
	SELECT  @valor_uf        = isnull(vmvalor,0.0) from VIEW_VALOR_MONEDA  where vmcodigo = 998 and vmfecha = @fecha_hoy
	SELECT  @valor_ivp       = isnull(vmvalor,0.0) from VIEW_VALOR_MONEDA  where vmcodigo = 997 and vmfecha = @fecha_hoy
	SELECT  @plaza           = ( SELECT Codigo_Plaza    FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad=1 )
	SELECT  @pais            = ( SELECT Codigo_Pais     FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad=1 )
	SELECT  @rut_entidad     = ( SELECT rut_entidad     FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad=1 )
	SELECT  @Codigo_Entidad  = ( SELECT codigo_entidad  FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad=1 )
	SELECT  @nRut_BCCH       = ( SELECT Rut_Bcch        FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad=1 )

/* ======================================================================================== */
/* Busca Fecha a Contabilizar para Tasa Mercado                                             */
/* ======================================================================================== */

	DECLARE @Periodo        CHAR(1) 
	      , @FechaAnt       DATETIME
	      , @FechaProx      DATETIME
	      , @FechaProc      DATETIME
	      , @lflag          INTEGER
	      , @Habiles        CHAR(1)      

-- Ver el caso de fin de mes no habil para las fechas de proceso y anterior.

	SELECT @Periodo       = 'M'         --- Indica el Perio en que Buscara Fecha
	,	@Habiles       = 'N'         --- Indica si las Fechas Anteriores seran dias Habiles
	,	@FechaProc     = @fecha_hoy

	SELECT	@FECHA1 = fecha_proceso
	,	@FECHA2 = fecha_proxima
	FROM	VIEW_DATOS_GENERALES

	CREATE TABLE #FECHA( FECHA DATETIME )
	INSERT INTO #FECHA EXEC SP_CON_FECHA_FERIADO @PAIS , @PLAZA , @fecha_hoy , 2 
	SELECT TOP 1 @FechaProx = FECHA FROM #FECHA
   
	IF MONTH(@FECHA1) <> MONTH(@FECHA2) AND DATEDIFF( DAY , @FECHA2 , @FECHA1 ) > 1 BEGIN              
		CREATE TABLE #FECHA1( FECHA DATETIME , ESPECIAL CHAR(01) )
		INSERT INTO #FECHA1 EXEC SP_CON_FECHA_FERIADO @PAIS , @PLAZA , @fecha_hoy , 1
		SELECT TOP 1 @FechaProx = FECHA FROM #FECHA1
	END

	IF @producto IN ('FLP','VFL','RP','VRP','FPD','VPD')
	BEGIN
		RETURN
	END
/* ========================r================================================================ */
/* busca si el sistema esta en una fecha no habil (fin de mes feriado)                      */
/* ======================================================================================== */

	SELECT @fecha_paso = @fecha_hoy

	EXECUTE Sp_Diahabil @fecha_paso OUTPUT

	IF DATEDIFF(DAY, @fecha_hoy, @fecha_paso) <> 0
		SELECT @habil = 'N'
	ELSE
		SELECT @habil = 'S'




   IF @producto IN ( 'CI' , 'CIX', 'RV' , 'RVA' ) BEGIN
   ---------------------------------------------------------------------------
   -- INFORMA LA COMPRA CON PACTO
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
           ,forma_pago	
           ,rut
           ,codigo_operacion
           ,mercado
           ,fecha_contable
	   ,archivo_proceso
	   ,fecha_historica
	   ,tipoper
	   ,tipoperO
	   ,cartera
           )
       SELECT 
           'BTR'
           ,'CI' --a.motipoper
           ,( CASE WHEN DATEDIFF( DAY , A.MOFECINIP , A.MOFECVENP ) <= 365 THEN 1 ELSE 2 END )
           ,'A00' 
           ,( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTCLI = CLRUT )
           ,( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTCLI = CLRUT )
           ,(CASE WHEN (SELECT relacion_bcch FROM VIEW_FORMA_DE_PAGO WHERE a.moforpagi = Codigo) = 1
                  THEN 'B00'
                  --ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=A.MORUTCLI AND Codigo_Cliente=A.MOCODCLI AND @Plaza=Codigo_Plaza AND defecto='S') , '')
                  --SE REALIZA ESTA CAMBIO EL 11/09/2003 (BUSCA EL CORRESPONSAL POR DEFECTO)
                  ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=@rut_entidad AND Codigo_Cliente=@Codigo_Entidad AND A.MOMONPACT=Codigo_mONEDA AND defecto='S') , '')
            END)
           ,'V'
           ,'V'    
           ,(CASE 
                WHEN A.MOMONPACT=999    THEN '0'
                WHEN A.MOMONPACT=998    THEN '1'
                WHEN A.MOMONPACT=997    THEN '2'
                ELSE '3'
            END)
           ,( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.MOMONPACT )
           ,(CASE
                WHEN A.MOmonpact = 999 THEN '0' 
                WHEN A.MOmonpact = 998 THEN '0' 
                WHEN A.MOmonpact = 997 THEN '0' 
                WHEN A.MOmonpact = 995 THEN '0' 
                WHEN A.MOmonpact = 994 THEN '0' 
                ELSE '1' 
            END)

    --Valores a contabilizar
           ,'valor_compra'              =   CASE WHEN a.momonpact in (999,998,997,994,995)
                                                 THEN  (CASE WHEN a.motipoper IN ('CI')       THEN   SUM(A.movalcomp )
							     WHEN a.motipoper IN ('CIX')      THEN   SUM(A.movalinip )
                                                             WHEN a.motipoper = 'RVA'         THEN   SUM(A.movalinip )
                                                             WHEN a.motipoper = 'RV'          THEN   SUM(A.mocapitalp)
                                                        END)  
              ELSE 0
                              END
           ,'valor_presente'           =    CASE WHEN a.momonpact NOT IN (999,998,997,994,995)
                                                 THEN (CASE WHEN a.motipoper IN ('CI')       THEN   CONVERT(NUMERIC(19,4),SUM(A.movalcomp ))
							    WHEN a.motipoper IN ('CIX')      THEN   CONVERT(NUMERIC(19,4),SUM(A.movalinip ))
                                                            WHEN a.motipoper = 'RVA'         THEN   CONVERT(NUMERIC(19,4),SUM(A.movalinip ))
                                                            WHEN a.motipoper = 'RV'          THEN   CONVERT(NUMERIC(19,4),SUM(A.mocapitalp))
                                                       END)
                                                 ELSE CONVERT(NUMERIC(19,4),0)
                                            END
           ,'valor_venta'               =   0
           ,'utilidad'                  =   (CASE WHEN a.motipoper = 'RVA'
                                                  THEN SUM(A.moutilidad)
                                                  ELSE 0
                                             END)
           ,'perdida'                   =   (CASE WHEN a.motipoper = 'RVA'
                                                  THEN SUM(A.moperdida)
                                                  ELSE 0
                                             END)
           ,'interes_papel'             =   CASE WHEN a.momonpact NOT in (999,998,997,994,995)
                                                 THEN (CASE WHEN a.motipoper = 'RVA'  THEN   SUM(A.mointpac)  
                                                            WHEN a.motipoper = 'RV'   THEN   SUM(A.mointeresp)
                                                            ELSE 0
                                                      END)
                                                 ELSE 0
                                            END
           ,'reajuste_papel'            =   0
           ,'interes_pacto '            =   CASE WHEN a.momonpact in (999,998,997,994,995)
                                                 THEN (CASE WHEN a.motipoper = 'RVA'  THEN   SUM(A.mointpac)  
                                                            WHEN a.motipoper = 'RV'   THEN   SUM(A.mointeresp)
                                                            ELSE 0
                                                      END)
                                                 ELSE 0
                                            END
           ,'reajuste_pacto'            =   (CASE WHEN a.motipoper = 'RVA'  THEN   SUM(A.moreapac)  
                                                  WHEN a.motipoper = 'RV'   THEN   SUM(A.moreajustp)
                                                  ELSE 0
                                            END)
           ,'valor_cupon'               =   0
           ,'nominalpesos'              =   (CASE WHEN a.motipoper = 'RVA'         THEN   SUM(A.monominalp) 
                                                  WHEN a.motipoper = 'RV'          THEN   SUM(A.monominalp) 
                                                  WHEN a.motipoper IN ('CI','CIX') THEN   SUM(A.monominalp) 
                                             END)
           ,'nominal'                   =   (CASE WHEN a.motipoper = 'RVA'         THEN   SUM(A.monominal)
                                                  WHEN a.motipoper = 'RV'          THEN   SUM(A.monominal)
                                                  WHEN a.motipoper IN ('CI','CIX') THEN   SUM(A.monominal )
                                             END) 
           ,'valor_comprahis'           =   (CASE WHEN a.motipoper = 'RVA'  THEN   SUM(A.movalvenp)
                                                  WHEN a.motipoper = 'RV'   THEN   SUM(A.movalvenp)
                                                  ELSE 0
             END)
           ,'dif_ant_pacto_pos'         =   (CASE WHEN a.motipoper = 'RVA'  THEN   SUM(A.moutilidad)
                                                  WHEN a.motipoper = 'RV'   THEN  0
                                                  ELSE 0
                                             END)
           ,'dif_ant_pacto_neg'         =   (CASE WHEN a.motipoper = 'RVA'  THEN   SUM(A.moperdida)
                                                  WHEN a.motipoper = 'RV'   THEN  0
                                                  ELSE 0
                                             END)

    --Datos -------
           ,'A'
       	   ,(CASE	WHEN @producto = 'CIX'	THEN 'CI' 
			WHEN @producto = 'RVA' 	THEN 'RV'
			ELSE @producto
			END)
    	   ,'MOV'
    	   ,a.momonpact
    	   ,a.momonpact         
           ,1
           ,a.monumoper
           ,a.monumoper
           ,0
           ,0
           ,a.morutcli
           ,( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.MOMONPACT )
           ,c.clmercado
           ,'fecha_contable'        = @fecha_hoy
	   ,'MOV'
	   ,a.mofecpro
	   ,a.motipoper
	   ,a.motipoper
	   ,''
	FROM	MOVIMIENTO_TRADER	        a,
		VIEW_CLIENTE	        c,
		VIEW_PRODUCTO               p,
		VIEW_CALIDAD_JURIDICA       j
       	WHERE	a.mostatreg               =  ' ' 
	AND	(c.clrut                  =  a.morutcli
	AND	c.clcodigo                =  a.mocodcli)
	AND	a.mofecpro                =  @fecha_hoy
	AND	a.motipoper               =  @producto
	AND	a.motipoper               <> 'TI'
	AND	p.codigo_producto         =  a.motipoper
	AND	c.Clcalidadjuridica       =  j.Codigo_Calidad
	GROUP
	BY	A.MOFECINIP
		,a.MOFECVENP 
		,a.MOMONPACT   	        
		,a.monumoper
		,a.morutcli
		,a.mocodcli
		,c.clmercado            
		,a.motipoper 
		,a.morutcart
		,a.moforpagi
		,a.mofecpro
		,A.MOMONPACT

        IF @@ERROR <> 0
        BEGIN
           SET   @error = 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA.'
           PRINT @error
           RETURN 1
        END

   -- INFORMA LA COMPRA CON PACTO 
   ---------------------------------------------------------------------------
   END



   ----------------------------------------------------------
   -- OPERACIONES DEL DIA
   ----------------------------------------------------------
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
       ,forma_pago	
       ,rut
       ,codigo_operacion
       ,mercado
       ,fecha_contable
       ,archivo_proceso
       ,fecha_historica
       ,tipoper
       ,tipoperO
       ,cartera
       ,fecha_referencia
       )
   SELECT
       'BTR'			
       ,(CASE  WHEN A.motipoper IN('IB','VIB')            	     			THEN 'IB'
               WHEN A.motipoper IN('CI','CIX','RV','RVA')           			THEN 'CI'
	       WHEN a.motipoper IN('VI','VIX','RC','RCA') and a.motipopero = 'CI'       THEN 'CI'
	       WHEN a.motipoper IN('VI','VIX','RC','RCA') and a.morutcli = @rut_central THEN 'REPO'
               WHEN a.motipoper IN('LBC','VBC')                  			THEN 'LBC'
	 ELSE
	 	(CASE 
           	    WHEN A.MOCODIGO=20 AND A.MORUTEMI= @rut_entidad THEN 'LCHP'
	            WHEN A.MOCODIGO=20 AND A.MORUTEMI<>@rut_entidad THEN 'LCHT'
	            WHEN A.MOCODIGO=15 AND A.MORUTEMI<>@rut_central THEN 'BONL'
        	    WHEN A.MOCODIGO=15 AND A.MORUTEMI= @rut_central THEN 'SLSP'
                    WHEN A.MOCODIGO=9  OR  A.MOCODIGO=11            THEN 'DPF'                    
	            ELSE  ( SELECT INSERIE FROM VIEW_INSTRUMENTO WHERE INCODIGO = A.MOCODIGO )
        	END)
	END)
       ,CASE WHEN A.MOTIPOPER IN ( 'IB' , 'VIB', 'LBC', 'VBC')
             THEN (CASE 
                        WHEN DATEDIFF( DAY , A.MOFECINIP , A.MOFECVEN ) BETWEEN   0 AND   29 THEN  3
                        WHEN DATEDIFF( DAY , A.MOFECINIP , A.MOFECVEN ) BETWEEN  30 AND   89 THEN  4
                        WHEN DATEDIFF( DAY , A.MOFECINIP , A.MOFECVEN ) BETWEEN  90 AND  365 THEN  5
                        WHEN DATEDIFF( DAY , A.MOFECINIP , A.MOFECVEN ) BETWEEN 366 AND 1095 THEN  6
                        WHEN DATEDIFF( DAY , A.MOFECINIP , A.MOFECVEN ) > 1095               THEN  7
                  END)
             ELSE ( CASE WHEN DATEDIFF( DAY , A.FECHA_COMPRA_ORIGINAL , A.MOFECVEN ) <= 365 THEN 1 ELSE 2 END )
        END
       ,CASE WHEN A.MOTIPOPER IN('CI','CIX','RV','RVA')				THEN 'A00'
             WHEN A.MOTIPOPER IN('VI','VIX','RC','RCA') and A.MOTIPOPERO = 'CI'	THEN 'A00'
             WHEN A.MOTIPOPER IN('LBC','VBC') 					THEN 'P00'
             ELSE 'A' +   (CASE
                                WHEN A.Codigo_CarteraSuper = 'T' THEN 'T' --TRADING
                                WHEN A.Codigo_CarteraSuper = 'P' THEN 'C' --PERMANENTE
                                ELSE '0' --INVEST /HAY QUE PARAMETRIZAR YA!!!!!!!
                          END) +'0'
        END        
       ,CASE WHEN A.MOTIPOPERO IN ('CI','CIX') 
             THEN (SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTCLI = CLRUT AND A.MOCODCLI = Clcodigo)
             ELSE (SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTEMI = CLRUT)
        END
       ,CASE WHEN A.MOTIPOPERO IN ('CI','CIX') 
             THEN (SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTCLI = CLRUT AND A.MOCODCLI = Clcodigo)
             ELSE (SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTEMI = CLRUT)
        END
       ,CASE WHEN A.MOTIPOPER = 'VCI' AND A.MORUTEMI=@nRut_BCCH 
             THEN 'B00'
             ELSE (CASE WHEN (SELECT relacion_bcch FROM VIEW_FORMA_DE_PAGO WHERE a.moforpagi = Codigo) = 1
                        THEN 'B00'
                        --ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=A.MORUTCLI AND Codigo_Cliente=A.MOCODCLI AND @Plaza=Codigo_Plaza AND defecto='S') , '')
                        --SE REALIZA ESTA CAMBIO EL 11/09/2003 (BUSCA EL CORRESPONSAL POR DEFECTO)
                        ELSE  ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=@rut_entidad AND Codigo_Cliente=@Codigo_Entidad AND A.MOMONPACT=Codigo_mONEDA AND defecto='S') , '')
                 END)
        END
       ,CASE WHEN A.MOTIPOPER IN('LBC','VBC') THEN '0' ELSE 'V' END
       ,CASE WHEN A.MOTIPOPER IN('LBC','VBC') THEN '0' ELSE 'V' END
       ,CASE
                WHEN A.MOTIPOPER IN( 'VIB','IB')  THEN ( CASE
                                                                    WHEN A.MOMONPACT=999            THEN '0'
                                                                    WHEN A.MOMONPACT=998            THEN '1'
                                                                    WHEN A.MOMONPACT=997            THEN '2'
                                                                    WHEN A.MOMONPACT IN (995,994)   THEN '3'
                                                                    ELSE '0'
                                                                END)
                ELSE  ( CASE
                            WHEN A.MOMONEMI = 999 THEN '0'
                            WHEN A.MOMONEMI = 998 THEN '1'
                            WHEN A.MOMONEMI = 997 THEN '2'
                            ELSE '3'
                      END)
         END
       ,CASE    
                WHEN A.MOTIPOPER IN('IB')  THEN (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.MOMONPACT)
                ELSE  ( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.MOMONEMI )
         END
       ,CASE	WHEN A.MOTIPOPER IN( 'IB') THEN ( CASE	WHEN A.MOmonpact = 999 THEN '0' 
							WHEN A.MOmonpact = 998 THEN '0' 
							WHEN A.MOmonpact = 997 THEN '0' 
							WHEN A.MOmonpact = 995 THEN '0' 
							WHEN A.MOmonpact = 994 THEN '0' 
							ELSE '1' 
							END)
                ELSE  ( CASE	WHEN A.MOMONEMI = 999 THEN '0' 
				WHEN A.MOMONEMI = 998 THEN '0' 
				WHEN A.MOMONEMI = 997 THEN '0' 
				WHEN A.MOMONEMI = 995 THEN '0' 
				WHEN A.MOMONEMI = 994 THEN '0' 
				ELSE '1' 
				END) 
         END
             
--Valores a contabilizar
       ,'valor_compra'              =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.movalcomp
                                              WHEN a.motipoper = 'RVA'  THEN  a.movalinip
                                              WHEN a.motipoper = 'CI'   THEN  a.movalcomp
                                              WHEN a.motipoper = 'CIX'  THEN  a.movalinip
                                              WHEN a.motipoper = 'CP'   THEN  a.movalcomp  
                                              WHEN a.motipoper = 'IB'   THEN  a.movalcomp
                                              WHEN a.motipoper = 'ICAP' THEN  a.movalcomp
                                              WHEN a.motipoper = 'ICOL' THEN  a.movalcomp
                                              WHEN a.motipoper = 'LBC'  THEN  a.movalcomp
                                              WHEN a.motipoper = 'RC'   THEN  CASE WHEN a.morutcli = @rut_central THEN 0  ELSE a.movalcomp END
                                              WHEN a.motipoper = 'RV'   THEN  a.mocapitalp
                                              WHEN a.motipoper = 'TD'   THEN  a.movalcomp
                                              WHEN a.motipoper = 'TI'   THEN  a.movalcomp
                                              WHEN a.motipoper = 'VBC'  THEN  a.movalinip
                                              WHEN a.motipoper = 'VCI'  THEN  a.movalcomp
                                              WHEN a.motipoper = 'VI'   THEN  CASE WHEN a.morutcli = @rut_central THEN 0  ELSE (CASE WHEN a.motipopero IN ('CI','CIX') THEN 0 ELSE a.movalcomp END) END
					      WHEN a.motipoper = 'VIX' THEN  CASE WHEN a.morutcli = @rut_central THEN 0  ELSE (CASE WHEN a.motipopero IN ('CI','CIX') THEN 0 ELSE a.movalcomp END) END
                                              WHEN a.motipoper = 'VIB'  THEN  a.movalinip
 WHEN a.motipoper = 'VP'   THEN  a.movalcomp
                                              WHEN a.motipoper = 'SLH'  THEN  a.movalcomp
                                              WHEN a.motipoper = 'VTD'  THEN  a.movalinip
                                              ELSE a.movalcomp
                                              END)  

       	,'valor_presente'           =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.movpresen
                                              WHEN a.motipoper = 'RVA'  THEN  a.movalant
                                              WHEN a.motipoper = 'CI'   THEN  0
                                              WHEN a.motipoper = 'CIX'  THEN  0
                                              WHEN a.motipoper = 'CP'   THEN  0
                                              WHEN a.motipoper = 'IB'   THEN  a.movpresen
                                              WHEN a.motipoper = 'ICAP' THEN  a.movpresen
                                              WHEN a.motipoper = 'ICOL' THEN  a.movpresen
                                              WHEN a.motipoper = 'LBC'  THEN  a.movpresen
                                              WHEN a.motipoper = 'RC'   THEN  a.movpresen
                                              WHEN a.motipoper = 'RV'   THEN  0
                                              WHEN a.motipoper = 'TD'   THEN  a.movpresen
                                              WHEN a.motipoper = 'TI'   THEN  a.movpresen
                                              WHEN a.motipoper = 'VBC'  THEN  a.movpresen 
                                              WHEN a.motipoper = 'VCI'  THEN  ( CASE WHEN a.momonemi IN (999,998,997,995, 994) THEN ROUND(a.movalven, 0) ELSE ROUND(a.movalven, 2)  END)
                                              WHEN a.motipoper = 'VI'   THEN  a.movpresen  --CASE WHEN a.morutcli = @rut_central THEN 0  ELSE a.movpresen END
                                              WHEN a.motipoper = 'VIX'  THEN  a.movpresen  --CASE WHEN a.morutcli = @rut_central THEN 0  ELSE a.movpresen END
                                              WHEN a.motipoper = 'VIB'  THEN  a.movpresen
                                              WHEN a.motipoper = 'VP'   THEN  a.movalven
                                              WHEN a.motipoper = 'SLH'  THEN  a.movalven --a.movpresen
                                              WHEN a.motipoper = 'VTD'  THEN  0
                                              ELSE a.movpresen
                                              END)  

       ,'valor_venta'               =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.movalinip
                                              WHEN a.motipoper = 'RVA'  THEN  0
                                              WHEN a.motipoper = 'CI'   THEN  0
                                              WHEN a.motipoper = 'CIX'  THEN  0
                                              WHEN a.motipoper = 'CP'   THEN  0
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
                                              WHEN a.motipoper = 'RC'   THEN  a.movalinip
                                              WHEN a.motipoper = 'RV'   THEN  0
                                              WHEN a.motipoper = 'TD' THEN  0
            				      WHEN a.motipoper = 'TI'   THEN  a.movalven
                                              WHEN a.motipoper = 'VBC'  THEN  a.monominal
                                              WHEN a.motipoper = 'VCI'  THEN  a.movalven
                                              WHEN a.motipoper = 'VI'   THEN  a.movalven
                                              WHEN a.motipoper = 'VIX'  THEN  a.movalven
                                              WHEN a.motipoper = 'VIB'  THEN  a.monominal
                              WHEN a.motipoper = 'VP'   THEN  a.movalven
                                              WHEN a.motipoper = 'SLH'  THEN  a.movalven
                                              WHEN a.motipoper = 'VTD'  THEN  a.movalvenp
                                              ELSE a.movalven                                              
                                              END)

       ,'utilidad'                  =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.moutilidad
                                              WHEN a.motipoper = 'RVA'  THEN  a.moutilidad
                                              WHEN a.motipoper = 'CI'   THEN  0
                                              WHEN a.motipoper = 'CIX'  THEN  0
                                              WHEN a.motipoper = 'CP'   THEN  ABS(a.descuento)
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
                                              WHEN a.motipoper = 'RC'   THEN  0
                                              WHEN a.motipoper = 'RV'   THEN  0
                                              WHEN a.motipoper = 'TD'   THEN  0
                                              WHEN a.motipoper = 'TI'   THEN  0
                                              WHEN a.motipoper = 'VBC'  THEN  0
                                              WHEN a.motipoper = 'VCI'  THEN  0
                                              WHEN a.motipoper = 'VI'   THEN  0
                                              WHEN a.motipoper = 'VIX'  THEN  0
                                              WHEN a.motipoper = 'VIB'  THEN  0
                                              WHEN a.motipoper = 'VP'   THEN  a.moutilidad
                                              WHEN a.motipoper = 'SLH'  THEN  a.moutilidad
                                              WHEN a.motipoper = 'VTD'  THEN  0
                                              ELSE a.moutilidad
                                         END)

       ,'perdida'                   =   (CASE WHEN a.motipoper = 'RCA'  THEN  ABS(a.moperdida)
                                              WHEN a.motipoper = 'RVA'  THEN  ABS(a.moperdida)
                                              WHEN a.motipoper = 'CI'   THEN  0
                                              WHEN a.motipoper = 'CIX'  THEN  0
                                              WHEN a.motipoper = 'CP'   THEN  ABS(a.premio)
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
			                      WHEN a.motipoper = 'RC'   THEN  0
                                              WHEN a.motipoper = 'RV'   THEN  0
                                              WHEN a.motipoper = 'TD'   THEN  0
					      WHEN a.motipoper = 'TI'  THEN  0
                                              WHEN a.motipoper = 'VBC'  THEN  0
                                              WHEN a.motipoper = 'VCI'  THEN  0
                                              WHEN a.motipoper = 'VI'   THEN  0
                                              WHEN a.motipoper = 'VIX'  THEN  0
                                              WHEN a.motipoper = 'VIB'  THEN  0
                                              WHEN a.motipoper = 'VP'   THEN  ABS(a.moperdida)
                                              WHEN a.motipoper = 'SLH'  THEN  ABS(a.moperdida)
                                              WHEN a.motipoper = 'VTD'  THEN  0
                                              ELSE a.moperdida
                                              END) 

     ,'interes_papel'             =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.mointeres
                                              WHEN a.motipoper = 'RVA'  THEN  0
                                              WHEN a.motipoper = 'CI'   THEN  0
                                              WHEN a.motipoper = 'CIX'  THEN  0
                                              WHEN a.motipoper = 'CP'   THEN  0
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
                                              WHEN a.motipoper = 'RC'   THEN  CASE WHEN a.morutcli = @rut_central THEN 0  ELSE a.mointeres END
                                              WHEN a.motipoper = 'RV'   THEN  0
                                              WHEN a.motipoper = 'TD'   THEN  0
                                              WHEN a.motipoper = 'TI'   THEN  0
                                              WHEN a.motipoper = 'VBC'  THEN  a.mointeresi
                                              WHEN a.motipoper = 'VCI'  THEN a.mointeres
                                              WHEN a.motipoper = 'VI'   THEN  CASE WHEN a.morutcli = @rut_central THEN 0  ELSE a.mointeres END
                                              WHEN a.motipoper = 'VIX'  THEN  CASE WHEN a.morutcli = @rut_central THEN 0  ELSE a.mointeres END
                                              WHEN a.motipoper = 'VIB'  THEN  a.mointeresi
                                              WHEN a.motipoper = 'VP'   THEN  a.mointeres
                                              WHEN a.motipoper = 'SLH'  THEN  a.mointeres
                                              WHEN a.motipoper = 'VTD'  THEN  a.mointeresi
                                              ELSE a.movalven                                              
                                              END)

       ,'reajuste_papel'            =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.moreajuste
                                              WHEN a.motipoper = 'RVA'  THEN  0
                                              WHEN a.motipoper = 'CI'   THEN  0
                                              WHEN a.motipoper = 'CIX'  THEN  0
                                              WHEN a.motipoper = 'CP'   THEN  0
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
                                              WHEN a.motipoper = 'RC'   THEN  CASE WHEN a.morutcli = @rut_central THEN 0  ELSE a.moreajuste END
					      WHEN a.motipoper = 'RV'   THEN  0
                                              WHEN a.motipoper = 'TD'   THEN  0
                                              WHEN a.motipoper = 'TI'   THEN  0
                                              WHEN a.motipoper = 'VBC' THEN  a.moreajusti
                                              WHEN a.motipoper = 'VCI'  THEN  a.moreajuste
                                              WHEN a.motipoper = 'VI'   THEN  CASE WHEN a.morutcli = @rut_central THEN 0  ELSE a.moreajuste END
                                              WHEN a.motipoper = 'VIX'  THEN  CASE WHEN a.morutcli = @rut_central THEN 0  ELSE a.moreajuste END
                                              WHEN a.motipoper = 'VIB'  THEN  a.moreajusti
                                              WHEN a.motipoper = 'VP'   THEN  a.moreajuste
                                              WHEN a.motipoper = 'SLH'  THEN  a.moreajuste
           WHEN a.motipoper = 'VTD'  THEN  a.moreajusti
                                              ELSE a.movalven                   
                                              END)

       ,'interes_pacto '            =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.mointpac
                                              WHEN a.motipoper = 'RVA'  THEN  a.mointpac
                                              WHEN a.motipoper = 'CI'   THEN  0
                                              WHEN a.motipoper = 'CIX'  THEN  0
                                              WHEN a.motipoper = 'CP'   THEN  0
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
                                              WHEN a.motipoper = 'RC'   THEN  a.mointeresp
                                              WHEN a.motipoper = 'RV'   THEN  a.mointeresp
                                              WHEN a.motipoper = 'TD'   THEN  0
                                              WHEN a.motipoper = 'TI'   THEN  0
                                              WHEN a.motipoper = 'VBC'  THEN  a.mointeresp
                                              WHEN a.motipoper = 'VCI'  THEN  0
                                              WHEN a.motipoper = 'VI'   THEN  0
                                              WHEN a.motipoper = 'VIX'  THEN  0
                                              WHEN a.motipoper = 'VIB'  THEN  a.mointeresp
                                              WHEN a.motipoper = 'VP'   THEN  ABS(a.descuento)
                                              WHEN a.motipoper = 'SLH'  THEN  ABS(a.descuento)
                                              WHEN a.motipoper = 'VTD'  THEN  a.mointeresp
                                              ELSE a.movalven                                              
                                              END)

       ,'reajuste_pacto'            =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.moreapac
                                              WHEN a.motipoper = 'RVA'  THEN  a.moreapac
                                              WHEN a.motipoper = 'CI'   THEN  0
                                              WHEN a.motipoper = 'CIX'  THEN  0
                                              WHEN a.motipoper = 'CP'   THEN  0
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
                                              WHEN a.motipoper = 'RC'   THEN  a.moreajustp
                                              WHEN a.motipoper = 'RV'   THEN  a.moreajustp
                                              WHEN a.motipoper = 'TD'   THEN  0
                                              WHEN a.motipoper = 'TI'   THEN  0
                                              WHEN a.motipoper = 'VBC'  THEN  a.moreajustp
        			   	      WHEN a.motipoper = 'VCI'  THEN  0
                                              WHEN a.motipoper = 'VI'   THEN  0
                                              WHEN a.motipoper = 'VIX'  THEN  0
                                              WHEN a.motipoper = 'VIB'  THEN  a.moreajustp
                                              WHEN a.motipoper = 'VP'   THEN  ABS(a.premio)
                                              WHEN a.motipoper = 'SLH'  THEN  ABS(a.premio)
                WHEN a.motipoper = 'VTD'  THEN  a.moreajustp
                                              ELSE a.movalven                            
                                        END)

       ,'valor_cupon'               =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.movalinip
                                              WHEN a.motipoper = 'RVA'  THEN  0
                                              WHEN a.motipoper = 'CI'   THEN  0
                                              WHEN a.motipoper = 'CIX'  THEN  0
                                              WHEN a.motipoper = 'CP'   THEN  0
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
                                              WHEN a.motipoper = 'RC'   THEN  0
                                              WHEN a.motipoper = 'RV'   THEN  0
                                              WHEN a.motipoper = 'TD'   THEN  0
                                              WHEN a.motipoper = 'TI'   THEN  0
                                              WHEN a.motipoper = 'VBC'  THEN  0
                                              WHEN a.motipoper = 'VCI'  THEN  0
                                              WHEN a.motipoper = 'VI'   THEN  0
                                              WHEN a.motipoper = 'VIX'  THEN  0
                                              WHEN a.motipoper = 'VIB'  THEN  0
                                              WHEN a.motipoper = 'VP'   THEN  0
                                              WHEN a.motipoper = 'SLH'  THEN  0
                                              WHEN a.motipoper = 'VTD'  THEN  0
                                              ELSE a.movalven    
                                              END)

       ,'nominalpesos'              =  (CASE  WHEN a.motipoper = 'RCA'  THEN  0
                                              WHEN a.motipoper = 'RVA'  THEN  a.monominalp
                                              WHEN a.motipoper = 'CP'   THEN  0
                                              WHEN a.motipoper = 'CI'   THEN  a.monominalp
                                              WHEN a.motipoper = 'CIX'  THEN  a.monominalp
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
                                              WHEN a.motipoper = 'RC'   THEN  a.monominalp
                                              WHEN a.motipoper = 'RV'   THEN  a.monominalp
                                              WHEN a.motipoper = 'TD'   THEN  0
                                              WHEN a.motipoper = 'TI'   THEN  0
                                              WHEN a.motipoper = 'VBC'  THEN  0
                                              WHEN a.motipoper = 'VCI'  THEN  0
                                              WHEN a.motipoper = 'VI'   THEN  a.monominalp
                                              WHEN a.motipoper = 'VIX'  THEN  a.monominalp
                                              WHEN a.motipoper = 'VIB'  THEN  0
                                              WHEN a.motipoper = 'VP'   THEN  0
                                              WHEN a.motipoper = 'SLH'  THEN  0
                                              WHEN a.motipoper = 'VTD'  THEN  0
                                              ELSE	(CASE	when a.momonemi <> 999 then ROUND(a.monominal * (Select vmvalor From view_valor_moneda Where vmcodigo =a.momonemi and vmfecha = a.mofecinip),0)    --@valor_uf,0)
								else a.monominal 
								END)
                                              END)     

       ,'nominal'                   =   (CASE WHEN a.motipoper = 'RCA'  THEN  0
                                              WHEN a.motipoper = 'RVA'  THEN  a.monominal
                                              WHEN a.motipoper = 'CI'   THEN  a.monominal
                                              WHEN a.motipoper = 'CIX'  THEN  a.monominal
                                              WHEN a.motipoper = 'CP'   THEN  0
                                              WHEN a.motipoper = 'IB'   THEN  0
                                              WHEN a.motipoper = 'ICAP' THEN  0
                                              WHEN a.motipoper = 'ICOL' THEN  0
                                              WHEN a.motipoper = 'LBC'  THEN  0
                                              WHEN a.motipoper = 'RC'   THEN  0
                                              WHEN a.motipoper = 'RV'   THEN  a.monominal
                                              WHEN a.motipoper = 'TD'   THEN  a.monominal
                                              WHEN a.motipoper = 'TI'   THEN  0
                                              WHEN a.motipoper = 'VBC'  THEN  0
                                              WHEN a.motipoper = 'VCI'  THEN  0
                                              WHEN a.motipoper = 'VI'   THEN  0
                                              WHEN a.motipoper = 'VIX'  THEN  0
                                              WHEN a.motipoper = 'VIB'  THEN  0
                                              WHEN a.motipoper = 'VP'   THEN  0
                                              WHEN a.motipoper = 'SLH'  THEN  0
                                              WHEN a.motipoper = 'VTD'  THEN  0
                                              ELSE a.monominal
                                              END) 

       ,'valor_comprahis'           =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.movalant    
                                              WHEN a.motipoper = 'RVA'  THEN  a.movalvenp
                                              WHEN a.motipoper = 'CP'   THEN  a.movalcomp
                                              WHEN a.motipoper = 'RC'   THEN  a.movalvenp
                                              WHEN a.motipoper = 'RV'   THEN  a.movalvenp
                                              ELSE   0
                                         END)
       ,'dif_ant_pacto_pos'         =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.moutilidad
                                              WHEN a.motipoper = 'RVA'  THEN  a.moutilidad
                                              WHEN a.motipoper = 'CP'   THEN  CASE WHEN A.MOCODIGO=20 AND A.MORUTEMI= @rut_entidad THEN a.descuento ELSE 0 END
                                              ELSE 0    
                                              END)

       ,'dif_ant_pacto_neg'         =   (CASE WHEN a.motipoper = 'RCA'  THEN  a.moperdida
			                      WHEN a.motipoper = 'RVA'  THEN  a.moperdida
                                              WHEN a.motipoper = 'CP'   THEN  CASE WHEN A.MOCODIGO=20 AND A.MORUTEMI= @rut_entidad THEN a.premio ELSE 0 END
                                              ELSE 0    
                                              END)

       ,'dif_valor_mercado_pos'     =   CONVERT(NUMERIC(19),0)    
       ,'dif_valor_mercado_neg'     =   CONVERT(NUMERIC(19),0)    
       ,'rev_valor_mercado_pos'     =   (CASE WHEN a.motipoper IN ('VCI','VP','SLH')  THEN  0
                                              ELSE CONVERT(NUMERIC(19),0)    
                                              END)

       ,'rev_valor_mercado_neg'     =  (CASE  WHEN a.motipoper IN ('VCI','VP','SLH')  THEN  0
                                              ELSE CONVERT(NUMERIC(19),0)    
                                              END)

       ,'valor_futuro'              =   CONVERT(NUMERIC(19),0)
       ,'Valor_perdida_usd'         =   CONVERT(NUMERIC(19),0)
       ,'Valor_utilidad_usd'        =   CONVERT(NUMERIC(19),0)
       ,'Valor_perdida_clp'         =   CONVERT(NUMERIC(19),0)
       ,'Valor_utilidad_clp'        =   CONVERT(NUMERIC(19),0) 

--Datos -------
        ,(CASE WHEN a.motipoper='LBC' THEN 'P' ELSE 'A' END )
	, CASE WHEN a.motipoper IN('VI','VIX') AND a.motipopero IN ('CI','CIX')	THEN 'CI' 
	       WHEN a.motipoper IN ('CI','CIX') 				THEN 'CI' 
	       WHEN a.motipoper IN ('VIX') 					THEN 'VI'
	       WHEN a.motipoper IN ('RCA') 					THEN 'RC'
	       WHEN a.motipoper IN ('RVA') 					THEN 'RV'
               ELSE (CASE WHEN a.motipoper='VBC' THEN 'LBC' ELSE a.motipoper END)
          END 
	,(case when a.motipoper = 'CP'   then (CASE WHEN A.MOCODIGO=20 AND A.MORUTEMI= @rut_entidad 
                                                    THEN 'ALC'
                                                    ELSE 'MOV'
                                               END) 
               when a.motipoper IN ('CI','CIX')   then 'MCO'
               when a.motipoper = 'RC'   then (CASE WHEN a.motipopero IN ('CI','CIX') THEN 'VEN' ELSE 'MOV' END)
               when a.motipoper = 'RCA'  then 'MOV'
               when a.motipoper = 'LBC'  then 'MOV'
               when a.motipoper = 'IB'   then 'MOV'
               when a.motipoper = 'TD'   then 'MOV'
               when a.motipoper = 'VP'   then (CASE	WHEN A.MOCODIGO=20 AND A.MORUTEMI= @rut_entidad 
							THEN 'LLC'
							ELSE 'MOV'
							END)
               when a.motipoper = 'SLH'  then (CASE	WHEN A.MOCODIGO=20 AND A.MORUTEMI= @rut_entidad 
							THEN 'SLH'
							ELSE 'MOV'
							END)
               when a.motipoper IN('VI','VIX') AND  a.motipopero<>'CI' then 'MOV'
               when a.motipoper IN('VI','VIX') AND  a.motipopero ='CI' then 'MVE'
               when a.motipoper = 'RV'   then 'MVE'
               when a.motipoper = 'RVA'  then 'MVE'
               when a.motipoper = 'TI'   then 'MOV'         
               when a.motipoper = 'VCI'  then (CASE	WHEN A.MOCODIGO=20 AND A.MORUTEMI= @rut_entidad 
							THEN 'VCP'
							ELSE 'VEN'
							END)
               when a.motipoper = 'VTD'  then 'VEN'         
               when a.motipoper = 'VBC'  then 'VEN'         
               when a.motipoper = 'VIB'  then 'VEN'               
	       end)

       ,a.momonemi
       ,a.momonemi
       ,a.mocodigo
       ,a.monumoper
       ,a.monumdocu
       ,a.mocorrela                  
       ,(CASE	WHEN A.MOCODIGO=20       AND A.MORUTEMI = @rut_entidad THEN 0
		WHEN A.motipoper IN('VCI','SLH') AND A.MORUTEMI =  @rut_central THEN 1
		WHEN A.motipoper IN('VCI','SLH') AND A.MORUTEMI <> @rut_central THEN 2
		ELSE  (CASE WHEN a.motipoper IN ('CP', 'VP') THEN (SELECT relacion_bcch FROM VIEW_FORMA_DE_PAGO WHERE a.moforpagi = Codigo) ELSE 0 END)
		END)
       ,a.morutcli
       ,CASE	WHEN a.momonemi = 13 THEN 'USD' 
		ELSE ( SELECT TOP 1 LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON =  a.momonemi)
		END
       ,c.clmercado
       ,'fecha_contable'        = @fecha_hoy
       ,'MOV'
       ,a.mofecpro
       ,a.motipoper
       ,a.motipoper
       ,''
       ,case	when a.motipoper = 'VC'   then '00' + substring(CONVERT(CHAR(10),@fecha_hoy,112),5,2)+ substring(CONVERT(CHAR(10),@fecha_hoy,112),1,4)
		when a.motipoper = 'SLH'  then '00' + substring(CONVERT(CHAR(10),@fecha_hoy,112),5,2)+ substring(CONVERT(CHAR(10),@fecha_hoy,112),1,4)
		ELSE ''
		end

	FROM	MOVIMIENTO_TRADER	a,
		VIEW_INSTRUMENTO	b,
		VIEW_CLIENTE	        c,
		VIEW_EMISOR	        e,
		VIEW_DATOS_GENERALES	m,
		VIEW_PRODUCTO   	p,
		VIEW_CALIDAD_JURIDICA   j
	WHERE	a.mostatreg   =  ' ' 
	AND	(a.motipoper   <>  'AIC'   AND a.motipoper  <>  'IC' )
	AND	(a.motipoper   <>  'CFM'   AND a.motipoper  <>  'RFM' )
	AND	(a.motipoper   <>  'FLI'   )
	AND	(c.clrut          =  a.morutcli
	AND	c.clcodigo        =  a.mocodcli)
	AND	e.emrut           =  a.morutemi
	AND	b.incodigo        =  a.mocodigo
	AND	a.mofecpro        =  @fecha_hoy
	AND	a.motipoper       =  @producto
	AND	a.motipoper      <> 'TI'
	AND	p.codigo_producto = a.motipoper
	AND	NOT (   a.momascara in ('ICAPX','ICOL','ICAP') AND  motipoper IN ('IB','VIB')   )
	AND	c.Clcalidadjuridica   = j.Codigo_Calidad
	AND	NOT ( a.motipoper IN('VI','VIX','RC','RCA') AND a.morutcli = @rut_central )



	IF @@ERROR <> 0
	BEGIN
		SET   @error = 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA.'
		PRINT @error
		RETURN 1
	END



-- ======================================================================================
-- LLENA FONDOS MUTUOS
-- =======================================================================================

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
		,valor_venta      
		,utilidad         
		,perdida          
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
		,forma_pago	
		,rut
		,codigo_operacion
		,mercado
		,fecha_contable
		,archivo_proceso
		,fecha_historica
		,tipoper
		,tipoperO
		,cartera
		,fecha_referencia
		)
	SELECT	'BTR'			
		,'CMF'
		,CASE WHEN DATEDIFF( DAY , A.FECHA_COMPRA_ORIGINAL , A.MOFECVEN ) <= 365 THEN 1 ELSE 2 END
		,'A00'
		,(SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTCLI = CLRUT AND A.MOCODCLI = Clcodigo)
		,(SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTCLI = CLRUT AND A.MOCODCLI = Clcodigo)
		,(CASE	WHEN (	SELECT relacion_bcch FROM VIEW_FORMA_DE_PAGO WHERE a.moforpagi = Codigo) = 1
			THEN 'B00'
			ELSE ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE Rut_Cliente=@rut_entidad AND Codigo_Cliente=@Codigo_Entidad AND A.MOMONPACT=Codigo_mONEDA AND defecto='S') , '')
			END)
		,'V'
		,'V'
		,(CASE	WHEN A.MOMONEMI = 999 THEN '0'
			WHEN A.MOMONEMI = 998 THEN '1'
			WHEN A.MOMONEMI = 997 THEN '2'
			ELSE '3'
			END)
		,( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.MOMONEMI )
		,'0'
		--Valores a contabilizar
		,'valor_compra'              =	 a.movalcomp
		,'valor_venta'               =   a.movalven
		,'utilidad'                  =   a.moutilidad
		,'perdida'                   =   a.moperdida

-- SELECT MOVALVEN-MOVALCOMP, MOINTERES,* FROM MOVIMIENTO_TRADER

		--Datos -------
		,'A'
		,a.motipoper                                         ---- 'CFM' supuestamente BUENO
		,(case	when a.motipoper = 'CFM'  then 'MCO'
			when a.motipoper = 'RFM'  then 'MVE'
			END)
		,a.momonemi
		,a.momonemi
		,a.mocodigo
		,a.monumoper
		,a.monumdocu
		,a.mocorrela                  
		,0
		,a.morutcli
		,( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.MOMONEMI )
		,c.clmercado
		,'fecha_contable'        = @fecha_hoy
		,'MOV'
		,a.mofecpro
		,a.motipoper
		,a.motipoper
		,''
		,''
	FROM	MOVIMIENTO_TRADER	a,
		VIEW_INSTRUMENTO	b,
		VIEW_CLIENTE	        c,
		VIEW_DATOS_GENERALES	m,
		VIEW_PRODUCTO   	p,
		VIEW_CALIDAD_JURIDICA   j
	WHERE	a.mostatreg   =  ' ' 
	AND	(c.clrut		=  a.morutcli
	AND	c.clcodigo		=  a.mocodcli)
	AND	b.incodigo		=  a.mocodigo
	AND	a.mofecpro		=  @fecha_hoy
	AND	a.motipoper		=  @producto
	AND	a.motipoper		IN( 'CFM', 'RFM')
	AND	p.codigo_producto	= a.motipoper
	AND	c.Clcalidadjuridica	= j.Codigo_Calidad


	IF @@ERROR <> 0
	BEGIN
		SET   @error = 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS FONDOS MUTUOS'
		PRINT @error
		RETURN 1
	END


-- ======================================================================================
-- FLI
-- =======================================================================================

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
           ,forma_pago	
           ,rut
           ,codigo_operacion
           ,mercado
           ,fecha_contable
	   ,archivo_proceso
	   ,fecha_historica
	   ,tipoper
	   ,tipoperO
	   ,cartera
           )
       SELECT 
           'BTR'
           ,'FLI'
           ,3
           ,'P00' 
           ,( SELECT TOP 1 LEFT(Codigo_Calidad_Contable  ,1) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTCLI = CLRUT )
           ,( SELECT TOP 1 RIGHT(Codigo_Calidad_Contable ,2) FROM VIEW_CLIENTE, VIEW_CALIDAD_JURIDICA WHERE Clcalidadjuridica = Codigo_Calidad  AND A.MORUTCLI = CLRUT )
           ,'B00'
           ,'0'
           ,'0'    
           ,(CASE 
                WHEN A.MOMONPACT=999    THEN '0'
                WHEN A.MOMONPACT=998    THEN '1'
                WHEN A.MOMONPACT=997    THEN '2'
                ELSE '3'
            END)
           ,( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.MOMONPACT )
           ,(CASE
                WHEN A.MOmonpact = 999 THEN '0' 
                WHEN A.MOmonpact = 998 THEN '0' 
                WHEN A.MOmonpact = 997 THEN '0' 
                WHEN A.MOmonpact = 995 THEN '0' 
                WHEN A.MOmonpact = 994 THEN '0' 
                ELSE '1' 
            END)

	   --Valores a contabilizar
           ,'valor_compra' =   SUM(a.movalven)

	   --Datos -------
           ,'A'
       	   ,'FLI'
    	   ,'MOV'
    	   ,a.momonpact
    	   ,a.momonpact         
           ,1
           ,a.monumoper
           ,a.monumoper
           ,0
           ,0
           ,a.morutcli
           ,( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.MOMONPACT )
           ,c.clmercado
           ,'fecha_contable'        = @fecha_hoy
	   ,'MOV'
	   ,a.mofecpro
	   ,a.motipoper
	   ,a.motipoper
	   ,''
	FROM	MOVIMIENTO_TRADER	        a,
		VIEW_CLIENTE	        c,
		VIEW_PRODUCTO               p,
		VIEW_CALIDAD_JURIDICA       j
       	WHERE	a.mostatreg               =  ' ' 
	AND	(c.clrut                  =  a.morutcli
	AND	c.clcodigo                =  a.mocodcli)
	AND	a.mofecpro                =  @fecha_hoy
	AND	a.motipoper               =  @producto
	AND	a.motipoper               = 'FLI'
	AND	p.codigo_producto         =  a.motipoper
	AND	c.Clcalidadjuridica       =  j.Codigo_Calidad
	GROUP
	BY	A.MOFECINIP
		,a.MOFECVENP 
		,a.MOMONPACT   	        
		,a.monumoper
		,a.morutcli
		,a.mocodcli
		,c.clmercado            
		,a.motipoper 
		,a.morutcart
--		,a.moforpagi
		,a.mofecpro
		,A.MOMONPACT

        IF @@ERROR <> 0
        BEGIN
           SET   @error = 'ERROR_PROC FALLA ACTUALIZANDO MOVIMIENTOS RENTA FIJA ARCHIVO CONTABILIZA.'
           PRINT @error
           RETURN 1
        END


-- ======================================================================================
-- LLENA RENTA FIJA DEVENGO
-- =======================================================================================


    IF @fecha_Cierre > @fecha_hoy
        SELECT @fecha_aux = @fecha_hoy
    ELSE
        SELECT @fecha_aux = @fecha_Anterior

--select @fecha_aux, @fecha_Cierre


    IF @producto IN ('CI','CIX') BEGIN

        /* INFORMA LOS INTERESES Y REVERSA DE INTERESES (pacto)
        ------------------------------------------------------- */
       INSERT INTO 
       ##CONTABILIZA (
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
           ,forma_pago	
           ,rut
           ,codigo_operacion
           ,mercado
           ,fecha_contable
           ,archivo_proceso
           ,fecha_historica
           ,tipoper
	   ,tipoperO
           ,cartera
           )
       SELECT
            'BTR'
            ,'codigo_producto'           =  'CI'
            ,( CASE WHEN DATEDIFF( DAY , A.RSFECINIP , a.rsfecvtop ) <= 365 THEN 1 ELSE 2 END )
            ,'A00' 
            ,(SELECT TOP 1 LEFT( ISNULL(Codigo_Calidad_Contable,'J00') ,1) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTCLI AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )
            ,(SELECT TOP 1 RIGHT( ISNULL(Codigo_Calidad_Contable,'J00') ,2) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTCLI AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )            
  ,CASE WHEN a.rsrutcli = @nRut_BCCH and a.rstipoper = 'VC' THEN 'B00' ELSE '   ' END
            ,'V'
            ,'V'
           ,(CASE 
            WHEN A.Rsmonpact = 999 THEN '0'
               WHEN A.Rsmonpact = 998 THEN '1'
                WHEN A.Rsmonpact = 997 THEN '2'
                ELSE '3'
            END)
           ,( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.rsmonpact )
           ,(CASE 
                WHEN A.RSmonpact = 999 THEN '0' 
                WHEN A.RSmonpact = 998 THEN '0' 
                WHEN A.RSmonpact = 997 THEN '0' 
         WHEN A.RSmonpact = 995 THEN '0' 
                WHEN A.RSmonpact = 994 THEN '0' 
            ELSE '1'         
            END)

    --Valores a contabilizar
    
           ,'valor_compra'              =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'valor_presente'            =   SUM(isnull(a.rsinteres,0) + 
						isnull(a.rsinteres_acum,0) + 
						isnull(a.rsreajuste,0) + 
						isnull(a.rsreajuste_acum,0) )
           ,'valor_venta'               =   SUM(isnull(a.rsvppresenx,0))
           ,'utilidad'                  =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'perdida'                   =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'interes_papel'             =   SUM(ISNULL(a.rsinteres,0)  + isnull(a.rsinteres_acum,0) )
           ,'reajuste_papel'            =   SUM(ISNULL(a.rsreajuste,0) + isnull(a.rsreajuste_acum,0))
           ,'interes_pacto '            =   SUM(ISNULL(a.rsinteres,0)  + isnull(a.rsinteres_acum,0) )
           ,'reajuste_pacto'            =   SUM(ISNULL(a.rsreajuste,0) + isnull(a.rsreajuste_acum,0))
            ,'valor_cupon'               =  SUM(ISNULL(a.rsflujo,0)) -- valor total del cupon 
           ,'nominalpesos'              =   SUM(ISNULL(a.rscupint,0))-- interes cupon  
           ,'nominal'                   =   SUM(ISNULL(a.rscupamo,0))-- amortizacion cupon
           ,'valor_comprahis'           =   SUM(ISNULL(a.rscuprea,0))-- reajuste cupon  
           ,'dif_ant_pacto_pos'         =   SUM(CONVERT(NUMERIC(15),0.0)) 
           ,'dif_ant_pacto_neg'         =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'dif_valor_mercado_pos'     =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'dif_valor_mercado_neg'     =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'rev_valor_mercado_pos'     =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'rev_valor_mercado_neg'     =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'valor_futuro'              =   SUM(ISNULL(a.rsvppresenx,0))
           ,'Valor_perdida_usd'         =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'Valor_utilidad_usd'        =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'Valor_perdida_clp'         =   SUM(CONVERT(NUMERIC(15),0.0))
           ,'Valor_utilidad_clp'        =   SUM(CONVERT(NUMERIC(15),0.0)) 
    
    --Valores Adicionales
           ,'A'
           , 'CI'
           ,'codigo_evento'             =   'DVI'
           ,'codigo_moneda1'            =   a.rsmonpact
           ,'codigo_moneda2'            =   a.rsmonpact
           ,'codigo_instrumento'        =   1
           ,'numero_operacion'          =   a.rsnumoper
           ,'numero_documento'          =   a.rsnumoper
           ,'correlativo'               =   0
           ,'forma_pago'		=   0 
           ,'rut'                       =   a.rsrutcli
           ,'codigo_operacion'          =   ( SELECT TOP 1 LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.rsmonpact )
           ,'mercado'                   =   c.clmercado
           ,'fecha_contable'            =   a.rsfecctb
           ,'archivo_proceso'		=   'DEV'
           ,'fecha_historica'		=   min(rsfecha)
           ,'tipoper'			=   rstipoper
	   ,'tipoperO'			=   'CI'
           ,'cartera'			=   rscartera
    
	FROM	RESULTADO_DEVENGO	  a,
		VIEW_CLIENTE	          c,
		VIEW_EMISOR	          e,
		VIEW_PRODUCTO          p
	WHERE	(c.clrut           = a.rsrutcli
	AND	c.clcodigo        = a.rscodcli)
	AND	e.emrut = a.rsrutemis
	AND	a.rsfecha         >=@fecha_aux
	AND	a.rsfecha         < @fecha_Cierre
	AND	a.rsfecvtop  > @fecha_Cierre
	AND	a.rstipopero = @producto
	AND	p.codigo_producto = a.rstipopero
	AND	a.rscartera       = '112'   
        GROUP BY
              a.rscartera
            , a.rstipoper
            , a.rstipopero
            , a.rsmonpact
            , a.rsfecvtop 
            , a.rsfecinip 
            , a.rsrutcli 
            , a.rscodcli 
            , a.rsnumoper
            , c.clmercado
            , a.rsfecctb
     --, a.rsrutemis
           

       IF @@ERROR <> 0
          BEGIN
          SET   @error = 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA ARCHIVO CONTABILIZA.'
          PRINT @error 
          RETURN 1
       END            
    
        

    END



/* ======================================================================================== 
   LLENA RENTA FIJA DEVENGO INTERBACARIOS DOLARES y CREDITOS DE LIQUIDEZ (icap-BCCH)
  ======================================================================================== 

*/

   INSERT INTO 
   ##CONTABILIZA (
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
       ,forma_pago	
       ,rut
       ,codigo_operacion
       ,mercado
       ,fecha_contable
       ,archivo_proceso
       ,fecha_historica
       ,tipoper
       ,tipoperO
       ,cartera
       )
   SELECT
        'BTR'
        ,a.codigo_subproducto
        ,(CASE 
               WHEN DATEDIFF( DAY , A.RSFECCOMP , A.rsfecvtop ) BETWEEN   0 AND   29 THEN  3
               WHEN DATEDIFF( DAY , A.RSFECCOMP , A.rsfecvtop ) BETWEEN  30 AND   89 THEN  4
               WHEN DATEDIFF( DAY , A.RSFECCOMP , A.rsfecvtop ) BETWEEN  90 AND  365 THEN  5
               WHEN DATEDIFF( DAY , A.RSFECCOMP , A.rsfecvtop ) BETWEEN 366 AND 1095 THEN  6
               WHEN DATEDIFF( DAY , A.RSFECCOMP , A.rsfecvtop ) > 1095               THEN  7
         END)
        , CASE WHEN a.Codigo_Subproducto IN('LBC','VBC') THEN 'P00'
	       ELSE 'A' +   (CASE
                                 WHEN A.Codigo_CarteraSuper = 'T' THEN 'T' --TRADING
                                 WHEN A.Codigo_CarteraSuper = 'P' THEN 'C' --PERMANENTE
                                 ELSE                                  '0' --INVEST
                              END) +'0'
	       END
        ,(SELECT TOP 1 LEFT( ISNULL(Codigo_Calidad_Contable,'J00') ,1) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTCLI  AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )
        ,(SELECT TOP 1 RIGHT( ISNULL(Codigo_Calidad_Contable,'J00') ,2) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTCLI  AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )
        ,CASE WHEN A.RSRUTEMIS = @nRut_BCCH and a.rstipoper = 'VC' THEN 'B00' ELSE ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE rut_cliente=a.rsrutcart AND codigo_cliente=1 AND @plaza=codigo_plaza AND defecto='S') , '') END 







        ,CASE WHEN a.Codigo_Subproducto IN('LBC') THEN '0' ELSE 'V' END
        ,CASE WHEN a.Codigo_Subproducto IN('LBC') THEN '0' ELSE 'V' END
        ,( CASE	WHEN A.RSmonpact = 999 THEN '0'
                WHEN A.RSmonpact = 998 THEN '1'
                WHEN A.RSmonpact = 997 THEN '2'
                WHEN A.RSmonpact IN (994,995) THEN '3'
                ELSE '0'
                END)
       ,(SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.RSMONPACT )
       ,( CASE 	WHEN A.RSmonpact = 999 THEN '0' 
       WHEN A.RSmonpact = 998 THEN '0' 
                WHEN A.RSmonpact = 997 THEN '0' 
                WHEN A.RSmonpact = 995 THEN '0' 
                WHEN A.RSmonpact = 994 THEN '0' 
                ELSE '1'         
            	END)

--Valores a contabilizar

       ,'valor_compra'              =   SUM(CASE WHEN  a.rstipoper = 'VC' THEN ISNULL(a.rsflujo,0) ELSE CONVERT(NUMERIC(15),0.0) END)
       ,'valor_presente'            =   SUM(isnull(a.rsinteres,0) + 
					isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsinteres_acum ELSE 0 END,0) + 
					isnull(a.rsreajuste,0) +
					isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsreajuste_acum ELSE 0 END,0))
       ,'valor_venta'               =   SUM(isnull(a.rsvppresenx,0))
       ,'utilidad'                  =   SUM((CASE WHEN a.rscartera = '112' THEN ISNULL(a.rsreajumes,0) ELSE 0 END))
       ,'perdida'                   =   SUM((CASE WHEN a.rscartera = '114' AND a.codigo_subproducto IN ('CI','CIX')
                                                                                 THEN ISNULL(a.rsreajumes,0)
                                                                                 ELSE 0
                                        END))
       ,'interes_papel'             =   SUM(ISNULL(a.rsinteres,0)  + isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsinteres_acum  ELSE 0 END,0))
       ,'reajuste_papel'            =   SUM(ISNULL(a.rsreajuste,0) + isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsreajuste_acum ELSE 0 END,0))
       ,'interes_pacto '            =   SUM(ISNULL(a.rsinteres,0)  + isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsinteres_acum  ELSE 0 END,0))
       ,'reajuste_pacto'            =   SUM(ISNULL(a.rsreajuste,0) + isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsreajuste_acum ELSE 0 END,0))
       ,'valor_cupon'               =   SUM(ISNULL(a.rsflujo,0)) -- valor total del cupon 
       ,'nominalpesos'              =   SUM(ISNULL(a.rscupint,0))-- interes cupon  
       ,'nominal'                   =   SUM(ISNULL(a.rscupamo,0))-- amortizacion cupon
       ,'valor_comprahis'           =   SUM(ISNULL(a.rscuprea,0))-- reajuste cupon  
       ,'dif_ant_pacto_pos'         =   SUM(ISNULL(a.premio   ,0))
       ,'dif_ant_pacto_neg'         =   SUM(ISNULL(a.descuento,0))
       ,'dif_valor_mercado_pos'     =   SUM(CONVERT(NUMERIC(15),0.0))
       ,'dif_valor_mercado_neg'     =   SUM(CONVERT(NUMERIC(15),0.0))
       ,'rev_valor_mercado_pos'     =   SUM(CONVERT(NUMERIC(15),0.0))
       ,'rev_valor_mercado_neg'     =   SUM(CONVERT(NUMERIC(15),0.0))
       ,'valor_futuro'              =   SUM(ISNULL(a.rsvppresenx,0))
       ,'Valor_perdida_usd'         =   SUM(CONVERT(NUMERIC(15),0.0))
       ,'Valor_utilidad_usd'        =   SUM(CONVERT(NUMERIC(15),0.0))
       ,'Valor_perdida_clp'         =   SUM(CONVERT(NUMERIC(15),0.0))
       ,'Valor_utilidad_clp'        =   SUM(CONVERT(NUMERIC(15),0.0)) 


       , 'A'
       , CASE   WHEN a.codigo_subproducto='IB' 
                THEN (CASE	WHEN a.rsinstser='ICAPX' THEN 'ICAP' 
				WHEN a.rsinstser='ICOLX' THEN 'ICOL' 
				ELSE a.rsinstser
				END)
                ELSE a.codigo_subproducto 
         END
       ,'codigo_evento'             =   (SELECT CASE when a.rscartera = '121' and a.rstipoper ='VC'then 'VEN' 
						     ELSE 'DEV' 
   end)
       ,'codigo_moneda1'            =   (SELECT CASE when a.rscartera = '111' then a.rsmonemi
				                     when a.rscartera = '112' then a.rsmonpact
                                                     when a.rscartera = '114' then a.rsmonemi
				                     when a.rscartera = '115' then a.rsmonpact
                                                     when a.rscartera = '121' then a.rsmonemi end)

       ,'codigo_moneda2'            =   (SELECT CASE when a.rscartera = '111' then a.rsmonemi
				                     when a.rscartera = '112' then a.rsmonpact
					             when a.rscartera = '114' then a.rsmonemi
				                     when a.rscartera = '115' then a.rsmonpact
                                                     when a.rscartera = '121' then a.rsmonemi end)

       ,'codigo_instrumento'        =   a.rscodigo
       ,'numero_operacion'          =   a.rsnumoper
       ,'numero_documento'          =   a.rsnumoper
       ,'correlativo'               =   a.rscorrela
       ,'forma_pago'		    =   0
       ,'rut'                       =   a.rsrutcli
       ,'codigo_operacion'          =   CASE WHEN a.rsmonemi = 13 THEN 'USD'
                                        ELSE ( SELECT TOP 1 LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.rsmonemi )
                                        END
       ,'mercado'                   =   c.clmercado
       ,'fecha_contable'            =   @fecha_hoy
       ,'DEV'
       ,min(a.rsfecha)
       ,a.rstipoper
       ,a.codigo_subproducto
       ,a.rscartera

   FROM	
	   RESULTADO_DEVENGO	  a,
	   VIEW_INSTRUMENTO	  b,
	   VIEW_CLIENTE	          c,
	   VIEW_EMISOR	          e,
           VIEW_PRODUCTO          p

   WHERE  (c.clrut           = a.rsrutcli 
     AND   c.clcodigo        = a.rscodcli)
     AND   a.rstipopero IN ('IB', 'LBC')
     AND   ( a.rsinstser  IN ('ICOLX') OR a.Codigo_Subproducto = 'LBC' )
     AND   e.emrut           = a.rsrutemis
     AND   b.incodigo        = a.rscodigo 
     AND   a.rstipoper       = 'DEV'
     AND   a.rsfecha >= @fecha_aux AND a.rsfecha < @fecha_Cierre
     AND   a.rstipopero      = @producto
     AND   p.codigo_producto = a.rstipopero
     AND   NOT (a.rstipopero IN ('LBC') AND a.rsfecvtop = @fecha_hoy )
     GROUP BY
              a.rscartera
            , a.rstipoper
            , a.rstipopero
            , a.rsmonpact
            , a.rsfecvtop 
            , a.rsfecinip 
            , a.rsrutcli 
            , a.rscodcli 
            , a.rsnumoper
            , c.clmercado
	    , a.codigo_subproducto
	    , a.RSCODIGO
	    , a.RSRUTEMIS
 	    , a.RSFECCOMP
            , a.Codigo_CarteraSuper
            , a.rsrutcart
            , a.RSMONEMI
	    ,a.rsinstser
	    ,a.rsnumdocu
	    ,a.rscorrela




/* ======================================================================================== 
   LLENA RENTA FIJA DEVENGO CARTERA PROPIA - INTERMEDIADA **************
  ======================================================================================== 
*/

	SELECT	*
	INTO	#TMP_RESULTADO_DEVENGO
	FROM	RESULTADO_DEVENGO
	WHERE	rsfecha >= @fecha_anterior
	AND	rsfecha < @fecha_Cierre


	-- Cuando existe 111 y 114(REPOS) del mismo documento
	UPDATE	A
	SET	a.codigo_subproducto	= b.codigo_subproducto	,
		a.rsrutcli		= b.rsrutcli		,
		a.rscodcli		= b.rscodcli		,
        	a.rscartera		= b.rscartera		,
        	a.rsmonpact		= b.rsmonpact		,
        	a.rsnumoper		= b.rsnumdocu		,
        	a.rsforpagi		= b.rsforpagi		,
        	a.rstipopero		= b.rstipopero		,
        	a.rsfeccomp		= b.rsfeccomp		,
		a.rsfecinip		= b.rsfecinip		
	FROM	#TMP_RESULTADO_DEVENGO	A,
		RESULTADO_DEVENGO	B
	WHERE	A.rscartera	= '114'
	AND	A.rsrutcli	= @rut_central
	AND	B.rsfecha	= a.rsfecha
	AND	B.rscartera	= '111'
	AND	B.rsnumdocu	= A.rsnumdocu
	AND	B.rscorrela	= A.rscorrela


	-- Cuando existe SOLO 114(REPOS)
	UPDATE	#TMP_RESULTADO_DEVENGO
	SET	rscartera	= '111',
        	rsnumoper	= rsnumdocu,
		codigo_subproducto = 'CP'
	WHERE	rscartera	= '114'
	AND	rsrutcli	= @rut_central



   INSERT INTO
   ##CONTABILIZA (
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
       ,forma_pago	
       ,rut
       ,codigo_operacion
       ,mercado
       ,fecha_contable
       ,archivo_proceso
       ,fecha_historica
       ,tipoper
       ,tipoperO
       ,cartera
       )
   SELECT
        'BTR'
        ,'codigo_producto'           =  (CASE WHEN a.codigo_subproducto IN('CI','CIX')      THEN 'CI'
				              WHEN a.codigo_subproducto IN('VI','VIX') and a.rsrutcli = @rut_central THEN 'REPO'                                             
    				        ELSE 
						(CASE
        	                                    WHEN A.RSCODIGO=20 AND A.RSRUTEMIS= @rut_entidad THEN 'LCHP'
                	                            WHEN A.RSCODIGO=20 AND A.RSRUTEMIS<>@rut_entidad THEN 'LCHT'
                        	                    WHEN A.RSCODIGO=15 AND A.RSRUTEMIS<>@rut_central THEN 'BONL'
                                	            WHEN A.RSCODIGO=15 AND A.RSRUTEMIS= @rut_central THEN 'SLSP'
				                    WHEN A.RSCODIGO=9  OR  A.RSCODIGO=11             THEN 'DPF'
                                        	    ELSE  ( SELECT INSERIE FROM VIEW_INSTRUMENTO WHERE INCODIGO = A.RSCODIGO )
	                                        END)
					END)
        ,( CASE WHEN DATEDIFF( DAY , (CASE WHEN a.rscartera = '112' THEN a.rsfecinip ELSE a.rsfeccomp END) , A.rsfecvcto ) <= 365 THEN 1 ELSE 2 END )
   ,'A' +   (CASE
                       WHEN A.Codigo_CarteraSuper = 'T' THEN 'T' --TRADING                     
                                 WHEN A.Codigo_CarteraSuper = 'P' THEN 'C' --PERMANENTE
                                 ELSE                                  '0' --INVEST
                            END) +'0'
        ,( CASE WHEN  rscartera IN ('111','114')
                THEN  (SELECT TOP 1 LEFT( ISNULL(Codigo_Calidad_Contable,'J00') ,1) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTEMIS AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )
                ELSE  (SELECT TOP 1 LEFT( ISNULL(Codigo_Calidad_Contable,'J00') ,1) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTCLI  AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )
           END
         )
        ,( CASE WHEN  rscartera IN ('111','114') 
                THEN  (SELECT TOP 1 RIGHT( ISNULL(Codigo_Calidad_Contable,'J00') ,2) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTEMIS AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )
                ELSE  (SELECT TOP 1 RIGHT( ISNULL(Codigo_Calidad_Contable,'J00') ,2) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTCLI  AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )
           END
         )
        ,CASE	WHEN a.rstipoper = 'VC' AND a.rsrutemis = @nrut_bcch   THEN 'B00'
		WHEN a.rstipoper = 'VC' AND a.rsrutemis<> @rut_entidad THEN ISNULL( (SELECT Codigo_Corresponsal_Contable FROM VIEW_CORRESPONSAL WHERE rut_cliente=a.rsrutcart AND codigo_cliente=1 AND @plaza=codigo_plaza AND defecto='S') , '')
		ELSE '   '
		END

        ,'V'
        ,'V'
        ,
          CASE   
                            WHEN A.RSMONEMI = 999 THEN '0'
                            WHEN A.RSMONEMI = 998 THEN '1'
                            WHEN A.RSMONEMI = 997 THEN '2'
                            ELSE '3'
             
          END
       ,(SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.RSMONEMI )
       
       ,CASE  WHEN A.RSMONEMI = 999 THEN '0' 
              WHEN A.RSMONEMI = 998 THEN '0' 
              WHEN A.RSMONEMI = 997 THEN '0' 
              WHEN A.RSMONEMI = 995 THEN '0' 
              WHEN A.RSMONEMI = 994 THEN '0' 
              ELSE '1'               
         END

--Valores a contabilizar

       ,'valor_compra'              =   SUM ( CASE WHEN  a.rstipoper = 'VC' THEN ISNULL(a.rsflujo,0) ELSE CONVERT(NUMERIC(15),0.0) END )
       ,'valor_presente'            =   SUM(isnull(a.rsinteres,0) + 
					isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsinteres_acum ELSE 0 END,0) + 
					isnull(a.rsreajuste,0) +
					isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsreajuste_acum ELSE 0 END,0) )
       ,'valor_venta'               =   SUM( isnull(a.rsvppresenx,0) )
       ,'utilidad'                  =   0
       ,'perdida'        =   0
       ,'interes_papel'             =   SUM( ISNULL(a.rsinteres,0)  + isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsinteres_acum  ELSE 0 END,0) )
       ,'reajuste_papel'            =   SUM( ISNULL(a.rsreajuste,0) + isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsreajuste_acum ELSE 0 END,0) )
       ,'interes_pacto '            =   SUM( ISNULL(a.rsinteres,0)  + isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsinteres_acum  ELSE 0 END,0) )
       ,'reajuste_pacto'            =   SUM( ISNULL(a.rsreajuste,0) + isnull(CASE WHEN rscartera IN(112,121) AND rstipoper = 'DEV' THEN a.rsreajuste_acum ELSE 0 END,0) )
       ,'valor_cupon'               =   SUM( ISNULL(a.rsflujo,0) )-- valor total del cupon 
       ,'nominalpesos'              =   SUM( ISNULL(a.rscupint,0) )-- interes cupon  
       ,'nominal'                   =   SUM( ISNULL(a.rscupamo,0) )-- amortizacion cupon
       ,'valor_comprahis'           =   SUM( ISNULL(a.rscuprea,0) )-- reajuste cupon  
      ,'dif_ant_pacto_pos'         =   SUM( ISNULL(a.descuento,0) )
       ,'dif_ant_pacto_neg'         =   SUM( ISNULL(a.premio,0) )
       ,'dif_valor_mercado_pos'     =   CONVERT(NUMERIC(15),0.0)
       ,'dif_valor_mercado_neg'     =   CONVERT(NUMERIC(15),0.0)
       ,'rev_valor_mercado_pos'     =   CONVERT(NUMERIC(15),0.0)
       ,'rev_valor_mercado_neg'     =   CONVERT(NUMERIC(15),0.0)
       ,'valor_futuro'              =   SUM( ISNULL(a.rsvppresenx,0) ) 
       ,'Valor_perdida_usd'         =   CONVERT(NUMERIC(15),0.0)
       ,'Valor_utilidad_usd'        =   CONVERT(NUMERIC(15),0.0)
       ,'Valor_perdida_clp'         =   CONVERT(NUMERIC(15),0.0)
       ,'Valor_utilidad_clp'        =   CONVERT(NUMERIC(15),0.0) 

--Valores Adicionales
       ,'A'
       , a.codigo_subproducto 
       ,'codigo_evento'             =   (SELECT CASE when rscartera = '111' and rstipoper ='VC'  then (CASE WHEN RSCODIGO=20 AND RSRUTEMIS=RSRUTCART 
                                                      THEN 'VCP' --VENCIMIENTO LETRAS PROPIA EMISION
                                                                                                            ELSE 'CC' 
                                                                                                       END)
                                                     when rscartera = '114' and rstipoper ='VC'  then 'CCI' 
                                                     when rscartera = '121' and rstipoper ='VC'  then 'VEN' else (CASE WHEN RSCODIGO=20 AND RSRUTEMIS=RSRUTCART AND a.codigo_subproducto NOT IN ('CI','CIX')
                                                                                                                       THEN 'DVP' --DEVENGO DE LETRAS PROPIA EMISION
                                                                                                                       ELSE 'DEV' 
                                                                                                                  END) 
                                                                                                    end)
       ,'codigo_moneda1'            =   (SELECT CASE when rscartera = '111' then rsmonemi
				                     when rscartera = '112' then rsmonemi
                                                     when rscartera = '114' then rsmonemi
				                     when rscartera = '115' then rsmonpact
                                                     when rscartera = '121' then rsmonemi end)

       ,'codigo_moneda2'            =   (SELECT CASE when rscartera = '111' then rsmonemi
				                     when rscartera = '112' then rsmonemi
					             when rscartera = '114' then rsmonemi
				                     when rscartera = '115' then rsmonpact
                                                     when rscartera = '121' then rsmonemi end)

       ,'codigo_instrumento'        =   a.rscodigo
       ,'numero_operacion'          =   (CASE WHEN a.codigo_subproducto IN ('CI','CIX') THEN a.rsnumdocu ELSE a.rsnumoper END )
       ,'numero_documento'          =   a.rsnumdocu
       ,'correlativo'               =   a.rscorrela
       ,'forma_pago'		    =   CASE WHEN a.rstipoper = 'VC' AND a.rsrutemis <> @rut_entidad THEN (CASE WHEN a.rsrutemis = @rut_central THEN 1 ELSE 2 END) ELSE 0 END
       ,'rut'                       =   a.rsrutcli
       ,'codigo_operacion'          =   CASE WHEN (SELECT CASE when rscartera = '111' then rsmonemi
				                     when rscartera = '112' then rsmonemi
					             when rscartera = '114' then rsmonemi
				                     when rscartera = '115' then rsmonpact
                                                     when rscartera = '121' then rsmonemi 
                                ELSE rsmonemi
                                end) = 13 
                    THEN 'USD'
                       ELSE      ( SELECT TOP 1 LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = 
                                                                (SELECT CASE when rscartera = '111' then rsmonemi
                				                     when rscartera = '112' then rsmonemi
                					             when rscartera = '114' then rsmonemi
                				                     when rscartera = '115' then rsmonpact
                                                                     when rscartera = '121' then rsmonemi 
                                                                     ELSE rsmonemi
                                                                end) )
                                        END
       ,'mercado'                   = c.clmercado
       ,'fecha_contable'            = @fecha_hoy
       ,'DEV'
       ,min(a.rsfecha)
       ,a.rstipoper
       ,a.codigo_subproducto
       ,a.rscartera
	FROM	#TMP_RESULTADO_DEVENGO	  a,
		VIEW_INSTRUMENTO	  b,
		VIEW_CLIENTE	        c,
		VIEW_EMISOR	          e,
		VIEW_PRODUCTO          p
	WHERE	(c.clrut           = a.rsrutcli 
	AND	c.clcodigo        = a.rscodcli)
	AND	e.emrut           = a.rsrutemis
	AND	b.incodigo        = a.rscodigo 
	AND	(a.rstipoper       = 'DEV'  OR  (a.rstipoper = 'VC' AND a.rscartera = '111'))
	AND	a.rsfecha >= @fecha_anterior AND a.rsfecha < @fecha_Cierre
	AND	a.rstipopero      = @producto
	AND	p.codigo_producto = a.rstipopero
	AND	a.rscartera       <> '115'
	AND	a.rscartera       <> '121'
	AND	NOT (a.rscartera = '114' AND a.codigo_subproducto  IN ('CI','CIX') )
	AND	NOT (a.rscartera = '112' AND a.rsfecvtop = @fecha_hoy )
	AND	NOT (a.rscartera = '111' AND a.codigo_subproducto = 'CFM' )
	GROUP
	BY	a.codigo_subproducto
		,a.rsrutcli
		,a.rscodigo 
		,a.rsrutemis
		,a.rsfecvcto
		,a.codigo_carterasuper
		,a.rscartera
		,a.rsmonpact
		,a.rsmonemi
		,a.rsinstser
		,a.rstipoper
		,a.rsrutcart
		,a.rsnumoper
		,a.rsnumdocu
		,a.rscorrela
		,a.rsforpagi
		,c.clmercado
		,a.rstipopero
		,a.rsfeccomp
		,a.rsfecinip


        UPDATE ##CONTABILIZA
        SET    utilidad = rsreajumes
        FROM   RESULTADO_DEVENGO
        WHERE  numero_operacion = rsnumdocu
        AND    numero_documento = rsnumdocu
        AND    correlativo      = rscorrela
        AND    cProducto        IN ('CI','CIX')
        AND    rscartera        = '112'
        AND    rstipoper        = 'DEV'
        AND    rsfecha         >= @fecha_aux
        AND    rsfecha         <  @fecha_Cierre


        UPDATE ##CONTABILIZA
        SET    perdida          = rsreajumes
        FROM   RESULTADO_DEVENGO
        WHERE  numero_operacion = rsnumdocu
        AND    numero_documento = rsnumdocu
        AND    correlativo      = rscorrela
        AND    cProducto        IN ('CI','CIX')
        AND    rscartera        = '114'
        AND    rstipoper        = 'DEV'
        AND    codigo_subproducto IN ('CI','CIX')
        AND    rsfecha         >= @fecha_aux
        AND    rsfecha         <  @fecha_Cierre


        
	IF @@ERROR <> 0
		BEGIN
		SET   @error = 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA ARCHIVO CONTABILIZA.'
		PRINT @error 
		RETURN 1
	END



-- ======================================================================================== 
-- LLENA DEVENGO FONDOS MUTUOS
-- ======================================================================================== 


   INSERT INTO
   ##CONTABILIZA (
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
       ,interes_papel

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
       ,forma_pago	
       ,rut
       ,codigo_operacion
       ,mercado
       ,fecha_contable
       ,archivo_proceso
       ,fecha_historica
       ,tipoper
       ,tipoperO
       ,cartera
       )
	SELECT
		'BTR'
		,'codigo_producto'           =  'CMF'
		,( CASE WHEN DATEDIFF( DAY , a.rsfeccomp , A.rsfecvcto ) <= 365 THEN 1 ELSE 2 END )
		,'A00'
		,(SELECT TOP 1 LEFT( ISNULL(Codigo_Calidad_Contable,'J00') ,1)  FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTCLI AND Cl.Clcodigo = RSCODCLI AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )
		,(SELECT TOP 1 RIGHT( ISNULL(Codigo_Calidad_Contable,'J00') ,2) FROM VIEW_CLIENTE CL , VIEW_CALIDAD_JURIDICA CA WHERE CL.CLRUT = RSRUTCLI AND Cl.Clcodigo = RSCODCLI AND CA.Codigo_Calidad = CL.Clcalidadjuridica  )
		,'   '
		,'V'
		,'V'
		,CASE	WHEN A.RSMONEMI = 999 THEN '0'
			WHEN A.RSMONEMI = 998 THEN '1'
			WHEN A.RSMONEMI = 997 THEN '2'
			ELSE '3'
			END
		,(SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = A.RSMONEMI )
		,CASE	WHEN A.RSMONEMI = 999 THEN '0' 
			WHEN A.RSMONEMI = 998 THEN '0' 
			WHEN A.RSMONEMI = 997 THEN '0' 
			WHEN A.RSMONEMI = 995 THEN '0' 
			WHEN A.RSMONEMI = 994 THEN '0' 
			ELSE '1'               
			END

		--Valores a contabilizar
		,'interes_papel'             =   SUM( ISNULL(a.rsinteres,0) )

		--Valores Adicionales
		,'A'
		,a.codigo_subproducto
		,'codigo_evento'             =   'DEV' 
		,'codigo_moneda1'            =   rsmonemi
		,'codigo_moneda2'            =   rsmonemi
		,'codigo_instrumento'        =   a.rscodigo
		,'numero_operacion'          =   a.rsnumdocu
		,'numero_documento'          =   a.rsnumdocu
		,'correlativo'               =   a.rscorrela
		,'forma_pago'		    =    0
		,'rut'                       =   a.rsrutcli
		,'codigo_operacion'          =   ( SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = rsmonemi ) 
		,'mercado'                   =	 c.clmercado
		,'fecha_contable'            =	 @fecha_hoy
		,'DEV'
		,min(a.rsfecha)
		,a.rstipoper
		,a.codigo_subproducto
		,a.rscartera
	FROM	#TMP_RESULTADO_DEVENGO	  a,
		VIEW_INSTRUMENTO	  b,
		VIEW_CLIENTE	          c,
		VIEW_PRODUCTO          p
	WHERE	c.clrut           = a.rsrutcli 
	AND	c.clcodigo        = a.rscodcli
	AND	b.incodigo        = a.rscodigo 
	AND	a.rstipoper       = 'DEV'
	AND	a.rsfecha	>= @fecha_anterior
	AND	a.rsfecha	< @fecha_Cierre
	AND	a.rstipopero      = @producto
	AND	p.codigo_producto = a.rstipopero
	AND	a.rscartera = '111' 
	AND 	a.codigo_subproducto = 'CFM'  
	GROUP
	BY	a.codigo_subproducto
		,a.rsrutcli
		,a.rscodcli
		,a.rscodigo 
		,a.rsrutemis
		,a.rsfecvcto
		,a.codigo_carterasuper
		,a.rscartera
		,a.rsmonpact
		,a.rsmonemi
		,a.rsinstser
		,a.rstipoper
		,a.rsrutcart
		,a.rsnumoper
		,a.rsnumdocu
		,a.rscorrela
		,a.rsforpagi
		,c.clmercado
		,a.rstipopero
		,a.rsfeccomp
		,a.rsfecinip

        
	IF @@ERROR <> 0
		BEGIN
		SET   @error = 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA ARCHIVO CONTABILIZA.'
		PRINT @error 
		RETURN 1
	END





-- ======================================================================================== 
-- llena renta tasa mercado
-- ======================================================================================== 


   IF @producto = 'MM'
   BEGIN
-- Contabilizacion al día de proceso.

	IF @fecha_Cierre > @fecha_hoy
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


   INSERT INTO 
   ##CONTABILIZA ( 
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
       ,forma_pago	
       ,rut
       ,codigo_operacion
       ,mercado
       ,fecha_contable
       ,archivo_proceso
       ,fecha_historica
       ,tipoper
       ,tipoperO
       ,cartera
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
                                 ELSE         '0' --INVEST
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

       ,'valor_compra'              =  CONVERT(NUMERIC(19),0.0)
       ,'valor_presente'            =  CONVERT(NUMERIC(19),0.0)
       ,'valor_venta'               =  CONVERT(NUMERIC(19),0.0)
       ,'utilidad'                  =  CONVERT(NUMERIC(19),0.0)
       ,'perdida'                   =  CONVERT(NUMERIC(19),0.0)
       ,'interes_papel'             =  CONVERT(NUMERIC(19),0.0)
       ,'reajuste_papel'            =  CONVERT(NUMERIC(19),0.0)
       ,'interes_pacto '            =  CONVERT(NUMERIC(19),0.0)
       ,'reajuste_pacto'            =  CONVERT(NUMERIC(19),0.0)
        ,'valor_cupon'              =  CONVERT(NUMERIC(19),0.0)
       ,'nominalpesos'              =  CONVERT(NUMERIC(19),0.0)
       ,'nominal'                   =  CONVERT(NUMERIC(19),0.0)
       ,'valor_comprahis'           =  CONVERT(NUMERIC(19),0.0)
       ,'dif_ant_pacto_pos'         =  CONVERT(NUMERIC(15),0.0) 
       ,'dif_ant_pacto_neg'         =  CONVERT(NUMERIC(15),0.0)
       ,'dif_valor_mercado_pos'     =  SUM( (CASE WHEN diferencia_mercado >= 0 THEN CASE WHEN mnextranj = '0' THEN ROUND(diferencia_mercado * @valor_observado,0) ELSE diferencia_mercado END      ELSE 0 END) )
       ,'dif_valor_mercado_neg'     =  SUM( (CASE WHEN diferencia_mercado <  0 THEN ABS(CASE WHEN mnextranj = '0' THEN ROUND(diferencia_mercado * @valor_observado,0) ELSE diferencia_mercado END ) ELSE 0 END) )
       ,'rev_valor_mercado_pos'     =  SUM( (CASE WHEN diferencia_mercado >= 0 THEN diferencia_mercado      ELSE 0 END) )
       ,'rev_valor_mercado_neg'     =  SUM( (CASE WHEN diferencia_mercado <  0 THEN ABS(diferencia_mercado) ELSE 0 END) )
       ,'valor_futuro'              =  CONVERT(NUMERIC(19),0.0)
       ,'Valor_perdida_usd'         =  SUM(CASE WHEN diferencia_mercado <  0 THEN ABS(diferencia_mercado) ELSE 0 END) / CASE WHEN mnextranj = '0' or a.moneda_emision = 999 THEN 1 ELSE (SELECT ISNULL(vmvalor,1) from VIEW_VALOR_MONEDA WHERE vmcodigo = a.moneda_emision AND vmfecha = @fecha_aux ) END
       ,'Valor_utilidad_usd'        =  SUM(CASE WHEN diferencia_mercado >= 0 THEN diferencia_mercado      ELSE 0 END) / CASE WHEN mnextranj = '0' or a.moneda_emision = 999 THEN 1 ELSE (SELECT ISNULL(vmvalor,1) from VIEW_VALOR_MONEDA WHERE vmcodigo = a.moneda_emision AND vmfecha = @fecha_aux ) END
       ,'Valor_perdida_clp'         =  SUM(CASE WHEN diferencia_mercado <  0 THEN ABS(diferencia_mercado) ELSE 0 END) / CASE WHEN mnextranj = '0' or a.moneda_emision = 999 THEN 1 ELSE ISNULL((SELECT vmvalor from VIEW_VALOR_MONEDA WHERE vmcodigo = a.moneda_emision AND vmfecha = @fecha_aux ),1) END
       ,'Valor_utilidad_clp'        =  SUM(CASE WHEN diferencia_mercado >= 0 THEN diferencia_mercado      ELSE 0 END) / CASE WHEN mnextranj = '0' or a.moneda_emision = 999 THEN 1 ELSE ISNULL((SELECT vmvalor from VIEW_VALOR_MONEDA WHERE vmcodigo = a.moneda_emision AND vmfecha = @fecha_aux ),1) END


--Valores Adicionales
       ,'A'    
       , a.tipo_operacion
       ,'codigo_evento'             =	CASE WHEN SUM( diferencia_mercado ) >= 0 AND a.instrumento NOT IN (37, 38, 39) THEN 'TMU'
					     WHEN SUM( diferencia_mercado ) <  0 AND a.instrumento NOT IN (37, 38, 39) THEN 'TMP'
					     WHEN SUM( diferencia_mercado ) >= 0 AND a.instrumento IN (37, 38, 39) THEN 'TXU'
                                             ELSE 'TXP'
                                        END
       ,'codigo_moneda1'    	    =   a.moneda_emision
       ,'codigo_moneda2'            =   a.moneda_emision
       ,'codigo_instrumento'        =   a.instrumento
       ,'numero_operacion'          =   a.numero_operacion
       ,'numero_documento'          =   a.numero_documento
       ,'correlativo'               =   a.correlativo
       ,'forma_pago'		    =   0 
       ,'rut'                       =   a.rut_emisor
       ,'codigo_operacion'          =   CASE WHEN a.moneda_emision = 13 THEN 'USD'
                                       	     ELSE ( SELECT TOP 1 LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.moneda_emision )
                                        END
       ,'mercado'                   =   c.clmercado
       ,'fecha_contable'            =   @fecha_hoy
       ,'VAL'
       ,a.fecha_valorizacion
       ,a.tipo_operacion
       ,'CP'
       ,'cartera'		    =  	(CASE WHEN a.tipo_operacion = 'CP' THEN '111' ELSE '114' END)

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
     AND   a.fecha_valorizacion = @fecha_aux
     AND   p.codigo_producto 	= a.tipo_operacion
     AND a.codigo_area        = ( SELECT ISNULL(codigo_area,'MNAC') FROM VIEW_AREA_PRODUCTO WHERE contabilidad_btr=1 )
     AND   a.id_sistema         = 'BTR'
     AND   NOT (b.incodigo      = 20 AND a.rut_emisor = a.rut_cartera)
     AND   mncodmon = a.moneda_emision
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
        SET   @error = 'ERROR_PROC FALLA ACTUALIZANDO TASA MERCADO RENTA FIJA ARCHIVO CONTABILIZA.'
        PRINT @error 
        RETURN 1
     END

   END



   SET NOCOUNT OFF

END

GO
