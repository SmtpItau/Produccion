USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOPERFICTBLE_NUEVO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADOPERFICTBLE_NUEVO](@numero NUMERIC(5))
                   
AS
BEGIN
DECLARE @Tipo_Ope  CHAR (05) 
CREATE TABLE #TEMPORAL (sistema   CHAR(20),
   movimiento   CHAR(20),
   operacion  CHAR(20),
   folio_perfil  NUMERIC(5),
   codigo_instrumento CHAR(10),
   glosa_instrumento CHAR(35),
   codigo_moneda  CHAR(5),
   glosa_moneda  CHAR(20),
   tipo_voucher  CHAR(12),
   glosa_perfil  CHAR(70))
CREATE TABLE #TEMPORAL1(codigo_campo  NUMERIC(5),
   tipo_movimiento_cuenta  CHAR(1),
   perfil_fijo  CHAR(1),
   codigo_cuenta  CHAR(20),
   correlativo_perfil NUMERIC(5),
   codigo_campo_variable NUMERIC(5),
   descripcion_campo CHAR(60),
   descripcion  CHAR(70),
   hora   CHAR(8),
   valor_dato  CHAR(30),
   codigo_cuenta_variable  CHAR(20),
   descripcion_campo_variable CHAR(60),
   descripcion_cuenta_variable CHAR(70))
        SET NOCOUNT ON
 SELECT TOP 1  @Tipo_Ope=tipo_operacion from perfil_cnt WHERE folio_perfil = @numero 
 INSERT INTO #TEMPORAL
 SELECT
  'sistema'= ISNULL((SELECT nombre_sistema FROM SISTEMA_CNT WHERE SISTEMA_CNT.id_sistema = PERFIL_CNT.id_sistema),''),
  'movimiento' = ISNULL((SELECT glosa_movimiento FROM MOVIMIENTO_CNT WHERE MOVIMIENTO_CNT.tipo_movimiento = PERFIL_CNT.tipo_movimiento AND MOVIMIENTO_CNT.tipo_operacion = PERFIL_CNT.tipo_operacion AND MOVIMIENTO_CNT.id_sistema = PERFIL_CNT.id_sistema),'')
