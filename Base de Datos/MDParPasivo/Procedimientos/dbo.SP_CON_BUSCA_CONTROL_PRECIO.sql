USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_BUSCA_CONTROL_PRECIO]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_CON_BUSCA_CONTROL_PRECIO](
                                             @iSistema       Char(3),
                                             @iProducto      Char(5),
                                             @iSubproducto   Char(15) = '',
                                             @iSubproducto1  Numeric(5) = 0,
                                             @iTasa          FLOAT  = 0,
                                             @iPrecio        FLOAT  = 0,
                                             @nNumoper       NUMERIC(10) = 0,
                                             @cCodigo_Grupo  CHAR(10)    = '',
                                             @cUsuario       CHAR(20)    = '',
                                             @iCorrelativo   INTEGER     = 0,
                                             @dFecPro        CHAR(10)    = '',
                                             @EncontroCurva  CHAR(1)     = ''       
                                            )
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE @INS   CHAR(15)
	DECLARE @Spread_Minimo FLOAT
	DECLARE @Spread_Maximo FLOAT
	DECLARE @cCod_Excepcion CHAR(02)

	SELECT @cCod_Excepcion='PR'


	SELECT	@iProducto = LTRIM(RTRIM(codigo_producto))
	FROM	LINEA_CHEQUEAR  WITH (NOLOCK)
	WHERE	NumeroOperacion		= @nNumoper	AND
		Id_Sistema		= @iSistema


	SELECT	@iCorrelativo = 0
	SELECT	@iCorrelativo = (COUNT(*)) + 1
	FROM	LIMITE_TRANSACCION_ERROR  WITH (NOLOCK)
	WHERE	NumeroOperacion = @nNumoper
	AND	id_sistema      = @iSistema


	IF (@iproducto = 'CP' or @iproducto = 'VP') BEGIN 
	       SELECT @INS = (SELECT INSERIE FROM INSTRUMENTO  WITH (NOLOCK) WHERE INCODIGO=@iSubproducto1)
	END ELSE IF (@iproducto = 'CPI' or @iproducto = 'VPI') BEGIN 
	       SELECT @INS = (SELECT Nom_Familia FROM VIEW_INSTRUMENTO_INVERSION_EXTERIOR  WHERE Cod_familia = @iSubproducto1 )
	END ELSE BEGIN
	       SELECT @INS = (SELECT Descripcion FROM PRODUCTO  WITH (NOLOCK) WHERE Id_Sistema = @iSistema AND Codigo_Producto = @iproducto )
	END 


IF @EncontroCurva = 'N'
BEGIN

	IF NOT EXISTS(SELECT * FROM LIMITE_TRANSACCION  WITH (NOLOCK)
                     WHERE NumeroOperacion = @nNumoper
                     AND id_sistema        = @iSistema
                     AND codigo_producto   = @iProducto
--                   AND codigo_grupo      = @cCodigo_Grupo
                     AND tipo_control      = 'CPREC')

		EXEC SP_LIMITES_GRABAR @dFecPro, @nNumoper, @iSistema, @iProducto, @cCodigo_Grupo, 0, 0, @iPrecio, @dFecPro, @cUsuario, 'N', 'N','CPREC', 0, 0, 0, ''
	 


	INSERT INTO LIMITE_TRANSACCION_ERROR 
	SELECT	@dFecPro	,
	        @nNumoper	,
		@iSistema	,
		@iProducto	,
		@cCodigo_Grupo	,
		0		,	--@iPrecio	,
		'No existe Curva Precio-Tasas para ' + @INS,
                @iCorrelativo	,
                'CPREC'		,
		@cCod_Excepcion

	SELECT Estado='NO', Descripcion='No existe Curva Precio-Tasas para ' + @INS

	RETURN

END



IF LEN(@iSubproducto)<>0 BEGIN



   IF EXISTS( SELECT 1 FROM CONTROL_PRECIO WITH (NOLOCK) WHERE id_sistema=@iSistema AND codigo_producto=@iProducto AND codigo_subproducto=@iSubproducto) BEGIN
      SELECT @Spread_Minimo = spread_minimo,
             @Spread_Maximo = spread_maximo
      FROM  CONTROL_PRECIO  WITH (NOLOCK)
      WHERE id_sistema=@iSistema       AND 
            codigo_producto=@iProducto AND
            codigo_subproducto=@iSubproducto
   END ELSE BEGIN


       IF NOT EXISTS(SELECT * FROM LIMITE_TRANSACCION  WITH (NOLOCK)
                     WHERE NumeroOperacion = @nNumoper 
                     AND id_sistema        = @iSistema     
                     AND codigo_producto   = @iProducto   
--                   AND codigo_grupo      = @cCodigo_Grupo
                     AND tipo_control      = 'CPREC')

           EXEC SP_LIMITES_GRABAR @dFecPro, @nNumoper, @iSistema, @iProducto, @cCodigo_Grupo, 0,0, @iPrecio, @dFecPro, @cUsuario, 'N', 'N','CPREC', 0, 0, 0, ''

        INSERT INTO LIMITE_TRANSACCION_ERROR 
        SELECT	@dFecPro	,
	        @nNumoper	,
		@iSistema	,
		@iProducto	,
		@cCodigo_Grupo	,
		0		,	--@iPrecio	,
		'No existe Spread para ' + @INS,
                @iCorrelativo	,
                'CPREC'		,
		@cCod_Excepcion

        SELECT Estado='NO', Descripcion='No existe Spread para ' + @INS
        RETURN
   END

