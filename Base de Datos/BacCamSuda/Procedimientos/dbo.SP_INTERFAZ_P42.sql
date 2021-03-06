USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_P42]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_P42]
( @Fecha_Consulta CHAR(08) )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nNumPlanilla          NUMERIC(07)
   DECLARE @nNumPlanillaAux       NUMERIC(07)
   -- Variables definida para REGIS00
   DECLARE @cFecha_Presentacion   CHAR(08)
   DECLARE @cFecha_Presentacion1  CHAR(08)
   DECLARE @cCodigo_Entidad       CHAR(03)
   DECLARE @cNombre_Entidad       CHAR(30)
   -- Variables definida para REGIS10
   DECLARE @cPlanilla_Numero      CHAR(06)
   DECLARE @cRut_Interesado       CHAR(10)
   DECLARE @cNombre_Interesado    CHAR(30)
   DECLARE @cDirecc_Interesado    CHAR(30)
   DECLARE @cCiudad_Interesado    CHAR(20)
   DECLARE @cFecha_Planilla       CHAR(08)
   DECLARE @cTipo_Documento       CHAR(01)
   DECLARE @cTipo_Operacion       CHAR(03)
   DECLARE @cCodigo_Comercio      CHAR(06)
   DECLARE @cConcepto             CHAR(03)
   DECLARE @cPais_Operacion       CHAR(03)
   DECLARE @cMoneda_Operacion     CHAR(03)
   DECLARE @cMonto_Origen         CHAR(15)
   DECLARE @cParidad              CHAR(11)
   DECLARE @cMonto_Dolares        CHAR(15)
   DECLARE @cTipo_Cambio          CHAR(09)
   DECLARE @cMonto_Pesos          CHAR(17)
   DECLARE @cAfecto_Derivados     CHAR(01)
   DECLARE @cCantidad_Acuerdos    CHAR(01)
   DECLARE @cTipo_Autorizacion    CHAR(02)
   DECLARE @cNumero_Autorizacion  CHAR(06)
   DECLARE @cFecha_Autorizacion   CHAR(08)
   DECLARE @cCodigo_Institucion   CHAR(03)
   DECLARE @cNro_Presen_Op_Relac  CHAR(06)
   -- Variables definida para REGIS20
   DECLARE @cNumero_Inscripcion   CHAR(08)
   DECLARE @cFecha_Inscripcion    CHAR(08)
   DECLARE @cNombre_Financista    CHAR(30)
   DECLARE @cFecha_Vencimiento    CHAR(08)
   DECLARE @cFecha_Desembolso     CHAR(08)
   DECLARE @cMoneda_Desembolso    CHAR(03)
   DECLARE @cMonto_Desembolso     CHAR(15)
   DECLARE @cImpuesto_Adicional   CHAR(13)
   -- Variables definida para REGIS60
   DECLARE @cNumero_Contrato      CHAR(08)
   DECLARE @cFecha_Suscripcion    CHAR(08)
   DECLARE @cFecha_Vcto_Contrato  CHAR(08)
   DECLARE @cInstrumento_Utiliza  CHAR(02)
   DECLARE @cParidad_Tipo_Cambio  CHAR(11)
   DECLARE @cArea_Contable        CHAR(02)
   -- Variables definida para REGIS80
   DECLARE @cObservaciones        VARCHAR(240)
   -- Variables definida para REGIS99
   DECLARE @nContador10           NUMERIC(06)
   DECLARE @nContador20           NUMERIC(06)
   DECLARE @nContador30           NUMERIC(06)
   DECLARE @nContador40           NUMERIC(06)
   DECLARE @nContador50           NUMERIC(06)
   DECLARE @nContador60           NUMERIC(06)
   DECLARE @nContador70           NUMERIC(06)
   DECLARE @nContador80           NUMERIC(06)
   DECLARE @nContador             NUMERIC(06)

   -- Tabla de Paso INTERFAZ_P42
   CREATE TABLE #INTERFAZ_P42
          (
           Registro       CHAR(250)
          )
   -- REGIS00
   SELECT       @cFecha_Presentacion = @Fecha_Consulta , --CONVERT( CHAR(08), acfecpro, 112 ),
                @cCodigo_Entidad     = RIGHT( '000' + CONVERT( VARCHAR(03), accodigo ), 3 ),
                @cNombre_Entidad     = acnombre
          FROM  meac

   IF @cCodigo_Entidad='001' BEGIN
      SELECT @cCodigo_Entidad='010'
   END   
   INSERT INTO #INTERFAZ_P42
          VALUES( '00' + @cFecha_Presentacion + @cCodigo_Entidad + @cNombre_Entidad )
          
   -- Número Planilla inicial
   SELECT @nNumPlanilla = 0
   SELECT @nContador10  = 0
   SELECT @nContador20  = 0
   SELECT @nContador30  = 0
   SELECT @nContador40  = 0
   SELECT @nContador50  = 0
   SELECT @nContador60  = 0
   SELECT @nContador70  = 0
   SELECT @nContador80  = 0
   SELECT @nContador    = 0
   
   WHILE (1=1) BEGIN
      SELECT @nNumPlanillaAux  = -1
      -- REGIS10    
      SET ROWCOUNT 1

      SELECT       @nNumPlanillaAux       = a.planilla_numero,
