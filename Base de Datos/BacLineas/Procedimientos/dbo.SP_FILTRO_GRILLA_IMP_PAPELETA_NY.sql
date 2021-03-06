USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_GRILLA_IMP_PAPELETA_NY]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--sp_helptext SP_FILTRO_GRILLA_IMP_PAPELETA_NY ' ', '', 'T', '', '', 0, 0, 'JROJAS'

--  SELECT * from  DETALLE_APROBACIONES WHERE Numero_Operacion = 3610 AND Id_Sistema = 'BEX'
--  SELECT * from  DETALLE_APROBACIONES WHERE Numero_Operacion = 3590 AND Id_Sistema = 'BTR'

--		   SELECT * from  DETALLE_APROBACIONES WHERE Numero_Operacion = 9564  and Firma1 <>'FALTA'    


--SELECT * from  DETALLE_APROBACIONES WHERE Numero_Operacion = 97093 AND Id_Sistema = 'BEX'

--SP_FILTRO_GRILLA_IMP_PAPELETA_NY 'BEX', '', 'T', '', '', 0, 0, 'ADMINISTRA'

--SP_FILTRO_GRILLA_IMP_PAPELETA_NY 'BEX', '', 'T', '', '', 0, 0, 'NBERMEO'
--SP_FILTRO_GRILLA_IMP_PAPELETA_NY 'PCS', '', 'T', '', '', 0, 0, 'NBERMEO'

--SP_FILTRO_GRILLA_IMP_PAPELETA_NY '', '', 'T', '', '', 0, 0, 'NBERMEO'

--SP_FILTRO_GRILLA_IMP_PAPELETA 'BEX', '', 'T', '', '', 0, 0, 'NBERMEO'
--SP_FILTRO_GRILLA_IMP_PAPELETA 'PCS', '', 'T', '', '', 0, 0, 'NBERMEO'


CREATE  PROCEDURE [dbo].[SP_FILTRO_GRILLA_IMP_PAPELETA_NY]   
   (   @Modulo       CHAR(3)    
   ,   @T_Operacion   CHAR(255)    
   ,   @S_Operacion   CHAR(20)    
   ,   @Usuario       CHAR(10)    
   ,   @Moneda        CHAR(3)    
   ,   @FP_Recibimos INT  
   ,   @FP_Pagamos  INT  
   ,   @UsuarioControl   VARCHAR(15)    
   )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   -- MAP 07 Octubre    
   -- Las formas de pago son mas complejas en las opciones    
   -- se opta por poner 'No aplica'    
   -- Caida de procedimiento por una columna que faltaba    
   -- Tipo de Cliente.    
    
   -- MAP 29 OCtubre 2009    
   -- Se elimina el estado como parte de los filtros    
   -- la grilla de las papeletas pueden estar aprobadas.    
    
    
