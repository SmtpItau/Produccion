USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_GRABA_SWAP]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_GRABA_SWAP]
         ( @CodPro   CHAR (5) , -- Codigo_Producto  
    @Moneda      CHAR (3) , -- Moneda
    @DiasDes  NUMERIC (5) , -- Dias Desde
    @DiasHas  NUMERIC (5) , -- Dias Hasta
    @Porcen    numeric (8,4) ) -- Porcentaje
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
  SELECT 'OK' 
 END 
 SET NOCOUNT OFF
END

GO
