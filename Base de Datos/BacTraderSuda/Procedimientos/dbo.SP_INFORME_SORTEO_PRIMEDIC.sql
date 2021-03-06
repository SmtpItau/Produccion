USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_SORTEO_PRIMEDIC]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INFORME_SORTEO_PRIMEDIC]
   (   @FechaArchivo   DATETIME
   ,   @Usuario        VARCHAR(15) = 'ADMINISTRA'
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @FechaProceso  DATETIME
   ,       @CtaBco        VARCHAR(20)
   ,       @Glosa         VARCHAR(50)

   SELECT  @CtaBco    = Cuenta_Dcv
   ,       @Glosa     = ISNULL(Glosa_Cuenta,'N/D')
   FROM    MdGestion..CUENTAS_DCV
   WHERE   CtaBac     = 'S'

   SELECT  @FechaProceso = acfecproc
   FROM    BacTraderSuda..MDAC

   SELECT SerIns                                as Serie
   ,      FecEve                                as FechaSorteo
   ,      NomSor                                as InformadoUm
   ,      MtoPos                                as InformadoClp
   ,      NomBac                                as CarteraUm
   ,      ISNULL(Cuenta_Dcv,'00-000')           as CtaDcv
   ,      ISNULL(Glosa_Cuenta,'N/D')            as Glosa
   ,      1                                     as Estado 
   ,      CONVERT(NUMERIC(21,4),0.0)            as SorteadoUm
   ,      CONVERT(NUMERIC(21,4),0.0)            as SorteadoClp
   ,      CONVERT(NUMERIC(10,0),0.0)            as Documento
   ,      CONVERT(NUMERIC(10,0),0.0)            as Correlativo
   ,      CONVERT(CHAR(10),@FechaProceso,103)   as FechaProceso
   ,      CONVERT(CHAR(10),GETDATE(),103)       as FechaEmision
   ,      CONVERT(CHAR(10),GETDATE(),108)       as HoraEmision
   ,      @Usuario                              as Usuario
   ,      'RazonSocial' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)
   INTO   #OTRAS_CTAS
   FROM   MdGestion..L043 
          LEFT JOIN MdGestion..CUENTAS_DCV      ON CtaDcv = Cuenta_Dcv
   WHERE  FecCar                = @FechaArchivo 
   AND    NomBac                > 0.0 
   AND    CtaDcv               <> @CtaBco

   IF (SELECT acint_rcc FROM BacTraderSuda..MDAC) = 0
   BEGIN
      IF NOT EXISTS(SELECT 1 FROM MdGestion..SORTEOS_LETRAS_L043 WHERE FechaCarga = @FechaArchivo)
      BEGIN
         DELETE #OTRAS_CTAS
      END
   END

   IF EXISTS(SELECT 1 FROM MdGestion..SORTEOS_LETRAS_L043 WHERE FechaCarga = @FechaArchivo)
   BEGIN

      SELECT cInstser         as SerieInformada
         ,   MIN(nNominalInf) as NominalInformado
         ,   MIN(nPesosInf)   as PesosInformados
      INTO   #INFORMADO
      FROM   MdGestion..SORTEOS_LETRAS_L043 
      WHERE  FechaCarga      = @FechaArchivo
      GROUP BY cInstser

      SELECT cInstser         as SerieSorteada
         ,   SUM(nNominal)    as NominalSorteado
         ,   SUM(nVptirv)     as PesosSorteada
      INTO   #SORTEADOS
      FROM   MdGestion..SORTEOS_LETRAS_L043 
      WHERE  FechaCarga   = @FechaArchivo
      GROUP BY cInstser

      INSERT INTO #OTRAS_CTAS
      SELECT SerieInformada                           as Serie
      ,      FechaSorteo                              as FechaSorteo
      ,      NominalInformado                         as InformadoUm
      ,      PesosInformados                          as InformadoClp
      ,      NominalSorteado                          as CarteraUm
      ,      @CtaBco                                  as CtaDcv
      ,      @Glosa                                   as Glosa
      ,      2                                        as Estado
      ,  ABS(NominalInformado - NominalSorteado)      as SorteadoUm
      ,  ABS(PesosSorteada    - PesosInformados)      as SorteadoClp
      ,      nNumOper                                 as Documento
      ,      nCorrela                                 as Correlativo
      ,      CONVERT(CHAR(10),@FechaProceso,103)      as FechaProceso
      ,      CONVERT(CHAR(10),GETDATE(),103)          as FechaEmision
      ,      CONVERT(CHAR(10),GETDATE(),108)          as HoraEmision
      ,      @Usuario                                 as Usuario
	  ,      'RazonSocial' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)
      FROM   #INFORMADO
             LEFT JOIN #SORTEADOS                     ON SerieInformada = SerieSorteada
            INNER JOIN MdGestion..SORTEOS_LETRAS_L043 ON SerieInformada = cInstser
      WHERE  #INFORMADO.NominalInformado <> #SORTEADOS.NominalSorteado

   END   

   IF NOT EXISTS( SELECT 1 FROM #OTRAS_CTAS)
   BEGIN
      INSERT INTO #OTRAS_CTAS
      SELECT ' '            as Serie
      ,      ' '            as FechaSorteo
      ,      0.0000         as InformadoUm
      ,      0              as InformadoClp
      ,      0.0000         as CarteraUm
      ,      ' '            as CtaDcv
      ,      ' '            as Glosa
      ,      0              as Estado
      ,      0.0000         as SorteadoUm
      ,      0.0000         as SorteadoClp
      ,      0              as Documento
      ,      0              as Correlativo
      ,      CONVERT(CHAR(10),@FechaProceso,103)      as FechaProceso
      ,      CONVERT(CHAR(10),GETDATE(),103)          as FechaEmision
      ,      CONVERT(CHAR(10),GETDATE(),108)          as HoraEmision
      ,      @Usuario                                 as Usuario
	  ,      'RazonSocial' = (SELECT BannerLargo FROM BacParamSuda..Contratos_ParametrosGenerales)
   END

   SELECT * FROM #OTRAS_CTAS ORDER BY Estado

END
GO