,
  'operacion' = ISNULL((SELECT glosa_operacion FROM MOVIMIENTO_CNT WHERE MOVIMIENTO_CNT.tipo_operacion = PERFIL_CNT.tipo_operacion AND MOVIMIENTO_CNT.tipo_movimiento = PERFIL_CNT.tipo_movimiento AND MOVIMIENTO_CNT.id_sistema = PERFIL_CNT.id_sistema),''),
  'folio_perfil' = ISNULL(folio_perfil,0),
  'codigo_instrumento' = ISNULL(codigo_instrumento ,''),
   'glosa_instrumento' = ISNULL(CASE
           WHEN PERFIL_CNT.id_sistema = 'BTR'  THEN (SELECT inglosa FROM INSTRUMENTO WHERE codigo_instrumento = inserie)
             ELSE substring(glosa_perfil,1,40) 
                      END, ''),
                                                
  'codigo_moneda' = ISNULL(CASE
      WHEN PERFIL_CNT.id_sistema = 'BTR'  THEN (SELECT mnnemo FROM MONEDA WHERE moneda_instrumento = mncodmon)
                                         WHEN PERFIL_CNT.id_sistema = 'BFW'  THEN (SELECT mnnemo FROM MONEDA WHERE codigo_instrumento = mncodmon)
             ELSE ''
      END, ''),                                                                      
  'glosa_moneda' = ISNULL(CASE
      WHEN PERFIL_CNT.id_sistema = 'BTR'  THEN (SELECT mnglosa FROM MONEDA WHERE moneda_instrumento = mncodmon)
      WHEN PERFIL_CNT.id_sistema = 'BFW'  THEN (SELECT mnglosa FROM MONEDA WHERE codigo_instrumento = mncodmon)
             ELSE ''
      END, ''),                                                                      
  'tipo_voucher' = ISNULL(CASE
     WHEN tipo_voucher = 'I' THEN 'INGRESO'
     WHEN tipo_voucher = 'E' THEN 'EGRESO'
     ELSE 'TRASPASO'
    END,''),
  ISNULL(glosa_perfil,'')
   
        FROM PERFIL_CNT
  WHERE folio_perfil = @numero 
            
  INSERT INTO #TEMPORAL1
  SELECT
   ISNULL(PERFIL_DETALLE_CNT.codigo_campo,0),
   ISNULL(tipo_movimiento_cuenta,''),
   ISNULL(perfil_fijo,''),
   CASE
    WHEN ISNULL(codigo_cuenta,'') = '0' THEN ''
    ELSE ISNULL(codigo_cuenta,'')
   END,
   ISNULL(correlativo_perfil,0),
   ISNULL(codigo_campo_variable,0),
          ISNULL(e.descripcion_campo,''),
          CASE 
    WHEN ISNULL(PLAN_DE_CUENTA.descripcion,'')= '' AND ISNULL(perfil_fijo,'')= 'S' THEN 'No Existe'
    WHEN ISNULL(PLAN_DE_CUENTA.descripcion,'')= '' AND ISNULL(perfil_fijo,'')= 'N' THEN 'PERFIL VARIABLE COMPLETO'
    ELSE ISNULL(PLAN_DE_CUENTA.descripcion,'')
    END,
   'hora' = CONVERT(VARCHAR(10),GETDATE(),108),
   ' ',
   ' ',
   d.descripcion_campo,
   ' '
           
     FROM PERFIL_DETALLE_CNT
		  LEFT JOIN  PLAN_DE_CUENTA ON rtrim(ltrim(PERFIL_DETALLE_CNT.codigo_cuenta)) = rtrim(ltrim(PLAN_DE_CUENTA.cuenta)),
           PERFIL_CNT,
          CAMPO_CNT e,
          CAMPO_CNT d 
   WHERE PERFIL_DETALLE_CNT.folio_perfil = @numero 
     AND PERFIL_CNT.folio_perfil         = @numero 
     AND e.tipo_operacion         = PERFIL_CNT.tipo_operacion
     AND e.codigo_campo                 = PERFIL_DETALLE_CNT.codigo_campo
      AND d.codigo_campo          = codigo_campo_variable
       AND d.tipo_administracion_campo     = 'V'
     AND d.id_sistema                    = PERFIL_CNT.id_sistema
     AND d.tipo_operacion                = PERFIL_CNT.tipo_operacion
   ORDER BY PERFIL_DETALLE_CNT.Correlativo_perfil                                          
  INSERT INTO #TEMPORAL1 SELECT 0,' ',' ',' ',correlativo_perfil,0,' ',' ',' ',valor_dato_campo,codigo_cuenta ,' ',isnull(descripcion,'NO EXISTE') 
	from perfil_variable_cnt
		LEFT JOIN plan_de_cuenta ON codigo_cuenta = cuenta
   where folio_perfil = @numero 
--   (codigo_campo  NUMERIC(5),
--   tipo_movimiento_cuenta  CHAR(1),
--   perfil_fijo  CHAR(1),
--   codigo_cuenta  CHAR(20),
--   correlativo_perfil NUMERIC(5),
--   codigo_campo_variable NUMERIC(5),
--   descripcion_campo CHAR(60),
--   descripcion  CHAR(70),
--   hora   CHAR(8),
--   valor_dato  CHAR(30),
--   codigo_cuenta_variable  CHAR(20),
--   descripcion_campo_variable CHAR(60),
--   descripcion_cuenta_variable CHAR(70))
  INSERT INTO #TEMPORAL1 SELECT  codigo_campo,tipo_movimiento_cuenta,'S', codigo_cuenta,correlativo_perfil,0,'',' ','','', '' ,'','' from  perfil_detalle_cnt  where folio_perfil = @numero  
                            and perfil_detalle_cnt.perfil_fijo='S'
  Update #TEMPORAL1 Set  descripcion_campo = CAMPO_CNT.descripcion_campo FROM CAMPO_CNT WHERE CAMPO_CNT.codigo_campo=#TEMPORAL1.codigo_campo and  CAMPO_CNT.tipo_operacion=@Tipo_Ope  and #TEMPORAL1.perfil_fijo='S' and #TEMPORAL1.codigo_campo<>0
  Update #TEMPORAL1 Set  descripcion  = PLAN_DE_CUENTA.descripcion 
  FROM #TEMPORAL1
	   LEFT JOIN PLAN_DE_CUENTA ON rtrim(ltrim(#TEMPORAL1.codigo_cuenta)) = rtrim(ltrim(PLAN_DE_CUENTA.cuenta))
  WHERE #TEMPORAL1.perfil_fijo='S' and #TEMPORAL1.codigo_campo<>0
    SELECT * FROM #TEMPORAL,#TEMPORAL1 a order by a.correlativo_perfil
 
SET NOCOUNT OFF
END

GO
