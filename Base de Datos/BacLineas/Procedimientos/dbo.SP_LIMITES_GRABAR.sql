USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_GRABAR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LIMITES_GRABAR]
   (  @dFecPro 	        DATETIME,
      @cSistema	        CHAR(03),
      @cProducto	CHAR(05),
      @nCodInst	        NUMERIC(05,0),
      @nNumoper	        NUMERIC(10,0),
      @nMonto		NUMERIC(19,4),
      @dFecvctop	DATETIME,
      @cUsuario	        CHAR(15),
      @cCheckLimOp	CHAR(1),
      @cCheckLimInst	CHAR(1)
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @cSistema = 'BFW'
   BEGIN
   	IF EXISTS( SELECT 1 FROM BacFwdSuda.dbo.MFCA WHERE canumoper = @nNumoper AND var_moneda2 > 0 AND cacodpos1 = 1)
	BEGIN
	     RETURN
	END
   END

   DECLARE @iValDolarObs   NUMERIC(19,4)
   SET     @iValDolarObs   = 1.0

   SELECT  @iValDolarObs   = isnull(vmvalor,1.0)
   FROM    VIEW_VALOR_MONEDA
   WHERE   vmfecha         = @dFecPro
   AND     vmcodigo        = 994

   IF @cSistema = 'BFW' AND @cProducto = '10'
   BEGIN
      SET @nMonto = ROUND((@nMonto / @iValDolarObs),4)
   END

   IF @cSistema = 'BFW' AND @cProducto = '13'
   BEGIN
      SET @nMonto = 0.0 --> ROUND((@nMonto / @iValDolarObs),4)
   END

   --+++jcamposd 20180518 llevar a pesos los COP para controles de limites
   IF @cSistema = 'BEX'
   BEGIN
		DECLARE @monedaBEX	NUMERIC(3)
				,@iValCOL	NUMERIC(19,4)
				
		SELECT @monedaBEX = momonemi FROM BacBonosExtSuda.dbo.text_mvt_dri WHERE monumoper = @nNumoper 
		IF @monedaBEX = 129
		BEGIN
			SELECT  @iValCOL   = isnull(vmvalor,1.0)  
			FROM    VIEW_VALOR_MONEDA  
			WHERE   vmfecha         = @dFecPro  
			AND     vmcodigo        = 129		
			SET @nMonto = ROUND((@nMonto * @iValCOL),0)
			
		END
   END
   -----jcamposd 20180518 llevar a pesos los COP para controles de limites

   DECLARE @Aux_Producto   VARCHAR(5)
   SELECT  @Aux_Producto   = codigo_grupo
   FROM    GRUPO_PRODUCTO 
   WHERE   Id_Sistema      = @cSistema
   AND     codigo_producto = @cProducto

   IF @@ROWCOUNT > 0
   BEGIN
      SET @cProducto = @Aux_Producto
   END

   DELETE LIMITE_TRANSACCION
   WHERE  @nNumoper = NumeroOperacion
   AND    @cSistema = Id_Sistema

   INSERT INTO LIMITE_TRANSACCION
   (     FechaOperacion,
         NumeroOperacion,
         Id_Sistema,
         Codigo_Producto,
         InCodigo,
         MontoTransaccion,
         FechaVencimiento,
         Operador,
         Check_Operacion,
         Check_Instrumento
   )
   VALUES
   (     @dFecPro,
         @nNumoper,
         @cSistema,
         @cProducto,
         @nCodInst,
         @nMonto,
         @dFecvctop,
         @cUsuario,
         @cCheckLimOp,
         @cCheckLimInst
   )

END
GO
