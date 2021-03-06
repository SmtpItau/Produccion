USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CLGRABAR1]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CLGRABAR1] (  
    @clrut                      NUMERIC(09, 0),  
    @cldv                       CHAR(01),  
    @clcodigo                   NUMERIC(09, 0),  
    @clnombre                   CHAR(70),  
    @clgeneric                  CHAR(05),  
    @cldirecc                   CHAR(40),  
    @clcomuna                   NUMERIC(8),  
    @clregion                   NUMERIC(5),  
    @cltipcli                   NUMERIC(5),  
    @clfecingr                  DATETIME,  
    @clctacte                   CHAR(15),  
    @clfono                     CHAR(20),  
    @clfax                      CHAR(20),  
    @clapelpa                   CHAR(20),  
    @clapelma                   CHAR(20),  
    @clnomb1                    CHAR(15),  
    @clnomb2                    CHAR(15),  
    @clapoderado                CHAR(40),  
    @clciudad                   NUMERIC(8),  
    @clmercado                  NUMERIC(5),  
    @clgrupo                    NUMERIC(5),  
    @clpais                     NUMERIC(5),  
    @clcalidad                  NUMERIC(5),  
    @cltipoml                   NUMERIC(5),  
    @cltipomx                   NUMERIC(5),  
    @clbanca                    NUMERIC(5),  
    @clrelac                    CHAR(20),  
    @clnumero                   NUMERIC(3),  
    @clcomex                    CHAR(20),  
    @clchips                    CHAR(20),  
    @claba                      CHAR(20),  
    @clswift                    CHAR(20),  
    @clnfm                      NUMERIC(3),  
    @clfmutuo                   CHAR(20),  
    @clfeculti                  DATETIME,  
    @clejecuti                  NUMERIC(4),  
    @clentidad                  NUMERIC(5),  
    @clgraba                    CHAR(20),  
    @clcompint                  NUMERIC(3),  
    @clcalle                    CHAR(30),  
    @clctausd                   CHAR(20),  
    @clcaljur                   CHAR(20),  
    @clnemo                     CHAR(20),  
    @climplic                   CHAR(20),  
    @clopcion                   CHAR(2),  
    @clrelaciongb               NUMERIC(2),  
    @clcatego                   NUMERIC(2),  
    @clsector                   NUMERIC(3),  
    @clclsbif                   CHAR(5), --> CHAR(2)          
    @clactivida                 NUMERIC(3),  
    @cltipemp                   CHAR(2),  
    @clrelbco                   NUMERIC(2),  
    @clpoder                    CHAR(2),  
    @clfirma                    CHAR(2),  
    @clfeca85                   DATETIME,  
    @clrelcia                   NUMERIC(2),  
    @clrelcor                   NUMERIC(2),  
    @clinfosoc                  CHAR(2),  
    @clart85                    CHAR(2),  
    @rut_grupo                  NUMERIC(10),  
    @clcodinst                  NUMERIC(3),  
    @clcodban                   NUMERIC(5),  
    @cloficinas                 CHAR(1),  
    @clcriesgo                  CHAR(10),  
    @codigo_otc                 CHAR(10),  
    @bloqueado                  CHAR(1),  
    @clcosto                    NUMERIC(5),  
    @codigo_contable            NUMERIC(3),  
    @clrutcliexterno            NUMERIC(9),  
    @cldvcliexterno             CHAR(1),  
    @clbrokers                  CHAR(1),  
    @ReceptorRutBco             NUMERIC(10) = 0,  
    @ReceptorCodBco             NUMERIC(10) = 0,  
    @clCondicionesGenerales     CHAR(01) = 'N',  
    @clFechaFirma_cond          CHAR(08) = '19000101',  
    @nombre_notaria             VARCHAR(50),  
    @fecha_escritura            DATETIME,  
    @CompBilateral              CHAR(1) = 'N',  
    @nuevoccgfirm               VARCHAR(1) = 'N', -- Ultimos Parametros Contratos Derivados 05-11-2009          
    @vercontratoccg             NUMERIC(2) = 0,  
    @fechafirmccg               DATETIME = '19000101',  
    @clausularetroact           CHAR(1) = 'N',  
    @MotivoBloqueo              VARCHAR(2000) = '', --> PRD-3826, 05-02-2010          
    @SegComercial               CHAR(6) = '',  
    @EjecutivoCom               VARCHAR(40) = '',  
    @GarantiaTotal              NUMERIC(14) = 0,  
    @EstadoCliente              CHAR(1) = 'S',  
    @GarantiaEfectiva           NUMERIC(18, 0) = 0,  
    @ClRecMtdCod                NUMERIC(5) = 0, --PRD-8800        
    @dFechaCGPactos             DATETIME = '19000101',  
    @ComDer                     CHAR(1), --> PRD-19121  
    @FechaContratoComder        DATETIME, --> PRD-19121 V1    
    @mail                       VARCHAR(100),  
    @ClasificaDecimal   CHAR(1) = 'N', --> PRD-21639  
    @CantidadDecimal   NUMERIC(1,0) = 0 --> PRD-21639  
 -- Datos para Fusión  
   ,  @Secuencia NUMERIC(9,0)  
   ,  @CodAS400 NUMERIC(7)  
   ,  @CodCGI  CHAR(7)  
---------------------------------------------------------------------------------  
-------------------------------INICIO FUSÍON-------------------------------------  
-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------  
---------------------------------------------------------------------------------  
   ,@ClCodEmpRelacionada NUMERIC (5)  
   ,@ClCod_contra   NUMERIC (5)  
   ,@ClCodEmp_cen   NUMERIC (5)  
   ,@CNPJ     CHAR (20)  
---------------------------------------------------------------------------------  
-------------------------------INICIO FUSÍON-------------------------------------  
-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------  
---------------------------------------------------------------------------------  
   ,@COD_COLATERAL     CHAR (03)  
)  
  
