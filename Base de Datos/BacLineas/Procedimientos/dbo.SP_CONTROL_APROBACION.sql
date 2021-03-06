USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_APROBACION]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_APROBACION]
   (   @cUsuario   VARCHAR(15)  
   ,   @cSistema   CHAR(3)  
   ,   @cNumero    NUMERIC(9)  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @FechaProc DATETIME  
       SET @FechaProc = (SELECT acfecproc FROM BacTraderSuda..MDAC with(nolock) )  
  
   DECLARE @cEstado   CHAR(10)  
   SELECT  @cEstado   = ''  
  
   CREATE TABLE #ESTADO_APROBACION  
   (   Estado     CHAR(10)  
   ,   Mensaje    VARCHAR(100) NULL  
   )  
  
   CREATE TABLE #ERRORES  
   (   Mensaje    VARCHAR(255)   
   ,   Monto      NUMERIC(21,4)  
   )  
  
   DECLARE @sLineas   CHAR(1)  
   ,       @sLimites  CHAR(1)  
   ,       @sTasas    CHAR(1)  
   ,       @sGrupos   CHAR(1)  
   ,       @Trheshold CHAR(1)  
   ,       @sPrecios  CHAR(1) --- Nuevo para Control de Precios y Tasas  
   ,	   @sBloqueos CHAR(1)	--- PRD-6066	
    -- +++cvegasan 2017.09.11 Control IDD autorización automatica solamente para líneas
	IF @cUsuario= 'AUTOMATICA'
	SELECT @sLineas = 'S'
		,@sLimites  = 'N'
		,@sTasas    = 'N'
		,@sGrupos   = 'N'
		,@sPrecios  = 'N'
		,@Trheshold = 'N'
		,@sBloqueos = 'N'
	ELSE
	-- ---cvegasan 2017.09.11 Control IDD autorización automatica solamente para líneas
   SELECT  @sLineas   = CASE WHEN aprueba_linea  = 0 THEN 'S' ELSE 'N' END  
   ,       @sLimites  = CASE WHEN aprueba_limite = 0 THEN 'S' ELSE 'N' END  
   ,       @sTasas    = CASE WHEN aprueba_tasa   = 0 THEN 'S' ELSE 'N' END  
   ,       @sGrupos   = CASE WHEN aprueba_glb    = 0 THEN 'S' ELSE 'N' END  
   ,       @sPrecios  = CASE WHEN aprueba_limprecio = 0 THEN 'S' ELSE 'N' END  
   ,       @Trheshold = CASE WHEN aprueba_limite = 0 THEN 'S' ELSE 'N' END  
   ,	   @sBloqueos = CASE WHEN aprueba_bloqclt = 0 THEN 'S' ELSE 'N' END		--- PRD-6066
   FROM    MATRIZ_ATRIBUCION With (NoLock)  
   WHERE   usuario    = @cUsuario  
  
   DELETE FROM #ERRORES  
  
   INSERT INTO #ERRORES EXECUTE Sp_Limites_Tasas @cSistema , @cNumero  
   IF NOT EXISTS(SELECT 1 FROM #ERRORES)  
   BEGIN  
      SET @sTasas = 'S'  
   END  
  
   DELETE #ERRORES  
   INSERT INTO #ERRORES EXECUTE Sp_Lineas_consolidadas @cSistema , @cNumero  
  
   IF NOT EXISTS(SELECT 1 FROM #ERRORES)  
   BEGIN  
      SET @sGrupos = 'S'  
   END  
  
   DELETE #ERRORES  
   INSERT INTO #ERRORES EXECUTE Sp_Lineas_Error @cSistema , @cNumero  
   IF NOT EXISTS(SELECT 1 FROM #ERRORES)  
   BEGIN  
      SET @sLineas = 'S'  
   END  
  
	/* Bloqueos de Clientes PRD-6066  */
	DELETE #ERRORES
	INSERT INTO #ERRORES EXECUTE SP_LIMITES_BLOQ_CLTES @cSistema, @cNumero
	IF NOT EXISTS(SELECT 1 FROM #ERRORES)
	BEGIN	
		SET @sBloqueos = 'S'
	END
	/* fin Bloqueos de Clientes */
 
   IF @sLimites = 'S'  
   BEGIN  
  
      INSERT INTO #ESTADO_APROBACION  
      EXECUTE Sp_Limites_ReChequear @cSistema , @cNumero , @cUsuario , 'M', 1

      SELECT @cEstado = Estado FROM #ESTADO_APROBACION  
  
      IF @cEstado = 'NO'  
      BEGIN  
         SET @sLimites  = 'N'  
         SET @Trheshold = 'N'  
      END  
   END  
  

  EXECUTE SP_LINEAS_AUTORIZA @FechaProc , @cSistema , @cNumero , @cUsuario , @sLimites , @sLineas , @sTasas , @sGrupos, @sPrecios, @sBloqueos
END  
GO
