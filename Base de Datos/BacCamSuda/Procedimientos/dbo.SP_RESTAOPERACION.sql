USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RESTAOPERACION]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RESTAOPERACION]( @tipmer   CHAR(4)     -- Mercado 
                                   ,@tipope   CHAR(1)     -- Tipo de Operacion
                                   ,@ticam    FLOAT       -- Tipo de Cambio
                                   ,@monmo    FLOAT       -- Monto de la Moneda
                                   ,@ussme    FLOAT       -- Monto en Dolares
                                   ,@codmon   CHAR(3)     -- Codigo de la Moneda de Operacion
                                   ,@codcnv   CHAR(3)     -- Codigo de la Moneda de Conversion 
                                   ,@tctra    FLOAT       -- Tipo de Cambio de Transferencia
                                   ,@parida   FLOAT       -- Paridad de Cierre
                                   ,@partr    FLOAT       -- Paridad de Transferencia
                                  )
AS
BEGIN
SET NOCOUNT ON
    IF @tipmer = 'EMPR'   BEGIN                  
       EXECUTE Sp_Funcion_MxCalcVolCorp @tipope
                                      , @ticam
                                      , @ussme
                                      , @codmon      -- @moneda
                                      , @codcnv
                                      , @tctra  
                                                     --, @entidad
                  
       EXECUTE Sp_MxCalcRenCorp @tipope
                              , @codmon
                              , @ticam
                              , @tctra
                              , @parida
                              , @partr
                              , @monmo            
                           -- , @entidad
    END
    ELSE
    BEGIN
       EXECUTE Sp_Recalc @codmon, @tipmer, @tipope, @ticam, @ussme
    END
SET NOCOUNT OFF                                                  
END
/***
  Sp_RestaOperacion 'PTAS'                 -- Tipo de Mercado
                   ,'C'                    -- Tipo de Operacion
                   ,605.00                 -- Tipo de Cambio de Cierre
                   ,-1000000.00            -- Monto en Moneda de Operacion
                   ,-1000000.00            -- Monto en Dolares
                   ,'USD'                  -- Codigo Moneda de Operacion
                   ,'CLP'                  -- Codigo Moneda de Conversion
                   ,605.00                 -- Tipo de Cambio de Transferencia
                   ,1.0000                 -- Paridad de Cierre
                   ,1.0000                 -- Paridad de Transferencia
-- select * from 
***/



GO
