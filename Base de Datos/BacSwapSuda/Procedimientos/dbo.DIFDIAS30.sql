USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[DIFDIAS30]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DIFDIAS30]  
   (   @FechaDesde   DATETIME
   ,   @FechaHasta   DATETIME
   ,   @DifDias30    NUMERIC(21,4) OUTPUT
   )
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @Meses         INTEGER
   ,       @FechaCalculo  DATETIME
   ,       @DifDias       INTEGER

   SELECT  @Meses        = DATEDIFF(MONTH,@FechaDesde,@FechaHasta)
   SELECT  @FechaCalculo = DATEADD(MONTH,@Meses,@FechaDesde)
   SELECT  @DifDias      = DATEDIFF(DAY,@FechaCalculo,@FechaHasta)
   SELECT  @DifDias30    = (@Meses * 30) + @DifDias

END
GO
