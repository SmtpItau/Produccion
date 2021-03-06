USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Llena_Contabiliza_BCC]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Llena_Contabiliza_BCC]
   (   @fecha_hoy       DATETIME
   ,   @fecha_anterior  DATETIME
   ,   @fecha_cierre    DATETIME
   ,   @producto        VARCHAR(5)
   ,   @error           VARCHAR(512) OUTPUT
   )
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
   DECLARE @rut_entidad      numeric(9)
   DECLARE @codigo_entidad   numeric(9)
   DECLARE @plaza            numeric(5)
   DECLARE @pais             numeric(5)

   SELECT  @rut_central     = 97029000
   SELECT  @valor_observado = 1.0
   SELECT  @valor_observado = isnull(vmvalor,0.0) from VIEW_VALOR_MONEDA  where vmcodigo = 994 and vmfecha = @fecha_hoy
   SELECT  @valor_uf        = isnull(vmvalor,0.0) from VIEW_VALOR_MONEDA  where vmcodigo = 998 and vmfecha = @fecha_hoy
   SELECT  @valor_ivp       = isnull(vmvalor,0.0) from VIEW_VALOR_MONEDA  where vmcodigo = 997 and vmfecha = @fecha_hoy
   SELECT  @rut_entidad     = (SELECT rut_entidad     FROM VIEW_DATOS_GENERALES WHERE codigo_entidad = 1)
   SELECT  @codigo_entidad  = (SELECT codigo_entidad  FROM VIEW_DATOS_GENERALES WHERE codigo_entidad = 1)
   
   SELECT  @pais            = (SELECT Codigo_Pais     FROM VIEW_DATOS_GENERALES WHERE Codigo_Entidad = 1)
   SELECT  @plaza           = (SELECT TOP 1 Codigo_Plaza    FROM VIEW_PLAZA WHERE CODIGO_PAIS = @pais)

   SELECT  @fecha_paso      = @fecha_hoy

   EXECUTE Sp_Diahabil @fecha_paso OUTPUT

   IF DATEDIFF(DAY, @fecha_hoy, @fecha_paso) <> 0
      SELECT @habil = 'N'
   ELSE
      SELECT @habil = 'S'



-- OPERACIONES DEL DIA que no correpondes a ( PTAS-EMPR por vcto de derivados )
-- *********************************************



   INSERT INTO ##CONTABILIZA
      (   id_sistema	            
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

      --   VALORES A CONTABILIZAR

      ,   valor_compra     
      ,   valor_presente   
      ,   valor_venta      
      ,   utilidad         
      ,   perdida          
      ,   interes_papel    
      ,   reajuste_papel   
      ,   interes_pacto    
      ,   reajuste_pacto   
      ,   valor_cupon      
      ,   nominalpesos     
      ,   nominal            
      ,   valor_comprahis    
      ,   dif_ant_pacto_pos  
      ,   dif_ant_pacto_neg  
      ,   dif_valor_mercado_pos 
      ,   dif_valor_mercado_neg 
      ,   rev_valor_mercado_pos 
      ,   rev_valor_mercado_neg 
      ,   valor_futuro        
      ,   Valor_perdida_usd     
      ,   Valor_utilidad_usd    
      ,   Valor_perdida_clp     
      ,   Valor_utilidad_clp    

      --  VALORES ADICIONALES

      ,   tipo_cuenta
      ,   cproductor
      ,   codigo_evento              
      ,   codigo_moneda1             
      ,   codigo_moneda2             
      ,   codigo_instrumento         
      ,   numero_operacion           
      ,   numero_documento           
      ,   correlativo                
      ,   forma_pago
      ,   rut
      ,   codigo_operacion
      ,   mercado
      ,   fecha_contable      
      ,   fecha_historica
      ,   tipoper
      ,   numero_SPOT
	)
   SELECT 'id_sistema'            = 'BCC'
      ,   'codigo_producto'       = CASE WHEN a.motipmer IN ('PTAS', 'EMPR' ,'CANJ') THEN 'PTAS' 
                                         WHEN a.motipmer = 'TRAN' THEN ''
                                         ELSE a.motipmer END
      ,   'tipo_plazo'            = 0
      ,   'financiamiento'        = CASE WHEN a.motipmer = 'OVER' THEN 'A00' ELSE SPACE(3) END--mocodmon --'ATE'
      ,   'codigo_sector'         = LEFT(j.codigo_calidad_contable, 1)
      ,   'codigo_subsector'      = RIGHT(j.codigo_calidad_contable, 2)
      ,   'banco_corresponsal'    = CASE WHEN A.Motipmer in('ARBI') 
				         THEN (CASE WHEN a.motipope = 'C'
	                                            THEN ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
        	                                         WHERE  rut_cliente    = @rut_entidad
                	                                 AND    codigo_cliente = @codigo_entidad
                        	                         AND    Codigo_Swift   = A.Swift_Recibimos
                                	                 AND    Codigo_Moneda  = (SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODMON = MNNEMO)
                                               	         AND    Codigo_Corresponsal_Contable <> ''
	                                                        ), '')
        	                                    ELSE ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                	                                 WHERE  rut_cliente    = @rut_entidad
                        	                         AND    codigo_cliente = @codigo_entidad
                                	                 AND    Codigo_Swift   = A.Swift_Corresponsal
                                                         AND    Codigo_Moneda  = (SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODmon = MNNEMO)
	                                                 AND    Codigo_Corresponsal_Contable <> ''
        	                                                ), '')
                	                      END)
                                         WHEN A.MOTIPMER IN ( 'TRAN' )
                                         THEN ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                                                         WHERE  rut_cliente    = @rut_entidad                                                                                 
                                                         AND    codigo_cliente = @codigo_entidad
