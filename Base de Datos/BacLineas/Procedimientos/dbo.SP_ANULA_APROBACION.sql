USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULA_APROBACION]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ANULA_APROBACION]
   (   @csistema       CHAR(03)
   ,   @noperacion     NUMERIC(10)
   ,   @dFecPro        DATETIME
   ,   @nrutcli        NUMERIC(10)
   ,   @ncodcli        NUMERIC(05)
   ,   @cProducto      CHAR(03)
   ,   @cMonedaOp      CHAR(03)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Operador_Origen         CHAR(10)
   DECLARE @Operador_Autoriza       CHAR(10)
   DECLARE @Monto_Operacion         FLOAT
   DECLARE @Monto_Operador          FLOAT
   DECLARE @Monto_Autoriza          FLOAT
   DECLARE @dFecvctop               DATETIME
   DECLARE @nMontoLinSis            FLOAT
   DECLARE @iFound                  INTEGER
   DECLARE @nMatrizriesgo           NUMERIC(8,4)
   DECLARE @incodigo                NUMERIC(5)
   DECLARE @formapago               NUMERIC(3)
   DECLARE @nPlazoDesde             NUMERIC(10,0)
   DECLARE @nPlazoHasta	            NUMERIC(10,0)
   DECLARE @nDisponible             NUMERIC(19,4)
   DECLARE @codigo_sistema          CHAR(03)
   DECLARE @anula_producto          CHAR(05)
   DECLARE @codigo_producto         CHAR(05)

   SELECT @Operador_Origen	= operador_origen
   ,      @Operador_Autoriza	= operador_autoriza
   ,      @Monto_Operacion	= monto_operacion
   ,      @Monto_Operador	= monto_operador
   ,      @Monto_Autoriza	= monto_autoriza
   FROM   DETALLE_APROBACIONES
   WHERE  id_sistema 		= @csistema
   AND	  numero_operacion 	= @noperacion
   AND	  fecha_operacion	= @dFecPro

   SELECT @Codigo_Sistema       = id_sistema
   FROM	  BacParamSuda.dbo.PRODUCTO
   WHERE  codigo_producto       = @cProducto

   SELECT @dFecvctop		= FechaVencimiento
   ,	  @codigo_producto	= codigo_producto
   FROM   LIMITE_TRANSACCION
   WHERE  id_sistema 		= @Codigo_Sistema
   AND	  NumeroOperacion 	= @noperacion
   AND	  FechaOperacion	= @dFecPro

   SET @anula_producto = @codigo_producto

   IF @cSistema = 'BTR' AND @cProducto = 'CPX' 
      SET @anula_producto = '03'

   IF @cSistema = 'PCS'
   BEGIN
      SET @anula_producto = (SELECT DISTINCT Codigo_Grupo FROM GRUPO_PRODUCTO WHERE id_sistema = 'PCS')
   END
   IF @cSistema = 'BFW' AND @cProducto IN ('ST','SM')
   BEGIN
      SET @cSistema       = 'PCS'
      SET @anula_producto = (SELECT DISTINCT Codigo_Grupo FROM GRUPO_PRODUCTO WHERE id_sistema = 'PCS')
   END

   UPDATE MATRIZ_ATRIBUCION_INSTRUMENTO
   SET	  Acumulado_Diario   = Acumulado_Diario - @Monto_Operador
   WHERE  Usuario            = @Operador_Origen
   AND	  Plazo_Desde       <= DATEDIFF(DAY, @dFecPro, @dFecvctop)
   AND	  Plazo_Hasta        > DATEDIFF(DAY, @dFecPro, @dFecvctop)
   AND	  Id_Sistema         = @csistema
   AND	  codigo_producto    = @anula_producto

   UPDATE MATRIZ_ATRIBUCION_INSTRUMENTO
   SET	  Acumulado_Diario   = Acumulado_Diario - @Monto_Autoriza
   WHERE  Usuario            = @Operador_Autoriza
   AND	  Plazo_Desde 	    <= DATEDIFF(DAY, @dFecPro, @dFecvctop)
   AND	  Plazo_Hasta  	     > DATEDIFF(DAY, @dFecPro, @dFecvctop)
   AND	  Id_Sistema	     = @csistema
   AND	  codigo_producto    = @anula_producto

   SET @nMontoLinSis = @Monto_Operador

   IF @cSistema  = 'BFW' AND @cproducto NOT IN ('SM','ST')
   BEGIN
      SET    @iFound         = 0
      SELECT @iFound         = 1,
             @nMatrizriesgo  = porcentaje
      FROM   MATRIZ_RIESGO_CLIENTE
      WHERE  rut_cliente     = @nRutcli
      AND    codigo_cliente  = @nCodcli
      AND    codigo_producto = @cProducto
      AND    moneda    	     = @cMonedaOp
      AND    diasdesde 	    <= DATEDIFF(DAY, @dFecPro, @dFecvctop)
      AND    diashasta      >= DATEDIFF(DAY, @dFecPro, @dFecvctop)

      IF @iFound = 0
      BEGIN
         SET    @iFound         = 0
         SELECT @iFound         = 1,
                @nMatrizriesgo  = porcentaje
         FROM 	MATRIZ_RIESGO
         WHERE 	codigo_producto	= @cProducto
         AND    moneda    	= @cMonedaOp
         AND    diasdesde       <= DATEDIFF(DAY, @dFecPro, @dFecvctop)
         AND    diashasta       >= DATEDIFF(DAY, @dFecPro, @dFecvctop)
      END

      IF @nMatrizriesgo > 0 
      BEGIN
         SET @nMontoLinSis 	= round(@Monto_Operacion * (@nMatrizriesgo/100),0)
      END
   END

   IF @Codigo_Sistema  = 'PCC'
   BEGIN
      SET    @iFound         = 0
      SELECT @iFound         = 1,
             @nMatrizriesgo  = porcentaje
      FROM   MATRIZ_RIESGO_CLIENTE
      WHERE  rut_cliente     = @nRutcli
      AND    codigo_cliente  = @nCodcli
      AND    codigo_producto = @cProducto
      AND    moneda    	     = @cMonedaOp
      AND    diasdesde      <= DATEDIFF(DAY, @dFecPro, @dFecvctop)
      AND    diashasta      >= DATEDIFF(DAY, @dFecPro, @dFecvctop)

      IF @iFound = 0
      BEGIN
         SET 	@iFound         = 0
         SELECT @iFound         = 1,
                @nMatrizriesgo  = porcentaje
         FROM 	MATRIZ_RIESGO_SWAP	
         WHERE 	codigo_producto	= @cProducto
         AND    moneda    	= @cMonedaOp
         AND    diasdesde      <= DATEDIFF(DAY, @dFecPro, @dFecvctop)
         AND    diashasta      >= DATEDIFF(DAY, @dFecPro, @dFecvctop)
      END

      IF @nMatrizriesgo > 0 
      BEGIN
         SET @nMontoLinSis 	= round(@Monto_Operacion * (@nMatrizriesgo/100),0)
      END
   END

   IF @cProducto = 'ST' 
      SET @cProducto = '1'

   IF @cProducto = 'SM' 
      SET @cProducto = '2'

   UPDATE LINEA_SISTEMA
   SET 	  totalocupado 	  = totalocupado    - @nMontoLinSis,
          totaldisponible = totaldisponible + @nMontoLinSis
   WHERE  rut_cliente 	  = @nRutcli
   AND    codigo_cliente  = @nCodcli
   AND    id_sistema 	  = @Codigo_Sistema

   -- Cambio el 01/06/2004			
   SET @incodigo  = 0
   SET @formapago = 0
   SET @cMonedaOp = 0

   SELECT @nPlazoDesde     = PlazoDesde,
          @nPlazoHasta     = PlazoHasta,
          @ndisponible     = Totaldisponible
   FROM   LINEA_PRODUCTO_POR_PLAZO
   WHERE  rut_cliente	   = @nRutcli				
   AND    codigo_cliente   = @nCodcli				
   AND    id_sistema	   = @Codigo_Sistema			
   AND    codigo_producto  = @cProducto				
   AND    plazodesde 	  <= DATEDIFF(DAY, @dFecPro, @dFecvctop)	
   AND    plazohasta  	   > DATEDIFF(DAY, @dFecPro, @dFecvctop)

   UPDATE LINEA_PRODUCTO_POR_PLAZO
   SET    totalocupado 	   = totalocupado    - @nMontoLinSis,
          totaldisponible  = totaldisponible + @nMontoLinSis,
          totalexceso      = totalexceso     - CASE WHEN totalexceso = 0 THEN 0 ELSE @nMontoLinSis END
   WHERE  rut_cliente	   = @nRutcli				
   AND    codigo_cliente   = @nCodcli				
   AND    id_sistema	   = @Codigo_Sistema			
   AND    codigo_producto  = @cProducto				
   AND    plazodesde 	  <= DATEDIFF(DAY, @dFecPro, @dFecvctop)	
   AND    plazohasta  	   > DATEDIFF(DAY, @dFecPro, @dFecvctop)


   DELETE APROBACION_OPERACIONES
   WHERE  id_sistema 	   = @Codigo_Sistema
   AND    numerooperacion  = @noperacion
   AND	  fechaOperacion   = @dfecpro

   UPDATE DETALLE_APROBACIONES
   SET 	  estado           = 'E'
   WHERE  id_sistema 	   = @csistema
   AND	  numero_Operacion = @noperacion
   AND	  fecha_Operacion  = @dFecPro

END
GO
