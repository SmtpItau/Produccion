USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PLANILLA_AUTOMATICA_PP]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_PLANILLA_AUTOMATICA_PP]
     (
         @entidad                NUMERIC(3)    -- 1
        ,@tipo_mercado           CHAR(4)       -- 2 PTAS,EMPR,ARBI
        ,@tipo_operacion         CHAR(1)       -- 3 C,V
        ,@operacion_fecha        DATETIME      -- 4 char(8) dtresner
        ,@operacion_numero       NUMERIC(7)    -- 5
        ,@operacion_moneda       NUMERIC(3)    -- 6 CHAR(3),        --NUMERIC(3),
        ,@interesado_rut         NUMERIC(9)    -- 7
        ,@interesado_codigo      NUMERIC(9)    -- 8
        ,@monto_origen           NUMERIC(19,4) -- 9
        ,@paridad                NUMERIC(19,8) --10 
        ,@monto_dolares          NUMERIC(19,4) --11  19,8
        ,@tipo_cambio            NUMERIC(19,4) --12  19,8
        ,@monto_pesos            NUMERIC(19,4) --13
        ,@der_numero_contrato    NUMERIC(8)    --14
        ,@der_fecha_inicio       DATETIME      --15
        ,@der_fecha_vence        DATETIME      --16
        ,@der_precio_contrato    NUMERIC(19,4) --17
        ,@der_instrumento        NUMERIC(2)    --18
        ,@rel_institucion        NUMERIC(3)    --19
        ,@rel_fecha              DATETIME      --20
        ,@rel_numero             NUMERIC(6)    --21
        ,@rel_arbitraje          CHAR(1)       --22
        ,@codigo_area            VARCHAR(5)    --23
        ,@codigo_comercio        CHAR(6)       --24 
        ,@codigo_concepto        CHAR(3)       --25
        ,@planilla_numero        NUMERIC(6) OUTPUT
        ,@planilla_fecha         DATETIME   OUTPUT --char(8)dtresner
     )                   
AS
BEGIN
   DECLARE @ok           NUMERIC(10)
   DECLARE @tipo_cliente CHAR(3)   
   DECLARE @cliente_tipo INTEGER
   DECLARE @condicion    CHAR(10)
   DECLARE @Valut        CHAR(10)
          ,@Corres_Donde CHAR(50)
          ,@Corres_Desde CHAR(50)
          ,@Corres_Quien CHAR(50)
   SELECT @ok = 1
   IF @planilla_numero = 0 
   BEGIN
        SELECT @planilla_numero = ISNULL( (SELECT correlativo_planilla  FROM MEAC ) , 0 )
        UPDATE MEAC    SET correlativo_planilla = ( correlativo_planilla + 1 )   WHERE acentida = 'ME'
        IF @@ERROR<>0
        BEGIN
             SELECT @@ERROR, 'NO SE PUDO CAPTURAR CORRELATIVO PARA PLANILLA AUTOMATICA'
             RETURN -1
        END
      
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
      AND planilla_fecha                         = CONVERT( CHAR(8) , @planilla_fecha , 112 )
          IF @@ERROR <> 0 OR @@ROWCOUNT = 0
             BEGIN
   SELECT @planilla_numero = 1   -- no acepta asignacion de cero = 0
   SELECT @planilla_fecha = ''
                 SELECT -1,'NO SE PUEDEN ACTUALIZAR DATOS GENERALES DE PLANILLA AUTOMATICA', @operacion_numero, @planilla_numero, @planilla_fecha
                 RETURN -1
             END

