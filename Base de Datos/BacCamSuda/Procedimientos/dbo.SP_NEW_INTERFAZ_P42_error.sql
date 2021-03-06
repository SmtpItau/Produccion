USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NEW_INTERFAZ_P42_error]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_NEW_INTERFAZ_P42_error]
   (   @Consulta   CHAR(08)   )  
AS   
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @nNumPlanilla          NUMERIC(07)  
   DECLARE @nNumPlanillaAux       NUMERIC(07)  
   DECLARE @cFecha_Presentacion   CHAR(08)  
  
   -- Variables definida para REGIS10  
   DECLARE @cPlanilla_Numero      CHAR(06)  
   DECLARE @cRut_Interesado       CHAR(10)  
   DECLARE @CCUN				  CHAR(9)  
   DECLARE @CACC				  CHAR(16)  
   DECLARE @cTipo_Operac		  CHAR(02)  
   DECLARE @cNombre_Interesado    CHAR(50)  
   DECLARE @cTipo_Documento       CHAR(01)  
   DECLARE @cCodigo_Comercio      VARCHAR(05) -- 5  
  
   DECLARE @cPais_Operacion       CHAR(04)    -- 3  
   DECLARE @cMoneda_Operacion     CHAR(03)  
  
   DECLARE @nPais_operacion       NUMERIC(03)      
   DECLARE @cOperacion_moneda     CHAR(03)      
  
   DECLARE @cMonto_Origen         CHAR(15)  
   DECLARE @cMonto_Dolares        CHAR(15)  
   DECLARE @cTipo_Cambio          CHAR(09)  
   DECLARE @cMonto_Pesos          CHAR(17)  
   DECLARE @cAfecto_Derivados     CHAR(01)  
   DECLARE @cZona_Franca		  CHAR(01)  
   DECLARE @cTipo_Autorizacion    CHAR(02)  
   DECLARE @cNumero_Autorizacion  CHAR(06)  
   DECLARE @cFecha_Autorizacion   CHAR(08)  
   DECLARE @cCodigo_Institucion   CHAR(03)  
   DECLARE @cTipo_Operacion       CHAR(03)  
   DECLARE @cFecha_Presentacion1  CHAR(08)  
   DECLARE @cNro_Presen_Op_Relac  CHAR(06)  
  
   DECLARE @cConcepto             CHAR(03)  
  
   -- Variables definida para REGIS20  
   DECLARE @cNumero_Inscripcion       CHAR(08)  
   DECLARE @cNombre_Financista        CHAR(50)  
   DECLARE @cFecha_Vencimiento        CHAR(08)  
   DECLARE @cFecha_Desembolso         CHAR(08)  
   DECLARE @cMoneda_Desembolso        CHAR(03)  
   DECLARE @cSector_Beneficiario      CHAR(02)  
   DECLARE @cSector_Inversionista     CHAR(02)  
   DECLARE @cPorcentaje_Participacion CHAR(05)  
  
   DECLARE @Cabeza    CHAR(02)  
   DECLARE @Registro10    CHAR(193)  
   DECLARE @Registro20    CHAR(86)  
   DECLARE @Registro50    CHAR(16)  
   DECLARE @Registro60    CHAR(198)  
  
   -- Variables definida para REGIS30  
   DECLARE @Registro30    CHAR(66)  
   -- Variables definida para REGIS40  
   DECLARE @Registro40    CHAR(59)  
   -- Variables definida para REGIS50  
   DECLARE @cNumero_Contrato      CHAR(08)  
   DECLARE @cFecha_Suscripcion    CHAR(08)  
   -- Variables definida para REGIS60  
   DECLARE @cObservaciones        VARCHAR(198)  
   -- Arreglo Principal Para Contener Los Datos --  
   DECLARE @cContenedor  VARCHAR(618)  
   -- Tabla de Paso INTERFAZ_P42_Bcch  
   CREATE TABLE #New_INTERFAZ_P42  
          (  
           Cabeza           CHAR(02)  
          ,Registro10       CHAR(193)  
          ,Registro20       CHAR(86)  
          ,Registro30       CHAR(66)  
          ,Registro40       CHAR(59)  
          ,Registro50       CHAR(16)  
          ,Registro60       CHAR(198)  
   )  
  
   SELECT @cFecha_Presentacion = @Consulta  
   SELECT @Registro30 = '00000000000       000000000000000000                              '  
