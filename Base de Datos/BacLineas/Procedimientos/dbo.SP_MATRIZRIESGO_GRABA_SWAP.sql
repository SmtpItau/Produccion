USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_GRABA_SWAP]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_GRABA_SWAP]
         ( @CodPro  	CHAR (5)
	 , @Moneda      CHAR (3)
	 , @DiasDes 	NUMERIC (5)
	 , @DiasHas 	NUMERIC (5)
	 , @Porcen   	numeric (8,4)
          )
AS
BEGIN

SET NOCOUNT ON

 BEGIN

  INSERT INTO MATRIZ_RIESGO_SWAP
   (Codigo_Producto,
    Moneda,
    DiasDesde,
    DiasHasta,
    Porcentaje)
 VALUES
   (@CodPro,
    @Moneda,
    @DiasDes,
    @DiasHas,
    @Porcen
   )  
  IF @@error<>0
    BEGIN
      SELECT 'NO INSERTADO'
      RETURN
    END
  ELSE
     SELECT 'OK'

 END 

 SET NOCOUNT OFF

END
GO
