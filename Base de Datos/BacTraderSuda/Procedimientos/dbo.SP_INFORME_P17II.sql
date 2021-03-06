USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_P17II]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORME_P17II]
AS
BEGIN
  
 set nocount on
 CREATE TABLE #IP17II( PARTIDA CHAR(4),
    CODIGO CHAR(5),
    GLOSA CHAR(50),
    MONEDA numeric(19,4),
    CAPITAL  NUMERIC(19,4) DEFAULT 0,
    REAJUSTE NUMERIC(19,4),
    INTERES  NUMERIC(19,4),
    TOT_CONTABLE NUMERIC(19,4),
    AJUSTE  NUMERIC(19,4),
    TOTAL  NUMERIC(19,4),
    CARTERA  NUMERIC(1),
    LINEA  NUMERIC (2))
 DECLARE @FECHAPROC DATETIME
 DECLARE @DOLAR    NUMERIC(19,4)
 DECLARE @UF    NUMERIC(19,4)
 SELECT @FECHAPROC = acfecproc from mdac 
 SELECT @DOLAR = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 and vmfecha = @fechaproc
 SELECT @UF = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 998 and vmfecha = @fechaproc
 INSERT INTO #IP17II VALUES(' ',' ','TOTAL INV. FINANCIERAS (I+II+III)',0,0,0,0,0,0,0,0,1) 
 INSERT INTO #IP17II VALUES('I',' ','Total Sistema No Financiero (1+2)',0,0,0,0,0,0,0,0,2) 
 INSERT INTO #IP17II VALUES('I','1','Total Sector Público',0,0,0,0,0,0,0,0,3) 
 INSERT INTO #IP17II VALUES('I','1','Pag.Desc. de Tesoreria PDT',0,0,0,0,0,0,0,2,4) 
 INSERT INTO #IP17II VALUES('I','1','Pag.Reaj. de Tesoreria PRT',0,0,0,0,0,0,0,2,5)    
 INSERT INTO #IP17II VALUES('I','1','Otros Pagarés de Tesorería',0,0,0,0,0,0,0,2,6)
 INSERT INTO #IP17II VALUES('I','1','Acciones',0,0,0,0,0,0,0,1,7)
 INSERT INTO #IP17II VALUES('I','1','Bonos y Letras de Crédito'  ,0,0,0,0,0,0,0,2,8)
 INSERT INTO #IP17II VALUES('I','1','Tit. Deuda Externa Emit.por el Fisco',0,0,0,0,0,0,0,2,9)
 INSERT INTO #IP17II VALUES('I','1','Tit. Deuda Ext.Emit.por otras entid.'  ,0,0,0,0,0,0,0,2,10)
 INSERT INTO #IP17II VALUES('I','1',' ',0,0,0,0,0,0,0,0,11)
 INSERT INTO #IP17II VALUES('I','1',' ',0,0,0,0,0,0,0,0,12)
 INSERT INTO #IP17II VALUES('I','1',' ',0,0,0,0,0,0,0,0,13)
 INSERT INTO #IP17II VALUES('I','2','Total Sector Privado'  ,0,0,0,0,0,0,0,2,14)
 INSERT INTO #IP17II VALUES('I','2','Acciones'  ,0,0,0,0,0,0,0,2,15)
 INSERT INTO #IP17II VALUES('I','2','Bonos y Debentures'  ,0,0,0,0,0,0,0,2,16)
 INSERT INTO #IP17II VALUES('I','2','Oro',0,0,0,0,0,0,0,2,17)
 INSERT INTO #IP17II VALUES('I','2','Otros' ,0,0,0,0,0,0,0,2,18)
 INSERT INTO #IP17II VALUES('II',' ','TOTAL SISTEMA FINANCIERO'  ,0,0,0,0,0,0,0,0,19)
 INSERT INTO #IP17II VALUES('II','1','Total Sector Pub.(1.1+1.2+1.3+1.4)',0,0,0,0,0,0,0,2,20)
 INSERT INTO #IP17II VALUES('II','1.1','Total Documentos Emitidos por el',0,0,0,0,0,0,0,1,21)
 INSERT INTO #IP17II VALUES('II','1.1','BCCH con Mercado Secundario',0,0,0,0,0,0,0,1,22)
 INSERT INTO #IP17II VALUES('II','1.1','Pagarés Descontables PDBC',0,0,0,0,0,0,0,1,23)
 INSERT INTO #IP17II VALUES('II','1.1','Pagarés Reajustables PRBC',0,0,0,0,0,0,0,2,24)
 INSERT INTO #IP17II VALUES('II','1.1','Pagarés en Dólares de los EEUU',0,0,0,0,0,0,0,1,25)
 INSERT INTO #IP17II VALUES('II','1.1',' ',0,0,0,0,0,0,0,0,26)
 INSERT INTO #IP17II VALUES('II','1.1','PRD',0,0,0,0,0,0,0,0,27)
 INSERT INTO #IP17II VALUES('II','1.1','Pagarés CERO',0,0,0,0,0,0,0,0,28)
 INSERT INTO #IP17II VALUES('II','1.1','Pagarés Tasa Flotante PTF',0,0,0,0,0,0,0,0,29)
 INSERT INTO #IP17II VALUES('II','1.1','PRC PERMANENTE',0,0,0,0,0,0,0,2,30)
 INSERT INTO #IP17II VALUES('II','1.1','Pagarés Reaj. con Cupones PRC',0,0,0,0,0,0,0,2,31)
 INSERT INTO #IP17II VALUES('II','1.1','Otros',0,0,0,0,0,0,0,2,32)
 INSERT INTO #IP17II VALUES('II','1.2','Total Documentos Emitidos por el',0,0,0,0,0,0,0,2,33)
 INSERT INTO #IP17II VALUES('II','1.2','BCCH sin Mercado Secundario',0,0,0,0,0,0,0,2,34)
 INSERT INTO #IP17II VALUES('II','1.2','Pag.Reprog.Deudas Ac.1507 y 1578',0,0,0,0,0,0,0,2,35)
 INSERT INTO #IP17II VALUES('II','1.2','Pag.Expresado en Dólares EEUU',0,0,0,0,0,0,0,2,36)
 INSERT INTO #IP17II VALUES('II','1.2','Certif. Dep. en Dólares EEUU',0,0,0,0,0,0,0,2,37)
 INSERT INTO #IP17II VALUES('II','1.2','Pagarés Cap. XVIII (Cupos)',0,0,0,0,0,0,0,0,38)
 INSERT INTO #IP17II VALUES('II','1.2','Otros',0,0,0,0,0,0,0,1,39)
 INSERT INTO #IP17II VALUES('II','1.2',' ',0,0,0,0,0,0,0,1,40)
 INSERT INTO #IP17II VALUES('II','1.3','Total Títulos de la Deuda Externa',0,0,0,0,0,0,0,2,41)
 INSERT INTO #IP17II VALUES('II','1.3','Emitidos por el BCCH',0,0,0,0,0,0,0,2,42)
 INSERT INTO #IP17II VALUES('II','1.3','Pagarés Conversión Deuda Externa',0,0,0,0,0,0,0,2,43)
 INSERT INTO #IP17II VALUES('II','1.3','',0,0,0,0,0,0,0,2,44)
 INSERT INTO #IP17II VALUES('II','1.4','Total Dctos. Emit. por Bco del Estado',0,0,0,0,0,0,0,2,45)
 INSERT INTO #IP17II VALUES('II','1.4','Letras de Crédito',0,0,0,0,0,0,0,2,46)
 INSERT INTO #IP17II VALUES('II','1.4','Tit.Deuda Ext. Emit. Bco del Estado',0,0,0,0,0,0,0,2,47)
 INSERT INTO #IP17II VALUES('II','1.4','Otras Inversiones Financieras',0,0,0,0,0,0,0,2,48)
 INSERT INTO #IP17II VALUES('II','1.4',' ',0,0,0,0,0,0,0,2,49)
 INSERT INTO #IP17II VALUES('II','1.4',' ',0,0,0,0,0,0,0,2,50)
 INSERT INTO #IP17II VALUES('II','2','Total Sector Privado (2.1+2.2)',0,0,0,0,0,0,0,0,51)
 INSERT INTO #IP17II VALUES('II','2.1','Total Doc.Emit.por Bancos y Financ.',0,0,0,0,0,0,0,2,52)
 INSERT INTO #IP17II VALUES('II','2.1','Letras de Crédito Propia Emisión',0,0,0,0,0,0,0,2,53)
 INSERT INTO #IP17II VALUES('II','2.1','Letras de Crédito Emit. por Terceros',0,0,0,0,0,0,0,2,54)
 INSERT INTO #IP17II VALUES('II','2.1','Títulos de Deuda Externa',0,0,0,0,0,0,0,2,55)
 INSERT INTO #IP17II VALUES('II','2.1','Otros',0,0,0,0,0,0,0,2,56)  
 INSERT INTO #IP17II VALUES('II','2.1',' ',0,0,0,0,0,0,0,2,57)
 INSERT INTO #IP17II VALUES('II','2.1',' ',0,0,0,0,0,0,0,2,58)
 INSERT INTO #IP17II VALUES('II','2.2','Total Doc. Emit. Otras Entidades',0,0,0,0,0,0,0,2,59)  
 INSERT INTO #IP17II VALUES('II','2.2',' ',0,0,0,0,0,0,0,2,60)
 INSERT INTO #IP17II VALUES('II','2.2',' ',0,0,0,0,0,0,0,2,61)
 INSERT INTO #IP17II VALUES('III',' ','TOTAL SECTOR EXTERNO',0,0,0,0,0,0,0,2,62
) INSERT INTO #IP17II VALUES('III',' ','Gobierno y Organismos Gubernament.',0,0,0,0,0,0,0,2,63)  
 INSERT INTO #IP17II VALUES('III',' ','Banco del Exterior',0,0,0,0,0,0,0,0,64)  
 INSERT INTO #IP17II VALUES('III',' ','Otros Agentes Económicos',0,0,0,0,0,0,0,2,65)  
