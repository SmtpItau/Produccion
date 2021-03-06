USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_SORTEO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_SORTEO]
   (   @FechaArchivo   DATETIME
   ,   @Usuario        VARCHAR(15) = 'ADMINISTRA'
   )
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @FechaProceso  DATETIME
   ,       @iSwitch       INTEGER

   SELECT  @FechaProceso = acfecproc
   ,       @iSwitch      = acint_rcc
   FROM    BacTraderSuda..MDAC

   IF @iSwitch = 1
   BEGIN

      IF EXISTS(SELECT 1 FROM MdGestion..SORTEOS_LETRAS_L043 WHERE FechaCarga = @FechaArchivo)
      BEGIN

         SELECT cInstser         as SerieSorteada
            ,   SUM(nNominal)    as NominalSorteado
            ,   SUM(nVptirv)     as PesosSorteada
         INTO   #SORTEADOS
         FROM   MdGestion..SORTEOS_LETRAS_L043 
         WHERE  FechaCarga   = @FechaArchivo
         GROUP BY cInstser

         SELECT cInstser         as SerieInformada
            ,   MIN(nNominalInf) as NominalInformado
            ,   MIN(nPesosInf)   as PesosInformados
         INTO   #INFORMADO
         FROM   MdGestion..SORTEOS_LETRAS_L043 
         WHERE  FechaCarga   = @FechaArchivo
         GROUP BY cInstser

         SELECT nNumOper        as Operacion
         ,      cInstser        as Serie
         ,      nNumDocu        as Documento
         ,      nCorrela        as Correlativo
         ,      nNominal        as Nominales
         ,      nTir            as Tir
         ,      nVptirv         as Pesos
         ,      FechaSorteo     as FechaSorteos
         ,      nCorrVent       as OrdenVenta
         INTO   #DETALLE
         FROM   MdGestion..SORTEOS_LETRAS_L043 
         WHERE  FechaCarga      = @FechaArchivo

         SELECT 'NumOperacion'   =   #DETALLE.Operacion
         ,      'Instrumento'    =   #DETALLE.Serie
         ,      'Documento'      =   #DETALLE.Documento
         ,      'Correlativo'    =   #DETALLE.Correlativo
         ,      'Nominal'        =   #DETALLE.Nominales
         ,      'Tasa'           =   #DETALLE.Tir
         ,      'Pesos'          =   #DETALLE.Pesos
         ,      'FechaSorteo'    =   CONVERT(CHAR(10),#DETALLE.FechaSorteos,103)
         ,      'SorteoFinalUm'  =   #SORTEADOS.NominalSorteado
         ,      'SorteoFinalPes' =   #SORTEADOS.PesosSorteada
         ,      'InformadoUm'    =   #INFORMADO.NominalInformado
         ,      'InformadoPes'   =   #INFORMADO.PesosInformados
         ,      'DifUm'          =   ABS(#SORTEADOS.NominalSorteado - #INFORMADO.NominalInformado)
         ,      'DifPes'         =   ABS(#SORTEADOS.PesosSorteada   - #INFORMADO.PesosInformados)
         ,      'FechaProceso'   =   CONVERT(CHAR(10),@FechaProceso,103)
         ,      'FechaEmision'   =   CONVERT(CHAR(10),GETDATE(),103)
         ,      'HoraEmision'    =   CONVERT(CHAR(10),GETDATE(),108)
         ,      'Usuario'        =   @Usuario
         FROM   #INFORMADO
             LEFT JOIN #SORTEADOS ON SerieInformada = SerieSorteada
             LEFT JOIN #DETALLE   ON SerieInformada = Serie
         ORDER BY SerieInformada , OrdenVenta   

      END ELSE
      BEGIN

         SELECT 'NumOperacion'   =   0
         ,      'Instrumento'    =   ' '
         ,      'Documento'      =   0.0
         ,      'Correlativo'    =   0.0
         ,      'Nominal'        =   0.0
         ,      'Tasa'           =   0.0
         ,      'Pesos'          =   0.0
         ,      'FechaSorteo'    =   CONVERT(CHAR(10),@FechaArchivo,103)
         ,      'SorteoFinalUm'  =   0.0
         ,      'SorteoFinalPes' =   0.0
         ,      'InformadoUm'    =   0.0
         ,      'InformadoPes'   =   0.0
         ,      'DifUm'          =   0.0
         ,      'DifPes'         =   0.0
         ,      'FechaProceso'   =   CONVERT(CHAR(10),@FechaProceso,103)
         ,      'FechaEmision'   =   CONVERT(CHAR(10),GETDATE(),103)
         ,      'HoraEmision'    =   CONVERT(CHAR(10),GETDATE(),108)
         ,      'Usuario'        =   @Usuario

      END

   END ELSE
   BEGIN
         SELECT 'NumOperacion'   =   0
         ,      'Instrumento'    =   ' '
         ,      'Documento'      =   0.0
         ,      'Correlativo'    =   0.0
         ,      'Nominal'        =   0.0
         ,      'Tasa'           =   0.0
         ,      'Pesos'          =   0.0
         ,      'FechaSorteo'    =   CONVERT(CHAR(10),@FechaArchivo,103)
         ,      'SorteoFinalUm'  =   0.0
         ,      'SorteoFinalPes' =   0.0
         ,      'InformadoUm'    =   0.0
         ,      'InformadoPes'   =   0.0
         ,      'DifUm'          =   0.0
         ,      'DifPes'         =   0.0
         ,      'FechaProceso'   =   CONVERT(CHAR(10),@FechaProceso,103)
         ,      'FechaEmision'   =   CONVERT(CHAR(10),GETDATE(),103)
         ,      'HoraEmision'    =   CONVERT(CHAR(10),GETDATE(),108)
         ,      'Usuario'        =   @Usuario

   END
END



GO
