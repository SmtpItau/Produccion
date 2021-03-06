USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETA_LIMITES]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Objeto:  procedimiento  almacenado dbo.Sp_Papeleta_Limites    fecha de la secuencia de comandos: 05/04/2001 13:13:47 ******/
CREATE PROCEDURE [dbo].[SP_PAPELETA_LIMITES]
     ( @cTipoOperacion  CHAR(05)  ,
     @nOperacion  NUMERIC(10)  ,
     @cSettlement  CHAR(50) OUTPUT ,
     @cPFE   CHAR(50) OUTPUT ,
     @cEmisorInstPlazo CHAR(150) OUTPUT ,
     @cCCE   CHAR(50) OUTPUT )
AS
BEGIN
DECLARE @TotReg   INTEGER
DECLARE @Cont   INTEGER
DECLARE @RutEmisor  NUMERIC(09)
DECLARE @Correla  NUMERIC(03)
DECLARE @xcSettlement   CHAR(50)
DECLARE @xcPFECCE      CHAR(50)
DECLARE @xcEmisorInstPlazo CHAR(255)
DECLARE @xcCodMensajeSet NUMERIC(05)
DECLARE @xcCodMensajePFE NUMERIC(05)
DECLARE @xcCodMensajeCCE NUMERIC(05)
DECLARE @xCodigoEMIPLZ  NUMERIC(05)
DECLARE @xMonto   NUMERIC(19)
DECLARE @cFormato  CHAR(70)
DECLARE @xMontoPFECCE  NUMERIC(19)
DECLARE @xMontoSETTLE  NUMERIC(19)
IF @cTipoOperacion <> 'BFW' AND @cTipoOperacion <> 'BCC' BEGIN
 SELECT @Cont   = 1
 SELECT @TotReg = COUNT(*) FROM mdmo WHERE monumoper = @nOperacion AND
        motipoper = @cTipoOperacion
 WHILE @Cont <= @TotReg
 BEGIN
  SET ROWCOUNT @Cont
  SELECT  @Correla = mocorrela  
  FROM MDMO
  WHERE monumoper = @nOperacion AND
   motipoper = @cTipoOperacion 
  SET ROWCOUNT 0
  SELECT @Cont = @Cont + 1
  IF RTRIM(@cTipoOperacion) = 'CP' OR @cTipoOperacion = 'IB' BEGIN
   --SELECT @xMonto = ROUND(Monto_Exceso * @Dolar,0),
                 SELECT @xMonto = Monto_Exceso,
          @xCodigoEMIPLZ = Codigo_exceso
      FROM MD_EXCESO_LIMITES 
      WHERE Operacion = @nOperacion AND
       tipo_operacion = @cTipoOperacion AND
       Correlativo = @Correla AND
       Tipo_Limites = 'EMIPLZ' 
   EXECUTE SP_FORMAT @xMonto , @cFormato OUTPUT
 
   IF @cFormato = '0' BEGIN
    SELECT @cFormato = ' ' + Mensaje FROM MD_MENSAJE_LIMITES WHERE codigo = @xCodigoEMIPLZ
   END ELSE BEGIN
    SELECT @cFormato = ':excedido ' + @cFormato
   END
   SELECT @xcEmisorInstPlazo = @xcEmisorInstPlazo + ' ' + RTRIM(emgeneric) + @cFormato 
      FROM MD_EXCESO_LIMITES
--  REQ. 7619        
--       , VIEW_EMISOR 
         , mdmo LEFT OUTER JOIN VIEW_EMISOR ON morutemi = emrut
      WHERE monumoper = @nOperacion AND
       motipoper = @cTipoOperacion AND
       mocorrela = @Correla AND
       Operacion = @nOperacion AND
       tipo_operacion = @cTipoOperacion AND
       correlativo = @Correla AND
       tipo_limites = 'EMIPLZ' 
