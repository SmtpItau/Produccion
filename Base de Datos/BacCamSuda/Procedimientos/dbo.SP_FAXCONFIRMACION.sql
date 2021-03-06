USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FAXCONFIRMACION]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FAXCONFIRMACION]
       (
        @nNumOper FLOAT
       )
AS
BEGIN
SET NOCOUNT ON
 
  DECLARE @cTraCon     CHAR ( 40 )
   DECLARE @cVendedor   CHAR ( 70 )
   DECLARE @cFaxVen     CHAR ( 20 )
   DECLARE @cOpeVen     CHAR ( 40 )
   DECLARE @cComprador  CHAR ( 70 )
   DECLARE @cFaxCom     CHAR ( 20 )
   DECLARE @cOpeCom     CHAR ( 40 )
   DECLARE @cTipOpe     CHAR ( 10 )
   DECLARE @nPreSpt     NUMERIC ( 16, 10 )
   DECLARE @nObsIni     NUMERIC ( 08, 02 )
   DECLARE @nUFIni      NUMERIC ( 08, 02 )
   DECLARE @dFecIni     DATETIME
   DECLARE @nCodMon     NUMERIC ( 03, 00 )
   DECLARE @nCodCnv     NUMERIC ( 03, 00 )
   DECLARE @cCodMon     CHAR ( 03 )
   DECLARE @cCodCnv     CHAR ( 03 )
   DECLARE @nPagoMx     NUMERIC ( 05, 00 )
   DECLARE @cPagoMx     CHAR ( 10 )
   DECLARE @cModalidad  CHAR ( 14 )
   DECLARE @cFirCom     CHAR ( 40 )
   DECLARE @cFirVen     CHAR ( 40 )
   DECLARE @nPreFut     NUMERIC ( 16, 10 )
   DECLARE @cNomprop    CHAR(50)
   DECLARE @diasvalor  INTEGER
   DECLARE @feriado    INTEGER
   DECLARE @cfecvaluta  DATETIME
   DECLARE @pais       INTEGER
   SELECT @pais    = acpais
   FROM   mfac
  
   SELECT @cNomprop = rcnombre from VIEW_ENTIDAD
   SELECT @dFecIni  = CaFecha  FROM mfca WHERE canumoper = @nNumOper
   SELECT @nObsIni = ISNULL ( VmValor, 0 ) FROM VIEW_VALOR_MONEDA WHERE VmCodigo = 994 AND VmFecha = @dFecIni
   SELECT @nUFIni  = ISNULL ( VmValor, 0 ) FROM VIEW_VALOR_MONEDA WHERE VmCodigo = 998 AND VmFecha = @dFecIni
   SELECT @cTraCon    = ISNULL ( a.OpNombre, '' ),
          @cVendedor  = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN ClNombre         ELSE @cNomprop          END ), '' ) ,
          @cFaxVen    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN ClFax            ELSE AcFax              END ), '' ) ,
          @cOpeVen    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN @cTraCon         ELSE b.nombre           END ), '' ) ,
          @cComprador = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN @cNomprop        ELSE ClNombre           END ), '' ) ,
          @cFaxCom    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN AcFax            ELSE ClFax              END ), '' ) ,
          @cOpeCom    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN b.nombre         ELSE @cTraCon           END ), '' ) ,
          @cTipOpe    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN 'COMPRA    '     ELSE 'VENTA     '       END ), '' ) ,
          @nPreSpt    = ISNULL ( ( CASE CaCodMon2 WHEN 999 THEN @nObsIni         ELSE @nObsIni / @nUFIni END ), 0  ) ,
          @nCodMon    = ISNULL ( CaCodMon1, 0 )          ,
          @nCodCnv    = ISNULL ( CaCodMon2, 0 )          ,
          @nPagoMx    = ISNULL ( CaFPagoMx, 0 )          ,
          @cModalidad = ISNULL ( ( CASE CaTipModa WHEN 'C' THEN 'COMPENSACION  ' ELSE 'ENTREGA FISICA'   END ), '' ) ,
          @cFirCom    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN @cNomprop        ELSE ''                 END ), '' ) ,
          @cFirVen    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN ''               ELSE @cNomprop          END ), '' ) ,
          @nPreFut    = ISNULL ( ( CASE CaCodPos1 WHEN 3   THEN CaPreMon2        ELSE CaParMon2          END ), 0 ) ,
		  @cfecvaluta = cafecvcto           
   	FROM MFCA LEFT OUTER JOIN VIEW_CLIENTE_OPERADOR a ON CaCodigo = a.OpRutCli and CaContraparte = a.OpRutOpe
			   LEFT OUTER JOIN VIEW_USUARIO b ON CaOperador = b.usuario ,
		 VIEW_CLIENTE,
		 MFAC 
	WHERE
          CaNumOper      = @nNumOper  AND
         (CaCodigo       = ClRut      AND    cacodcli       = clcodigo )   


 /* -->Req.7619 CASS 04-01-2010 ESTE PROCEDIMIENTO NO SE UTILIZA.
	FROM
          MFCA,
          VIEW_CLIENTE,
          MFAC,
          VIEW_CLIENTE_OPERADOR a,
		  VIEW_USUARIO b
   WHERE
          CaNumOper      = @nNumOper AND
         (CaCodigo       = ClRut     AND
          cacodcli       = clcodigo ) AND  
          CaCodigo      *= a.OpRutCli  AND
          CaContraparte *= a.OpRutOpe  AND
	      CaOperador    *= b.usuario
*/

   SELECT @cCodMon = ISNULL ( MnNemo, '' ) FROM  VIEW_MONEDA WHERE @nCodMon = MnCodMon
   SELECT @cCodCnv = ISNULL ( MnNemo, '' ) FROM  VIEW_MONEDA WHERE @nCodCnv = MnCodMon
   SELECT @cPagoMx   = Glosa2 ,
   @diasvalor = diasvalor  
   FROM VIEW_FORMA_DE_PAGO 
   WHERE Codigo = @nPagoMx
   WHILE (@diasvalor > 0)  ------------------ Valuta Entregamos
 BEGIN
       SELECT @cfecvaluta = DATEADD(DAY, 1, @cfecvaluta )
       EXECUTE sp_feriado @cfecvaluta, @pais, @feriado OUTPUT
     IF @feriado = 0
     SELECT @diasvalor = @diasvalor -1
 END
 
   SELECT 'Proprietario' = @cNomprop                               ,
          'Numoper'  = @nNumOper                                ,
          'Fecha Inicio'  = CONVERT ( CHAR ( 10 ), CaFecha  , 103 ) ,
          'Fecha Vto'  = CONVERT ( CHAR ( 10 ), CaFecVcto, 103 ) ,
          'Plazo'  = CaPlazo                                 ,
          'Valor UF INI '  = @nUFIni                                 ,
          'Valor Obs Ini' = @nObsIni                                ,
          'Vendedor'  = @cVendedor                              ,
          'FaxVta'  = @cFaxVen                                ,
          'Operador Ven' = @cOpeVen                                ,
          'Comprador'  = @cComprador                             ,
          'FaxCMP'  = @cFaxCom                                ,
          'Operador com' = @cOpeCom                                ,
          'TipoOPer'  = @cTipOpe                                ,
          'Mto Mex'  = CaMtoMon1                               ,
          'CodMoneda'  = @cCodMon                                ,
          'CodCnversion' = @cCodCnv                                ,
          'Precio'  = CaPreCal                                ,
          'Precio Spt'  = @nPreSpt                                ,
          'Precio futuro' = @nPreFut                                ,
          'Monto Final'  = CaMtoMon2                               ,
          'Modalidad'  = @cModalidad                             ,
          'PagoMX'  = ISNULL ( @cPagoMx, '' )                 ,
          'Glosa'  = MnGlosa                                 ,
          'No. Fax Enitidad' = AcFax                                   ,
          'Firma Compra' = @cFirCom                                ,
          'Firma Venta'  = @cFirVen                                ,
	      'Valuta'  = CONVERT( CHAR(10) , @cfecvaluta , 103 )  ,
          'Nombre Entidad' = (Select rcnombre from VIEW_ENTIDAD where rccodcar=cacodsuc1 )
   FROM
          MFAC,
          MFCA LEFT OUTER JOIN VIEW_MONEDA ON  CaMdaUSD = MnCodMon
   WHERE
          CaNumOper   = @nNumOper 
         


/* -->Req.7619 CASS 04-01-2010 ESTE PROCEDIMIENTO NO SE UTILIZA.
   FROM
          MFAC,
          MFCA,
          VIEW_MONEDA
   WHERE
          CaNumOper   = @nNumOper AND
          CaMdaUSD   *= MnCodMon
*/

SET NOCOUNT OFF
END

GO
