USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MS165]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_MS165]
AS
BEGIN

   DECLARE @PCX_Propia         NUMERIC(19,4),
           @PCX_Intermediados  NUMERIC(19,4),
           @PCX_Compra_Pacto   NUMERIC(19,4),
           @XERO_Propia        NUMERIC(19,4),
           @XERO_Intermediados NUMERIC(19,4),
           @XERO_Compra_Pacto  NUMERIC(19,4),
           @BCX_Propia         NUMERIC(19,4),
           @BCX_Intermediados  NUMERIC(19,4),
           @BCX_Compra_Pacto   NUMERIC(19,4)

   SET NOCOUNT ON

   CREATE TABLE #TEMP( PCX_Propia         NUMERIC(19,4),
                       PCX_Intermediados  NUMERIC(19,4),
                       PCX_Compra_Pacto   NUMERIC(19,4),
                       XERO_Propia        NUMERIC(19,4),
                       XERO_Intermediados NUMERIC(19,4),
                       XERO_Compra_Pacto  NUMERIC(19,4),
                       BCX_Propia         NUMERIC(19,4),
                       BCX_Intermediados  NUMERIC(19,4),
                       BCX_Compra_Pacto   NUMERIC(19,4) )

   SELECT @PCX_Propia = ISNULL( SUM(CPNOMINAL), 0 )
   FROM MDCP, VIEW_INSTRUMENTO
   WHERE CPCODIGO = INCODIGO AND INSERIE = 'PCX'

   SELECT @PCX_Intermediados = ISNULL( SUM(VINOMINAL), 0 )
   FROM MDVI, VIEW_INSTRUMENTO
   WHERE VICODIGO = INCODIGO AND INSERIE = 'PCX'

   SELECT @PCX_Compra_Pacto = ISNULL( SUM(CINOMINAL), 0 )
   FROM MDCI, VIEW_INSTRUMENTO
   WHERE CICODIGO = INCODIGO AND INSERIE = 'PCX'


   SELECT @XERO_Propia = ISNULL( SUM(CPNOMINAL), 0 )
   FROM MDCP, VIEW_INSTRUMENTO
   WHERE CPCODIGO = INCODIGO AND INSERIE = 'XERO'

   SELECT @XERO_Intermediados = ISNULL( SUM(VINOMINAL), 0 )
   FROM MDVI, VIEW_INSTRUMENTO
   WHERE VICODIGO = INCODIGO AND INSERIE = 'XERO'

   SELECT @XERO_Compra_Pacto = ISNULL( SUM(CINOMINAL), 0 )
   FROM MDCI, VIEW_INSTRUMENTO
   WHERE CICODIGO = INCODIGO AND INSERIE = 'XERO'


   SELECT @BCX_Propia = ISNULL( SUM(CPNOMINAL), 0 )
   FROM MDCP, VIEW_INSTRUMENTO
   WHERE CPCODIGO = INCODIGO AND INSERIE = 'BCX' 

   SELECT @BCX_Intermediados = ISNULL( SUM(VINOMINAL), 0 )
   FROM MDVI, VIEW_INSTRUMENTO
   WHERE VICODIGO = INCODIGO AND INSERIE = 'BCX'

   SELECT @BCX_Compra_Pacto = ISNULL( SUM(CINOMINAL), 0 )
   FROM MDCI, VIEW_INSTRUMENTO
   WHERE CICODIGO = INCODIGO AND INSERIE = 'BCX'

   INSERT INTO #TEMP (PCX_Propia, PCX_Intermediados, PCX_Compra_Pacto, XERO_Propia, XERO_Intermediados, XERO_Compra_Pacto, BCX_Propia, BCX_Intermediados, BCX_Compra_Pacto )
        VALUES(@PCX_Propia, @PCX_Intermediados, @PCX_Compra_Pacto, @XERO_Propia, @XERO_Intermediados, @XERO_Compra_Pacto, @BCX_Propia, @BCX_Intermediados, @BCX_Compra_Pacto )

   SET NOCOUNT OFF

   SELECT *, 'Fec_Hoy' = CONVERT(CHAR(10),ACFECPROC,103) FROM #TEMP, MDAC, BacParamSuda..Contratos_ParametrosGenerales


END

-- select acnomprop,* from mdac

-- select RazonSocial,* from BacParamSuda..Contratos_ParametrosGenerales

GO
