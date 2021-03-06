USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GMOVTO3]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GMOVTO3]
               (
      @numope           numeric(7)
                        ,@tipmer           char(4)
                        ,@tipope           char(1)
                        ,@rutcli           numeric(9)
                        ,@codcli           numeric(9)
                        ,@nomcli           char(35)
                        ,@codmon           char(3)
                        ,@codcnv           char(3)
                        ,@monmo            numeric(19,4)
                        ,@ticam            numeric(19,4)
                        ,@tctra            numeric(19,4)
                        ,@parida           numeric(19,8)
                        ,@partr            numeric(19,8)
                        ,@ussme            numeric(19,4)
                        ,@usstr            numeric(19,4)
                        ,@monpe            numeric(19,4)
                        ,@entre            numeric(3)
                        ,@recib            numeric(3)
                        ,@oper             char(10)
                        ,@term             char(12)
                        ,@hora             char(8)
                        ,@fecha            datetime
                        ,@codoma           numeric(3) -- xxx
                        ,@estatus          char(1)
                        ,@codejec          numeric(6)
                        ,@valuta1          datetime   -- entregamos
                        ,@valuta2          datetime   -- recibimos
                        ,@rentab           numeric(3)
                        ,@linea            char(1)
   ,@entidad          numeric(3)
                        ,@precio           numeric(19,4) = 0
                        ,@pretra           numeric(19,4) = 0
                        ,@estado           numeric(1) = -1       -- para la captura automatica de fwd   
   ,@respon           char(3)
   ,@cotab            char(1)
   ,@observa          varchar(250)
   ,@swift_corrdonde  varchar(10)
   ,@swift_corrquien  varchar(10)
   ,@swift_corrdesde  varchar(10)
   ,@plaza_corrdonde  numeric(5)
   ,@plaza_corrquien  numeric(5)
   ,@plaza_corrdesde  numeric(5)
                        ,@fpagomxcli       numeric(5)    --14 Canjes
                        ,@fpagomncli       numeric(5)    --15 Canjes
                        ,@valuta3          datetime      --18 Canjes
                        ,@valuta4          datetime      --19 Canjes
                        ,@codigo_area      varchar(5)
                        ,@codigo_comercio  char(6)
                        ,@codigo_concepto  char(3)
                        ,@CASAMATRIZ       NUMERIC(3)    = 0
                        ,@MONTOFINAL       NUMERIC(19,4) = 0
                        ,@DIAS             NUMERIC(9)    = 0
                        ,@rutgir           NUMERIC(9)
                        
                      ) 