--                                                       AND    Codigo_Swift   = A.Swift_Entregamos
                                                         AND    Codigo_Swift   = (CASE 
                                                                                      WHEN a.mocodoma = 343  THEN A.Swift_Recibimos
                                                                                      WHEN a.mocodoma = 123  THEN A.Swift_Entregamos
                                                                                      WHEN a.mocodoma = 341  THEN a.Swift_recibimos   --A.Swift_Entregamos
                                                                                      ELSE A.Swift_Recibimos
                                                                                 END)
                                                         AND    Codigo_Moneda  = (SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODMON = MNNEMO)
                                                         AND    Codigo_Corresponsal_Contable <> ''
                                                           ), '')
					 WHEN A.Motipmer in('EMPR') AND (SELECT TOP 1 FORMA_CENTRAL FROM VIEW_FORMA_DE_PAGO WHERE CODIGO=(CASE WHEN A.MOTIPOPE='C' THEN A.MORECIB ELSE A.MOENTRE END)  ) = 'S'
					 THEN ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
        	                                         					WHERE  rut_cliente    = @rut_entidad
                	                                 					AND    codigo_cliente = @codigo_entidad
							 					AND    Banco_Central  = 'S' ), '')

                                         ELSE ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                                                         WHERE  rut_cliente    = @rut_entidad
                                                         AND    codigo_cliente = @codigo_entidad
                                                         AND    Codigo_Swift   = (CASE WHEN a.motipope = 'C' THEN A.Swift_Recibimos ELSE A.Swift_Entregamos END)
							 AND    Codigo_Moneda  = (SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODMON = MNNEMO) AND    Codigo_Corresponsal_Contable <> ''
                                                           ), '')
                                    END

      ,   'status_cuota'          = 'V'
      ,   'status_colocacion'     = 'V'
      ,   'reajustabilidad'       = 0
      ,   'divisa'                = mocodmon
      ,   'tipo_divisa'           = '1'

      --   VALORES A CONTABILIZAR
      ,   'valor_compra'	= CASE	WHEN a.motipmer = 'ARBI'		THEN a.momonmo
					WHEN a.motipmer IN('EMPR','PTAS')
					THEN 	CASE	WHEN	(SELECT TOP 1 FORMA_CENTRAL
								FROM VIEW_FORMA_DE_PAGO
								WHERE CODIGO = (CASE WHEN A.MOTIPOPE='C' THEN A.MORECIB ELSE A.MOENTRE END)) = 'S' 
							THEN a.momonmo
							ELSE 0
							END
					ELSE a.momonmo
					END

      ,   'valor_presente'	= ROUND(a.momonpe,0) 
      ,   'valor_venta'		= CASE	WHEN a.motipmer = 'ARBI' and p.FORMA_CENTRAL = 'N' THEN 0
					WHEN a.motipmer = 'ARBI' and p.FORMA_CENTRAL = 'S' THEN a.momonmo
					WHEN a.motipmer = 'EMPR'
					THEN (CASE	WHEN (SELECT TOP 1 FORMA_CENTRAL FROM VIEW_FORMA_DE_PAGO WHERE CODIGO=(CASE WHEN A.MOTIPOPE='C' THEN A.MORECIB ELSE A.MOENTRE END)  ) = 'N'
							THEN 0
							ELSE a.momonmo
							END)
                                         ELSE a.momonmo 
                                         END

      ,   'utilidad'		= 0
      ,   'perdida'		= 0
      ,   'interes_papel'	= (a.mousstr - a.momonmo)
      ,   'reajuste_papel'	= 0
      ,   'interes_pacto'	= 0
      ,   'reajuste_pacto'	= 0
      ,   'valor_cupon'		= 0
      ,   'nominalpesos'	= 0
      ,   'nominal'		= CASE	WHEN a.motipmer = 'CANJ' THEN a.moussfi
					WHEN a.motipmer = 'ARBI' THEN 0
					WHEN a.motipmer = 'EMPR' THEN 0
					WHEN a.motipmer = 'INTM' THEN 0
					WHEN a.motipmer = 'OVER' THEN 0
					WHEN a.motipmer = 'PTAS' THEN 0
					WHEN a.motipmer = 'REVS' THEN 0
					WHEN a.motipmer = 'SINT' THEN 0
					WHEN a.motipmer = 'TRAN' THEN 0
					ELSE 0 
					END

      ,   'valor_comprahis'	  = 0
      ,   'dif_ant_pacto_pos'     = 0
      ,   'dif_ant_pacto_neg'     = 0
      ,   'dif_valor_mercado_pos' = CASE WHEN a.motipmer = 'CANJ' AND ROUND(a.momonpe - (a.momonmo * a.motctra), 0) < 0
                                         THEN ABS(ROUND(a.momonpe - ROUND(a.momonmo * a.motctra, 0) ,0)) ELSE 0
                                    END
      ,   'dif_valor_mercado_neg' = CASE WHEN a.motipmer = 'CANJ' AND ROUND( a.momonpe - (a.momonmo * a.motctra),0) >= 0
                                         THEN ABS(ROUND(a.momonpe - ROUND(a.momonmo * a.motctra, 0), 0)) ELSE 0
                                    END
      ,   'rev_valor_mercado_pos' = 0
      ,   'rev_valor_mercado_neg' = 0
      ,   'valor_futuro'          = 0
      ,   'valor_perdida_usd'     = 0
      ,   'valor_utilidad_usd'    = 0
      ,   'valor_perdida_clp'     = 0
      ,   'valor_utilidad_clp'    = 0

      --  VALORES ADICIONALES
  
      ,   'tipo_cuenta'           = CASE WHEN a.motipmer = 'PTAS' AND a.motipope = 'C' THEN 'A'
                                         WHEN a.motipmer = 'PTAS' AND a.motipope = 'V' THEN 'P'
                                         WHEN a.motipmer = 'EMPR' AND a.motipope = 'C' THEN 'A'
                                         WHEN a.motipmer = 'EMPR' AND a.motipope = 'V' THEN 'P'
                             		 WHEN a.motipmer = 'ARBI' AND a.motipope = 'C' THEN 'A'
                                         WHEN a.motipmer = 'ARBI' AND a.motipope = 'V' THEN 'P'
                                         WHEN a.motipmer = 'OVER'  THEN 'A'
                                         WHEN a.motipmer = 'TRAN'  THEN 'A'
                                         WHEN a.motipmer = 'LIQU'  THEN 'A'
					 WHEN a.motipmer = 'CANJ'  THEN 'A'
					END
      ,   'cproductor'            = CASE WHEN a.motipmer IN ('PTAS', 'CANJ') THEN 'PTAS' ELSE a.motipmer END
      ,   'codigo_evento'         = CASE WHEN a.motipmer = 'PTAS' AND a.motipope = 'C' THEN 'MCO'
					 WHEN a.motipmer = 'PTAS' AND a.motipope = 'V' THEN 'MVE'
                                         WHEN a.motipmer = 'EMPR' AND a.motipope = 'C' THEN 'MCO'
                                         WHEN a.motipmer = 'EMPR' AND a.motipope = 'V' THEN 'MVE'
                                         WHEN a.motipmer = 'ARBI' THEN (CASE WHEN a.motipope = 'C' and a.Monumfut <> 0 AND a.moterm in ('FORWARD','SWAP')	THEN 'MCD' 	-- ASIGNA EVENTO --LIQUIDACION DE DERIVADOS CDD
									     WHEN a.motipope = 'C' and c.Cltipcli = 1 and c.clMercado =  1			THEN 'MCN' 	-- ASIGNA EVENTO A BANCO NACIONAL   --ARBITRAJE SPOT
									     WHEN a.motipope = 'C' 								THEN 'MCO' 	-- ASIGNA EVENTO A OTROS CLIENTES --ARBITRAJE SPOT
                                                                             WHEN a.motipope = 'V' and a.Monumfut <> 0 AND a.moterm in ('FORWARD','SWAP') 	THEN 'MVD'	-- ASIGNA EVENTO --LIQUIDACION DE DERIVADOS VDD
                                                                             WHEN a.motipope = 'V' and c.Cltipcli = 1 and c.clMercado =  1 			THEN 'MVN' 	-- ASIGNA EVENTO A BANCO NACIONAL   --ARBITRAJE SPOT
                                                                             WHEN a.motipope = 'V' 								THEN 'MVE' 	-- ASIGNA EVENTO A OTROS CLIENTES --ARBITRAJE SPOT
                                                                        END)

                                         WHEN a.motipmer = 'OVER'  THEN 'MOV'
                                         WHEN a.motipmer = 'TRAN'  THEN (CASE
                                                                                WHEN A.MOCODOMA = 341 THEN 'MOV' --TRASPASO ENTRE CORRESPONSALES
                                                                                WHEN A.MOCODOMA = 343 THEN 'MTA' --TRASPASO DE FONDO [A    ] CUENTA DE ENCAJE
                                                                                WHEN A.MOCODOMA = 123 THEN 'MTD' --TRASPASO DE FONDO [DESDE] CUENTA DE ENCAJE
                                                                        END)
                                         WHEN a.motipmer = 'LIQU'  THEN 'MOV'
                                         WHEN a.motipmer = 'CANJ'  THEN 'MCO'
                                    END
      ,   'codigo_moneda1'        = CASE WHEN A.MOTIPMER = 'ARBI' 
                                         THEN  (CASE WHEN a.motipope = 'C' THEN  (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodCNV = LEFT(mnsimbol,3)) ELSE (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodMON = LEFT(mnsimbol,3)) END)
                                         ELSE (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodmon = LEFT(mnsimbol,3)) 
                                    END
      ,   'codigo_moneda2'        = CASE WHEN A.MOTIPMER = 'ARBI' 
                                         THEN  (CASE WHEN a.motipope = 'C' THEN  (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodCNV = LEFT(mnsimbol,3)) ELSE (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodMON = LEFT(mnsimbol,3)) END)
                                         ELSE (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodcnv = LEFT(mnsimbol,3)) 
                                    END
      ,   'codigo_instrumento'    = ''
      ,   'numero_operacion'      = a.monumope
      ,   'numero_documento'      = (CASE WHEN a.Monumfut <> 0 AND a.moterm in ('FORWARD','SWAP') THEN a.Monumfut ELSE a.monumope END)
      ,   'correlativo'           = 1
      ,   'forma_pago'            = 0
      ,   'rut'                   = a.morutcli
      ,   'codigo_operacion'      = CASE WHEN A.MOTIPMER = 'ARBI' 
                                         THEN a.mocodMON
                                         ELSE a.mocodmon
                                    END
      ,   'mercado'               = c.clmercado
      ,   'fecha_contable'        = @fecha_hoy
      ,   a.mofech
      ,   a.motipmer
      ,   a.monumope

   FROM   VIEW_MOVIMIENTO_CAMBIO  a
      ,   VIEW_CLIENTE            c
      ,   VIEW_CALIDAD_JURIDICA   j
      ,   VIEW_FORMA_DE_PAGO      p
   WHERE  a.mofech          =  @fecha_hoy 
     AND  a.moestatus       =  ' '
     AND  a.contabiliza     =  'S'
     AND  a.sintetico       <> 'S'
     AND  (a.morutcli       =  c.clrut
     AND   a.mocodcli       =  c.clcodigo)
     AND  a.motipmer        =  @producto
     AND  c.clcalidadjuridica = j.codigo_calidad
     AND  p.codigo          = a.moentre
     AND  NOT ( a.motipmer in('PTAS','EMPR') AND a.monumfut <> 0 AND a.moterm in ('FORWARD','SWAP') ) 