-- Sp_Filtro_Grilla_Imp_Papeleta '', 'T', '', '', '', 0, 0,''    
    
   DECLARE @Fecha_Proceso    DATETIME    
   DECLARE @Fecha_ProcesoFWD DATETIME    
   DECLARE @Fecha_ProcesoBTR DATETIME    
   DECLARE @Fecha_ProcesoPCS DATETIME    
   DECLARE @Fecha_ProcesoOPT DATETIME    
    
     
      CREATE TABLE #TMP    
   (   Modulo               CHAR(03)       NOT NULL    
   ,   N_Operacion          NUMERIC(10,0)  NOT NULL    
   ,   N_documento          NUMERIC(10,0)  NOT NULL    
   ,   Correlativo          NUMERIC(3,0)   NOT NULL    
   ,   T_Operacion          CHAR(12)       NOT NULL    
   ,   Moneda               CHAR(10)       NOT NULL    
   ,   rutcartera           NUMERIC(9,0)   NOT NULL    
   ,   rutcli               NUMERIC(9,0)   NOT NULL    
   ,   Nom_Cliente          CHAR(80)       NOT NULL    
   ,   Monto_Oper           NUMERIC(19,4)  NOT NULL    
   ,   Tasa                 NUMERIC(9,4)   NOT NULL    
   ,   oper                 CHAR(40)       NOT NULL    
   ,   nomoper              CHAR(40)       NOT NULL    
   ,   papeleta      NUMERIC(03)  NOT NULL     
   ,   contrato      NUMERIC(03)  NOT NULL     
   ,   tiporig      CHAR(10)       NOT NULL    
   ,   S_Operacion          CHAR(20)       NOT NULL    
   ,   Estado               CHAR(10)       NOT NULL    
   ,   codcli               NUMERIC(9,0)   NOT NULL    
   ,   FP_Pagamos         NUMERIC(5,0)       NOT NULL    
   ,   FP_Recibimos         NUMERIC(5,0)      NOT NULL    
   ,   Fecha      DATETIME    NOT NULL    
   ,   Supervisor     CHAR(15)       NOT NULL     
   ,   Tipoper      CHAR(12)       NOT NULL     
   ,   SwImpre              NUMERIC(1,0)   NOT NULL    
   ,   TipoCliente          INTEGER         NOT NULL    
   )    
    
    CREATE TABLE #TEMP_MOVIMIENTOS    
   (   Modulo               CHAR(03)       NOT NULL    
   ,   N_Operacion          NUMERIC(10,0)  NOT NULL    
   ,   N_documento          NUMERIC(10,0)   NOT NULL    
   ,   Correlativo          NUMERIC(3,0)   NOT NULL    
   ,   T_Operacion          CHAR(50)        NOT NULL    
   ,   Moneda_Oper          CHAR(40)       NOT NULL    
   ,   Nom_Cliente          CHAR(80)       NOT NULL    
   ,   Monto_Oper           NUMERIC(21,4)  NOT NULL    
   ,   Monto_Pesos          NUMERIC(21,4)  NOT NULL    
   ,   Tasa                 NUMERIC(9,4)   NOT NULL    
   ,   Precio               NUMERIC(19,4)  NOT NULL    
   ,   S_Operacion          CHAR(20)       NOT NULL    
   ,   Usuario              CHAR(15)       NOT NULL    
   ,   FP_Pagamos         CHAR(30)       NOT NULL    
   ,   FP_Recibimos         CHAR(30)       NOT NULL    
   ,   Fecha      DATETIME    NOT NULL    
   ,   Supervisor     CHAR(15)       NOT NULL    
   ,   Mercado         CHAR(06)    NOT NULL    
   ,   Tipop      CHAR(12)       NOT NULL     
   ,   SwImpre              NUMERIC(1,0)   NOT NULL    
   ,   TipoCliente          INTEGER         NOT NULL    
   )    
     
      CREATE TABLE #TEMP_PAPELETAS    
   (   Modulo               CHAR(03)       NOT NULL    
   ,   N_Operacion          NUMERIC(9,0)   NOT NULL    
   ,   N_documento          NUMERIC(9,0)   NOT NULL  
   ,   Correlativo          CHAR(03)       NOT NULL    
   ,   T_Operacion          CHAR(50)        NOT NULL    
   ,   Moneda_Oper          CHAR(40)       NOT NULL    
,   Nom_Cliente         CHAR(80)       NOT NULL    
   ,   Monto_Oper           NUMERIC(19,4)  NOT NULL    
   ,   Monto_Pesos          NUMERIC(19,4)  NOT NULL    
   ,   Tasa                 NUMERIC(9,4)   NOT NULL    
   ,   Precio               NUMERIC(19,4)  NOT NULL    
   ,   S_Operacion          CHAR(20)       NOT NULL    
   ,   Usuario              CHAR(15) NOT NULL    
   ,   FP_Pagamos         CHAR(30)       NOT NULL    
   ,   FP_Recibimos        CHAR(30)       NOT NULL    
   ,   Fecha      DATETIME    NOT NULL    
   ,   Supervisor     CHAR(15)       NOT NULL    
   ,   Mercado         CHAR(06)    NOT NULL     
   ,   TipoperRF            CHAR(12)  NOT NULL    
   ,   SwImpre              NUMERIC(1,0)   NOT NULL    
   ,   Rutcartera           NUMERIC(9,0)   NOT NULL    
   ,   FirmaSup1            CHAR(15)       NOT NULL    
   ,   FirmaSup2            CHAR(15)       NOT NULL    
   ,   TipoCliente          INTEGER         NOT NULL    
   )    
    
      SET @Fecha_Proceso = (SELECT CONVERT(CHAR(08), acfecpro, 112) FROM BacCamSuda.dbo.MEAC with(nolock))    
    
      INSERT INTO  #TEMP_MOVIMIENTOS       
      SELECT 'Modulo'      = 'BCC'    
      ,      'N_Operacion'   = mov.monumope    
      ,      'N_documento'   = mov.monumope    
      ,      'Correlativo'   = 0    
      ,      'T_Operacion'   = CASE WHEN mov.motipope = 'C' THEN 'COMPRA' ELSE 'VENTA' END    
      ,      'Moneda_Oper'   = mov.mocodmon    
      ,      'Nom_Cliente'   = mov.monomcli    
      ,      'Monto_Oper'    = mov.momonmo    
      ,      'Monto_Pesos'   = mov.momonpe    
      ,      'Tasa'        = 0.0    
      ,      'Precio'      = CASE WHEN mov.motipmer  ='ARBI' THEN mov.moparme ELSE mov.moprecio END    
      ,      'S_Operacion'   = CASE WHEN mov.moestatus = 'P' THEN 'PENDIENTE'    
                                    WHEN mov.moestatus = 'R' THEN 'RECHAZADA'    
                                    ELSE                          'APROBADA'    
                  END     
      ,      'Usuario'       = mov.mooper    
      ,      'FP_Pagamos'    = isnull(pag.glosa, 'S/N F. PAGO')    
      ,      'FP_Recibimos'  = isnull(rec.glosa, 'S/N F. PAGO')    
      ,      'Fecha'         = mov.mofech    
      ,      'Supervisor'    = mov.mooper    
      ,      'Mercado'       = CASE WHEN mov.motipmer = 'CCBB' THEN 'EMPR' ELSE mov.motipmer end    
      ,      'tipop'      = mov.motipope    
      ,      'SwImpre'      = mov.SwImpresion    
      ,      'TipoCliente'   = ISNULL(cli.cltipcli, -1)    
      FROM   BacCamSuda.dbo.MEMO                      mov with(nolock)    
             LEFT JOIN BacParamSuda.dbo.CLIENTE       cli with(nolock) ON cli.clrut  = mov.morutcli and cli.clcodigo = mov.mocodcli    
             LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO pag with(nolock) ON pag.codigo = mov.moentre    
             LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO rec with(nolock) ON rec.codigo = mov.moentre    
      WHERE  mov.mofech      = @Fecha_Proceso    
      AND   (mov.moestatus   = @S_Operacion  OR @S_Operacion  = 'T')    
      AND   (mov.mooper      = @Usuario      OR @Usuario      = '')    
      AND    mov.motipmer   <> 'OVER'    
      AND   (mov.motipope    = @T_Operacion  OR @T_Operacion  = '')    
      AND   (mov.mocodmon    = @Moneda    OR @Moneda       = '')    
      AND   (mov.moentre     = @FP_Pagamos   OR @FP_Pagamos   = 0)    
      AND   (mov.morecib     = @FP_Recibimos OR @FP_Recibimos = 0)    
      ORDER BY mov.monumope     
    
      IF @@ERROR <> 0     
      BEGIN    
         PRINT 'ERROR AL INSERTAR DESDE SPOT'       
         RETURN    
      END    
    
      --- OVERNIGHT    
      INSERT INTO  #TEMP_MOVIMIENTOS       
      SELECT 'Modulo'      = 'BCC'   
      ,      'N_Operacion'   = mov.monumope     
      ,      'N_documento'   = mov.monumope     
      ,      'Correlativo'   = 0    
      ,      'T_Operacion'   = CASE WHEN mov.motipope = 'C' THEN 'COMPRA' ELSE 'VENTA' END    
      ,      'Moneda_Oper'   = mov.mocodmon    
      ,      'Nom_Cliente'   = mov.monomcli    
	  ,		'Monto_Oper'    = mov.momonmo    
      ,      'Monto_Pesos'   = mov.momonpe    
      ,      'Tasa'        = mov.motctra    
      ,      'Precio'      = CASE WHEN mov.motipmer ='ARBI' THEN mov.moparme ELSE mov.moprecio END    
      ,      'S_Operacion'   = CASE WHEN mov.moestatus = 'P' THEN 'PENDIENTE'    
               WHEN mov.moestatus = 'R' THEN 'RECHAZADA'    
                                    ELSE             'APROBADA'    
                 END      
      ,      'Usuario'       = mov.mooper                
      ,      'FP_Pagamos'    = ' ' --b.glosa        
      ,      'FP_Recibimos'  = ' ' --c.glosa        
      ,      'Fecha'         = mov.mofech     
      ,      'Supervisor'    = mov.mooper     
      ,      'Mercado'       = CASE WHEN mov.motipmer = 'CCBB' THEN 'EMPR' ELSE mov.motipmer end    
      ,      'tipop'      = mov.motipope       
      ,      'SwImpre'      = mov.SwImpresion    
      ,      'TipoCliente'   = ISNULL(cli.cltipcli, -1)    
      FROM   BacCamSuda.dbo.MEMO                mov with(nolock)    
             LEFT JOIN BacParamSuda.dbo.CLIENTE cli with(nolock) ON cli.clrut = mov.morutcli and cli.clcodigo = mov.mocodcli    
      WHERE  mov.mofech      = @Fecha_Proceso    
      AND   (mov.moestatus   = @S_Operacion  OR @S_Operacion  = 'T')    
      AND   (mov.mooper      = @Usuario      OR @Usuario      = '')    
      AND    mov.motipmer    = 'OVER'    
      AND   (mov.motipope    = @T_Operacion  OR @T_Operacion  = '')    
      AND   (mov.mocodmon    = @Moneda       OR @Moneda       = '')    
      AND   (mov.moentre     = @FP_Pagamos   OR @FP_Pagamos   = 0)    
      AND   (mov.morecib     = @FP_Recibimos OR @FP_Recibimos = 0)    
      ORDER BY mov.monumope     
    
      IF @@ERROR <> 0     
      BEGIN    
         PRINT 'ERROR AL INSERTAR DESDE SPOT II'       
         RETURN    
      END    
    
      SET @Fecha_Procesofwd = (SELECT CONVERT(CHAR(08), acfecproc, 112) FROM BacFWDNY.dbo.MFAC with(nolock))    
    
      INSERT INTO  #TEMP_MOVIMIENTOS       
      SELECT 'Modulo'      = 'BFW'    
      ,      'N_Operacion'   = mov.monumoper    
      ,      'N_documento'   = mov.monumoper    
      ,      'Correlativo'   = 0    
      ,      'T_Operacion'   = CASE WHEN mov.motipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END    
      ,      'Moneda_Oper'   = ISNULL(mon.mnnemo, '')    
      ,      'Nom_Cliente'   = cli.clnombre    
      ,      'Monto_Oper'    = mov.momtomon1    
      ,      'Monto_Pesos'   = mov.momtomon1    
      ,      'Tasa'        = 0.0    
      ,      'Precio'      = CONVERT(NUMERIC(19,4), mov.motipcam)    
      ,      'S_Operacion'   = CASE WHEN mov.moestado = 'P' THEN 'PENDIENTE'    
                                    WHEN mov.moestado = 'R' THEN 'RECHAZADA'    
                                    ELSE                         'APROBADA'    
                               END    
      ,      'Usuario'       = mov.mooperador    
      ,      'FP_Pagamos'    = ISNULL(pmn.glosa, '')    
      ,      'FP_Recibimos'  = ISNULL(pmx.glosa, '')    
      ,      'Fecha'         = mov.mofecha    
      ,      'Supervisor'    = mov.mooperador    
      ,      'Mercado'       = CONVERT(CHAR(02), mov.mocodpos1)    
      ,      'tipop'      = mov.motipoper    
      ,      'SwImpre'      = mov.SwImpresion    
      ,      'TipoCliente'   = ISNULL(cli.cltipcli, -1)    
      FROM   BacFwdNY.dbo.MFMO                      mov with(nolock)    
             LEFT JOIN BacParamSuda.dbo.CLIENTE       cli with(nolock) ON cli.clrut = mov.mocodigo AND cli.clCodigo = mov.mocodCli   
             LEFT JOIN BacParamSuda.dbo.MONEDA        mon with(nolock) ON mon.mncodmon = mov.mocodmon1    
             LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO pmn with(nolock) ON pmn.codigo = mov.mofpagomn    
             LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO pmx with(nolock) ON pmx.codigo = mov.mofpagomn    
      WHERE  mov.mofecha     = @Fecha_Procesofwd    
      AND   (mov.moestado    = @S_Operacion     OR @S_Operacion  = 'T')   
      AND   (mov.motipoper   = @T_Operacion     OR @T_Operacion  = '')    
      AND   (mon.mnnemo      = @Moneda          OR @Moneda       = '')    
      AND   (mov.mofpagomn   = @FP_Pagamos      OR @FP_Pagamos   = 0)    
      AND   (mov.mofpagomx   = @FP_Recibimos    OR @FP_Recibimos = 0)    
      AND   (mov.mooperador  = @Usuario         OR @Usuario      = '')    
      AND ( (mov.moNroOpeMxClp = 0)  
   OR  (mov.moNroOpeMxClp > 0 AND mocodpos1 = 2)  
   )  
      ORDER BY mov.monumoper    
    
      IF @@ERROR <> 0    
      BEGIN    
         PRINT 'ERROR AL INSERTAR DESDE FORWARD'     
         RETURN    
      END    
                
      SET @Fecha_ProcesoBTR  = ( SELECT CONVERT(CHAR(08), acfecproc, 112) FROM BacTraderSuda.dbo.MDAC with(nolock) )    
       
