USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_PARIDAD_SPOT_BCCH]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_PARIDAD_SPOT_BCCH]
   (   @Codigo  CHAR(03)
   ,   @Fecha   DATETIME
   )
AS
BEGIN

   SET NOCOUNT ON

   IF NOT EXISTS(SELECT 1 FROM BacParamSuda..POSICION_SPT WHERE vmcodigo = @Codigo AND vmfecha = @Fecha)
      SELECT -1
   ELSE
      SELECT CASE WHEN mnrrda = 'M' THEN (1.0/vmparmes)
                  ELSE                    vmparmes
             END       as vmparmes
      ,      vmparmes
      FROM   BacparamSuda..POSICION_SPT 
             LEFT JOIN BacParamSuda..MONEDA ON vmcodigo = mnnemo
      WHERE  vmcodigo    = @Codigo
      AND    vmfecha     = @Fecha

END

GO
