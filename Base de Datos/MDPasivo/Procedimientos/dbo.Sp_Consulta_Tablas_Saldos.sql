USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Consulta_Tablas_Saldos]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROC [dbo].[Sp_Consulta_Tablas_Saldos]
                               ( @archivo     CHAR(25) ,
                                 @filtro      VARCHAR(20),
                                 @operacion   VARCHAR(10)=' ',
                                 @xid_Sistema VARCHAR(10)=' '
                               )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

DECLARE  @fecha_desde     CHAR(8)     ,
         @fecha_hasta     CHAR(8)     ,
         @tabla           CHAR(30)    ,
	 @filtros         CHAR(30)    ,
         @proceso         VARCHAR(250),
         @campos          VARCHAR(150),
         @id_sistema      CHAR(3)     ,
         @tipo_movimiento CHAR(3)     ,
         @tipo_operacion  CHAR(5)

/*
IF @Archivo = "BAC_CNT_MOVIMIENTO"

BEGIN

   SELECT glosa_operacion,
          tipo_operacion
     FROM MOVIMIENTO_CNT 
    WHERE id_sistema      = @filtro
      AND tipo_movimiento = "MOV"

END
*/


IF @archivo = "BAC_CNT_SISTEMAS"

BEGIN

   SELECT nombre_sistema,
          id_sistema 
     FROM SISTEMA
    WHERE operativo = "S"

END
/*
IF @archivo = "CON_PLAN_CUENTAS1"
   SELECT cuenta,              --    SELECT * FROM Plan_de_Cuenta
          descripcion,
	  glosa,
	  tipo_moneda,	
	  cta_sbif,
	  tipo_cuenta,
	  con_centro_costo	
		  
          FROM PLAN_DE_CUENTA
	  where cuenta = @filtro
          ORDER BY cuenta

*/
/*
IF @archivo = 'CON_CAMPOS_PERFIL'
BEGIN

   SELECT CONVERT( CHAR(3), codigo_campo ),
          descripcion_campo,* 
          FROM CAMPO

          WHERE
                CHARINDEX (  @filtro ,productos )<>0
            AND tipo_campo = 'F'
            
END

*/
/*
IF @archivo = 'BAC_CNT_PERFIL'
BEGIN

   SELECT 
            'folio_perfil' = ( SELECT MAX(PD.folio_perfil) FROM PERFIL_DETALLE_SALDO PD WHERE PD.id_sistema         = P.id_sistema 
                                                                                   AND   PD.codigo_producto    = P.codigo_producto 
                                                                                   AND   PD.codigo_evento      = P.codigo_evento 
                                                                                   AND   PD.codigo_moneda1     = P.codigo_moneda1 
                                                                                   AND   PD.codigo_moneda2     = P.codigo_moneda2 
                                                                                   AND   PD.codigo_instrumento = P.codigo_instrumento  )
            ,P.glosa_perfil
            ,P.codigo_producto

    FROM PERFIL_SALDO P

    WHERE 
         (id_sistema = @xId_Sistema OR @xId_Sistema =' ')

    ORDER BY 
            P.glosa_perfil

END
*/

/*
IF @archivo = 'GEN_TABLAS1'

BEGIN
    SELECT  
             codigo_condicion 
	    ,descripcion
            ,codigo_campo
            ,PRODUCTOS  
            ,CHARINDEX(@operacion, productos )
            
      FROM CAMPO_LOGICO

     WHERE 
           codigo_campo = CONVERT(NUMERIC(3),@filtro)
             AND CHARINDEX( @operacion , productos ) > 0
END
*/

IF @archivo = "MDCL_BANCOS"
BEGIN
   
   SELECT STR(cod_inst,4), clnombre 
     FROM CLIENTE 
    WHERE cltipcli  = 1
      AND cod_inst <> 0
END

IF @archivo = "LIQMX"
BEGIN
   
   SELECT mnnemo,
          mnglosa
     FROM MONEDA
    WHERE (mnmx = "C" OR mncodmon = 999)

END

IF @archivo = "MDFP_TESOR"

BEGIN
   
   SELECT CONVERT(CHAR(5),codigo),
          glosa
     FROM FORMA_DE_PAGO
    WHERE cc2756 = (CASE WHEN RTRIM(@filtro) = "$$" THEN "N" ELSE "S" END)

END

/*
IF @archivo = "BAC_CNT_CAMPOS"

BEGIN

   SELECT   codigo_campo, 
            descripcion_campo ,
            nombre_campo_tabla
    FROM CAMPO

END
*/
/*

IF @archivo = "CON_PLAN_CUENTAS"
   SELECT cuenta, 
          descripcion,
	  glosa,
	  tipo_moneda,
	  tipo_cuenta
          FROM PLAN_DE_CUENTA
          ORDER BY cuenta
*/

SET NOCOUNT OFF

END   /* FIN PROCEDIMIENTO */





GO