-- OPERACIONES DE VCTOS DE DERIVADOS (PTAS-EMPR)
-- *********************************************


   INSERT INTO ##CONTABILIZA
      (   id_sistema	            
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

      --   VALORES A CONTABILIZAR

      ,   valor_compra     
      ,   valor_presente   
      ,   valor_venta      
      ,   valor_comprahis    

      --  VALORES ADICIONALES

      ,   tipo_cuenta
      ,   cproductor
      ,   codigo_evento              
      ,   codigo_moneda1             
      ,   codigo_moneda2             
      ,   codigo_instrumento         
      ,   numero_operacion           
      ,   numero_documento           
      ,   correlativo                
      ,   forma_pago
      ,   rut
      ,   codigo_operacion
      ,   mercado
      ,   fecha_contable      
      ,   fecha_historica
      ,   tipoper
      ,   numero_SPOT
	)
   SELECT 'id_sistema'            = 'BCC'
      ,   'codigo_producto'       = CASE WHEN a.motipmer IN ('PTAS', 'EMPR' ,'CANJ') THEN 'PTAS' 
                                         WHEN a.motipmer = 'TRAN' THEN ''
                                         ELSE a.motipmer END
      ,   'tipo_plazo'            = 0
      ,   'financiamiento'        = CASE WHEN a.motipmer = 'OVER' THEN 'A00' ELSE SPACE(3) END--mocodmon --'ATE'
      ,   'codigo_sector'         = LEFT(j.codigo_calidad_contable, 1)
      ,   'codigo_subsector'      = RIGHT(j.codigo_calidad_contable, 2)
      ,   'banco_corresponsal'    = CASE WHEN A.Motipmer in('EMPR') AND (SELECT TOP 1 FORMA_CENTRAL FROM VIEW_FORMA_DE_PAGO WHERE CODIGO=(CASE WHEN A.MOTIPOPE='C' THEN A.MORECIB ELSE A.MOENTRE END)  ) = 'S'
					 THEN ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
        	                                         					WHERE  rut_cliente    = @rut_entidad
                	                                 					AND    codigo_cliente = @codigo_entidad
							 					AND    Banco_Central  = 'S' ), '')

                                         ELSE ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                                                         WHERE  rut_cliente    = @rut_entidad
                                                         AND    codigo_cliente = @codigo_entidad
                                                         AND    Codigo_Swift   = (CASE WHEN a.motipope = 'C' THEN A.Swift_Recibimos ELSE A.Swift_Entregamos END)
							 AND    Codigo_Moneda  = (SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODMON = MNNEMO) AND    Codigo_Corresponsal_Contable <> ''
                                                           ), '')
                                    END

      ,   'status_cuota'          = 'V'
      ,   'status_colocacion'     = 'V'
      ,   'reajustabilidad'       = 0
      ,   'divisa'                = mocodmon
      ,   'tipo_divisa'           = '1'


      --   VALORES A CONTABILIZAR

	-- ptas-empr cpa -> cuentas personales MX
	-- ptas-empr vta -> Valor Spot en MX, Contrapartida Cuentas Personales
      ,   'valor_compra'	= CASE	WHEN (	SELECT TOP 1 FORMA_CENTRAL
						FROM VIEW_FORMA_DE_PAGO
						WHERE CODIGO = (CASE WHEN A.MOTIPOPE='C' THEN A.MORECIB ELSE A.MOENTRE END)) = 'S' 
					THEN 	CASE 	WHEN a.motipmer = 'EMPR' THEN a.momonmo
							WHEN a.motipmer = 'PTAS' THEN Moussme
							END
					ELSE 0
					END

	-- ptas-empr cpa->  $$ spot
	-- ptas-empr vta->  Valor Spot en CLP, Contrapartida Cuentas Puente SPOT
      ,   'valor_presente'	= CASE	WHEN (	SELECT TOP 1 FORMA_CENTRAL
						FROM VIEW_FORMA_DE_PAGO
						WHERE CODIGO = (CASE WHEN A.MOTIPOPE='C' THEN A.MORECIB ELSE A.MOENTRE END)) = 'N' 
					THEN ROUND(a.momonpe,0) 
					ELSE 0
					END


	-- ptas-empr cpa -> divisas pendientes MX
	-- ptas-empr vta -> Valor Spot en MX, Contrapartida Divisas pendientes
      ,   'valor_venta'		= CASE	WHEN (	SELECT TOP 1 FORMA_CENTRAL
						FROM VIEW_FORMA_DE_PAGO
						WHERE CODIGO = (CASE WHEN A.MOTIPOPE='C' THEN A.MORECIB ELSE A.MOENTRE END)) = 'N' 
					THEN 	CASE 	WHEN a.motipmer = 'EMPR' THEN a.momonmo
							WHEN a.motipmer = 'PTAS' THEN Moussme
							END
					ELSE 0
					END


	-- ptas-empr cpa-> $$ cuentas personales
	-- ptas-empr vta-> Valor Spot en CLP, Contrapartida Cuentas Personales
      ,   'valor_comprahis'	= CASE	WHEN (	SELECT TOP 1 FORMA_CENTRAL
						FROM VIEW_FORMA_DE_PAGO
						WHERE CODIGO = (CASE WHEN A.MOTIPOPE='C' THEN A.MORECIB ELSE A.MOENTRE END)) = 'S' 
					THEN ROUND(a.momonpe,0) 
					ELSE 0
					END


      --  VALORES ADICIONALES
  
      ,   'tipo_cuenta'           = CASE WHEN a.motipmer = 'PTAS' AND a.motipope = 'C' THEN 'A'
                                         WHEN a.motipmer = 'PTAS' AND a.motipope = 'V' THEN 'P'
                                         WHEN a.motipmer = 'EMPR' AND a.motipope = 'C' THEN 'A'
                                         WHEN a.motipmer = 'EMPR' AND a.motipope = 'V' THEN 'P'
					END
      ,   'cproductor'            = a.motipmer
      ,   'codigo_evento'         = CASE WHEN a.motipmer = 'PTAS' AND a.motipope = 'C' AND monumfut <> 0 AND a.moterm in ('FORWARD','SWAP') THEN 'MCD'
                                         WHEN a.motipmer = 'PTAS' AND a.motipope = 'V' AND monumfut <> 0 AND a.moterm in ('FORWARD','SWAP') THEN 'MVD'
                                         WHEN a.motipmer = 'EMPR' AND a.motipope = 'C' AND monumfut <> 0 AND a.moterm in ('FORWARD','SWAP') THEN 'MCD'
                                         WHEN a.motipmer = 'EMPR' AND a.motipope = 'V' AND monumfut <> 0 AND a.moterm in ('FORWARD','SWAP') THEN 'MVD'
                                    END
      ,   'codigo_moneda1'        = (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodmon = LEFT(mnsimbol,3)) 
      ,   'codigo_moneda2'        = (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodcnv = LEFT(mnsimbol,3)) 
      ,   'codigo_instrumento'    = ''
      ,   'numero_operacion'      = a.monumope
      ,   'numero_documento'      = a.Monumfut
      ,   'correlativo'           = 1
      ,   'forma_pago'            = 0
      ,   'rut'                   = a.morutcli
      ,   'codigo_operacion'      = a.mocodmon
      ,   'mercado'               = c.clmercado
      ,   'fecha_contable'        = @fecha_hoy
      ,   a.mofech
      ,   a.motipmer
      ,   a.monumope

   FROM   VIEW_MOVIMIENTO_CAMBIO  a
      ,   VIEW_CLIENTE            c
      ,   VIEW_CALIDAD_JURIDICA   j
      ,   VIEW_FORMA_DE_PAGO      p
   WHERE  a.mofech          =  @fecha_hoy 
     AND  a.moestatus       =  ' '
     AND  a.contabiliza     =  'S'
     AND  a.sintetico       <> 'S'
     AND  (a.morutcli       =  c.clrut
     AND   a.mocodcli       =  c.clcodigo)
     AND  a.motipmer        =  @producto
     AND  c.clcalidadjuridica = j.codigo_calidad
     AND  p.codigo          = a.moentre
     AND  a.motipmer in('PTAS','EMPR')
     AND  a.monumfut <> 0
     AND  a.moterm in ('FORWARD','SWAP')





   IF @producto IN ('CANJ','ARBI','TRAN')
   BEGIN

      INSERT INTO ##CONTABILIZA
         (   id_sistema	            
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

         --   VALORES A CONTABILIZAR

         ,   valor_compra     
         ,   valor_presente   
         ,   valor_venta      
         ,   utilidad         
         ,   perdida          
         ,   interes_papel    
         ,   reajuste_papel   
         ,   interes_pacto    
 	 ,   reajuste_pacto   
  	 ,   valor_cupon      
         ,   nominalpesos     
         ,   nominal            
         ,   valor_comprahis    
         ,   dif_ant_pacto_pos  
         ,   dif_ant_pacto_neg  
         ,   dif_valor_mercado_pos 
         ,   dif_valor_mercado_neg 
         ,   rev_valor_mercado_pos 
         ,   rev_valor_mercado_neg 
         ,   valor_futuro        
         ,   Valor_perdida_usd     
         ,   Valor_utilidad_usd    
         ,   Valor_perdida_clp     
         ,   Valor_utilidad_clp    

         --  VALORES ADICIONALES

         ,   tipo_cuenta
         ,   cproductor
         ,   codigo_evento              
         ,   codigo_moneda1             
,   codigo_moneda2             
         ,   codigo_instrumento         
         ,   numero_operacion           
         ,   numero_documento           
  ,   correlativo                
,   forma_pago
	 ,   rut
         ,   codigo_operacion
         ,   mercado
         ,   fecha_contable
         ,   fecha_historica
         ,   tipoper
         ,   numero_SPOT

         )
      SELECT 'id_sistema'            = 'BCC'
         --,   'codigo_producto'       = a.motipmer
         ,   'codigo_producto'       = CASE WHEN a.motipmer = 'CANJ' THEN  'PTAS' 
                   WHEN a.motipmer = 'TRAN' THEN  '' 
                                            ELSE 'ARBI' 
                                       END
         ,   'tipo_plazo'            = 0
         ,   'financiamiento'        = SPACE(3) --mocodmon --'ATE'
         ,   'codigo_sector'         = LEFT(j.codigo_calidad_contable, 1)
         ,   'codigo_subsector'      = RIGHT(j.codigo_calidad_contable, 2)