/* REQ. 7619 CASS 06-01-2011
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
     AND    a.Clciudad               *= b.codigo_ciudad
*/

   UPDATE   VIEW_PLANILLA_SPT
      SET   interesado_nombre        = SUBSTRING(a.clnombre,1,30)
      ,     interesado_direccion     = SUBSTRING(a.cldirecc,1,30)
      ,     interesado_ciudad        = ISNULL(SUBSTRING(b.nombre,1,20),'')
     FROM   VIEW_CLIENTE a LEFT OUTER JOIN VIEW_CIUDAD b ON a.Clciudad = b.codigo_ciudad
     WHERE  entidad                  = @entidad
     AND    planilla_numero          = @planilla_numero
     AND    CONVERT(CHAR(8),planilla_fecha,112)  = CONVERT( CHAR(8), @planilla_fecha , 112)
     AND    interesado_rut           = a.clrut
     AND    interesado_codigo        = a.clcodigo


   UPDATE VIEW_PLANILLA_SPT
      SET pais_operacion    = ISNULL(mncodpais,225)
     FROM VIEW_MONEDA
    WHERE entidad               = @entidad              
      AND planilla_numero         = @planilla_numero      
      AND planilla_fecha    = @planilla_fecha 
      AND operacion_moneda               = mncodmon
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
   IF @rel_arbitraje = 'A'  BEGIN  --@ok > 0  

           SELECT @Corres_Donde = ISNULL((SELECT DISTINCT RTRIM(nombre) FROM memo,view_corresponsal WHERE monumope=@operacion_numero AND cod_corresponsal = CONVERT(INTEGER,Swift_Recibimos)),'')
           SELECT @Corres_Desde = ISNULL((SELECT DISTINCT RTRIM(nombre) FROM memo,view_corresponsal WHERE monumope=@operacion_numero AND cod_corresponsal = CONVERT(INTEGER,Swift_Entregamos)),'')
           SELECT @Corres_Quien = ISNULL((SELECT DISTINCT RTRIM(nombre) FROM memo,view_corresponsal WHERE monumope=@operacion_numero AND cod_corresponsal = CONVERT(INTEGER,Swift_Corresponsal)),'')
           SELECT @Valut  = (SELECT CONVERT(CHAR(10),MOVALUTA1,103) FROM memo WHERE monumope=@operacion_numero)

    UPDATE VIEW_PLANILLA_SPT
       SET rel_institucion    = @rel_institucion,
           rel_fecha          = @rel_fecha,
           rel_arbitraje      = @rel_arbitraje,
           rel_numero         = @rel_numero,
                  obs_1                                 = CASE WHEN @tipo_operacion = 'C' and operacion_moneda = 13 THEN 'Cliente: '+@Corres_Donde+' Paridad : '+CONVERT(CHAR(28),paridad)+' Credito : '+@Corres_Quien+' Valuta  : '+@Valut
                                                          ELSE 'Cliente: '+@Corres_Donde+' Paridad : '+CONVERT(CHAR(28),paridad)+' Debito : '+@Corres_Desde+' Valuta  : '+@Valut
                                                          END 
     WHERE entidad                 = @entidad              
       AND planilla_numero         = @planilla_numero      
       AND CONVERT(CHAR(8),planilla_fecha,112)  = CONVERT(CHAR(8),@planilla_fecha,112)
    UPDATE VIEW_PLANILLA_SPT
       SET rel_institucion    = @rel_institucion,
         rel_fecha          = @planilla_fecha,
           rel_arbitraje    = @rel_arbitraje,
           rel_numero         = @planilla_numero,
                  obs_1                                 = CASE WHEN @tipo_operacion = 'C' and operacion_moneda <> 13 THEN 'Cliente: '+@Corres_Donde+' Paridad : '+CONVERT(CHAR(28),paridad)+' Credito : '+@Corres_Quien+' Valuta  : '+@Valut
                                                          ELSE 'Cliente: '+@Corres_Donde+' Paridad : '+CONVERT(CHAR(28),paridad)+' Debito : '+@Corres_Donde+' Valuta  : '+@Valut
                                                          END 
     WHERE entidad                 = @entidad              
       AND planilla_numero         = @rel_numero
       AND CONVERT(CHAR(8),planilla_fecha,112)  = CONVERT(CHAR(8),@rel_fecha,112)
   END
   IF @@ERROR<>0 OR @@ROWCOUNT = 0
   SELECT @tipo_cliente = '000'
   SELECT @cliente_tipo = 0
   SELECT @tipo_cliente = CONVERT(CHAR(3), (CASE WHEN cltipcli > 9 THEN 0 ELSE cltipcli END) ),
   @cliente_tipo = ( CASE WHEN cltipcli > 9 THEN 0 ELSE cltipcli END )
   FROM   VIEW_CLIENTE      ,
          VIEW_PLANILLA_SPT
   WHERE  clrut      = interesado_rut 
   AND    clcodigo   = interesado_codigo
   AND    planilla_numero       = @planilla_numero     
   AND    convert(char(8),planilla_fecha,112)  = @planilla_fecha 
   SELECT @tipo_cliente  = CASE  WHEN @der_numero_contrato > 0 AND @cliente_tipo > 4 AND @tipo_mercado <> 'ARBI' THEN 'FE' -- forward y/o swaps Empresas
     WHEN @der_numero_contrato > 0 AND @cliente_tipo < 4 AND @tipo_mercado <> 'ARBI' THEN 'FB' -- forward y/o swaps Bancos
     WHEN @der_numero_contrato > 0 AND @cliente_tipo > 4 AND @tipo_mercado = 'ARBI'  THEN 'FAE' -- forward y/o swaps Empresas
     WHEN @der_numero_contrato > 0 AND @cliente_tipo < 4 AND @tipo_mercado = 'ARBI'  THEN 'FAB' -- forward y/o swaps Bancos
     WHEN @tipo_mercado        = 'ARBI'   THEN 'A'   -- arbitraje o spot de moneda
                                 WHEN @interesado_rut      = 97029000 THEN 'C'   -- banco central de chile
     WHEN @tipo_mercado        = 'EMPR' AND @interesado_rut = 97018000 THEN 'S'  -- Sucursales Empresas
                                        ELSE @tipo_cliente                    
                                  END
   SELECT @condicion = CASE WHEN RTRIM(LTRIM(@tipo_cliente)) IN ('FE','FB','FAE','FAB','A','C') THEN 'USD' ELSE 'CLP' END
   SELECT @condicion = @tipo_operacion + RTRIM(LTRIM(@condicion)) + RTRIM(LTRIM(@tipo_cliente))
   UPDATE VIEW_PLANILLA_SPT
      SET tipo_documento          = d.tipo_documento,
          tipo_operacion_cambio   = d.tipo_operacion_cambio,
          codigo_comercio         = (CASE @codigo_comercio WHEN '' THEN d.comercio ELSE @codigo_comercio END),
          concepto                = (CASE @codigo_concepto WHEN '' THEN d.concepto ELSE @codigo_concepto END)
     FROM CODIGO_PLANILLA_AUTOMATICA d
    WHERE entidad                 = @entidad           
      AND planilla_numero         = @planilla_numero     
      AND convert(char(8),planilla_fecha,112)  = @planilla_fecha 
      AND d.condicion = @condicion
