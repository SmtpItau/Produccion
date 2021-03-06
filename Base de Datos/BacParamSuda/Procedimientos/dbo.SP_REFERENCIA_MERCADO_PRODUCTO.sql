USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_REFERENCIA_MERCADO_PRODUCTO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_REFERENCIA_MERCADO_PRODUCTO]
   (   @iTag          INTEGER
   ,   @Producto      INTEGER
   ,   @Modalidad     CHAR(1)    = ''
   ,   @Referencia    INTEGER    = 0
   ,   @DiasValor     NUMERIC(5) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   IF @iTag = 0
   BEGIN
      SELECT DISTINCT 
             Codigo    = Codigo
           , Glosa     = Glosa
           , Defecto   = CASE WHEN @Producto = 1 AND Codigo = 1 THEN 1
                              WHEN @Producto = 2 AND Codigo = 5 THEN 1
                              ELSE                                   0
                         END 
        FROM REFERENCIA_MERCADO_PRODUCTO
             INNER JOIN REFERENCIA_MERCADO ON Codigo = Referencia
       WHERE Estado    = 0
         AND Producto  = @Producto
   END

   IF @iTag = 1
   BEGIN
      SELECT DiasValor  = DiasValor
        FROM REFERENCIA_MERCADO_PRODUCTO
             INNER JOIN REFERENCIA_MERCADO ON Codigo = Referencia
       WHERE Estado     = 0
         AND Producto   = @Producto
         AND Modalidad  = @Modalidad
         AND Referencia = @Referencia
   END

   IF @iTag = 2 -- Carga para comboxs formulario Operaciones Mx-Clp --> BacOpeArbMxClp.FRM
   BEGIN
	SELECT DISTINCT
             Codigo    = Codigo
           , Glosa     = Glosa
           , Defecto   = CASE WHEN @Producto = 1 AND Codigo = 1 THEN 1
                              WHEN @Producto = 2 AND Codigo = 5 THEN 1
                              ELSE                                   0
                         END
		   , IdCombo   = CASE WHEN  idTipoCambio = 1 THEN 1
							  ELSE                        2
				         END
        FROM REFERENCIA_MERCADO_PRODUCTO
             INNER JOIN REFERENCIA_MERCADO ON Codigo = Referencia
       WHERE Estado    = 0
         AND Producto  = @Producto
         AND Modalidad = @Modalidad
END

END
GO
