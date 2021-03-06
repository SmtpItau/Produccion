USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ULTIMAOPERACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_ULTIMAOPERACION]( 
                                           @Codigo  CHAR(03) ,
                                     	   @Entidad CHAR(02) )
AS
BEGIN
SET NOCOUNT ON
  ----<< Actualiza nuevo numero de operaci¢n.

  --> PRD-21033 Para igualar el numero correlativo del numero operación
  DECLARE @nNumOper as numeric(21)
  set @nNumOper = (select numero_operacion from BACSWAPSUDA.dbo.SwapGeneral)

    UPDATE BACSWAPNY..SwapGeneral 
     SET numero_operacion = @nNumOper + 1
	-----------------------------------------

  UPDATE SwapGeneral 
     SET numero_operacion = numero_operacion + 1

  IF @@ERROR <> 0  BEGIN
     SELECT -1, 'No se puede capturar Correlativo de Operacion'
     SET NOCOUNT OFF
     RETURN
  END

  ----<< Correlativo de Operacion

  DECLARE @NumOperacion NUMERIC(7)

 
 SELECT numero_operacion
    FROM SWAPGENERAL  

   SET NOCOUNT OFF      -- ADO
END


GO