-------------------------------------------------------
      ,   'banco_corresponsal'    = CASE WHEN A.Motipmer in('ARBI')
                                         THEN (CASE WHEN a.motipope = 'C'
                                                    THEN ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                                                         WHERE  rut_cliente    = @rut_entidad
                                                         AND    codigo_cliente = @codigo_entidad
                                                         AND    Codigo_Swift   = A.Swift_Corresponsal
                                                         AND    Codigo_Moneda  = (SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODCNV = MNNEMO)
                                                         AND    Codigo_Corresponsal_Contable <> ''
                                                           ), '')
                                                    ELSE ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                                                        WHERE  rut_cliente    = @rut_entidad
                                                         AND    codigo_cliente = @codigo_entidad
                                                         AND    Codigo_Swift   = A.Swift_Recibimos
                                                         AND    Codigo_Moneda  = (SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODCNV = MNNEMO)
                                                         AND    Codigo_Corresponsal_Contable <> ''
                                                           ), '')
                                              END)
                                         WHEN A.MOTIPMER IN ( 'TRAN' )
                                         THEN ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                                                         WHERE  rut_cliente    = (CASE 
                                                                                      WHEN a.mocodoma = 343  THEN @rut_central
                                                                                      ELSE @rut_entidad
                    END)
               AND    codigo_cliente = (CASE 
                                                                                      WHEN a.mocodoma = 343  THEN 1
                          ELSE @codigo_entidad
                                                                                 END)
                                                         AND    Codigo_Swift   = (CASE 
                                         WHEN a.mocodoma = 343  THEN a.Swift_corresponsal
                                                           ELSE A.Swift_Entregamos --a.Swift_recibimos
              END)
