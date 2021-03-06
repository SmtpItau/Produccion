USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTHAIRCUTSOMA]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ACTHAIRCUTSOMA]
   (   @Codigo	      NUMERIC(3,0)	
   ,   @Riesgo        CHARACTER(3)
   ,   @TipoOpe       CHAR(03)	
   ,   @TasaRef       FLOAT
   )
AS
BEGIN

   SET NOCOUNT ON 

   INSERT INTO HAIRCUT_SOMA
   (      hcincodigo
   ,      hcClasificacionRiesgo
   ,      hctipoper
   ,      hchaircut
   )
   VALUES 
   (      @Codigo	      	
   ,      @Riesgo          
   ,      @TipoOpe       
   ,      @TasaRef   
   )

END
GO