----Bonos 
     UPDATE #IP17II SET reajuste = (select isnull(sum(cpvalcomp),0) from mdcp,view_serie where cpcodigo =15  and secodigo = cpcodigo and semascara = cpmascara and semonemi = 994 ) ,ajuste =(select sum(vivalcomp) from mdvi,view_serie where vicodigo = 31 and vitipoper = 'CP' and secodigo = vicodigo and semascara = vimascara and semonemi = 994) where linea = 18  
     UPDATE #IP17II SET reajuste = (select isnull(sum(cpvalcomp),0) from mdcp,view_serie ,view_emisor where cpcodigo =15  and secodigo = cpcodigo and semascara = cpmascara and serutemi  = emrut and emtipo <> 1 ) ,ajuste =(select sum(vivalcomp) from mdvi,view_serie,view_emisor where vicodigo = 31 and vitipoper = 'CP' and secodigo = vicodigo and semascara = vimascara and serutemi = emrut and emtipo <> 1) where linea = 8  
     UPDATE #IP17II SET reajuste = (select isnull(sum(cpvalcomp),0) from mdcp,view_serie ,view_emisor where cpcodigo =15  and secodigo = cpcodigo and semascara = cpmascara and serutemi  = emrut and emtipo = 1 ) ,ajuste =(select sum(vivalcomp) from mdvi,view_serie,view_emisor where vicodigo = 31 and vitipoper = 'CP' and secodigo = vicodigo and semascara = vimascara and serutemi = emrut and emtipo = 1) where linea = 16  