AS  
BEGIN  
  
 SET NOCOUNT ON          
   
 SET @cldv = UPPER(@cldv)   
  
   
 -- 10967 Primero Checar si se modifica la metodología  
 -- del CLIENTE o Padre de Familia    
   
 DECLARE @rutAux NUMERIC(13)    
 DECLARE @codigoAux NUMERIC(5)     
 DECLARE @MetAnterior NUMERIC(5)    
   
 SET @rutAux = @clrut    
 SET @codigoaux = @clcodigo    
   
 SELECT @rutAux = clrut_padre,  
        @codigoAux     = ClCodigo_padre  
 FROM   baclineas..CLIENTE_RELACIONADO cr  
 WHERE  clrut_hijo     = @clrut  
        AND cr.clcodigo_hijo = @clcodigo      
   
 SELECT @MetAnterior = 0    
   
 SELECT @MetAnterior = ClRecMtdCod  
 FROM   bacParamSuda..CLIENTE  
     WHERE  clrut            = @rutAux  
        AND clcodigo     = @codigoAux      
   
 IF @MetAnterior <> @ClRecMtdCod  
 BEGIN  
     -- 10967 Limpieza de linea DRV, por no ser utilizada    
     IF @ClRecMtdCod IN (1, 4)  
     BEGIN  
         UPDATE BacLineas..LINEA_SISTEMA  
         SET    TotalDisponible = TotalAsignado,  
                TotalExceso = 0,  
                TotalOcupado = 0  
         WHERE  Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoAux  
                AND Id_Sistema = 'DRV'    
           
         UPDATE BacLineas..LINEA_PRODUCTO_POR_PLAZO  
         SET    TotalDisponible = TotalAsignado,  
                TotalExceso = 0,  
                TotalOcupado = 0  
         WHERE  Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoaux  
                AND Id_Sistema = 'DRV'   
           
         EXECUTE BacLineas..SP_RECALCULA_GENERAL  
  
     END  
     ELSE  
     BEGIN  
         -- Limpia las lineas que no se van a utilizar.    
  
         UPDATE BacLineas..LINEA_SISTEMA  
         SET    TotalDisponible = TotalAsignado,  
                TotalExceso = 0,  
                TotalOcupado = 0  
         WHERE  Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoAux  
                AND Id_Sistema   IN (SELECT id_Sistema  
                                     FROM   BacLineas..TBL_AGRPROD  
                                     WHERE  Id_Grupo = 'DRV')    
           
         UPDATE BacLineas..LINEA_PRODUCTO_POR_PLAZO  
         SET    TotalDisponible = TotalAsignado,  
                TotalExceso = 0,  
                TotalOcupado = 0  
         WHERE  Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoaux  
                AND Id_Sistema   IN (SELECT id_Sistema  
                                     FROM   BacLineas..TBL_AGRPROD  
                                     WHERE  Id_Grupo = 'DRV')   
           
         -- select * from sysobjects where name like '%GR%' and type = 'u'  use baclineas  -- select * from BacLineas..TBL_AGRPROD  
         -- 10967 Limmpieza de TRN porque no aplicarn con metodologia DRV  
         -- 10967 Borrado sin OR por el desempeño del DELETE    
           
         DELETE LINEA_TRANSACCION  
         WHERE  Id_Sistema = 'PCS'  
                AND Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoaux  
           
         DELETE LINEA_TRANSACCION  
         WHERE  Id_Sistema = 'FWD'  
                AND Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoaux  
           
         DELETE LINEA_TRANSACCION  
         WHERE  Id_Sistema = 'OPT'  
                AND Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoaux  
           
         DELETE LINEA_TRANSACCION_DETALLE  
         WHERE  Id_Sistema = 'PCS'  
                AND Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoaux  
           
         DELETE LINEA_TRANSACCION_DETALLE  
         WHERE  Id_Sistema = 'FWD'  
                AND Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoaux  
           
         DELETE LINEA_TRANSACCION_DETALLE  
         WHERE  Id_Sistema = 'OPT'  
                AND Rut_Cliente = @rutAux  
                AND Codigo_Cliente = @codigoaux   
           
         EXECUTE BacLineas..SP_RECALCULA_GENERAL  
     END  
 END    
   
 SET @clnombre = SUBSTRING(@clnombre, 1, 60)         
   
 DECLARE @dFecha DATETIME          
 SET @dFecha = (  
         SELECT acfecproc  
         FROM   BacTraderSuda.dbo.MDAC WITH(NOLOCK)  
     )          
   
 DECLARE @iClasOriginal INTEGER          
 SET @iClasOriginal = -1          
   
 SET @iClasOriginal = ISNULL((SELECT TOP 1 tbtasa  
         FROM   BacParamSuda.dbo.CLIENTE  
            INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE   
            ON  tbcateg = 103  
            AND tbcodigo1 = clclsbif  
         WHERE  clrut            = @clrut  
         AND clcodigo     = @clcodigo),-1)          
   
 DECLARE @iClasNueva INTEGER          
 SET @iClasNueva = (SELECT TOP 1 tbtasa  
        FROM   BacParamSuda.dbo.TABLA_GENERAL_DETALLE  
        WHERE  tbcateg           = 103  
        AND tbcodigo1     = @clclsbif)          
   
 IF EXISTS(SELECT clrut  
     FROM   CLIENTE  
           WHERE  clrut            = @clrut  
              AND clcodigo     = @clcodigo)  
                
 BEGIN  
     -->     Genera un bloqueo automatico del CLIENTE al cae su clasificacion de riesgo          
     EXECUTE dbo.SP_BLOQUEO_AUTOMATICO_CLIENTE @clrut, @clcodigo, @clclsbif   
     -->     Genera un bloqueo automatico del CLIENTE al cae su clasificacion de riesgo  
     --> Si la clasificacion cae, debe reducir Threshold por tabla de reduccion de threshold          
       
     IF @iClasNueva > @iClasOriginal  
        AND @iClasOriginal > -1  
     BEGIN  
         EXECUTE dbo.SP_APLICA_REDUCCION_THRESHOLD @clrut, @clcodigo  
     END          
       
     UPDATE CLIENTE  
     SET    clrut                      = @clrut,  
            clcodigo                   = @clcodigo,  
            clnombre                   = @clnombre,  
            clgeneric                  = @clgeneric,  
            cldirecc                   = @cldirecc,  
            clcomuna                   = @clcomuna,  
            clregion                   = @clregion,  
            cltipcli                   = @cltipcli,  
            clfecingr                  = @clfecingr,  
            clctacte                   = @clctacte,  
            clfono                     = @clfono,  
            clfax                      = @clfax,  
            clapelpa                   = @clapelpa,  
            clapelma                   = @clapelma,  
            clnomb1                    = @clnomb1,  
            clnomb2                    = @clnomb2,  
            clapoderado                = @clapoderado,  
            clciudad                   = @clciudad,  
            clmercado                  = @clmercado,  
            clgrupo                    = @clgrupo,  
   clpais                     = @clpais,  
            clcalidadjuridica          = @clcalidad,  
            cltipoml                   = @cltipoml,  
            cltipomx                   = @cltipomx,  
            clbanca                    = @clbanca,  
            clrelac                    = @clrelac,  
            clnumero                   = @clnumero,  
            clcomex                    = @clcomex,  
            clchips                    = @clchips,  
            claba                      = @claba,  
            clswift                    = @clswift,  
            clnfm                      = @clnfm,  
            clfmutuo                   = @clfmutuo,  
            clfeculti                  = '',  
            clejecuti                  = @clejecuti,  
            clentidad                  = @clentidad,  
            clgraba                    = @clgraba,  
            clcompint                  = @clcompint,  
            clcalle                    = @clcalle,  
            clctausd                   = @clctausd,  
            clcaljur                   = @clcaljur,  
            clnemo                     = @clnemo,  
            climplic                   = @climplic,  
            clopcion                   = @clopcion,  
            clrelacion                 = @clrelaciongb,  
            clcatego                   = @clcatego,  
            clsector                   = @clsector,  
            clclsbif                   = @clclsbif,  
            clactivida                 = @clactivida,  
            cltipemp                   = @cltipemp,  
            relbco                     = @clrelbco,  
            poder                      = @clpoder,  
            firma                      = @clfirma,  
            feca85                     = @clfeca85,  
            relcia                     = @clrelcia,  
            relcor                     = @clrelcor,  
            infosoc                    = @clinfosoc,  
            art85                      = @clart85,  
            rut_grupo                  = @Rut_Grupo,  
            cod_inst                   = @clcodinst,  
            clcodban                   = @clcodban,  
            clvalidalinea              = (CASE WHEN @clrelaciongb = 3 THEN 'S' ELSE 'N' END),  
            oficinas                   = @cloficinas,  
            clclaries                  = @clcriesgo,  
            codigo_otc                 = @codigo_otc,  
            bloqueado                  = @bloqueado,  
            clcosto                    = @clcosto,  
            mxcontab                   = @codigo_contable,  
            clrutcliexterno            = @clrutcliexterno,  
            cldvcliexterno             = @cldvcliexterno,  
            clBrokers                  = @clbrokers,  
            RutBancoReceptor           = @ReceptorRutBco,  
            CodBancoReceptor           = @ReceptorCodBco,  
            clCondicionesGenerales     = @clCondicionesGenerales,  
            clFechaFirma_cond          = @clFechaFirma_cond,  
            nombre_notaria             = @nombre_notaria,  
            fecha_escritura            = @fecha_escritura,  
            ClCompBilateral            = @CompBilateral,  
            nuevo_ccg_firmado          = @nuevoccgfirm,  
            version_contratos_ccg      = @vercontratoccg,  
            fecha_firma_nuevo_ccg      = @fechafirmccg,  
            clausula_retroactiva_firmada = @clausularetroact,  
            motivo_bloqueo             = @MotivoBloqueo, -- PRD-3826, jbh, 05-02-2010          
            seg_comercial              = @SegComercial,  
            ejecutivo_comercial        = @EjecutivoCom,  
            garantiatotal              = @GarantiaTotal,  
            clVigente                  = @EstadoCliente, -- PRD-5896, 22-07-2010          
            garantiaefectiva           = @GarantiaEfectiva, -- PRD-5521          
            ClRecMtdCod                = @ClRecMtdCod, --PRD-8800        
            FechaFirmaCG_Pactos        = @dFechaCGPactos,  
            ComDer         = @ComDer, -- PRD 19121  
            ClFechaFirmaContratoComder = @FechaContratoComder, --> PRD-19121 V1  
            Email                      = @mail,  
            ClClasificaDecimales    = @ClasificaDecimal, --> PRD-21639,  
            ClCantidadDecimales    = @CantidadDecimal  --> PRD-21639  
              -- Datos Fusión  
   ,      Secuencia      = @Secuencia  
   ,      Codigo_AS400   = @CodAS400  
   ,      Codigo_CGI     = @CodCGI  
