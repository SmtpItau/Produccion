USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [bacuser].[SVC_PERFILES_MODULO]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [bacuser].[SVC_PERFILES_MODULO]
   (   @Modulo   CHAR(3)   )
AS
BEGIN

   SET NOCOUNT ON

   CREATE TABLE #TEMP2 
   (   sistema            CHAR(10)
   ,   movimiento         CHAR(15)
   ,   operacion          CHAR(30)
   ,   folio_perfil       NUMERIC(5)
   ,   codigo_instrumento CHAR(10)
   ,   glosa_instrumento  CHAR(35)
   ,   codigo_moneda      CHAR(5)
   ,   glosa_moneda       CHAR(20)
   ,   tipo_voucher       CHAR(12)
   ,   glosa_perfil       CHAR(70)
   )

   CREATE TABLE #TEMP1
   (   codigo_campo                NUMERIC(5)
   ,   tipo_movimiento_cuenta      CHAR(1)
   ,   perfil_fijo                 CHAR(1)
   ,   codigo_cuenta               CHAR(20)
   ,   correlativo_perfil          NUMERIC(5)
   ,   codigo_campo_variable       NUMERIC(5)
   ,   descripcion_campo           CHAR(50)
   ,   descripcion                 CHAR(70)
   ,   valor_dato                  CHAR(30) 
   ,   codigo_cuenta_variable      CHAR(20) 
   ,   descripcion_campo_variable  CHAR(60) 
   ,   descripcion_cuenta_variable CHAR(70)
   )

   INSERT INTO #TEMP2 
   SELECT  'Sistema'            = CONVERT(CHAR(10),ltrim(rtrim(s.nombre_sistema)))
   ,       'Movimiento'         = CONVERT(CHAR(15),ltrim(rtrim(isnull(m.glosa_movimiento,''))))
   ,       'Operacion'          = CONVERT(CHAR(30),ltrim(rtrim(isnull(m.glosa_operacion,''))))
   ,       'Folio_Perfil'       = isnull(p.folio_perfil,0)
   ,       'Codigo_Instrumento' = CONVERT(CHAR(10),ltrim(rtrim(isnull(i.inglosa,''))))
   ,       'Glosa_Instrumento'  = CONVERT(CHAR(35),ltrim(rtrim(isnull(i.Inglosa,''))))

   ,       'Codigo_Moneda'      = CONVERT(CHAR(5) ,ltrim(rtrim(isnull(n.mnnemo,''))))
   ,       'Glosa_Moneda'       = CONVERT(CHAR(20),ltrim(rtrim(isnull(n.mnglosa,''))))
   ,       'Tipo_Voucher'       = CASE WHEN p.tipo_voucher = 'I' THEN 'INGRESO'
                                       WHEN p.tipo_voucher = 'E' THEN 'EGRESO'
                                       ELSE                           'TRASPASO'
                                  END
   ,       'Glosa_Perfil'       = CONVERT(CHAR(70),ltrim(rtrim(isnull(p.glosa_perfil,''))))
   FROM    PERFIL_CNT               p
           LEFT JOIN SISTEMA_CNT    s ON p.id_sistema = s.id_sistema
           LEFT JOIN MOVIMIENTO_CNT m ON p.id_sistema = m.id_sistema AND p.tipo_movimiento = m.tipo_movimiento AND p.tipo_operacion = m.tipo_operacion
           LEFT JOIN INSTRUMENTO    i ON i.inserie    = p.codigo_instrumento
           LEFT JOIN MONEDA         n ON n.mncodmon   = CASE WHEN p.id_sistema = 'BFW' THEN CONVERT(INTEGER,codigo_instrumento)
                                                             ELSE                           CONVERT(INTEGER,moneda_instrumento)
                                                        END
--   WHERE  p.Folio_Perfil             = 1530
   
   INSERT INTO #TEMP1
   SELECT isnull(d.codigo_campo,0)
   ,      isnull(d.tipo_movimiento_cuenta,'')
   ,      isnull(d.perfil_fijo,'')
   ,      CASE WHEN d.codigo_cuenta = '0' THEN '' ELSE isnull(d.codigo_cuenta,'') END
   ,      isnull(d.correlativo_perfil,0)
   ,      isnull(d.codigo_campo_variable,0)
   ,      CONVERT(CHAR(50),ltrim(rtrim(isnull(c.descripcion_campo,''))))
   ,      CASE WHEN isnull(u.descripcion,'') = '' AND isnull(d.perfil_fijo,'') = 'S' THEN 'No Existe'
               WHEN isnull(u.descripcion,'') = '' AND isnull(d.perfil_fijo,'') = 'N' THEN 'Perfil Variable Completo'
               ELSE                                                                        isnull(u.descripcion,'')
          END
   ,      ''
   ,      ''
   ,      isnull(v.descripcion_campo,'')
   ,      ''
   FROM   PERFIL_DETALLE_CNT       d
          LEFT JOIN PERFIL_CNT     p ON d.Folio_Perfil  = p.Folio_Perfil
          LEFT JOIN CAMPO_CNT      c ON p.id_sistema    = c.id_sistema AND p.tipo_movimiento = c.tipo_movimiento AND p.tipo_operacion = c.tipo_operacion AND d.codigo_campo = c.codigo_campo
          LEFT JOIN PLAN_DE_CUENTA u ON d.codigo_cuenta = u.cuenta
          LEFT JOIN CAMPO_CNT      v ON p.id_sistema    = v.id_sistema AND p.tipo_movimiento = v.tipo_movimiento AND p.tipo_operacion = v.tipo_operacion AND v.codigo_campo = d.codigo_campo_variable AND v.tipo_administracion_campo = 'V'
--   WHERE  d.Folio_Perfil             = 1530

   INSERT INTO #TEMP1 
   SELECT 0,' ',' ',' ',correlativo_perfil,0,' ',' ',valor_dato_campo,codigo_cuenta ,' ',isnull(descripcion,'No Existe')
   FROM   PERFIL_VARIABLE_CNT
          LEFT JOIN PLAN_DE_CUENTA ON cuenta = codigo_cuenta
--   WHERE  folio_perfil             = 1530

   SELECT * 
   FROM   #TEMP2,#TEMP1 a 
   ORDER BY a.correlativo_perfil , convert(integer,a.valor_dato)

END
GO
