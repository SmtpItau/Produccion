USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_CONTABLE]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_CONTABLE]
AS
BEGIN
   SET NOCOUNT ON
 DECLARE @cSw          CHAR(02)
 DECLARE @cNumOpe      CHAR(10)
 DECLARE @cNumOpeAux   CHAR(10)
 DECLARE @nContador    NUMERIC(19)
 DECLARE @moneda   NUMERIC(3)
 DECLARE @monedainter  NUMERIC(3)
 DECLARE @nfolio   NUMERIC(6)
 DECLARE @cfolio   CHAR(6)
 DECLARE @nregs   INTEGER
 DECLARE @cont   INTEGER
 DECLARE @voucher  NUMERIC(10)
 DECLARE @rut_cli  NUMERIC(9)
 DECLARE @codigo_cli  NUMERIC(10)
 DECLARE @TipoMercado  CHAR(4)
 DECLARE @numero_definitivo NUMERIC(10)
 DECLARE @tipo_operacion  CHAR(1)
 DECLARE @NumFuturo  NUMERIC(10)
   CREATE TABLE #tmpinterfaz
          (
           Moneda      CHAR(02),
           Oficina     CHAR(02),
           Dpto        CHAR(02),
           Batch       CHAR(03),
           Folio       CHAR(06),
           Emisora     CHAR(02),
           Departa     CHAR(02),
           Fecha       CHAR(06),   --yymmdd
           Glosa       CHAR(40),
           Cuenta      CHAR(10),
           Correspon   CHAR(04),
           Debe        CHAR(15),
           Haber       CHAR(15),
           Cambio      CHAR(12),
           NumOpe      CHAR(10),
           NumCuota    CHAR(02),
           Contrapar   CHAR(01),
           FecConta    CHAR(06),   --yymmdd
           TasaInter   CHAR(06),
           FecValuta   CHAR(06),   --yymmdd
           RutCli      CHAR(09),
           NomCli      CHAR(35),
           FinProduc   CHAR(03),
           Filler1     CHAR(01),
           BcoCorresp  CHAR(04),
           Gedin       CHAR(01),
           Filler2     CHAR(08),
           Secuencia   CHAR(02),
           TipoReg     CHAR(01),
           NumVoucher  NUMERIC(10),
           CorrVoucher NUMERIC(05),
           NumOperac   NUMERIC(07),
           NumFuturo   NUMERIC(07),
           TipoTransac CHAR(04),
           TipoOperac  CHAR(01),
           TipoMercado CHAR(04),
           CodMoneda   CHAR(03),
           FPEntrega   NUMERIC(04),
           Contador    NUMERIC(19) IDENTITY( 1, 1 ),
			MonedaOpera CHAR(03) ,
			rut_cli NUMERIC(9) ,
			codigo_cli  NUMERIC(10)
          )
   CREATE TABLE #tmpinterfaz_real
          (
           Moneda      CHAR(02),
           Oficina     CHAR(02),
           Dpto        CHAR(02),
           Batch       CHAR(03),
           Folio       CHAR(06),
           Emisora     CHAR(02),
           Departa     CHAR(02),
           Fecha       CHAR(06),   --yymmdd
           Glosa       CHAR(40),
           Cuenta      CHAR(10),
           Correspon   CHAR(04),
           Debe        CHAR(15),
           Haber       CHAR(15),
           Cambio      CHAR(12),
           NumOpe      CHAR(10),
           NumCuota    CHAR(02),
           Contrapar   CHAR(01),
           FecConta    CHAR(06),   --yymmdd
           TasaInter   CHAR(06),
           FecValuta   CHAR(06),   --yymmdd
           RutCli      CHAR(09),
           NomCli      CHAR(35),
           FinProduc   CHAR(03),
           Filler1     CHAR(01),
           BcoCorresp  CHAR(04),
           Gedin       CHAR(01),
           Filler2     CHAR(08),
           Secuencia   CHAR(02),
           TipoReg     CHAR(01)
          )
   INSERT INTO #tmpinterfaz
                       (
                        Moneda,
                        Oficina,
                        Dpto,
                        Batch,
                        Folio,
                        Emisora,
                        Departa,
                        Fecha,
                        Glosa,
                        Cuenta,
                        Correspon,
                        Debe,
                        Haber,
                        Cambio,
                        NumOpe,
                        NumCuota,
                        Contrapar,
                        FecConta,
                        TasaInter,
                        FecValuta,
                        RutCli,
                	NomCli,
                        FinProduc,
                        Filler1,
                        BcoCorresp,
                        Gedin,
                        Filler2,
                        Secuencia,
                        TipoReg,
                        NumVoucher,
                        CorrVoucher,
          		NumOperac,
                        NumFuturo,
                        TipoTransac,
                        TipoOperac,
                   	TipoMercado,
                        CodMoneda,
                        FPEntrega,
          		MonedaOpera  ,
   			rut_cli  ,
   			codigo_cli
                       )
          SELECT        '00',  -- Moneda
                        '71',
                        '49',
                        '698',
                        RIGHT( '000000' + CONVERT( VARCHAR(06), a.Numero_Voucher ), 6 ),  -- CorPerfil = 1 OR CorPerfil = 5, sino ???
                        '21',
                        '00',  --(nDepa)
                        REPLACE(CONVERT( CHAR(08), f.acfecpro, 4 ),'.',''),
                        SUBSTRING( ISNULL( c.glosa, CONVERT( CHAR(40), ' ' ) ), 1, 40 ),
                        SUBSTRING( a.cuenta, 1, 10 ),   -- DCCUENTA = '2505690160' AND (Perfil = 7 or Perfil = 8, VM_CTACAMB (USD), VM_CTACAMB (EC_CODMON))
                        RIGHT( '0000' + CONVERT( VARCHAR(04), Codigo_Corresponsal ), 4 ),
                        RIGHT( '000000000000000' + CONVERT( VARCHAR(20), 
                               CONVERT( NUMERIC(19,2), (CASE WHEN Tipo_Monto = 'D' THEN Monto ELSE 0 END) ) ), 15 ),
                        RIGHT( '000000000000000' + CONVERT( VARCHAR(20), 
                               CONVERT( NUMERIC(19,2), (CASE WHEN Tipo_Monto = 'H' THEN Monto ELSE 0 END) ) ), 15 ),
                        RIGHT( '000000000000000' + CONVERT( VARCHAR(20), CONVERT( NUMERIC(19,4), b.tipo_cambio ) ), 12 ), -- TIPO DE CAMBIOS
                        '0000000000',      -- NNUMOPE
                        '00',
                        ' ',
                        '000000',
                        '000000',
                        '000000',
                        RIGHT( '000000000' + CONVERT( VARCHAR(09), b.rut_cliente ), 9 ),
                        SUBSTRING( clnombre, 1, 35 ),
                        '000',
                        ' ',
                        CASE WHEN Codigo_Corresponsal = 0 THEN '0000' ELSE CONVERT( CHAR(04), Codigo_Corresponsal ) END,
                        ' ',
                        CONVERT( CHAR(08), ' ' ),
                        '00',
                        '1',
                        a.Numero_Voucher,
                        a.Correlativo,
                        b.Operacion,
                        b.Documento,
                        b.Tipo_Operacion,
                        SUBSTRING( b.Tipo_Operacion, 1, 1 ) ,
                        b.Mercado    ,
                        SUBSTRING( a.valor_campo, 1, 3 ) ,             --d.mocodmon,
                        0 ,-- CASE WHEN b.SUBSTRING( TipoTransac, 1, 1 ) = 'C' THEN d.moentre ELSE d.morecib END,
   			b.moneda_operacion ,
   			b.rut_cliente     ,
   			b.codigo_cliente
                FROM   BAC_CNT_DETALLE_VOUCHER A LEFT OUTER JOIN  VIEW_PLAN_DE_CUENTA C ON a.Cuenta = c.Cuenta ,
   						bac_cnt_voucher  b, 
   						view_cliente   e, 
   						meac    f
                 WHERE  a.Numero_Voucher = b.Numero_Voucher  AND 
                        (b.rut_cliente    = e.clrut           AND
    					b.codigo_cliente = e.clcodigo ) AND
                        f.acfecpro        = b.Fecha_Ingreso


				/*REQ.7619 CASS 07-01-2011
								 FROM   bac_cnt_detalle_voucher a, 
   										bac_cnt_voucher  b, 
   										view_plan_de_cuenta  c, 
   										view_cliente   e, 
   										meac    f
								 WHERE  a.Numero_Voucher = b.Numero_Voucher  AND 
										a.Cuenta        *= c.cuenta          AND
										(b.rut_cliente    = e.clrut           AND
    									b.codigo_cliente = e.clcodigo ) AND
										f.acfecpro        = b.Fecha_Ingreso
				*/


   UPDATE       #tmpinterfaz
          SET   Debe   = '0' + SUBSTRING(   Debe, 1, 12 ) + SUBSTRING(   Debe, 14, 2 ),
                Haber  = '0' + SUBSTRING(  Haber, 1, 12 ) + SUBSTRING(  Haber, 14, 2 ),
                Cambio = '0' + SUBSTRING( Cambio, 1, 07 ) + SUBSTRING( Cambio, 9, 4 )
 UPDATE #tmpinterfaz
 SET Departa = CASE WHEN NumFuturo  = 0 THEN '18' ELSE '19' END
 SELECT  @nregs = COUNT(*)
 FROM #tmpinterfaz
 SELECT  @cont = 1
 WHILE @nregs >= @cont
  BEGIN
   SET ROWCOUNT @cont
   SELECT  @voucher  = NumVoucher ,
    @rut_cli  = rut_cli ,
    @codigo_cli = codigo_cli ,
    @TipoMercado = TipoMercado ,
    @tipo_operacion = TipoOperac ,
    @NumFuturo = NumFuturo
   FROM #tmpinterfaz
   SET ROWCOUNT 0
   SET ROWCOUNT 1
   SELECT @numero_definitivo = monumope
   FROM memo
   WHERE @rut_cli  = morutcli AND
    @codigo_cli = mocodcli AND
    @TipoMercado = motipmer AND
    @tipo_operacion = motipope AND
    @NumFuturo = monumfut AND
    moestatus IN( '' , 'M')
   ORDER BY monumope
   SET ROWCOUNT 0
   UPDATE  #tmpinterfaz
   SET NumOperac  = @numero_definitivo
   WHERE NumVoucher = @voucher
   SELECT  @cont = @cont + 1
  
  END
