USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REPORTEEXCESOS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_REPORTEEXCESOS]
AS
BEGIN
 DECLARE @Cont   INTEGER
 DECLARE @Regs   INTEGER
 DECLARE @Rut_Cliente  NUMERIC(10)
 DECLARE @Codigo_Rut  NUMERIC(05)
 DECLARE @Operacion  NUMERIC(10)
 DECLARE @Correlativo  NUMERIC(5)
 DECLARE @Codigo       NUMERIC(5)
 DECLARE @Tipo_Limite  CHAR(10)
 DECLARE @Tipo_Limite_Aux CHAR(10)
 DECLARE @Veces   NUMERIC(10)
 DECLARE @tipo_operacion  CHAR(5)
 DECLARE @Plazo   NUMERIC(5)
 DECLARE @Plazo_Linea  NUMERIC(5)
 DECLARE @Sistema  CHAR(3)
 DECLARE @Instrumento  CHAR(3)
 CREATE TABLE #EXCESOS( rut_grupo           CHAR(12)    NULL DEFAULT '' ,
                        nombre_grupo        CHAR(50)    NULL DEFAULT '' ,
                        rut_contraparte     CHAR(12)    NULL DEFAULT '' ,
                        nombre_contraparte  CHAR(50)    NULL DEFAULT '' ,
                        operacion           NUMERIC(10) NULL DEFAULT 0  ,
                        correlativo         NUMERIC(5)  NULL DEFAULT 0  ,
                        monto_exceso        FLOAT       NULL DEFAULT 0  ,
                        tipo_operacion      CHAR(5)     NULL DEFAULT '' ,
                        monto_asignado      FLOAT       NULL DEFAULT 0  ,
                        monto_ocupado       FLOAT       NULL DEFAULT 0  ,
                        tipo_limite         CHAR(10)    NULL DEFAULT '' ,
                        riesgo              CHAR(10)    NULL DEFAULT '' ,
                        sistema             CHAR(3)     NULL DEFAULT '' ,
                        rut_cliente         NUMERIC(10) NULL DEFAULT 0  ,
                        producto            CHAR(10)    NULL DEFAULT '' ,
                        plazo               NUMERIC(5)  NULL DEFAULT 0  ,
                        codigo              NUMERIC(10) NULL DEFAULT 0  )
 CREATE TABLE #EXCESOS2 (rut_grupo           CHAR(12)    NULL DEFAULT '' ,
                        nombre_grupo        CHAR(50)    NULL DEFAULT '' ,
                        rut_contraparte     CHAR(12)    NULL DEFAULT '' ,
                        nombre_contraparte  CHAR(50)    NULL DEFAULT '' ,
                        operacion           NUMERIC(10) NULL DEFAULT 0  ,
                        correlativo         NUMERIC(5)  NULL DEFAULT 0  ,
                        monto_exceso        FLOAT       NULL DEFAULT 0  ,
                        tipo_operacion      CHAR(5)     NULL DEFAULT '' ,
                        monto_asignado      FLOAT       NULL DEFAULT 0  ,
                        monto_ocupado       FLOAT       NULL DEFAULT 0  ,
                        tipo_limite         CHAR(10)    NULL DEFAULT '' ,
                        riesgo              CHAR(10)    NULL DEFAULT '' ,
                        sistema             CHAR(3)     NULL DEFAULT '' ,
                        rut_cliente         nUMERIC(10) NULL DEFAULT 0  ,
                        producto            CHAR(10)    NULL DEFAULT '' ,
                        plazo               NUMERIC(5)  NULL DEFAULT 0  ,
                        codigo              NUMERIC(10) NULL DEFAULT 0  )
 INSERT INTO #EXCESOS
  SELECT  SPACE(12),
                        SPACE(50)     ,
                        SPACE(12)     ,
                        SPACE(50)     ,
                        operacion     ,
                        correlativo     ,
                        monto_exceso     ,
                        tipo_operacion     ,
                        CONVERT(FLOAT,0.00)    ,
                        monto_ocupado     ,
                        (CASE 
                         WHEN tipo_limites = 'EMIPLZ' THEN 'EMISOR'
                         WHEN tipo_limites = 'PFECCE' THEN (CASE codigo_exceso WHEN 1 THEN 'PFE'
                                                                               WHEN 2 THEN 'CCE'
                                                                               WHEN 3 THEN 'PFE'
         WHEN 4 THEN 'CCE'
              END)
                        END)      ,
                        SPACE(10)     ,
                        id_sistema     ,
                        rut_cliente     ,
                        SPACE(10)     ,
                        plazo      ,
                        codigo_rut
     FROM MD_EXCESO_LIMITES
                  WHERE monto_exceso  > 0
                    AND tipo_limites <> 'SETTLE'
                    AND estado       <> 'A'
      AND rut_cliente  <> 97029000 
 UPDATE #Excesos SET #Excesos.monto_asignado = MD_PFE_CCE.monto_asignado
    FROM MD_PFE_CCE
    WHERE  #Excesos.rut_cliente  =  MD_PFE_CCE.rut AND
      #Excesos.tipo_limite  =  'PFE'   AND
      #Excesos.sistema =  MD_PFE_CCE.productos AND
      #Excesos.plazo         >= MD_PFE_CCE.plazo_ini AND
      #Excesos.Plazo         <= MD_PFE_CCE.plazo_fin
     
 UPDATE #Excesos SET #Excesos.monto_asignado = MD_PFE_CCE.monto_asignado
    FROM MD_PFE_CCE
    WHERE #Excesos.rut_cliente = MD_PFE_CCE.rut  AND
     #Excesos.tipo_limite = 'CCE'    AND
     #Excesos.sistema     = MD_PFE_CCE.productos   AND
     #Excesos.plazo       >= MD_PFE_CCE.plazo_ini  AND
     #Excesos.plazo      <= MD_PFE_CCE.plazo_fin
        UPDATE #Excesos SET #Excesos.monto_asignado = MD_EMISOR_INST_PLAZO.monto_asignado
    FROM 
    MD_EMISOR_INST_PLAZO    
    WHERE MD_EMISOR_INST_PLAZO.rut = #Excesos.rut_cliente  AND
     #Excesos.tipo_limite = 'EMISOR'     AND
     #Excesos.plazo       >= MD_EMISOR_INST_PLAZO.plazo_ini  AND
     #Excesos.plazo      <= MD_EMISOR_INST_PLAZO.plazo_fin
 UPDATE #Excesos SET #Excesos.Producto = CASE #Excesos.Sistema WHEN 'BTR' THEN 'SECURITIES'
           WHEN 'BFW' THEN 'FX FORWARD' END 
 SELECT @Cont = 1
 SELECT @Regs = COUNT(*) FROM #Excesos
 WHILE @Cont <= @Regs
 BEGIN
  SET rowcount @Cont 
  
  SELECT  @Rut_Cliente  = rut_cliente    ,
   @Codigo_Rut = codigo  ,
   @Tipo_Limite = tipo_limite    ,
   @tipo_operacion = tipo_operacion ,
   @Operacion = operacion  ,
   @Correlativo = correlativo  ,
   @Plazo  = plazo   ,
   @Sistema = sistema
                   FROM #Excesos
    ORDER BY operacion, correlativo
  SET ROWCOUNT 0
  SELECT @Cont = @Cont + 1
  IF @Tipo_Limite = 'EMISOR'
  BEGIN
                   IF @tipo_operacion = 'CI' OR @tipo_operacion = 'IB'
                      SELECT @Codigo = CICODIGO FROM MDCI WHERE cinumdocu = @Operacion
                   IF @tipo_operacion = 'VI'
                      SELECT @Codigo = VICODIGO FROM MDVI WHERE vinumoper = @Operacion
                   IF @tipo_operacion = 'CP'
                      SELECT @Codigo = CPCODIGO FROM MDCP WHERE cpnumdocu = @Operacion
                   SELECT @Instrumento = intiporig,
                          @Tipo_Limite = (CASE 
                                          WHEN intiporig = 'MM' THEN 'M. MARKET'
                                          WHEN intiporig = 'FI' THEN 'F. INCOME'
                                          ELSE                       'S. TERM'                                           
                                         END)
                                 FROM VIEW_INSTRUMENTO
                                WHERE INCODIGO = @Codigo
            SELECT @Plazo_Linea = @Plazo
            SELECT @Plazo_Linea = Plazo_Fin
              FROM MD_EMISOR_INST_PLAZO
             WHERE rut         = @Rut_Cliente
               AND instrumento = @Instrumento
               AND plazo_ini  <= @Plazo
               AND plazo_fin  >= @Plazo
                   UPDATE #Excesos SET tipo_limite    = @Tipo_Limite,
                                       plazo          = @Plazo_Linea
                                 WHERE tipo_operacion = @tipo_operacion
                                   AND operacion      = @Operacion
       AND correlativo    = @Correlativo
       AND plazo       = @Plazo
  END
  ELSE
  IF @Tipo_Limite = 'PFE' OR @Tipo_Limite = 'CCE'
  BEGIN
                   IF @Tipo_Limite = 'CCE'
                      SELECT @Tipo_Limite_Aux = 'PFE'
                   IF @Tipo_Limite = 'PFE'
                      SELECT @Tipo_Limite_Aux = 'CCE'
                   IF NOT EXISTS(SELECT * FROM #Excesos2 WHERE rut_cliente  = @Rut_Cliente  AND
                                                               L= @Codigo_Rut   AND
                                                               tipo_limite <> @Tipo_Limite  AND
              plazo        = @Plazo )
                      INSERT #Excesos2( rut_grupo    ,
                                        nombre_grupo    ,
                                        rut_contraparte    ,
                                        nombre_contraparte   ,
                                        operacion    ,
                                        correlativo    ,
                                        monto_exceso    ,
                                        tipo_operacion    ,
                                        monto_asignado    ,
                                        monto_ocupado    ,
                                        tipo_limite    ,
                                        riesgo     ,
                                        sistema     ,
                                        rut_cliente    ,
                                        producto    ,
                                        plazo     ,
                                        codigo     )
                                 SELECT #Excesos.rut_grupo     ,
                                        #Excesos.nombre_grupo     ,
                                        #Excesos.rut_contraparte    ,
                                        #Excesos.nombre_contraparte    ,
                                        #Excesos.operacion     ,
                                        #Excesos.correlativo     ,
                                        0       ,
                                        #Excesos.tipo_operacion     ,
                                        ISNULL((SELECT sum(md_pfe_cce.monto_asignado) FROM MD_PFE_CCE WHERE rut = @Rut_Cliente AND Codigo = @Codigo_Rut AND tipo_limite = @Tipo_Limite AND plazo_fin >= @Plazo), 0.0),
                                        0.0       ,
                                        @Tipo_Limite_Aux     ,
                                        #Excesos.riesgo      ,
                                        #Excesos.sistema     ,
                                        #Excesos.rut_cliente     ,
                                        #Excesos.producto     ,
                                        #Excesos.plazo      ,
                                        #Excesos.codigo
                                   FROM #Excesos
                                  WHERE #Excesos.rut_cliente = @Rut_Cliente
                                    AND #Excesos.codigo  = @Codigo_Rut
                                    AND #Excesos.tipo_limite = @Tipo_Limite
                                    AND #Excesos.plazo   = @Plazo
  END
 END
        INSERT INTO #Excesos SELECT * FROM #Excesos2
 UPDATE #Excesos SET rut_grupo =  RTRIM(CONVERT(CHAR(09),clrut)) + '/' + CONVERT(CHAR(02),clcodigo) ,
       nombre_grupo=clnombre        ,
       rut_contraparte=RTRIM(CONVERT(CHAR(09),clrut)) + '/' + CONVERT(CHAR(02),clcodigo) ,
       nombre_contraparte=clnombre        ,
       riesgo = RTRIM(ISNULL(CLCRF,''))+ '/' +RTRIM(ISNULL(CLERF,''))
   FROM VIEW_CLIENTE
  WHERE clrut    = rut_cliente
    AND clcodigo = codigo
 UPDATE #Excesos SET nombre_grupo = VIEW_CLIENTE.clnombre
     FROM VIEW_CLIENTE_RELACIONADO A,
        VIEW_CLIENTE B
  WHERE A.clrut_hijo     = rut_cliente
    AND A.clcodigo_hijo  = codigo
    AND A.clrut_padre    = B.clrut
    AND A.clcodigo_padre = B.clcodigo
 UPDATE #Excesos SET plazo = MD_PFE_CCE.plazo_fin
   FROM MD_PFE_CCE
  WHERE MD_PFE_CCE.rut        = #Excesos.rut_cliente
    AND MD_PFE_CCE.codigo     = #Excesos.codigo
    AND MD_PFE_CCE.productos  = #Excesos.sistema
    AND MD_PFE_CCE.plazo_ini <= #Excesos.plazo
    AND MD_PFE_CCE.plazo_fin >= #Excesos.plazo
    AND (#Excesos.tipo_limite = 'PFE' OR #Excesos.tipo_limite = 'CCE')
 SELECT rut_grupo     ,
  nombre_grupo     ,
  rut_contraparte     ,
  nombre_contraparte    ,
--  operacion     ,
--  Correlativo     ,
    0      ,
    0      ,
  'Exceso' = ISNULL(-(sum(monto_exceso) / 1000.0),0.0),
--  tipo_operacion     ,
    ''      ,
  'Asignado' = ISNULL((sum(monto_asignado) / 1000.0),0.0),
  'Usado'    = ISNULL((sum(monto_ocupado)  / 1000.0),0.0),
  tipo_limite     ,
  riesgo      ,
  producto     ,
  plazo
  FROM #Excesos
  WHERE Rut_Grupo <> ''
  GROUP BY rut_grupo,
    nombre_grupo,
    rut_contraparte,
    nombre_contraparte,
    tipo_limite,
    riesgo,
    producto,
    plazo
  ORDER BY rut_grupo,
    nombre_grupo,
    rut_contraparte,
    nombre_contraparte,
    riesgo,
    plazo,
    tipo_limite,
    producto
    
END   /* FIN PROCEDIMIENTO */
-- Sp_ReporteExcesos
-- SELECT * FROM MD_EXCESO_LIMITES

GO
