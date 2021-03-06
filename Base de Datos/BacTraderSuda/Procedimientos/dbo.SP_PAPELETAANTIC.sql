USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETAANTIC]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PAPELETAANTIC]
                  (@xNumeroOperacion NUMERIC(10))
AS
BEGIN
SET NOCOUNT ON
 DECLARE @iplazoOLD INTEGER 
 SELECT @iplazoOLD = DATEDIFF( DAY, fecha_operacion,fecha_vencimiento ) FROM GEN_CAPTACION WHERE numero_operacion = @xnumerooperacion 
 SELECT  'Fecpro'=CONVERT(CHAR(10),mofecpro,103),  --Fecha de Operación(1)
  'Rutcart'=RTRIM(LTRIM(STR(morutcart))+'-'+rcdv), --Rut de Catera(2)
  monumdocu   ,   --Numero de Documento(3)
  mocorrela   ,   --Correlativo Operación(4)
  monumoper   ,   --Numero de Operación(5)
  motipoper   ,   --Tipo de Operación(6)
  movalant   ,   --Nominal(7)  aqui va monto anticipo
  movalinip   ,   --Valor Inicio $$(8)
  motasant   ,   --Tasa Captación(9)
  Tasa_tran   ,   --Tasa Transferencia(10)
  'FechaIni'=CONVERT(CHAR(10),mofecinip,103),  --Fecha de Inicio(11)
  'FechaVcto'=CONVERT(CHAR(10),mofecvenp,103),  --Fecha de Vencimiento(12)
  @iplazoOLD    , 
  monominal   ,   --Valor Inicio(14)
  movalvenp   ,   --Valor Final(15)
  'monpact'=mnnemo  ,   --Moneda de la Operación(16)
  'forpagini'=glosa  ,   --Forma pago Inicio(17)
  'Rutcliente'=RTRIM(LTRIM(STR(morutcli))+'-'+cldv), --Rut de Cliente(18)
  mocodcli   ,   --Codigo de Cliente(19)
   motipret   ,   --Tipo de Retiro(20)
  'custodia'=CASE Custodia 
   WHEN 'P' THEN 'PROPIA'
   WHEN 'C' THEN 'CLIENTE'
   ELSE 'DCV' END,  --Custodia(21)
  mohora    ,   --Hora de la Operación(22)
  mousuario   ,   --Usuario(23)
  moterminal   ,   --Terminal(24)
  'tipodep'=CASE Tipo_Deposito WHEN 'R' THEN 'RENOVABLE'
          ELSE 'FIJO' END, --Tipo de Deposito(25)
  'nomentidad'=rcnombre  ,   --Nombre Entidad(26)
  'nomcliente'=clnombre  ,   --Nombre del Cliente(27)
  'ValorMoneda'=CASE momonpact WHEN 999 THEN 1 
       ELSE ISNULL(vmvalor,0) END, --Valor Unidad Monetaria(28) 
                mostatreg  , -- (29)
  motaspact  , -- (30)
  @iplazoOLD   , -- (31)
  movpressb  , -- (32)  -- Anticipo en UM
  monto_final     -- (33)  
  FROM 
   GEN_CAPTACION ,  
   VIEW_ENTIDAD MDRC  , 
   VIEW_CLIENTE  , 
   VIEW_FORMA_DE_PAGO,
   VIEW_MONEDA,
   MDMO
   LEFT OUTER JOIN VIEW_VALOR_MONEDA ON
   mofecpro = vmfecha AND
   momonpact = vmcodigo	

  WHERE  (motipoper = 'AIC' ) AND
   monumoper = numero_operacion AND
   mocorrela = correla_operacion AND
   monumoper = @xNumeroOperacion AND
   morutcart = rcrut  AND
   morutcli  = clrut  AND
   codigo    = moforpagi  AND
   momonpact = mncodmon
/*  AND
   mofecpro  *= vmfecha  AND
   momonpact *= vmcodigo  
*/
   ORDER BY mocorrela
SET NOCOUNT OFF
END



GO