/*
   UPDATE  #tmpinterfaz
   SET    Departa    = '18'
   WHERE  NumFuturo <> 0 AND (TipoMercado = 'ARRI' OR TipoOperac <> 'C') AND SUBSTRING( TipoTransac, 2, 3 ) = 'MXN'
   UPDATE       #tmpinterfaz
          SET   Departa    = '19'
          WHERE NumFuturo <> 0 AND TipoMercado <> 'ARRI' AND TipoOperac <> 'C' AND SUBSTRING( TipoTransac, 2, 3 ) = 'MXN'
   UPDATE       #tmpinterfaz
          SET   Departa    = '18'
          WHERE NumFuturo <> 0 AND (TipoMercado = 'ARRI' OR TipoOperac <> 'C') AND SUBSTRING( TipoTransac, 2, 3 ) = 'MXN'
   UPDATE       #tmpinterfaz
          SET   Departa    = '18'
          WHERE NumFuturo  = 0 AND SUBSTRING( TipoTransac, 2, 3 ) = 'MXN'
   UPDATE       #tmpinterfaz
          SET   Departa     = CASE WHEN NumFuturo  = 0 THEN '18' ELSE '19' END
          WHERE TipoTransac = 'CMXA' 
   UPDATE       #tmpinterfaz
          SET   Departa     = CASE WHEN NumFuturo  = 0 THEN '18' ELSE '19' END
          WHERE TipoTransac = 'VMXA'
*/
   UPDATE       #tmpinterfaz
          SET   NumOpe      = RIGHT( '00000000' + Departa + CONVERT( VARCHAR(07), NumOperac ), 10 )
   UPDATE       #tmpinterfaz
          SET   Moneda      = RIGHT( '00' + CONVERT( VARCHAR(02), LEFT(mncodfox,2) ), 2 )
          FROM  view_moneda
          WHERE mnnemo = CodMoneda
   UPDATE       #tmpinterfaz
          SET   Cuenta      = CASE WHEN mnctacamb = '0' THEN '0000000000' ELSE mnctacamb END
          FROM  view_moneda
          WHERE Cuenta      = '2505690160' AND mnnemo = MonedaOpera
   UPDATE       #tmpinterfaz
          SET   Cuenta      = mnctacamb
          FROM  view_moneda
          WHERE Cuenta      = '2505690160' AND (CorrVoucher = 7 OR CorrVoucher = 8) AND mnnemo = 'USD'
   SELECT @cSw = '00'
   SET ROWCOUNT 1
 SELECT  @cNumOpe = NumOpe , 
  @moneda  = moneda 
 FROM  #tmpinterfaz 
 WHERE  secuencia = '00' 
 ORDER BY NumOpe, Contador
   SET ROWCOUNT 0