---- pdbc
     UPDATE #IP17II SET moneda = (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =6  ) ,interes =(select sum(vivalcomp) from mdvi where vicodigo = 6 and vitipoper = 'CP') where linea = 23
--- prbc 
     UPDATE #IP17II SET Capital = (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =7  ) ,tot_contable =(select sum(vivalcomp) from mdvi where vicodigo = 7 and vitipoper = 'CP') where linea = 24
-- prd  
     UPDATE #IP17II SET reajuste = (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =31  ) ,ajuste =(select sum(vivalcomp) from mdvi where vicodigo = 31 and vitipoper = 'CP') where linea = 27
-- cero 
     UPDATE #IP17II SET Capital = (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =300  ) ,tot_contable =(select sum(vivalcomp) from mdvi where vicodigo = 300 and vitipoper = 'CP') where linea = 28
-- PTF
    UPDATE #IP17II SET Capital = (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =5  ) ,tot_contable =(select sum(vivalcomp) from mdvi where vicodigo = 5 and vitipoper = 'CP')  where linea = 29
-- prc
     UPDATE #IP17II SET Capital = (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =4   and codigo_carterasuper = 'P' ) ,tot_contable =(select sum(vivalcomp) from mdvi where vicodigo = 4 and vitipoper = 'CP' and codigo_carterasuper = 'P' ) where linea = 30
     UPDATE #IP17II SET Capital = (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =4   and codigo_carterasuper = 'T'  ),tot_contable =(select sum(vivalcomp) from mdvi where vicodigo = 4 and vitipoper = 'CP' and codigo_carterasuper = 'T' ) where linea = 31