INSERT  INTO #TMP    
      SELECT DISTINCT      
             'Modulo'        = 'BTR'    
      ,      'N_Operacion'   = mov.monumoper    
      ,      'N_Documento'   = 0    
      ,      'Correlativo'   = 1    
      ,      'T_Operacion'   = CONVERT(CHAR(10), mov.motipoper)    
      ,      'Moneda'        = MIN( mon.mnnemo )    
      ,      'rutcartera'    = MIN( mov.morutcart )    
      ,      'rutcli'        = MIN( mov.morutcli )    
      ,      'Nom_Cliente'   = MIN( LEFT(cli.clnombre,40) )--> cli.clnombre    
      ,      'Monto_Oper'    = 0    
      ,      'Tasa'          = MIN( mov.motasemi )    
      ,      'oper'          = MIN( mov.mousuario )     
      ,      'nomoper'       = MIN( ISNULL(usr.nombre, '')  )    
      ,      'papeleta'      = MIN( ISNULL(pap.papapimp, 0) )-->      
      ,      'contrato'      = MIN( ISNULL(pap.paconimp, 0) )-->     
      ,      'S_Operacion'   = MIN( mov.mostatreg )    
      ,      'tiporig'       = SPACE(05)    
      ,      'Estado'        = MIN( mov.mostatreg )    
      ,      'codcli'        = MIN( mov.mocodcli )    
      ,      'FP_Pagamos'    = MIN( mov.moforpagi )    
      ,      'FP_Recibimos'  = MIN( mov.moforpagv )    
      ,      'fecha'      = MIN( mov.mofecpro )    
      ,      'Supervisor'    = MIN( mov.mousuario )    
      ,      'Tipoper'      = mov.motipoper    
      ,      'SwImpre'      = MIN( mov.SwImpresion )    
      ,      'TipoCliente'   = MIN( cli.cltipcli )    
      FROM    BacTraderSuda.dbo.MDMO            mov with(nolock)    
              LEFT JOIN BacParamSuda.dbo.MONEDA mon with(nolock) ON mon.mncodmon   = CASE WHEN motipoper = 'CI' THEN momonpact    
                                                                                          WHEN motipoper = 'VI' THEN momonpact    
                                                                                          ELSE                       momonemi    
                                                                                     END    
              LEFT JOIN BacParamSuda.dbo.CLIENTE cli with(nolock) ON cli.clrut     = morutcli and cli.clcodigo = mocodcli    
              LEFT JOIN BacTraderSuda.dbo.MDPA   pap with(nolock) ON pap.panumoper = mov.monumoper    
              LEFT JOIN BacParamSuda.dbo.USUARIO usr with(nolock) ON usr.usuario   = mov.mousuario    
      WHERE   mov.motipoper      IN('CP', 'CI', 'VP', 'VI', 'IB', 'ST', 'RCA', 'RVA', 'IC', 'AIC', 'FLI')    
      and     mov.mofecpro       = @Fecha_ProcesoBTR    
      GROUP BY mov.monumoper, mov.motipoper    
    
    
      IF @@ERROR <> 0     
      BEGIN    
         PRINT 'ERROR AL INSERTAR DESDE RENTA FIJA '    
         RETURN    
      END    
    
      DELETE FROM #TMP     
            WHERE LTRIM(RTRIM( estado )) <> ''    
    
      UPDATE #TMP    
      SET    Modulo       = 'BTR'     
      ,      T_Operacion  = SUBSTRING(moinstser,1,4)     
      ,      Monto_Oper   = (SELECT SUM(movalinip)  FROM BacTraderSuda.dbo.MDMO with(nolock) WHERE N_Operacion = monumoper)    
      FROM   BacTraderSuda.dbo.MDMO with(nolock)    
      WHERE  N_Operacion=monumoper     
      AND    motipoper    = 'IB'    
    
      UPDATE #TMP    
      SET    Monto_Oper   = (SELECT SUM(movalcomp)  FROM BacTraderSuda.dbo.MDMO with(nolock) WHERE N_Operacion = monumoper)    
      WHERE  T_Operacion  IN('CP', 'RC', 'RCA')    
    
      UPDATE #TMP    
      SET    Monto_Oper   = (SELECT SUM(movalven)   FROM BacTraderSuda.dbo.MDMO with(nolock) WHERE N_Operacion = monumoper)    
      WHERE  T_Operacion  IN('VP', 'RV', 'RVA', 'ST')    
    
      UPDATE #TMP    
      SET    Monto_Oper   = (SELECT SUM(movalinip)  FROM BacTraderSuda.dbo.MDMO with(nolock) WHERE N_Operacion = monumoper)    
      WHERE  T_Operacion  IN('CI', 'VI', 'FLI')    
    
      UPDATE #TMP    
      SET    Monto_Oper   = (SELECT SUM(movpresen)  FROM BacTraderSuda.dbo.MDMO with(nolock) WHERE N_Operacion = monumoper)    
      WHERE  T_Operacion='IC'    
    
      UPDATE #TMP    
      SET    Monto_Oper   = (SELECT SUM(movpresen)  FROM BacTraderSuda.dbo.MDMO with(nolock) WHERE N_Operacion = monumoper)    
    WHERE  T_Operacion ='AIC'    
    
      UPDATE #TMP    
     SET    tiporig = T_Operacion    
    
      UPDATE #TMP     
      SET    T_Operacion = 'A' +T_Operacion     
      WHERE  S_Operacion = 'A'    
    
    
      -- PM    
      INSERT  INTO #TMP    
      SELECT 'Modulo'        = 'BTR'    
      ,      'N_Operacion'   = monumoper    
      ,      'N_Documento'   = 0    
      ,      'Correlativo'   = 1    
      ,      'T_Operacion'   = 'ST'    
      ,      'Moneda'        = mnnemo    
      ,      'rutcartera'    = morutcart    
      ,    'rutcli'        = morutcli    
      ,      'Nom_Cliente'   = SUBSTRING(clnombre,1,40)    
      ,      'Monto_Oper'    = SUM(movalven)    
      ,      'Tasa'          = SUM(motasemi * monominal) / SUM(monominal)    
      ,      'oper'          = SUBSTRING(mousuario,1,12)    
      ,      'nomoper'       = SUBSTRING(MIN(nombre),1,30)    
      ,      'papeleta'      = 0    
      ,      'contrato'      = 0    
      ,      'S_Operacion'   = mostatreg    
      ,      'tiporig'       = 'ST'    
      ,      'Estado'        = mostatreg    
      ,      'codcli'        = mocodcli    
      ,      'FP_Pagamos'    = MIN(moforpagi)    
      ,      'FP_Recibimos'  = MIN(moforpagv)    
      ,      'fecha'      = mofecpro    
      ,      'Supervisor'    = mousuario    
      ,      'Tipoper'      = 'ST'    
      ,      'SwImpre'      = SwImpresion    
      ,      'TipoCliente'   = ISNULL(cltipcli, -1)    
      FROM   BacTraderSuda.dbo.MDMOPM           with(nolock)    
             LEFT JOIN BacParamSuda.dbo.CLIENTE with(nolock) ON clrut = morutcli AND clcodigo = mocodcli    
      ,      BacTraderSuda.dbo.MDAC             with(nolock)    
      ,      BacParamSuda.dbo.USUARIO usr       with(nolock)    
      ,      BacParamSuda.dbo.MONEDA            with(nolock)    
      WHERE  mofecinip  = acfecproc    
      AND    SorteoLCHR = 'S'    
      AND    mousuario  = usr.usuario     
      AND    momonemi   = mncodmon    
     GROUP BY mofecpro, morutcart, monumoper, motipoper, morutcli, mocodcli, clnombre, mostatreg, mousuario, SwImpresion, momonemi, mnnemo, cltipcli    
    
      IF @@ERROR <> 0     
      BEGIN    
         PRINT 'ERROR AL INSERTAR DESDE RENTA FIJA II'    
         RETURN    
      END    
    
     
      DECLARE @dFechaPCS   DATETIME    
      SET     @dFechaPCS   = (SELECT fechaproc FROM BacSwapNY.dbo.SWAPGENERAL with(nolock))    
    
      CREATE TABLE #PASO_COMPRAS    
      (   Swap    CHAR(6)    
      ,   Numero_Operacion NUMERIC(10)    
      ,   Codigo_Cliente NUMERIC(10)    
      ,   Nombrecli  CHAR(70)    
      ,   Tipo_operacion CHAR(1)    
      ,   NombreOp  CHAR(7)    
      ,   FechaInicio    CHAR(10)    
      ,   Fechatermino   CHAR(10)    
      ,   MonedaOperacion NUMERIC(3)    
      ,   NombreMoneda  CHAR(10)    
      ,   MontoOperacion  NUMERIC(21,04)    
      ,   TasaBase  NUMERIC(15,04)    
      ,   MontoConversion NUMERIC(21,04)    
      ,   TasaConversion NUMERIC(15,04)    
      ,   Modalidad         CHAR(15)    
      ,   rutcli  CHAR(12)    
      ,   EstadoOpe  CHAR(5)    
      ,   Usuario  CHAR(15)    
      ,   FormaPago  CHAR(30)    
      ,   FormaPago2  CHAR(30)    
      ,  Fecha  DATETIME    
      ,   Supervisor  CHAR(15)    
      ,   SwImpre            NUMERIC(1,0)    
      ,   TipoCliente           INTEGER    
      )      
    
      INSERT INTO #PASO_COMPRAS    
      SELECT DISTINCT    
             'Swap'   = CASE WHEN mov.Tipo_Swap = 1 THEN 'TASA'     
                                       WHEN mov.Tipo_Swap = 2 THEN 'MONEDA'    
                                       WHEN mov.Tipo_Swap = 3 THEN 'FRA'    
                                       WHEN mov.Tipo_Swap = 4 THEN 'PROM.C'    
                    END    
      ,      'Numero_Operacion' = mov.Numero_Operacion    
      ,      'Codigo_Cliente' = mov.codigo_cliente    
      ,      'Nombrecli' = LTRIM(RTRIM(cli.clnombre))    
      ,      'Tipo_operacion' = mov.Tipo_operacion    
      ,      'NombreOp'  = CASE WHEN mov.Tipo_operacion = 'C' THEN 'COMPRA' ELSE 'VENTA' END    
      ,      'FechaInicio'   = CONVERT(CHAR(10), fecha_cierre,  103)    
      ,      'Fechatermino'  = CONVERT(CHAR(10), fecha_termino, 103)    
      ,      'MonedaOperacion' = compra_moneda    
