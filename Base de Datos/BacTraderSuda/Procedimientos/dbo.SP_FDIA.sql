USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FDIA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FDIA]
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @sw_fd                  CHAR(01)
	,       @sw_co                  CHAR(01)
	,       @sw_finmes              CHAR(01)
	,       @dFecpro                DATETIME
	,       @nretorno               INTEGER
	,       @nMes                   INTEGER
	,       @nDia                   INTEGER
	,       @cMes                   CHAR(02)
	,       @cDia                   CHAR(02)
	,       @cStrexec               CHAR(255)
	,       @cArcMDAC               CHAR(14)
	,       @cArcMDCP               CHAR(14)
	,       @cArcMDCI               CHAR(14)
	,       @cArcMDVI               CHAR(14)
	,       @cArcMDDI               CHAR(14)
	,       @cArcMDRS               CHAR(14)
	,       @cArcMDMO               CHAR(14)
	,       @cArcMDCO               CHAR(14)
	,       @cArcMDNS               CHAR(14)
	,       @cArcMDCV               CHAR(14)
	,       @cArcMargen_Articulo84  CHAR(25)
	,       @fIpc_Mes               FLOAT
	,       @dFecha                 DATETIME

	SELECT  @sw_fd			= acsw_fd
	,       @sw_co			= acsw_co
	,       @sw_finmes		= acsw_finmes
	,       @dFecpro		= acfecproc
	FROM    MDAC			with(nolock)


	SELECT  @nMes  = DATEPART(MONTH,@dFecpro)  
	,       @nDia  = DATEPART(DAY,@dFecpro)  

	IF @nMes < 10  
		SELECT @cMes = '0' + CONVERT(CHAR(1),@nMes)  
	ELSE  
		SELECT @cMes =       CONVERT(CHAR(2),@nMes)  

	IF @nDia < 10  
		SELECT @cDia = '0' + CONVERT(CHAR(1),@nDia)  
	ELSE  
		SELECT @cDia =       CONVERT(CHAR(2),@nDia)  

	IF @sw_fd = '1'  
	BEGIN  
		SELECT 'NO','El Proceso de Fin de Dia fue Realizado'  
		RETURN  
	END  

	BEGIN TRANSACTION  
 
	UPDATE MDAC  
	SET    acsw_pd      = '0'  
	,      acsw_rc      = '0'  
	,      acsw_rv      = '0'  
	,      acsw_co      = '0'  
	,      acsw_dvprop  = '0'  
	,      acsw_dvci    = '0'  
	,      acsw_dvvi    = '0'  
	,      acsw_dvib    = '0'  
	,      acsw_dv      = '0'  
	,      acsw_cm      = '0'  
	,      acsw_mesa    = '1'  
	,      acsw_ptw     = '0'  
	,      acsw_trd     = '0'  
	,      acsw_btw     = '0'  
	,      acsw_mm      = '0'  
	,      acsw_finmes  = '0'  
	,      acint_c8     = '0'  
	,      acint_cte    = '0'  
	,      acint_cteii  = '0'  
	,      acint_p17    = '0'  
	,      acint_d3     = '0'  
	,      acint_cli    = '0'  
	,      acint_col    = '0'  
	,      acint_c14    = '0'  
	,      acint_rcc    = '0'  
	,      acint_ges    = '0'  
	,      acsw_ges     = '0'  
	,      acsw_fd      = '1'  
  
	IF @@ERROR <> 0
	BEGIN
	  SELECT 'NO', 'No se Pudieron Actualizar Switch de Control de Procesos'
	  ROLLBACK TRANSACTION
	  RETURN
	END

	/*+++ jcamposd 20180515 No debe eliminar la historia de aprobación
	DELETE VIEW_LIMITE_TRANSACCION_ERROR  WHERE id_sistema = 'BTR'
	DELETE VIEW_LIMITE_TRANSACCION        WHERE id_sistema = 'BTR'
	DELETE VIEW_APROBACION_OPERACIONES    WHERE id_sistema = 'BTR'
	--- jcamposd 20180515 No debe eliminar la historia de aprobación
	*/
	
	COMMIT TRANSACTION  

	SELECT @cArcMDAC              = 'MDAC'              + @cMes + @cDia  
	,      @cArcMDCP              = 'MDCP'              + @cMes + @cDia  
	,      @cArcMDCI              = 'MDCI'              + @cMes + @cDia  
	,      @cArcMDVI              = 'MDVI'              + @cMes + @cDia  
	,      @cArcMDDI              = 'MDDI'              + @cMes + @cDia  
	,      @cArcMDRS              = 'MDRS'              + @cMes + @cDia  
	,      @cArcMDMO              = 'MDMO'              + @cMes + @cDia  
	,      @cArcMDCO              = 'MDCO'              + @cMes + @cDia  
	,      @cArcMDNS              = 'MDNS'              + @cMes + @cDia  
	,      @cArcMDCV              = 'MDCV'              + @cMes + @cDia  
	,      @cArcMargen_Articulo84 = 'Margen_Articulo84' + @cMes + @cDia  

   --** Borra Respaldo del Dia si se ejecuta por 2 vez el cierre **--  
	SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDAC  
	IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDAC)  
		EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDCP  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDCP)  
		EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDCI  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDCI)  
		EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDVI  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDVI)  
		EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDDI  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDDI)  
		EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDRS  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDRS)  
		EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDMO  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDMO)  
		EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDCO  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDCO)  
      EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDNS  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDNS)  
      EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMDCV  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDCV)  
      EXECUTE (@cStrexec)  

   SELECT @cStrexec  = 'DROP TABLE dbo.' + @cArcMargen_Articulo84  
   IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMargen_Articulo84)  
      EXECUTE (@cStrexec)  
  

	--** Genera Respaldo del Dia **--  
	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMDAC + ' FROM MDAC'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDAC)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMDCP + ' FROM MDCP'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDCP)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMDCI + ' FROM MDCI'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDCI)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMDVI + ' FROM MDVI'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDVI)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMDDI + ' FROM MDDI'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDDI)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT rs.* INTO dbo.' + @cArcMDRS + ' FROM MDRS rs,mdac WHERE rsfecha> acfecproc'   

	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDRS)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMDMO + ' FROM MDMO'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDMO)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMDCO + ' FROM MDCO'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDCO)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMDNS + ' FROM VIEW_NOSERIE'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDNS)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMDCV + ' FROM MDCV'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMDCV)  
		EXECUTE (@cStrexec)  

	SELECT @cStrexec  = 'SELECT * INTO dbo.' + @cArcMargen_Articulo84 + ' FROM Margen_Articulo84'  
	IF NOT EXISTS(SELECT NAME FROM SYSOBJECTS WHERE TYPE = 'U' AND NAME = @cArcMargen_Articulo84)  
		EXECUTE (@cStrexec)  

	EXECUTE BacTraderSuda..SP_GENERA_RESPALDO_COBERTURAS  
  
     
	-- Respaldo tablas SOMA EN TABLAS HIS.  
	EXECUTE BacTraderSuda..SP_GENERA_RESPALDO_HIS  


	IF @@ERROR <> 0  
	BEGIN  
		SELECT -1, 'Error: En  Generar respaldo HIS.'  
		SET NOCOUNT OFF  
		RETURN  
	END  

	--- Recalculo de Cortes

	EXECUTE BacTraderSuda..SP_GENERA_CORTES  

	--- Respaldo de Garantias  

	EXECUTE Bacparamsuda..SP_RESPALDOS_GARANTIAS  

