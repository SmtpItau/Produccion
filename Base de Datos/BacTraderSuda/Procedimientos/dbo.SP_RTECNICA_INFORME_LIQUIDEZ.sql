USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_INFORME_LIQUIDEZ]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_INFORME_LIQUIDEZ]
--     (
--     @fecha DATETIME
--     )
as
begin
   set nocount on
   declare @fecha datetime
   select @fecha = acfecante from mdac
 create table #tmp
  (
  Orden  integer,
  Cuenta  char(10),
  Pormenor char(256),
  Ctas  CHAR(25),
  Linea  CHAR(2),
  Uf  numeric(19, 4),
  Pesos  numeric(19, 4)
  )
 insert into #tmp
 select
  1,
  ' ',
  'A.- DOCUMENTOS ADQUIRIDOS AL BCCH Y TESGRAL',
  ' ',
  ' ',
  0,
  0
 insert into #tmp
 select
  2,
  '193',
  'P.D.B.C.',
  '193-1953-1954',
  '55',
  sum ( rsnominal ) ,
  sum ( rsvppresen )
 FROM
  mdrs --mdrs 
 WHERE
  rsfecha = @fecha
 and rscodigo = 6
 and rstipoper = 'dev'
 and rscartera = '111'
 insert into #tmp
 select
  3,
  ' ',
  'P.R.B.C',
  ' ',
  '56',
  sum ( rsnominal ) ,
  sum ( rsvppresen )
 FROM
  mdrs --mdrs 
 WHERE
  rsfecha = @fecha
 and rscodigo = 7
 and rstipoper = 'dev'
 and rscartera = '111'
 and datediff( dd, @fecha, rsfecvcto ) > 90
 and rsrutemis = 97029000
 insert into #tmp
 select
  4,
  ' ',
  'P.R.B.C ELEGIBLES PARA RESERVA TECNICA',
  '195E',
  '57',
  sum ( rsnominal ) ,
  sum ( rsvppresen )
 FROM
  mdrs --mdrs 
 WHERE
  rsfecha = @fecha
 and rscodigo = 7
 and rstipoper = 'dev'
 and rscartera = '111'
 and datediff( dd, @fecha, rsfecvcto ) <= 90
 and rsrutemis = 97029000
 insert into #tmp
 select
  5,
  ' ',
  'P.R.B.C ACDO. 1851',
  ' ',
  '58',
  0,
  0
 insert into #tmp
 select
  6,
  '195F, 195G',
  'PAGARES DEL BCCH POR DIFERENCIAS DE CAMBIO',
  ' ',
  '59',
  0,
  0
 insert into #tmp
 select
  7,
  '195M',
  'PAGARES REAJUSTABLES DE LA TESGRAL',
  ' ',
  '60',
  0,
  0
 insert into #tmp
 select
  8,
  ' ',
  'PAGARES DESCONTABLES DE LA TESGRAL EN UF',
  ' ',
  '61',
  0,
  0
 insert into #tmp
 select
  9,
  '1950',
  'PAGARES DESCONTABLES DE LA TESGRAL',
  ' ',
  '62',
  0,
  0
 insert into #tmp
 select
  10,
  '1926',
  'PAGARES REAJUSTABLES DEL BCCH CON PAGO DE CUPONES
  (P.R.C.)',
  '1926',
  '63',
  sum ( rsnominal ) ,
  sum ( rsvppresen )
 FROM
  mdrs --mdrs 
 WHERE
  rsfecha = @fecha
 and rscodigo = 4
 and rstipoper = 'dev'
 and rscartera = '111'
 and rsrutemis = 97029000
 insert into #tmp
 select
  11,
  ' ',
  ' ',
  ' ',
  ' ',
  0,
  0
 insert into #tmp
 select
  12,
  '',
  'B.- DOCUMENTOS BCCH Y TESGRAL ADQUIRIDOS AL MERCADO SECUNDARIO',
  ' ',
  ' ',
  0,
  0
 insert into #tmp
 select
  13,
  '1340',
  'COMPRA DE DOCTOS. REAJUSTABLES CON PACTO DE RETROCOMPRA A INSTI, FINANC.',
  ' ',
  '64',
  0,
  0
 insert into #tmp
 select
  14,
  '1342',
  'COMPRA DE DOCTOS. REAJUSTABLES CON PACTO DE RETROCOMPRA A TERCEROS',
  ' ',
  '65',
  0,
  0
 insert into #tmp
 select
  15,
  '1907',
  'PAGARES DE REPROGRAMACION COMPRADOS A OTRAS INSTITUCIONES',
  ' ',
  '66',
  0,
  0
 insert into #tmp
 select
  16,
  '1341, 1343',
  'P.R.B.C.',
  ' ',
  '67',
  0,
  sum ( rsvalinip )
 FROM
  mdrs --mdrs 
 WHERE
  rsfecha = @fecha
 and rscodigo = 7
 and rstipoper = 'dev'
 and rscartera = '112'
 insert into #tmp
 select
  17,
  ' ',
  'P.R.B.C. CON TASA DE INTERES FLOTANTE (P.T.F.)',
  ' ',
  '68',
  0,
  0
 insert into #tmp
 select
  18,
  ' ',
  'P.R.B.C. DIFERENCIA DE CAMBIO ACDO. 1484 ADQUIRIDOS A TERCEROS',
  'LCHR',
  '69',
  0,
  0
 insert into #tmp
 select
  19,
  ' ',
  'P.R.B.C. PROVENIENTES DE SWAP',
  'PRD-CTA. 1958',
  '70',
  0,
  0
 insert into #tmp
 select
  20,
  ' ',
  'P.R.B.C. ACDO. 1506',
  ' ',
  '71',
  0,
  0
 insert into #tmp
 select
  21,
  ' ',
  'P.R.B.C. DIFERENCIA DE CAMBIO ACDO. 1657-03 ADQUIRIDOS A TERCEROS',
  ' ',
  '72',
  0,
  0
 insert into #tmp
 select
  22,
  '',
  'OTROS (P.D.B.C.)',
  ' ',
  '73',
  0,
  sum ( rsvalinip )
 FROM
  mdrs --mdrs 
 WHERE
  rsfecha = @fecha
 and rscodigo = 6
 and rstipoper = 'dev'
 and rscartera = '112'
 insert into #tmp
 select
  23,
  '',
  '',
  ' ',
  '',
  0,
  0
 insert into #tmp
 select
  24,
  '',
  'P.R.C.',
  ' ',
  '74',
  0,
  sum ( rsvalinip )
 FROM
  mdrs 
 WHERE
  rsfecha = @fecha
 and rscodigo = 4
 and rstipoper = 'dev'
 and rscartera = '112'
 insert into #tmp
 select
  25,
  '',
  'P.C.D.',
  ' ',
  '75',
  0,
  0
 insert into #tmp
 select
  26,
  '',
  'BONOS CORA',
  ' ',
  '76',
  0,
  0
 insert into #tmp
 select
  27,
  '1911',
  'DOCUMENTOS REAJUSTABLES EMITIDOS POR OTROS ORGANISMOS FISCALES',
  ' ',
  '77',
  0,
  0
 insert into #tmp
 select
  28,
  '1921',
  'VALORES ADQUIRIDOS P.T.F.',
  'CUP. ZERO CTA 1965-0-00',
  '78',
  sum ( rsnominal ) ,
  sum ( rsvppresen )
 FROM
  mdrs 
 WHERE
  rsfecha = @fecha
 and rscodigo = 301
 and rstipoper = 'dev'
 and rscartera = '111'
 insert into #tmp
 select
  29,
  '1912',
  'DOC. REAJUSTABLES EMIT. POR OTRAS INST. FINANC. DEL PAIS',
  ' ',
  '79',
  0,
  0
 insert into #tmp
 select
  30,
  '1964',
  'CUPON CERO',
  'CERO CTA 1964-0-00',
  '80',
  sum ( rsnominal ) ,
  sum ( rsvppresen )
 FROM
  mdrs 
 WHERE
  rsfecha = @fecha
 and rscodigo = 300
 and rstipoper = 'dev'
 and rscartera = '111'
 select
  *
 from
  #tmp
 order by
  orden
   set nocount off
end

GO