,      'NombreMoneda' = mon.mnnemo    
  ,   'MontoOperacion'  = compra_capital    
      ,      'TasaBase'  = compra_valor_tasa    
      ,      'MontoConversion' = venta_capital    
      ,      'TasaConversion' = venta_valor_tasa    
      ,      'Modalidad'        = CASE WHEN modalidad_pago = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA' END    
      ,      'rutcli'  = rut_cliente    
      ,      'EstadoOpe' = CASE WHEN estado_oper_lineas = 'A' THEN '' ELSE estado_oper_lineas END    
 ,      'Usuario'  = operador    
      ,      'FormaPago' = ISNULL( fpa.glosa, '')    
      ,      'FormaPago2' = ISNULL( fpb.glosa, '')    
      ,      'Fecha'         = fecha_cierre    
      ,      'Supervisor' = operador    
      ,      'SwImpre'          = SwImpresion    
      ,      'TipoCliente'      = ISNULL(cltipcli, -1)    
      FROM    BacSwapNY.dbo.MOVDIARIO                   mov with(nolock)     
              LEFT JOIN BacParamSuda.dbo.CLIENTE       cli with(nolock) ON cli.clrut    = mov.rut_cliente AND cli.clcodigo = mov.codigo_cliente    
              LEFT JOIN BacParamSuda.dbo.MONEDA        mon with(nolock) ON mon.mncodmon = compra_moneda    
              LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO fpa with(nolock) ON fpa.codigo   = CASE WHEN tipo_flujo = 1 THEN recibimos_documento ELSE pagamos_documento   END    
              LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO fpb with(nolock) ON fpb.codigo   = CASE WHEN tipo_flujo = 1 THEN pagamos_documento   ELSE recibimos_documento END    
      WHERE   Fecha_Cierre      = @dFechaPCS    
      AND     tipo_flujo        = 1    