END
/*
 select * from codigo_PLANILLA_AUTOMATICA 
 select * from view_tabla_general_detalle  where tbcateg = 72 order by tbcodigo1
 INSERT INTO CODIGO_PLANILLA_AUTOMATICA
 VALUES( '20011025' , '2' , '220' , '275107' , '019' , 'VCLPS' )
 select * from memo where morutcli = 97024000
 select obs_1,obs_2,operacion_moneda,tipo_operacion_cambio,* from VIEW_PLANILLA_SPT  where planilla_fecha = '20011031'
Sp_Graba_Planilla_Automatica 
         1
        ,'EMPR'
        ,'V'
        ,'20011218'
        ,2000
        ,13
        ,84196300
        ,1
        ,1000000
        ,1
        ,1000000
        ,685
        ,685000000
        ,2001
        ,'20010101'
        ,'20011218'
        ,165
        ,1
        ,0
        ,''
        ,0
        ,''
,''
        ,''
        ,''
        ,0
        ,''
*/



/****
Sp_Graba_Planilla_Automatica_pp 1
,'ARBI'
,'V'
,'20031015'
,96833     
,13    
,97023000    
,1           
,1625000.0000          
,1.00000000            
,1625000.00000000      
,641.71000000          
,1042778750.0000       
,0          
,'19000101'
,'19000101'
,.0000                 
,0    
,0           
,'20031015'
,326905   
,'A'    
,'ARBI'            
,''
,''
,0
,''

select * from view_planilla_spt where planilla_numero = 96833
***/

GO