--	/*		( Se encontraba comentado, por que en ambiente de certificacion no funciona
/***	MIGRACION-CONVIVENCIA 2020				***
 ***	SE COMENTA POR DEJAR FUERA OPCIONES ***
	begin try
		EXECUTE dbo.SVC_GENERA_SET_PRECIOS  

		IF @@ERROR <> 0  
		BEGIN  
			SELECT 'SI', 'Fin de Día, ha finaliado. sin embargo el proceso de set de precios ha fallado. (Opciones)'  
			RETURN  
		END  

			end try
	begin catch
		insert into BAC_LOG
			(	logsistema, loguser, logfecha, loghora, logevento	)
		select	logsistema	= 'BTR'
			,	loguser		= 'bacuser'
			,	logfecha	= getdate()
			,	loghora		= convert(char(10), getdate(), 108)
			,	logevento	= 'Error en Fin de Día, set de precios no ha sido generado.'
		from	BAC_LOG
	end catch
 ***	MIGRACION-CONVIVENCIA 2020				***
 ***	SE COMENTA POR DEJAR FUERA OPCIONES ***/
--	/*		( Se encontraba comentado, por que en ambiente de certificacion no funciona
		
	-- 8800
	EXECUTE BacLineas.dbo.SP_RIEFIN_RESPALDO_TABLAS_LINEAS
	IF @@ERROR <> 0
	BEGIN
		SELECT 'SI', 'Fin de Día, ha finaliado. FALLO RESPALDO LINEAS'
		RETURN
	END
	-- 8800

	EXECUTE BacParamSuda.dbo.Sp_Copia_Valores_Monedas_IDAutomatico
	IF @@ERROR <> 0
	BEGIN
		SELECT 'SI', 'Fin de Día, ha finaliado. Fallo la copia de Valores para Inicio de Día Automatico.'
		RETURN
	END

	--================================================================
	-- Se agrega respaldo de cartera de Garantías
	--================================================================

	EXECUTE BDBOMESA.garantia.SP_RESPALDO_CARTERA_MOVIMIENTO_GAR
	IF @@ERROR <> 0
	BEGIN
		SELECT 'SI', 'Fin de Día, ha finaliado. Fallo la copia de Valores para Inicio de Día Automatico.'
		RETURN
	END

	--------> Limpieza de mdbl, para liberar papeles bloqueados
	EXECUTE BDBOMESA.garantia.sp_LiberarInstrumentos
	IF @@ERROR <> 0
	BEGIN
		SELECT 'SI', 'Fin de Día, ha finaliado. Fallo la limpieza de instrumentos bloqueados.'
		RETURN
	END


	SET NOCOUNT OFF  
	SELECT 'SI', 'Fin de Dia Realizado Sin Problemas.'  
END

GO