AS
BEGIN
SELECT @hora  =  CONVERT( CHAR(8), GETDATE() ,108 )
----<< Para Planillas Automaticas
SET NOCOUNT ON
/***
DECLARE @aux_xtotco     numeric(15,2) 
       ,@aux_xtotcop    numeric(15,2) 
       ,@aux_xpmeco     numeric(10,4) 
       ,@aux_xtotve     numeric(15,2) 
       ,@aux_xtotvep    numeric(15,2) 
       ,@aux_xpmeve     numeric(10,4) 
       ,@aux_xtotcore   numeric(19,4) 
       ,@aux_xtotcopre  numeric(19,4) 
       ,@aux_xpmecore   numeric(19,4) 
       ,@aux_xposic     numeric(15,2) 
       ,@aux_xpohedge   numeric(19,2) 
       ,@aux_xpohefut   numeric(19,4) 
       ,@aux_xpohespt   numeric(19,4) 
       ,@aux_xtotvere   numeric(19,4) 
       ,@aux_xtotvepre  numeric(19,4) 
       ,@aux_xpreini    numeric(10,4) 
       ,@aux_xPosini    numeric(15,2) 
       ,@aux_xprecie    numeric(10,4) 
       ,@aux_xutili     numeric(15,2) 
       ,@aux_xUticoCP   numeric(19,4) 
       ,@aux_xUtiveCP   numeric(19,4) 
       ,@aux_xtotvepcp  numeric(19,2)
       ,@aux_xtotcocp   numeric(19,4)
       ,@aux_xtotcopcp  numeric(19,2)
       ,@aux_xtotvecp   numeric(19,4)
       ,@aux_xpmecocpci numeric(15,4)
       ,@aux_xpmecocp   numeric(15,4)
       ,@aux_xpmevecpci numeric(15,4)
       ,@aux_xpmevecp   numeric(15,4)
       ,@aux_xPoHeFui   numeric(15,4)
       ,@aux_xPoHeSpi   numeric(19,4)
       ,@aux_xpmevere   numeric(19,4)
       ,@aux_xutilicp   numeric(9,2) 
       ,@valorRetorno   numeric(19,4) 
***/
DECLARE  @xpreini     Numeric(10,4) --ACPREINI
        ,@xposinic    Numeric(15,2) --ACPOSINI
        ,@xposic      Numeric(15,2) --ACPOSIC
        ,@xpmeco      Numeric(10,4) --ACPMECO
        ,@xpmeve      Numeric(10,4) --ACPMEVE
        ,@xtotco      Numeric(15,2) --ACTOTCO
        ,@xtotve      Numeric(15,2) --actotve
        ,@xtotcop     Numeric(15,2) --ACTOTCOPO
        ,@xtotvep     Numeric(15,2) --ACTOTVEPO
        ,@xpmecore    Numeric(19,4) --AC_PMECORE
        ,@xpmevere    Numeric(19,4) --AC_PMEVERE
        ,@xtotcore    Numeric(19,4) --AC_TOTCORE
        ,@xtotvere    Numeric(19,4) --AC_TOTVERE
        ,@xtotcopre   Numeric(19,4) --ACTOTCOPRE
        ,@xtotvepre   Numeric(19,4) --ACTOTVEPRE
        ,@xutili      Numeric(15,2) --ACUTILI
        ,@xprecie     Numeric(10,4) --ACPRECIE
        ,@xPrHeIni    Numeric(15,4) --ACHEDGEPRECIOINICIAL
        ,@xPoHeFui    Numeric(15,4) --ACHEDGEINICIALFUTURO
        ,@xPoHeSpi    Numeric(19,4) --ACHEDGEINICIALSPOT
        ,@xPoHeFut    Numeric(19,4) --ACHEDGEACTUALFUTURO
        ,@xPoHeSpt    Numeric(19,4) --ACHEDGEACTUALSPOT
        ,@xuhedge     Numeric(19,2) --ACHEDGEUTILIDAD
        ,@xtotcocp    Numeric(19,4) --CP_TOTCO
        ,@xtotvecp    Numeric(19,4) --CP_TOTVE
        ,@xtotcopcp   Numeric(19,2) --CP_TOTCOP
        ,@xtotvepcp   Numeric(19,2) --CP_TOTVEP
        ,@xutilicp    Numeric(19,2)  --CP_UTILI
        ,@xpmecocp    Numeric(15,4) --CP_PMECO
        ,@xpmevecp    Numeric(15,4) --CP_PMEVE
        ,@xpmecocpci  Numeric(15,4) --CP_PMECOCI
        ,@xpmevecpci  Numeric(15,4) --CP_PMEVECI
        ,@xuticocp    Numeric(15,2) --CP_UTICO
        ,@xutivecp    Numeric(15,2) --CP_UTIVE 
        ,@xpohedge    Numeric(19,2)
        ,@xPosini     Numeric(15,2) 
DECLARE  @planilla_numero NUMERIC(6)
        ,@planilla_fecha  DATETIME
        ,@rel_numero      NUMERIC(6)
        ,@rel_fecha       DATETIME
        ,@rel_arbitraje   CHAR(1)
        ,@moneda          NUMERIC(3)
        ,@rut             NUMERIC(9)
        ,@codcar          NUMERIC(10)
        ,@codtipocli      NUMERIC(5)
SELECT   @planilla_numero = 0
        ,@planilla_fecha  = ''
        ,@rel_numero      = 0
        ,@rel_fecha       = ''
        ,@rel_arbitraje   = ''
        ,@moneda          = 0
        ,@codtipocli      = 0
SELECT   @xpmeco        = 0
        ,@xpmeve        = 0
        ,@xtotco        = 0
        ,@xtotve        = 0
        ,@xtotcop       = 0
        ,@xtotvep       = 0
        ,@xpmecore      = 0
        ,@xpmevere      = 0
        ,@xtotcore      = 0
        ,@xtotvere      = 0
        ,@xtotcopre     = 0
        ,@xtotvepre     = 0
        ,@xutili        = 0
        ,@xprecie       = 0
        ,@xuhedge       = 0
        ,@xtotcocp      = 0
        ,@xtotvecp      = 0
        ,@xtotcopcp     = 0
        ,@xtotvepcp     = 0
        ,@xutilicp      = 0
        ,@xpmecocp      = 0
        ,@xpmevecp      = 0
        ,@xpmecocpci    = 0
        ,@xpmevecpci    = 0
        ,@xuticocp      = 0
        ,@xutivecp      = 0
 ,@xpreini       = 0
 ,@xposini       = 0
 ,@xposic        = 0
 ,@xPrHeIni      = 0
 ,@xPoHeFui      = 0
 ,@xPoHeSpi      = 0
 ,@xPoHeFut      = 0
 ,@xPoHeSpt      = 0