--                 @cPlanilla_Numero      = RIGHT( '000000' + CONVERT( VARCHAR(06), a.planilla_numero ), 6 ),
                   @cPlanilla_Numero      = RIGHT( '000000' + CONVERT( VARCHAR(06), SUBSTRING( LTRIM(RTRIM( a.planilla_numero )), 1, 6) ), 6 ),
                   @cRut_Interesado       = CASE WHEN a.interesado_rut < 2 THEN '' 
												 ELSE RIGHT( '000000000' + CONVERT( VARCHAR(09), b.clrut ), 9 ) + b.cldv
                                            END,
                   @cNombre_Interesado    = a.interesado_nombre,
                   @cDirecc_Interesado    = a.interesado_direccion,
                   @cCiudad_Interesado    = a.interesado_ciudad,
                   @cFecha_Planilla       = CONVERT( CHAR(08), a.planilla_fecha, 112 ),
                   @cTipo_Documento       = a.tipo_documento,
                   @cTipo_Operacion       = RIGHT( '000' + CONVERT( VARCHAR(03), a.tipo_operacion_cambio ), 3 ),
                   @cCodigo_Comercio      = RIGHT( '000000' + CONVERT( VARCHAR(06), a.codigo_comercio ), 6 ),
                   @cConcepto             = RIGHT( '000' + CONVERT( VARCHAR(03), a.concepto ), 3 ),
                   @cPais_Operacion       = CASE WHEN a.der_numero_contrato > 0 
                                                 THEN RIGHT( '000' + CONVERT( VARCHAR(03), a.pais_operacion ), 3 )
                                                 ELSE '000'
                                            END,
                   @cMoneda_Operacion     = RIGHT( '000' + CONVERT( VARCHAR(03), CONVERT( NUMERIC(03), operacion_moneda ) ), 3 ),
                   @cMonto_Origen         = RIGHT( '000000000000000' + CONVERT( VARCHAR(15), CONVERT( NUMERIC(15,2),  a.monto_origen ) ), 15 ),
                   @cParidad              = RIGHT( '00000000000' + CONVERT( VARCHAR(11), CONVERT( NUMERIC(11,4),       a.paridad ) ), 11 ),
                   @cMonto_Dolares        = RIGHT( '000000000000000' + CONVERT( VARCHAR(15), CONVERT( NUMERIC(15,2), a.monto_dolares ) ), 15 ),
                   @cTipo_Cambio          = RIGHT( '000000000' + CONVERT( VARCHAR(09), CONVERT( NUMERIC(09,2),   a.tipo_cambio ) ), 9 ),
                   @cMonto_Pesos          = RIGHT( '00000000000000000' + CONVERT( VARCHAR(17), CONVERT( NUMERIC(17,2),   a.monto_pesos ) ), 17 ),
                   @cAfecto_Derivados     = CONVERT( VARCHAR(01), a.afecto_derivados ),
                   @cCantidad_Acuerdos    = CONVERT( VARCHAR(01), a.cantidad_acuerdos ),

                   @cTipo_Autorizacion    = autbcch_tipo,
                   @cNumero_Autorizacion  = CASE WHEN a.autbcch_numero = 0    THEN '000000' ELSE RIGHT( '000000' + CONVERT( VARCHAR(03), a.autbcch_numero ), 6 ) END,
                   @cFecha_Autorizacion   = ISNULL( (CASE WHEN CONVERT( CHAR(8) , a.autbcch_fecha , 112 ) = '19000101' THEN '00000000' ELSE CONVERT( CHAR(08), a.autbcch_fecha, 112 ) END ) , '00000000' ),
                   @cCodigo_Institucion   = RIGHT( '000' + CONVERT( VARCHAR(02), a.rel_institucion ), 3 ),
                   @cFecha_Presentacion1  = ISNULL( CONVERT( CHAR(08), a.rel_fecha, 112 ), '00000000' ),

                   @cNro_Presen_Op_Relac  = RIGHT( '000000' + CONVERT( VARCHAR(06), SUBSTRING(LTRIM(RTRIM( a.rel_numero )), 1, 6) ), 6 ) ,

                   @cNumero_Inscripcion   = RIGHT( '00000000' + CONVERT( VARCHAR(08), a.ofi_numero_inscripcion ), 8 ),
                   @cFecha_Inscripcion    = ISNULL( CONVERT( CHAR(08), a.ofi_fecha_inscripcion, 112 ), '00000000' ),
                   @cNombre_Financista    = a.ofi_nombre_financista,
                   @cFecha_Vencimiento    = ISNULL( CONVERT( CHAR(08), a.ofi_fecha_vencimiento, 112 ), '00000000' ),

                   @cFecha_Desembolso     = ISNULL( CONVERT( CHAR(08), a.ofi_fecha_desembolso, 112 ), '00000000' ),
                   @cMoneda_Desembolso    = RIGHT( '000' + CONVERT( VARCHAR(03), a.ofi_moneda_desembolso ), 3 ),
                   @cMonto_Desembolso     = RIGHT( '000000000000000' + CONVERT( VARCHAR(15), CONVERT( NUMERIC(15,2),  a.ofi_monto_desembolso ) ), 15 ),
                   @cImpuesto_Adicional   = RIGHT( '0000000000000' + CONVERT( VARCHAR(13), CONVERT( NUMERIC(13,2),  a.ofi_impuesto_adicional ) ), 13 ),
                   @cNumero_Contrato      = RIGHT( '00000000' + CONVERT( VARCHAR(08), a.der_numero_contrato ), 8 ),
                   @cFecha_Suscripcion    = ISNULL( CONVERT( CHAR(08), a.der_fecha_inicio, 112 ), '00000000' ),
                   @cFecha_Vcto_Contrato  = ISNULL( CONVERT( CHAR(08), a.der_fecha_vence, 112 ), '00000000' ),
                   @cInstrumento_Utiliza  = CASE WHEN der_instrumento = 1 THEN '01' 
                                                 WHEN der_instrumento = 2 THEN '02'
                                                                          ELSE '  '
                                            END,

                   @cParidad_Tipo_Cambio  = RIGHT( '00000000000' + CONVERT( VARCHAR(11), CONVERT( NUMERIC(11,4),  a.der_precio_contrato ) ), 11 ),
