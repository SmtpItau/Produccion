USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Papeletavi]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Papeletavi]
   (   @xFecha         CHAR   (10)
   ,   @nRutcart       NUMERIC(09,00)
   ,   @nNumoper       NUMERIC (10,0)
   )
AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET DATEFIRST 1
   SET NOCOUNT ON

   DECLARE @Valor_Moneda_Vcto NUMERIC(21,4)
   DECLARE @Fecha_Vcto        DATETIME 
   DECLARE @fechaProceso      DATETIME
   DECLARE @TipoEvento        CHAR(10)

   DECLARE @Fecha_proceso         CHAR(10)
      ,    @Fecha_proxima         CHAR(10)
      ,    @uf_hoy            NUMERIC(21,04)
      ,    @uf_man            NUMERIC(21,04)
      ,    @ivp_hoy           NUMERIC(21,04)
      ,    @ivp_man           NUMERIC(21,04)
      ,    @do_hoy            NUMERIC(21,04)
      ,    @do_man            NUMERIC(21,04)
      ,    @da_hoy            NUMERIC(21,04)
      ,    @da_man            NUMERIC(21,04)
      ,    @Nombre_entidad         CHAR(40)
      ,    @rut_empresa       CHAR(12)
      ,    @hora              CHAR(08)
      ,    @fecha             DATETIME
      ,    @TotalPaginas      INTEGER
      ,    @tircompra2 	      NUMERIC(17,04)
      ,    @tipooper          CHAR(02)
      ,    @nDiaSem 	      INTEGER
      ,    @nDia  	      INTEGER
      ,    @nMes  	      INTEGER
      ,    @nAnn  	      INTEGER
      ,    @cFecEmi           VARCHAR(40)
      ,    @Forpac            VARCHAR(30)
      ,    @Forpav  	      VARCHAR(30)
      ,    @Tipocli 	      VARCHAR(25)
      ,    @Tipcli  	      NUMERIC(05,00)
      ,    @Cust  	      VARCHAR(01)
      ,    @Custodia 	      VARCHAR(25)
      ,    @Rutcli  	      NUMERIC(09,00)
      ,    @Dig  	      VARCHAR(01)
      ,    @Codcli 	      NUMERIC(09,00)
      ,    @Nomcli  	      VARCHAR(40)
      ,    @Dircli  	      VARCHAR(40)
      ,    @Foncli  	      VARCHAR(15)
      ,    @Faxcli  	      VARCHAR(15)
      ,    @Nomoper 	      VARCHAR(40)
      ,    @Ret               VARCHAR(01)
      ,    @Retiro  	      VARCHAR(15)
      ,    @Totalc  	      NUMERIC(19,04)
      ,    @Totalv  	      NUMERIC(19,04)
      ,    @Monpact 	      CHAR(05)
      ,    @monpacto	      NUMERIC (03,00)
      ,    @monglo  	      CHAR(20)
      ,    @Observ  	      CHAR(70)
      ,    @ValMon  	      NUMERIC(19,04)
      ,    @nValIniP	      NUMERIC(21,04)
      ,    @nValVenP 	      NUMERIC(21,04)
      ,    @nMtoVenta 	      NUMERIC(21,04)
      ,    @MtoEsc  	      VARCHAR(100)
      ,    @MtoRecompra       NUMERIC(21,04)
      ,    @cFecVen 	      VARCHAR(100)
      ,    @comcli  	      CHAR(20)
      ,    @Pagina  	      INTEGER
      ,    @nTotPagina 	      INTEGER
      ,    @contador 	      NUMERIC(19,00)
      ,    @contador2 	      NUMERIC(19,00)
      ,    @NumSol  	      NUMERIC(09,00)
      ,    @glocopia 	      CHAR(25)
      ,    @nCopia  	      INTEGER
      ,    @cSettlement       CHAR(50)
      ,    @cPFE  	      CHAR(50)
      ,    @cCCE  	      CHAR(50)
      ,    @cEmisorInstPlazo  CHAR(255)
      ,    @Valor_Moneda       NUMERIC(09,04)
      ,    @Valor_Moneda1      NUMERIC(09,04)
      ,    @cTipOper             CHAR(05)
      ,    @plazo                NUMERIC(05,00)
      ,    @nCodCli           NUMERIC(5)

   SELECT   @fecha      =  CONVERT(DATETIME,@xfecha,112)

   EXECUTE Sp_Base_Del_Informe
           @Fecha_proceso   OUTPUT  ,
           @Fecha_proxima   OUTPUT  ,
           @uf_hoy      OUTPUT  ,
           @uf_man      OUTPUT  ,
           @ivp_hoy     OUTPUT  ,
           @ivp_man     OUTPUT  ,
           @do_hoy      OUTPUT  ,
           @do_man      OUTPUT  ,
           @da_hoy      OUTPUT  ,
           @da_man      OUTPUT  ,
           @Nombre_entidad   OUTPUT  ,
           @rut_empresa OUTPUT  ,
           @hora        OUTPUT  ,
           @Fecha

   SELECT 'sector'        = 0
      ,   'oficina'       = 0
      ,   'centrocosto'   = 0
      ,   'Fecha_proceso'     = @Fecha_proceso
      ,   'Fecha_proxima'     = @Fecha_proxima
      ,   'uf_hoy'        = @uf_hoy
      ,   'uf_man'        = @uf_man

      ,   'ivp_hoy'       = @ivp_hoy
      ,   'ivp_man'       = @ivp_man
      ,   'do_hoy'        = @do_hoy
      ,   'do_man'        = @do_man
      ,   'da_hoy'        = @da_hoy
      ,   'da_man'        = @da_man
      ,   'FechaEmision'  = CONVERT(CHAR(10),GETDATE(),103)
      ,   'hora'          = @hora
   INTO #PARAMETROS
   FROM VIEW_DATOS_GENERALES