--                      AND    Codigo_Swift   = A.Swift_Recibimos
                                                      AND    Codigo_Moneda  = (SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODCNV = MNNEMO)
                                                         AND    Codigo_Corresponsal_Contable <> ''
                                                           ), '')
                                         ELSE ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                                             WHERE  rut_cliente   = @rut_entidad
                       AND    codigo_cliente = @codigo_entidad
                                                         AND    Codigo_Swift   = A.Swift_Entregamos
                                                         AND    Codigo_Moneda  = (SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODMON = MNNEMO)
                                                         AND    Codigo_Corresponsal_Contable <> ''
                                                           ), '')

                                            --ELSE    ISNULL((SELECT codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                                            --                WHERE  rut_cliente    = @rut_entidad
                                            --                  AND  codigo_cliente = @codigo_entidad
                                            --                  AND  codigo_plaza   = @plaza         
                                            --                  AND  codigo_pais    = @pais         
                                            --                  ), '')
                                    END
-------------------------------------------------------
         ,   'status_cuota'          = 'V'
         ,   'status_colocacion'     = 'V'
         ,   'reajustabilidad'       = 0
         ,   'divisa'                = CASE WHEN A.MOTIPMER = 'ARBI' THEN a.mocodCNV
					    WHEN A.MOTIPMER = 'CANJ' THEN a.mocodmon                                         
                                            ELSE a.mocodCNV
                                       END
         ,   'tipo_divisa'           = '1'

         --   VALORES A CONTABILIZAR

         ,   'valor_compra'          = CASE	WHEN a.motipmer = 'CANJ' THEN a.momonmo
						WHEN a.motipmer = 'ARBI' THEN a.moussme
