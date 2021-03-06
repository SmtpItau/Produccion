USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ULTIMODIA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_ULTIMODIA]  
            (   @Fecha        DATETIME  
            ,   @Adelante     CHAR(01)  
            ,   @FechaRetorno DATETIME OUTPUT  
            )  
AS
BEGIN  



  
   DECLARE @nDia      NUMERIC(02)  
   DECLARE @nMes      NUMERIC(02)  
   DECLARE @nYear     NUMERIC(04)  
   DECLARE @Fecha_Aux DATETIME  
  
   SET NOCOUNT ON     
  
   SELECT @nMes  = DATEPART(month, @Fecha)  
   SELECT @nDia  = 1  
   SELECT @nYear = DATEPART(year, @Fecha)  
     
   IF @Adelante = 'S'  
   BEGIN             

    	SELECT @nMes = @nMes + 1  

	IF @nMes > 12  
      BEGIN             
         SELECT @nMes = 1  
         SELECT @nYear = @nYear + 1  
      END  
        
   END  
  
   SELECT @Fecha_Aux = CONVERT(CHAR(04),@nYear) +           
                (CASE WHEN @nMes < 10 THEN '0' + CONVERT(CHAR(01),@nMes) ELSE CONVERT(CHAR(02),@nMes) END) +  
                (CASE WHEN @nDia < 10 THEN '0' + CONVERT(CHAR(01),@nDia) ELSE CONVERT(CHAR(02),@nDia) END)  
  
   SELECT @Fecha_Aux = CONVERT(DATETIME,DATEADD(day, -1, @Fecha_Aux))  
     
   SET NOCOUNT OFF  
  
   SELECT @FechaRetorno =  @Fecha_Aux  
  
END
-- Base de Datos --
GO