SELECT @estado = -1                -- PARA TODOS
BEGIN TRANSACTION   
IF @numope = 0
   IF @tipmer = 'EMPR'
      BEGIN
         UPDATE MEAC SET  accorempr = ( accorempr + 1 )
         SELECT @numope = ( SELECT accorempr  FROM MEAC )
      END
   ELSE
      BEGIN
         UPDATE MEAC SET  accorope = ( accorope + 1 )
         SELECT @numope = ( SELECT accorope  FROM MEAC )
      END
IF @tipmer = 'PTAS' --or @tipmer = 'EMPR' --or @tipmer = 'CANJ' 
BEGIN
     SELECT  @partr  = @parida
            ,@tctra  = @ticam
            ,@pretra = @precio
            ,@usstr  = @ussme
END
--------------------------<< Grabando Movimiento
IF EXISTS ( SELECT 1 FROM MEMO WHERE monumope = @numope )
   BEGIN
 DECLARE  @linetipo  CHAR(3)
 SELECT   @planilla_numero = planilla_numero
                ,@planilla_fecha  = planilla_fecha
                ,@rel_numero      = rel_numero
                ,@rel_fecha       = rel_fecha
                ,@rel_arbitraje   = rel_arbitraje
          FROM  VIEW_PLANILLA_SPT
         WHERE  operacion_numero  =   @numope 
         AND    operacion_fecha   =   @fecha
        UPDATE  MEMO
         SET    monumope           = @numope
               ,motipmer           = @tipmer
               ,motipope           = @tipope
               ,morutcli           = @rutcli
               ,mocodcli           = @codcli
               ,monomcli           = @nomcli
               ,mocodmon           = @codmon
               ,mocodcnv           = @codcnv
               ,momonmo            = @monmo
               ,moticam            = @ticam
               ,motctra            = @tctra
               ,moparme            = @parida
               ,mopartr            = @partr
               ,moussme            = @ussme
               ,mousstr            = @usstr
               ,momonpe            = @monpe
               ,moentre            = @entre
               ,morecib            = @recib
               ,mooper             = @oper
               ,moterm             = @term
               ,mohora             = @hora
               ,mofech             = @fecha
               ,mocodoma           = @codoma
               ,moestatus          = @estatus
               ,mocodejec          = @codejec
               ,movaluta1          = @valuta1
               ,movaluta2          = @valuta2     
               ,morentab           = @rentab
               ,moalinea           = @linea
               ,moentidad          = @entidad
               ,moprecio           = @precio
               ,mopretra           = @pretra
             ,id_sistema         = @respon
               ,contabiliza    = @cotab
        ,observacion    = @observa
        ,swift_corresponsal = @swift_corrdonde
        ,swift_recibimos    = @swift_corrquien
        ,swift_entregamos   = @swift_corrdesde
        ,plaza_corresponsal = @plaza_corrdonde
        ,plaza_recibimos    = @plaza_corrquien
        ,plaza_entregamos   = @plaza_corrdesde
               ,forma_pago_cli_nac = @fpagomxcli 
               ,forma_pago_cli_ext = @fpagomncli
               ,valuta_cli_nac     = @valuta3
               ,valuta_cli_ext     = @valuta4
               ,codigo_area        = @codigo_area 
               ,codigo_comercio    = @codigo_comercio  
               ,codigo_concepto    = @codigo_concepto  
               ,morutgir           = @rutgir
             
         WHERE monumope  = @numope
   END
