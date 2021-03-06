USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_LINPRODUCTO_PLAZO]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VALIDA_LINPRODUCTO_PLAZO]  
   (   @RutCliente      NUMERIC(12)  
   ,   @CodCliente      NUMERIC(5)  
   ,   @Id_Sistema      CHAR(3)  
   ,   @Cod_Producto    VARCHAR(5)  
   ,   @CodInstrumento  NUMERIC(5)  
   ,   @iPlazo          NUMERIC(9)  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   CREATE TABLE #tmp_paso_lin_producto  
   (   rut_cliente        NUMERIC(9)  
   ,   codigo_cliente     NUMERIC(9)  
   ,   id_sistema         CHAR(3)  
   ,   codigo_producto    CHAR(5)  
   ,   incodigo           NUMERIC(5,0)  
   ,   mncodmon           NUMERIC(5,0)  
   ,   codigo             NUMERIC(3,0)  
   ,   plazodesde         NUMERIC(5,0)  
   ,   plazohasta         NUMERIC(5,0)  
   ,   porcentaje         NUMERIC(8,4)  
   ,   totalasignado      NUMERIC(19,4)  
   ,   totalocupado       NUMERIC(19,4)  
   ,   totaldisponible    NUMERIC(19,4)  
   ,   TotalExceso        NUMERIC(19,4)  
   ,   TotalTraspaso      NUMERIC(19,4)  
   ,   TotalRecibido      NUMERIC(19,4)  
   )  
  
   DECLARE @iFound         INTEGER  
   DECLARE @nRegistros     INTEGER  
   DECLARE @iLineas        INTEGER  
  
   DECLARE @iPlazoDesde    NUMERIC(9)  
       SET @iPlazoDesde    = 0  
  
   DECLARE @iPlazoHasta    NUMERIC(9)  
       SET @iPlazoHasta    = @iPlazo  
  
   -- PRD8800
   DECLARE @Id_SistemaNetting   CHAR(03)          
        ,  @MetodoLCR           NUMERIC(05)

   DECLARE @RutComder		NUMERIC(9)	-- COMDER


   -- Detectar si el sistema @Id_Sistema
   -- es DRV o NO DRV
   declare @SistemaEsDRV numeric(1)
   select  @SistemaEsDRV = case when Id_Sistema <> Id_Grupo then 1 else 0 end from  TBL_AGRPROD where Id_Sistema = @Id_Sistema
   
   if @SistemaEsDRV = 0 
       SELECT  @MetodoLCR = 1
   else   
		SELECT  @MetodoLCR  = BacLineas.dbo.FN_RIEFIN_METODO_LCR( @RutCliente, @CodCliente, @RutCliente, @CodCliente )

   SELECT   @Id_SistemaNetting =  CASE	WHEN @MetodoLCR NOT IN (1,4) THEN Id_Grupo
										ELSE Id_Sistema  
									END
           -- MAP
		,	@Cod_Producto		= CASE	WHEN @MetodoLCR NOT IN (1,4) THEN Id_Grupo
										ELSE @Cod_Producto  
		 	             			END
   FROM		TBL_AGRPROD
   WHERE	Id_Sistema  = @Id_Sistema
   -- PRD8800

	-- COMDER - VALIDACION PRD19708 
	IF @Cod_Producto = 'DRV' and @Id_Sistema <> 'DRV'
		SET @Id_Sistema = 'DRV'
	-- COMDER - VALIDACION PRD19708

   -->     1.0 Lee cada uno de los registros para el Cliente, producto e instrumento  
   DELETE FROM #tmp_paso_lin_producto  
  
   INSERT INTO #tmp_paso_lin_producto  
   SELECT *   
     FROM BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
    WHERE Rut_Cliente     = @RutCliente  
      AND Codigo_Cliente  = @CodCliente  
      AND Id_Sistema      = @Id_Sistema  
      AND Codigo_Producto = @Cod_Producto
      AND incodigo        = @CodInstrumento  


  /*******************  COMDER *****************************/	
  -- PRD21119-Consumo Línea Derivados COMDER
	SET @RutComder = 0
	SELECT @RutComder = acRutComder FROM bacfwdsuda.dbo.MFAC with(nolock)
	IF @RutCliente = @RutComder AND @CodCliente = 1 
	BEGIN
		RETURN
	END
  /********************************************************/	
  
   -->     2.0 Determina la cantidad de registros   
   SET @iLineas = ( SELECT COUNT(1) FROM #tmp_paso_lin_producto )  
  
   IF @iLineas = 0  
   BEGIN  
		  SET @iPlazoHasta = CASE WHEN @Id_SistemaNetting  = 'DRV' THEN 99999  ELSE   @iPlazoHasta END-- PRD8800
		  INSERT INTO BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
		  SELECT @RutCliente, @CodCliente, @Id_Sistema, @Cod_Producto, @CodInstrumento, 0, 0,  
				 @iPlazoDesde, @iPlazoHasta, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0  
      RETURN  
   END  
  
  
   SET @iLineas = ( SELECT COUNT(1) FROM #tmp_paso_lin_producto WHERE @iPlazo BETWEEN plazodesde AND Plazohasta )  
  
   IF @iLineas = 1  
   BEGIN  
      RETURN  
   END  
  
  
   IF @iLineas = 0  AND @Id_SistemaNetting <> 'DRV'
   BEGIN  
      SET @iPlazoDesde = ( SELECT MAX( plazohasta ) FROM #tmp_paso_lin_producto ) + 1  
  
      IF @iPlazo >= @iPlazoDesde  
      BEGIN  
         INSERT INTO BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
         SELECT @RutCliente, @CodCliente, @Id_Sistema, @Cod_Producto, @CodInstrumento, 0, 0,  
                @iPlazoDesde, @iPlazo , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 
         RETURN  
      END  
  
      IF @iPlazo < @iPlazoDesde  
      BEGIN  
         SET @iPlazoHasta = ( SELECT MAX(plazodesde) FROM #tmp_paso_lin_producto ) -1  
         SET @iPlazoDesde = ( SELECT MAX(plazohasta) FROM #tmp_paso_lin_producto WHERE plazohasta < @iPlazo )+1  
  
         IF @iPlazoDesde IS NULL  
         BEGIN  
            SET @iPlazoDesde = @iPlazo  
            SET @iPlazoHasta = (SELECT MIN(plazodesde) - 1  FROM #tmp_paso_lin_producto)  
         END  
              
         IF @iPlazo < @iPlazoHasta  
         BEGIN  
            INSERT INTO BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
            SELECT @RutCliente, @CodCliente, @Id_Sistema, @Cod_Producto, @CodInstrumento, 0, 0,  
                   @iPlazoDesde, @iPlazoHasta , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0  
         END  
         RETURN  
      END  
   END  
  
  
   IF @iLineas > 1  
   BEGIN  
      SELECT rut_cliente, codigo_cliente, id_sistema, codigo_producto, incodigo, mncodmon, codigo  
         ,   min( plazodesde )       as plazodesde  
         ,   max( plazohasta )       as plazohasta  
         ,   max( porcentaje )       as porcentaje  
         ,   sum( totalasignado )    as totalasignado  
         ,   sum( totalocupado )     as totalocupado  
         ,   sum( totaldisponible )  as totaldisponible  
         ,   sum( TotalExceso )      as TotalExceso  
         ,   sum( TotalTraspaso )    as TotalTraspaso  
         ,   sum( TotalRecibido )    as TotalRecibido  
      INTO   #tmp_agrupa_reg  
      FROM   #tmp_paso_lin_producto   
      WHERE  @iPlazo BETWEEN plazodesde AND Plazohasta  
      GROUP BY rut_cliente, codigo_cliente, id_sistema, codigo_producto, incodigo, mncodmon, codigo  
  
      UPDATE #tmp_agrupa_reg  
         SET totaldisponible = totalasignado  
  
      UPDATE #tmp_agrupa_reg  
         SET totalocupado    = CASE WHEN totaldisponible > TotalExceso THEN totalocupado + TotalExceso ELSE totalocupado END  
         ,   TotalExceso     = CASE WHEN totaldisponible > TotalExceso THEN 0                          ELSE TotalExceso  END  
  
      UPDATE #tmp_agrupa_reg  
         SET totaldisponible = totaldisponible - totalocupado  
  
      DELETE FROM #tmp_paso_lin_producto  
            WHERE @iPlazo BETWEEN plazodesde AND Plazohasta  
  
      INSERT INTO #tmp_paso_lin_producto  
      SELECT * FROM #tmp_agrupa_reg  
  
      DELETE FROM BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
            WHERE Rut_Cliente     = @RutCliente  
            AND   Codigo_Cliente  = @CodCliente  
            AND   Id_Sistema      = @Id_Sistema  
            AND   Codigo_Producto = @Cod_Producto  
            AND   incodigo        = @CodInstrumento  
  
      INSERT INTO BacLineas.dbo.LINEA_PRODUCTO_POR_PLAZO  
      SELECT * FROM #tmp_paso_lin_producto
  
  END  
END	
GO