--                   @cArea_Contable        = RIGHT( '00' + CONVERT( VARCHAR(06), a.der_area_contable ), 8 ),
                   @cArea_Contable        = RIGHT( '00' + CONVERT( VARCHAR(02), a.der_area_contable ), 2 ),
                   @cObservaciones        = obs_1

             FROM  view_planilla_spt a, view_cliente b
             WHERE a.interesado_rut    = b.clrut       AND
                   a.interesado_codigo = b.clcodigo    AND
                   a.planilla_numero   > @nNumPlanilla AND
                   a.planilla_fecha    = @cFecha_Presentacion
             ORDER BY a.planilla_numero

             
      SET ROWCOUNT 0
      IF @nNumPlanillaAux = -1 BEGIN
         BREAK
      END
      SELECT @nNumPlanilla = @nNumPlanillaAux
      IF @cCodigo_Institucion='001' BEGIN
         SELECT @cCodigo_Institucion='010'
      END   
      -- REGIS10
      SELECT @nContador10  = @nContador10 + 1
      INSERT INTO #INTERFAZ_P42
             VALUES ( '10' + @cPlanilla_Numero + @cRut_Interesado + @cNombre_Interesado +
                      @cDirecc_Interesado + @cCiudad_Interesado + @cFecha_Planilla + '0'+ @cTipo_Documento +
                      @cTipo_Operacion + @cCodigo_Comercio + @cConcepto + @cPais_Operacion + @cMoneda_Operacion + 
                      LEFT(     @cMonto_Origen, 12 ) + RIGHT(     @cMonto_Origen, 2 ) +
                      LEFT(          @cParidad,  6 ) + RIGHT(          @cParidad, 4 ) +
                      LEFT(    @cMonto_Dolares, 12 ) + RIGHT(    @cMonto_Dolares, 2 ) +
                      LEFT(      @cTipo_Cambio,  6 ) + RIGHT(      @cTipo_Cambio, 2 ) +
                      LEFT(      @cMonto_Pesos, 14 ) + RIGHT(      @cMonto_Pesos, 2 ) + 
                      @cAfecto_Derivados + @cCantidad_Acuerdos + @cTipo_Autorizacion + @cNumero_Autorizacion + 
                      @cFecha_Autorizacion + @cCodigo_Institucion + @cFecha_Presentacion1 + @cNro_Presen_Op_Relac )
      -- REGIS20
      IF @cNumero_Inscripcion <> '00000000' BEGIN
         SELECT @nContador20  = @nContador20 + 1
         INSERT INTO #INTERFAZ_P42
               VALUES ( '20' + @cNumero_Inscripcion + @cFecha_Inscripcion + @cNombre_Financista + @cFecha_Vencimiento +
                        @cFecha_Desembolso + @cMoneda_Desembolso + 
                        LEFT(   @cMonto_Desembolso, 12 ) + RIGHT(   @cMonto_Desembolso, 2 ) )
                   --   + LEFT( @cImpuesto_Adicional, 10 ) + RIGHT( @cImpuesto_Adicional, 2 ) )
      END
      -- REGIS60
      IF @cNumero_Contrato <> '00000000' BEGIN
         SELECT @nContador60  = @nContador60 + 1
         INSERT INTO #INTERFAZ_P42
               VALUES ( '60' + @cNumero_Contrato + @cFecha_Suscripcion + @cFecha_Vcto_Contrato + @cInstrumento_Utiliza +
                        LEFT( @cParidad_Tipo_Cambio, 6 ) + RIGHT( @cParidad_Tipo_Cambio, 4 ) + 
                        @cArea_Contable )
      END
      -- REGIS80
      IF @cObservaciones <> '' BEGIN
         SELECT @nContador80  = @nContador80 + 1
         SELECT @cObservaciones = REPLACE(@cObservaciones,CHAR(13),' ')
         SELECT @cObservaciones = REPLACE(@cObservaciones,CHAR(10),' ')
         SELECT @cObservaciones = REPLACE(@cObservaciones,CHAR(9),' ')
         INSERT INTO #INTERFAZ_P42
  VALUES ( '80' + @cObservaciones )
      END
      
   END
   -- REGIS99
   SELECT @nContador    = @nContador10 + @nContador20 + @nContador30 + @nContador40 + 
                          @nContador60 + @nContador70 + @nContador80
   INSERT INTO #INTERFAZ_P42
       VALUES ( '99' + 
                   RIGHT( '000000' + CONVERT( VARCHAR(06), @nContador10 ), 6 ) +
                   RIGHT( '000000' + CONVERT( VARCHAR(06), @nContador20 ), 6 ) +
                   RIGHT( '000000' + CONVERT( VARCHAR(06), @nContador30 ), 6 ) +
                   RIGHT( '000000' + CONVERT( VARCHAR(06), @nContador40 ), 6 ) +
                   RIGHT( '000000' + CONVERT( VARCHAR(06), @nContador60 ), 6 ) +
                   RIGHT( '000000' + CONVERT( VARCHAR(06), @nContador70 ), 6 ) +
                   RIGHT( '000000' + CONVERT( VARCHAR(06), @nContador80 ), 6 ) +
                   RIGHT( '000000' + CONVERT( VARCHAR(06), @nContador   ), 6 ) )
   --INSERT INTO #INTERFAZ_P42 VALUES (CHAR(127))
   SELECT * FROM #INTERFAZ_P42
   DROP TABLE #INTERFAZ_P42
   SET NOCOUNT OFF
END
GO