--    AND     numero_flujo      = (SELECT MIN(numero_flujo) FROM BacSwapSuda.dbo.MOVHISTORICO with(nolock) WHERE Fecha_Cierre = @dFechaPCS)    
      AND     numero_flujo      = (SELECT MIN(numero_flujo) FROM BacSwapNY.dbo.MOVDIARIO    with(nolock) WHERE numero_operacion = mov.numero_operacion and Fecha_Cierre = @dFechaPCS)    
    
      IF @@ERROR <> 0     
      BEGIN    
         PRINT 'ERROR AL INSERTAR DESDE SWAP'    
         RETURN    
    END    
    
    
      INSERT INTO  #TEMP_MOVIMIENTOS       
      SELECT 'Modulo'      = 'PCS'    
      ,      'N_Operacion'  = Numero_Operacion     
      ,      'N_documento'  = Numero_Operacion     
      ,      'Correlativo'  = 0    
      ,      'T_Operacion'  = NombreOp    
      ,      'Moneda_Oper'  = NombreMoneda       
      ,      'Nom_Cliente'  = Nombrecli       
      ,      'Monto_Oper'   = MontoOperacion       
      ,      'Monto_Pesos'  = MontoOperacion     
      ,      'Tasa'       = TasaBase    
      ,      'Precio'     = 0.0       
      ,      'S_Operacion'  = CASE WHEN EstadoOpe = 'P' THEN 'PENDIENTE'    
       WHEN EstadoOpe = 'R' THEN 'RECHAZADA'    
                                   ELSE                      'APROBADA'    
                END     
      ,      'Usuario'      = Usuario                
      ,      'FP_Pagamos'   = case when Tipo_operacion = 'C' then  FormaPago2 else   FormaPago end    
      ,      'FP_Recibimos' = case when Tipo_operacion = 'v' then FormaPago2 else   FormaPago end    
      ,      'Fecha'        = Fecha    
      ,      'Supervisor'   = supervisor    
      ,      'Mercado'      = Swap    
      ,      'tipop'     = Tipo_operacion    
      ,      'SwImpre'     = SwImpre      
      ,      'TipoCliente'  = ISNULL(TipoCliente, -1)    
      FROM  #paso_compras     
      WHERE (EstadoOpe      = @S_Operacion OR @S_Operacion  = 'T')    
      AND   (Tipo_operacion = @T_Operacion OR @T_Operacion  = '')    
      AND   (NombreMoneda   = @Moneda      OR @Moneda       = '')    
      AND   (Usuario        = @Usuario     OR @Usuario      = '')    
               ORDER BY Numero_Operacion    
    
    
    
 /*=======================================================================*/    
 -------------------------- INICIO OPCIONES 02/06/2009 --------------------    
 /*=======================================================================*/    
    
     
        SELECT @Fecha_ProcesoOPT = CONVERT(CHAR(08),fechaproc,112)  FROM LnkOpc.CbMdbOpcNY.dbo.OpcionesGeneral    
    
            
        -- CER 26 Oct. 2009 . Descartar operaciones anuladas                
        SELECT  MoNumContrato INTO #Anuladas     
        FROM  LnkOpc.CbMdbOpcNY.DBO.MoEncContrato WHERE MoTipoTransaccion = 'ANULA'    
    
    
        INSERT INTO  #TEMP_MOVIMIENTOS       
        SELECT       'Modulo'      = 'OPT'    
                     ,'N_Operacion'  = A.MoNumContrato    
                     ,'N_documento'  = A.MoNumFolio     
                     ,'Correlativo'  = 0     
                     ,'T_Operacion'  = OpcEstDsc + ' ' +(Case when A.MoCVEstructura ='C' then 'COMPRA' ELSE 'VENTA' END)    
                     ,'Moneda_Oper'  = C.mnnemo    
                     ,'Nom_Cliente'  = D.clnombre       
                     ,'Monto_Oper'   = MAX(B.MoMontoMon1)       
                     ,'Monto_Pesos'  = MAX(B.MoMontoMon1)     
                     ,'Tasa'        = 0.0    
                     ,'Precio'      = CONVERT(NUMERIC(19,4),MAX(B.MoStrike))      
                     ,'S_Operacion'  = CASE A.MoEstado WHEN 'P' THEN 'PENDIENTE'    
                                                       WHEN 'R' THEN 'RECHAZADA'    
                                                       ELSE          'APROBADA'      
                                       END     
                     ,'Usuario'      = A.MoOperador                
                     ,'FP_Pagamos'   = ''  -- E.glosa  -- MAP 07 Octubre    
                     ,'FP_Recibimos' = ''  -- F.glosa    -- MAP 07 Octubre    
                     ,'Fecha'        = A.MoFechaContrato     
                     ,'Supervisor'   = A.MoOperador     
                     ,'Mercado'      = CONVERT(CHAR(03),'OPT')    
                     ,'tipop'      = A.MoCVEstructura    
                     ,'SwImpre'      = CASE WHEN A.MoImpreso = 'N' THEN 0 ELSE 1 END    
       ,'TipoCliente'  = ISNULL(cltipcli, -1)         -- MAP 07 Octubre    
    
        FROM LnkOpc.CbMdbOpcNY.dbo.MoEncContrato A    
           , LnkOpc.CbMdbOpcNY.dbo.MoDetContrato B    
           , VIEW_MONEDA   C    
           , VIEW_CLIENTE  D     