--  REQ. 7619
--  morutemi *= emrut      
  END
   
  SELECT @xMontoSETTLE  = (SELECT SUM(Monto_Exceso) FROM MD_EXCESO_LIMITES
     WHERE Operacion = @nOperacion AND
      tipo_operacion = @cTipoOperacion AND
      Tipo_Limites = 'SETTLE' ),
         @xcCodMensajeSet = Codigo_Exceso 
     FROM MD_EXCESO_LIMITES
     WHERE operacion = @nOperacion AND
      tipo_operacion  = @cTipoOperacion AND
      tipo_limites = 'SETTLE' 
  IF @xMontoSETTLE IS NOT NULL AND @xMontoSETTLE > 0 BEGIN
   EXECUTE SP_FORMAT @xMontoSETTLE , @cFormato OUTPUT
   SELECT @cSettlement = @cFormato
  END ELSE BEGIN
   SELECT @xcSettlement = NULL 
  END
  SELECT @xMonto  = 0.0
  SELECT @xMonto   = Monto_Exceso,
                       @xcCodMensajePFE = Codigo_Exceso 
  FROM MD_EXCESO_LIMITES
  WHERE operacion = @nOperacion  AND
   tipo_operacion = @cTipoOperacion AND
   tipo_limites = 'PFECCE'  AND
   (Codigo_Exceso  = 1 OR Codigo_Exceso = 3)
   IF @xMonto IS NOT NULL AND @xMonto > 0 BEGIN
   EXECUTE SP_FORMAT @xMonto, @cFormato OUTPUT
   SELECT @cPFE = @cFormato
  END 
  ELSE  SELECT @cPFE = NULL 
  SELECT @xMonto  = 0.0
  SELECT @xMonto   = Monto_Exceso,
                       @xcCodMensajeCCE = Codigo_Exceso 
  FROM MD_EXCESO_LIMITES
  WHERE Operacion = @nOperacion  AND
   tipo_operacion = @cTipoOperacion AND
   tipo_limites = 'PFECCE'  AND
   (Codigo_Exceso  = 4 OR Codigo_Exceso = 2)
   IF @xMonto IS NOT NULL AND @xMonto > 0 BEGIN
   EXECUTE SP_FORMAT @xMonto, @cFormato OUTPUT
   SELECT @cCCE = @cFormato
  END 
  ELSE  SELECT @cCCE = NULL 
 END
END
IF @cTipoOperacion = 'BCC' BEGIN
 SELECT @cTipoOperacion = (CASE 
      WHEN motipmer = 'PTAS' AND motipope = 'C' THEN 'CSB'
      WHEN motipmer = 'PTAS' AND motipope = 'V' THEN 'VSB'
      WHEN motipmer = 'EMPR' AND motipope = 'C' THEN 'CSE'
      WHEN motipmer = 'EMPR' AND motipope = 'V' THEN 'VSE'
     END)
 FROM VIEW_MEMO
 WHERE monumope = @nOperacion
 SELECT @xMontoSETTLE  = Monto_Exceso,
        @xcCodMensajeSet = Codigo_Exceso 
 FROM MD_EXCESO_LIMITES
 WHERE operacion = @nOperacion AND
  tipo_operacion  = @cTipoOperacion AND
  tipo_limites = 'SETTLE' AND
  id_sistema =  'BCC'
 IF @xMontoSETTLE IS NOT NULL AND @xMontoSETTLE > 0 BEGIN
  EXECUTE SP_FORMAT @xMontoSETTLE , @cFormato OUTPUT
  SELECT @cSettlement = @cFormato
 END 
 ELSE  SELECT @cSettlement = NULL 
END
IF @cTipoOperacion = 'BFW' BEGIN
 SELECT @cTipoOperacion = CONVERT(CHAR(1),mocodpos1) + motipoper
  FROM VIEW_MFMO
  WHERE monumoper = @nOperacion 
                SELECT @xMonto  = NULL
  SELECT @xMonto  = Monto_Exceso,
                   @xcCodMensajePFE = Codigo_Exceso 
  FROM    MD_EXCESO_LIMITES
  WHERE operacion = @nOperacion AND
   tipo_operacion = @cTipoOperacion AND
   tipo_limites = 'PFECCE' AND
   (Codigo_Exceso  = 1 OR Codigo_Exceso = 3)
  IF @xMonto IS NOT NULL AND @xMonto > 0 BEGIN
   EXECUTE SP_FORMAT @xMonto , @cFormato OUTPUT
   SELECT @cPFE = @cFormato
  END 
  ELSE  SELECT @cPFE = NULL 
 
                SELECT @xMonto  = NULL
  SELECT @xMonto  = Monto_Exceso,
                   @xcCodMensajeCCE = Codigo_Exceso 
  FROM    MD_EXCESO_LIMITES
  WHERE operacion = @nOperacion AND
   tipo_operacion = @cTipoOperacion AND
   tipo_limites = 'PFECCE' AND
   (Codigo_Exceso  = 2 OR Codigo_Exceso = 4)
  IF @xMonto IS NOT NULL AND @xMonto > 0 BEGIN
   EXECUTE SP_FORMAT @xMonto , @cFormato OUTPUT
   SELECT @cCCE = @cFormato
  END 
  ELSE SELECT @cCCE = NULL 
 
END
IF @cSettlement IS NULL SELECT @cSettlement  = ISNULL((SELECT mensaje FROM MD_MENSAJE_LIMITES WHERE codigo = @xcCodMensajeSet ),'<OK>')
IF @cPFE   IS NULL SELECT @cPFE         = ISNULL((SELECT mensaje FROM MD_MENSAJE_LIMITES WHERE codigo = @xcCodMensajePFE ),'<OK>')
IF @cCCE IS NULL SELECT @cCCE         = ISNULL((SELECT mensaje FROM MD_MENSAJE_LIMITES WHERE codigo = @xcCodMensajeCCE ),'<OK>')
SELECT @cEmisorInstPlazo = ISNULL(@xcEmisorInstPlazo,'<OK>')
END


GO
