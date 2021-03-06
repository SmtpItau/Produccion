USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTMONEDAPRIORIDAD]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTMONEDAPRIORIDAD]
   (   @CodMoneda	 NUMERIC(5,0)	
   ,   @Prioridad        NUMERIC(10,0)
   )
AS
BEGIN

   SET NOCOUNT ON 

   INSERT INTO MonedaPrioridad
   (      MnCodMon
   ,      mnPrioridad 
   )
   VALUES 
   (      @CodMoneda	      	
   ,      @Prioridad           
   )

END
GO
