USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_PRUEBA_PPP]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Sp_PRUEBA_PPP]
     (
         @entidad                NUMERIC(3)
        ,@tipo_mercado           CHAR(4)      -- PTAS,EMPR,ARBI
        ,@tipo_operacion         CHAR(1)      -- C,V
        ,@operacion_fecha        DATETIME     ---char(8) dtresner
        ,@operacion_numero       NUMERIC(7)
        ,@operacion_moneda       NUMERIC(3)   --CHAR(3),        --NUMERIC(3),
        ,@interesado_rut         NUMERIC(9)
        ,@interesado_codigo      NUMERIC(9)
        ,@monto_origen           NUMERIC(19,4)
        ,@paridad                NUMERIC(19,8)
        ,@monto_dolares          NUMERIC(19,4) --19,8
        ,@tipo_cambio            NUMERIC(19,4) --19,8
        ,@monto_pesos            NUMERIC(19,4)
        ,@der_numero_contrato    NUMERIC(8)
        ,@der_fecha_inicio       DATETIME     
        ,@der_fecha_vence        DATETIME     
        ,@der_precio_contrato    NUMERIC(19,4)
        ,@der_instrumento        NUMERIC(2)
        ,@rel_institucion        NUMERIC(3)   
        ,@rel_fecha              DATETIME     
        ,@rel_numero             NUMERIC(6)
        ,@rel_arbitraje          CHAR(1)
        ,@codigo_area            VARCHAR(5)
        ,@codigo_comercio        CHAR(6)
        ,@codigo_concepto        CHAR(3)
        ,@planilla_numero        NUMERIC(6) OUTPUT
        ,@planilla_fecha  DATETIME   OUTPUT --char(8)dtresner
     )                   
AS
BEGIN
   select 'entidad'=@entidad,
          'Fecha Planilla'=@planilla_fecha,
          'numero planilla'=@planilla_numero 
   DECLARE @ok           NUMERIC(10)
   DECLARE @tipo_cliente CHAR(1)   
   DECLARE @condicion    CHAR(5)
   SELECT @ok = 1
   SELECT @planilla_fecha = CONVERT(CHAR(8),@operacion_fecha,112)
   IF @planilla_numero = 0 
   BEGIN
        select 'mensaje 2',@entidad,@planilla_fecha,@planilla_numero 
         
        SELECT @planilla_numero = ISNULL((SELECT correlativo_planilla  FROM MEAC ) , 0 )
        UPDATE MEAC    SET correlativo_planilla = ( correlativo_planilla + 1 )   WHERE acentida = 'ME'
        IF @@ERROR<>0
        BEGIN
             SELECT @@ERROR, 'NO SE PUDO CAPTURAR CORRELATIVO PARA PLANILLA AUTOMATICA'
             RETURN -1
        END
        
        select 'mensaje 3',@entidad,@planilla_fecha,@planilla_numero 
        INSERT VIEW_PLANILLA_SPT 
            ( 
               fecha   
              ,entidad
              ,planilla_fecha
              ,planilla_numero 
            )
       VALUES 
            (
               CONVERT(CHAR(8),GETDATE(),112)
              ,@entidad
              ,@planilla_fecha
              ,@planilla_numero 
            )
        
        IF @@ERROR<>0
        BEGIN
             SELECT @@ERROR, 'NO SE PUEDE AGREGAR PLANILLA AUTOMATICA'
             RETURN -1
        END
   END
   UPDATE VIEW_PLANILLA_SPT
      SET interesado_rut           = @interesado_rut,
          interesado_codigo        = @interesado_codigo,
          operacion_numero         = @operacion_numero,
          operacion_fecha          = @operacion_fecha,
          operacion_moneda         = @operacion_moneda,
          monto_origen             = @monto_origen,
          paridad                  = @paridad,
          monto_dolares            = @monto_dolares,
          tipo_cambio              = @tipo_cambio,
          monto_pesos              = @monto_pesos,
          afecto_derivados         = (CASE WHEN @der_numero_contrato > 0   THEN 1 ELSE 0 END),
          tipo_documento           = (CASE WHEN @tipo_operacion      = 'C' THEN 1 ELSE 2 END)   -- 1=ingreso   2=egreso
    WHERE entidad                  = @entidad              
      AND planilla_numero          = @planilla_numero      
      AND planilla_fecha           = CONVERT( CHAR(8) , @planilla_fecha , 112 )
  
          IF @@ERROR <> 0 OR @@ROWCOUNT = 0
             BEGIN
   SELECT @planilla_numero = 1   -- no acepta asignacion de cero = 0
   SELECT @planilla_fecha = ''
                 SELECT -1,'NO SE PUEDEN ACTUALIZAR DATOS GENERALES DE PLANILLA AUTOMATICA', @operacion_numero
                 RETURN -1
             END
   UPDATE   VIEW_PLANILLA_SPT
      SET   interesado_nombre        = SUBSTRING(a.clnombre,1,30)
      ,     interesado_direccion     = SUBSTRING(a.cldirecc,1,30)
      ,     interesado_ciudad        = ISNULL(SUBSTRING(b.nombre,1,20),'')
     FROM   VIEW_CLIENTE a,  VIEW_CIUDAD b
     WHERE  entidad                  = @entidad
     AND    planilla_numero          = @planilla_numero
     AND    CONVERT(CHAR(8),planilla_fecha,112)  = CONVERT( CHAR(8), @planilla_fecha , 112)
     AND    interesado_rut           = a.clrut
     AND    interesado_codigo        = a.clcodigo
