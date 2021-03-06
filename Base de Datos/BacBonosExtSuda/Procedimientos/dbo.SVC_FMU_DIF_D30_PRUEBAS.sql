USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_FMU_DIF_D30_PRUEBAS]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_FMU_DIF_D30_PRUEBAS]
   (   @fecini   DATETIME
   ,   @fecvto   DATETIME
   )
AS
BEGIN

   DECLARE @DifDias   INTEGER

   IF DATEPART(DAY, @fecvto)= 31 AND DATEPART(DAY, @fecini)= 31
      SET @DifDias = 0
   ELSE 
      IF DATEPART(DAY, @fecvto)= 31
         SET @DifDias = (30 - DATEPART(DAY, @fecini) )
      ELSE
         IF DATEPART(DAY, @fecini)= 31
            SET @DifDias = DATEPART(DAY, @fecvto) - 30 
         ELSE
            SET @DifDias = DATEPART(DAY, @fecvto) - DATEPART(DAY, @fecini)

   SET @DifDias = ( (DATEPART(YEAR,  @fecvto) - DATEPART(YEAR,  @fecini)) * 360)
                + ( (DATEPART(MONTH, @fecvto) - DATEPART(MONTH, @fecini)) * 30) 
                + @DifDias

   SELECT @DifDias

END

GO