--					 	WHEN a.motipmer = 'ARBI' and p.cc2756 = 'N' THEN a.moussme  -- SEGUN EL ALVARo SIEMRPE Se DEBE ENVIAR En ARBITRAJES
--					 	WHEN a.motipmer = 'ARBI' and p.cc2756 = 'S' THEN 0
						ELSE a.momonmo
						END
         ,   'valor_presente'        = CASE	WHEN a.motipmer = 'CANJ' THEN ROUND(a.momonmo * a.motctra,0)
						ELSE Round(a.momonpe,0)
                                            	END
         ,   'valor_venta'           = CASE 	WHEN a.motipmer = 'CANJ' THEN a.momonmo
						WHEN a.motipmer = 'ARBI' AND p.FORMA_CENTRAL = 'N'  THEN 0
						WHEN a.motipmer = 'ARBI' AND p.FORMA_CENTRAL = 'S'  THEN a.moussme
						ELSE a.moussme
						END
         ,   'utilidad'              = 0
         ,   'perdida'               = 0
         ,   'interes_papel'         = 0
         ,   'reajuste_papel'        = 0
   ,   'interes_pacto'         = 0
         ,   'reajuste_pacto'        = 0
         ,   'valor_cupon'           = 0
         ,   'nominalpesos'          = 0
         ,   'nominal'               = a.moussfi
         ,   'valor_comprahis'       = 0
         ,   'dif_ant_pacto_pos'     = 0
       ,   'dif_ant_pacto_neg'     = 0
         ,   'dif_valor_mercado_pos' = CASE WHEN ROUND(a.momonpe - (a.momonmo * a.motctra), 0) < 0
                                            THEN ABS(ROUND(a.momonpe - ROUND(a.momonmo * a.motctra, 0) ,0)) ELSE 0
                        END
         ,   'dif_valor_mercado_neg' = CASE WHEN ROUND( a.momonpe - (a.momonmo * a.motctra),0) >= 0
                                    THEN ABS(ROUND(a.momonpe - ROUND(a.momonmo * a.motctra, 0), 0)) ELSE 0
                                     END
         ,   'rev_valor_mercado_pos' = 0
     ,   'rev_valor_mercado_neg' = 0
         ,   'valor_futuro'          = 0
         ,   'valor_perdida_usd'     = 0
         ,   'valor_utilidad_usd'    = 0
         ,   'valor_perdida_clp'     = 0
         ,   'valor_utilidad_clp'    = 0

         --  VALORES ADICIONALES
  
         ,   'tipo_cuenta'           = CASE WHEN A.MOTIPMER = 'ARBI' THEN  (CASE WHEN a.motipope = 'C' THEN  'P' ELSE 'A' END)                                            
                                           ELSE 'P' END
         ,   'cproductor'            = CASE WHEN a.motipmer = 'CANJ' THEN  'PTAS' 
                                            WHEN a.motipmer = 'TRAN' THEN  'TRAN' 
                                            ELSE 'ARBI' 
                                       END

         ,   'codigo_evento'         = CASE WHEN a.motipmer = 'ARBI' THEN (CASE WHEN a.motipope = 'C' and a.Monumfut <> 0 AND a.moterm in ('FORWARD','SWAP')	THEN 'MVD' 	--ASIGNA EVENTO --LIQUIDACION DE DERIVADOS CDD
										WHEN a.motipope = 'C' and c.Cltipcli = 1 and c.clMercado =  1			THEN 'MVN' 	--ASIGNA EVENTO A BANCO NACIONAL   --ARBITRAJE SPOT
										WHEN a.motipope = 'C' 								THEN 'MVE' 	--ASIGNA EVENTO A OTROS CLIENTES --ARBITRAJE SPOT
                                                                                WHEN a.motipope = 'V' and a.Monumfut <> 0 AND a.moterm in ('FORWARD','SWAP')	THEN 'MCD' 	--ASIGNA EVENTO --LIQUIDACION DE DERIVADOS VDD
                                                                                WHEN a.motipope = 'V' and c.Cltipcli = 1 and c.clMercado =  1			THEN 'MCN' 	--ASIGNA EVENTO A BANCO NACIONAL   --ARBITRAJE SPOT
                                                                                WHEN a.motipope = 'V' 								THEN 'MCO' 	--ASIGNA EVENTO A OTROS CLIENTES --ARBITRAJE SPOT
                                                                           END)

                                            WHEN A.MOTIPMER = 'TRAN' THEN  'MOV'
                                            ELSE 'MVE' END
         ,   'codigo_moneda1'        = CASE WHEN A.MOTIPMER = 'ARBI' 
                                            THEN  (CASE WHEN a.motipope = 'C' THEN  (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodMON = LEFT(mnsimbol,3)) ELSE (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodCNV = LEFT(mnsimbol,3)) END)
                                            ELSE (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodmon = LEFT(mnsimbol,3)) END

         ,   'codigo_moneda2'        = CASE WHEN A.MOTIPMER = 'ARBI' 
                                            THEN  (CASE WHEN a.motipope = 'C' THEN  (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodMON = LEFT(mnsimbol,3)) ELSE (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodCNV = LEFT(mnsimbol,3)) END)
				            ELSE (SELECT mncodmon FROM VIEW_MONEDA WHERE a.mocodcnv = LEFT(mnsimbol,3)) END
         ,   'codigo_instrumento'    = ''
--       ,   'numero_operacion'      = a.monumope
--       ,   'numero_documento'      = a.monumope
         ,   'numero_operacion'      = a.monumope --(CASE WHEN a.Monumfut <> 0 AND a.moterm in ('FORWARD','SWAP')	THEN a.Monumfut ELSE a.monumope END)
         ,   'numero_documento'      = (CASE WHEN a.Monumfut <> 0 AND a.moterm in ('FORWARD','SWAP')	THEN a.Monumfut ELSE a.monumope END)

         ,   'correlativo'           = 1
         ,   'forma_pago'          = 0
         ,   'rut'                   = a.morutcli
         ,   'codigo_operacion'      =  CASE WHEN A.MOTIPMER = 'ARBI'                                                 
                                             THEN  a.mocodCNV
         --THEN  (CASE WHEN a.motipope = 'C' THEN  a.mocodMON ELSE a.mocodCNV END)
