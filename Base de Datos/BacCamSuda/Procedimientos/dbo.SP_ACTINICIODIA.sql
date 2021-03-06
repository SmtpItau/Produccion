USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTINICIODIA]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTINICIODIA]
                                (       @entidad    char(2),
					@fechaprop  datetime,
					@fechaprx   datetime,
					@ddhabil    numeric(1)
				)
AS
BEGIN

   SET NOCOUNT ON

        DECLARE @npos    	numeric(7)	,
		@nposaux   	numeric(7)	,
		@tipope    	char(1)		,			
		@gcodoma   	char(4)		,
		@rutcli    	numeric(9)	,
		@codcli    	numeric(9)	,
		@nomcli    	char(35)	,
		@mtousd    	numeric(17,4)	,
		@tipcam    	numeric(10,4)	,
		@fpmxi    	numeric(2)	,
		@fpmni    	numeric(2)	,
		@fpmxv    	numeric(2)	,
		@fpmnv    	numeric(2)	,
		@fecvto    	datetime	,
		@fechab    	datetime	,
		@fechac    	datetime	,
		@user    	char(10)	,
		@entre    	numeric(7)	,
		@recib    	numeric(7)	,
		@codoma    	numeric(3)	,
		@valuta1   	datetime	,
		@valuta2	datetime	,
		@monpe    	numeric(19,4)	,
		@numope    	numeric(7)	,
		@fecant    	char(8)         ,
                @acummesdiaant  numeric(19,4)

   BEGIN TRANSACTION
         
        SELECT  @acummesdiaant   = 0      
        SELECT  @acummesdiaant   = ISNULL(acacummes,0) FROM MEACH  WHERE  acfecprx =@fechaprop
 
	SELECT 	@fecant = CONVERT(CHAR(8),acfecpro,112) FROM MEAC

	UPDATE 	MEAC
	SET 	acposini     = acposic    ,
		acpmeco      = 0       ,
		acpmeve      = 0       ,
		acpmecopo    = 0       ,
		acpmevepo    = 0       ,
		acutilipo    = 0       ,
		acutili      = 0       ,
		acutiltot    = 0       ,
		actotco      = 0       ,
		actotve      = 0       ,
		actotcopo    = 0       ,
		actotvepo    = 0       ,
		acpmecofi    = 0       ,
		acpmevefi    = 0       ,
		actotalpe    = 0       ,
		acultpta     = ''         ,
		acultmon     = 0       ,
		acultpre     = 0       ,
		acpcierre    = ''         ,
		acfecpro     = @fechaprop ,
		acfecprx     = @fechaprx  ,
		acfecant     = @fecant    ,
		cp_totco     = 0          ,
		cp_totve     = 0          ,
		cp_totcop    = 0          ,
		cp_totvep    = 0          ,
		cp_utili     = 0          ,
		cp_pmeco     = 0          ,
		cp_pmeve     = 0          ,
		cp_utico     = 0          ,
		cp_utive     = 0          ,
		cp_pmecoci   = 0          ,
		cp_pmeveci   = 0          ,
		ac_totcop    = 0          ,
		ac_totvep    = 0          ,
		ac_pmecore   = 0          ,
		ac_pmevere   = 0          ,
		ac_totcore   = 0          ,
		ac_totvere   = 0          ,
		actotcopre   = 0          ,
		actotvepre   = 0          ,
		acultempr    = ''         ,
		acultmonempr = 0          ,
		acultpreempr = 0          ,
		accorempr    = 0          ,
		achedgeinicialfuturo 	= achedgeactualfuturo, --+achedgevctofuturo	,
		achedgeactualfuturo  	= achedgeactualfuturo, --+achedgevctofuturo	,
--		achedgevctofuturo    	= 0					,
		achedgeinicialspot   	= achedgeactualspot			,
		achedgeutilidad 	= 0					,
		acacumdia		= 0                                     ,
                info_utili              = achedgeactualspot                     ,
                acacummes               = @acummesdiaant                        ,
                swOpeCalceCorredora     = 1 --> Se inicializa el control de Operaciones de Calce --> 16-11-2010
   
                IF @ddhabil = 1 
                   UPDATE MEAC SET acacummes = 0  

	        IF @@ERROR <> 0 
		BEGIN
			ROLLBACK TRANSACTION
			SELECT -1,'ERROR: NO SE PUDO ACTUALIZAR PARAMETROS DE CONTROL'
			SET NOCOUNT OFF
			RETURN -1
		END

	UPDATE 	VIEW_VALOR_MONEDA 
	SET	vmposini = vmposic    ,
		vmpmeco  = 0   ,
		vmpmeve  = 0   ,
		vmtotco  = 0   ,
		vmtotve  = 0   ,
		vmutili  = 0   ,
		vmprecoc = 0   ,
		vmparidc = 0   ,
		vmpreco  = 0

	IF @@ERROR <> 0 
		BEGIN
			ROLLBACK TRANSACTION
			SELECT -1, 'ERROR: NO SE PUDO ACTUALIZAR VALORES DE MONEDAS'
			SET NOCOUNT OFF
			RETURN -1
		END
    --------------------- limpia movimientos
	DELETE MEMO
