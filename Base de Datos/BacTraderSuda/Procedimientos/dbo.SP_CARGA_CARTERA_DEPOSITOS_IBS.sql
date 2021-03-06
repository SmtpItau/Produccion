USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_CARTERA_DEPOSITOS_IBS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CARGA_CARTERA_DEPOSITOS_IBS]
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaAnterior   DATETIME
   SELECT  @dFechaAnterior   = acfecante
   FROM    BacTraderSuda..MDAC

   IF EXISTS( SELECT 1 FROM MdGestion..CAPTACIONES WHERE FechaCarga = @dFechaAnterior )
   BEGIN

      DELETE dbo.CARTERA_DEPOSITOS_IBS

      INSERT INTO dbo.CARTERA_DEPOSITOS_IBS
      SELECT 'NumeroDeposito'   = NumeroDeposito
      ,      'Serie'            = CASE WHEN mncodmon = 999 THEN 'DPF'
                                       WHEN mncodmon = 13  THEN 'DPX'                                       
                                       WHEN mncodmon = 998 THEN 'DPR'
                                  END
                                + CASE WHEN DAY(FechaVcto) <= 9   THEN ' 0' + RTRIM(LTRIM(DAY(FechaVcto)))
                                       ELSE                            ' '  + RTRIM(LTRIM(DAY(FechaVcto)))
                                  END
                                + CASE WHEN MONTH(FechaVcto) <= 9 THEN '0' + RTRIM(LTRIM(MONTH(FechaVcto)))
                                       ELSE                                  RTRIM(LTRIM(MONTH(FechaVcto)))
                                  END
                                + SUBSTRING(LTRIM(RTRIM(YEAR(FechaVcto))),3,2)
      ,      'FechaApertura'    = FechaApertura
      ,      'FechaEmisión'     = FechaEmision
      ,      'FechaVencimiento' = FechaVcto
      ,      'Moneda'           = mncodmon
      ,      'TasaInteres'      = TasaInteres
      ,      'Base'             = Base
      ,      'Plazo'            = Plazo
      ,      'MontoInicial'     = MontoInicial
      ,      'CapitalIniPesos'  = CapitalIniPesos
      ,      'CapitalDia'       = CapitalDia
      ,      'CapitalMonOrig'   = CapitalMonOrig
      ,      'CapitalMasUno'    = CapitalMasUno
      ,      'RutCliente'       = substring(ltrim(rtrim(RutCliente)),1,len(RutCliente)-1)
      ,      'CodCliente'       = 1
      ,      'Libro'            = ''
      ,      'CartNormativa'    = ''
      ,      'SubCart'          = ''
      ,      'CartFinan'        = ''
      ,      'AreaResp'         = ''
      ,      'Relacionado'      = 'N'            
      FROM    MdGestion..CAPTACIONES
              LEFT JOIN BacParamSuda..MONEDA  ON mnnemo = NemoMoneda
      ,       BacTraderSuda..MDAC
      WHERE   NumeroDeposito    IN(SELECT NumeroDeposito FROM MdGestion..MESA)
      AND     FechaCarga        = acfecante 

      UPDATE  dbo.CARTERA_DEPOSITOS_IBS
      SET     CodCliente        = isnull(clcodigo,0)
      FROM    BacParamSuda..CLIENTE
      WHERE   clrut             = RutCliente

   END ELSE
   BEGIN
      SELECT -1 , 'No existen Captaciones Cargadas a la Fecha.-'
      RETURN
   END

END



GO
