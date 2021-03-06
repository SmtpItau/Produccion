USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_UltimoDia]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_UltimoDia]
            (   @Fecha        DATETIME
            ,   @Adelante     CHAR(01)
            ,   @FechaRetorno DATETIME OUTPUT
            )
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   DECLARE @nDia      NUMERIC(02)
   DECLARE @nMes      NUMERIC(02)
   DECLARE @nYear     NUMERIC(04)
   DECLARE @Fecha_Aux DATETIME

   SELECT @nMes  = DATEPART(m, @Fecha)
   SELECT @nDia  = 1
   SELECT @nYear = DATEPART(yyyy, @Fecha)
   
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

   SELECT @Fecha_Aux = CONVERT(DATETIME,DATEADD(d, -1, @Fecha_Aux))
   
   SELECT @FechaRetorno =  @Fecha_Aux

END


GO