--           ,VIEW_FORMA_DE_PAGO E -- MAP 07 Octubre    
--           ,VIEW_FORMA_DE_PAGO F -- MAP 07 Octubre    
           ,LnkOpc.CbMdbOpcNY.dbo.OpcionEstructura       
        WHERE A.MoNumFolio      = B.MoNumFolio    
        AND  (@Moneda           = ''  OR  C.mnnemo = @Moneda)              
        AND   (B.MoCodMon1      = C.mncodmon )     
        AND   A.MoRutCliente    = D.clrut     
        AND   A.MoCodigo        = D.clCodigo         
--        AND   B.MoFormaPagoMon1 = E.codigo    
--        AND   B.MoFormaPagoMon2 = F.codigo    
        AND   A.MoCodEstructura = OpcEstCod    
        AND  (A.MoEstado   = @S_Operacion  OR @S_Operacion = 'T')    
        AND  (A.MoEstado <> 'N') -- 10449 PAE se detecta error preexistente y se corrige  
        AND  (@T_Operacion  = ''  OR  A.MoCVEstructura = @T_Operacion )    
    AND  (@Moneda       = ''  OR  C.mnnemo = @Moneda )    
--    AND  (@FP_Pagamos   = 0   OR  B.MoFormaPagoMon1  = @FP_Pagamos )    
--        AND  (@FP_Recibimos = 0   OR  B.MoFormaPagoMon2  = @FP_Recibimos )    
        AND  (@Usuario      = ''  OR  A.MoOperador   = @Usuario )    
    