ELSE
   BEGIN
        SELECT @linetipo = 'CAR'
        INSERT MEMO
             ( 
                monumope
               ,motipmer
               ,motipope
               ,morutcli
               ,mocodcli
               ,monomcli
               ,mocodmon
               ,mocodcnv
               ,momonmo
               ,moticam
               ,motctra
               ,moparme
               ,mopartr
               ,moussme
               ,mousstr
               ,momonpe
               ,moentre
               ,morecib
               ,mooper
               ,moterm
               ,mohora
               ,mofech
               ,mocodoma
               ,moestatus
               ,mocodejec
               ,movaluta1
               ,movaluta2
               ,morentab
               ,moalinea
               ,moentidad
               ,moprecio
               ,mopretra
               ,id_sistema
        ,contabiliza
        ,observacion
        ,swift_corresponsal
        ,swift_recibimos
        ,swift_entregamos
        ,plaza_corresponsal
        ,plaza_recibimos
        ,plaza_entregamos
               ,forma_pago_cli_nac
               ,forma_pago_cli_ext
               ,valuta_cli_nac
               ,valuta_cli_ext
               ,codigo_area
               ,codigo_comercio
               ,codigo_concepto
               ,morutgir
       )
       VALUES
               ( 
                  @numope
                 ,@tipmer
                 ,@tipope
                 ,@rutcli
                 ,@codcli
                 ,@nomcli
                 ,@codmon
                 ,@codcnv
                 ,@monmo
                 ,@ticam
                 ,@tctra
                 ,@parida
                 ,@partr
                 ,@ussme
                 ,@usstr
                 ,@monpe
                 ,@entre
                 ,@recib
                 ,@oper
                 ,@term
                 ,@hora
                 ,@fecha
                 ,@codoma
                 ,@estatus
                 ,@codejec
                 ,@valuta1
                 ,@valuta2
                 ,@rentab
                 ,@linea
                 ,@entidad
                 ,@precio
                 ,@pretra
   ,@respon
          ,@cotab
   ,@observa
   ,@swift_corrdonde
   ,@swift_corrquien
   ,@swift_corrdesde
   ,@plaza_corrdonde
    ,@plaza_corrquien
    ,@plaza_corrdesde
                 ,@fpagomxcli
                 ,@fpagomncli
                 ,@valuta3
                 ,@valuta4
                 ,@codigo_area
                 ,@codigo_comercio
                 ,@codigo_concepto
                 ,@rutgir
           
    )
        SELECT @rut    = (SELECT rcrut    FROM VIEW_ENTIDAD WHERE rccodcar = @entidad)
        SELECT @codcar = (SELECT rccodcar FROM VIEW_ENTIDAD WHERE rccodcar = @entidad)
        IF @tipmer = 'PTAS'
           BEGIN
              UPDATE meac SET acultpta = (CASE WHEN @tipope = 'C' THEN 'COMPRA A '+@nomcli+' '+@codmon
                                    ELSE 'VENTA A '+@nomcli+' '+@codmon
                                    END),
                           acultmon = @monmo,
                           acultpre = @ticam        
    
                WHERE  acrut    = @rut AND 
                       accodigo = @codcar
            END
         ELSE
           BEGIN
              UPDATE meac SET acultempr = (CASE WHEN @tipope = 'C' THEN 'COMPRA A '+@nomcli+' '+@codmon
                                    ELSE 'VENTA A '+@nomcli+' '+@codmon
                                    END),
                           acultmonempr = @monmo,
                           acultpreempr = @ticam        
    
                WHERE  acrut    = @rut AND 
                       accodigo = @codcar
            END
/***        IF @tipmer = 'PTAS'
           BEGIN
              UPDATE meac SET acultpta = (CASE WHEN @tipope = 'C' THEN 'COMPRA A '+@nomcli+' '+@codmon
                                          ELSE 'VENTA A '+@nomcli+' '+@codmon
                                          END),
                              acultmon = @monmo,
                              acultpre = @ticam        
    
              WHERE  acrut    = @rut AND 
                     accodigo = @codcar
           END
        ELSE
           BEGIN
              UPDATE meac SET acultempr     = (CASE WHEN @tipope = 'C' THEN 'COMPRA A '+@nomcli+' '+@codmon
                                               ELSE 'VENTA A '+@nomcli+' '+@codmon
                                               END),
                              acultmonempr  = @monmo,
                              acultpreempr  = @ticam        
    
              WHERE  acrut    = @rut AND 
                     accodigo = @codcar
           END
***/
   END
