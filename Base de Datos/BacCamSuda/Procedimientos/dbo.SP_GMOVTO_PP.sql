USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GMOVTO_PP]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GMOVTO_PP]
       (
        @numope           NUMERIC(07),          -- 01
        @tipmer           CHAR(04),             -- 02
        @tipope           CHAR(01),             -- 03
        @rutcli           NUMERIC(09),          -- 04
        @codcli           NUMERIC(09),          -- 05
        @nomcli           CHAR(35),             -- 06
        @codmon           CHAR(03),             -- 07
        @codcnv           CHAR(03),             -- 08
        @monmo            NUMERIC(19,4),        -- 09
        @ticam            NUMERIC(19,4),        -- 10
        @tctra            NUMERIC(19,4),        -- 11
        @parida           NUMERIC(19,8),        -- 12
        @partr            NUMERIC(19,8),        -- 13
        @ussme            NUMERIC(19,4),        -- 14
        @usstr            NUMERIC(19,4),        -- 15   
        @monpe            NUMERIC(19,4),        -- 16
        @entre            NUMERIC(03),          -- 17
        @recib            NUMERIC(03),          -- 18
        @oper             CHAR(10),             -- 19
        @term             CHAR(12),             -- 20
        @fecha            DATETIME,             -- 21
        @codoma           NUMERIC(03),          -- 22 (xxx)
        @estatus          CHAR(01),             -- 23
        @codejec          NUMERIC(06),          -- 24
        @valuta1          DATETIME,             -- 25 (entregamos)
        @valuta2          DATETIME,             -- 26 (recibimos)
        @rentab           NUMERIC(03),          -- 27
        @linea            CHAR(01),             -- 28
        @entidad          NUMERIC(03),          -- 29
        @precio           NUMERIC(19,4) = 0,    -- 30
        @pretra           NUMERIC(19,4) = 0,    -- 31
        @estado           NUMERIC(01) = -1,     -- 32 (para la captura automatica de fwd)
        @respon           CHAR(03),             -- 33
        @cotab            CHAR(01),             -- 34
        @observa          VARCHAR(250),         -- 35
        @swift_corrdonde  VARCHAR(10),          -- 36
        @swift_corrquien  VARCHAR(10),          -- 37
        @swift_corrdesde  VARCHAR(10),          -- 38
        @plaza_corrdonde  NUMERIC(05),          -- 39
        @plaza_corrquien  NUMERIC(05),          -- 40
        @plaza_corrdesde  NUMERIC(05),          -- 41
        @fpagomxcli       NUMERIC(05),          -- 42 (Canjes) fp mx
        @fpagomncli       NUMERIC(05),          -- 43 (Canjes) FP MN
        @valuta3          DATETIME,             -- 44 (Canjes) Valuta MN
        @valuta4          DATETIME,             -- 45 (Canjes) Valuta MX
        @codigo_area      VARCHAR(05),          -- 46
        @codigo_comercio  CHAR(06),             -- 47
        @codigo_concepto  CHAR(03),             -- 48
        @casamatriz       NUMERIC(03)   = 0,    -- 49
        @montofinal       NUMERIC(19,4) = 0,    -- 50
        @dias             NUMERIC(09)   = 0,    -- 51
        @rutgir           NUMERIC(09),          -- 52
	@codigogirador	  NUMERIC(09),          -- 53	
        @CostoFondo       NUMERIC(10,4),        -- 54
        @utilpe           NUMERIC(19,0),        -- 55
        @tcfin            NUMERIC(19,4),        -- 56
        @FechVcto         DATETIME,		-- 57
        @VamosVienen      NUMERIC(01),          -- 58 Vamos - Vienen
        @MoCorres         NUMERIC(08),          -- 59 Codigo Corresponsal       
	@forward	  CHAR(1) = 'N',	-- 60 Indica si es de Forward
	@der_numero	  NUMERIC(8) = 0,	-- 61 
	@der_inicio	  DATETIME = ''	,	-- 62	
	@der_vcto	  DATETIME = ''	,	-- 63
        @der_precio	  NUMERIC(19,4)=0,	-- 64     
        @der_instr        NUMERIC(2)=0		-- 65
       ) 
