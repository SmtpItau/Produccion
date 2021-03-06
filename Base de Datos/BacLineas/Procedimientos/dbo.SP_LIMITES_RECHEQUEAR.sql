USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_RECHEQUEAR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_RECHEQUEAR]
	(	@cSistema			CHAR(03)
	,	@nNumoper			NUMERIC(10,0)
	,	@cUsuario			CHAR(15)
	,	@Indicador			CHAR(1)
	,	@iMostrarRetorno	INT			= 0
	)
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @dFecPro             DATETIME  
   DECLARE @cProducto           CHAR(05)  
   DECLARE @nCodInst            NUMERIC(05,0)  
   DECLARE @nMonto              NUMERIC(19,4)  
   DECLARE @dFecvctop           DATETIME  
   DECLARE @cCheckLimOp         CHAR(1)  
   DECLARE @cCheckLimInst       CHAR(1)  
   DECLARE @Sw_Error            CHAR(1)  
   DECLARE @operador            CHAR(15)  
   DECLARE @cSistemaAux         CHAR(03)  
   DECLARE @supervisor          CHAR(1)  
   DECLARE @nDolar  FLOAT  
   DECLARE @Firma1       CHAR(15)  
   DECLARE @Firma2       CHAR(15)  
   DECLARE @Estado              CHAR(01)  
   DECLARE @Fir1                CHAR(15)  
   DECLARE @nCorrDet            INTEGER  
   DECLARE @cMensaje            VARCHAR(255)  
   DECLARE @cError              VARCHAR(1)  
   DECLARE @cTipInst            CHAR(6)  
   DECLARE @nMontLimIni         NUMERIC(19,04)  
   DECLARE @nMontLimVen         NUMERIC(19,04)  
   DECLARE @nExceso             NUMERIC(19,04)  
   DECLARE @nmontolimocu        NUMERIC(19,04)  
   DECLARE @nMontOpLimIni NUMERIC(19,04)  
   DECLARE @nMontOpLimVen NUMERIC(19,04)  
   DECLARE @nmontoOpLimocu      NUMERIC(19,04)  
   DECLARE @nmontoOpLimDis      NUMERIC(19,04)  
   DECLARE @monto_operador      NUMERIC(19,4)  
   DECLARE @monto_supervisor    NUMERIC(19,4)  
   DECLARE @MontLimoperad       NUMERIC(19,4)  
   DECLARE @MontLimoperadac     NUMERIC(19,4)  
   DECLARE @MontLimsuperv       NUMERIC(19,4)  
   DECLARE @montocargaop NUMERIC(19,4)  
   DECLARE @montocargasup       NUMERIC(19,4)  
   DECLARE @Aux_Id              INTEGER
   DECLARE @NOperacion			INTEGER -->Jcamposd 20180518 COLTES
   DECLARE @monedaBEX			INTEGER -->Jcamposd 20180518 COLTES
  
   SET @cSistemaAux = @cSistema  
   SET @Sw_Error    = 'N'  
   SET @supervisor  = 'N'  
  
   SET @cMensaje = ' '  
  
   SELECT 'Id'            = Identity(INT)  
   ,      'Fecha'         = FechaOperacion  
   ,      'Producto'      = Codigo_Producto  
   ,      'Codigo'        = InCodigo  
   ,      'Monto'         = SUM(MontoTransaccion)  
   ,      'Vcto'          = MAX(FechaVencimiento)  
   ,      'Operacion'     = Check_Operacion  
   ,      'Instrumento'   = Check_Instrumento  
   ,      'Operador'      = Operador
   ,	  'NOperacion'	  = NumeroOperacion -->Jcamposd 20180518 necesitamos el numero para identicar las invext en otra moneda <> dolar
   INTO   #Cursor_Lim_ReChequear  
   FROM   LIMITE_TRANSACCION --	with (nolock)  
   WHERE  NumeroOperacion = @nNumoper  
   AND   Id_Sistema   = @cSistema  
   GROUP BY  FechaOperacion  
         ,   Codigo_Producto  
         ,   InCodigo  
         ,   Check_Operacion  
         ,   Check_Instrumento  
         ,   operador
         ,	 NumeroOperacion   
  
   CREATE INDEX #ix_Cursor_Lim_ReChequear ON #Cursor_Lim_ReChequear (Id)  
  
   DECLARE @iContador   INTEGER  
   DECLARE @iRegistros  INTEGER  
       SET @iContador   = (SELECT MIN(Id) FROM #Cursor_Lim_ReChequear)  
       SET @iRegistros  = (SELECT MAX(Id) FROM #Cursor_Lim_ReChequear)  
  
   WHILE (@iRegistros >= @iContador)  
   BEGIN  
  
      SELECT @Aux_Id        = Id  
      ,      @dFecPro       = Fecha  
      ,      @cProducto     = Producto  
      ,      @nCodInst      = Codigo  
      ,      @nMonto        = Monto  
      ,      @dFecvctop     = Vcto  
      ,      @cCheckLimOp   = Operacion  
      ,      @cCheckLimInst = Instrumento  
      ,      @operador      = Operador
      ,		 @NOperacion    = NOperacion
      FROM   #Cursor_Lim_ReChequear  
      WHERE  Id             = @iContador   
  
      SET @iContador = @iContador + 1  
  
      IF @@ROWCOUNT = 0  
      BEGIN  
         BREAK  
      END  
  
      IF @cSistema = 'BEX'    
      BEGIN    
         SET @cSistema  = 'BTR'    
         SET @cProducto = '03'    
         --+++jcamposd 20180517 control moneda BEX si es coltes el limite esta en pesos desde la grabación.	
         SELECT @monedaBEX = momonemi FROM BacBonosExtSuda.dbo.text_mvt_dri where monumoper = @NOperacion
         IF @monedaBEX <> 129
         BEGIN
			SET @nDolar    = ISNULL((SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmfecha = @dFecPro AND vmcodigo = 994),0.0)    
			SET @nMonto    = ROUND(@nMonto * @nDolar,0)   
		 END
         -----jcamposd 20180517		 		  
      END      
  
      IF @cSistema = 'PCS'  
      BEGIN   
         SET @cSistema  = @cSistema  
         SET @cProducto = (SELECT DISTINCT Codigo_Grupo FROM GRUPO_PRODUCTO with(nolock) WHERE Id_Sistema = @cSistema )  
      END  
  
      IF @cSistema = 'BFW' AND (@cProducto = '10' OR @cProducto = '12' OR @cProducto = '13' OR @cProducto = '11')  
      BEGIN   
         SET @cProducto = ISNULL( ( SELECT DISTINCT Codigo_Grupo FROM GRUPO_PRODUCTO with(nolock) WHERE Id_Sistema = @cSistema AND Codigo_Producto = @cProducto ), '02')  
      END   
  
      SET @Fir1 = ''  
      SET @Fir1 = ISNULL((SELECT ISNULL(max(Firma1),'') FROM DETALLE_APROBACIONES  with(nolock)  WHERE Id_Sistema = @cSistema AND Numero_Operacion = @nNumoper AND Fecha_Operacion = @dFecPro),'')  
  
      IF EXISTS(SELECT 1 FROM DETALLE_APROBACIONES with(nolock) WHERE Id_Sistema      = @cSistema AND Numero_Operacion = @nNumoper   
                                                                   AND Fecha_Operacion = @dFecPro  AND Estado           = 'F'   
                                                                   AND Firma1         <> 'FALTA'   AND Firma1          <> @cUsuario)  
      BEGIN  
         UPDATE DETALLE_APROBACIONES
         SET    Firma2           = @cUsuario  
         ,      Estado           = 'A'  
         WHERE  Id_Sistema       = @cSistema  
         AND    Numero_Operacion = @nNumoper  
         AND    Fecha_Operacion  = @dFecPro  
         AND    Estado           = 'F'  
         AND    Firma1          <> @cUsuario  
      END ELSE  
      BEGIN   
         IF @cCheckLimOp = 'S'  
         BEGIN  
            SET @cMensaje = ' '  
  
            IF @cSistema = 'PCS'  
            BEGIN  
               SET @cSistema  = @cSistema  
               SET @cProducto = (SELECT DISTINCT Codigo_Grupo FROM GRUPO_PRODUCTO  with (nolock)  WHERE Id_Sistema = @cSistema)  
            END  
  
            IF @cSistema = 'BEX'  
            BEGIN  
               SET @cSistema  = 'BTR'  
               SET @cProducto = '03'  
               SET @nDolar    = (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with (nolock) WHERE vmfecha = @dFecPro AND vmcodigo = 994)  
               SET @nMonto    = ROUND(@nMonto * @nDolar,0)  
            END  
  
            IF @indicador <> 'I'  
            BEGIN  
               IF @operador <> @cUsuario  
               BEGIN  
  
                  IF EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO with (nolock) WHERE Usuario = @operador AND Codigo_Producto = @cProducto)  
                  BEGIN  
                     SET @nMontOpLimIni  = 0  
                     SET @nMontOpLimVen  = 0  
                     SET @nmontoOplimocu = 0  
                     SET @nmontoOpLimDis = 0  
  
                     IF EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO with (nolock) WHERE Usuario         = @operador  
                                                                                           AND Codigo_Producto = @cProducto  
                                                                                           AND Plazo_Desde    <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
                                                                                           AND Plazo_Hasta    >= DATEDIFF(DAY, @dFecPro, @dFecvctop))  
                     BEGIN  
                        SET @nMontOpLimIni  = 0  
                        SET @nMontOpLimVen  = 0  
                        SET @nmontoOplimocu = 0  
  
                        SELECT @nMontOpLimIni   = Monto_Maximo_Operacion  
                        ,      @nMontOpLimVen   = Monto_Maximo_Acumulado  
                        ,      @nmontoOplimocu  = Acumulado_Diario  
                        FROM   MATRIZ_ATRIBUCION_INSTRUMENTO with (nolock)  
                        WHERE  Usuario  = @operador  
                        AND    Codigo_Producto = @cProducto  
           AND    Plazo_Desde     <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
                        AND    Plazo_Hasta     >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
  
                        SET @nmontoOpLimDis = @nMontOpLimVen - @nmontoOplimocu  
                     END  
  
                  END ELSE  
                  BEGIN  
                     SET @cMensaje = RTRIM(LTRIM(@operador)) + ': Operador no tiene Privilegios para esta Operación [Sin Matriz]'  
                     SET @nExceso  = 0  
                  END  
  
  
                  IF @Fir1 <> @cUsuario  
                  BEGIN  
                     IF EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO with (nolock) WHERE Usuario         = @cUsuario  
                                                                                           AND Codigo_Producto = @cProducto  
                                                                                           AND Plazo_Desde    <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
                                                                  AND Plazo_Hasta    >= DATEDIFF(DAY, @dFecPro, @dFecvctop))  
                     BEGIN  
                        SET @nMontLimIni        = 0.0  
                        SET @nMontLimVen        = 0.0  
                        SET @nmontolimocu       = 0.0  
  
                        SELECT @nMontLimIni     = Monto_Maximo_Operacion  
                        ,      @nMontLimVen     = Monto_Maximo_Acumulado  
                        ,      @nmontolimocu    = Acumulado_Diario  
                        FROM   MATRIZ_ATRIBUCION_INSTRUMENTO  with (nolock)   
                        WHERE  Usuario  = @cUsuario  
                        AND    Codigo_Producto = @cProducto  
                        AND    Plazo_Desde     <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
                        AND    Plazo_Hasta     >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
  
                        IF @nMontLimIni < @nMonto  
                        BEGIN  
                           SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto Sobrepasa Maximo de Operación '  
                           SET @nExceso  = @nMontLimIni - @nMonto  
                        END  
  
                        IF (@nmontolimocu + @nMonto) > @nMontLimVen OR ((@nmontolimocu + @nMonto) > (@nmontoOpLimDis + @nMontLimVen))  
                        BEGIN  
                           SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto Sobrepasa Maximo Acumulado de Operación '  
                           SET @nExceso  = ABS(( @nMonto + @nmontolimocu ) - @nMontLimVen )  
                        END  
                     END ELSE  
                     BEGIN  
  
                        --> Se agrego por mensaje poco claro en Aprobacion de operaciones  
                        IF EXISTS( SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO with(nolock) WHERE Usuario = @cUsuario AND Codigo_Producto = @cProducto)  
                        BEGIN  
                           IF NOT EXISTS( SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO with(nolock)   
                                                 WHERE Usuario      = @cUsuario AND Codigo_Producto = @cProducto  
                                                   AND Plazo_Desde <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
												   AND Plazo_Hasta >= DATEDIFF(DAY, @dFecPro, @dFecvctop))  
                           BEGIN  
                              SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Plazo de la operación excede plazo en matriz. '  
                              SET @nExceso  = 0  
                           END  
                        END ELSE  
                        BEGIN  
                           SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene Privilegios para esta Operación [No Matriz]'  
                           SET @nExceso  = 0  
                        END  
                       --> Se agrego por mensaje poco claro en Aprobacion de operaciones  
                     END  
  
                  END ELSE  
                  BEGIN  
                     SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no puede ser Segunda Firma a la vez'  
                     SET @nExceso  = 0  
                  END  
               END ELSE  
               BEGIN  
                  SET @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no puede aprobarse a si mismo'  
              SET @nExceso  = 0  
               END  
            END ELSE  
            BEGIN  
  
               SET @nMontOpLimIni  = 0  
               SET @nMontOpLimVen  = 0  
               SET @nmontoOplimocu = 0  
               SET @nmontoOpLimDis = 0  
  
               IF EXISTS(SELECT 1 FROM MATRIZ_ATRIBUCION_INSTRUMENTO with (nolock) WHERE Usuario         = @operador  
                                                                                     AND Codigo_Producto = @cProducto  
                                                                                     AND Plazo_Desde    <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
                                                                                     AND Plazo_Hasta    >= DATEDIFF(DAY, @dFecPro, @dFecvctop))  
               BEGIN  
                  SET @nMontOpLimIni  = 0  
                  SET @nMontOpLimVen  = 0  
                  SET @nmontoOplimocu = 0  
  
                  SELECT @nMontOpLimIni   = Monto_Maximo_Operacion  
                  ,      @nMontOpLimVen   = Monto_Maximo_Acumulado  
                  ,      @nmontoOplimocu  = Acumulado_Diario  
                  FROM  MATRIZ_ATRIBUCION_INSTRUMENTO  with (nolock)   
                  WHERE  Usuario          = @operador  
                  AND    Codigo_Producto  = @cProducto  
                  AND    Plazo_Desde     <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
                  AND    Plazo_Hasta     >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
  
                  SET @nmontoOpLimDis     = @nMontOpLimVen - @nmontoOplimocu  
               END  
            END  
         END  
  
         IF @cMensaje <> ' '  
         BEGIN  
            SET @Sw_Error = 'S'  
            INSERT INTO LIMITE_TRANSACCION_ERROR  
            (   NumeroOperacion  
            ,   Id_Sistema  
            ,   Monto  
            ,   Mensaje  
            )  
            VALUES  
            (   @nNumoper  
            ,   @cSistema  
            ,   @nExceso  
            ,   @cMensaje  
            )  
         END  
  
         IF @indicador <> 'I'  
         BEGIN  
            IF @Sw_Error <> 'S'  
            BEGIN  
               SET    @montocargaop    = 0  
               SELECT @monto_operador  = Acumulado_Diario  
               ,      @MontLimoperad   = Monto_Maximo_Operacion  
               ,      @MontLimoperadac = Monto_Maximo_Acumulado  
               FROM   MATRIZ_ATRIBUCION_INSTRUMENTO with (nolock)  
               WHERE  Usuario          = @operador  
               AND    Codigo_Producto  = @cProducto  
               AND    Plazo_Desde     <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
               AND    Plazo_Hasta     >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
  
               SELECT @monto_supervisor = Acumulado_Diario  
               ,      @MontLimsuperv = Monto_Maximo_Acumulado  
               FROM   MATRIZ_ATRIBUCION_INSTRUMENTO with (nolock)  
               WHERE  Usuario  = @cusuario  
               AND    Codigo_Producto = @cProducto  
               AND    Plazo_Desde      <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
               AND    Plazo_Hasta      >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
  
               SET @MontLimoperad       = ISNULL(@MontLimoperad,0)  
               SET @monto_operador      = ISNULL(@monto_operador,0)  
  
               IF (@monto_operador + @nmonto > @MontLimoperadac)  
               BEGIN  
          IF (@nmonto > @MontLimoperad)   
                  BEGIN  
                     SET @monto_operador   = @monto_operador  
                     SET @monto_supervisor = @monto_supervisor + @nmonto  
                     SET @montocargaop     = @monto_operador  
                     SET @montocargasup    = @monto_supervisor  
                     SET @Firma1           = @cUsuario  
                     SET @Firma2           = ''  
                     SET @Estado           = 'F'  
                  END ELSE  
                  BEGIN   
                     SET @monto_operador   = @monto_operador  
                     SET @monto_supervisor = @monto_supervisor + @nmonto  
                     SET @montocargaop     = @monto_operador  
                     SET @montocargasup    = @monto_supervisor  
                     SET @Firma1           = @cUsuario  
                     SET @Firma2           = ''  
                     SET @Estado           = 'F'  
                  END  
               END ELSE  
               BEGIN  
                  IF @nmonto > @MontLimoperad  
                  BEGIN  
                     SET @monto_operador   = @monto_operador   
                     SET @monto_supervisor = @monto_supervisor + @nmonto   
                     SET @montocargaop     = @monto_operador  
                     SET @montocargasup    = @monto_supervisor   
                     SET @Firma1           = @cUsuario  
                     SET @Firma2           = ''  
                     SET @Estado           = 'F'  
                  END ELSE  
                  BEGIN
                     IF @operador  <> @cUsuario
                     BEGIN
                        SET @monto_operador   = @monto_operador
                        SET @monto_supervisor = @monto_supervisor  
                        SET @montocargaop     = @monto_operador  
                        SET @montocargasup    = @monto_supervisor  
                        SET @Firma1           = @operador  
                        SET @Firma2           = @cUsuario  
                        SET @Estado           = 'A'  
                     END  
                  END  
               END  

               UPDATE MATRIZ_ATRIBUCION_INSTRUMENTO  
               SET    Acumulado_Diario  = @monto_operador  
               WHERE  Usuario           = @operador  
               AND    Codigo_Producto   = @cProducto  
               AND    Plazo_Desde      <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
               AND    Plazo_Hasta      >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
  
               UPDATE MATRIZ_ATRIBUCION_INSTRUMENTO  
               SET    Acumulado_Diario = @monto_supervisor  
               WHERE  Usuario          = @cusuario  
               AND    Codigo_Producto  = @cProducto  
               AND    Plazo_Desde     <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
               AND    Plazo_Hasta     >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
  
               IF NOT EXISTS(SELECT 1 FROM DETALLE_APROBACIONES with(nolock) WHERE Id_Sistema      = @cSistema AND Numero_Operacion = @nNumoper  
                                                                               AND Fecha_Operacion = @dFecPro  AND Estado           = 'A')  
               BEGIN  
                  IF EXISTS(SELECT 1 FROM DETALLE_APROBACIONES  with(nolock) WHERE Id_Sistema      = @cSistema AND Numero_Operacion = @nNumoper  
                                                                               AND Fecha_Operacion = @dFecPro  AND Estado           = 'F')  
                  BEGIN  
                     UPDATE DETALLE_APROBACIONES  
                     SET    Operador_Autoriza = SUBSTRING(@cusuario,1,10)  
                     ,      Monto_Autoriza    = CONVERT(FLOAT,@montocargasup)  
                     ,      Firma1            = ISNULL(@Firma1,'FALTA')  
                     ,      Firma2            = ISNULL(@Firma2,'FALTA')  
                     WHERE  Id_Sistema        = @cSistema  
                     AND    Numero_Operacion  = @nNumoper  
                     AND    Fecha_Operacion   = @dFecPro  
                     AND    Estado            = 'F'  
                  END ELSE  
                  BEGIN  
                     INSERT INTO DETALLE_APROBACIONES  
                     (   Id_Sistema  
                     ,   Numero_Operacion  
                     ,   Fecha_Operacion  
                     ,   Operador_Origen  
                     ,   Operador_Autoriza  
                     ,   Monto_Operacion  
                     ,   Monto_Operador  
                     ,   Monto_Autoriza  
                     ,   Estado  
                     ,   Firma1  
                     ,   Firma2  
                    )  
                     VALUES  
                     (   @cSistema  
                     ,   @nNumoper  
                     ,   @dFecPro  
                     ,   SUBSTRING(@operador,1,10)  
                     ,   SUBSTRING(@cusuario,1,10)  
                     ,   CONVERT(FLOAT,@nmonto)  
                     ,   CONVERT(FLOAT,@montocargaop)  
                     ,   CONVERT(FLOAT,@montocargasup)  
                     ,   ISNULL(@Estado,'F')  
                     ,   ISNULL(@Firma1,'FALTA')  
                     ,   ISNULL(@Firma2,'FALTA')  
                     )  
                  END  
  
               END ELSE    
               BEGIN  
                  UPDATE DETALLE_APROBACIONES   
                  SET    Operador_Autoriza   = SUBSTRING(@cusuario,1,10)  
                  ,      Monto_Operacion     = CONVERT(FLOAT,@nmonto)  
                  ,      Monto_Operador      = CONVERT(FLOAT,@montocargaop)  
                  ,      Monto_Autoriza      = CONVERT(FLOAT,@montocargasup)  
                  WHERE  Id_Sistema          = @cSistema  
                  AND    Numero_Operacion    = @nNumoper  
                  AND    Fecha_Operacion     = @dFecPro  
                  AND    Estado              = 'A'  
               END  
            END  
         END ELSE   
         BEGIN  
            SET    @montocargaop    = 0  
            SELECT @monto_operador  = Acumulado_Diario  
            ,      @MontLimoperad   = Monto_Maximo_Operacion  
            ,      @MontLimoperadac = Monto_Maximo_Acumulado  
            FROM   MATRIZ_ATRIBUCION_INSTRUMENTO  with (nolock)   
            WHERE  Usuario          = @operador  
            AND    Codigo_Producto  = @cProducto  
            AND    Plazo_Desde     <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
            AND    Plazo_Hasta     >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
  
            SELECT @monto_supervisor = Acumulado_Diario  
            ,      @MontLimsuperv    = Monto_Maximo_Acumulado  
            FROM   MATRIZ_ATRIBUCION_INSTRUMENTO  with (nolock)   
            WHERE  Usuario           = @cusuario  
            AND    Codigo_Producto   = @cProducto  
            AND    Plazo_Desde      <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
            AND    Plazo_Hasta      >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
                       
            SET @MontLimoperad  = ISNULL(@MontLimoperad,0)  
            SET @monto_operador = ISNULL(@monto_operador,0)  
  
            IF (@monto_operador + @nmonto <= @MontLimoperadac)  
            BEGIN  
               IF (@nmonto <= @MontLimoperad)  
               BEGIN  
                  SET @monto_operador   = @monto_operador + @nmonto  
                  SET @monto_supervisor = @monto_supervisor   
                  SET @montocargaop     = @nmonto  
                  SET @montocargasup    = @monto_supervisor  
                  SET @Firma1           = @operador  
                  SET @Firma2           = @cUsuario  
                  SET @Estado           = 'F1'  
               END  
            END  
           
            UPDATE MATRIZ_ATRIBUCION_INSTRUMENTO  
            SET    Acumulado_Diario = @monto_operador  
            WHERE  Usuario          = @operador  
            AND    Codigo_Producto  = @cProducto  
            AND    Plazo_Desde     <= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
            AND    Plazo_Hasta     >= DATEDIFF(DAY, @dFecPro, @dFecvctop)  
  
            IF NOT EXISTS(SELECT 1 FROM DETALLE_APROBACIONES with (nolock) WHERE Id_Sistema      = @cSistema AND Numero_Operacion = @nNumoper  
                                                                             AND Fecha_Operacion = @dFecPro  AND Estado           = 'A')  
            BEGIN  
  
               INSERT INTO DETALLE_APROBACIONES   
               (      Id_Sistema  
               ,      Numero_Operacion  
               ,      Fecha_Operacion  
               ,      Operador_Origen  
               ,      Operador_Autoriza  
               ,      Monto_Operacion  
               ,      Monto_Operador  
               ,      Monto_Autoriza  
               ,      Estado  
               ,      Firma1  
               ,      Firma2  
               )  
               VALUES  
               (      @cSistema  
               ,      @nNumoper  
               ,      @dFecPro  
               ,      ISNULL(SUBSTRING(@operador,1,10),'')  
               ,      ISNULL(SUBSTRING(@cusuario,1,10),'')  
               ,      CONVERT(FLOAT,@nmonto)  
               ,      CONVERT(FLOAT,@montocargaop)  
               ,      CONVERT(FLOAT,@montocargasup)  
               ,      ISNULL(@Estado,'FALTA')  
               ,      ISNULL(@Firma1,'FALTA')  
               ,      ISNULL(@Firma2,'FALTA')  
               )  
            END  
         END  
      END  
   END


   IF @iMostrarRetorno = 1
   BEGIN
		IF @Sw_Error = 'S'  
			SELECT 'NO', @cMensaje   
		ELSE  
			SELECT 'OK', @cMensaje   
	END
  
END  
GO