-- SELECT @Registro40 = '                  00000000000000000000000                  '  
   SELECT @Registro40 = 'Z                 000000000000000000000000                  '  
   -- Número Planilla inicial  
   SELECT @nNumPlanilla = 0  
  
	SELECT monumope  as Operacion  
	INTO   #Arbi_Empresas  
	FROM   MEMOH
	WHERE  motipmer  = 'EMPR'
	AND    mocodcnv  = 'USD'
	AND    mocodmon <> 'USD'
	AND	   mofech	 = ( select acfecant from BacCamSuda.dbo.meac )


	-->	Si No Esta Realizado el Cierre de la Mesa (0) y la Contabilidad (0). 
	--  Se interpreta que es la interfaz correspondiente al cierre de las 15:00 Horas y no debe considerar las 
	--  operaciones de Arbitrajes
	if	(select substring(aclogdig, 6, 1) from BacCamSuda.dbo.Meac) = 0	--> Sw de Cierre de Mesa
	and (select substring(aclogdig, 8, 1) from BacCamSuda.dbo.Meac) = 0 --> Sw de Contabilidad
	begin
		--> Se Agrega por cambio Normativo	( Tabla que se utiliza para excluir operaciones )
		INSERT INTO #Arbi_Empresas
		SELECT	monumope as Operacion
		FROM	MEMOH
		WHERE	motipmer = 'ARBI'
		AND		mofech	 = ( select acfecant from BacCamSuda.dbo.meac )
	end 
	-->	---------------------------------------------------------------------------------------------------------------------
  
   WHILE (1=1)   
   BEGIN  
  
      SELECT @Cabeza     = '05'  
      SELECT @Registro10 = ''  
      SELECT @Registro20 = ''  
      SELECT @Registro50 = ''  
      SELECT @Registro60 = ''  
      SELECT @nNumPlanillaAux  = -1  
  
      SET ROWCOUNT 1  
		SELECT  @nNumPlanillaAux		= a.planilla_numero
        ,		@cPlanilla_Numero		= RIGHT( '000000' + CONVERT( VARCHAR(06), SUBSTRING( LTRIM(RTRIM( a.planilla_numero )), 1, 6) ), 6 )
        
        ,		@cRut_Interesado		= CASE WHEN a.interesado_rut < 2 THEN '' 
                                                 ELSE                           RIGHT( '000000000' + CONVERT( VARCHAR(09), b.clrut ), 9 ) + b.cldv  
											END
        ,		@CCUN					= '000000000'
        ,		@CACC					= '0000000000000000'
        ,		@cTipo_Operac			= '00'
        ,		@cNombre_Interesado		= a.interesado_nombre
        ,		@cTipo_Documento		= a.tipo_documento
        ,		@cTipo_Operacion		= RIGHT( '000'		+ CONVERT( VARCHAR(03), a.tipo_operacion_cambio ), 3 )
        ,		@cCodigo_Comercio		= RIGHT( '00000'	+ CONVERT( VARCHAR(05), a.codigo_comercio ), 5 )
        ,		@cConcepto				= RIGHT( '000'		+ CONVERT( VARCHAR(03), a.concepto ), 3 )
        ,		@nPais_operacion		= a.pais_operacion
        ,		@cOperacion_moneda		= a.operacion_moneda
        ,		@cMonto_Origen			= RIGHT( '000000000000000' + CONVERT( VARCHAR(15), CONVERT( NUMERIC(15,2),  a.monto_origen ) ), 15 )
        ,		@cMonto_Dolares			= RIGHT( '000000000000000' + CONVERT( VARCHAR(15), CONVERT( NUMERIC(15,2), a.monto_dolares ) ), 15 )
        ,		@cTipo_Cambio			= RIGHT( '000000000' + CONVERT( VARCHAR(09), CONVERT( NUMERIC(09,2),   a.tipo_cambio ) ), 9 )
        ,		@cMonto_Pesos			= RIGHT( '00000000000000000' + CONVERT( VARCHAR(17), CONVERT( NUMERIC(17,2),   a.monto_pesos ) ), 17 )
        ,		@cAfecto_Derivados		= CONVERT( VARCHAR(01), a.afecto_derivados )
        ,		@cTipo_Autorizacion		= autbcch_tipo
        ,		@cNumero_Autorizacion	= CASE WHEN a.autbcch_numero = 0    THEN '000000' ELSE RIGHT( '000000' + CONVERT( VARCHAR(03), a.autbcch_numero ), 6 ) END
        ,		@cFecha_Autorizacion	= ISNULL( (CASE WHEN CONVERT( CHAR(8) , a.autbcch_fecha , 112 ) = '19000101' THEN '00000000' ELSE CONVERT( CHAR(08), a.autbcch_fecha, 112 ) END ) , '00000000' )
        ,		@cCodigo_Institucion	= RIGHT( '000' + CONVERT( VARCHAR(02), a.rel_institucion ), 3 )
        ,		@cFecha_Presentacion1	= ISNULL( CONVERT( CHAR(08), a.rel_fecha, 112 ), '00000000' )

        ,		@cNro_Presen_Op_Relac	= RIGHT( '000000' + CONVERT( VARCHAR(06), SUBSTRING(LTRIM(RTRIM( a.rel_numero )), 1, 6) ), 6 ) 
        
        ,		@cNumero_Inscripcion	= RIGHT( '00000000' + CONVERT( VARCHAR(08), a.ofi_numero_inscripcion ), 8 )
        ,		@cNombre_Financista		= a.ofi_nombre_financista
        ,		@cFecha_Vencimiento		= ISNULL( CONVERT( CHAR(08), a.ofi_fecha_vencimiento, 112 ), '00000000' )
        ,		@cFecha_Desembolso		= ISNULL( CONVERT( CHAR(08), a.ofi_fecha_desembolso, 112 ), '00000000' )
        ,		@cMoneda_Desembolso		= RIGHT( '000' + CONVERT( VARCHAR(03), a.ofi_moneda_desembolso ), 3 )
        ,		@cNumero_Contrato		= RIGHT( '00000000' + CONVERT( VARCHAR(08), a.der_numero_contrato ), 8 )
        ,		@cFecha_Suscripcion		= ISNULL( CONVERT( CHAR(08), a.der_fecha_inicio, 112 ), '00000000' )
        ,		@cObservaciones			= obs_1

		FROM	VIEW_PLANILLA_SPT		A with (nolock) 

				inner join (	select	motipmer, monumope, moestatus 
								from	memoh memo
							--	where	motipmer <> 'empr'	--> Temporal, mientras IBS no pase su componente a Produccion
								where  ( motipmer <> 'empr' 
									or  (select cltipcli from view_cliente where clrut = memo.moRutCli and clcodigo = memo.MOCODCLI ) = 4 
								and		morutcli <> 96665450
										) 
								and		mofech	  = ( select acfecant from BacCamSuda.dbo.meac )

							)	memo	On memo.monumope = operacion_numero

				inner join VIEW_CLIENTE	b with (nolock) On	b.clrut		= a.interesado_rut
														AND	b.clcodigo	= a.interesado_codigo
		WHERE	a.planilla_numero		> @nNumPlanilla
		AND		a.planilla_fecha		= @cFecha_Presentacion
		AND		a.operacion_numero		NOT IN(SELECT Operacion FROM #Arbi_Empresas)
		and		memo.moestatus			= ''
--		AND		b.cltipcli				IN(1,2,3,4) --> Se retira por cambio Normativo
		ORDER BY a.planilla_numero  
  
      SET ROWCOUNT 0  
  
 
      IF @nNumPlanillaAux = -1 BEGIN  
         BREAK  
  
      END  
  
      SELECT @nNumPlanilla = @nNumPlanillaAux  
  
      IF @cCodigo_Institucion='001' BEGIN  
         SELECT @cCodigo_Institucion='010'  
      END     
  
  
      SELECT @cPais_Operacion   = cod_swift FROM view_pais   with (nolock)  WHERE codigo_pais = @nPais_operacion  
      SELECT @cMoneda_Operacion = mniso_coddes FROM view_moneda with (nolock) WHERE mncodmon = @cOperacion_moneda  
  
  
   -- RELACION NUEVOS CODIGOS ------------------------------------------------------------------  
  
      -- MODIFICACIONES MIENTRAS SE MODIFICA EL SISTEMA PARA LOS NUEVOS CODIGOS  
      -- REGISTRO 10  
  
      SELECT @cCodigo_Comercio = codigo_relacion   
        FROM codigo_comercio  with (nolock)   
       WHERE @cCodigo_Comercio = comercio AND  
             @cConcepto        = concepto  
  
      SELECT @cCodigo_Comercio = LEFT(@cCodigo_Comercio,5)  
  
      SELECT @cTipo_Documento  = ( CASE WHEN @cTipo_Documento IN (1,2,5)  THEN '1'      -- C/V
                                       WHEN @cTipo_Documento IN (8,9)    THEN '2'      -- Transferencias  
                                       ELSE '3' END )                                   -- Anulaciones  (3,4,10,11)  
      SELECT @cTipo_Operacion  = '000'  
  
  
      SELECT @cZona_Franca         = '0'  
      SELECT @cSector_Beneficiario      = '00'  
      SELECT @cSector_Inversionista     = '00'  
      SELECT @cPorcentaje_Participacion = '0000'  
  
  ---- FIN NUEVOS CODIGOS -----------------------------------------------------------------------  
  
      -- REGIS10  
      SELECT @Registro10 = @cPlanilla_Numero + @cRut_Interesado + @CCUN + @CACC  +  
   @cTipo_Operac + @cNombre_Interesado + @cTipo_Documento   +  
                       @cCodigo_Comercio + @cPais_Operacion + @cMoneda_Operacion  +   
                       LEFT(     @cMonto_Origen, 12 ) + RIGHT(     @cMonto_Origen, 2 ) +  
                       LEFT(    @cMonto_Dolares, 12 ) + RIGHT(    @cMonto_Dolares, 2 ) +  
                       LEFT(      @cTipo_Cambio,  6 ) + RIGHT(      @cTipo_Cambio, 2 ) +  
                       LEFT(      @cMonto_Pesos, 14 ) + RIGHT(      @cMonto_Pesos, 2 ) +   
                       @cAfecto_Derivados + @cZona_Franca + @cTipo_Autorizacion  +   
   @cNumero_Autorizacion + @cFecha_Autorizacion    +   
   @cCodigo_Institucion + @cFecha_Presentacion1    +   
   @cNro_Presen_Op_Relac  
  
      -- REGIS20  
		IF @cNumero_Inscripcion <> '00000000' 
		BEGIN
         SELECT @Registro20 = @cNumero_Inscripcion + @cNombre_Financista + @cFecha_Vencimiento +  
                        @cFecha_Desembolso + @cMoneda_Desembolso + @cSector_Beneficiario +  
                        @cSector_Inversionista + @cPorcentaje_Participacion + @Registro30 + @Registro40  
		END ELSE 
		BEGIN
         SELECT @Registro20 = '00000000                                                  0000000000000000   000000000'   
      END  
   
      -- REGIS50 ( EX REGIS60 )  
		IF @cNumero_Contrato <> '00000000' 
		BEGIN
         SELECT @Registro50 = @cNumero_Contrato + @cFecha_Suscripcion  
		END ELSE 
		BEGIN
         SELECT @Registro50 = '0000000000000000'  
      END  
  
      -- REGIS60 ( EX REGIS80 )  
      IF @cObservaciones <> '' BEGIN
  
         SELECT @cObservaciones = REPLACE(@cObservaciones,CHAR(13),' ')  
         SELECT @cObservaciones = REPLACE(@cObservaciones,CHAR(10),' ')  
         SELECT @cObservaciones = REPLACE(@cObservaciones,CHAR(9),' ')  
         SELECT @Registro60 = @cObservaciones  
      END  
      ELSE BEGIN  
         SELECT @Registro60 = SPACE(198)  
      END  
  
      INSERT INTO #New_INTERFAZ_P42 VALUES (@Cabeza,@Registro10,@Registro20,@Registro30,@Registro40,@Registro50,@Registro60)       
  
   END  
  
   SELECT  * FROM #New_INTERFAZ_P42
  
   DROP TABLE #New_INTERFAZ_P42  
  
   SET NOCOUNT OFF  
  
END
GO