--------------------------<< Planilla Automatica
--SELECT * FROM MEAC
SELECT @moneda = 0
SELECT @moneda = ISNULL(mncodmon,0)
  FROM VIEW_MONEDA
 WHERE SUBSTRING(mnnemo,1,3) = @codmon
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-------------------------------------------<< Punta USD
IF (@tipmer = 'PTAS' OR @tipmer = 'CANJ' OR @tipmer = 'EMPR') AND @codmon = 'USD'
BEGIN
     SELECT @codtipocli = (SELECT cltipcli FROM view_cliente WHERE clrut=@rutcli)
     IF @moneda = 0
     BEGIN
          ROLLBACK TRANSACTION
          SELECT -1, 'ERROR : MONEDA ORIGINAL PARA PLANILLA AUTOMATICA NO FUE ENCONTRADA'
          SET NOCOUNT OFF
          RETURN 
     END
     IF @tipmer = 'CANJ'
     BEGIN 
        ---Compra de Dolares
        EXECUTE  @estado  = Sp_Graba_Planilla_Automatica  
    @entidad
  ,@tipmer
  ,'C'
  ,@fecha
  ,@numope
  ,@moneda
  ,@rutcli
  ,@codcli
  ,@monmo
  ,@parida
  ,@ussme
  ,@ticam
  ,@monpe
  ,0        -- derivados
                ,''       -- derivados
                ,''       -- derivados
                ,0        -- derivado
                ,0        -- derivados
  ,@entidad          -- relacion planilla
  ,@rel_fecha
  ,@rel_numero
  ,@rel_arbitraje
                ,@codigo_area
                ,@codigo_comercio
                ,@codigo_concepto
  ,@planilla_numero OUTPUT
  ,@planilla_fecha  OUTPUT 
               IF @estado <> 0
                  BEGIN
                  ROLLBACK TRANSACTION
                  SELECT -1, 'ERROR'
                  SET NOCOUNT OFF
                  RETURN 
               END
        ---Venta de Dolares
        EXECUTE  @estado  = Sp_Graba_Planilla_Automatica  
   @entidad
  ,@tipmer
  ,'V'
  ,@fecha
  ,@numope
  ,@moneda
  ,@rutcli
  ,@codcli
  ,@monmo
  ,@parida
  ,@ussme
  ,@ticam  ---CAmbia
  ,@monpe  ---Cambia
  ,0
                ,''
                ,''
                ,0
                ,0       -- derivados
  ,@entidad          -- relacion planilla
  ,@rel_fecha -- cambia
  ,@rel_numero
  ,@rel_arbitraje
                ,@codigo_area
                ,@codigo_comercio
                ,@codigo_concepto
  ,@planilla_numero OUTPUT
  ,@planilla_fecha  OUTPUT 
               IF @estado <> 0
                  BEGIN
                  ROLLBACK TRANSACTION
                  SELECT -1, 'ERROR'
                  SET NOCOUNT OFF
                  RETURN 
              END
        END
        ELSE IF @codtipocli > 0 AND @codtipocli < 4 BEGIN
             EXECUTE  @estado  = Sp_Graba_Planilla_Automatica  
                @entidad
       ,@tipmer
       ,@tipope
       ,@fecha
       ,@numope
       ,@moneda
       ,@rutcli
       ,@codcli
       ,@monmo
            ,@parida
       ,@ussme
       ,@ticam
       ,@monpe
       ,0
                     ,''                     
                     ,''
                     ,0
                     ,0                 -- derivados
       ,@entidad          -- relacion planilla
       ,@rel_fecha
       ,@rel_numero
       ,@rel_arbitraje
                     ,@codigo_area
                     ,@codigo_comercio
                     ,@codigo_concepto
       ,@planilla_numero OUTPUT
       ,@planilla_fecha  OUTPUT 
             IF @estado <> 0
             BEGIN
                ROLLBACK TRANSACTION
                SELECT -1, 'ERROR EN PLANILLA AUTOMATICA 1'
                SET NOCOUNT OFF
                RETURN 
             END
         END