--     AND    a.clciudad             *= b.codigo_ciudad
   IF @@ERROR <> 0 OR @@ROWCOUNT = 0

     UPDATE VIEW_PLANILLA_SPT
		 SET pais_operacion    = ISNULL(codigo_pais,225)
 	 FROM VIEW_PLANILLA_SPT LEFT OUTER JOIN VIEW_MONEDA ON operacion_moneda = mncodmon
     WHERE entidad             = @entidad              
      AND planilla_numero      = @planilla_numero      
      AND CONVERT(CHAR(8),planilla_fecha,112)  = @planilla_fecha 


/* REQ.7619 CASS 07-01-2011
   UPDATE VIEW_PLANILLA_SPT
      SET pais_operacion    = ISNULL(codigo_pais,225)
     FROM VIEW_MONEDA
    WHERE entidad               = @entidad              
      AND planilla_numero         = @planilla_numero      
      AND CONVERT(CHAR(8),planilla_fecha,112)  = @planilla_fecha 
      AND operacion_moneda              *= mncodmon
*/

   IF @@ERROR <> 0 OR @@ROWCOUNT = 0
   DECLARE @der_area_contable                NUMERIC(1)
   SELECT  @ok = @der_numero_contrato
   IF @ok > 0
   BEGIN
       SELECT @der_area_contable = (CASE WHEN @tipo_operacion = 'C' THEN 1 ELSE 2 END)
   END
   UPDATE VIEW_PLANILLA_SPT
      SET der_numero_contrato     = (CASE WHEN @ok > 0 THEN @der_numero_contrato ELSE  0 END),
          der_fecha_inicio        = (CASE WHEN @ok > 0 THEN @der_fecha_inicio    ELSE '' END),
          der_fecha_vence         = (CASE WHEN @ok > 0 THEN @der_fecha_vence     ELSE '' END),
          der_instrumento         = (CASE WHEN @ok > 0 THEN @der_instrumento     ELSE  0 END),
          der_precio_contrato     = (CASE WHEN @ok > 0 THEN @der_precio_contrato ELSE  0 END),
          der_area_contable       = (CASE WHEN @ok > 0 THEN @der_area_contable   ELSE  0 END)
    WHERE entidad                 = @entidad              
    AND   planilla_numero         = @planilla_numero      
    AND   CONVERT(CHAR(8),planilla_fecha,112)  = @planilla_fecha
   IF @@ERROR <> 0 OR @@ROWCOUNT = 0
   SELECT @ok = @rel_numero
   IF @ok > 0  
   UPDATE VIEW_PLANILLA_SPT
      SET rel_institucion    = (CASE WHEN @ok > 0 THEN @rel_institucion ELSE 0  END),
          rel_fecha          = (CASE WHEN @ok > 0 THEN @rel_fecha       ELSE '' END),
          rel_arbitraje      = (CASE WHEN @ok > 0 THEN @rel_arbitraje   ELSE '' END),
          rel_numero         = (CASE WHEN @ok > 0 THEN @rel_numero      ELSE 0  END)
    WHERE entidad                 = @entidad              
      AND planilla_numero         = @planilla_numero      
      AND CONVERT(CHAR(8),planilla_fecha,112)  = @planilla_fecha
   IF @@ERROR<>0 OR @@ROWCOUNT = 0
   SELECT @tipo_cliente = '0'
   
   SELECT @tipo_cliente = CONVERT(CHAR(1), (CASE WHEN cltipcli > 9 THEN 0 ELSE cltipcli END) )
   FROM   VIEW_CLIENTE      ,
          VIEW_PLANILLA_SPT
   WHERE  clrut      = interesado_rut 
   AND    clcodigo   = interesado_codigo
   SELECT @tipo_cliente  = CASE  WHEN @der_numero_contrato > 0        THEN 'F'    -- forward y/o swaps
                           WHEN @tipo_mercado        = 'ARBI'   THEN 'A'   -- arbitraje o spot de moneda
                                 WHEN @interesado_rut      = 97029000 THEN 'C'  -- banco central de chile
                                        ELSE @tipo_cliente                    
                  END
   SELECT @condicion = CASE  WHEN @tipo_cliente IN ('F','A','C') THEN 'USD' ELSE 'CLP' END
   SELECT @condicion = @tipo_operacion + rtrim(ltrim(@condicion)) + @tipo_cliente
   UPDATE VIEW_PLANILLA_SPT
      SET tipo_documento          = d.tipo_documento,
          tipo_operacion_cambio   = d.tipo_operacion_cambio,
          codigo_comercio         = @codigo_comercio,
          concepto                = @codigo_concepto
--        codigo_comercio         = d.comercio,
--        concepto                = d.concepto
     FROM VIEW_CODIGO_PLANILLA_AUTOMATICA d
    WHERE entidad                 = @entidad           
      AND planilla_numero         = @planilla_numero     
      AND convert(char(8),planilla_fecha,112)  = @planilla_fecha 
      AND d.condicion = @condicion
END



GO
