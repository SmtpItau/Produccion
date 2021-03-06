USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALIZA_ORIGEN_CURVA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_ACTUALIZA_ORIGEN_CURVA]
   (   @FechaValorizacion   DATETIME
   ,   @Serie               VARCHAR(20)
   ,   @EmGeneric           VARCHAR(10)
   ,   @TipoCurva           CHAR(2)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @RutEmisor   NUMERIC(10)
       SET @RutEmisor   = (SELECT TOP 1 emrut FROM BacParamSuda..EMISOR WHERE emgeneric = @EmGeneric AND emcodigo = 1)

   UPDATE VALORIZACION_MERCADO
      SET OrigenCurva        = @TipoCurva
    WHERE fecha_valorizacion = @FechaValorizacion
      AND rminstser          = @Serie
      AND rut_emisor         = @RutEmisor

END




GO