--SELECT * FROM #tmpinterfaz 
   SELECT @nfolio = 504000
   SELECT @cfolio = RIGHT( '000000' + CONVERT( VARCHAR(06), @nfolio ), 6 )
   WHILE (1=1) BEGIN
      SET ROWCOUNT 1
      SELECT           @cNumOpeAux  = NumOpe ,
                       @nContador   = Contador ,
   @monedainter = moneda
      FROM       #tmpinterfaz 
      WHERE      secuencia = '00' 
      ORDER BY   NumOpe, Contador
      SET ROWCOUNT 0
      IF NOT EXISTS( SELECT secuencia FROM #tmpinterfaz WHERE secuencia = '00' ) BEGIN
         BREAK
      END
      IF @moneda <> @monedainter
  BEGIN
  SELECT @nfolio = @nfolio + 1
  SELECT @moneda = @monedainter
  SELECT @cfolio = RIGHT( '000000' + CONVERT( VARCHAR(06), @nfolio ), 6 )
END
      IF @cNumOpe = @cNumOpeAux BEGIN
         IF @cSw = '01' BEGIN
            SELECT @cSw = '02'
         END ELSE BEGIN
            SELECT @cSw = '01'
         END
      END ELSE BEGIN
         SELECT @cNumOpe = @cNumOpeAux
         SELECT @cSw     = '01'
      END
      INSERT INTO #tmpinterfaz_real
                       (
                          Moneda,
                          Oficina,
                          Dpto,
                          Batch,
                   folio,
                          Emisora,
                          Departa,
                          Fecha,
                        Glosa,
                          Cuenta,
                          Correspon,
                          Debe,
                          Haber,
                          Cambio,
                          NumOpe,
                          NumCuota,
                          Contrapar,
                          FecConta,
                          TasaInter,
                          FecValuta,
                          RutCli,
                          NomCli,
                       FinProduc,
                          Filler1,
                          BcoCorresp,
                          Gedin,
                          Filler2,
                          Secuencia,
                          TipoReg
                       )
   SELECT       Moneda,
                          Oficina,
                   Dpto,
                          Batch,
                          @cfolio,
                          Emisora,
                          Departa,
          Fecha,
                          Glosa,
                          Cuenta,
                          Correspon,
                          Debe,
                          Haber,
                          Cambio,
                          NumOpe,
          NumCuota,
            Contrapar,
                          FecConta,
                          TasaInter,
                          FecValuta,
                          RutCli,
                          NomCli,
                          FinProduc,
                          Filler1,
                          BcoCorresp,
                          Gedin,
                          Filler2,
                          @cSw,
                          TipoReg
                    FROM  #tmpinterfaz
                    WHERE contador = @nContador
      IF @cSw = '02' BEGIN
         INSERT INTO #tmpinterfaz_real
                       (
                          Moneda,
                          Oficina,
                          Dpto,
                          Batch,
                          folio,
                          Emisora,
                          Departa,
                          Fecha,
                          Glosa,
                          Cuenta,
                          Correspon,
                          Debe,
                          Haber,
                          Cambio,
                          NumOpe,
                          NumCuota,
                          Contrapar,
                          FecConta,
                          TasaInter,
                          FecValuta,
                          RutCli,
                          NomCli,
                          FinProduc,
                          Filler1,
                          BcoCorresp,
                          Gedin,
                          Filler2,
                          Secuencia,
                          TipoReg
                       )
          SELECT          Moneda,
                          '71',
                          '49',
                          '698',
                          @cfolio,
                          '21',
                          Departa,
                          Fecha,
                          CONVERT( CHAR(40), ' ' ),
                          '0000000000',
                          '0000',
                          CASE WHEN Debe = '000000000000000 ' THEN Haber ELSE Debe END,
                          CASE WHEN Debe = '000000000000000 ' THEN Haber ELSE Debe END,
                          Cambio,
                          '0000000000',      -- NNUMOPE
                          '00',
                          ' ',
                          '000000',
                          '000000',
                          '000000',
  RutCli,
                          NomCli,
                          '000',
                          ' ',
        '0000',
                          ' ',
                          Filler2,
                          '99',
                          '2'
                    FROM  #tmpinterfaz
                    WHERE contador = @nContador
      END
      UPDATE #tmpinterfaz SET secuencia = @cSw WHERE contador = @nContador
   END
-- SELECT * FROM #tmpinterfaz
-- ORDER BY NomCli,TipoOperac
   SELECT      'Registro' = Moneda + Oficina + Dpto + Batch + Folio + Emisora + Departa + Fecha + Glosa + Cuenta + 
       Correspon + Debe + Haber + Cambio + NumOpe + NumCuota + Contrapar + FecConta + TasaInter +
                            FecValuta + RutCli + NomCli + FinProduc + Filler1 + BcoCorresp + Gedin + Filler2 + 
                            Secuencia + TipoReg
   FROM #tmpinterfaz_real
   ORDER BY folio
   DROP TABLE #tmpinterfaz_real
  DROP TABLE #tmpinterfaz
   SET NOCOUNT OFF
END

GO
