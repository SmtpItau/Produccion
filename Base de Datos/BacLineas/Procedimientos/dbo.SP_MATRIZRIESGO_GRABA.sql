USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_GRABA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_GRABA]
                  (
                  @CodPro  CHAR    (5) ,
                  @Moneda  CHAR    (3) ,
                  @DiasDes NUMERIC (5) ,
                  @DiasHas NUMERIC (5) ,
                  @Porcen  NUMERIC (8,4),
		  @ConMon  CHAR    (3)
                  )
AS
BEGIN
        SET NOCOUNT ON

 BEGIN

  INSERT INTO MATRIZ_RIESGO
   (Codigo_Producto,
    Moneda,
    DiasDesde,
    DiasHasta,
    Porcentaje,
    Contra_Moneda
    )
  VALUES
    (@CodPro,
     @Moneda,
     @DiasDes,
     @DiasHas,
     @Porcen,
     @ConMon
    )  
  IF @@ERROR<>0
   BEGIN
      SELECT 'NO INSERTADO'
      RETURN
   END
      SELECT 'OK'
 END 
   SET NOCOUNT OFF
END
GO