--	DELETE MEMOC
	DELETE MEATA
	DELETE MESMO
	DELETE MESCX
	DELETE MEUS
	DELETE tbtransferencia 
	DELETE tbtransferencia_detalle 
	DELETE TxOnlineCorredora

    	UPDATE 	MEMR 
	SET	mrposini = mrposic,
		mrpmeco  = 0,
		mrpmeve  = 0,
		mrtotco  = 0,
		mrtotve  = 0,
		mrutili  = 0,
		mrposic  = 0

    -------------------<< actualiza mepos
    	DELETE	VIEW_POSICION_SPT 
	WHERE 	CONVERT(CHAR(8),vmfecha,112) = CONVERT(CHAR(8),@fechaprop,112)

	IF NOT EXISTS (SELECT vmfecha FROM VIEW_POSICION_SPT WHERE CONVERT(CHAR(8),vmfecha,112) = @fecant)
        BEGIN
	      INSERT INTO VIEW_POSICION_SPT( VMCODIGO, VMFECHA )
                 SELECT SUBSTRING(mnsimbol,1,3),CONVERT(CHAR(8),@fechaprop,112)
			FROM 	VIEW_MONEDA 
			WHERE 	mnmx = 'C'

			IF @@ERROR <> 0
			BEGIN
					ROLLBACK TRANSACTION
					SELECT -1,'ERROR: NO SE PUEDEN INICIALIZAR POSICIONES DE MONEDAS'
					SET NOCOUNT OFF
					RETURN -1
			END
	END ELSE
	BEGIN
			INSERT INTO VIEW_POSICION_SPT( vmcodigo, vmfecha, vmposini, vmpreini, vmposic, vmparidad, vmparmes )
			SELECT  vmcodigo, @fechaprop, vmposic , vmpreini, vmposic, vmparidad, vmparmes
			FROM 	VIEW_POSICION_SPT
			WHERE CONVERT(CHAR(8),vmfecha,112) = @fecant

			IF @@ERROR <> 0
				BEGIN
					ROLLBACK TRANSACTION
					SELECT -1,'ERROR: NO SE PUEDEN ACTUALIZAR POSICIONES DE MONEDAS PARA HOY'
					SET NOCOUNT OFF
					RETURN -1
				END
        END

    -- observado como precio inicial de usd
	DECLARE @observado FLOAT
	SELECT  @observado = 0

	SELECT  @observado = isnull(vmvalor ,0)
	FROM  	VIEW_VALOR_MONEDA  
	WHERE  	vmcodigo = 994 AND CONVERT(CHAR(8),vmfecha,112) = CONVERT(CHAR(8),@fechaprop,112)

	IF @observado = 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT -1,'ERROR: VALOR DEL OBSERVADO PARA EL ' + CONVERT(CHAR(10),@FECHAPROP,103) + ' ESTA EN CERO.'
			SET NOCOUNT OFF
			RETURN -1
		END

	UPDATE 	VIEW_POSICION_SPT
	SET 	VIEW_POSICION_SPT.vmpreini   = VIEW_VALOR_MONEDA.vmvalor, 
		VIEW_POSICION_SPT.vmparidad  = 1
	FROM 	VIEW_VALOR_MONEDA  
	WHERE 	VIEW_POSICION_SPT.vmcodigo  = 'USD'
		AND CONVERT(CHAR(8), VIEW_POSICION_SPT.vmfecha,112) = CONVERT(CHAR(8),@fechaprop,112)
		AND VIEW_VALOR_MONEDA.vmcodigo       = 994   
		AND CONVERT(CHAR(8),VIEW_VALOR_MONEDA.vmfecha,112)  = CONVERT(CHAR(8),@fechaprop,112) -- observado

--------------------realiza vencimientos
	UPDATE 	TRANSFERENCIA_PENDIENTE
	SET 	Estado_transferencia = 'V'
	WHERE 	fecha_vencimiento <= ( SELECT acfecpro FROM MEAC )

	UPDATE 	BACLINEAS..matriz_atribucion_instrumento 
	SET	Acumulado_Diario = 0
	WHERE 	Id_Sistema = 'BCC'


   COMMIT TRANSACTION

     -- VB+- 29/07/2009 
	EXECUTE cal_resumenMonedas
     -- VB+-

	-->		Completa la Grabacion de los Parametros Diarios
	EXECUTE dbo.Graba_Parametros_Diarios
	-->		Completa la Grabacion de los Parametros Diarios

	SELECT 0, 'OK'

	SET NOCOUNT OFF

END
GO
