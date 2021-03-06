USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERACIONESRELACIONADAS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_OPERACIONESRELACIONADAS]
   (   @OPERACION   FLOAT   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @oper1   FLOAT
   DECLARE @OPER2   FLOAT

   CREATE TABLE #TMP6622
   (   CANUMOPER    FLOAT   );
	

   IF EXISTS( SELECT 1 FROM BacFwdSuda.dbo.MFCA WHERE canumoper = @OPERACION AND var_moneda2 = 0 )
   BEGIN
      --> No es Moneda Extranjera Clp
      SELECT @OPERACION
      RETURN
   END

   -->   Si fuese un Arbitraje Mx-clp, Retornara ambos numeros de folio correspondientes al par de operaciones.
   SELECT canumoper   FROM BacFwdSuda.dbo.MFCA WHERE canumoper   = @OPERACION UNION
   SELECT canumoper   FROM BacFwdSuda.dbo.MFCA WHERE var_moneda2 = @OPERACION UNION
   SELECT var_moneda2 FROM BacFwdSuda.dbo.MFCA WHERE canumoper   = @OPERACION UNION
   SELECT var_moneda2 FROM BacFwdSuda.dbo.MFCA WHERE var_moneda2 = @OPERACION 

RETURN    

   -->  Pregunta si es el seguro e Cambio relacionado al Arb Mx-Clp
   IF ( SELECT 1 FROM BacFwdSuda..MFCA WHERE var_moneda2 = @OPERACION and canumoper != @OPERACION ) = 1
   BEGIN

      SELECT @oper1 = var_moneda2
         ,   @oper2 = canumoper
      FROM   BacFwdSuda..MFCA 
      WHERE  var_moneda2 = @OPERACION
        and  canumoper  != @OPERACION

   END ELSE
   BEGIN
      -->  Pregunta si es el Arbitraje relacionado al Arb Mx-Clp
      IF ( SELECT 1 FROM BacFwdSuda..MFCA where canumoper = @OPERACION and var_moneda2 != @OPERACION ) = 1
      BEGIN
         SELECT @oper1 = var_moneda2
            ,   @oper2 = canumoper
           FROM BacFwdSuda..MFCA
          WHERE canumoper    = @OPERACION
            and var_moneda2 != @OPERACION
      END 
   END

   SET @oper1 = isnull(@oper1, 0)
   SET @oper2 = isnull(@oper2, 0)

   INSERT #TMP6622
   SELECT @OPER1

   INSERT #TMP6622
   SELECT @OPER2

   SELECT * FROM #TMP6622
		
END

GO
