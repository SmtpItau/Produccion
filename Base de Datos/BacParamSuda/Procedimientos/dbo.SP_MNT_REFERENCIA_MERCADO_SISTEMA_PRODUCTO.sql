USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNT_REFERENCIA_MERCADO_SISTEMA_PRODUCTO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- sp_helptext SP_MNT_REFERENCIA_MERCADO_SISTEMA_PRODUCTO
--exec SP_MNT_REFERENCIA_MERCADO_SISTEMA_PRODUCTO 2,'BFW',0,'C'

--exec BacParamsuda.dbo.SP_MNT_REFERENCIA_MERCADO_SISTEMA_PRODUCTO 0,'BFW', 1,'C'

CREATE PROCEDURE [dbo].[SP_MNT_REFERENCIA_MERCADO_SISTEMA_PRODUCTO]
   (
			@iTab		 integer   
	   ,    @Sistema	 char(3)		 	
	   ,    @Producto    INTEGER
	   ,	@Modalidad   CHAR(1)      = ''
	   ,	@Referencia  INT		  = 0
	   ,    @DiasValor   NUMERIC(5)   = 0
	   ,    @idTipoCambio smallint    = 0
   )
AS
BEGIN
   SET NOCOUNT ON

   declare @CodProductosSwap integer
   set @CodProductosSwap = 1050
     
   
   IF @iTab = 0
   BEGIN

		/*CUANDO EL SISTEMA ES SWAP, OBTENGO LOS PRODUCTOS DESDE dbo.TABLA_GENERAL_DETALLE */
	   IF @Sistema = 'PCS'
	   BEGIN
		  SELECT Referencia   = Referencia
			 ,   Glosa        = Glosa
			 ,   DiasValor    = DiasValor
		,   idTipoCambio = idTipoCambio
		  FROM   dbo.REFERENCIA_MERCADO_PRODUCTO 
				 INNER JOIN dbo.TABLA_GENERAL_DETALLE a ON tbcateg = @CodProductosSwap
					 AND [tbcodigo1] = Producto
				 INNER JOIN REFERENCIA_MERCADO     ON codigo     = Referencia
		  WHERE  Producto     = @Producto
		  AND    Modalidad    = @Modalidad
		  AND	 id_sistema	  = @Sistema
	   END

	   /*CONSULTA PARA EL RESTO DE LOS SISTEMAS */
	   IF @Sistema <> 'PCS'
	   BEGIN
		 SELECT Referencia   = Referencia
			 ,   Glosa        = Glosa
			 ,   DiasValor    = DiasValor
		,   idTipoCambio = idTipoCambio
		  FROM   REFERENCIA_MERCADO_PRODUCTO rmp
				 INNER JOIN BacParamSuda..PRODUCTO a ON a.id_sistema = rmp.id_sistema
					 AND codigo_producto = Producto
				 INNER JOIN REFERENCIA_MERCADO     ON codigo     = Referencia
		  WHERE  Producto     = @Producto
		  AND    Modalidad    = @Modalidad
		  AND	rmp.id_sistema = @Sistema
	   END
	END
	
	/*ELIMINACION DE REFERENCIA MERCADO SISTEMA PRODUCTO*/
	IF @iTab = 3
	BEGIN
		DELETE FROM REFERENCIA_MERCADO_PRODUCTO
			WHERE Producto   = @Producto
				AND Modalidad  = @Modalidad
				AND id_sistema =  @Sistema
	END

	/*REGISTRO DE UNA NUEVA REFERENCIA MERCADO SISTEMA PRODUCTO*/
	IF @iTab = 4
	BEGIN
		INSERT INTO REFERENCIA_MERCADO_PRODUCTO ( Producto ,  Modalidad,  Referencia,id_sistema,  DiasValor, idTipoCambio  )
										VALUES( @Producto, @Modalidad, @Referencia,@Sistema, @DiasValor, @idTipoCambio )
	END
END
GO
