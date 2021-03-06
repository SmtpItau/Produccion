USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_GEN_INTERFAZDCV]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_GEN_INTERFAZDCV]
   (   @numdocu   NUMERIC(10)
   ,   @correla   NUMERIC(10)
   )
AS
BEGIN

   SET NOCOUNT ON
   
   DECLARE @RutCorp      NUMERIC(10)
   SELECT  @RutCorp      = acrutprop
   FROM    BacTraderSuda..MDAC

   DECLARE @CtaDcvCorp   VARCHAR(20)

   SELECT  @CtaDcvCorp   = '0000000000'
   SELECT  @CtaDcvCorp   = isnull(Cuenta_Dcv,'0000000000')
   FROM    mdGestion..CUENTAS_DCV
   WHERE   RutCliente    = 97023000
   AND     CodCliente    = 1
   AND     CtaBac        = 'S'


   SELECT Campo000 = CASE WHEN M.morutcli = @RutCorp THEN 'T' ELSE 'M' END
   ,      Campo001 = M.mofecpro
   ,      Campo002 = isnull(substring(C.Cuenta_Dcv,1,5),'00000')
   ,      Campo003 = M.moclave_dcv
   ,      Campo004 = dateadd(day,F.diasvalor,M.mofecpro)
   ,      Campo005 = CASE WHEN M.morutcli  = @RutCorp THEN 'TC' 
                          ELSE 'CV' 
                     END
   ,      Campo006 = CASE WHEN M.morutcli  = @RutCorp THEN '  '
                          WHEN M.motipoper = 'CP'     THEN 'CO' 
                          WHEN M.motipoper = 'VP'     THEN 'VE'     
                     END
   ,      Campo007 = M.moinstser
   ,      Campo008 = E.madurez
   ,      Campo009 = M.monominal
   ,      Campo010 = CASE WHEN M.morutcli  = @RutCorp THEN 0  ELSE 60          END -- E.moneda
   ,      Campo011 = CASE WHEN M.morutcli  = @RutCorp THEN 0  ELSE M.movpresen END
   ,      Campo012 = CASE WHEN M.morutcli  = @RutCorp THEN '' ELSE E.formapago END
   ,      Campo013 = '01011900'
   ,      Campo014 = ''
   ,      Campo015 = CASE WHEN e.Estado = 'P' THEN 'E'
                          WHEN e.Estado = 'E' THEN 'A'
                          WHEN e.Estado = 'R' THEN 'A'
                     END
   ,      Campo016 = '--'
   ,      Campo017 = CASE WHEN e.Estado = 'P' THEN 0
                          WHEN e.Estado = 'E' THEN 1
                          WHEN e.Estado = 'R' THEN 1
                     END
   ,      Campo018 = @CtaDcvCorp
   INTO   #PASO_RETORNO
   FROM   MDMO M
          LEFT JOIN mdGestion..CUENTAS_DCV      C   ON M.morutcli  = C.RutCliente AND M.mocodcli = C.CodCliente
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO F   ON M.moforpagi = F.codigo
          LEFT JOIN OP_ENVIADAS_DCV             E   ON M.monumdocu = E.monumdocu  AND M.mocorrela = E.correla
   WHERE  M.monumdocu = @numdocu
   AND    M.mocorrela = @correla

   SELECT * 
   INTO   #ANULACIONES
   FROM   #PASO_RETORNO  
   WHERE  Campo015 = 'A'

   UPDATE #ANULACIONES SET Campo015 = 'E' , Campo017 = 0

   INSERT INTO #PASO_RETORNO
   SELECT * FROM #ANULACIONES
   
   IF @CtaDcvCorp = '0000000000'
   BEGIN
      SELECT -1 , 'Cuenta Dcv asociada a CorpBanca. No se encuentra definida.'
      RETURN
   END

   IF EXISTS(SELECT 1 FROM #PASO_RETORNO WHERE Campo002 = '00000')
   BEGIN
      SELECT -1 , 'Operación no se puede enviar, No posee Cuenta Dcv de Destino.'
      RETURN
   END ELSE
   BEGIN
      SELECT 0 , * FROM #PASO_RETORNO ORDER BY Campo017
   END

END
--   dbo.SVC_GEN_INTERFAZDCV 54340 , 7




GO