--letras bco del Estado
 
 UPDATE #IP17II SET moneda =  (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =20 and cptipoletra = 'E'), tot_contable =(select isnull(sum(vivalcomp),0) from mdvi,view_serie where vicodigo =20 and vimascara= semascara and serutemi = '97030000')   WHERE linea = 46
--letras suda
     UPDATE #IP17II SET moneda = (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =20 and (cptipoletra ='V' or cptipoletra = 'F') ),tot_contable = (select isnull(sum(vivalcomp),0) from mdvi,view_serie where vicodigo =20 and vimascara= semascara and serutemi = '97018000' ) where  linea =53
--OTRAS LETRAS
     UPDATE #IP17II SET moneda = (select isnull(sum(cpvalcomp),0) from mdcp where cpcodigo =20 and cptipoletra ='O' ),tot_contable = (select isnull(sum(vivalcomp),0) from mdvi,view_serie where vicodigo =20 and vimascara= semascara and serutemi <> '97018000' AND serutemi <> '97030000'   and codigo_carterasuper = 'T' ) where  linea =54
--sumas
     UPDATE #IP17II SET moneda = (select sum(moneda) from #ip17ii),capital = (select sum(capital) from #ip17ii),
      reajuste= (select sum(reajuste) from #ip17ii) , interes =(select sum(interes ) from #ip17ii) ,
      tot_contable = (select sum(tot_contable) from #ip17ii),ajuste = (select sum(ajuste) from #ip17ii)WHERE LINEA = 1  
---
     UPDATE #IP17II SET moneda = (select sum(moneda) from #ip17ii where partida = 'I' ),capital = (select sum(capital) from #ip17ii where partida = 'I' ),
      reajuste= (select sum(reajuste) from #ip17ii where partida = 'I' ) , interes =(select sum(interes ) from #ip17ii where partida = 'I' ) ,
      tot_contable = (select sum(tot_contable) from #ip17ii where partida = 'I' ),ajuste = (select sum(ajuste) from #ip17ii where partida = 'I' )WHERE LINEA = 2  
--  
     UPDATE #IP17II SET moneda = (select sum(moneda) from #ip17ii where partida = 'I' and codigo = 1),capital = (select sum(capital) from #ip17ii where partida = 'I' and codigo = 1),
      reajuste= (select sum(reajuste) from #ip17ii where partida = 'I' and codigo = 1) , interes =(select sum(interes ) from #ip17ii where partida = 'I' and codigo = 1) ,
      tot_contable = (select sum(tot_contable) from #ip17ii where partida = 'I' and codigo = 1),ajuste = (select sum(ajuste) from #ip17ii where partida = 'I' and codigo = 1)WHERE LINEA = 3
--
     UPDATE #IP17II SET moneda = (select sum(moneda) from #ip17ii where partida = 'I' and codigo = 2),capital = (select sum(capital) from #ip17ii where partida = 'I' and codigo = 2),
      reajuste= (select sum(reajuste) from #ip17ii where partida = 'I' and codigo = 2) , interes =(select sum(interes ) from #ip17ii where partida = 'I' and codigo = 2) ,
      tot_contable = (select sum(tot_contable) from #ip17ii where partida = 'I' and codigo = 2),ajuste = (select sum(ajuste) from #ip17ii where partida = 'I' and codigo = 2)WHERE LINEA = 14
--
     UPDATE #IP17II SET moneda = (select sum(moneda) from #ip17ii where partida = 'II' and codigo in('1.1','1.2','1.3','1.4')),capital = (select sum(capital) from #ip17ii where partida = 'II' and codigo in('1.1','1.2','1.3','1.4')),
      reajuste= (select sum(reajuste) from #ip17ii where partida = 'II' and codigo in('1.1','1.2','1.3','1.4')) , interes =(select sum(interes ) from #ip17ii where partida = 'II' and codigo in('1.1','1.2','1.3','1.4')) ,
      tot_contable = (select sum(tot_contable) from #ip17ii where partida = 'II' and codigo in('1.1','1.2','1.3','1.4')),ajuste = (select sum(ajuste) from #ip17ii where partida = 'II' and codigo in('1.1','1.2','1.3','1.4'))WHERE LINEA = 20
--
     UPDATE #IP17II SET moneda = (select sum(moneda) from #ip17ii where partida = 'II' and codigo = '1.2'),capital = (select sum(capital) from #ip17ii where partida = 'II' and codigo = '1.2'),
      reajuste= (select sum(reajuste) from #ip17ii where partida = 'II' and codigo = '1.2') , interes =(select sum(interes ) from #ip17ii where partida = 'II' and codigo = '1.2') ,
      tot_contable = (select sum(tot_contable) from #ip17ii where partida = 'II' and codigo = '1.2'),ajuste = (select sum(ajuste) from #ip17ii where partida = 'II' and codigo = '1.2')WHERE LINEA = 34
--
     UPDATE #IP17II SET moneda = (select sum(moneda) from #ip17ii where partida = 'II' and codigo = '1.3'),capital = (select sum(capital) from #ip17ii where partida = 'II' and codigo = '1.3'),
      reajuste= (select sum(reajuste) from #ip17ii where partida = 'II' and codigo = '1.3') , interes =(select sum(interes ) from #ip17ii where partida = 'II' and codigo = '1.3') ,
      tot_contable = (select sum(tot_contable) from #ip17ii where partida = 'II' and codigo = '1.3'),ajuste = (select sum(ajuste) from #ip17ii where partida = 'II' and codigo = '1.3')WHERE LINEA = 41
--
 UPDATE #IP17II SET moneda = (select sum(moneda) from #ip17ii where partida = 'II' and codigo in( '2.1','2.2')),capital = (select sum(capital) from #ip17ii where partida = 'II' and codigo in( '2.1','2.2')),
      reajuste= (select sum(reajuste) from #ip17ii where partida = 'II' and codigo in( '2.1','2.2')) , interes =(select sum(interes ) from #ip17ii where partida = 'II' and codigo in( '2.1','2.2')) ,
      tot_contable = (select sum(tot_contable) from #ip17ii where partida = 'II' and codigo in( '2.1','2.2')),ajuste = (select sum(ajuste) from #ip17ii where partida = 'II' and codigo in( '2.1','2.2'))WHERE LINEA = 51
--
 SELECT *,fecha = @FECHAPROC,uf =@UF,dolar =@DOLAR,acnomprop FROM #IP17II, mdac
 set nocount off
end


GO