END ELSE BEGIN

   IF (@iproducto = 'CP' or @iproducto = 'VP') BEGIN --AND @iSubproducto1 in (4,31,6,7,20,15) BEGIN
 
       SELECT @INS = (SELECT INSERIE FROM INSTRUMENTO  WITH (NOLOCK) WHERE INCODIGO=@iSubproducto1)

   END ELSE BEGIN

       SELECT @INS =  @iproducto 

   END 

   IF EXISTS( SELECT 1 FROM CONTROL_PRECIO  WITH (NOLOCK) WHERE id_sistema=@iSistema AND codigo_producto=@iProducto AND codigo_subproducto=@INS) BEGIN
      SELECT @Spread_Minimo = spread_minimo,
             @Spread_Maximo = spread_maximo
      FROM CONTROL_PRECIO  WITH (NOLOCK)
      WHERE id_sistema=@iSistema       AND 
            codigo_producto=@iProducto AND
            codigo_subproducto=@INS
   END ELSE BEGIN

       IF NOT EXISTS(SELECT * FROM LIMITE_TRANSACCION  WITH (NOLOCK)
                     WHERE NumeroOperacion = @nNumoper 
                     AND id_sistema        = @iSistema        
                     AND codigo_producto   = @iProducto
--                   AND codigo_grupo      = @cCodigo_Grupo
                     AND tipo_control      = 'CPREC') 
           EXEC SP_LIMITES_GRABAR @dFecPro, @nNumoper, @iSistema, @iProducto, @cCodigo_Grupo, 0,0,@iPrecio, @dFecPro, @cUsuario, 'N', 'N','CPREC', 0, 0, 0,''

       INSERT INTO LIMITE_TRANSACCION_ERROR 
       SELECT	@dFecPro	,
	        @nNumoper	,
		@iSistema	,
		@iProducto	,
		@cCodigo_Grupo	,
		0		,	--@iPrecio	,
		'No existe Spread para ' + @INS,
                @iCorrelativo	,
                'CPREC'		,
		@cCod_Excepcion

       SELECT Estado='NO', Descripcion='No existe Spread para ' + @INS
       RETURN
   END
END 

  	SELECT @Spread_minimo   = @iTasa - @Spread_minimo
	SELECT @Spread_maximo   = @iTasa + @Spread_maximo
                        
  	IF @iPrecio >= @Spread_minimo  And @iPrecio <= @Spread_maximo BEGIN
	        SELECT 'SI',''
        	RETURN
	  END ELSE BEGIN
    
       IF NOT EXISTS(SELECT * FROM LIMITE_TRANSACCION  WITH (NOLOCK)
                     WHERE NumeroOperacion = @nNumoper 
                     AND id_sistema        = @iSistema        
                     AND codigo_producto   = @iProducto
                     AND tipo_control      = 'CPREC') 

        EXEC SP_LIMITES_GRABAR @dFecPro, @nNumoper, @iSistema, @iProducto, @cCodigo_Grupo, 0,0, @iPrecio, @dFecPro, @cUsuario, 'N', 'N','CPREC' ,0 , 0 , 0 , ''

	INSERT INTO LIMITE_TRANSACCION_ERROR
        SELECT	@dFecPro	,
	        @nNumoper	,
		@iSistema	,
		@iProducto	,
		@cCodigo_Grupo	,
		0		,	--@iPrecio	,
		'Precio ' + RTRIM(CONVERT(CHAR(24),@iprecio)) + ' Fuera de Rango ' + RTRIM(CONVERT(CHAR(24),@Spread_minimo)) + ' / ' + RTRIM(CONVERT(CHAR(24),@Spread_maximo)) + ' para ' + @INS ,
                @iCorrelativo	,
                'CPREC'		,
		@cCod_Excepcion

       SELECT Estado='NO', Descripcion='Precio ' + RTRIM(CONVERT(CHAR(24),@iprecio)) + ' Fuera de Rango ' + RTRIM(CONVERT(CHAR(24),@Spread_minimo)) + ' / ' + RTRIM(CONVERT(CHAR(24),@Spread_maximo)) + ' para ' + @INS 

   END 
END




GO