--        AND A.MoEstado = 'P'        
-- MAP 29 Octubre , no habria que filtrar por el estado, esto lo hace la pantalla    
    
        and A.MoNumcontrato not in ( select MoNumContrato from #Anuladas )  -- CER 26 Oct. 2009 . Descartar operaciones anuladas                     
        GROUP BY A.MoNumContrato    
                ,A.MoNumFolio     
                ,A.MoCVEstructura    
                ,C.mnnemo    
                ,D.clnombre    
                ,A.MoEstado    
                ,A.MoOperador    
--                ,E.glosa     -- MAP 07 Octubre    
--                ,F.glosa     -- MAP 07 Octubre    
                ,A.MoFechaContrato     
                ,A.MoImpreso    
                ,OpcEstDsc    
                ,ClTipCli    
        ORDER BY A.MoNumContrato    
    
        IF @@ERROR <> 0 BEGIN    
           PRINT 'ERROR AL INSERTAR DESDE OPCIONES'     
           RETURN    
        END    
    
        /*=======================================================================*/    
        ----------------------- FIN OPCIONES 02/06/2009 --------------------------    
        /*=======================================================================*/    
    
    
      -----------------------------------Bonos Exterior--------------------------------    
      DECLARE @Fec_ProcBex    DATETIME    
         SET  @Fec_ProcBex    = (SELECT CONVERT(CHAR(08),acfecproc,112) FROM BacBonosExtNY.dbo.TEXT_ARC_CTL_DRI with(nolock))    
    
      INSERT INTO  #TEMP_MOVIMIENTOS       
      SELECT 'Modulo'           = 'BEX'    
	  --SELECT 'Modulo'           = 'BTR'    
      ,      'N_Operacion'      = a.monumoper    
      ,      'N_documento'      = a.monumoper    
      ,      'Correlativo'      = 0    
      ,      'T_Operacion'      = case when a.motipoper ='CP' then 'COMPRA' ELSE 'VENTA' END    
      ,      'Moneda'           = c.mnnemo    
      ,      'NomCliente'       = ISNULL(clnombre, 'NO EXISTE')    
      ,      'Monto_Oper'       = sum(a.movalcomu)    
      ,      'Monto_pesos'      = sum(a.monominal)    
      ,      'Tasa'         = a.motasemi    
      ,      'Precio'           = 0.0    
      ,      'S_Operacion'      = CASE WHEN a.mostatreg = 'P' THEN 'PENDIENTE'    
           WHEN a.mostatreg = 'R' THEN 'RECHAZADA'    
                  ELSE                        'APROBADA'    
      END    
      ,      'Usuario'          = a.mousuario    
      ,      'FP_Pagamos'       = (select glosa from view_forma_de_pago where  a.forma_pago=codigo)    
      ,      'FP_Recibimos'     = (select glosa from view_forma_de_pago where  a.forma_pago=codigo)    
      ,      'Fecha'         = a.mofecpago    
      ,      'Supervisor'       = a.mousuario    
      ,      'Mercado'          = ''    
      ,      'tipop'         = a.motipoper    
      ,      'SwImpre'          = a.SwImpresion    
      ,      'TipoCliente'      = ISNULL(cltipcli, 0)    
      FROM   VIEW_text_mvt_dri_NY A    
             LEFT JOIN BacParamSuda.dbo.CLIENTE with(nolock) ON clrut = a.morutcli AND clcodigo = a.mocodcli    
      ,      VIEW_TEXT_FML_INM B    
      ,      VIEW_MONEDA       C    
      WHERE  a.mofecpro    = @Fec_ProcBex     
--    AND    a.mofecpro    = a.mofecneg    
--    AND    a.mofecneg   >= @Fec_ProcBex     
      AND    a.cod_familia = b.cod_familia    
      AND    motipoper     IN('CP','VP')    
      AND    mostatreg     <> 'A'     
      AND    a.momonemi    = c.mncodmon    
    
      AND   (a.mostatreg   = @S_Operacion OR @S_Operacion = 'T')    
      AND   (@T_Operacion  = ''           OR a.motipoper  = @T_Operacion )      
      AND   (@Moneda       = ''           OR c.mnnemo     = @Moneda )           
      AND   (@Usuario      = ''           OR a.mousuario  = @Usuario )          
      GROUP BY a.monumoper, a.motipoper, a.momonemi, a.morutcart, a.motasemi, a.mousuario, a.SwImpresion, a.forma_pago, c.mnnemo, b.nom_familia    
             , a.mofecpago, a.morutcli, a.mocodcli, a.mostatreg, a.confirmacion, cltipcli, clnombre    
      ORDER BY monumoper    
    
    
      IF @@ERROR <> 0     
      BEGIN    
         PRINT 'ERROR AL INSERTAR DESDE INVERSION EXTERIOR'    
         RETURN    
      END    
    
      INSERT INTO #TEMP_PAPELETAS    
      (      /*001*/ Modulo     
      ,      /*002*/ N_Operacion    
      ,      /*003*/ N_documento    
      ,      /*004*/ Correlativo    
      ,      /*005*/ T_Operacion    
      ,      /*006*/ Moneda_Oper    
      ,      /*007*/ Nom_Cliente    
      ,      /*008*/ Monto_Oper    
      ,      /*009*/ Monto_Pesos    
      ,      /*010*/ Tasa    
      ,      /*011*/ Precio    
      ,      /*012*/ S_Operacion    
      ,      /*013*/ Usuario    
      ,      /*014*/ FP_Pagamos    
      ,      /*015*/ FP_Recibimos    
      ,      /*016*/ Fecha    
      ,      /*017*/ Supervisor    
      ,      /*018*/ Mercado    
      ,      /*019*/ TipoperRF    
      ,      /*020*/ SwImpre    
      ,      /*021*/ Rutcartera    
      ,      /*022*/ FirmaSup1    
      ,      /*023*/ FirmaSup2    
      ,      /*024*/ TipoCliente    
      )    
      SELECT /*001*/ Modulo    
      ,      /*002*/ N_Operacion    
      ,      /*003*/ N_documento    
      ,      /*004*/ Correlativo    
      ,      /*005*/ T_Operacion    
      ,      /*006*/ Moneda_Oper    
      ,      /*007*/ Nom_Cliente    
      ,  /*008*/ Monto_Oper    
      ,      /*009*/ Monto_Pesos    
      ,      /*010*/ Tasa    
      ,      /*011*/ Precio    
      ,      /*012*/ S_Operacion    
      ,      /*013*/ Usuario    
      ,      /*014*/ FP_Pagamos    
      ,      /*015*/ FP_Recibimos    
      ,      /*016*/ Fecha    
      ,      /*017*/ Supervisor    
      ,      /*018*/ Mercado    
      ,  /*019*/ Tipop    
   ,      /*020*/ SwImpre    
      ,      /*021*/ 0    
      ,      /*022*/ ''    
      ,      /*023*/ ''    
      ,      /*024*/ TipoCliente    
      FROM  #TEMP_MOVIMIENTOS    
    
    
 INSERT INTO  #TEMP_PAPELETAS        
      SELECT Modulo       = a.Modulo    
      ,  N_Operacion  = a.N_Operacion    
      ,      N_documento  = a.N_Documento    
      ,      Correlativo  = a.Correlativo    
      ,      T_Operacion  = d.descripcion    
      ,      Moneda_Oper  = a.Moneda    
      ,      Nom_Cliente  = a.Nom_Cliente    
      ,      Monto_Oper   = a.Monto_Oper    
      ,      Monto_Pesos  = 0.0    
      ,      Tasa         = a.Tasa    
      ,      Precio       = 0.0    
      ,      S_Operacion  = CASE WHEN a.S_Operacion = 'P' THEN 'PENDIENTE'    
                                 WHEN a.S_Operacion = 'R' THEN 'RECHAZADA'    
                                 ELSE                          'APROBADA'      
             END    
      ,      Usuario      = a.oper    
      ,      FP_Pagamos   = b.glosa    
      ,      FP_Recibimos = c.glosa    
      ,      Fecha        = a.fecha    
      ,      Supervisor   = a.Supervisor    
      ,      Mercado      = a.tipoper    
      ,      TipoperRF    = a.tipoper    
      ,      SwImpre      = a.SwImpre    
      ,      Rutcartera   = a.rutcartera    
      ,      FirmaSup1    = ''    
      ,      FirmaSup2    = ''    
      ,      TipoCliente  = TipoCliente    
      FROM   #TMP                               a     
             INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO      b with(nolock) ON b.codigo = a.FP_Pagamos    
             INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO      c with(nolock) ON c.codigo = a.FP_Pagamos    
             INNER JOIN BacParamSuda.dbo.OPERACION_PRODUCTO d with(nolock) ON d.id_sistema = a.Modulo AND d.codigo = a.T_Operacion    
      WHERE (S_Operacion   = @S_Operacion OR @S_Operacion  = 'T')       
      AND   (T_Operacion   = @T_Operacion OR @T_Operacion  = '')    
      AND   (a.oper        = @Usuario     OR @Usuario      = '')    
      AND   (a.moneda      = @Moneda      OR @Moneda       = '')    
    
      INSERT INTO  #TEMP_PAPELETAS        
      SELECT Modulo       = a.Modulo    
      ,    N_Operacion  = a.N_Operacion    
      ,      N_documento  = a.N_Documento    
      ,      Correlativo  = a.Correlativo    
      ,      T_Operacion  = d.descripcion    
      ,      Moneda_Oper  = a.Moneda    
      ,      Nom_Cliente  = a.Nom_Cliente    
      ,      Monto_Oper   = a.Monto_Oper    
      ,      Monto_Pesos  = 0.0    
      ,      Tasa         = a.Tasa    
      ,      Precio       = 0.0    
      ,      S_Operacion  = CASE WHEN a.S_Operacion = 'P' THEN 'PENDIENTE'    
                                 WHEN a.S_Operacion = 'R' THEN 'RECHAZADA'    
                                 ELSE                          'APROBADA'     
                            END    
      ,      Usuario      = a.oper    
      ,      FP_Pagamos   = ''    
      ,      FP_Recibimos = c.glosa    
      ,      Fecha        = a.fecha    
      ,      Supervisor   = a.Supervisor    
      ,      Mercado      = a.tipoper    
      ,      TipoperRF    = a.tipoper    
      ,      SwImpre      = a.SwImpre    
      ,      Rutcartera   = a.rutcartera    
      ,      FirmaSup1    = ''    
      ,      FirmaSup2    = ''    
      ,      TipoCliente  = TipoCliente    
      FROM   #TMP                               a    
      INNER JOIN BacParamSuda.dbo.FORMA_DE_PAGO      c with(nolock) ON c.codigo = a.FP_Recibimos    
      INNER JOIN BacParamSuda.dbo.OPERACION_PRODUCTO d with(nolock) ON d.id_sistema = a.Modulo AND d.codigo = a.T_Operacion    
      WHERE  a.T_Operacion = 'RVA'    
      AND   (S_Operacion   = @S_Operacion OR @S_Operacion = 'T')       
      AND   (T_Operacion   = @T_Operacion OR @T_Operacion = '')  
      AND   (a.oper        = @Usuario     OR @Usuario     = '')  
      AND   (a.moneda      = @Moneda      OR @Moneda      = '')    
    



   update #TEMP_PAPELETAS        
 set Supervisor = a.Operador_Origen          
           ,FirmaSup1 = a.Firma1    
           ,FirmaSup2 = a.Firma2    
        from  DETALLE_APROBACIONES a    
        where N_Operacion = a.Numero_Operacion    
          and Firma1 <>'FALTA'    
          AND Modulo = a.Id_Sistema    


--/PRD-21039
		 update #TEMP_PAPELETAS        
		set Supervisor = a.Operador_Origen          
           ,FirmaSup1 = a.Firma1    
           ,FirmaSup2 = a.Firma2    
        from  DETALLE_APROBACIONES a    
        where N_Operacion = a.Numero_Operacion    
          and Firma1 <>'FALTA'    
          AND 'BTR' = a.Id_Sistema    
--/PRD-21039


    
      UPDATE #TEMP_PAPELETAS    
         SET MERCADO   = CASE WHEN T_Operacion = 'COMPRA' THEN 'CPX' ELSE 'VPX' END    
       WHERE Modulo    = 'BEX'    
    
      DELETE FROM #TEMP_PAPELETAS    
             WHERE MODULO NOT IN(SELECT DISTINCT sistema FROM BacLineas.dbo.PERFIL_USUARIO_LINEAS WHERE usuario = @UsuarioControl AND activado = 1)    
    
      SELECT tmp.* FROM #TEMP_PAPELETAS tmp    
                   INNER JOIN BacLineas.dbo.PERFIL_USUARIO_LINEAS usr ON usr.Usuario      = @UsuarioControl    
                                                                     and usr.sistema      = tmp.MODULO    
                                                                     and usr.Producto     = CASE WHEN tmp.MERCADO = 'MONEDA' THEN 'SM'    
                                                                                                 WHEN tmp.MERCADO = 'TASA'   THEN 'ST'    
                                                                                                 WHEN tmp.MERCADO = 'FRA'    THEN 'FR'    
                                                                                                 WHEN tmp.MERCADO = 'PROM.C' THEN 'SP'    
      WHEN tmp.MERCADO = 'IB'     THEN 'ICAP'    
                                                                                                 WHEN tmp.MERCADO = 'IB'     THEN 'ICOL'    
                                                                                                 ELSE                             tmp.MERCADO    
                                                                                            END    
                                                                     and usr.Tipo_Cliente = tmp.TipoCliente    
                                                                     and usr.Activado     = 1    
      WHERE (tmp.MODULO = @Modulo OR @Modulo = '')    
      ORDER BY tmp.modulo, tmp.n_operacion     
    
END

GO
