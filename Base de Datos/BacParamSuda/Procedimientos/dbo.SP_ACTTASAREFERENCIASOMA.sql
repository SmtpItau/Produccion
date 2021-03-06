USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTTASAREFERENCIASOMA]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ACTTASAREFERENCIASOMA]
   (   @Codigo	      NUMERIC(3,0)	
   ,   @Riesgo        CHARACTER(3)
   ,   @Serie	      CHAR(12)	
   ,   @Desde	      NUMERIC(10,0) = ''
   ,   @Hasta	      NUMERIC(10,0) = ''
   ,   @TipoOpe       CHAR(03)	
   ,   @TasaRef       FLOAT
   )
AS
BEGIN

   SET NOCOUNT ON 

   INSERT INTO tasa_referencia_soma
   (      trincodigo
   ,      trClasificacionriesgo
   ,      trserie
   ,      trDesde
   ,      trHasta
   ,      trtipoper
   ,      trtasareferencial
   )
   VALUES 
   (      @Codigo	      	
   ,      @Riesgo        
   ,      @Serie	      
   ,      @Desde	   
   ,      @Hasta	  
   ,      @TipoOpe       
   ,      @TasaRef   
   )

END
GO
