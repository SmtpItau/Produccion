USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[VALIDACIÓN_SORTEO_L043]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[VALIDACIÓN_SORTEO_L043]
   (   @FechaArchivo   DATETIME    = ''   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound   INTEGER
   ,       @CtaBanco VARCHAR(50)

   SELECT  @iFound    = -3
   SELECT  @CtaBanco  = Cuenta_Dcv
   ,       @iFound    = 0
   FROM    MdGestion..CUENTAS_DCV 
   WHERE   RutCliente = 97023000
   AND     CodCliente = 1
   AND     CtaBac     = 'S'

   IF @iFound = -3
   BEGIN
      SELECT -3 , 'No Existe Ninguna Cuenta Dcv Registrada Como Cuenta del Banco.'
      RETURN -3
   END   

   SELECT  @iFound = -1
   SELECT  @iFound = 0
   FROM    MdGestion..L043
   WHERE   FecCar  = @FechaArchivo
   AND     NomBac  > 0.0

   IF @iFound = -1
   BEGIN
      SELECT -1 , 'No Existe Información de Sorteos Cargados a la Fecha.'
      RETURN -1
   END

   SELECT  @iFound = -2
   SELECT  @iFound = 0
   FROM    MdGestion..L043
   WHERE   FecCar  = @FechaArchivo
   AND     NomBac  > 0.0
   AND     CtaDcv  = @CtaBanco

   IF @iFound = -2
   BEGIN
      SELECT -2 , 'No Existen Cuentas Dcv Relacionadas Para el Archivo Cargado a la Fecha '
      RETURN -2
   END

   SELECT 0 , 'Información Para Cargar ' + LTRIM(RTRIM(COUNT(1))) + ' Sorteos Asociados a la Cuenta DCV.'
   FROM    MdGestion..L043
   WHERE   FecCar  = @FechaArchivo
   AND     NomBac  > 0.0
   AND     CtaDcv  = @CtaBanco

   

END

GO