END -- Planilla Automatica de PTAS / USD
-------------------------------------------<< Arbitrajes
IF @tipmer = 'ARBI'
BEGIN
     DECLARE  @parbcch numeric(19,8)
             ,@mtousd  numeric(19,8)
             ,@tc_bcch numeric(19,8)
             ,@cv_bcch CHAR(1)
     SELECT   @parbcch = 0
             ,@mtousd  = 0
             ,@tc_bcch = 0
             ,@cv_bcch = ''
     ---- Valida Paridad Mensual del BCCH
     SELECT  @parbcch = ISNULL(vmparmes,0) 
       FROM  VIEW_POSICION_SPT 
      WHERE  CONVERT( CHAR(8), vmfecha, 112) = CONVERT( CHAR(8), @fecha, 112)
        AND  vmcodigo = @codmon
     IF @parbcch = 0 OR @parbcch IS NULL
     BEGIN
          ROLLBACK TRANSACTION
   SELECT -1, 'ERROR : PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA DE ARBITRAJE'
          SET NOCOUNT OFF
          RETURN 
     END
     SELECT  @mtousd  = round( @monmo / @parbcch,2 )
     SELECT  @tc_bcch = round( @monpe / @mtousd ,4 )
     
      EXECUTE @estado = Sp_Graba_Planilla_Automatica
              @entidad
             ,@tipmer
             ,@tipope
             ,@fecha
             ,@numope
             ,@moneda
             ,@rutcli
             ,@codcli
             ,@monmo
             ,@parbcch
             ,@mtousd
             ,@tc_bcch
             ,@monpe
             ,0
             ,''
             ,''
             ,0
             ,0       -- derivados
             ,@entidad          -- relacion planilla
             ,@rel_fecha
             ,@rel_numero
             ,@rel_arbitraje         
             ,@codigo_area
             ,@codigo_comercio
             ,@codigo_concepto
             ,@planilla_numero OUTPUT
             ,@planilla_fecha  OUTPUT
     --select @estado
     IF @estado <> 0
     BEGIN
          ROLLBACK TRANSACTION
          SELECT -1, 'ERROR EN PLANILLA AUTOMATICA 2'
          SET NOCOUNT OFF
          RETURN 
     END
     
     SELECT @cv_bcch = (CASE @tipope WHEN 'C' THEN 'V' ELSE 'C' END)
     SELECT @moneda  = 0
     SELECT @moneda  = ISNULL(mncodmon,0)
            FROM VIEW_MONEDA
            WHERE SUBSTRING(mnnemo,1,3) = @codcnv
     IF @moneda = 0 OR  @moneda is NULL
     BEGIN
          ROLLBACK TRANSACTION
   SELECT -1,'ERROR : MONEDA CONVERSION PARA PLANILLA AUTOMTICA NO FUE ENCONTRADA'
          SET NOCOUNT OFF
          RETURN 
     END
     
     EXECUTE  @estado = Sp_Graba_Planilla_Automatica
              @entidad
             ,@tipmer 
             ,@cv_bcch
             ,@fecha  
             ,@numope 
             ,@moneda 
             ,@rutcli 
             ,@codcli 
             ,@ussme  
             ,1       
             ,@ussme  
             ,@ticam  
             ,@monpe  
             ,0
             ,''
             ,''
             ,0
             ,0       
             ,@entidad
             ,@planilla_fecha
             ,@planilla_numero
             ,'A'
             ,@codigo_area
             ,@codigo_comercio
             ,@codigo_concepto
             ,@rel_numero OUTPUT
             ,@rel_fecha  OUTPUT
     if @estado <> 0
    BEGIN
          ROLLBACK TRANSACTION
          SELECT -1 , 'ERROR EN PLANILLA AUTOMATICA 3'
          SET NOCOUNT OFF
          RETURN 
     END
     UPDATE VIEW_PLANILLA_SPT 
        SET rel_institucion    = entidad    
            ,rel_fecha         = @rel_fecha 
            ,rel_numero        = @rel_numero
            ,rel_arbitraje     = 'A'
      WHERE planilla_numero    = @planilla_numero
        AND CONVERT( CHAR(8), planilla_fecha, 112) = @planilla_fecha
     IF @@error <> 0
     BEGIN
          ROLLBACK TRANSACTION
          SELECT -1, 'ERROR : AL RELACIONAR PLANILLA AUTOMATICA POR ARBITRAJE'
          SET NOCOUNT OFF
          RETURN 
     END
END
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DECLARE @NUMERO_OPERACION  NUMERIC(9)
DECLARE @MONTO_ORIGEN      NUMERIC(19,4)  
SELECT  @NUMERO_OPERACION  = ( SELECT accorope FROM MEAC )
IF @tipmer = 'ARBI'
   BEGIN
   SELECT @MONTO_ORIGEN = @usstr
END ELSE 
   BEGIN
   SELECT @MONTO_ORIGEN = @ussme
