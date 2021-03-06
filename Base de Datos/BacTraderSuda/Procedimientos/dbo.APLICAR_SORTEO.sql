USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[APLICAR_SORTEO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[APLICAR_SORTEO]
   (   @Feha      DATETIME
   ,   @Usuario   VARCHAR(12)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nNumOper   	        NUMERIC(10,0)
   ,       @nRutCart   	        NUMERIC(09,0)
   ,       @nTipCart   	        NUMERIC(05,0)
   ,       @nNumDocu   	        NUMERIC(10,0)
   ,       @nCorrela   	        NUMERIC(03,0)
   ,       @nNominal   	        NUMERIC(19,4)
   ,       @nTir       	        NUMERIC(19,4)
   ,       @nPvp       	        NUMERIC(19,2)
   ,       @nVpar      	        NUMERIC(19,8)
   ,       @nVptirv    	        FLOAT
   ,       @nNumuCup   	        NUMERIC(03,0)
   ,       @nRutCli    	        NUMERIC(09,0)
   ,       @nCodCli    	        NUMERIC(09,0)
   ,       @cFecPro    	        DATETIME
   ,       @nTasEst    	        NUMERIC(09,4)
   ,       @nMonemi    	        NUMERIC(03,0)
   ,       @nRutEmi    	        NUMERIC(09,0)
   ,       @nTasEmi    	        NUMERIC(09,4)
   ,       @nBasemi    	        NUMERIC(03,0)
   ,       @cTipCust   	        CHAR(01)
   ,       @nForPagi   	        NUMERIC(05,0)
   ,       @cRetiro    	        CHAR(01)
   ,       @cUsuario   	        CHAR(12)
   ,       @cTerminal  	        CHAR(12)
   ,       @cMascara   	        CHAR(12)
   ,       @cInstser   	        CHAR(12)
   ,       @cGenemi   	        CHAR(10)
   ,       @cNemoMon   	        CHAR(05)
   ,       @cFecEmi   	        DATETIME
   ,       @cFecVen   	        DATETIME
   ,       @nCodigo   	        NUMERIC(05,0)
   ,       @nCorrVent           INTEGER
   ,       @ClaveDcv            CHAR(10)
   ,       @nCarteraSuper       CHAR(01)
   ,       @nCarteraFinanciera  CHAR(01)
   ,       @nMercado   	        CHAR(01)
   ,       @Sucursal   	        VARCHAR(05)
   ,       @Sistema             CHAR(03)
   ,       @FechaPagoMañana     DATETIME
   ,       @Laminas   	        CHAR(01)
   ,       @TipoInversion       CHAR(01)
   ,       @Observ    	        CHAR(70)
   ,       @IdLibro		CHAR(06)
   ,       @FechaSorteo         DATETIME
   ,       @VctoReal            DATETIME

   DECLARE @iCantSorteos   INTEGER
   ,       @iEnviando      INTEGER   

   SELECT  @iCantSorteos   = MAX(Puntero)
   ,       @iEnviando      = MIN(Puntero)
   FROM    MdGestion..SORTEOS_LETRAS_L043

   WHILE   @iCantSorteos >= @iEnviando
   BEGIN

      SELECT  @nNumOper   	   = nNumOper
      ,       @nRutCart   	   = nRutCart
      ,       @nTipCart   	   = nTipCart
      ,       @nNumDocu   	   = nNumDocu
      ,       @nCorrela   	   = nCorrela
      ,       @nNominal   	   = nNominal
      ,       @nTir       	   = nTir
      ,       @nPvp       	   = nPvp
      ,       @nVpar      	   = nVpar
      ,       @nVptirv    	   = nVptirv
      ,       @nNumuCup   	   = nNumuCup
      ,       @nRutCli    	   = nRutCli
      ,       @nCodCli    	   = nCodCli
      ,       @cFecPro    	   = cFecPro
      ,       @nTasEst    	   = nTasEst
      ,       @nMonemi    	   = nMonemi
      ,       @nRutEmi    	   = nRutEmi
      ,       @nTasEmi    	   = nTasEmi
      ,       @nBasemi    	   = nBasemi
      ,       @cTipCust   	   = cTipCust
      ,       @nForPagi   	   = nForPagi
      ,       @cRetiro    	   = cRetiro
      ,       @cUsuario   	   = cUsuario
      ,       @cTerminal  	   = cTerminal
      ,       @cMascara   	   = cMascara
      ,       @cInstser   	   = cInstser
      ,       @cGenemi   	   = cGenemi
      ,       @cNemoMon   	   = cNemoMon
      ,       @cFecEmi   	   = cFecEmi
      ,       @cFecVen   	   = cFecVen
      ,       @nCodigo   	   = nCodigo
      ,       @nCorrVent           = nCorrVent
      ,       @ClaveDcv            = ClaveDcv
      ,       @nCarteraSuper       = nCarteraSuper
      ,       @nCarteraFinanciera  = nCarteraFinanciera
      ,       @nMercado   	   = nMercado
      ,       @Sucursal   	   = Sucursal
      ,       @Sistema             = Sistema
      ,       @FechaPagoMañana     = FechaPagoMañana
      ,       @Laminas   	   = Laminas
      ,       @TipoInversion       = TipoInversion
      ,       @Observ    	   = Observ
      ,       @IdLibro		   = IdLibro
      ,       @FechaSorteo         = FechaSorteo
      ,       @VctoReal            = VctoReal
      FROM    MdGestion..SORTEOS_LETRAS_L043
      WHERE   Puntero              = @iEnviando

      EXECUTE BacTraderSuda..SP_GRABARST
              @nNumOper
      ,       @nRutCart
      ,       @nTipCart
      ,       @nNumDocu
      ,       @nCorrela
      ,       @nNominal
      ,       @nTir
      ,       @nPvp
      ,       @nVpar
      ,       @nVptirv
      ,       @nNumuCup
      ,       @nRutCli
      ,       @nCodCli
      ,       @cFecPro
      ,       @nTasEst
      ,       @nMonemi
      ,       @nRutEmi
      ,       @nTasEmi
      ,       @nBasemi
      ,       @cTipCust
      ,       @nForPagi
      ,       @cRetiro
      ,       @cUsuario
      ,       @cTerminal
      ,       @cMascara
      ,       @cInstser
      ,       @cGenemi
      ,       @cNemoMon
      ,       @cFecEmi
      ,       @cFecVen
      ,       @nCodigo
      ,       @nCorrVent
      ,       @ClaveDcv
      ,       @nCarteraSuper
      ,       @nCarteraFinanciera
      ,       @nMercado
      ,       @Sucursal
      ,       @Sistema
      ,       @FechaPagoMañana
      ,       @Laminas
      ,       @TipoInversion
      ,       @Observ
      ,       @IdLibro
      ,       @FechaSorteo
      ,       @VctoReal

      IF @@ERROR <> 0
      BEGIN
         RETURN -1
      END

      UPDATE MdGestion..SORTEOS_LETRAS_L043
      SET    Enviado = 'S'
      WHERE  Puntero = @iEnviando

      SET @iEnviando = @iEnviando + 1
   END

   UPDATE BacTraderSuda..MDAC SET acint_rcc = 1

   SELECT 0 , 'Aplicación de Sorteos de Letras ha Finalizado Correctamente.'

END

GO