AS
BEGIN

   SET NOCOUNT ON

   ----<< Para Planillas Automaticas
   DECLARE @hora            CHAR(08)
   DECLARE @planilla_numero NUMERIC(6)
   DECLARE @planilla_fecha  DATETIME
   DECLARE @rel_numero      NUMERIC(6)
   DECLARE @rel_fecha       DATETIME
DECLARE @rel_arbitraje   CHAR(1)
   DECLARE @moneda          NUMERIC(3)
   DECLARE @rut             NUMERIC(9)
   DECLARE @codcar          NUMERIC(10)
   DECLARE @EntidadBCCH     INTEGER
   DECLARE @oper_contra	    CHAR(1)			-- Operacione Inversa en Operaciones M/X-USD
   DECLARE @rut_banco       NUMERIC(10) 
   DECLARE @PesosxCompra    NUMERIC(19,4)


   SELECT  @rut_banco = acrut FROM meac

   /*** Variables Para la Modificacion ***/
	DECLARE @fx_ticam	NUMERIC(19,4)
	DECLARE @fx_monmo	NUMERIC(19,4)
	DECLARE @fx_ussme	NUMERIC(19,4)
	DECLARE @fx_codcnv	CHAR(03)
	DECLARE @fx_tctra	NUMERIC(19,4)
	DECLARE @fx_parida	NUMERIC(19,8)
	DECLARE @fx_partr       NUMERIC(19,8)
	DECLARE @fx_tipmer	CHAR(04)
	DECLARE @fx_tipope	CHAR(01)
	DECLARE @fx_codmon	CHAR(03)
	DECLARE @fx_costfn 	NUMERIC(15,04)
	DECLARE @fx_USD30  	NUMERIC(19,04)



   /*** Planilla Automatica ***/
   DECLARE @parBCCH         NUMERIC(19,8)
   DECLARE @MtoUSD          NUMERIC(19,8)
   DECLARE @tc_BCCH         NUMERIC(19,8)
   DECLARE @cv_BCCH         CHAR(1)
   DECLARE @tipmoneda       CHAR(1)
   DECLARE @USD30dias       NUMERIC(19,4)

   DECLARE @TipoCliente     NUMERIC(05)
   /*** Fin de Variables  ***/

   SELECT @planilla_numero = 0
   SELECT @planilla_fecha  = @Fecha
   SELECT @rel_numero      = 0
   SELECT @rel_fecha       = ''
   SELECT @rel_arbitraje   = ''
   SELECT @moneda          = 0
   SELECT @TipoCliente     = 0

   SELECT @hora            = CONVERT( CHAR(8), GETDATE() ,108 )

   SELECT       @TipoCliente = ISNULL(cltipcli,0)
          FROM  view_cliente
          WHERE clrut        = @rutcli AND
                clcodigo     = @codcli

   SELECT       @EntidadBCCH = ISNULL( clcodban , 32 )
          FROM  view_cliente, meac 
          WHERE clrut        = acrut and 
                clcodigo     =   1

   SELECT       @tipmoneda = ISNULL(mnrrda,'D')
          FROM  VIEW_MONEDA
          WHERE SUBSTRING(mnnemo,1,3) = @codmon

   SELECT @estado = -1                -- PARA TODOS

   BEGIN TRANSACTION   

   ----<< captura correlativo
   IF @numope = 0   BEGIN
      IF @tipmer = 'EMPR'   BEGIN
         UPDATE MEAC SET  accorope = ( accorope + 1 )
         SELECT @numope = accorope  FROM meac

         --UPDATE MEAC SET  accorempr = ( accorempr + 1 )
         --SELECT @numope = accorempr  FROM meac

      END ELSE IF @tipmer = 'INFO' BEGIN
         UPDATE MEAC SET info_numope = ( info_numope + 1 )
         SELECT @numope = info_numope  FROM meac

      END ELSE BEGIN
         UPDATE MEAC SET  accorope = ( accorope + 1 )
         SELECT @numope = accorope  FROM meac

      END

   END

   /*----<< Carga Paridad BCCH y otros para planilla*/
   SELECT @parBCCH = 0

   /*---- Valida Paridad Mensual del BCCH*/
   SELECT       @parBCCH = ISNULL(vmparmes,0) 
          FROM  VIEW_POSICION_SPT 
          WHERE CONVERT( CHAR(8), vmfecha, 112) = CONVERT( CHAR(8), @fecha, 112) AND
                vmcodigo = @codmon

   ----<< Costo de Fondo para operaciones de Punta es igual a cierre
   IF @tipmer = 'PTAS'   BEGIN
      SELECT  @partr  = @parida
      SELECT  @tctra  = @ticam
      SELECT  @pretra = @precio
      SELECT  @usstr  = @ussme

   END

   ----<< DÃ³lares Calculados de Acuerdo al Central( Monto Moneda Origen / Paridad mensual ) 
   EXECUTE Sp_Funcion_MxMtoUsd30 @codmon , @monmo , @USD30dias OUTPUT

   --------------------------<< Grabando Movimiento
   IF EXISTS ( SELECT 1 FROM MEMO WHERE monumope = @numope )   BEGIN
      -- Respaldo de operaciÃ³n antes de modificar
      INSERT INTO memo_modif SELECT * FROM memo WHERE monumope  = @numope
         
      -- Elimina Operacion Anterior de la Posicion
      SELECT       @fx_ticam  = moticam,
                   @fx_monmo  = momonmo,
                   @fx_ussme  = moussme,
                   @fx_codcnv = mocodcnv,
                   @fx_tctra  = motctra,
 @fx_parida = moparme,
 @fx_partr  = mopartr,
                   @fx_tipmer = motipmer,
                   @fx_tipope = motipope,
                   @fx_codmon = mocodmon,
                   @fx_codcnv = mocodcnv,
		   @fx_costfn = mocostofo,
		   @fx_USD30  =	mouss30
	FROM  memo
	WHERE monumope  = @numope
   
      	SELECT @fx_monmo = @fx_monmo * -1
   	SELECT @fx_ussme = @fx_ussme * -1
	SELECT @fx_USD30 = @fx_USD30 * -1
	SELECT @oper_contra = ( CASE @fx_tipope WHEN 'C' THEN 'V' ELSE 'C' END )

	IF @forward <> 'S'  -- Esto Es mientras no se define correctamente el cÃ¡lculo de los Forward

		BEGIN
		IF @fx_tipmer = 'EMPR' 
			BEGIN
				EXECUTE Sp_Recalc @fx_codmon,  @fx_tipmer, @fx_tipope, @fx_costfn, @fx_USD30

				IF @fx_codcnv = 'USD'  -- Operaciones Empresas M/X-USD
					BEGIN
						EXECUTE Sp_Recalc @fx_codmon,  @fx_tipmer,  @oper_contra , @fx_costfn, @fx_ussme
					END

				EXECUTE sp_recalc_empresas	@fx_tipope	,
								@fx_ticam	,
								@fx_ussme	,
								@fx_codmon	,
								@fx_codcnv	,
								@fx_tctra	,
								@fx_parida	,
								@fx_partr	,
								@fx_monmo
			END
	    	ELSE
			BEGIN
				EXECUTE Sp_Recalc @fx_codmon,  @fx_tipmer, @fx_tipope, @fx_ticam, @fx_USD30

				IF @fx_codcnv = 'USD'  -- Operaciones Puntas M/X-USD
					BEGIN
						EXECUTE Sp_Recalc @fx_codmon,  @fx_tipmer, @oper_contra , @fx_ticam , @fx_ussme
					END

			END	
	END


        DELETE view_planilla_spt 
         WHERE operacion_numero = @numope AND
               operacion_fecha  = @fecha

      IF @@error <> 0 BEGIN
         ROLLBACK TRANSACTION
         SELECT -1, 'NO SE PUEDE ELIMINAR DATOS ANTERIORES A LA MODIFICACION'
         RETURN

      END

      UPDATE memo
             SET   monumope           = @numope,
                   motipmer           = @tipmer,
                   motipope           = @tipope,
                   morutcli           = @rutcli,
                   mocodcli           = @codcli,
                   monomcli           = @nomcli,
                   mocodmon           = @codmon,
                   mocodcnv           = @codcnv,
                   momonmo            = @monmo,
                   moticam            = @ticam,
                   motctra            = @tctra,
                   moparme            = @parida,
                   mopar30            = @parBCCH,
                   mopartr            = @partr,
                   moussme            = @ussme,
                   mousstr            = @usstr,
                   mouss30            = @USD30dias ,
                   momonpe            = @monpe,
                   moentre            = @entre,
                   morecib            = @recib,
                   mooper             = @oper,
                   moterm             = @term,
                   mohora             = @hora,
                   mofech             = @fecha,
                   mocodoma           = @codoma,
                   moestatus          = @estatus,
                   mocodejec          = @codejec,
                   movaluta1          = @valuta1,
                   movaluta2          = @valuta2,
                   morentab           = @rentab,
                   moalinea           = @linea,
                   moentidad          = @entidad,
                   moprecio           = @precio,
                   mopretra           = @pretra,
                   id_sistema         = @respon,
                   contabiliza        = @cotab,
                   observacion        = @observa,
                   swift_corresponsal = @swift_corrdonde,
                   swift_recibimos    = @swift_corrquien,
                   swift_entregamos   = @swift_corrdesde,
                   plaza_corresponsal = @plaza_corrdonde,
                   plaza_recibimos    = @plaza_corrquien,
                   plaza_entregamos   = @plaza_corrdesde,
                   forma_pago_cli_nac = @fpagomncli,