ELSE a.mocodmon END 
         ,   'mercado'               = c.clmercado
         ,   'fecha_contable'        = @fecha_hoy
         ,   a.mofech
         ,   a.motipmer
         ,   a.monumope

      FROM   VIEW_MOVIMIENTO_CAMBIO a
         ,   VIEW_CLIENTE           c
         ,   VIEW_CALIDAD_JURIDICA  j
         ,   VIEW_FORMA_DE_PAGO      p
      WHERE  a.mofech            =  @fecha_hoy 
        AND  a.moestatus         =  ' '
        AND  a.contabiliza       =  'S'
        AND  a.sintetico         <> 'S'
        AND  (a.morutcli         =  c.clrut
   AND   a.mocodcli         =  c.clcodigo)
        AND  a.motipmer        =  @producto
        AND  c.clcalidadjuridica = j.codigo_calidad
        AND  A.MOCODOMA = ( CASE WHEN A.MOTIPMER = 'TRAN' THEN 341 ELSE A.MOCODOMA END )
        AND  p.codigo            = a.morecib

   END


   INSERT INTO ##CONTABILIZA
      (   id_sistema
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

      --   VALORES A CONTABILIZAR

      ,   valor_compra     
      ,   valor_presente   
      ,   valor_venta      
      ,   utilidad         
      ,   perdida          
      ,   interes_papel    
      ,   reajuste_papel   
      ,   interes_pacto    
      ,   reajuste_pacto   
      ,   valor_cupon      
      ,   nominalpesos     
      ,   nominal            
      ,   valor_comprahis    
      ,   dif_ant_pacto_pos  
      ,   dif_ant_pacto_neg  
      ,   dif_valor_mercado_pos 
      ,   dif_valor_mercado_neg 
      ,   rev_valor_mercado_pos 
      ,   rev_valor_mercado_neg 
      ,   valor_futuro        
      ,   Valor_perdida_usd     
      ,   Valor_utilidad_usd    
      ,   Valor_perdida_clp     
      ,   Valor_utilidad_clp    

      --  VALORES ADICIONALES

      ,   tipo_cuenta
      ,   cproductor
      ,   codigo_evento              
      ,   codigo_moneda1             
      ,   codigo_moneda2             
      ,   codigo_instrumento         
      ,   numero_operacion           
      ,   numero_documento           
      ,   correlativo                
      ,   forma_pago
      ,   rut
      ,   codigo_operacion
      ,   mercado
      ,   fecha_contable
      ,   fecha_historica
      ,   tipoper
      ,   numero_SPOT

      )
   SELECT 'id_sistema'            = 'BCC'

      ,   'codigo_producto'       = CASE WHEN a.tipo_mercado IN ('PTAS', 'EMPR' ,'CANJ') THEN 'PTAS' 
                                         WHEN a.tipo_mercado = 'TRAN' THEN ''
                                         ELSE a.tipo_mercado END

      ,   'tipo_plazo'            = 0
      ,   'financiamiento'        = SPACE(3) --ISNULL((SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE mncodmon = Codigo_Moneda),'') --'ATE'
      ,   'codigo_sector'         = LEFT(j.codigo_calidad_contable, 1)
      ,   'codigo_subsector'      = RIGHT(j.codigo_calidad_contable, 2)
      ,   'banco_corresponsal'    = CASE WHEN a.tipo_mercado = 'ARBI'
                                         THEN (CASE WHEN A.Tipo_Operacion = 'C'
	                                            THEN ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
        	                                         WHERE  rut_cliente  = @rut_entidad
                	                                 AND    codigo_cliente = @codigo_entidad
                        	                         AND    Codigo_Swift   = S.Swift_Recibimos
                                	                 AND    Codigo_Moneda  = A.Codigo_Moneda --(SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODMON = MNNEMO)
                                               	         AND    Codigo_Corresponsal_Contable <> ''
	                                                        ), '')
        	                                    ELSE ISNULL((SELECT TOP 1 codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                	                                 WHERE  rut_cliente    = @rut_entidad
                        	                         AND    codigo_cliente = @codigo_entidad
                                	                 AND    Codigo_Swift   = S.Swift_Corresponsal
                                               AND    Codigo_Moneda  = A.Codigo_Moneda -- --(SELECT MNCODMON FROM VIEW_MONEDA WHERE a.MOCODMON = MNNEMO)
	                                                 AND    Codigo_Corresponsal_Contable <> ''
        	                                                ), '')
                	                      END)

					 ELSE 
						ISNULL((SELECT codigo_corresponsal_contable FROM VIEW_CORRESPONSAL
                                                      WHERE  rut_cliente    = @rut_entidad
                                                        AND  Codigo_cliente = @codigo_entidad
                                                        AND  Codigo_Moneda  = a.codigo_moneda
                                                        AND  Defecto        = 'S'
                                                      --AND  @plaza         = codigo_plaza
                                                      --AND  @pais          = codigo_pais
							), '')
				    END
      ,   'status_cuota'          = 'V'
      ,   'status_colocacion'     = 'V'
      ,   'reajustabilidad'       = 0
      ,   'divisa'                = (SELECT LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE a.codigo_moneda = mncodmon)
      ,   'tipo_divisa'           = '1'

      --   VALORES A CONTABILIZAR

      ,   'valor_compra'          = a.monto_original
      ,   'valor_presente'        = a.monto_pesos
      ,   'valor_venta'           = CASE WHEN a.tipo_mercado = 'ARBI' THEN a.monto_dolares
                                         WHEN a.tipo_mercado = 'CANJ' THEN a.monto_dolares
                                         WHEN a.tipo_mercado = 'EMPR' THEN a.monto_dolares
                                         WHEN a.tipo_mercado = 'INTM' THEN a.monto_dolares
                                         WHEN a.tipo_mercado = 'OVER' THEN a.monto_dolares
                                         WHEN a.tipo_mercado = 'PTAS' THEN a.monto_dolares
                                         WHEN a.tipo_mercado = 'REVS' THEN a.monto_dolares
                                         WHEN a.tipo_mercado = 'SINT' THEN a.monto_dolares
                                         WHEN a.tipo_mercado = 'TRAN' THEN a.monto_dolares
                                         ELSE a.monto_original
                                    END
      ,   'utilidad'              = 0
      ,   'perdida'               = 0
      ,   'interes_papel'         = 0
      ,   'reajuste_papel'        = 0
      ,   'interes_pacto'         = 0
      ,   'reajuste_pacto'        = 0
      ,   'valor_cupon'           = 0
      ,   'nominalpesos'          = CASE WHEN a.tipo_mercado = 'OVER' THEN ROUND(a.monto_final - a.monto_dolares,4)                         
                                         ELSE 0
                 END
      ,   'nominal'               = a.monto_pesos
      ,   'valor_comprahis'       = 0
      ,   'dif_ant_pacto_pos'     = 0
      ,   'dif_ant_pacto_neg'     = 0
      ,   'dif_valor_mercado_pos' = 0
      ,   'dif_valor_mercado_neg' = 0
      ,   'rev_valor_mercado_pos' = 0
      ,   'rev_valor_mercado_neg' = 0
      ,   'valor_futuro'          = 0
      ,   'valor_perdida_usd'     = 0
      ,   'valor_utilidad_usd'   = 0
      ,   'valor_perdida_clp'     = 0
      ,   'valor_utilidad_clp'    = 0

    --  VALORES ADICIONALES
  
      ,   'tipo_cuenta'           = CASE WHEN a.tipo_mercado = 'PTAS' AND a.tipo_operacion = 'C' THEN 'A'
                                         WHEN a.tipo_mercado = 'PTAS' AND a.tipo_operacion = 'V' THEN 'P'
                                         WHEN a.tipo_mercado = 'EMPR' AND a.tipo_operacion = 'C' THEN 'A'
                                         WHEN a.tipo_mercado = 'EMPR' AND a.tipo_operacion = 'V' THEN 'P'
                                         WHEN a.tipo_mercado = 'ARBI' AND a.tipo_operacion = 'C' THEN 'A'
                            WHEN a.tipo_mercado = 'ARBI' AND a.tipo_operacion = 'V' THEN 'P'
                                         WHEN a.tipo_mercado = 'CANJ' AND a.tipo_operacion = 'C' THEN 'A'
                                         WHEN a.tipo_mercado = 'CANJ' AND a.tipo_operacion = 'V' THEN 'P'
                                         --WHEN a.tipo_mercado = 'OVER'  THEN 'P'
                                         --WHEN a.tipo_mercado = 'TRAN'  THEN 'P'
                                         WHEN a.tipo_mercado = 'OVER'  THEN 'P'
                                         WHEN a.tipo_mercado = 'TRAN'  THEN 'P'
                                    END
      ,   'cproductor'            = CASE WHEN a.tipo_mercado IN ('PTAS', 'CANJ') THEN 'PTAS' ELSE a.tipo_mercado END
      ,   'codigo_evento'         = CASE 

                                         WHEN a.tipo_mercado = 'PTAS' AND a.tipo_operacion = 'C' and s.Monumfut <> 0 AND a.id_sistema <> 'BCC' THEN 'TCD'  -- Vencmiento Valuta Por Derivados 
                                         WHEN a.tipo_mercado = 'PTAS' AND a.tipo_operacion = 'V' and s.Monumfut <> 0 AND a.id_sistema <> 'BCC' THEN 'TVD'  -- Vencmiento Valuta Por Derivados 
                                         WHEN a.tipo_mercado = 'ARBI' AND a.tipo_operacion = 'C' and s.Monumfut <> 0 AND a.id_sistema <> 'BCC' THEN 'TCD'  -- Vencmiento Valuta Por Derivados 
                                         WHEN a.tipo_mercado = 'ARBI' AND a.tipo_operacion = 'V' and s.Monumfut <> 0 AND a.id_sistema <> 'BCC' THEN 'TVD'  -- Vencmiento Valuta Por Derivados 

                                         WHEN a.tipo_mercado = 'ARBI' AND a.tipo_operacion = 'C' THEN 'VCN'   -- Vencmiento Valuta Arbitrajes en SPOT (solo B.Nacional)
                                         WHEN a.tipo_mercado = 'ARBI' AND a.tipo_operacion = 'V' THEN 'VVN'   -- Vencmiento Valuta Arbitrajes en SPOT (solo B.Nacional)

					 WHEN a.tipo_mercado = 'PTAS' AND a.tipo_operacion = 'C' THEN 'VCO'
                                         WHEN a.tipo_mercado = 'PTAS' AND a.tipo_operacion = 'V' THEN 'VVE'

                                         WHEN a.tipo_mercado = 'EMPR' AND a.tipo_operacion = 'C' THEN 'VCO'
                                         WHEN a.tipo_mercado = 'EMPR' AND a.tipo_operacion = 'V' THEN 'VVE'


                                         WHEN a.tipo_mercado = 'CANJ' AND a.tipo_operacion = 'C' THEN 'VCO'
                                         WHEN a.tipo_mercado = 'CANJ' AND a.tipo_operacion = 'V' THEN 'VVE'
                                         WHEN a.tipo_mercado = 'OVER'  THEN 'VEN'
                                         WHEN a.tipo_mercado = 'TRAN'  THEN 'VEN'
      END
      ,   'codigo_moneda1'        = a.codigo_moneda
      ,   'codigo_moneda2'        = a.codigo_moneda
      ,   'codigo_instrumento'   = ''
      ,   'numero_operacion'      = a.numero_operacion --(CASE WHEN s.Monumfut <> 0 AND a.id_sistema <> 'BCC' THEN s.Monumfut ELSE a.numero_operacion END)
      ,   'numero_documento'      = (CASE WHEN s.Monumfut <> 0 AND a.id_sistema <> 'BCC' THEN s.Monumfut ELSE a.numero_operacion END)
      ,   'correlativo'           = 1
      ,   'forma_pago'            = 0
      ,   'rut'                   = a.Rut_Cliente
      ,   'codigo_operacion'      = (SELECT TOP 1 LEFT(mnsimbol,3) FROM VIEW_MONEDA WHERE MNCODMON = a.codigo_moneda)
      ,   'mercado'               = c.clmercado
      ,   'fecha_contable'        = @fecha_hoy
      ,   a.fecha_contable
      ,   A.Codigo_Producto
      ,   a.numero_operacion

   FROM   VIEW_TRANSFERENCIA_PENDIENTE a
      ,   VIEW_CLIENTE                 c
      ,   VIEW_CALIDAD_JURIDICA        j
      ,   VIEW_MOVIMIENTO_CAMBIO       S
   WHERE  
     (    ( a.fecha_contable  = @fecha_hoy AND A.Id_Sistema ='BCC' AND a.estado_transferencia = 'V')                                                   OR
--        ( a.fecha_contable  = @fecha_hoy AND A.Id_Sistema<>'BCC' AND A.Codigo_Producto <>'ARBI' AND a.estado_transferencia = 'V')                    OR
          ( a.fecha_contable  = @fecha_hoy AND A.Id_Sistema<>'BCC' AND c.Cltipcli = 1 and c.clMercado = 1 AND a.estado_transferencia = 'V' ) 		OR
          ( a.Fecha_Operacion = @fecha_hoy AND A.Id_Sistema<>'BCC' AND ( NOT (c.Cltipcli = 1 and c.clMercado = 1) ) AND a.estado_transferencia in ('P','V')))

     --AND  a.estado_transferencia = 'V'
     AND  (a.rut_cliente         = c.clrut
     AND  a.codigo_cliente       = c.clcodigo)
     AND  a.codigo_producto      = @producto
     AND  c.clcalidadjuridica    = j.codigo_calidad
     AND  NOT   A.Codigo_Producto IN( 'EMPR')
     AND  NOT ( A.Codigo_Producto IN( 'ARBI') AND A.Id_Sistema='BCC' AND c.Cltipcli <> 1 )
     AND  NOT ( A.Codigo_Producto IN( 'ARBI') AND A.Id_Sistema='BCC' AND c.Cltipcli = 1 and c.clMercado <> 1 )
     AND  s.monumope		= a.numero_operacion
     AND  s.moestatus 		<> 'A'

   IF @@ERROR <> 0
   BEGIN
      SET   @error = 'ERROR_PROC FALLA ACTUALIZANDO DEVENGAMIENTO RENTA FIJA ARCHIVO CONTABILIZA.'
      PRINT @error 
      RETURN 1
   END

   SET NOCOUNT OFF


END



GO
