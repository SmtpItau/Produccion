USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_TABLAS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_TABLAS]   
   (   @archivo    CHAR(25)  
   ,   @filtro     CHAR(20)  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE  @fecha_desde     CHAR(8)  
   ,        @fecha_hasta     CHAR(8)  
   ,        @tabla           VARCHAR(250)  
   ,        @filtros         VARCHAR(250)  
   ,        @proceso         VARCHAR(550)  
   ,        @campos          VARCHAR(150)  
   ,        @id_sistema      CHAR(3)  
   ,        @tipo_movimiento CHAR(3)  
   ,        @tipo_operacion  CHAR(5)  
  
   IF @Archivo = 'BAC_CNT_MOVIMIENTO'  
   BEGIN  
      SELECT glosa_operacion  
      ,      tipo_operacion  
      FROM   MOVIMIENTO_CNT   
      WHERE  id_sistema      = @filtro  
      AND    tipo_movimiento = 'MOV'  
   END  
  
   IF @archivo = 'BAC_CNT_SISTEMAS'  
   BEGIN  
      SELECT nombre_sistema  
      ,      id_sistema   
      FROM   SISTEMA_CNT  
      WHERE  operativo = 'S'  
   END  
  
   IF @archivo = 'CON_PLAN_CUENTAS1'  
      SELECT cuenta,              --    SELECT * FROM Plan_de_Cuenta  
             descripcion,  
             glosa,  
             tipo_moneda,   
             cta_sbif,  
             tipo_cuenta,  
             con_centro_costo   
      FROM   PLAN_DE_CUENTA  
      WHERE  cuenta = @filtro  
      ORDER BY cuenta  
  
   IF @archivo = 'CON_CAMPOS_PERFIL'  
   BEGIN  
      SELECT CONVERT( CHAR(3), codigo_campo )  
      ,      descripcion_campo  
      ,      *   
      FROM   CAMPO_CNT  
      WHERE  id_sistema                = SUBSTRING(@filtro,1,3)   
      AND    tipo_movimiento           = SUBSTRING(@filtro,4,3)   
      AND    tipo_administracion_campo = 'F'   
      AND    tipo_operacion            = RTRIM(SUBSTRING(@filtro,7,5))  
   END  
  
   IF @archivo = 'BAC_CNT_PERFIL'  
   BEGIN  
      SELECT CONVERT(CHAR(10),folio_perfil)   
      ,      glosa_perfil  
      FROM   PERFIL_CNT  
      WHERE (id_sistema = @filtro or @filtro = '')  
      ORDER BY glosa_perfil --folio_perfil  
   END  
  
   IF @archivo = 'GEN_TABLAS1'  
   BEGIN  
      SELECT @id_sistema      = SUBSTRING(@filtro,1,3)  
      SELECT @tipo_movimiento = SUBSTRING(@filtro,4,3)  
      SELECT @tipo_operacion  = RTRIM(SUBSTRING(@filtro,7,5))  
      SELECT @filtro          = SUBSTRING(@filtro,12,5)  
  
      SELECT @tabla           = tabla_campo     
      ,      @filtros         = isnull(campo_tabla,'')     
      ,      @campos          = isnull(campos_tablas,'')   
      FROM   CAMPO_CNT  
      WHERE codigo_campo      = CONVERT(NUMERIC(05),@filtro )  
      AND   id_sistema        = @id_sistema    
      AND   tipo_movimiento   = @tipo_movimiento  
      AND   tipo_operacion    = @tipo_operacion  
  
      SELECT @proceso = 'SELECT '+ LTRIM(RTRIM(@campos)) + ' FROM ' + LTRIM(RTRIM(@tabla)) + ' ' + RTRIM(@filtros)  
  
      EXECUTE (@proceso)  
   END  
  
   IF @archivo = 'MDCL_BANCOS'  
   BEGIN  
      SELECT STR(cod_inst,4), clnombre   
      FROM   CLIENTE   
      WHERE  cltipcli  = 1  
      AND    cod_inst <> 0  
   END  
  
   IF @archivo = 'LIQMX'  
   BEGIN  
      SELECT mnnemo  
      ,      mnglosa  
      FROM   MONEDA  
      WHERE (mnmx = 'C' OR mncodmon = 999)  
   END  
  
   IF @archivo = 'MDFP_TESOR'  
   BEGIN  
      SELECT CONVERT(CHAR(5),codigo)  
      ,      glosa  
      FROM   FORMA_DE_PAGO  
      WHERE  cc2756 = (CASE WHEN RTRIM(@filtro) = '$$' THEN 'N' ELSE 'S' END)  
   END  
  
   IF @archivo = 'BAC_CNT_CAMPOS'  
   BEGIN  
      SELECT codigo_campo  
      ,      descripcion_campo   
      ,      id_sistema    
      ,      nombre_campo_tabla  
      ,      tipo_administracion_campo  
      FROM   CAMPO_CNT   
      WHERE (@filtro         = '' OR id_sistema = @filtro)   
      AND    tipo_operacion  = ''  
      AND    tipo_movimiento = ''  
   END  
  
   IF @archivo = 'CON_PLAN_CUENTAS'  
      SELECT cuenta  
      ,      descripcion  
      ,      glosa  
      ,      tipo_moneda  
      ,      tipo_cuenta  
      FROM   PLAN_DE_CUENTA  
      ORDER BY cuenta  
  
   IF @archivo = 'CON_MON_CUENTAS'  
      SELECT DISTINCT(mncodfox)  
      FROM MONEDA  
      ORDER BY mncodfox  
  
SET NOCOUNT OFF  
END  
GO
