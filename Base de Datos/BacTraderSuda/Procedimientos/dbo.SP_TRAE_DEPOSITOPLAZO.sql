USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_DEPOSITOPLAZO]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_DEPOSITOPLAZO]
                                 ( @xNumeroOperacion NUMERIC(10) ,
     @xSistema  CHAR(3)  ,
     @xTipoOperacion  CHAR(5)  )
AS
BEGIN
 DECLARE @Regs   INTEGER
 DECLARE @I   INTEGER
 DECLARE @Banco   NUMERIC(10)
 DECLARE @Plaza   NUMERIC(10)
 DECLARE @Oficina  NUMERIC(10)
 DECLARE @Fecha_Pago   DATETIME
 DECLARE @tipo_movimiento  CHAR   ( 1)
 DECLARE @Rut_Cliente  NUMERIC( 9) 
 DECLARE @Codigo_Rut         NUMERIC( 3)
        DECLARE @Moneda    CHAR   ( 3) 
 DECLARE @Numero_Documento NUMERIC(10)
 DECLARE @Forma_Pago   CHAR   ( 4)
 DECLARE @Nombre_Cliente   CHAR   (40)
        DECLARE @Estado    CHAR   ( 1)
 DECLARE @Tipo_Canje   CHAR   ( 1)
 DECLARE @Codigo_Banco         NUMERIC( 3)
 DECLARE @Fecha_Cobro      DATETIME
 DECLARE @Glosa    CHAR   (40)
 DECLARE @Tipo_Ingreso    CHAR   ( 1)
 DECLARE @Correla_Pago    NUMERIC( 5)
 DECLARE @Correlativo            NUMERIC( 5)
 
 SELECT  @Fecha_Pago  =  fecha_pago   ,
  @tipo_movimiento = tipo_movimiento                 ,
  @Rut_Cliente  = rut_cliente    ,
  @Codigo_Rut  = codigo_rut    ,
                @Moneda   = moneda     ,
  @Numero_Documento= numero_documento   ,
  @Forma_Pago  = forma_pago    ,
  @Nombre_Cliente  = nombre_cliente    ,
                @Estado   = estado     ,
  @Tipo_Canje  = 'R'    ,
  @Codigo_Banco  = codigo_banco   ,
  @Fecha_Cobro     = fecha_cobro                  ,
  @Glosa   = glosa                           ,         
  @Tipo_Ingreso   = tipo_ingreso    ,
  @Correla_Pago   = correla_pago    ,
  @Correlativo     =      correlativo
 FROM GEN_PAGOS_OPERACION WHERE id_sistema     = @xSistema 
      AND   operacion      = @xNumeroOperacion
      AND   tipo_operacion = @xTipoOperacion 
      AND   Tipo_Canje     = 'E' ORDER BY  Correlativo 
 SELECT @Banco  = Folio FROM GEN_FOLIOS WHERE Codigo = 'BANCO'
 SELECT @Plaza  = Folio FROM GEN_FOLIOS WHERE Codigo = 'PLAZA'
 SELECT @Oficina = Folio FROM GEN_FOLIOS WHERE Codigo = 'OFICINA'
 
SELECT   @i=1 
SELECT   @Regs = COUNT(*) FROM GEN_CAPTACION WHERE numero_operacion = @xNumeroOperacion
WHILE @I <= @Regs
BEGIN
 SET ROWCOUNT @I         
 SELECT  @Correlativo = Correla_operacion FROM GEN_CAPTACION WHERE NUMERO_OPERACION = @xNumeroOperacion  order by Correla_operacion  
  IF EXISTS(SELECT * FROM GEN_PAGOS_OPERACION WHERE OPERACION = @xNumeroOperacion and Tipo_Canje = 'R' and Correlativo = @Correlativo)   
   UPDATE GEN_PAGOS_OPERACION SET fecha_pago = @Fecha_Pago  ,
                       id_sistema = @xSistema  ,
             tipo_operacion = @xTipoOperacion ,
             operacion = @xNumeroOperacion ,
             tipo_movimiento  = @tipo_movimiento ,
             rut_cliente  = @Rut_Cliente  ,
             codigo_rut   = @Codigo_Rut  ,
                                                       moneda   = @Moneda  ,
                                                       numero_documento = @Numero_Documento ,
                                                       forma_pago  = @Forma_Pago  ,
                                                       nombre_cliente   = @Nombre_Cliente ,
                                                       estado  = @Estado  ,
                                                       tipo_canje = @Tipo_Canje  ,
                                                       codigo_banco  = @Codigo_Banco  ,
                                                       fecha_cobro = @Fecha_Cobro  ,
                                                       glosa   = @Glosa  ,
                                                       tipo_ingreso  = @Tipo_Ingreso  ,
                                                       correla_pago  = @Correla_Pago  ,
                                                       correlativo = (SELECT Correla_operacion  FROM  GEN_CAPTACION WHERE NUMERO_OPERACION = @xNumeroOperacion and Correla_operacion = @Correlativo),
             monto_operacion = (SELECT Monto_Inicio_Pesos FROM  GEN_CAPTACION WHERE NUMERO_OPERACION = @xNumeroOperacion and Correla_operacion = @Correlativo)
         WHERE OPERACION = @xNumeroOperacion and Tipo_Canje = 'R' and  Correlativo = @Correlativo  
  ELSE 
   
   INSERT INTO GEN_PAGOS_OPERACION SELECT  @Fecha_Pago       ,  --Fecha pago
        @xSistema   ,  --id_sistema
        @xTipoOperacion   , --tipo_operacion 
        @xNumeroOperacion , --Operacion
        Correla_operacion , --Correlativo
        @tipo_movimiento  , --tipo_movimiento
        @Rut_Cliente      , --Rut_Cliente
        @Codigo_Rut   , --Codigo_Rut
        Monto_Inicio_Pesos, --Monto_Operacion
               @Moneda    , --Moneda
        @Numero_Documento , --Numero_Documento
        @Forma_Pago   , --Forma_Pago
        @Nombre_Cliente   , --Nombre_Cliente
               @Estado    , --Estado
        @Tipo_Canje   , --Tipo_Canje
        @Codigo_Banco   , --Codigo_Banco
        @Fecha_Cobro   , --Fecha_Cobro
        @Glosa    , --Glosa
        @Tipo_Ingreso   , --Tipo_Ingreso
        @Correla_Pago   --Correla_pago
      FROM  GEN_CAPTACION 
      WHERE NUMERO_OPERACION = @xNumeroOperacion 
      AND   correla_operacion= @Correlativo ORDER BY Correla_operacion
 
 SET ROWCOUNT 0
 SELECT @I = @I + 1
