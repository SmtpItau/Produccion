USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ANULA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_ANULA]
   (	@dFecPro     DATETIME
   ,	@cSistema    CHAR(03)
   ,	@nNumoper    NUMERIC(10,0) 
   )
AS
BEGIN
-- IMPORTANTE Este SP no debe retornar nunca nada, tomar en cuenta otros sistemas que no son BAC (SAO)
   SET NOCOUNT ON

  DECLARE @iFoundLimite   INTEGER
       SET @iFoundLimite   = 1

   IF @cSistema = 'BFW'
   BEGIN
     IF EXISTS( SELECT 1 FROM BacFwdSuda.dbo.MFCA WHERE cacodpos1 = 1 and canumoper = @nNumoper and var_moneda2 > 0 )
      BEGIN
	SET @iFoundLimite = -1
      END 
  
   END

   -- SELECT @iFoundLimite , 10967 Para no confundir dataset para SAO 

   DECLARE @Contador  INTEGER
   DECLARE @sw        CHAR(1)

   DECLARE @ctranssaccion  	   CHAR(15)
   DECLARE @ctipo_detalle  	   CHAR(1)
   DECLARE @cactualizo_linea 	   CHAR(1)
   DECLARE @nmontotransaccion 	   NUMERIC(19,4)
   DECLARE @ctipo_movimiento 	   CHAR(1)
   DECLARE @nrutcli  		   NUMERIC(09,0)
   DECLARE @ncodigo  		   NUMERIC(09,0)
   DECLARE @nplazodesde  	   NUMERIC(09,0)
   DECLARE @nplazohasta  	   NUMERIC(09,0)
   DECLARE @csistematras  	   CHAR(03)
   DECLARE @nmonto   		   NUMERIC(19,4)
   DECLARE @dfecvctop  		   DATETIME
   DECLARE @ccontrolaplazo  	   CHAR(01)
   DECLARE @nRutcasamatriz  	   NUMERIC(09,0)
   DECLARE @nCodigocasamatriz 	   NUMERIC(09,0)
   DECLARE @cProducto  		   CHAR(05)
   DECLARE @nMontoSpo  		   NUMERIC(19,4)
   DECLARE @nMontoFwd  		   NUMERIC(19,4)
   DECLARE @nPlazo   		   NUMERIC(10)
   DECLARE @nCodigo_pais	   NUMERIC(05)
   DECLARE @instrumento 	   NUMERIC(03)
   DECLARE @moneda  		   NUMERIC(05)
   DECLARE @forma_pago 		   NUMERIC(03)
   DECLARE @Codigo_Producto	   CHAR(05)
   DECLARE @Grupo_Emisor	   CHAR(05)
   DECLARE @cOperador 		   CHAR(10)
   DECLARE @nMonto_Operador	   NUMERIC(19,4) 
   DECLARE @cOperador_Autoriza	   CHAR(10)
   DECLARE @nMonto_Autoriza	   NUMERIC(19,4)
   DECLARE @Codigo_Producto_Aux    CHAR(05)
   DECLARE @nMtoGrp 		   NUMERIC(19,4)
   DECLARE @nCorrela		   NUMERIC(4)
   DECLARE @firma1 		   CHAR(15)
   DECLARE @Codigo_Producto_Icap   CHAR(05)
   DECLARE @Imputo                 CHAR(01)
   DECLARE @MetodoLCR		   NUMERIC(5)	-- COMDER
   DECLARE @cProductoIDD	   CHAR(10) --+++CONTROL IDD

   -- MAP 20080520 Anulación de una Cotización
   if  @cSistema = 'PCS' 
   Begin
        select @Imputo = 'N'
   	select @Imputo = 'S' from LINEA_TRANSACCION_DETALLE
               where NumeroOperacion = @nNumoper  and Id_sistema = @cSistema 
        if @Imputo = 'N' return  -- MAP 20080520 Sale si no imputó
   end

   SELECT  Linea_Transsaccion,
           NumeroCorre_Detalle,
           Tipo_Detalle,
           Actualizo_Linea,
           MontoTransaccion,
           Tipo_Movimiento,
           Rut_Cliente,
           Codigo_Cliente,
           PlazoDesde,
           PlazoHasta,
           instrumento,
           moneda,
           forma_pago,
           Codigo_Producto,
           Grupo_Emisor,
           NumeroCorrelativo,
           Puntero = Identity(Int)
   INTO    #TMP_LINEA_TRANSACCION_DETALLE
   FROM    LINEA_TRANSACCION_DETALLE 
   WHERE   Id_Sistema       = @cSistema
   AND     NumeroOperacion  = @nNumoper

   CREATE INDEX #ixcvt_TMP_LINEA_TRANSACCION_DETALLE ON #TMP_LINEA_TRANSACCION_DETALLE (Puntero)

   DECLARE @iRegistros      INTEGER
   DECLARE @iPuntero        INTEGER

   SELECT  @iRegistros      = MAX(Puntero)
   ,       @iPuntero        = MIN(Puntero)
   FROM    #TMP_LINEA_TRANSACCION_DETALLE

   SET @Codigo_Producto_Aux = ''    -- VG      

   WHILE @iRegistros >= @iPuntero
   BEGIN
      SELECT @cTranssaccion     = Linea_Transsaccion,
             @Contador          = NumeroCorre_Detalle,
             @cTipo_Detalle     = Tipo_Detalle,
             @cActualizo_Linea  = Actualizo_Linea,
             @nMontoTransaccion = MontoTransaccion,
             @cTipo_Movimiento  = Tipo_Movimiento,
             @nRutcli           = Rut_Cliente,
             @nCodigo           = Codigo_Cliente,
             @nPlazoDesde       = PlazoDesde,
             @nPlazoHasta       = PlazoHasta,
             @instrumento       = instrumento,
             @moneda            = moneda,
             @forma_pago        = forma_pago,
             @Codigo_Producto   = Codigo_Producto,
             @Grupo_Emisor      = Grupo_Emisor,
             @nCorrela          = NumeroCorrelativo
      FROM   #TMP_LINEA_TRANSACCION_DETALLE
      WHERE  Puntero            = @iPuntero

	SET @cProductoIDD = @Codigo_Producto --+++CONTROL IDD

      IF @cSistema = 'BTR' and @instrumento = 0
         SET @instrumento = (SELECT TOP 1 mocodigo FROM BactraderSuda.dbo.MDMO 
                                            WHERE monumdocu = @nNumoper
                                              AND mocorrela = @nCorrela)

      IF @Codigo_Producto = 'CI'
         SET @instrumento = 0


      SET @iPuntero = @iPuntero + 1

      /*****************************************************/
      /* Solo para Codigo producto ICAP*/
      SELECT @Codigo_Producto_Icap = incodigo 
      FROM   LIMITE_TRANSACCION  
      WHERE  Id_Sistema            = 'BTR' 
      AND    Codigo_Producto       = '06' 
      AND    NumeroOperacion       = @nNumoper 
      AND    InCodigo              = 993

      IF @Codigo_Producto_Icap = 993
         SET @Codigo_Producto_Aux = 'ICAP'
      /*****************************************************/

      IF @cTranssaccion = 'LINGEN' and @Codigo_Producto in('ICOL','ICAP')
      BEGIN
         SET @Codigo_Producto_Aux = @Codigo_Producto
      END

		--+++CONTROL IDD, jcamposd
		IF @cTranssaccion = 'LINIDD' and @Codigo_Producto in('ICOL','ICAP')  
		BEGIN  
			SET @Codigo_Producto_Aux = @Codigo_Producto  
		END 
		-----CONTROL IDD, jcamposd


      IF @cTipo_Movimiento = 'S'
         SET @nMontoTransaccion = @nMontoTransaccion * (-1)

      -- COMDER: Consultar metodologia
      SELECT @MetodoLCR = ISNULL(ClRecMtdCod,0)
      FROM bacparamsuda.dbo.cliente
      WHERE ClRut = @nRutcli AND ClCodigo = @nCodigo

      IF @cTipo_Detalle = 'L' AND @cActualizo_Linea = 'S'
      BEGIN
      	IF @MetodoLCR <> 6 -- 6: metodologia COMDER
      	BEGIN
         IF @cTranssaccion = 'LINGEN'
         BEGIN
            UPDATE LINEA_GENERAL
            SET    totalocupado   = totalocupado  + @nMontoTransaccion
            WHERE  rut_cliente    = @nRutcli
            AND    codigo_cliente = @nCodigo
         END

         IF @cTranssaccion = 'LINSIS'
         BEGIN
            UPDATE LINEA_SISTEMA
            SET    totalocupado    = totalocupado  + @nMontoTransaccion
            WHERE  rut_cliente 	   = @nRutcli	
            AND    codigo_cliente  = @nCodigo	
            AND    id_sistema 	   = @cSistema
         END

         IF @cTranssaccion = 'LINPZO'
         BEGIN
            UPDATE LINEA_PRODUCTO_POR_PLAZO
            SET    totalocupado      = totalocupado  + @nMontoTransaccion
            WHERE  rut_cliente 	     = @nRutcli		
            AND    codigo_cliente    = @nCodigo 
            AND    id_sistema 	     = @cSistema		
            AND    Codigo_Producto   = @Codigo_Producto	
            AND    incodigo          = CASE WHEN Codigo_Producto = 'ICOL' THEN 992 ELSE
                                          case when @cSistema = 'BEX' then incodigo  -- 10967 Para eliminar el Filtro, instrumento biene en cero
                                                                      else @instrumento END END
      -->   AND    plazodesde       <= @nPlazoDesde
            AND    @nPlazoDesde BETWEEN PlazoDesde AND PlazoHasta
         END
        END -- Fin 6: metodologia COMDER

         IF @cSistema = 'BTR'
         BEGIN
            IF @Codigo_producto = 'VP'
            BEGIN
               SET    @nMtoGrp = 0
               SELECT @nMtoGrp = monominal 
               FROM   LINEA_TRANSACCION_DETALLE a
                      INNER JOIN VIEW_MDMO b ON a.NumeroOperacion = b.moNumoper AND a.NumeroCorrelativo = b.moCorrela AND a.Codigo_Producto = b.moTipoper
               WHERE  a.Id_Sistema         = @cSistema
               AND    a.NumeroOperacion    = @nNumoper							
               AND    a.NumeroCorrelativo  = @nCorrela
               AND    b.moTipoper          = 'VP'

               UPDATE POSICION_GRUPO
               SET    totalocupado                           = totalocupado  + @nMtoGrp
               FROM   LINEA_TRANSACCION_DETALLE 
               WHERE  Id_Sistema                             = @cSistema
               AND    NumeroOperacion                     = @nNumoper							
               AND    NumeroCorrelativo      = @nCorrela
               AND    LINEA_TRANSACCION_DETALLE.Grupo_Emisor = POSICION_GRUPO.Codigo_Grupo
            END

            IF @Codigo_producto = 'CP'
            BEGIN
               SET             @nMtoGrp   = 0
               SELECT DISTINCT @nMtoGrp   = cpnominal 
               FROM   LINEA_TRANSACCION_DETALLE a
               ,      VIEW_MDCP                 b
               WHERE  a.Id_Sistema        = @cSistema
               AND    a.NumeroOperacion   = @nNumoper							
               AND    a.NumeroCorrelativo = @nCorrela
               AND    a.NumeroOperacion   = b.cpNumdocu
               AND    a.NumeroCorrelativo = b.cpCorrela

               UPDATE POSICION_GRUPO
               SET    totalocupado                            = totalocupado  - @nMtoGrp
               FROM   LINEA_TRANSACCION_DETALLE 
               WHERE  Id_Sistema                              = @cSistema
               AND    NumeroOperacion                         = @nNumoper
               AND    NumeroCorrelativo                       = @nCorrela
               AND    LINEA_TRANSACCION_DETALLE.Grupo_Emisor  = POSICION_GRUPO.Codigo_Grupo
            END

         END

         IF @cSistema = 'BEX' 
         BEGIN
            IF @Codigo_producto = 'VPX' 
            BEGIN
               SET    @nMtoGrp = 0
               SELECT @nMtoGrp = monominal 
               FROM   LINEA_TRANSACCION_DETALLE	a
               ,      BacBonosExtSuda..TEXT_MVT_DRI	b
               WHERE  a.Id_Sistema         = @cSistema
               AND    a.NumeroOperacion    = @nNumoper							
               AND    a.NumeroCorrelativo  = @nCorrela
               AND    a.NumeroOperacion    = b.moNumoper
               AND    a.NumeroCorrelativo  = b.moCorrelativo
               AND    a.Codigo_Producto    = b.moTipoper
               AND    b.moTipoper          = 'VP'

               UPDATE POSICION_GRUPO
               SET    totalocupado                           = totalocupado  + @nMtoGrp
               FROM   LINEA_TRANSACCION_DETALLE 
               WHERE  Id_Sistema                             = @cSistema
               AND    NumeroOperacion                        = @nNumoper	
               AND    NumeroCorrelativo                      = @nCorrela
               AND    LINEA_TRANSACCION_DETALLE.Grupo_Emisor = POSICION_GRUPO.Codigo_Grupo
            END

            IF @Codigo_producto = 'CPX' 
            BEGIN
               SELECT @nMtoGrp            = 0
               SELECT @nMtoGrp            = cpnominal 
               FROM   LINEA_TRANSACCION_DETALLE a
               ,      BacBonosExtSuda..TEXT_CTR_INV b
               WHERE  a.Id_Sistema        = @cSistema
               AND    a.NumeroOperacion   = @nNumoper							
               AND    a.NumeroCorrelativo = @nCorrela
               AND    a.NumeroOperacion   = b.cpNumdocu
               AND    a.NumeroCorrelativo = b.cpCorrelativo

               UPDATE POSICION_GRUPO
               SET    totalocupado                           = totalocupado - @nMtoGrp
               FROM   LINEA_TRANSACCION_DETALLE 
               WHERE  Id_Sistema                             = @cSistema
               AND    NumeroOperacion                        = @nNumoper
               AND    NumeroCorrelativo                      = @nCorrela
               AND    LINEA_TRANSACCION_DETALLE.Grupo_Emisor = POSICION_GRUPO.Codigo_Grupo
            END
         END
      END
   END

   DELETE LINEA_TRANSACCION_DETALLE
   WHERE  Id_Sistema  	  = @cSistema	
   AND    NumeroOperacion = @nNumoper

   SELECT @cOperador 		= Operador_Origen
   ,      @nMonto_Operador	= Monto_Operador
   ,      @cOperador_Autoriza	= Operador_Autoriza
   ,      @nMonto_Autoriza	= Monto_Operacion
   ,      @firma1               = Firma1     
   FROM   DETALLE_APROBACIONES 
   WHERE Id_Sistema         = case when @cSistema = 'BEX' then 'BTR' else @cSistema  end -- 15 Oct. 2009 
   -- MAP 21 Oct. 2011 va a quedar la crema cuando grabe en los dos sistemas
   -- no se corregira nada en este ambito por haber otro tema relacionado en 
   -- certificación: Oct. 2011
   AND   Numero_Operacion      = @nNumoper

   IF LEN(@Codigo_Producto_Aux) = 0  /* SOLO PARA OPERACIONES DISTINTAS A ICOL-ICAP*/
   BEGIN	
      IF @cSistema = 'BCC' 
      BEGIN --GLCF
         SELECT @Codigo_Producto = Codigo_Producto 
         FROM   BacLineas..LIMITE_TRANSACCION 
         WHERE  Id_Sistema       = 'BCC'
         AND    NumeroOperacion  = @nNumoper
      END

      SET @Codigo_Producto_Aux = @Codigo_Producto

   END

   SELECT @Codigo_Producto = Codigo_Grupo
   FROM   GRUPO_PRODUCTO
   WHERE  Codigo_Producto  = @Codigo_Producto_Aux
   AND	  Id_Sistema       = @cSistema
 
   IF @cSistema = 'PCS' 
   BEGIN
      SET @Codigo_Producto = @Codigo_Producto --> '02'
   END

   IF @cSistema = 'BEX' 
   BEGIN 
      SET @Codigo_Producto = '03'
   END

   IF @iFoundLimite = -1
      SET @nMonto_Autoriza = 0

   IF NOT EXISTS(SELECT 1 FROM LINEA_AUTORIZACION WHERE Id_Sistema  = @cSistema AND NumeroOperacion= @nNumoper AND FechaAutorizo = @dFecPro And codigo_excepcion = 'R')  
   BEGIN

      -- 10967 Se corrige la des-imputacion de límites
      IF @cSistema = 'BEX'
      BEGIN
         SET @Codigo_Producto = '03'
      END

      IF @cSistema = 'PCS'
      BEGIN 
         SET @Codigo_Producto = (SELECT Max( Codigo_Grupo ) FROM GRUPO_PRODUCTO with (nolock) WHERE Id_Sistema = @cSistema )
      END

      IF @cSistema = 'BFW' AND (@cProducto = '10' OR @cProducto = '12' OR @cProducto = '13' OR @cProducto = '11')
      BEGIN 
         SET @Codigo_Producto = (SELECT Max( Codigo_Grupo ) FROM GRUPO_PRODUCTO with (nolock) WHERE Id_Sistema = @cSistema )
      END 
      -- 10967 Se corrige la des-imputacion de límites

      UPDATE MATRIZ_ATRIBUCION_INSTRUMENTO                             
      SET    Acumulado_Diario  = Acumulado_Diario - @nMonto_Autoriza
      WHERE  Usuario           = @firma1	
      AND    Codigo_Producto   = @Codigo_Producto
   END

   DELETE LINEA_TRANSACCION
   WHERE  Id_Sistema      = @cSistema
   AND    NumeroOperacion = @nNumoper

   DELETE LIMITE_TRANSACCION
   WHERE  Id_Sistema      = @cSistema 
   AND    NumeroOperacion = @nNumoper 
   AND    FechaOperacion  = @dFecPro 

   DELETE LINEA_TRANSACCION_DETALLE  
   WHERE  Id_Sistema      = @cSistema 
   AND    NumeroOperacion = @nNumoper 
 
   DELETE LIMITE_TRANSACCION_ERROR
   WHERE  Id_Sistema      = @cSistema 
   AND    NumeroOperacion = @nNumoper 

	UPDATE Transacciones_IDD
	SET	iestadoidd ='R' --rechazado la ope se esta anulando
	WHERE cModulo			= @cSistema
		AND cProducto		= @cProductoIDD
		AND nOperacion		= @nNumoper




	--+++CONTROL IDD, jcamposd, no debe actualizar líneas
	--EXECUTE Sp_Lineas_Actualiza   
	-----CONTROL IDD, jcamposd
   
END
--> +++ cvegasan 2017.08.08 Control Lineas IDD
GO