END
/***
       EXECUTE  Sp_Transferencia_Pendiente
                @fecha
               ,@entre
               ,@recib
               ,'BCC'
               ,@tipmer
               ,@NUMERO_OPERACION
               ,@codmon
               ,@codcnv
               ,@MONTO_ORIGEN
               ,@monmo                   --@ussme
               ,@ticam
               ,@parida
               ,@rutcli
               ,@codcli
               ,@tipope
               ,@CASAMATRIZ
               ,@MONTOFINAL
               ,@DIAS
   SELECT @estado = 0   -- Indica a sp_CapturaForwards que grabo sin problemas
***/
       COMMIT TRANSACTION
      IF @tipmer = 'PTAS' OR @tipmer = 'EMPR'
         BEGIN
            EXECUTE Sp_Parametros_Actuales @tipmer
                                          ,@xpreini     out --ACPREINI
                                          ,@xposini     out --ACPOSINI
                                          ,@xposic      out --ACPOSIC
                                          ,@xpmeco      out --ACPMECO
                                          ,@xpmeve      out --ACPMEVE
                                          ,@xtotco      out --ACTOTCO
                                          ,@xtotve      out --actotve
                                          ,@xtotcop     out --ACTOTCOPO
         ,@xtotvep     out --ACTOTVEPO
                                          ,@xpmecore    out --AC_PMECORE
              ,@xpmevere    out --AC_PMEVERE
              ,@xtotcore    out --AC_TOTCORE
              ,@xtotvere    out --AC_TOTVERE
              ,@xtotcopre   out --ACTOTCOPRE
                    ,@xtotvepre   out --ACTOTVEPRE
              ,@xutili      out --ACUTILI
              ,@xprecie     out --ACPRECIE
                                          ,@xPrHeIni    out --ACHEDGEPRECIOINICIAL
              ,@xPoHeFui    out --ACHEDGEINICIALFUTURO
              ,@xPoHeSpi    out --ACHEDGEINICIALSPOT
              ,@xPoHeFut    out --ACHEDGEACTUALFUTURO
              ,@xPoHeSpt    out --ACHEDGEACTUALSPOT
              ,@xuhedge     out --ACHEDGEUTILIDAD
              ,@xtotcocp    out --CP_TOTCO
              ,@xtotvecp    out --CP_TOTVE
              ,@xtotcopcp   out --CP_TOTCOP
              ,@xtotvepcp   out --CP_TOTVEP
              ,@xutilicp    out --CP_UTILI
              ,@xpmecocp    out --CP_PMECO
              ,@xpmevecp    out --CP_PMEVE
              ,@xpmecocpci  out --CP_PMECOCI
              ,@xpmevecpci  out --CP_PMEVECI
              ,@xuticocp    out --CP_UTICO
              ,@xutivecp    out --CP_UTIVE
            SELECT @xpohedge = @xPoHeFut + @xPoHeSpt
            EXECUTE Sp_Func_MxRecalcPr @tipmer
                                         ,@tipope
                                         ,@ticam
                                         ,@ussme
      ,@xtotco     Out
                                         ,@xtotcop    Out
                                         ,@xpmeco     Out
                                         ,@xtotve     Out
                                         ,@xtotvep    Out
                                         ,@xpmeve     Out
                                         ,@xtotcore   Out
                                         ,@xtotcopre  Out
                                         ,@xpmecore   Out
                                         ,@xposic     Out
                                         ,@xpohedge   Out
                                         ,@xpohefut   Out
                                         ,@xpohespt   Out
                                         ,@xtotvere   Out
                                         ,@xtotvepre  Out
                                         ,@xpreini    Out
                                         ,@xPosini    Out
                                         ,@xprecie    Out
                                         ,@xutili     out
                                         ,@xprheini   out
            EXECUTE sp_Func_GrabaParam2 @tipmer    
                                       ,@xpreini    
                                       ,@xposinic   
                                       ,@xposic     
                                       ,@xpmeco     
                                       ,@xpmeve     
                                       ,@xtotco     
                                       ,@xtotve     
                                       ,@xtotcop    
               ,@xtotvep    
                                       ,@xpmecore   
           ,@xpmevere   
           ,@xtotcore   
           ,@xtotvere   
           ,@xtotcopre  
                 ,@xtotvepre  
           ,@xutili     
           ,@xprecie    
           ,@xPoHeFui   
           ,@xPoHeSpi   
           ,@xPoHeFut   
           ,@xPoHeSpt   
           ,@xuhedge    
            IF @tipmer = 'EMPR'
               BEGIN                  
                  EXECUTE Sp_Funcion_MxCalcVolCorp @tipope
                                                  ,@ticam
                                                  ,@ussme
                                                  ,@codmon
                                                  ,@codcnv
                                                  ,@tctra  --,@entidad
                  
                  EXECUTE Sp_MxCalcRenCorp @tipope
                                          ,@codmon
                                          ,@ticam
                                          ,@tctra
                                          ,@parida
                                          ,@partr
                                          ,@monmo
            
                                               -- ,@entidad
                                                  
               END
         END
      ELSE
         BEGIN
            EXECUTE Sp_Recalcmx @codmon
         END
    SET NOCOUNT ON 
    SELECT @numope , 'OK'
    SET NOCOUNT OFF