/* Empieza el rescate de información de tabla MOVIMIENTO_DIA_TRADER*/      


   SELECT @fecha         = CONVERT(DATETIME,@xfecha,112)
   SELECT @fechaProceso  = (SELECT Fecha_proceso FROM VIEW_DATOS_GENERALES)


   SELECT 
         mofecpro                    
   ,     morutcart   
   ,     motipcart 
   ,     monumdocu    
   ,     mocorrela 
   ,     monumdocuo   
   ,     mocorrelao 
   ,     monumoper    
   ,     motipoper 
   ,     motipopero 
   ,     moinstser    
   ,     momascara    
   ,     mocodigo 
   ,     moseriado 
   ,     mofecemi                    
   ,     mofecven                    
   ,     momonemi 
   ,     motasemi    
   ,     mobasemi 
   ,     morutemi    
   ,     monominal             
   ,     movpresen             
   ,     momtps                
   ,     momtum                                                
   ,     momtum100                                             
   ,     monumucup 
   ,     motir       
   ,     mopvp     
   ,     movpar                   
   ,     motasest    
   ,     mofecinip                   
   ,     mofecvenp                   
   ,     movalinip             
   ,     movalvenp             
   ,     motaspact   
   ,     mobaspact 
   ,     momonpact 
   ,     moforpagi 
   ,     moforpagv 
   ,     motipobono 
   ,     mocondpacto 
   ,     mopagohoy 
   ,     morutcli    
   ,     mocodcli    
   ,     motipret 
   ,     mohora          
   ,     mousuario       
   ,     moterminal      
   ,     mocapitali            
   ,     mointeresi            
   ,     moreajusti            
   ,     movpreseni            
   ,     mocapitalp            
   ,     mointeresp            
   ,     moreajustp            
   ,     movpresenp            
   ,     motasant              
   ,     mobasant              
   ,     movalant              
   ,     mostatreg 
   ,     movpressb             
   ,     modifsb               
   ,     monominalp            
   ,     movalcomp             
   ,     movalcomu             
   ,     mointeres             
   ,     moreajuste            
   ,     mointpac              
   ,     moreapac              
   ,     moutilidad            
   ,     moperdida             
   ,     movalven              
   ,     mocontador            
   ,     monsollin             
   ,     moobserv                                                               
   ,     moobserv2                                                              
   ,     movvista              
   ,     movviscom             
   ,     momtocomi             
   ,     mocorvent 
   ,     modcv 
   ,     moclave_dcv 
   ,     mocodexceso 
   ,     momtoPFE                                              
   ,     momtoCCE                                              
   ,     mointermesc           
   ,     moreajumesc           
   ,     mointermesvi          
   ,     moreajumesvi          
   ,     m.fecha_compra_original       
   ,     m.valor_compra_original 
   ,     m.valor_compra_um_original                              
   ,     m.tir_compra_original                      
   ,     m.valor_par_compra_original 
   ,     m.porcentaje_valor_par_compra_original 
   ,     m.codigo_carterasuper 
   ,     m.Tipo_Cartera_Financiera 
   ,     m.Mercado 
   ,     m.Sucursal 
   ,     m.Id_Sistema 
   ,     m.Fecha_PagoMañana            
   ,     m.Laminas 
   ,     m.Tipo_Inversion 
   ,     m.Cuenta_Corriente_Inicio 
   ,     m.Cuenta_Corriente_Final 
   ,     m.Sucursal_Inicio 
   ,     m.Sucursal_Final 
   ,     m.Estado_Control moimpreso
 
   INTO #MOVIMIENTOS
   FROM MOVIMIENTO_TRADER m WITH (NOLOCK)
   WHERE  monumoper = @nNumoper
     AND  morutcart = @nRutcart
     AND  (motipoper = 'VI' or motipoper = 'VIX' or motipoper = 'RP' or motipoper = 'FLP' or motipoper = 'VRP' or motipoper = 'VFL')
     AND  mofecpro  = @fecha
   ORDER BY mocorrela

   SELECT @tipooper=motipopero 
   FROM   #MOVIMIENTOS

   IF @tipooper = 'CP'
   BEGIN

      SELECT @tircompra2 = cptircomp
	  FROM   CARTERA_PROPIA WITH (NOLOCK), #MOVIMIENTOS
      WHERE  monumoper = @nNumoper 
        AND  monumdocu = cpnumdocu
        AND  mocorrela = cpcorrela

   END ELSE 
   BEGIN

      SELECT @tircompra2 = citircomp
      FROM   CARTERA_COMPRA_PACTO WITH (NOLOCK), #MOVIMIENTOS
      WHERE  monumoper = @nNumoper 
        AND  monumdocu = cinumdocu
        AND  mocorrela = cicorrela
   END

   SELECT @Totalc   = SUM(movalinip)
      ,   @Totalv   = SUM(movalvenp)
   FROM	  #MOVIMIENTOS
   
   SELECT @Monpact   = mnnemo
      ,   @Monpacto = momonpact
   FROM   VIEW_MONEDA
      ,   #MOVIMIENTOS
   WHERE  momonpact = mncodmon

   SELECT @monglo  = CASE WHEN @monpacto = 999 THEN 'PESOS'
                          WHEN @monpacto = 998 THEN 'UNIDADES DE FOMENTO'
                          WHEN @monpacto = 994 THEN 'DOLARES'
                          WHEN @monpacto = 995 THEN 'DOLARES'
                          WHEN @monpacto = 13  THEN 'DOLARES'  
                          ELSE 'MONEDA EXTRANJERA'
                     END
   
   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecinip)
      ,   @nDia	    = DATEPART(DAY,mofecinip)
      ,   @nMes	    = DATEPART(MONTH,mofecinip)
      ,   @nAnn	    = DATEPART(YEAR,mofecinip)
   FROM	  #MOVIMIENTOS

   SELECT @cFecEmi = CASE WHEN @nMes = 01 THEN CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 02 THEN CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 03 THEN CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 04 THEN CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 05 THEN CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 06 THEN CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 07 THEN CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 08 THEN CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 09 THEN CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 10 THEN CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 11 THEN CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 12 THEN CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)
                     END

   SELECT @cFecEmi = CASE WHEN @nDiaSem = 7 THEN 'Domingo '   + @cFecEmi
                          WHEN @nDiaSem = 1 THEN 'Lunes '     + @cFecEmi
                          WHEN @nDiaSem = 2 THEN 'Martes '    + @cFecEmi
                          WHEN @nDiaSem = 3 THEN 'Miercoles ' + @cFecEmi
                          WHEN @nDiaSem = 4 THEN 'Jueves '    + @cFecEmi
                          WHEN @nDiaSem = 5 THEN 'Viernes '   + @cFecEmi
                          WHEN @nDiaSem = 6 THEN 'Sabado '    + @cFecEmi
                     END

   SELECT @nDiaSem  = DATEPART(WEEKDAY,mofecvenp)
      ,   @nDia	    = DATEPART(DAY,mofecvenp)
      ,   @nMes	    = DATEPART(MONTH,mofecvenp)
      ,   @nAnn	    = DATEPART(YEAR,mofecvenp)
   FROM	  #MOVIMIENTOS

   SELECT @cFecVen = CASE WHEN @nMes = 01 THEN CONVERT(CHAR(2),@nDia) + ' de Enero de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 02 THEN CONVERT(CHAR(2),@nDia) + ' de Febrero de '    + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 03 THEN CONVERT(CHAR(2),@nDia) + ' de Marzo de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 04 THEN CONVERT(CHAR(2),@nDia) + ' de Abril de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 05 THEN CONVERT(CHAR(2),@nDia) + ' de Mayo de '       + CONVERT(CHAR(4),@nAnn)
  			  WHEN @nMes = 06 THEN CONVERT(CHAR(2),@nDia) + ' de Junio de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 07 THEN CONVERT(CHAR(2),@nDia) + ' de Julio de '      + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 08 THEN CONVERT(CHAR(2),@nDia) + ' de Agosto de '     + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 09 THEN CONVERT(CHAR(2),@nDia) + ' de Septiembre de ' + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 10 THEN CONVERT(CHAR(2),@nDia) + ' de Octubre de '    + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 11 THEN CONVERT(CHAR(2),@nDia) + ' de Noviembre de '  + CONVERT(CHAR(4),@nAnn)
                          WHEN @nMes = 12 THEN CONVERT(CHAR(2),@nDia) + ' de Diciembre de '  + CONVERT(CHAR(4),@nAnn)
                     END

   SELECT @cFecVen = CASE WHEN @nDiaSem = 7 THEN 'Domingo '   + @cFecVen
                          WHEN @nDiaSem = 1 THEN 'Lunes '     + @cFecVen
                          WHEN @nDiaSem = 2 THEN 'Martes '    + @cFecVen
                          WHEN @nDiaSem = 3 THEN 'Miercoles ' + @cFecVen
                          WHEN @nDiaSem = 4 THEN 'Jueves '    + @cFecVen
                          WHEN @nDiaSem = 5 THEN 'Viernes '   + @cFecVen
                          WHEN @nDiaSem = 6 THEN 'Sabado '    + @cFecVen
                     END

   SELECT @NumSol = monsollin
   FROM   #MOVIMIENTOS

   SELECT @Forpac = glosa 
   FROM   VIEW_FORMA_DE_PAGO, #MOVIMIENTOS
   WHERE  codigo = moforpagi --forma de pago inicial

   SELECT @Forpav = glosa 
   FROM   VIEW_FORMA_DE_PAGO, #MOVIMIENTOS
   WHERE  codigo = moforpagv  --forma de pago vcto.
  
   SELECT @Cust     = ISNULL(mocondpacto,' ')
      ,   @Observ   = ISNULL(moobserv,' ')
      ,   @Ret      = motipret
      ,   @nDiaSem  = DATEPART(WEEKDAY,mofecvenp)
      ,   @nDia     = DATEPART(DAY,mofecvenp)
      ,   @nMes     = DATEPART(MONTH,mofecvenp)
      ,   @nAnn     = DATEPART(YEAR,mofecvenp)
      ,   @Rutcli   = morutcli
      ,   @nCodCli  = mocodcli
      ,   @Nomoper  = mousuario
      ,   @Custodia = CASE WHEN laminas = 'L' THEN 'LAMINAS'
                           WHEN laminas = 'D' THEN 'DCV'
                           ELSE 'CERTIFICADO'
                      END
   FROM   #MOVIMIENTOS

 IF EXISTS(SELECT 1 FROM VIEW_CLIENTE WHERE clrut = @Rutcli AND clcodigo = @nCodCli)
   SELECT @Nomcli = clnombre  	, 
  	  @Dircli = cldirecc  	,
  	  @Foncli = clfono  	,
  	  @Faxcli = clfax   	,
  	  @Codcli = clcodigo  	,
  	  @Tipcli = cltipcli      ,
  	  @Dig    = ISNULL(cldv,' ')
   FROM VIEW_CLIENTE
   WHERE clrut    = @Rutcli
     AND clcodigo = @nCodCli
 ELSE
   SELECT @Nomcli = 'N/A'  	, 
  	  @Dircli = 'N/A'  	, 
  	  @Foncli = 0  	        , 
  	  @Faxcli = 0  	        , 
  	  @Codcli = 0  	        , 
  	  @Tipcli = 0  	        , 
  	  @Dig    = 'N/A'

   -- Se Cambio la Vista View_Ciudad_Comuna por la Vista View_Ciudad
   SELECT @comcli = ISNULL(nombre,' ')
   FROM   VIEW_CLIENTE
   ,      VIEW_CIUDAD
   WHERE  clrut    = @Rutcli
   AND    clcodigo = @nCodCli
   AND    clciudad = codigo_ciudad


   SELECT @Tipocli = ISNULL(descripcion ,' ')
   FROM   VIEW_TIPO_CLIENTE
   WHERE  CONVERT(INTEGER,codigo_tipo_cliente)=CONVERT(INTEGER,@Tipcli  ) 

   IF @Ret='V'
     SELECT @Retiro = 'Vamos'
   ELSE
     SELECT @Retiro = 'Vienen'

   SELECT @nMtoVenta   = ISNULL(SUM(mocapitali),0)
      ,   @MtoRecompra = ISNULL(SUM(movalvenp),0)
   FROM   #MOVIMIENTOS
  
    SELECT @ValMon = vmvalor
    FROM VIEW_VALOR_MONEDA, #MOVIMIENTOS
    WHERE vmcodigo=momonpact 
      AND vmfecha=mofecinip 

   IF @ValMon = NULL SELECT @ValMon = 1
    
   SELECT @Fecha_Vcto =  mofecvenp
   FROM   #MOVIMIENTOS

   SELECT @tipoevento ='INGRESO'

   SELECT @Fecha_Vcto = mofecvenp