forma_pago_cli_ext = @fpagomxcli,
            	   valuta_cli_nac     = @valuta3,
                   valuta_cli_ext     = @valuta4,
                   codigo_area        = @codigo_area,
                   codigo_comercio    = @codigo_comercio,
                   codigo_concepto    = @codigo_concepto,
                   morutgir           = @rutgir,
		   mocodigogirador    = @codigogirador,
                   mocostofo          = @CostoFondo,
                   moutilpe           = @utilpe,
                   motcfin            = @tcfin,
                   mofecvcto          = @FechVcto,
                   modias             = @dias,
                   movamos            = @VamosVienen,
                   mocorres           = @MoCorres,
		   motipcar 	      = @der_instr,
		   monumfut           = @der_numero,
		   mofecini           = @der_inicio
             WHERE monumope           = @numope

   END ELSE BEGIN

      INSERT INTO memo
                      ( 
                       monumope,
                       motipmer,
             	       motipope,
                       morutcli,
                       mocodcli,
                       monomcli,
                       mocodmon,
                       mocodcnv,
                       momonmo,
                       moticam,
                       motctra,
                       moparme,
                       mopar30,
                       mopartr,
                       moussme,
                       mouss30,
                       mousstr,
                       momonpe,
                       moentre,
                       morecib,
                       mooper,
                       moterm,
                       mohora,
                       mofech,
          	       mocodoma,
                       moestatus,
                       mocodejec,
                       movaluta1,
                       movaluta2,
                       morentab,
                       moalinea,
                       moentidad,
                       moprecio,
                       mopretra,
                       id_sistema,
                       contabiliza,
                       observacion,
                       swift_corresponsal,
                       swift_recibimos,
                       swift_entregamos,
                       plaza_corresponsal,
                       plaza_recibimos,
                       plaza_entregamos,
                       forma_pago_cli_nac,
                       forma_pago_cli_ext,
                       valuta_cli_nac,
                       valuta_cli_ext,
                       codigo_area,
                       codigo_comercio,
                       codigo_concepto,
                       morutgir,
		       mocodigogirador,
                       mocostofo,
                       moutilpe,
                       motcfin,
                       mofecvcto,
                       modias,
                       movamos,
                       mocorres,
		       motipcar,
		       monumfut,           
		       mofecini            	        
                      )
             VALUES   (
                       @numope,
                       @tipmer,
                       @tipope,
                       @rutcli,
                       @codcli,
                       @nomcli,
                       @codmon,
                       @codcnv,
                       @monmo,
                       @ticam,
                       @tctra,
                       @parida,
                       @parBCCH,
                       @partr,
                       @ussme,
                       @USD30dias ,
                       @usstr,
                       @monpe,
                       @entre,
                       @recib,
                       @oper,
                       @term,
                       @hora,
                       @fecha,
@codoma,
 @estatus,
                       @codejec,
         @valuta1,
                       @valuta2,
                       @rentab,
                       @linea,
		       @entidad,
		       @precio,
                       @pretra,
                       @respon,
                       @cotab,
                       @observa,
                       @swift_corrdonde,
                       @swift_corrquien,
                       @swift_corrdesde,
                       @plaza_corrdonde,
                       @plaza_corrquien,
                       @plaza_corrdesde,
                       @fpagomncli,
                       @fpagomxcli,
                       @valuta3,
                       @valuta4,
                       @codigo_area,
                       @codigo_comercio,
                       @codigo_concepto,
                       @rutgir,
		       @codigogirador,
                       @CostoFondo,
                       @utilpe,
                       @tcfin,
                       @FechVcto,
                       @dias,
                       @VamosVienen,
                       @MoCorres,
		       @der_instr,
		       @der_numero,
		       @der_inicio
                      )

      SELECT @rut    = ISNULL( (SELECT rcrut FROM VIEW_ENTIDAD WHERE rccodcar = @entidad) , 0 )
      SELECT @codcar = ISNULL( (SELECT rccodcar FROM VIEW_ENTIDAD WHERE rccodcar = @entidad) , 0 )

      IF @tipmer = 'PTAS' BEGIN
         UPDATE meac 
                SET   acultpta = (CASE @tipope WHEN 'C' THEN 'COMPRA A ' ELSE 'VENTA A ' END) +
                                 SUBSTRING( @nomcli , 1,20 ) + ' ' + @codmon,
                      acultmon = @monmo,
                      acultpre = @ticam

                WHERE acrut    = @rut      AND
                      accodigo = @codcar

      END ELSE BEGIN 
         UPDATE meac 
                SET   acultempr    = (CASE @tipope WHEN 'C' THEN 'COMPRA A ' ELSE 'VENTA A ' END) +
                                     SUBSTRING( @nomcli , 1,20 ) + ' ' + @codmon,
                      acultmonempr = @monmo,
                      acultpreempr = @ticam,
                      acultpta     = (CASE @tipope WHEN 'C' THEN 'COMPRA A ' ELSE 'VENTA A ' END) +
                                      SUBSTRING( @nomcli , 1,20 ) + ' ' + @codmon,
                      acultmon     = @monmo,
                      acultpre     = @ticam

                WHERE acrut        = @rut    AND 
                      accodigo     = @codcar

      END

   END 

   IF 	@codcnv = 'CLP' 										AND 
	@tipmer IN ('PTAS' , 'CANJ', 'EMPR') 								AND 
      	( ( @TipoCliente > 0 AND @TipoCliente < 5 ) OR @forward = 'S' ) 	                        AND 
      	( @rutcli <> 1 AND @rutcli <> 2 AND @rutcli <> 3 AND @rutcli <> 4 AND @rutcli <> 5 		AND 
        @rutcli <> 70 AND @rutcli <> @rut_banco)
	BEGIN

      /*----<< Carga codigo de Moneda*/
      SELECT @moneda = 0

      SELECT       @moneda = ISNULL(mncodmon,0)
             FROM  VIEW_MONEDA
             WHERE SUBSTRING(mnnemo,1,3) = @codmon

      IF @moneda = 0 BEGIN
         ROLLBACK TRANSACTION
         SELECT -1, 'CODIGO DE MONEDA ORIGINAL PARA PLANILLA AUTOMATICA NO FUE ENCONTRADA'
         RETURN 

      END

      /*----<< Carga Paridad BCCH y otros para planilla*/
      SELECT @parBCCH = 0
      SELECT @MtoUSD  = 0
      SELECT @tc_BCCH = 0
      SELECT @cv_BCCH = @tipope

      /*---- Valida Paridad Mensual del BCCH*/
      SELECT       @parBCCH = ISNULL(vmparmes,0) 
             FROM  VIEW_POSICION_SPT 
             WHERE CONVERT( CHAR(8), vmfecha, 112) = CONVERT( CHAR(8), @fecha, 112) AND
                   vmcodigo = @codmon

      IF @parBCCH IS NULL BEGIN
         ROLLBACK TRANSACTION
         SELECT -1, 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA'
         RETURN 

      END ELSE IF @parBCCH = 0 BEGIN
       ROLLBACK TRANSACTION
         SELECT -1, 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA'
         RETURN 

      END

      /*----<< valores para planilla*/
      SELECT  @MtoUSD  = round( @monmo / @parBCCH , 2 )
      SELECT  @tc_BCCH = round( @monpe / @MtoUSD  , 4 )
      
      SELECT  @PesosxCompra =  @monmo * @tctra
      /*----<< Canje*/
      IF @tipmer = 'CANJ'   BEGIN 
         ---Compra de Dolares
         EXECUTE @estado = Sp_Graba_Planilla_Automatica @entidad,
                                                         @tipmer,
                                                         'C',
                                                         @fecha,
            	 					 @numope,
                                                         @moneda,
                                                         @rutcli,
                                                         @codcli,
                                                         @monmo,
                                                         @parida,
                                                         @ussme,
       						         @tctra,
                                             		 @PesosxCompra,
							 @der_numero,
							 @der_inicio,
							 @der_vcto,
							 @der_precio,
							 @der_instr,
                                                         @EntidadBCCH,   -- relacion planilla, codigo del Bco segun el BCCH
                     					 @rel_fecha,
							 @rel_numero,
                                                         @rel_arbitraje,
                                                         @codigo_area,
                                                         @codigo_comercio,
                                                         @codigo_concepto,
                                                         @planilla_numero OUTPUT,
                                                         @planilla_fecha  OUTPUT

         IF @estado <> 0   BEGIN
            ROLLBACK TRANSACTION
            SELECT -1, 'No se puede generar planilla automatica de ingreso Canje'
            RETURN 
         END

         ---Venta de Dolares
         SELECT @planilla_numero = 0
         EXECUTE @estado = Sp_Graba_Planilla_Automatica @entidad,
                                                        @tipmer,
                                                        'V',
                                                        @fecha,
                                                        @numope,
                                                        @moneda,
                                                        @rutcli,
                                                        @codcli,
                                                        @monmo,
                                                        @parida,
                                                        @ussme,
                                                        @ticam,        -- Cambia
                                                        @monpe,        -- Cambia
							 @der_numero,
							 @der_inicio,
							 @der_vcto,
							 @der_precio,
							 @der_instr,
                                                        @EntidadBCCH,  -- relacion planilla, codigo del Bco segun el BCCH
                                                        @rel_fecha,    -- cambia
                                                        @rel_numero,
                                                        @rel_arbitraje,
                                                        @codigo_area,
                                                        @codigo_comercio,
                                                        @codigo_concepto,
                                                        @planilla_numero OUTPUT,
                                                        @planilla_fecha  OUTPUT 

         IF @estado <> 0 BEGIN
            ROLLBACK TRANSACTION
   SELECT -1, 'No se puede generar planilla automatica de egreso Canje'
            RETURN

         END

      END ELSE BEGIN

         EXECUTE @estado = Sp_Graba_Planilla_Automatica  @entidad,
                                                         @tipmer,
                                                         @tipope,
                                                         @fecha,
                                                         @numope,
                                                         @moneda,
                                                         @rutcli,
                       					 @codcli,
                     					 @monmo,
                                                         @parBCCH,
                                                	 @MtoUSD,
                                                         @tc_BCCH,
                                                         @monpe,
							 @der_numero,
							 @der_inicio,
							 @der_vcto,
							 @der_precio,
							 @der_instr,
                                                         0,       -- relacion planilla, codigo del Bco segun el BCCH
                                                         '',
                                                         0,
                                                         '',
                                                         @codigo_area,
                                                         @codigo_comercio,
                                                         @codigo_concepto,
                                                         @planilla_numero OUTPUT,
                                                         @planilla_fecha  OUTPUT 

         IF @estado <> 0   BEGIN
            ROLLBACK TRANSACTION
            SELECT -1, 'No se puede generar planilla automatica para operacion Spot'
            RETURN 

         END

      END

   END -- Planilla Automatica de M/X / $$

   -------------------------------------------<< Arbitrajes
   IF @tipmer = 'ARBI' OR ( @tipmer = 'EMPR' AND @forward = 'S' AND  @codcnv = 'USD' ) BEGIN
      SELECT @parBCCH = 0
      SELECT @MtoUSD  = 0
      SELECT @tc_BCCH = 0
      SELECT @cv_BCCH = ''

    		
      SELECT       @moneda = ISNULL(mncodmon,0)
             FROM  VIEW_MONEDA
             WHERE SUBSTRING(mnnemo,1,3) = @codmon

      ---- Valida Paridad Mensual del BCCH
      SELECT       @parBCCH = ISNULL(vmparmes,0) 
             FROM  VIEW_POSICION_SPT 
             WHERE CONVERT( CHAR(8), vmfecha, 112) = CONVERT( CHAR(8), @fecha, 112) AND
                   vmcodigo = @codmon

      IF @parBCCH IS NULL BEGIN
         ROLLBACK TRANSACTION
         SELECT -1, 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA DE ARBITRAJE'
         RETURN 

      END IF @parBCCH = 0 BEGIN
         ROLLBACK TRANSACTION
         SELECT -1, 'PARIDAD BCCH DE MONEDA NO EXISTE PARA PLANILLA AUTOMATICA DE ARBITRAJE'
         RETURN 

      END

      SELECT  @MtoUSD  = round( @monmo / @parBCCH, 2 )
      SELECT  @tc_BCCH = round( @monpe / @MtoUSD , 4 )

      EXECUTE @estado = Sp_Graba_Planilla_Automatica_PP @entidad,
                                                     'ARBI', --@tipmer
                                                     @tipope,
                                                     @fecha,
                                                     @numope,
                                                     @moneda,
                                                     @rutcli,
               					     @codcli,
                                                     @monmo,
                                                     @parBCCH,
                                                     @MtoUSD,
                                                     @tc_BCCH,
                                                     @monpe,
							 @der_numero,
							 @der_inicio,
							 @der_vcto,
							 @der_precio,
							 @der_instr,
                                                     @EntidadBCCH,      -- relacion planilla, segun BCCH
                                                     @rel_fecha,
                                                     @rel_numero,
                                                     @rel_arbitraje,
                    				     @codigo_area,
                                                     @codigo_comercio,
                                                     @codigo_concepto,
                                                     @planilla_numero OUTPUT,
                                                     @planilla_fecha  OUTPUT

      IF @estado <> 0   BEGIN
	 ROLLBACK TRANSACTION
         SELECT -1, 'No se puede generar planilla automatica principal de arbitraje'
         RETURN 

      END

      SELECT @rel_fecha = @planilla_fecha