END
/***
SELECT * FROM MEMO
sp_gMovto 0,                --@numope           numeric(7)
          'PTAS',           --@tipmer           char(4)
          'C',              --@tipope           char(1) 
          97004000,         --@rutcli           numeric(9)
          1,                --@codcli           numeric(9)
          'BANCO DE CHILE', --@nomcli           char(35)
          'USD',            --@codmon           char(3)
          'CLP',            --@codcnv           char(3)
          1000000,          --@monmo            numeric(19,4)
          605,              --@ticam            numeric(19,4)
          605,              --@tctra            numeric(19,4)
          1,                --@parida           numeric(19,8)
          1,                --@partr            numeric(19,8)
          1000000,          --@ussme            numeric(19,4)
          1000000,          --@usstr            numeric(19,4)
          605000000,        --@monpe            numeric(19,4)
          5,                --@entre            numeric(2)
          106,              --@recib            numeric(2)
          'ADMINISTRA',     --@oper             char(10)
          'BAC0159_LABA',   --@term             char(12)
          '18991230',       --@hora             char(8)
          '20010523',       --@fecha            datetime
          220,              --@codoma           numeric(3) -- xxx
          ' ',              --@estatus          char(1)
          0,                --@codejec          numeric(6)
          '20010525',       --@valuta1          datetime   -- entregamos
          '20010528',       --@valuta2          datetime   -- recibimos
          0,                --@rentab           numeric(3)
          ' ',              --@linea            char(1)
          1,       --@entidad          numeric(3)
          605,              --@precio           numeric(19,4) = 0
          605,              --@pretra           numeric(19,4) = 0
          0,                --@estado           numeric(1) = -1       -- para la captura automatica de fwd   
          'BCC',     --@respon           char(3)
          'S',      --@cotab         char(1)
          '_',              --@observa          varchar(250)
          '',      --@swift_corrdonde  varchar(10)
          '',      --@swift_corrquien  varchar(10)
          '',      --@swift_corrdesde  varchar(10)
           0,       --@plaza_corrdonde  numeric(5)
           0,      --@plaza_corrquien  numeric(5)
           0,      --@plaza_corrdesde  numeric(5)
           0,               --@fpagomxcli       numeric(5)    --14 Canjes
           0,               --@fpagomncli       numeric(5)    --15 Canjes
          '',               --@valuta3          datetime      --18 Canjes
          '',               --@valuta4          datetime      --19 Canjes
          'EMPR',           --@codigo_area      varchar(5)
          '15122K',         --@codigo_comercio  char(6)
          '021',            --@codigo_concepto  char(3)
          0,                --@CASAMATRIZ       NUMERIC(3)    = 0
          0,                --@MONTOFINAL       NUMERIC(19,4) = 0
          0,                --@DIAS             NUMERIC(9)    = 0
          12345678                 --@rutgir           NUMERIC(9)                        
sp_GMovto3 0, 'PTAS', 'C', 97024000, 1, 'BANCO DE A.EDWARDS', 'USD', 'CLP', 1000000, 605, 605, 1, 1, 1000000, 1000000, 605000000, 5, 13, 'ADMINISTRA', 'BAC0159_LABA', '18991230', '20010523', 220, ' ', 0, '20010524', '20010525', 0, ' ', 1, 605, 605, 0, 'BCC', 'S', '_', '', '', '', 0, 0, 0, 0, 0, '', '', 'EMPR', '15122K', '021', 0, 0, 0, 0
***/

GO