/*      ,   @TipoEvento = CASE WHEN mofecvenp > @fecha THEN
                                CASE WHEN moforpagi IN(5,2,3)  THEN 'INGRESO'  --EFECTIVO / V.VISTA / CHEQUE
                                     WHEN moforpagi IN(4,15,7) THEN 'TRASPASO' --CTA.CTE / REM.SUCURSAL / CTA.CTE.BCCH
                                END
                             ELSE
                                CASE WHEN moforpagv = 2   THEN 'INGRESO'       --V.VISTA
                             WHEN moforpagv IN(4,15,7) THEN 'TRASPASO' --CTA.CTE / REM.SUCURSAL / CTA.CTE.BCCH
                          END
                        END*/
   FROM   #MOVIMIENTOS

   IF @@ROWCOUNT > 0 
   BEGIN

      EXECUTE Sp_Buscar_Valor_Moneda
          @Fecha_Vcto
      ,   @Valor_Moneda_Vcto  OUTPUT     --VALOR UF / OBSERVADO / ACUERDO / PESOS - DEPENDE DE LA MONEDA DEL PACTO
      ,   @Monpacto

      EXECUTE SP_MONTOESCRITO @nMtoVenta, @MtoEsc OUTPUT

   END




   /*======================================== MENSAJES LINEAS ==========================================*/


   DECLARE   @nNum_Opera   NUMERIC(9)
         ,   @cSistema     CHAR(3)
         ,   @cMargen_1    CHAR(100) 
         ,   @cMargen_2    CHAR(100) 
         ,   @cTraspaso_1  CHAR(100) 
         ,   @cTraspaso_2  CHAR(100) 
         ,   @cSobreGiro_1 CHAR(100) 
         ,   @cSobreGiro_2 CHAR(100) 


    SELECT   @cMargen_1    = ' '
         ,   @cMargen_2    = ' '
         ,   @cTraspaso_1  = ' '
         ,   @cTraspaso_2  = ' '
         ,   @cSobreGiro_1 = ' '
         ,   @cSobreGiro_2 = ' '

         ,   @cSistema     = 'BTR'
         ,   @nNum_Opera   = @nNumOper

   IF EXISTS ( SELECT 1 FROM #MOVIMIENTOS WHERE mofecpro = @fechaProceso  ) 
   BEGIN

       EXEC Sp_Papeletas_Mensajes_Lineas
                                        @nNum_Opera   
                                    ,   @cSistema     
                                    ,   @cMargen_1    OUTPUT
                                    ,   @cMargen_2    OUTPUT
                                    ,   @cTraspaso_1  OUTPUT
                                    ,   @cTraspaso_2  OUTPUT
                                    ,   @cSobreGiro_1 OUTPUT
                                    ,   @cSobreGiro_2 OUTPUT
   END 



   /*===================================================================================================*/


   SELECT 'TipoEvento'  = @TipoEvento
      ,   'nomemp' 	= ISNULL(Nombre_entidad,' ')
      ,   'rutemp'	= STR(Rut_entidad) + '-' + Digito_entidad
      ,   'fecpro'	= CONVERT(CHAR(10),mofecpro,103)
      ,   'fecemi' 	= ISNULL(@cFecEmi,' ')
      ,   'NumDocumento'      = CONVERT(CHAR(12),REPLICATE('0', 8 - LEN(LTRIM(STR(monumdocu)))) + LTRIM(STR(monumdocu)) + '-'
                              + REPLICATE('0', 3 - LEN(LTRIM(STR(mocorrela)))) + LTRIM(STR(mocorrela)))
      ,   'numoper'           = ISNULL(monumoper,0)
      ,   'totalV' 	= ISNULL(@TotalC,0)
      ,   'valorpar'	= ISNULL(movpar,0)     
      ,   'forpai' 	= ISNULL(@forpac,' ')
      ,   'totalc' 	= ISNULL(@TotalV,0)
      ,   'forpav' 	= ISNULL(@forpav,' ')
      ,   'tasapacto' 	= ISNULL(motaspact,0)
      ,   'base'  	= ISNULL(mobaspact,0)
      ,   'dias'  	= ISNULL(DATEDIFF(DAY,mofecinip,mofecvenp),0)
      ,   'fecini'      = ISNULL(CONVERT(CHAR(10),mofecinip,103),' ')
      ,   'fecven'	= ISNULL(CONVERT(CHAR(10),mofecvenp,103),' ')
      ,   'correla' 	= ISNULL(mocorrela,0)
      ,   'serie'  	= ISNULL(moinstser,' ')
      ,   'nominal' 	= ISNULL(monominal,0)
      ,   'tasa'  	= ISNULL(motir,0)
      ,   'tircompra'   = tir_compra_original   --ISNULL(@tircompra2,0)  
      ,   'total'  	= ISNULL(movpresen,0)
      ,   'custodia' 	= CASE 	WHEN motipoper = 'VFL' THEN 'DCV'
			  	ELSE CASE modcv WHEN  'C' THEN 'CLIENTE' WHEN 'P' THEN 'PROPIA' WHEN 'D' THEN 'DCV' ELSE 'PROPIA' END
				END
      ,   'CustodiaOper'= CASE 	WHEN motipoper = 'VFL' THEN 'DCV'
				ELSE @Custodia
				END
      ,   'tipcli' 	= ISNULL(@Tipocli,' ')
      ,   'tipcon' 	= ISNULL(@Retiro,' ')
      ,   'rut'  	= STR(@Rutcli) + '-' + @Dig
      ,   'rutempresa'  = Rut_entidad
      ,   'digempresa'  = Digito_entidad
      ,   'rutcliente'  = @Rutcli
      ,   'digcliente'  = @Dig
      ,   'codcli' 	= ISNULL(@Codcli,0)
      ,   'nomcli' 	= ISNULL(@Nomcli,' ')
      ,   'dircli' 	= ISNULL(@Dircli,' ')
      ,   'fono'  	= ISNULL(@Foncli,' ')
      ,   'faxcli' 	= ISNULL(@Faxcli,' ')
      ,   'observa' 	= ISNULL(@Observ,' ')
      ,   'nomope' 	= ISNULL(@Nomoper,' ')
      ,   'Emisor' 	= ISNULL(emgeneric,' ')
      ,   'Moneda' 	= ISNULL(a.mnnemo,' ')
  ,   'MonPact'	= ISNULL(@Monpact,' ')
      ,   'Fecha_Emi' 	= CONVERT(CHAR(10),mofecemi,103)
      ,   'Fecha_Ven' 	= CONVERT(CHAR(10),mofecven,103)
      ,   'ValInip' 	= ISNULL(movalinip,0)
      ,   'ValVen' 	= ISNULL(movalven,0)
      ,   'MtoInicio' 	= movalinip
      ,   'MtoEscrito' 	= @MtoEsc
      ,   'ValorFinal' 	= ISNULL(movalvenp,0)/*CASE momonpact WHEN 998 THEN movalvenp * @Valor_Moneda_Vcto
                                         WHEN 994 THEN ISNULL(movalvenp,0) * @Valor_Moneda_Vcto
                                    WHEN 995 THEN ISNULL(movalvenp,0) * @Valor_Moneda_Vcto
                                         ELSE ISNULL(movalvenp,0)
                          END*/
      ,   'Fec_Ven' 	= @cFecVen
      ,   'diremp' 	= ISNULL(Direccion_entidad,' ')
      ,   'comemp' 	= ISNULL(nombre,' ')
      ,   'comcli' 	= ISNULL(@monglo,' ')
      ,   'copia'  	= ISNULL(@glocopia,' ')
      ,   'Pagina' 	= 0
      ,   'contador' 	= ISNULL(mocorvent,0)
      ,   'numdocu' 	= ISNULL(monumoper,0)
      ,   'Lim_Settle' 	= @cSettlement
      ,   'Lim_PFE' 	= @cPFE
      ,   'clave_dcv' 	= moclave_dcv
      ,   'Lim_CCE' 	= @cCCE
      ,   'Tir_compra'	= ISNULL(tir_compra_original,0)
      ,   'ValorPte'  	= ISNULL(movpresenp,0)
      ,   'FechaCompra' = CONVERT(CHAR(10),fecha_compra_original,103)
      ,   'ValorVenta'  = ISNULL(movalvenp,0)
      ,   'Estado '	= CASE mostatreg WHEN 'A' THEN 'ANULADO' WHEN 'V' THEN 'VENCIMIENTO' ELSE ' ' END
      ,   'sucursalinicio'= CASE moforpagi WHEN 15 THEN ISNULL((SELECT nombre FROM VIEW_SUCURSAL WHERE sucursal_inicio = codigo_sucursal),' ')
                                                 WHEN 4  THEN cuenta_corriente_inicio
                                                 ELSE ' '
                          END
      ,   'sucursalfinal' = CASE moforpagv WHEN 15 THEN ISNULL((SELECT nombre FROM VIEW_SUCURSAL WHERE sucursal_final  = codigo_sucursal),' ')
                                                 WHEN 4  THEN cuenta_corriente_final
                                                 ELSE ' '
                          END
      ,   'NumReg'        = IDENTITY(INT)
      ,   'Corte'         = CONVERT(INTEGER,0)
      ,   'HoraOperacion' = SUBSTRING(mohora,1,8)
      ,   'pvp'           = mopvp

      ,   'cMargen_1'          = @cMargen_1    
      ,   'cMargen_2'          = @cMargen_2    
      ,   'cTraspaso_1'        = @cTraspaso_1  
      ,   'cTraspaso_2'        = @cTraspaso_2  
      ,   'cSobreGiro_1'       = @cSobreGiro_1 
      ,   'cSobreGiro_2'       = @cSobreGiro_2 
      ,   'tipo'               = motipoper
      ,   'dcv'			= CASE modcv  WHEN 'P' THEN 'PROPIA' WHEN 'C' THEN 'CLIENTE' WHEN 'D' THEN 'DCV' ELSE ' ' END

      ,   'Tipo_moneda'        = a.mnextranj  
      ,   b.mnredondeo	
      ,   'TITULO'	  = CASE WHEN 	motipoper = 'VI' OR motipoper = 'VIX' THEN 'VENTA CON PACTO'
					ELSE 	(select descripcion from view_producto where Codigo_Producto = motipoper)
				 END
   INTO   #TEMP
   FROM   #MOVIMIENTOS
      ,   VIEW_EMISOR
      ,   VIEW_MONEDA a
      ,   VIEW_DATOS_GENERALES
      ,	  VIEW_COMUNA	
      ,   VIEW_MONEDA b	
   WHERE morutemi *= emrut 
     AND momonemi *= a.mncodmon
     AND momonpact *= b.mncodmon    	
     AND codigo_comuna =* Comuna_entidad 
     AND Codigo_ciudad =* Ciudad_entidad
   ORDER BY mofecven,moinstser,mocorrela


   SELECT @TotalPaginas = CASE WHEN (@@ROWCOUNT % 15) = 0 THEN @@ROWCOUNT / 15 ELSE (@@ROWCOUNT / 15) + 1 END
   UPDATE #TEMP SET Corte = CASE WHEN (NumReg % 15) = 0 THEN NumReg / 15 ELSE (NumReg / 15) + 1 END

   SELECT *
      ,   'TotalPag' = @TotalPaginas
   FROM   #TEMP
      ,   #PARAMETROS

   SET NOCOUNT OFF

END

GO
