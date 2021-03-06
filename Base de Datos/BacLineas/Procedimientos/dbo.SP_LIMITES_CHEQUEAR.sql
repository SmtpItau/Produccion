USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_CHEQUEAR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_CHEQUEAR]
   (   @cSistema   CHAR(03)
   ,   @nNumoper   NUMERIC(10,0)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFecPro 	     DATETIME
   DECLARE @cProducto	     CHAR(05)
   DECLARE @nCodInst	     NUMERIC(05,0)
   DECLARE @nMonto	     NUMERIC(19,4)
   DECLARE @dFecvctop	     DATETIME
   DECLARE @cUsuario	     CHAR(15)
   DECLARE @cCheckLimOp	     CHAR(1)
   DECLARE @cCheckLimInst    CHAR(1)
   DECLARE @nPlazoDesde      INTEGER
   DECLARE @nPlazoHasta      INTEGER
   DECLARE @nCorrDet	     INTEGER
   DECLARE @cMensaje	     VARCHAR(255)
   DECLARE @cError 	     VARCHAR(1)
   DECLARE @cTipInst	     CHAR(6)
   DECLARE @nMontLimIni	     NUMERIC(19,04)
   DECLARE @nMontLimVen	     NUMERIC(19,04)
   DECLARE @nExceso	     NUMERIC(19,04)
   DECLARE @cTipoper	     CHAR(10)
   DECLARE @cSistema_a 	     CHAR(03)
   DECLARE @cProducto_a      CHAR(05)
   DECLARE @Aux_Id           INTEGER

   DELETE  LIMITE_TRANSACCION_ERROR
   WHERE   NumeroOperacion   = @nNumoper
   AND	   Id_Sistema	     = @cSistema

   SELECT  'id'            = Identity(INT),
           'Fecha'         = FechaOperacion,
           'Producto'      = Codigo_Producto,
           'Codigo'        = InCodigo,
           'Monto'         = SUM(MontoTransaccion),
           'Vcto'          = MAX(FechaVencimiento),
           'Operador'      = Operador,
           'Operacion'     = Check_Operacion,
           'Instrumento'   = Check_Instrumento
   INTO    #Cursor_Lim
   FROM	   LIMITE_TRANSACCION
   WHERE   NumeroOperacion = @nNumoper
   AND	   Id_Sistema	   = @cSistema
   GROUP BY FechaOperacion,
           Codigo_Producto,
           InCodigo,
           Operador,
           Check_Operacion,
           Check_Instrumento 

   CREATE INDEX #ix_Cursor_Lim ON #Cursor_Lim ( Id )

   WHILE (1 = 1)
   BEGIN

      SET @Aux_Id = 0
      SELECT TOP 1
             @Aux_Id        = id,
             @dFecPro       = Fecha,
             @cProducto     = Producto,
             @nCodInst      = Codigo,
             @nMonto        = Monto,
             @dFecvctop     = Vcto,
             @cUsuario      = Operador,
             @cCheckLimOp   = Operacion,
             @cCheckLimInst = Instrumento
      FROM   #Cursor_Lim
      WHERE  id             > @Aux_Id

      IF @@ROWCOUNT = 0
      BEGIN
         BREAK
      END

      DELETE #Cursor_Lim
       WHERE Id = @Aux_Id

      --*************** INICIO LIMITES OP. INSTUMENTO ***
      IF @cCheckLimOp = 'S'
      BEGIN

         IF @cSistema = 'BEX' AND @cProducto = '01'
         BEGIN
            SET @cProducto = '03'

            SELECT @cSistema       = 'BTR'
            FROM   GRUPO_PRODUCTO
            WHERE  Id_Sistema      = @cSistema
            AND    Codigo_Producto = 'VPX'
         END

         IF @cSistema = 'PCS' --> AND LTRIM(RTRIM(@cProducto)) IN('1','2','4') 
         BEGIN
            SET @cSistema_a  = @cSistema
            SET @cProducto_a = (SELECT DISTINCT Codigo_Grupo FROM GRUPO_PRODUCTO WHERE Id_sistema = @cSistema)
         END ELSE 
         BEGIN
            SET @cSistema_a  = @cSistema
            SET @cProducto_a = @cProducto
         END

         
         SET    @cMensaje       = ''

         DECLARE @iFound        INTEGER

         SET     @iFound         = -1
         SET     @cMensaje       = ''
         SELECT  @iFound         = 0
         FROM	 MATRIZ_ATRIBUCION_INSTRUMENTO
         WHERE	 Usuario	 = @cUsuario
         AND	 Id_Sistema 	 = @cSistema_a
         AND	 Codigo_Producto = @cProducto_a

         IF @iFound = -1
         BEGIN
            SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene privilegios Matriz no definida.' + ltrim(rtrim(@cProducto_a))
            SET @nExceso  = 0
         END 


         IF @iFound = 0
         BEGIN
            SET     @iFound         = -1
            SET     @cMensaje       = ''
            SELECT  @iFound         = 0
            FROM    MATRIZ_ATRIBUCION_INSTRUMENTO
            WHERE   Usuario	    = @cUsuario
            AND	    Id_Sistema 	    = @cSistema_a
            AND	    Codigo_Producto = @cProducto_a
            AND	    Plazo_Desde    <= DATEDIFF(DAY, @dFecPro, @dFecvctop)
            AND	    Plazo_Hasta    >= DATEDIFF(DAY, @dFecPro, @dFecvctop)

            IF @iFound = -1
            BEGIN
               SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene privilegios Plazo no definido en la Matriz.' + CONVERT(CHAR(10),DATEDIFF(DAY, @dFecPro, @dFecvctop))
               SET @nExceso  = 0
            END 
         END
        
         IF @iFound = 0
         BEGIN
            SET    @cMensaje       = ''
            SET    @nMontLimIni	   = 0
            SELECT @nMontLimIni	   = Monto_Maximo_Operacion
            FROM   MATRIZ_ATRIBUCION_INSTRUMENTO
            WHERE  Usuario         = @cUsuario
            AND	   Id_Sistema 	   = @cSistema_a
            AND	   Codigo_Producto = @cProducto_a
            AND	   Plazo_Desde    <= DATEDIFF(DAY, @dFecPro, @dFecvctop)
            AND	   Plazo_Hasta    >= DATEDIFF(DAY, @dFecPro, @dFecvctop)

            IF @@ROWCOUNT = 0
            BEGIN
               SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene Privilegios para esta Operación Limite Acumulado por Operacion. '
               SET @nExceso  = 0
            END ELSE
            BEGIN
               IF @nMontLimIni < @nMonto 
               BEGIN
                  SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto Sobrepasa el Máximo por Operación en '
                  SET @nExceso  = @nMonto - @nMontLimIni
               END
            END
         END

         IF @cMensaje <> ''
         BEGIN
            INSERT INTO LIMITE_TRANSACCION_ERROR
            (   NumeroOperacion,
                Id_Sistema,
                Monto,
                Mensaje
            )
            VALUES
            (   @nNumoper,
		@cSistema,
		@nExceso,
                @cMensaje
            )
         END

      END

      --*************************************
      --*************** FIN LIMITES OP.******
   END


   /*************************************************************/
   /* Control de limte por el acumulado de operaciones del dia */
   /*************************************************************/

   SELECT TOP 1
         @cProducto      = Codigo_Producto,
         @dFecpro        = FechaOperacion,
         @cUsuario       = Operador,
         @nCodInst       = incodigo
   FROM  LIMITE_TRANSACCION
   WHERE NumeroOperacion = @nNumoper
   AND   Id_Sistema	 = @cSistema

   SELECT 'FechaOperacion'   = a.FechaOperacion,
          'Codigo_Producto'  = a.Codigo_Producto,
          'InCodigo'	     = a.InCodigo,
          'MontoTransaccion' = SUM(a.MontoTransaccion),
          'Operador'         = a.Operador,
          'Plazo_Desde'      = b.Plazo_Desde,
          'Plazo_Hasta'      = b.Plazo_Hasta
   INTO    #Paso
   FROM	  LIMITE_TRANSACCION            a
   ,      MATRIZ_ATRIBUCION_INSTRUMENTO b
   WHERE  a.FechaOperacion   = @dFecpro
   AND    a.Id_Sistema	     = @cSistema
   AND    a.operador         = @cUsuario
   AND    a.Codigo_Producto  = @cProducto
   AND    b.Id_Sistema       = a.Id_Sistema -- CASE WHEN @cSistema = 'PCS' THEN 'BFW' ELSE a.Id_Sistema END
   AND    a.operador	     = b.Usuario
   AND    b.Codigo_Producto  = CASE WHEN a.Codigo_Producto = 'VP' And @cSistema = 'BEX' THEN '01'
			         -- WHEN @cSistema = 'PCS'                              THEN '02'
                                    ELSE                                                     a.Codigo_Producto
                               END
   AND    b.Plazo_Desde     <= DATEDIFF(DAY, a.FechaOperacion, a.FechaVencimiento)
   AND    b.Plazo_Hasta     >= DATEDIFF(DAY, a.FechaOperacion, a.FechaVencimiento)
   GROUP BY a.FechaOperacion,
          a.Operador,
          a.Codigo_Producto,
          a.InCodigo,
          b.Plazo_Desde,
          b.Plazo_Hasta


   SELECT 'Id'          = Identity(INT),
          'Fecha'       = FechaOperacion,
          'Producto'    = Codigo_Producto,
          'Codigo'      = InCodigo,
          'Monto'       = MontoTransaccion,
          'Operador'    = Operador,
          'Desde'       = Plazo_Desde,
          'Hasta'       = Plazo_Hasta
   INTO   #Cursor_Lim_Uno
   FROM	  #Paso

   CREATE INDEX #ix_Cursor_Lim_Uno ON #Cursor_Lim_Uno ( Id )

   WHILE (1 = 1)
   BEGIN

      SET @Aux_Id = 0
      SELECT TOP 1 
            @Aux_Id      = Id,
            @dFecPro     = Fecha,
            @cProducto	 = Producto,
            @nCodInst	 = Codigo,
            @nMonto      = Monto,
            @cUsuario    = Operador,
            @nPlazoDesde = Desde,
            @nPlazoHasta = Hasta
      FROM  #Cursor_Lim_Uno
      WHERE Id           > @Aux_Id

      IF @@ROWCOUNT = 0
      BEGIN
         BREAK
      END

      DELETE #Cursor_Lim_Uno
       WHERE Id = @Aux_Id

      --*************************************
      --*************** INICIO LIMITES OP. INSTUMENTO ***

      IF @cCheckLimOp = 'S'
      BEGIN
         IF @cSistema = 'BEX' AND @cProducto = '01' 
         BEGIN
            SET    @cProducto      = '03'

            SELECT @cSistema       = 'BTR'
            FROM   GRUPO_PRODUCTO
            WHERE  Id_Sistema      = @cSistema 
            AND    Codigo_Producto = 'VPX'
   END

         IF @cSistema = 'PCS' --> AND @cProducto IN('1','2','4') 
         BEGIN
            SET @cProducto_a = (SELECT DISTINCT Codigo_Grupo FROM GRUPO_PRODUCTO WHERE Id_sistema = @cSistema)
            SET @cSistema_a  = @cSistema
         END ELSE 
         BEGIN
            SET @cProducto_a = @cProducto
            SET @cSistema_a  = @cSistema
         END

         SET @cMensaje = ''

         SELECT	@nMontLimVen	= 0
         SELECT	@nMontLimVen	= Monto_Maximo_Acumulado
         FROM	MATRIZ_ATRIBUCION_INSTRUMENTO
         WHERE	Usuario		= @cUsuario
         AND	Id_Sistema 	= @cSistema_a
         AND	Codigo_Producto	= @cProducto_a
         AND	Plazo_Desde     = @nPlazoDesde			
         AND	Plazo_Hasta     = @nPlazoHasta


         IF @@ROWCOUNT = 0
         BEGIN
            SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene Privilegios para esta Operación Limite Total Acumulado Diario '
            SET @nExceso  = 0
         END ELSE
         BEGIN
            IF @nMontLimVen < @nMonto  
            BEGIN
               SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto Sobrebasa Maximo Acumulado Diario de Operación para el tramo ' + rtrim(Convert(Char(6),@nPlazoDesde)) +'-'+ rtrim(Convert(Char(6),@nPlazoHasta)) +' Días en '
               SET @nExceso  = @nMonto - @nMontLimVen
            END
         END

         IF @cMensaje <> ''
         BEGIN
            INSERT INTO LIMITE_TRANSACCION_ERROR
            (   NumeroOperacion,
                Id_Sistema,
                Monto,
                Mensaje
            )
            VALUES
            (   @nNumoper,
                @cSistema,
                @nExceso,
                @cMensaje
            )
         END

      END

      --*************************************
      --*************** FIN LIMITES OP.******
   END

  --/* Esta verificando que el usuario exista en test bactrader
  -- Huo que otorgar grant aunque nunca se aplicarán estas instrucciones
   IF EXISTS(SELECT 1 FROM LIMITE_TRANSACCION_ERROR WHERE NumeroOperacion = @nNumoper AND Id_Sistema = @cSistema)
   BEGIN
      IF @cSistema = 'BTR'
      BEGIN
         UPDATE VIEW_MDMO      SET mostatreg = 'P' WHERE monumoper = @nNumoper
      END
   END

   --> Determina si es operación generada en CHile o NY
   DECLARE @EsOperacionNY as char(2)
   SET @EsOperacionNY = 'No'
 	IF exists (select 1 from BACBONOSEXTNY..text_mvt_dri where monumoper = @nNumoper)
				set @EsOperacionNY = 'Si'


   IF @cSistema = 'BEX'
   BEGIN
		IF @EsOperacionNY = 'No'
		BEGIN
			UPDATE VIEW_TEXT_MVT_DRI SET mostatreg = 'P' WHERE monumoper = @nNumoper
		END ELSE
		BEGIN
			UPDATE VIEW_text_mvt_dri_NY SET mostatreg = 'P' WHERE monumoper = @nNumoper
		END

   END
--*/
END

GO
