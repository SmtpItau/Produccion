USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_BIDASK]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_BIDASK]
   (   @Moneda       CHAR(3)
   ,   @CodPeriodo   CHAR(6)
   ,   @Bid          FLOAT
   ,   @Ask          FLOAT
   ,   @factor       NUMERIC(10,0)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @FechaProc DATETIME
       SET @FechaProc = (SELECT acfecproc FROM MFAC)

   DECLARE @iMoneda   INT
       SET @iMoneda   = ISNULL( (SELECT mncodmon FROM BacParamSuda..MONEDA WHERE mnnemo = @Moneda), 0)

   IF @iMoneda = 0
   BEGIN
      SELECT -1
      RETURN -1
   END

   DECLARE @iPeriodo  INT
       SET @iPeriodo  = (SELECT pecodigo FROM BacParamSuda..PERIODO_TASA_BIDASK WHERE peperiodo = SUBSTRING(@CodPeriodo,4,3) )

--       SET @iPeriodo  = (SELECT pecodigo FROM BacParamSuda..PERIODO_TASA_BIDASK WHERE peperiodo = @CodPeriodo )

   IF EXISTS(SELECT 1 FROM MFBIDASK WHERE Fecha = @FechaProc AND moneda = @iMoneda AND Periodo = @iPeriodo)
   BEGIN
      UPDATE MFBIDASK
         SET bid     = @Bid
           , ask     = @Ask
           , factor  = @factor
       WHERE fecha   = @FechaProc 
         AND moneda  = @iMoneda
         AND periodo = @iPeriodo
   END ELSE
   BEGIN
      INSERT INTO MFBIDASK
      (   moneda 
      ,   fecha
      ,   periodo
      ,   bid
      ,   ask
      ,   factor
      )
      VALUES
      (   @iMoneda
      ,   @FechaProc
      ,   @iPeriodo
      ,   @Bid
      ,   @Ask
      ,   @factor
      )
   END

END


GO
