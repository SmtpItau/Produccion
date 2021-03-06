USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_PERIODO_CARTERA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_TRAE_PERIODO_CARTERA]( @NumeroOpe   NUMERIC(9),  
           				      @Tipo_Flujo  NUMERIC(2))
AS
BEGIN

     SET NOCOUNT ON

     IF @Tipo_Flujo = 1     --Recibimos
        BEGIN

        SELECT  DISTINCT compra_codamo_capital,compra_codamo_interes
        FROM CARTERA        
        WHERE Numero_Operacion=@NumeroOpe
              and tipo_flujo=@Tipo_Flujo

      END
      ELSE BEGIN

        SELECT DISTINCT venta_codamo_capital,venta_codamo_interes
        FROM CARTERA        
        WHERE Numero_Operacion=@NumeroOpe
              and tipo_flujo=@Tipo_Flujo

      END

      SET NOCOUNT OFF	
END

GO