/*
      UPDATE    view_planilla_spt 
      SET   	rel_institucion = entidad
      WHERE 	planilla_numero = @planilla_numero     AND
                   CONVERT( CHAR(8), planilla_fecha, 112) = @planilla_fecha
  */    
     
      ----<< Planilla Moneda Cnv de operacion
      SELECT @moneda  = 0
      SELECT       @moneda  = ISNULL(mncodmon,1)
             FROM  VIEW_MONEDA
             WHERE SUBSTRING(mnnemo,1,3) = @codcnv

      IF @moneda is NULL BEGIN
         ROLLBACK TRANSACTION
         SELECT -1,'PARIDAD BCHH DE MONEDA CONVERSION PARA PLANILLA AUTOMTICA NO FUE ENCONTRADA'
         RETURN 

      END IF @moneda = 0 BEGIN
         ROLLBACK TRANSACTION
         SELECT -1,'PARIDAD BCHH DE MONEDA CONVERSION PARA PLANILLA AUTOMTICA NO FUE ENCONTRADA'
         RETURN 

      END

      SELECT @parBCCH = 1	-- CorrecciÃ³n DMV,JCL

      SELECT @cv_BCCH = (CASE @tipope WHEN 'C' THEN 'V' ELSE 'C' END)
      SELECT @MtoUSD  = ROUND( @ussme / @parBCCH, 2 )
      SELECT @tc_BCCH = ROUND( @monpe / @MtoUSD , 4 )
