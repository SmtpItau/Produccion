USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_CHEQUEARGRABAR]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_CHEQUEARGRABAR]
   (   @dFecPro         DATETIME  
   ,   @cSistema CHAR(03)  
   ,   @cProducto CHAR(05)  
   ,   @nNumoper NUMERIC(10)  
   ,   @nNumdocu NUMERIC(10,0)  
   ,   @nCorrela NUMERIC(10,0)  
   ,   @nRutcli         NUMERIC(09,0)  
   ,   @nCodigo         NUMERIC(09,0)  
   ,   @nMonto  NUMERIC(19,4)  
   ,   @fTipcambio NUMERIC(08,4)  
   ,   @dFecvctop DATETIME  
   ,   @cUsuario CHAR(15)  
   ,   @nRut_emisor NUMERIC(9)  
   ,   @nMonedaEmision  NUMERIC(3)  
   ,   @dFecvctoInst DATETIME  
   ,   @nInCodigo NUMERIC(05)  
   ,   @cSeriado CHAR(1)  
   ,   @nMonedaOp NUMERIC(05)  
   ,   @cTipo_Riesgo CHAR(1)  
   ,   @nCodigo_pais NUMERIC(05)  
   ,   @cPagoCheque CHAR(1)  
   ,   @nRutCheque NUMERIC(09,0)  
   ,   @dFecvctoCehque  DATETIME  
   ,   @nFactorVenta NUMERIC(19,8)  
   ,   @formapago NUMERIC(3)  
   ,   @nTir  FLOAT  
   ,   @nTasaPact FLOAT  
   ,   @cInstser CHAR(12)  
   ,   @Avr             numeric(15) = 0    
   ,   @PrcLCR          float       = 0  
   ,   @Resultado       float       = 0  
   ,   @MetodoLCR	numeric(5)  = 0
   ,   @Garantia        float       = 0
   )  
AS  
BEGIN  
  
SET NOCOUNT ON

DECLARE @Tiene_Rela numeric(1)  
declare @nRutcliAux numeric(13)
declare @nCodigoAux numeric(5)
declare @EsDRV      varchar(5)
select  @nRutcliAux = @nRutcli
select  @nCodigoAux = @nCodigo
  
  
set @EsDRV = ''
select @EsDRV = Id_Grupo from TBL_AGRPROD where Id_sistema = @cSistema
if @EsDRV <> 'DRV'
   Select @MetodoLCR = 1 
else 
BEGIN
    If @MetodoLCR = 0 
    BEGIN
      select @MetodoLCR = BacLineas.dbo.FN_RIEFIN_METODO_LCR(@nRutcli, @ncodigo, @nRutcli, @ncodigo)
    END
    select @MetodoLCR = case when @MetodoLCR = 0 then 1 else @MetodoLCR end
 --  Por si biene del recálculo 
END
CREATE TABLE #Salida( Resultado  Float ) 
INSERT INTO #Salida 
EXECUTE bacparamsuda.dbo.SP_RIEFIN_GARANTIA @nRutcli, @nCodigo,@MetodoLCR, @cSistema, @nNumoper  
select @Garantia = resultado from #Salida

--SET @Tiene_Rela = (SELECT Afecta_Lineas_Hijo FROM CLIENTE_RELACIONADO WHERE clrut_hijo = @nRutcli AND clcodigo_hijo = @nCodigo)   
--IF @Tiene_Rela = 0   
--BEGIN  
   --IF EXISTS(SELECT 1 FROM CLIENTE_RELACIONADO WHERE clrut_hijo = @nRutcli AND clcodigo_hijo = @nCodigo)  
   --BEGIN  
      --SELECT @nRutcli        = clrut_padre  
      --,      @nCodigo        = clcodigo_padre  
      --FROM   CLIENTE_RELACIONADO  
      --WHERE  clrut_hijo      = @nRutcli  
     -- AND    clcodigo_hijo   = @nCodigo  
   --END  
--END  
  
  
   INSERT INTO LINEA_CHEQUEAR  
   (   FechaOperacion  
   ,   NumeroOperacion  
   ,   Numerodocumento  
   ,   NumeroCorrelativo  
   ,   Rut_Cliente  
   ,   Codigo_Cliente  
   ,   Id_Sistema  
   ,   Codigo_Producto  
   ,   MontoTransaccion  
   ,   TipoCambio  
   ,   FechaVencimiento  
   ,   Operador  
   ,   Rut_Emisor  
   ,   Moneda_Emision  
   ,   FechaVctoInst  
   ,   InCodigo  
   ,   Seriado  
   ,   MonedaOperacion  
   ,   Tipo_Riesgo  
   ,   codigo_pais  
   ,   Pago_Cheque  
   ,   Rut_Cheque  
   ,   FechaVctoCheque  
   ,   FactorVenta  
   ,   FormaPago  
   ,   Tir  
   ,   TasaPacto  
   ,   Instser  
   ,   Avr  
   ,   PrcLCR  
   ,   Resultado   
   ,   MetodoLCR     -- PRD8800
   ,   Garantia      -- PRD8800
   )  
   VALUES  
   (   @dFecPro  
   ,   @nNumoper  
   ,   Case when @nNumdocu = 0 then @nNumoper else @nNumdocu end -- Swap para met 1 o 4 no consulta al trader los errores de lineas  
   ,   @nCorrela  
   ,   @nRutcli  
   ,   @nCodigo  
   ,   @cSistema  
   ,   @cProducto  
   ,   @nMonto  
   ,   @fTipcambio  
   ,   @dFecvctop  
   ,   @cUsuario  
   ,   @nRut_emisor  
   ,   @nMonedaEmision  
   ,   @dFecvctoInst  
   ,   @nInCodigo  
   ,   @cSeriado  
   ,   @nMonedaOp  
   ,   @cTipo_Riesgo  
   ,   @nCodigo_pais  
   ,   @cPagoCheque  
   ,   @nRutCheque  
   ,   @dFecvctoCehque  
   ,   @nFactorVenta  
   ,   @formapago  
   ,   @nTir  
   ,   @nTasaPact  
   ,   @cInstser  
   ,   @Avr  
   ,   @PrcLCR  
   ,   @Resultado   
   ,   @MetodoLCR                -- PRD8800
   ,   @Garantia                 -- PRD8800
   )  
  SET NOCOUNT OFF
END
--> +++ cvegasan 2017.08.08 Control Lineas IDD
GO
