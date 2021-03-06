USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_CUSTODIA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACTUALIZA_CUSTODIA](@xNumoper       NUMERIC(10),
                                       @xCorrela       NUMERIC(05),
                                       @xCustodia      CHAR(1))
AS
BEGIN
   SET NOCOUNT ON
  
  UPDATE GEN_CAPTACION SET custodia = @xCustodia WHERE numero_operacion  = @xNumoper AND
                                                       correla_operacion = @xCorrela
   
   SELECT 'OK'
   SET NOCOUNT OFF
END

GO