END     --Fin del While
SELECT   Convert(CHAR(10),GEN_OPERACIONES.fecha_operacion,103) ,  --1
         Convert(CHAR(10),GEN_CAPTACION.fecha_vencimiento,103) ,  --2
         numero_operacion     ,  --3
         Rtrim(Str(gen_operaciones.rut_cliente))+ '-' + cldv ,  --4
         gen_operaciones.codigo_rut    ,  --5
         'Base'=mnbase      ,  --6
         GEN_OPERACIONES.entidad    ,  --7
         GEN_OPERACIONES.Retiro     ,  --8
         GEN_CAPTACION.monto_inicio     ,  --9
         GEN_CAPTACION.monto_inicio_pesos   ,  --10
         mnnemo       ,   --11
         tasa       ,  --12
         plazo       ,  --13
         monto_final      ,  --14
         'Razon_Social'=rcnombre    ,  --15
         'Rut_Razon_Social'=rcrut    ,  --16
         'Dv_Razon_Social'=rcdv     ,  --17
  'Direccion_Razon'=rcdirecc    ,  --18
         'Descripcion_Moneda'=mnglosa    ,  --19
         'Nombre_Cliente'=clnombre    ,  --20
         'Dv_Cliente'=cldv     ,  --21
  Convert(CHAR(10),GEN_OPERACIONES.fecha_pago,103) ,  --22
         'Moneda2' = (CASE mncodmon WHEN 13 THEN mnnemo ELSE (SELECT mnnemo FROM VIEW_MONEDA WHERE mncodmon= 999)  END),          --23
  'SubLinea' = (CASE Tipo_Deposito WHEN 'R' THEN (CASE mncodmon WHEN 13  THEN 'Renovable Endosable'
                WHEN 999 THEN 'Renovable Endosable'
               ELSE 'Renovable Reajustable Endosable'
               END)
       ELSE (CASE mncodmon WHEN 13  THEN 'Fijo Endosable'
              WHEN 999 THEN 'Fijo Endosable'
             ELSE 'Fijo Reajustable Endosable'
             END)
       END),    --24       
   'Puntos' = (CASE Tipo_Deposito WHEN 'R' THEN (CASE mncodmon WHEN 13  THEN '1-3-5'
              WHEN 999 THEN '1-4-5'
             WHEN 998 THEN '1-2-5'
             WHEN 994 THEN '1-5-6'  
             ELSE '--'
               END)
       ELSE (CASE mncodmon WHEN 13  THEN '3-5'
              WHEN 999 THEN '4-5' 
             WHEN 998 THEN '2-5'
             WHEN 994 THEN '5-6'              
             ELSE '--'
             END)
       END),    --25
         @Banco                               ,    --26
  @Plaza                               ,    --27
  @Oficina                ,    --28
  (CASE CUSTODIA WHEN 'P' THEN 'PROPIA'
   WHEN 'D' THEN 'DCV'
   WHEN 'C' THEN 'CLIENTE
   ELSE '--'
   END)                    ,                       --29
  GEN_CAPTACION.correla_operacion ,   --30
  @Regs        --31
         FROM GEN_OPERACIONES, VIEW_CLIENTE, VIEW_MONEDA, GEN_CAPTACION, VIEW_ENTIDAD MDRC 
   WHERE  gen_operaciones.Operacion      = @xNumeroOperacion
   AND gen_operaciones.tipo_operacion = @xTipoOperacion
   AND     id_sistema = @xSistema
   AND Operacion  = gen_captacion.Numero_Operacion
   AND gen_operaciones.Rut_Cliente = clrut
   AND gen_operaciones.Entidad     = rcrut
   AND gen_captacion.Moneda     = mncodmon
  ORDER BY gen_captacion.numero_operacion, gen_captacion.correla_operacion
END

GO