---------------------------------------------------------------------------------  
-------------------------------INICIO FUSÍON-------------------------------------  
-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------  
---------------------------------------------------------------------------------  
   ,ClCodEmpRelacionada   = @ClCodEmpRelacionada  
   ,ClCod_contra     = @ClCod_contra  
   ,ClCod_Emp_cen     = @ClCodEmp_cen  
   ,CNPJ       = @CNPJ  
---------------------------------------------------------------------------------  
-------------------------------INICIO FUSÍON-------------------------------------  
-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------  
---------------------------------------------------------------------------------  
     WHERE  clrut                      = @clrut  
            AND cldv                   = @cldv  
            AND clcodigo               = @clcodigo  
 END  
 ELSE  
 BEGIN  
     INSERT INTO CLIENTE  
       (  
         clrut,  
         cldv,  
         clcodigo,  
         clnombre,  
         clgeneric,  
         cldirecc,  
         clcomuna,  
         clregion,  
         cltipcli,  
         clfecingr,  
         clctacte,  
         clfono,  
         clfax,  
         clapelpa,  
         clapelma,  
         clnomb1,  
         clnomb2,  
         clapoderado,  
         clciudad,  
         clmercado,  
       clgrupo,  
         clpais,  
         clcalidadjuridica,  
         cltipoml,  
         cltipomx,  
         clbanca,  
         clrelac,  
         clnumero,  
         clcomex,  
         clchips,  
         claba,  
         clswift,  
         clnfm,  
         clfmutuo,  
         clejecuti,  
         clentidad,  
         clgraba,  
         clcompint,  
         clcalle,  
         clctausd,  
         clcaljur,  
         clnemo,  
         climplic,  
         clopcion,  
         clrelacion,  
         clcatego,  
         clsector,  
         clclsbif,  
         clactivida,  
         cltipemp,  
         relbco,  
         poder,  
         firma,  
         feca85,  
         relcia,  
         relcor,  
         infosoc,  
         art85,  
         rut_grupo,  
         cod_inst,  
         clcodban,  
         clvalidalinea,  
         oficinas,  
         clclaries,  
         codigo_otc,  
         bloqueado,  
         clcosto,  
         mxcontab,  
         clrutcliexterno,  
         cldvcliexterno,  
         clBrokers,  
         RutBancoReceptor,  
         CodBancoReceptor,  
         clCondicionesGenerales,  
         clFechaFirma_cond,  
         nombre_notaria,  
         fecha_escritura,  
         ClCompBilateral,  
         nuevo_ccg_firmado,  
         version_contratos_ccg,  
         fecha_firma_nuevo_ccg,  
         clausula_retroactiva_firmada,  
         motivo_bloqueo, --- PRD-3826, JBH, 05-02-2010          
         seg_comercial,  
         ejecutivo_comercial,  
         garantiatotal,  
         clvigente,  
         garantiaefectiva, --- PRD-5521          
         ClRecMtdCod, --- PRD-8800        
         FechaFirmaCG_Pactos,  
         ComDer, -- PRD 19121  
         ClFechaFirmaContratoComder, -- PRD 19121 V1  
         Email,  
         ClClasificaDecimales,  --PRD-21639  
         ClCantidadDecimales    --PRD-21639  
           -- Datos Fusión  
   ,     Secuencia    
   ,     Codigo_AS400    
   ,     Codigo_CGI      
---------------------------------------------------------------------------------  
-------------------------------INICIO FUSÍON-------------------------------------  
-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------  
---------------------------------------------------------------------------------  
   ,ClCodEmpRelacionada  
   ,ClCod_contra  
   ,ClCod_Emp_cen  
   ,CNPJ  
---------------------------------------------------------------------------------  
-------------------------------INICIO FUSÍON-------------------------------------  
-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------  
---------------------------------------------------------------------------------  
       )  
     VALUES  
       (  
         @clrut,  
         @cldv,  
         @clcodigo,  
         @clnombre,  
         @clgeneric,  
         @cldirecc,  
         @clcomuna,  
         @clregion,  
         @cltipcli,  
         @clfecingr,  
         @clctacte,  
         @clfono,  
         @clfax,  
         @clapelpa,  
         @clapelma,  
         @clnomb1,  
         @clnomb2,  
         @clapoderado,  
         @clciudad,  
         @clmercado,  
         @clgrupo,  
         @clpais,  
         @clcalidad,  
         @cltipoml,  
         @cltipomx,  
         @clbanca,  
         @clrelac,  
         @clnumero,  
         @clcomex,  
         @clchips,  
         @claba,  
         @clswift,  
         @clnfm,  
         @clfmutuo,  
         @clejecuti,  
         @clentidad,  
         @clgraba,  
         @clcompint,  
         @clcalle,  
         @clctausd,  
         @clcaljur,  
         @clnemo,  
         @climplic,  
         @clopcion,  
         @clrelaciongb,  
         @clcatego,  
         @clsector,  
         @clclsbif,  
         @clactivida,  
         @cltipemp,  
         @clrelbco,  
         @clpoder,  
         @clfirma,  
         @clfeca85,  
         @clrelcia,  
         @clrelcor,  
         @clinfosoc,  
         @clart85,  
         @rut_grupo,  
         @clcodinst,  
         @clcodban,  
         (CASE WHEN @clrelaciongb = 3 THEN 'S' ELSE 'N' END),  
         @cloficinas,  
         @clcriesgo,  
         @codigo_otc,  
         @bloqueado,  
         @clcosto,  
         @codigo_contable,  
         @clrutcliexterno,  
         @cldvcliexterno,  
         @clbrokers,  
         @ReceptorRutBco,  
         @ReceptorCodBco,  
         @clCondicionesGenerales,  
         @clFechaFirma_cond,  
         @nombre_notaria,  
         @fecha_escritura,  
         @CompBilateral,  
         @nuevoccgfirm,  
         @vercontratoccg,  
         @fechafirmccg,  
         @clausularetroact,  
         @MotivoBloqueo, --- PRD-3826, jbh, 05-02-2010          
         @SegComercial,  
         @EjecutivoCom,  
         @GarantiaTotal,  
         @EstadoCliente,  
         @GarantiaEfectiva, --- PRD-5521           
         @ClRecMtdCod, --- PRD-8800        
         @dFechaCGPactos,  
         @ComDer, --PRD 19121  
         @FechaContratoComder, --PRD 19121 V1  
         @mail,  
         @ClasificaDecimal, --PRD-21639  
         @CantidadDecimal   --PRD-21639  
           -- Datos Fusión  
   ,      @Secuencia  
   ,      @CodAS400   
   ,      @CodCGI  
---------------------------------------------------------------------------------  
-------------------------------INICIO FUSÍON-------------------------------------  
-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------  
---------------------------------------------------------------------------------  
   ,@ClCodEmpRelacionada  
   ,@ClCod_contra  
   ,@ClCodEmp_cen  
   ,@CNPJ  
---------------------------------------------------------------------------------  
-------------------------------INICIO FUSÍON-------------------------------------  
-----------------NUEVAS INTERFACES BACEN NORMATIVAS A BRASIL---------------------  
---------------------------------------------------------------------------------  
       )   
     
    
     EXECUTE SP_GRABAHISTORICORIESGO @clrut, @clcodigo, @dFecha, @clclsbif   
  
     /* Agregar al nuevo CLIENTE en tabla de bloqueos con todos los bloqueos y código 0. PRD -6066   */        
       
     IF NOT EXISTS(  
            SELECT 1  
            FROM   dbo.TBL_BLOQUEOS_CLIENTES  
            WHERE  rutCliente         = @clrut  
                   AND codCliente     = @clcodigo  
        )  
     BEGIN  
         INSERT INTO dbo.TBL_BLOQUEOS_CLIENTES  
           (  
             rutCliente,  
             codCliente,  
             blqTodos,  
             blqForward,  
             blqSwaps,  
             blqOpciones,  
             blqSpot,  
             blqPactos,  
             codMotivo  
           )  
         VALUES  
           (  
             @clrut,  
             @clcodigo,  
             'N', --- Todos      
             'S', --- Forward        
             'S', --- Swap        
             'S', --- Opciones        
             'N', --- Spot      
             'S', --- Pactos        
             0  
           ) --- Motivo de Bloqueo  
     END/* Fin PRD-6066 */  
 END          
   
 EXEC dbo.spIUClienteTuring @clrut, @clcodigo  
 
-- IF @COD_COLATERAL <>''
 begin
	if EXISTS (select 1 from CLI_COLATERAL where rut_cliente=@clrut and cod_cliente=@clcodigo)
	begin
		update CLI_COLATERAL
			set cod_colateral=@COD_COLATERAL
		where rut_cliente=@clrut and cod_cliente=@clcodigo
	end
	else
	begin
		insert into CLI_COLATERAL
		select	@clrut
		,		@clcodigo
		,		@COD_COLATERAL
	end
 end
 
   
 SELECT 'OK'  
END
GO