--****

      select @entidad,
                                                     'ARBI', --@tipmer
                                                     @cv_BCCH,
                                                     @fecha,
                                                     @numope,
                                                     @moneda,
                                                     @rutcli,
                                                     @codcli,
                                                     @ussme,
                                                     @parBCCH,
                                                     @MtoUSD,
                                                     @tc_BCCH,
                                                     @monpe,
							 @der_numero,
							 @der_inicio,
							 @der_vcto,
							 @der_precio,
							 @der_instr,
                                                     @EntidadBCCH,      -- Relacion
                                                     @planilla_fecha,
                                                     @planilla_numero,
                                                     'A',
						     @codigo_area,
                                                     @codigo_comercio,
                                                     @codigo_concepto



--*****

      EXECUTE @estado = Sp_Graba_Planilla_Automatica_PP @entidad,
                                                     'ARBI', --@tipmer
                                                     @cv_BCCH,
                                                     @fecha,
                                                     @numope,
                                                     @moneda,
                                                     @rutcli,
                                                     @codcli,
                                                     @ussme,
                                                     @parBCCH,
                                                     @MtoUSD,
                                                     @tc_BCCH,
                                                     @monpe,
							 @der_numero,
							 @der_inicio,
							 @der_vcto,
							 @der_precio,
							 @der_instr,
                                                     @EntidadBCCH,      -- Relacion
                                                     @planilla_fecha,
                                                     @planilla_numero,
                                                     'A',
						     @codigo_area,
                                                     @codigo_comercio,
                                                     @codigo_concepto,
                                                     @rel_numero OUTPUT,
                                                     @rel_fecha  OUTPUT

      IF @estado <> 0  BEGIN
         ROLLBACK TRANSACTION
         SELECT -1, 'No se puede generar planilla automatica contramoneda de arbitraje'
         RETURN

      END
