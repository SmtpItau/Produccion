USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_GRABA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_GRABA]
         (@CodPro  CHAR (5) , -- Codigo_Producto  
   @Moneda         CHAR (3) , -- Moneda
   @DiasDes NUMERIC (5) , -- Dias Desde
   @DiasHas NUMERIC (5) , -- Dias Hasta
   @Porcen   numeric (8,4) ) -- Porcentaje
AS
BEGIN
        SET NOCOUNT ON
-- BEGIN TRANSACTION
/* if exists(SELECT CODIGO_PRODUCTO FROM MATRIZ_RIESGO WHERE CODIGO_PRODUCTO=@CodPro
   AND MODALIDAD_PAGO=@ModPag AND DIASDESDE=@DiasDes)
  BEGIN 
  select "Existe"
  UPDATE MATRIZ_RIESGO SET Codigo_Producto=@CodPro,
      Modalidad_Pago=@ModPag,
      DiasDesde=@DiasDes,
      DiasHasta=@DiasHas,
      Porcentaje=@Porcen
      WHERE CODIGO_PRODUCTO=@CodPro
       AND MODALIDAD_PAGO=@ModPag
       AND DIASDESDE=@DiasDes
         IF @@error<>0
                    BEGIN
                     ROLLBACK TRANSACTION
                    SELECT "NO ACTUALIZADO"
                     RETURN
                END
         COMMIT TRANSACTION
         SELECT "OK" 
  END
 ELSE
*/
 BEGIN
--  BEGIN TRANSACTION
  INSERT INTO MATRIZ_RIESGO
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
--                  ROLLBACK TRANSACTION
                  SELECT 'NO INSERTADO'
                  RETURN
                END
 --      COMMIT TRANSACTION
         SELECT 'OK' 
 END 
   SET NOCOUNT OFF
END
-- select * from matriz_riesgo
-- EXECUTE sp_matrizriesgo_graba '7', '13',1, 30, 7

GO
