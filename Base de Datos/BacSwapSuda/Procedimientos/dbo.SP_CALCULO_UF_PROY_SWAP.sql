USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCULO_UF_PROY_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALCULO_UF_PROY_SWAP]
   (   @FechaProceso    DATETIME
   ,   @dFechaVcto      DATETIME
   ,   @nTasaMon        FLOAT   = 0.0
   ,   @nTasaCnv        FLOAT   = 0.0
   ,   @vUFProy         FLOAT   OUTPUT
   )
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @nValorUf      FLOAT
   SET     @nValorUf      = ( SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @FechaProceso AND vmcodigo = 998 )

   DECLARE @vValorUf      FLOAT
   SET     @vValorUf      = 0.0

   DECLARE @iProducto     INTEGER
   SET     @iProducto     = 3

   DECLARE @iBase_Clp     FLOAT
   SET     @iBase_Clp     = 360

   DECLARE @iBase_Uf      FLOAT
   SET     @iBase_Uf      = 360

   DECLARE @iPlazo        INTEGER
   SET     @iPlazo        = DATEDIFF(DAY, @FechaProceso, @dFechaVcto  )

   --> Lee Tasa para los Pesos (999)
   DECLARE @nTasa_Clp   FLOAT
   SET     @nTasa_Clp   = @nTasaCnv

   --> Lee Tasa para los Unidad Fomento (998)
   DECLARE @nTasa_Uf    FLOAT
   SET     @nTasa_Uf    = @nTasaMon

   --> Genera Calculo
   DECLARE @Pi_K   FLOAT
   SET     @Pi_K   = POWER( 1.0 + @nTasa_Clp / 100.0, @iPlazo / @iBase_Clp )
                   / POWER( 1.0 + @nTasa_Uf  / 100.0, @iPlazo / @iBase_Uf  ) - 1.0
  
   SET @vValorUf = ROUND(@nValorUf * ( 1 + @Pi_K ),4)

   SET @vUFProy = @vValorUf

END
GO