/*
      SELECT @rel_fecha,@rel_numero,@planilla_numero,@planilla_fecha,@EntidadBCCH

      UPDATE       view_planilla_spt 
             SET   rel_institucion = entidad,
                   rel_fecha       = @rel_fecha,
                   rel_numero      = @rel_numero,
                rel_arbitraje  = 'A'
             WHERE planilla_numero = @planilla_numero     AND
                   CONVERT( CHAR(8), planilla_fecha, 112) = @planilla_fecha
*/
      IF @@error <> 0 BEGIN
         ROLLBACK TRANSACTION
         SELECT -1, 'NO SE PUEDEN RELACIONAR LAS PLANILLAS AUTOMATICA POR ARBITRAJE'
         RETURN 

      END

   END

   COMMIT TRANSACTION

   SELECT @oper_contra = ( CASE @tipope WHEN 'C' THEN 'V' ELSE 'C' END ) 

   ------<< Actualiza Posicion
   IF @forward <> 'S' -- Esto Es mientras no se define correctamente el cÃ¡lculo de los Forward
	BEGIN

	   IF @tipmer = 'EMPR' 
		BEGIN
			EXECUTE Sp_Recalc @codmon,  @tipmer, @tipope, @CostoFondo, @USD30dias

			IF @codcnv = 'USD'  -- Operaciones Empresas M/X-USD
				BEGIN
					EXECUTE Sp_Recalc @codmon,  @tipmer, @oper_contra , @CostoFondo , @ussme
				END

			EXECUTE sp_recalc_empresas	@tipope	,
							@ticam	,
							@ussme	,
							@codmon	,
							@codcnv	,
							@tctra	,
							@parida	,
							@partr	,
							@monmo
		END

	    ELSE
		BEGIN

			EXECUTE Sp_Recalc @codmon,  @tipmer, @tipope, @ticam, @USD30dias

			IF @codcnv = 'USD'  -- Operaciones Puntas M/X-USD
				BEGIN
					EXECUTE Sp_Recalc @codmon,  @tipmer, @oper_contra , @ticam , @ussme
				END

		END	

	END
   ------<< Retorna numero de operacion

   SELECT @numope , 'OK'

END

GO
