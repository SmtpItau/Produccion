USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ND15]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC ND15 '20211126'
CREATE  PROCEDURE [dbo].[ND15]  ( @dFechaProceso  DATETIME )        
AS        
BEGIN         
        
 SET NOCOUNT ON          
/*  
  
El campo 39 correspondiente a Jerarquía se encuentra ok.  
Campo 42 debe ir la información solo el último día del mes para los instrumentos clasificados con código 02 y 03;   
  
códigos 01, 04 y 05 deben ir en 0. Según el manual de CMF.  
declare @Fecha_Interfaz DATETIME='20211231'       
*/  
  

  
declare @Fecha_Interfaz  DATETIME  
set    @Fecha_Interfaz=@dFechaProceso--'20220408'  

  
 declare @dFechaMercado datetime -- 'Fecha mercado (T0)'      
 declare @dFechacartera datetime -- 'Fecha cartera (+1)'      
 declare @dFechaProxima datetime      
  -- 20211223.RCHS Cambios Estructura P40 / Circular N°2.301 - CMF ( cambios en la estructura del archivo P40 )  
 declare @dFechaUltimoDiaMes  datetime  
 declare @dFechaUltimoDiaHabilMes datetime  
 declare @bUltimoDiahabilMes  bit = 0      
  
 declare @nValorUF  NUMERIC(19,4)        
  
--------VALOR DETERRIO--------------  
CREATE TABLE [dbo].[#ValorDet](  
 [Cartera]    [varchar](1) NULL,  
 [Moneda]    [varchar](3) NULL,  
 [N_Documento]   numeric(8) NULL,  
 [valor]     numeric(8) NULL,  
 [correlativo]   numeric(1) NULL,  
 [Fecha_Proceso]   [datetime] NULL,  
 [Serie]     [varchar](15) NULL,  
 [Fecha_Vcto]   [datetime] NULL,  
 [Fase_Deterioro]  numeric(1) NULL,  
 [Tasa_de_Interes]  [float] NULL,  
 [Provision]    [float] NULL  
) ON [PRIMARY]  


Declare @ND15 Table (
	ctry			char(3)	
,	intf_dt         datetime
,	src_id          char(14)
,	cem             char(3)
,	prod            char(16)
,	book_dt         datetime
,	con_no          char(20)
,	ident_cli       char(12)
,	typ_reg         char(1)
,	instr_fmly      char(2)
,	typ             char(1)
,	next_coup       char(08)
,	der_opt         char(2)
,	nom_curr        numeric(18,4)
,	adj_ccy         char(4)
,	emi_rt_typ      char(7)
,	tera            numeric(16,8)
,	par_val         numeric(18,4)
,	com_rt_typ      char(7)
,	compra_rt       numeric(16,8)
,	acq_cost        numeric(18,4)
,	amort_cost      numeric(18,4)
,	val_rt_typ      char(7)
,	valor_rt        numeric(16,8)
,	valor_typ       char(1)
,	inst_price      numeric(16,8)
,	mod_dur         numeric(16,8)
,	convex          numeric(16,8)
,	valor_det       numeric(18,2)
,	instr_cond      char(1)
,	ini_cond_d      char(08)
,	fin_cond_d      char(08)
,	nemo_instr      char(20) 
)
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 219670, 2196701, 1, '02/28/2022', 'BCHIUK0611', '06/01/2022', 1, 0.0058999999999999999, 4257.3250147757608)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 221998, 2219981, 1, '02/28/2022', 'BSTDE60412', '04/01/2022', 1, 0.0060000000000000001, 7136.5062020159412)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222054, 2220541, 1, '02/28/2022', 'BESTR40517', '05/01/2022', 1, 0.0040000000000000001, 3556.6168576778532)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222112, 2221121, 1, '02/28/2022', 'BBNS-M0412', '04/01/2022', 1, 0.0050000000000000001, 17144.657287708753)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222142, 2221421, 1, '02/28/2022', 'BCHIUK0611', '06/01/2022', 1, 0.0048999999999999998, 710.26026361782147)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222153, 2221531, 1, '02/28/2022', 'BBNS-N0712', '07/01/2022', 1, 0.0060000000000000001, 53075.078447913816)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222282, 2222821, 1, '02/28/2022', 'BBNS-M0412', '04/01/2022', 1, 0.0073000000000000001, 2138.1887935753116)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222285, 2222851, 1, '02/28/2022', 'BBNS-M0412', '04/01/2022', 1, 0.0068999999999999999, 6417.1146243968988)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222287, 2222871, 1, '02/28/2022', 'BBNS-N0712', '07/01/2022', 1, 0.0074000000000000003, 2120.0527662736272)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222324, 2223241, 1, '02/28/2022', 'BBNS-M0412', '04/01/2022', 1, 0.0069999999999999993, 12120.012816968883)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222331, 2223312, 2, '02/28/2022', 'BBNS-M0412', '04/01/2022', 1, 0.0074999999999999997, 7125.8811307474307)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222362, 2223621, 1, '02/28/2022', 'BBNS-M0412', '04/01/2022', 1, 0.0055000000000000014, 7140.0549370741301)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222518, 2225181, 1, '02/28/2022', 'BSTDE60412', '04/01/2022', 1, 0.010500000000000001, 8525.6707442589286)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222529, 2225291, 1, '02/28/2022', 'BESTR30317', '03/01/2022', 1, 0.012699999999999999, 4250.7610092139303)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222552, 2225521, 1, '02/28/2022', 'BESTR40517', '05/01/2022', 1, 0.010500000000000001, 706.74781298536675)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222583, 2225831, 1, '02/28/2022', 'BBNS-M0412', '04/01/2022', 1, 0.0090000000000000011, 71152.87650374668)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222584, 2225841, 1, '02/28/2022', 'BBNS-M0412', '04/01/2022', 1, 0.0097999999999999997, 7109.650662733251)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222899, 2228991, 1, '02/28/2022', 'BBCIB10517', '05/01/2022', 1, 0.0109, 42030.62811771586)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222971, 2229711, 1, '02/28/2022', 'BCHIUK0611', '06/01/2022', 1, 0.010500000000000001, 2825.2965408647601)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 222994, 2229941, 1, '02/28/2022', 'BESTR30317', '03/01/2022', 1, 0.01, 355.17703471544098)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 223037, 2230371, 1, '02/28/2022', 'BBBVJ90517', '05/09/2022', 1, 0.010200000000000001, 62028.345223819051)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 223045, 2230451, 1, '02/28/2022', 'BESTT10617', '06/01/2022', 1, 0.0095999999999999992, 14115.514063943892)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 223566, 2235661, 1, '02/28/2022', 'BCHIUK0611', '06/01/2022', 1, 0.0007000000000000001, 5705.9301579770981)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 224174, 2241741, 1, '02/28/2022', 'BESTT60817', '08/01/2022', 1, 0.001, 20900.743677285191)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 224179, 2241791, 1, '02/28/2022', 'BSTDP70315', '09/01/2022', 1, 0.00050000000000000001, 150311.97795939486)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 224206, 2242061, 1, '02/28/2022', 'BCHIUQ1011', '10/01/2022', 1, 0.0007000000000000001, 25096.999315616857)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 224210, 2242101, 1, '02/28/2022', 'BCHIUQ1011', '10/01/2022', 1, 0.0007000000000000001, 15775.256711672899)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 224236, 2242361, 1, '02/28/2022', 'BESTT60817', '08/01/2022', 1, 0.00089999999999999998, 129314.12937887677)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226055, 2260551, 1, '02/28/2022', 'BCHIUQ1011', '10/01/2022', 1, -0.0035999999999999999, 11522.425744418471)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226056, 2260561, 1, '02/28/2022', 'BBNS-N0712', '07/01/2022', 1, -0.0035999999999999999, 7144.8586803962698)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226254, 2262541, 1, '02/28/2022', 'BBCIB10517', '05/01/2022', 1, -0.0028, 79890.121021733896)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226295, 2262951, 1, '02/28/2022', 'BSTD080216', '08/01/2023', 1, -0.0020999999999999999, 7105.7977397245713)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226381, 2263811, 1, '02/28/2022', 'BCHIEA0617', '06/01/2023', 1, -0.0040999999999999986, 2140.2832050504744)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226381, 2263812, 2, '02/28/2022', 'BCHIDY0917', '09/01/2022', 1, -0.0046999999999999993, 716.68305165097013)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226419, 2264191, 1, '02/28/2022', 'BBBVK30212', '02/01/2023', 1, -0.0043, 7123.7473950987951)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226419, 2264192, 2, '02/28/2022', 'BBNS-M0412', '04/01/2022', 1, -0.0045000000000000014, 721.17782413139503)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226419, 2264193, 3, '02/28/2022', 'BCHIUK0611', '06/01/2022', 1, -0.0046999999999999993, 717.11096042353904)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226419, 2264195, 5, '02/28/2022', 'BCHIUQ1011', '10/01/2022', 1, -0.0046999999999999993, 2883.7900657827131)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226419, 2264196, 6, '02/28/2022', 'BESTR40517', '05/01/2022', 1, -0.0040000000000000001, 717.03681227079619)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226434, 2264341, 1, '02/28/2022', 'BSTDEF0114', '01/01/2024', 1, -0.0030000000000000001, 4282.3048619565516)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226434, 2264342, 2, '02/28/2022', 'BCHIUR1011', '10/01/2023', 1, -0.0033, 2159.8045448141424)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226453, 2264531, 1, '02/28/2022', 'BCHIBE1115', '11/01/2022', 1, -0.0047999999999999996, 9325.9997316485515)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226454, 2264541, 1, '02/28/2022', 'BBBVK30212', '02/01/2023', 1, -0.0050000000000000001, 3920.8174920923911)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226454, 2264542, 2, '02/28/2022', 'BCHIUQ1011', '10/01/2022', 1, -0.0053, 7213.8238987695231)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226454, 2264543, 3, '02/28/2022', 'BSTDE60412', '04/01/2022', 1, -0.0045999999999999999, 721.25027518867182)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226544, 2265441, 1, '02/28/2022', 'BCHIEA0617', '06/01/2023', 1, -0.0078000000000000014, 7160.8816920545069)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226624, 2266241, 1, '02/28/2022', 'BCHIBF0915', '09/01/2023', 1, -0.0094999999999999998, 36199.569411681492)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226670, 2266701, 1, '02/28/2022', 'BBNS-Q0513', '05/01/2023', 1, -0.0111, 37665.171214121801)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226701, 2267011, 1, '02/28/2022', 'BBNSAK0118', '07/01/2023', 1, -0.0118, 41678.433897207193)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226830, 2268301, 1, '02/28/2022', 'BESTS80517', '05/01/2024', 1, -0.01, 43296.738257405304)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 226890, 2268901, 1, '02/28/2022', 'BESTS80517', '05/01/2024', 1, -0.0086, 381914.4402461506)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 229546, 2295461, 1, '02/28/2022', 'BSTD070216', '02/01/2023', 1, -0.0080000000000000002, 107216.94243433133)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 229607, 2296071, 1, '02/28/2022', 'BBNS-Q0513', '05/01/2023', 1, -0.001, 71700.715741982494)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 229609, 2296091, 1, '02/28/2022', 'BESTS20317', '03/01/2023', 1, -0.0015, 71853.541541735118)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 230492, 2304921, 1, '02/28/2022', 'BBNS-Q0513', '05/01/2023', 1, 0.0055000000000000014, 87621.768754128119)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 230494, 2304941, 1, '02/28/2022', 'BBNSAK0118', '07/01/2023', 1, 0.0080000000000000002, 107080.72511866213)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 230500, 2305001, 1, '02/28/2022', 'BCHIUS0212', '02/01/2023', 1, 0.0055000000000000014, 70563.669750923014)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'CLF', 230511, 2305111, 1, '02/28/2022', 'BSTDSA0714', '07/01/2024', 1, 0.020400000000000001, 330335.108399891)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'USD', 4101, 41011, 1, '02/28/2022', 'CHILE 3.24', '02/06/2028', 1, 0.032469999999999999, 2205.796604316723)  
  
  
INSERT INTO #ValorDet (Cartera, Moneda, N_Documento, valor, correlativo, Fecha_Proceso, Serie, Fecha_Vcto, Fase_Deterioro, Tasa_de_Interes, Provision)  
VALUES ('P', 'USD', 4157, 41571, 1, '02/28/2022', 'NOTEX', '04/28/2022', 1, 0.00055000000000000003, 616863.51346754783)  
  
  
------------------------------------  
  
   
          
--        select * from BacTraderSuda.dbo.Fechas_Proceso where acfecproc = @Fecha_Interfaz  
  
  select @dFechaMercado   = case when month(acfecproc) <> month(acfecprox)   
         then dateadd(day,-1,dateadd(month,1,dateadd(day,1,dateadd(day,(day(acfecproc)*-1),acfecproc))))      
         else acfecproc    end      
  ,  @dFechacartera   = acfecprox  
  from BacTraderSuda.dbo.Fechas_Proceso       
  where acfecproc = @Fecha_Interfaz      
  
--select @dFechaMercado,@Fecha_Interfaz,@dFechacartera  
--SET  @dFechacartera='20220201'  
  
set @dFechaUltimoDiaMes=dateadd(day,-1,convert(char(4),datepart(year,dateadd(month, 1,@Fecha_Interfaz)))+right('0'+convert(varchar(2),datepart(month,dateadd(month, 1,@Fecha_Interfaz))),2)+'01')  
  
if @Fecha_Interfaz=@dFechaUltimoDiaMes or @dFechacartera > @dFechaUltimoDiaMes  
begin  
  set  @bUltimoDiahabilMes=1  
end  
  
 --rescata VM UF      
    SELECT @nValorUF         = vmvalor FROM         BacParamSuda..VALOR_MONEDA      
    WHERE  vmfecha    = @dFechacartera AND   vmcodigo = 998      
          
--20211223.RCHS Cambios Estructura P40 / Circular N°2.301 - CMF ( cambios en la estructura del archivo P40 )  
--Se rescata última fecha hábil del mes en curso.   
--exec BactraderSuda..SP_ULTIMODIA  @Fecha_Interfaz, 'S', @dFechaUltimoDiaHabilMes out  
--Se establece variable para control y evaluación posterior.  
--if DATEDIFF ("d",@Fecha_Interfaz,@dFechaUltimoDiaHabilMes)=0  
--  set  @bUltimoDiahabilMes=1  
  
 CREATE TABLE #TABLA_P40_MX         
 (  Tipo_Registro         varchar(2) NOT NULL ,  --1        
   Codigo_Tenedor         char(4)  NOT NULL ,  -- 20211223.RCHS Cambios Estructura P40 char(3)      NOT NULL ,       --2        
   Fecha_Proceso          char(8)   NULL ,      --3        
   Fecha_Compra           char(8)    NULL ,       --4        
   Tipo_Cartera           numeric(5)     NOT NULL ,       --5        
   Emisor                 varchar (10)   NULL ,       --6        
   Pais_Emisor            int    NOT NULL ,       --7        
   Familia_Instrumento    VARCHAR(2)  NOT NULL ,       --8        
   Nemotecnico            char (20)   NULL ,       --9        
   Tipo_Rendimiento       int    NOT NULL ,       --10        
   Periodicidad_Cupon     decimal(5, 0)  NULL ,       --11        
   Fecha_Ultimo_Cupon     char (8)    NULL ,       --12        
   Fecha_Proximo_Cupon    char (8)    NULL ,       --13        
   Fecha_Vcto_Instr       char (8)    NULL ,       --14        
   Derivado_Incrust_Opc   char(2)   NOT NULL ,       --15        
   Nominal_Inicial        numeric(19, 4)  NULL ,       --16        
   Nominal_Actual         numeric(19, 4)  NULL ,       --17        
   Moneda_Emision         numeric(3, 0) NOT NULL ,       --18        
   Moneda_Reajuste        VARCHAR(3)  NOT NULL ,       --19        
   Tipo_Tasa_Emision      char(7)    NULL ,       --20        
   Tasa_Emision           numeric(9, 4) NOT NULL ,       --21        
   Tera                   decimal(8, 4)  NULL ,       --22        
   Valor_Par              numeric(18,4)  NULL ,       --23        
   Tipo_Tasa_Compra       char(7)    NULL ,       --24        
   Tasa_Compra            numeric(9, 4) NOT NULL ,       --25        
   Costo_Adquisicion      numeric(19, 4) NOT NULL ,       --26        
   Costo_Amortizado       numeric(14, 0)  NULL ,       --27        
   Valor_Razonable        numeric(19, 4)  NULL ,       --28        
   Tipo_Tasa_Valoriza     varchar(7)   NULL ,       --29        
   Tasa_Valorizacion      numeric(19, 4)  NULL ,       --30        
   Tipo_valorizacion      int    NOT NULL ,       --31        
   Precio_Instrumento     numeric(6, 2) NOT NULL ,       --32 (19, 8)        
   Duracion_Modificada    numeric(24,8) NOT NULL ,      --33        
   Convexidad             numeric(24,8) NOT NULL ,       --34        
   Valor_Deterioro        numeric(14, 0)  NULL ,       --35        
   Condicion_Instrumento  int    NOT NULL ,       --36        
   Fecha_Inicio_Cond      char (8)    NULL ,       --37        
   Fecha_Final_Cond       char (8)    NULL ,       --38        
      
   iCantidad    INT     NULL ,       --38      
   signoTCmp    CHAR(1)   NOT NULL,   --39      
   signoTVal    CHAR(1)   NOT NULL,        --40      
      
   Cartera     numeric (5)  NOT NULL ,       --41                
   numero_Documento       numeric(10, 0) NOT NULL ,   --42      
   Correlativo            numeric(10, 0) NOT NULL ,   --43      
   Numero_Operacion       numeric(10, 0) NOT NULL ,       --44      
   Seriado                CHAR(1)   NOT NULL ,   --45      
   Serie                  VARCHAR(20)  NOT NULL ,       --46      
   Familia                NUMERIC(10)      NOT NULL ,   --47      
   IdFila                 INT    Identity(1, 1)         
     
 )         
      
select        
  Tipo_Registro    = convert(char(2),  Ret.Tipo_Registro   )    --1      
 , Codigo_Tenedor   = convert(char(4),  Ret.Codigo_Tenedor   )    -- 20211223.RCHS convert(char(3),  Ret.Codigo_Tenedor   )    --2      
 , Fecha_Proceso   = convert(char(8),  Ret.Fecha_Proceso   )    --3      
 , Fecha_Compra    = convert(char(8),  Ret.Fecha_Compra   )    --4      
 , Tipo_Cartera    = convert(numeric(5),  Ret.Tipo_Cartera   )    --5      
 , Emisor     = convert(varchar(10), Ret.Emisor     )    --6      
 , Pais_Emisor    = convert(numeric(3),  Ret.Pais_Emisor    )    --7      
 , Familia_Instrumento  = convert(char(2),  Ret.Familia_Instrumento  )    --8      
 , Nemotecnico    = convert(char(20),  Ret.Nemotecnico    )    --9      
 , Tipo_Rendimiento   = convert(char(1),  Ret.Tipo_Rendimiento  )    --10      
 , Periodicidad_Cupon  = convert(char(1),  Ret.Periodicidad_Cupon  )    --11      
 , Fecha_Ultimo_Cupon  = convert(char(8),  Ret.Fecha_Ultimo_Cupon  )    --12      
 , Fecha_Proximo_Cupon  = convert(char(8),  Ret.Fecha_Proximo_Cupon  )    --13      
 , Fecha_Vcto_Instr   = convert(char(8),  Ret.Fecha_Vcto_Instr  )    --14      
 , Derivado_Incrust_Opc  = convert(char(2),  Ret.Derivado_Incrust_Opc )    --15      
 , Nominal_Inicial   = convert(numeric(19,4), Ret.Nominal_Inicial   )    --16       
 , Nominal_Actual   = convert(numeric(19,4), Ret.Nominal_Actual   )    --17      
 , Moneda_Emision   = convert(varchar(3),  Ret.Moneda_Emision   )    --18      
 , Moneda_Reajuste   = convert(varchar(3),  Ret.Moneda_Reajuste   )    --19      
 , Tipo_Tasa_Emision  = convert(varchar(7),  Ret.Tipo_Tasa_Emision  )    --20      
 , Tasa_Emision    = convert(numeric(9,4), Ret.Tasa_Emision   )    --21      
 , Tera      = convert(numeric(8,4), Ret.Tera     )    --22      
 , Valor_Par    = convert(numeric(18,4), Ret.Valor_Par    )    --23      
 , Tipo_Tasa_Compra   = convert(char(7),  Ret.Tipo_Tasa_Compra  )    --24      
 , Tasa_Compra    = convert(numeric(9,4), Ret.Tasa_Compra    )    --25      
 , Costo_Adquisicion  = convert(numeric(19,4), Ret.Costo_Adquisicion  )    --26      
 , Costo_Amortizado   = convert(numeric(14,0), Ret.Costo_Amortizado  )    --27      
 , Valor_Razonable   = convert(numeric(19,4), Ret.Valor_Razonable   )    --28      
 , Tipo_Tasa_Valoriza  = convert(varchar(7),  Ret.Tipo_Tasa_Valoriza  )    --29      
 , Tasa_Valorizacion  = convert(numeric(19,4), Ret.Tasa_Valorizacion  )    --30      
 , Tipo_valorizacion  = convert(int,   Ret.Tipo_valorizacion  )    --31      
 , Precio_Instrumento  = convert(float, Ret.Precio_Instrumento  )    --convert(numeric(6,2), Ret.Precio_Instrumento  )    --32      
 , Duracion_Modificada  = convert(numeric(24,8), Ret.Duracion_Modificada  )    --33      
 , Convexidad    = convert(numeric(24,8), Ret.Convexidad    )    --34      
 , Valor_Deterioro   = convert(numeric(14,0), Ret.Valor_Deterioro   )    --35      
 , Condicion_Instrumento = convert(int,   Ret.Condicion_Instrumento )    --36      
 , Fecha_Inicio_Cond  = convert(char(8),  Ret.Fecha_Inicio_Cond  )    --37      
 , Fecha_Final_Cond   = convert(char(8),  Ret.Fecha_Final_Cond  )    --38      
 , iCantidad    = BACTRADERSUDA.dbo.Fx_ReplicaId(Ret.iCantidad, ROW_NUMBER() over( order by Ret.iCantidad desc )) --39      
 , signoTCmp    = Ret.signoTCmp          --40      
 , signoTVal    = Ret.signoTVal          --41      
      
 , cartera     = ret.cartera         --42  
 , numdocu     = ret.numdocu         --43  
 , correla     = ret.Correlativo        --44    
 , numoper     = ret.numoper         --45  
 , estado     = ret.estado         --46  
 , Seriado     = convert(char(1), Ret.Seriado)     --47  
 , Valor_mercado   = convert(numeric(19,4),Ret.Valor_mercado)  --48  
 , Cliente     = Ret.Cliente         --49  
 , CodCliente    = Ret.CodCliente        --50  
 -- 20211223.RCHS Cambios Estructura P40 / Circular N°2.301 - CMF ( cambios en la estructura del archivo P40 )  
 , Jerarquia_vrazonable  = convert(int,Ret.Jerarquia_vrazonable)         --51  
 , Valor_deterioro_Rie_Cre = convert(int,ret.Valor_deterioro_Rie_Cre)         --52  
 , Apli_sup_Ins_Rie_Cre  = convert(int,ret.Apli_sup_Ins_Rie_Cre)         --53  
 , Costo_adq_Act_conta  = convert(numeric(14,0),ret.Costo_adq_Act_conta) --54  
  
into #tmp      
from (      
 select Tipo_Registro    = TmpP40.Tipo_Registro      
  , Codigo_Tenedor    = TmpP40.Codigo_Tenedor      
  , Fecha_Proceso    = TmpP40.Fecha_Proceso      
  , Fecha_Compra    = TmpP40.Fecha_Compra      
  , Tipo_Cartera    = TmpP40.Tipo_Cartera      
  , Emisor      = TmpP40.Emisor      
  , Pais_Emisor     = TmpP40.Pais_Emisor      
  , Familia_Instrumento   = TmpP40.Familia_Instrumento      
  , Nemotecnico     = TmpP40.Nemotecnico      
  , Tipo_Rendimiento   = TmpP40.Tipo_Rendimiento      
     
  , Periodicidad_Cupon   = case when TmpP40.Tipo_Rendimiento = 1 then 0      
            else TmpP40.xPeriodicidad      
           end      
      
  , Fecha_Ultimo_Cupon   = case when TmpP40.Tipo_Rendimiento = 1 then '00000000'      
            else TmpP40.Fecha_Ultimo_Cupon      
           end      
  , Fecha_Proximo_Cupon   = case when TmpP40.Tipo_Rendimiento = 1 then '00000000'       
            else TmpP40.Fecha_Proximo_Cupon      
           end      
      
  , Fecha_Vcto_Instr   = TmpP40.Fecha_Vcto_Instr      
  , Derivado_Incrust_Opc  = TmpP40.Derivado_Incrust_Opc      
  , Nominal_Inicial    = TmpP40.Nominal_Inicial      
  , Nominal_Actual    = TmpP40.Nominal_Actual      
  , Moneda_Emision    = TmpP40.Moneda_Emision      
  , Moneda_Reajuste    = TmpP40.Moneda_Reajuste      
  , Tipo_Tasa_Emision   = TmpP40.Tipo_Tasa_Emision      
  , Tasa_Emision    = abs( TmpP40.Tasa_Emision )      
  , Tera      = abs( TmpP40.Tera )      
  , Valor_Par     = TmpP40.Valor_Par      
  , Tipo_Tasa_Compra   = TmpP40.Tipo_Tasa_Compra      
  , Tasa_Compra     = abs( TmpP40.Tasa_Compra )      
  , Costo_Adquisicion   = TmpP40.Costo_Adquisicion      
  , Costo_Amortizado   = TmpP40.Costo_Amortizado      
  , Valor_Razonable    = TmpP40.Valor_Razonable      
  , Tipo_Tasa_Valoriza   = TmpP40.Tipo_Tasa_Valoriza      
  , Tasa_Valorizacion   = case when abs(TmpP40.Tasa_Valorizacion) > 100 then abs(TmpP40.Tasa_Valorizacion) - abs((100 - abs(TmpP40.Tasa_Valorizacion))-1)      
            else abs(TmpP40.Tasa_Valorizacion)      
            end      
  , Tipo_valorizacion   = TmpP40.Tipo_valorizacion      
  , Precio_Instrumento   = abs( TmpP40.Precio_Instrumento )      
  , Duracion_Modificada   = TmpP40.Duracion_Modificada      
  , Convexidad     = TmpP40.Convexidad      
  , Valor_Deterioro    = TmpP40.Valor_Deterioro      
  , Condicion_Instrumento  = TmpP40.Condicion_Instrumento      
  , Fecha_Inicio_Cond   = TmpP40.Fecha_Inicio_Cond      
  , Fecha_Final_Cond   = TmpP40.Fecha_Final_Cond      
  , Filler      = TmpP40.Filler      
  , numero_Documento   = TmpP40.numero_Documento      
  , Correlativo     = TmpP40.Correlativo      
  , Numero_Operacion   = TmpP40.Numero_Operacion      
  , Seriado      = TmpP40.Seriado      
  , Codigo      = TmpP40.Codigo      
  , Serie      = TmpP40.Serie      
  , FecCupVen     = TmpP40.FecCupVen      
  , FechaEmision    = TmpP40.FechaEmision      
  , NomOriginal     = TmpP40.NomOriginal      
  , rutcart      = TmpP40.rutcart      
  , signoTCmp     = CASE WHEN TmpP40.Tasa_Compra       >= 0 THEN '+' ELSE '-' END                                                        -- 35. Signo Tasa Compra          
  , signoTVal     = CASE WHEN TmpP40.Tasa_Valorizacion >= 0 THEN '+' ELSE '-' END                     -- 36. Signo Tasa Valorizacion          
  , iCantidad     = TmpP40.iCantidad      
        
  , estado      = TmpP40.viestado      
  , cartera      = TmpP40.cartera      
  , numdocu      = TmpP40.numdocu      
  , numoper      = TmpP40.numoper      
  , Valor_mercado    = TmpP40.Valor_mercado      
  ,  Cliente =TmpP40.Cliente    
  ,  CodCliente=TmpP40.CodCliente    
  
  -- 20211223.RCHS Cambios Estructura P40 / Circular N°2.301 - CMF ( cambios en la estructura del archivo P40 )  
  , Jerarquia_vrazonable = TmpP40.Jerarquia_vrazonable  
  , Valor_deterioro_Rie_Cre = case when TmpP40.Tipo_Cartera in (2,3) then 1 else 0 end  
  , Apli_sup_Ins_Rie_Cre = Apli_sup_Ins_Rie_Cre--case when TmpP40.Tipo_Cartera in (2,3) then ( case when rtrim(TmpP40.Emisor) in ('608050000','970290001') then 1 else 4 end ) else 0 end  
  , Costo_adq_Act_conta  = TmpP40.Costo_adq_Act_conta  
 from (      
      
  SELECT 'Tipo_Registro'    = '01'      
  ,  'Codigo_Tenedor'   = '0039' --20200514.RCHS AJUSTES P40 '027'      
  ,  'Fecha_Proceso'    = CONVERT(CHAR(8), @Fecha_Interfaz, 112)      
  ,  'Fecha_Compra'    = CONVERT(CHAR(10), MDRS.rsfeccomp,  112)      
  ,  'Tipo_Cartera'    = CASE WHEN MDRS.codigo_carterasuper = 'A' THEN 3      
       WHEN MDRS.codigo_carterasuper = 'P' THEN 2      
       WHEN MDRS.codigo_carterasuper in ('T','R') THEN 1      
       ELSE                                     9     
       END      
  ,  'Emisor'     = CONVERT(VARCHAR(11), REPLICATE('0',(9 -LEN(LTRIM(RTRIM(STR( ltrim(rtrim( MDRS.rsrutemis )) ))))))       
                + LTRIM(RTRIM(STR( ltrim(rtrim( MDRS.rsrutemis )) )))       
                + ltrim(rtrim( Emisor.emdv )) )      
  ,  'Pais_Emisor'    = 160      
  ,  'Familia_Instrumento'  = CASE WHEN Emisor.emrut = 97029000     THEN '01'      
             WHEN Emisor.emrut = 60805000     THEN '01'      
             WHEN Emisor.emrut = 61533000     THEN '03'      
             WHEN MDRS.rscodigo = 20      THEN '04'      
             WHEN MDRS.rscodigo IN (9,11)     THEN '10'      
             WHEN MDRS.rscodigo = 15 AND Emisor.emtipo = 1 THEN '06'      
             WHEN MDRS.rscodigo = 15 AND Emisor.emtipo = 2 THEN '08'      
             WHEN MDRS.rscodigo = 15 AND Emisor.emtipo = 4 THEN '52'      
             ELSE             '00'      
            END      
  ,  'Nemotecnico'    =  (CASE WHEN  INST.inmdse = 'S' THEN rsinstser      
              WHEN  INST.inmdse = 'N' AND rscodigo = 9  THEN 'FN' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,3) + '-' + SUBSTRING(rsinstser,5,6)          
              WHEN  INST.inmdse = 'N' AND rscodigo = 11 THEN 'FU' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,3) + '-' + SUBSTRING(rsinstser,5,6)      
              WHEN  INST.inmdse = 'N' AND rscodigo = 13 THEN 'F*' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,3) + '-' + SUBSTRING(rsinstser,5,6)      
              WHEN  INST.inmdse = 'N' AND rscodigo = 6  THEN 'BNPDBC' + SUBSTRING(rsinstser,5,6)      
              WHEN  INST.inmdse = 'N' AND rscodigo = 16 THEN 'SN' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,4) +  SUBSTRING(rsinstser,5,6)          
              WHEN  INST.inmdse = 'N' AND rscodigo = 17 THEN 'SU' + SUBSTRING((SELECT TOP 1 bolsa FROM BACPARAMSUDA..SINACOFI WHERE clrut=rsrutemis),1,4) +  SUBSTRING(rsinstser,5,6)          
              ELSE  Convert(Char(20), rsinstser ) END)       
  ,  'Tipo_Rendimiento'   = CASE WHEN INST.inmdse  = 'N' THEN 1      
             WHEN SERIE.secupones <= 1    THEN 1      
             WHEN SERIE.senumamort = 1  THEN 2      
             WHEN INST.incodigo  = 20 THEN 3      
             ELSE         9          
            END      
      
  ,  'Periodicidad_Cupon'  = CASE WHEN INST.inmdse = 'N' THEN 0           
             ELSE SERIE.SePeriodicidad      
            END      
  ,  'Fecha_Ultimo_Cupon'  = CASE WHEN INST.inmdse = 'N' THEN '19000101' ELSE CONVERT(CHAR(08), BACTRADERSUDA.dbo.Fx_P40_Fecha( MDRS.rscodigo, MDRS.rsinstser, MDRS.rsfecha, MDRS.rsnominal, MDRS.rsfecemis), 112) end      
  ,  'Fecha_Proximo_Cupon'  = CASE WHEN INST.inmdse = 'N' THEN '19000101' ELSE CONVERT(CHAR(08), MDRS.rsfecpcup, 112) END      
  ,  'Fecha_Vcto_Instr'   = CONVERT(CHAR(08), MDRS.rsfecvcto, 112)      
  ,  'Derivado_Incrust_Opc'  = CASE WHEN MDRS.rscodigo = 20 THEN '02' ELSE '01' END      
      
  ,  'Nominal_Inicial'   = CONVERT(NUMERIC(19,4), MDRS.rsnominal)      
  ,  'Nominal_Actual'   = case when INST.inmdse = 'S' then BACTRADERSUDA.dbo.Fx_P40_Nominal ( rscodigo, rsinstser, rsfecucup, rsnominal, rsfecemis )      
             else convert(numeric(19,4), VMERC.valor_nominal )      
            end      
      
  ,  'Moneda_Emision'   = case when INST.inmdse = 'N' then NOSERIE.nsmonemi      
             else case when MDRS.rscodigo = 20 then 998 else MDRS.rsmonemi end-- INST.inmonemi end      
            end      
      
  ,  'Moneda_Reajuste'   = CASE WHEN MDRS.rscodigo = 20  THEN 998 ELSE  MDRS.rsmonemi end--INST.inmonemi END      
      
  ,  'Tipo_Tasa_Emision'   = case when INST.inmdse = 'N' then '1' + NOSERIE.SeIndN      
                     + '9' + NOSERIE.NsIndC + '000'      
             else case when Datediff(Day, SERIE.sefecemi, SERIE.sefecven) > 365 then '12'      
                else               '11'       
               end + SERIE.SeIndPc + '000'      
            end      
      
  ,  'Tasa_Emision'    = CASE WHEN MDRS.rscodigo = 888         THEN 4.0 --> BR      
             WHEN MDRS.rscodigo = 37          THEN 0.0 --> XERO      
             WHEN MDRS.rscodigo = 300         THEN 0.0 --> CERO      
             WHEN MDRS.rscodigo = 301         THEN 0.0 --> ZERO      
             WHEN MDRS.rscodigo IN(3,9,11,12,13,14, 18,19, 50,51,52, 54) THEN 0.0 --> DP%      
             WHEN INST.inmdse = 'S' and SERIE.setasemi = 0   THEN MDRS.rstir       
             WHEN INST.inmdse = 'S' and SERIE.setasemi <> 0   THEN SERIE.setasemi      
      
             WHEN INST.inmdse = 'N' and NOSERIE.nstasemi = 0   THEN MDRS.rstir      
             WHEN INST.inmdse = 'N' and NOSERIE.nstasemi <> 0   THEN NOSERIE.nstasemi      
             ELSE MDRS.rstasemi      
            END      
      
  ,  'Tera'      = case when INST.inmdse = 'S' and SERIE.setera  = 0 then MDRS.rstir      
             when INST.inmdse = 'S' and SERIE.setera  <> 0 then SERIE.setera      
                   
             when INST.inmdse = 'N' and NOSERIE.nstasemi = 0 then MDRS.rstir      
             when INST.inmdse = 'N' and NOSERIE.nstasemi <> 0 then NOSERIE.nstasemi      
            END      
      
      
      
  ,  'Valor_Par'     =   ( case when INST.inmdse = 'S' then (valor_par * rsnominal) / 100.0--then (rsvpcomp * rsnominal) / 100.0      
              else rsnominal    end )       
 /* ,  'Valor_Par'     =  valor_par*/       
  ,  'Tipo_Tasa_Compra'   = case when INST.inmdse = 'N' then '1' + NOSERIE.SeIndN + '9' + NOSERIE.NsIndC + '000'      
             else case when Datediff(Day, SERIE.sefecemi, SERIE.sefecven) > 365 then '12'      
                else '11' end + SERIE.SeIndPc + '000'      
            end      
      
  ,  'Tasa_Compra'    = MDRS.rstir      
  ,  'Costo_Adquisicion'   = CASE WHEN INST.inmonemi in (999,998,994,997) THEN MDRS.rsvalcomp ELSE 0 END --MDRS.rsvalcomp      
                   
  ,  'Costo_Amortizado'   = CASE WHEN MDRS.codigo_carterasuper in ('A','P') THEN MDRS.rsvalcomp ELSE 0 END      
  ,  'Valor_Razonable'   =  ISNULL(VMERC.valor_mercado, 0.0)      
      
  ,  'Tipo_Tasa_Valoriza'  = case when INST.inmdse = 'N' then '1' + NOSERIE.SeIndN + '9' + NOSERIE.NsIndC + '000'      
             else case when Datediff(Day, SERIE.sefecemi, SERIE.sefecven) > 365 then '12'      
                else '11'       
               end + SERIE.SeIndPc + '000'      
            end      
      
  ,  'Tasa_Valorizacion'   = ISNULL( VMERC.tasa_mercado, 0.0)      
  ,  'Tipo_valorizacion'   = CASE WHEN VMERC.OrigenCurva = 'MC' THEN 3 ELSE 2 END      
      
  ,  'Precio_Instrumento'  = CASE WHEN MDRS.rscodigo = 888 THEN ROUND(MDRS.rsvpcomp, 2)  --precio      
             WHEN MDRS.rscartera = 111 THEN ROUND(MDRS.rsvpcomp, 2)       
             WHEN MDRS.valor_par = 0  THEN ROUND(MDRS.rstir, 2)      
             ELSE           ROUND(MDRS.valor_par, 2)      
            END      
       
  ,  'Duracion_Modificada'  = CASE WHEN CONVERT(NUMERIC(24,2),ISNULL(VMERC.Duration_Mod, 0)) = 0 THEN 0.01      
             ELSE CONVERT(NUMERIC(24,2),ISNULL(VMERC.Duration_Mod, 0))       
            END      
      
  ,  'Convexidad'    = convert(numeric(24,8), CASE WHEN isnull(VMERC.Convexidad, 0.0) = 0.0 THEN 0.01      
                   ELSE isnull(VMERC.Convexidad, 0.0)      
                  END )      
      
  ,  'Valor_Deterioro'   = convert(numeric(14),round(isnull(provision,0),0))  
  ,  'Condicion_Instrumento'  = CASE WHEN MDRS.rscartera = '111' THEN 1       
             WHEN MDRS.rscartera = '114' THEN 2       
             WHEN MDRS.rscartera = '159' THEN 3       
             else 0 END --20200430.RCHS. AJUSTES P40 CASE WHEN MDRS.rscartera = '111' THEN 1 ELSE 2 END      
      
  ,  'Fecha_Inicio_Cond'   = case when MDRS.rscartera = '111' then '00000000' --20200616.RCHS. AJUSTES P40 convert(char(08), MDVI.vifecinip, 112)      
             when MDRS.rscartera = '159' then convert(char(08), MDRS.rsfecinip, 112)      
             else case when MDRS.rscartera = '114' then convert(char(08), MDRS.rsfecinip, 112)      
                else '00000000'      
               end      
            end      
  ,  'Fecha_Final_Cond'   = case when MDRS.rscartera = '111' then '00000000'--20200616.RCHS. AJUSTES P40 convert(char(08), MDVI.vifecvenp, 112)      
             when MDRS.rscartera = '159' then convert(char(08), MDRS.rsfecvtop, 112)        
             else case when MDRS.rscartera = '114' then convert(char(08), MDRS.rsfecvtop, 112)      
                else '00000000'      
               end      
            end      
      
  ,  'Filler'     = ' '      
  ,  'Numero_Documento'   = MDRS.rsnumdocu          
  ,  'Correlativo'    = MDRS.rscorrela          
  ,  'Numero_Operacion'   = CASE WHEN MDRS.rscartera ='111' THEN MDRS.rsnumdocu ELSE MDRS.rsnumoper END      
  -->>>> Agregado para su uso mas adelante <<<<--          
  ,  'Seriado'     = INST.inmdse      
  ,  'Codigo'     = INST.incodigo      
  ,  'Serie'      = MDRS.rsinstser      
  ,  'FecCupVen'     = MDRS.rsfecucup      
  ,  'FechaEmision'    = MDRS.rsfecemis      
  ,  'NomOriginal'    = MDRS.rsnominal      
  ,  'Rutcart'     = MDRS.rsrutcart      
  -->>>> Agregado para su uso mas adelante <<<<--          
  ,  'xPeriodicidad'    = case when INST.inmdse = 'S' then SERIE.SePeriodo else NOSERIE.NsPeriodo end      
  ,  'iCantidad'     = ROW_NUMBER() over( order by MDRS.rsnumoper, MDRS.rsnumdocu, MDRS.rscorrela)      
  ,  'viestado'     = mdvi.viEstado      
  ,  'cartera'     = mdrs.rscartera      
  ,  'numdocu'     = mdrs.rsnumdocu      
  ,  'numoper'     = mdrs.rsnumoper      
  ,  'Valor_mercado'    = VMERC.valor_mercado      
  ,  'Cliente' =CAST(CLIEN.Clrut AS VARCHAR(9)) + CLIEN.Cldv
  ,  'CodCliente'=CLIEN.Clcodigo      
   -- 20211223.RCHS Cambios Estructura P40 / Circular N°2.301 - CMF ( cambios en la estructura del archivo P40 )  
  , 'Jerarquia_vrazonable'  =  case when @bUltimoDiahabilMes=1 AND MDRS.rscodigo IN (32,33,34,36,40,98)     THEN '1'  
           when @bUltimoDiahabilMes=1 AND MDRS.rscodigo IN (1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,38,39,50,51,52,54) THEN '2'  
         ELSE   
          '1'  
         END  
  , 'Valor_deterioro_Rie_Cre' = CASE WHEN MDRS.codigo_carterasuper in ('P','A') THEN 1 ELSE 0 END  
  , 'Apli_sup_Ins_Rie_Cre'  = CASE WHEN MDRS.codigo_carterasuper in ('P','A') THEN ( case when MDRS.rsrutemis in (60805000,97029000) then 1 else 2 end ) ELSE 0 END  
  , 'Costo_adq_Act_conta'  = case when @bUltimoDiahabilMes=1 AND MDRS.codigo_carterasuper IN('P','A') then (rsvppresen  + rsinteres + rsreajuste + vmerc.diferencia_mercado)  
          ELSE     
          0      
          END    
    FROM  ( select rsfecha, rstipoper, rscartera, rsnominal, rstir,  rsvppresen      
      , rsnumoper, rsnumdocu, rscorrela, rsfecucup, rsfecpcup, rstasemi      
      , rsfecinip, rsfecvtop, rsfecemis, rscodigo,  rsrutemis, rsrutcart      
      , rsvalcomp, rsinstser, rsrutcli,  rscodcli,  rsfeccomp, rsfecvcto      
      , codigo_carterasuper, valor_tasa_emision, valor_par, rsvpcomp  , rsmonemi , rsinteres , rsreajuste  
     from BacTraderSuda.dbo.Mdrs with(nolock)      
     where rsfecha     = @dFechacartera      
     and  MDRS.rsfecvcto     >= MDRS.rsfecha      
     and  MDRS.rstipoper   = 'DEV'      
     and  MDRS.rscartera   IN(111, 114, 159)--20200430.RCHS.AJUSTES P40 (INCLUSIÓN GTIAS.) IN(111, 114)      
     and  MDRS.rsnominal   > 0      
     and  MDRS.rscodigo     <> 98      
     AND not(MDRS.rscodigo   = 20       
      AND MDRS.rsrutemis   = (select acrutprop from BacTraderSuda.dbo.Mdac with(nolock) )      
       )      
    ) MDRS      
    --20200514.RCHS.AJUSTES P40 (MAY 4 DV) left Join ( select emrut, emdv, emtipo, emrutdv = ltrim(rtrim( emrut )) + ltrim(rtrim( emdv ))      
    left Join ( select emrut, UPPER(emdv) emdv, emtipo, emrutdv = ltrim(rtrim( emrut )) + ltrim(rtrim( emdv ))      
       from BacParamSuda.dbo.Emisor with(nolock)       
       ) Emisor   On Emisor.emrut = MDRS.rsrutemis      
      
    left Join ( Select incodigo, inmdse, inmonemi      
       from BacParamSuda.dbo.Instrumento with(nolock)      
       )  INST  On INST.incodigo = rscodigo      
      
    Left Join ( Select secodigo, seserie, secupones, senumamort, sepervcup, sefecemi, sefecven, setera, setasemi      
        , SeIndPc   = case when sepervcup = 1  then '1'      
               when sepervcup = 3  then '2'      
               when sepervcup = 4  then '3'      
               when sepervcup = 6  then '4'      
               when sepervcup = 12 then '5' else '9' end      
              --> Base del Instrumento (Nueva Definicion Carlos)       
             + case when sebasemi = 360 then '1'      
               when sebasemi = 365 then '2'      
               when sebasemi = 30 then '3' else '9' end      
--             + case when sebasemi = 360 then '4' else '9' end      
      
        , SePeriodicidad = case when sepervcup = 1  then 1      
               when sepervcup = 3  then 2      
               when sepervcup = 4  then 3      
               when sepervcup = 6  then 4      
               when sepervcup = 12 then 5 else 6 end      
      
        , SePeriodo  = case when sepervcup = 1  then '1'      
               when sepervcup = 3  then '2'      
               when sepervcup = 4  then '3'      
               when sepervcup = 6  then '4'      
               when sepervcup = 12 then '5' else '9' end      
       from BacParamSuda.dbo.Serie with(nolock)      
       )  SERIE  On SERIE.secodigo = MDRS.rscodigo      
            AND SERIE.seserie = CASE WHEN MDRS.rscodigo = 20 THEN SUBSTRING(MDRS.rsinstser,1,6) ELSE MDRS.rsinstser END      
      
    Left Join ( Select nsnumdocu, nscorrela, nsrutcart, nstasemi, nsmonemi      
        , NsIndC  = case when nsbasemi = 360 then '4' else '9' end      
      
        , SeIndN  = case when DateDiff( Day, nsfecemi, nsfecven ) > 365 then '2'      
               else '1' end      
        , NsPeriodo = '9'      
       from BacparamSuda.dbo.NoSerie with(nolock)      
       )  NOSERIE  On NOSERIE.nsnumdocu = MDRS.rsnumdocu      
            AND NOSERIE.nscorrela = MDRS.rscorrela      
            AND NOSERIE.nsrutcart = MDRS.rsrutcart      
      
    Left Join ( Select  clrut, clcodigo, cldv    
       from BacParamSuda.dbo.Cliente with(nolock)      
       )  CLIEN  On CLIEN.clrut  = MDRS.rsrutcli      
            AND CLIEN.clcodigo = MDRS.rscodcli      
      
    inner Join (Select fecha_valorizacion, rmnumoper, tipo_operacion, id_sistema, rmnumdocu, rmcorrela      
        , valor_mercado, tasa_mercado, OrigenCurva, Duration_Mod      
        , Convexidad  , diferencia_mercado, valor_nominal  
     From BacTraderSuda.dbo.Valorizacion_Mercado with(nolock)      
       )  VMERC  On VMERC.fecha_valorizacion = @dFechaMercado      
                 
            AND VMERC.id_sistema   = 'BTR'          
            AND VMERC.rmnumdocu   = MDRS.rsnumdocu       
            AND VMERC.rmcorrela   = MDRS.rscorrela       
            AND VMERC.rmnumoper   = MDRS.rsnumoper      
            AND VMERC.tipo_operacion = CASE WHEN MDRS.rscartera = '111' THEN 'CP' WHEN MDRS.rscartera = '114' THEN 'VI' ELSE 'CG' END    --20200514.RCHS.AJUSTES P40 (INCLUSIÓN OPERACIONES CG) AND VMERC.tipo_operacion = CASE WHEN MDRS.rscartera = '111' THEN 'CP' ELSE  THEN 'VI' END          
      
    left Join ( Select nscodigo, nsnumdocu, nscorrela, nsrutemi      
        , nsnemo = case when nscodigo = 9 and nsmonemi  = 999 then 'PAGARE NR'      
             when nscodigo = 9 and nsmonemi <> 999 then 'PAGARE R'      
             when nscodigo = 11 and nsmonemi  = 999 then 'PAGARE NR'      
             when nscodigo = 11 and nsmonemi <> 999 then 'PAGARE R'      
             else nsserie      
            end      
       from BacParamSuda.dbo.NOSERIE with(nolock)      
         LEFT JOIN BacParamSuda.dbo.SINACOFI with(nolock) On clrut = nsrutemi      
      )  NEMOTECNICO On NEMOTECNICO.nsnumdocu = MDRS.rsnumdocu      
            AND NEMOTECNICO.nscorrela = MDRS.rscorrela      
      
    Left Join ( Select vinumoper, vifecinip, vifecvenp, vinumdocu, vicorrela, viEstado = 1      
       from BacTraderSuda.dbo.MDVI with(nolock)      
      
       )  MDVI  On MDVI.vinumoper = CASE WHEN MDRS.rscartera = '111' THEN  MDRS.rsnumdocu ELSE MDRS.rsnumoper END      
            AND MDVI.vinumdocu = MDRS.rsnumdocu      
            AND MDVI.vicorrela = MDRS.rscorrela      
                
    left Join ( Select vmcodigo, vmvalor      
       from BacTraderSuda.dbo.MDAC with(nolock)      
         inner join BacParamSuda.dbo.VALOR_MONEDA with(nolock) On vmfecha = acfecproc      
        union      
       Select 999, 1.0       
        union      
       select  13,  vmvalor      
       from BacTraderSuda.dbo.MDAC with(nolock)      
         inner join BacParamSuda.dbo.VALOR_MONEDA with(nolock) On vmfecha = acfecproc      
      where vmcodigo = 994      
       )  VMONEDA  On VMONEDA.vmcodigo = case when INST.inmdse = 'N' then NOSERIE.nsmonemi      
                    else case when MDRS.rscodigo = 20 then 998 else INST.inmonemi end      
                   end      
 left join #ValorDet d on d.N_Documento=mdrs.rsnumdocu and d.correlativo=mdrs.rscorrela  
  
  ) TmpP40      
 ) Ret      
 order       
 by  Ret.Nemotecnico      
  , Ret.numero_Documento      
  , Ret.Correlativo      
  , Ret.Numero_Operacion      
  
--Actualiza Precio_Instrumento       
UPDATE #TMP      
Set Precio_Instrumento = CASE WHEN Seriado = 'S' THEN      
        CASE WHEN ISNULL(Valor_Par, 0) = 0 OR ISNULL(Nominal_Inicial, 0) = 0 THEN      
         0       
        ELSE      
          ROUND(((99*(valor_mercado/ROUND(valor_par, 0))) + (1.01*(valor_mercado/Nominal_Inicial))),5)      
        END      
       ELSE       
        CASE WHEN Moneda_Emision=998 THEN      
         ROUND(((valor_razonable/@nValorUF)/Nominal_Inicial)*100,2)      
        ELSE      
         ROUND((valor_razonable/Nominal_Inicial)*100,2)      
        END      
       END       
where Precio_Instrumento<1 and valor_razonable>0      
      
ALTER TABLE #TMP ADD Precio_Instrum   FLOAT NULL --DEFAULT 0      
ALTER TABLE #TMP ADD Limite_Inferior  FLOAT NULL --DEFAULT 0      
ALTER TABLE #TMP ADD Limite_Superior  FLOAT NULL --DEFAULT 0      
ALTER TABLE #TMP ADD Valida_Registro  FLOAT NULL --DEFAULT 0      
      
  
UPDATE #TMP      
    SET Precio_Instrum  = ROUND((valor_razonable / valor_par) * 100.0,2)      
    ,   Limite_Inferior = (0.99 * valor_razonable / valor_par) * 100.0      
    ,   Limite_Superior = (1.01 * valor_razonable / nominal_actual) * 100.0      
WHERE  tipo_registro = '01' AND Seriado = 'S' AND Moneda_Emision = 999  AND valor_par>0    
      
UPDATE #TMP      
    SET precio_instrumento = ROUND(Precio_Instrum,2)      
WHERE  tipo_registro = '01' AND Seriado = 'S' AND Moneda_Emision = 999      
AND (precio_instrumento < Limite_Inferior OR precio_instrumento > Limite_Superior)      
      
      
ALTER TABLE #TMP DROP COLUMN Precio_Instrum      
ALTER TABLE #TMP DROP COLUMN Limite_Inferior      
ALTER TABLE #TMP DROP COLUMN Limite_Superior      
ALTER TABLE #TMP DROP COLUMN Valida_Registro      
      
/*      
      
CORRECCIÓN BLAPO-H                   
-------------------      
Se solicita llevar a pesos el nominal actual que está en UF      
      
2020 08 13      
      
blapo llevar a CLP      
      
*/    
    
--select * from BacParamSuda..MONEDA where mncodmon=807    
--select * from BacParamSuda..VALOR_MONEDA where vmfecha='20210923'--vmcodigo=998 and     
      
UPDATE #TMP      
SET  Costo_Adquisicion = @nValorUF * Nominal_Actual      
WHERE Nemotecnico='BLAPO-H' AND upper(Emisor)='096874030K' and Costo_Adquisicion=0      
      
--Actualiza Moneda Emisión y Reajuste + Valor Razonable      
UPDATE #TMP      
SET  Moneda_Emision = '999',Moneda_Reajuste = '999',Valor_Razonable=1      
WHERE upper(Emisor)='096874030K' and Valor_Razonable=0      
      
       
--PARA LOS PAPELES DONDE LA FECHA ULTIMO CORTE ES IGUAL A LA FECHA PRÓXIMO CUPON (CASO BSTDP80315)      
UPDATE #TMP      
SET FECHA_PROXIMO_CUPON=convert(char(08),'00000000', 112)       
WHERE  FECHA_ULTIMO_CUPON=FECHA_PROXIMO_CUPON and FECHA_ULTIMO_CUPON!='00000000'      
      
      
      
--REMOVER PAPELES QUE NO ESTAN EN GARANTÍA A LA FECHA DE EMISIÓN DE LA INTERFAZ      
--NO SIRVE ESTE CRITERIO PARA ELIMINAR LOS PAPELES EN GARANTIA       
--PORQUE NO EXISTE UN CONTROL X FECHA EN SISTEMA DE GARANTIAS.      
      
--DELETE FROM #TMP WHERE  Cartera=159 AND FECHA_FINAL_COND<@Fecha_Interfaz      
    
--PARA LOS PAPELES EN GARANTÍA SE DEBEN INFORMAR '99999999'      
UPDATE #TMP      
SET FECHA_INICIO_COND =  convert(char(08),  '99999999', 112) ,--convert(char(08),'99999999'),       
 FECHA_FINAL_COND =  convert(char(08),  '99999999', 112)--convert(char(08),'99999999')      
WHERE CARTERA=159 AND Condicion_Instrumento='3'       
       
--PARA AQUELLOS REGISTROS QUE EL COSTO ADQUISICIÓN VENGA EN 0      
update #tmp       
set costo_adquisicion=rsvalcomp      
from BacTraderSuda.DBO.mdrs       
where rsfecha=@dFechacartera and numdocu=rsnumdocu and correla=rscorrela and costo_adquisicion=0      
     
  
INSERT INTO #TABLA_P40_MX      
EXEC SP_INTERFAZ_P40_BANCO_MX_TMP @Fecha_Interfaz      
  
ALTER TABLE #TABLA_P40_MX add Cliente numeric(9)  
ALTER TABLE #TABLA_P40_MX add Jerarquia_vrazonable int  
ALTER TABLE #TABLA_P40_MX add Valor_deterioro_Rie_Cre int  
ALTER TABLE #TABLA_P40_MX add Apli_sup_Ins_Rie_Cre int  
ALTER TABLE #TABLA_P40_MX add Costo_Adquisicion_conta numeric(14)  
      
      
/*      
rango1=((0,99*VR)/VPar)*10000      
rango2=((1,01*VR)/N)*10000      
precio=precio_instrumento/100      
*/      
      
--ACTUALIZO CANTIDAD DE REGISTROS A INFORMAR      
declare @qRFN int      
declare @qRFE int      
      
set @qRFN = (select count(*) from #tmp)      
set @qRFE = (select count(*) from #TABLA_P40_MX)      
      
update #tmp set iCantidad=(@qRFN + @qRFE)      
       
update #TABLA_P40_MX set iCantidad= (@qRFN+@qRFE)      
  
update #tmp  
set Valor_Deterioro=0  
where Valor_Deterioro is null  
       
      
UPDATE #TABLA_P40_MX  
SET  nemotecnico = replicate(' ',20)  
WHERE Nemotecnico=''       
    
--PARA CUANDO SE INFORME VALOR RAZONABLE NULO.    
UPDATE #TABLA_P40_MX      
SET   Valor_Razonable = ISNULL(Valor_Razonable,0)    
WHERE Valor_Razonable IS NULL       
  
UPDATE p  
set Jerarquia_vrazonable = case when rsrutemis in (97029000,60805000) then '1' else '1' end  
, Valor_deterioro_Rie_Cre = case when tipo_cartera in (2,3) then '1' else '0' end     
, Apli_sup_Ins_Rie_Cre    = case when tipo_cartera in (2,3) then ( case when emisor in ('608050000','970290001') then '1' else '2' end ) else '0' end  
, Costo_Adquisicion_conta = case when codigo_carterasuper='T' THEN 0 ELSE rsvppresen + rsinteres + rsreajuste + rsDiferenciaMerc END  
from #TABLA_P40_MX p  
inner join BacBonosExtSuda..TEXT_RSU on rsnumdocu=numero_Documento and rsnumoper=Numero_Operacion and rscorrelativo=Correlativo AND rsfecpro=@Fecha_Interfaz  
  
update p  
set p.valor_deterioro=round(provision,0)  
from #TABLA_P40_MX   p  
left join #ValorDet v on v.N_Documento=p.numero_Documento and v.correlativo=p.Correlativo  
  
  
if not ( @bUltimoDiahabilMes = 1)--no es el ultimo dia del mes  
begin  
 update #tmp  
  set   
   Valor_Razonable   = case when Tipo_Cartera in (3) then 0 else Valor_Razonable end  
  , Jerarquia_vrazonable = 0  
  , Valor_deterioro_Rie_Cre = 0  
  , Apli_sup_Ins_Rie_Cre = 0  
  , Costo_adq_Act_conta  = 0  
  ,   valor_deterioro   =   0  
  ,   Costo_Amortizado  = case when Tipo_Cartera in (3) then Costo_Amortizado else 0 end  
  
 update #TABLA_P40_MX  
  set   
   Valor_Razonable   = case when Tipo_Cartera in (3) then 0 else Valor_Razonable end  
  , Jerarquia_vrazonable = 0  
  , Valor_deterioro_Rie_Cre = 0  
  , Apli_sup_Ins_Rie_Cre = 0  
  , Costo_Adquisicion_conta = 0  
  ,   valor_deterioro   =   0  
  ,   Costo_Amortizado  = case when Tipo_Cartera in (3) then Costo_Amortizado else 0 end  
end  
else --ultimo dia del mes  
begin  
 update #tmp  
  set   
     Costo_Amortizado  = case when Tipo_Cartera in (2,3) then Costo_Amortizado else 0 end  
  
 update #TABLA_P40_MX  
  set   
     Costo_Amortizado  = case when Tipo_Cartera in (2,3) then Costo_Amortizado else 0 end  
  
end  
  
  
--solucion fecha de corte  
UPDATE p  
set p.Fecha_Ultimo_Cupon = convert(char(8),r.rsfecucup,112)  
from #tmp p  
inner join bactradersuda..mdrs r on r.rsnumdocu=p.numdocu and r.rscorrela=p.correla and r.rsnumoper=p.numoper and r.rsfecha=@Fecha_Interfaz  
where p.Fecha_Ultimo_Cupon>p.Fecha_Proceso  
  
UPDATE p  
set p.Fecha_Proximo_Cupon = convert(char(8),r.rsfecpcup,112)  
from #tmp p  
inner join bactradersuda..mdrs r on r.rsnumdocu=p.numdocu and r.rscorrela=p.correla and r.rsnumoper=p.numoper and r.rsfecha=@Fecha_Interfaz  
where p.Fecha_Proximo_Cupon=0 and p.Tipo_Rendimiento<>1  
  
  
UPDATE p  
set p.Valor_Par = case when r.rsfecucup >'19000101' then (r.rsvpcomp * r.rsnominal) / 100.0 else r.rsnominal end  
from #tmp p  
inner join bactradersuda..mdrs r on r.rsnumdocu=p.numdocu and r.rscorrela=p.correla and r.rsnumoper=p.numoper and r.rsfecha=@Fecha_Interfaz  
where p.Valor_Par=0  
  
UPDATE p  
set p.Precio_Instrumento = case when r.rscodigo = 888 then round(r.rsvpcomp, 2) when r.rscartera=111 then round(r.rsvpcomp, 2) when r.valor_par = 0  then round(r.rstir, 2) else round(r.valor_par, 2) end  
from #tmp p  
inner join bactradersuda..mdrs r on r.rsnumdocu=p.numdocu and r.rscorrela=p.correla and r.rsnumoper=p.numoper and r.rsfecha=@Fecha_Interfaz  
where p.Precio_Instrumento=0  

--select * from #tmp

INSERT INTO @ND15
SELECT 'CL'															AS	ctry												--		1	
,		convert(char(08),@Fecha_Interfaz,112)						AS	intf_dt												--		2
,		'ND15'														as	src_id												--		4	
,		'001'														as	cem													--		5	
,		'MD01'	 + SPACE(12)										as	prod		--case when cartera = 111 then 'CP' when cartera = 114 then 'VI' when cartera = 159 then 'CG' end		as	prod												--		6	
,		convert(char(08),Fecha_Proceso,112)						AS	book_dt												--		2
,		ltrim(rtrim(CAST(numdocu AS VARCHAR(8)) +  cast(correla AS VARCHAR(4))+ CAST( numoper AS VARCHAR(8))))		as	con_no	 											--		7	
--,		left(Cliente,12)											as	ident_cli   
,       right(replicate('0',12)+convert(varchar(10),Emisor),12)     as	ident_cli
,		'1'															as	typ_reg     
,		Familia_Instrumento											as	instr_fmly  
,		Tipo_Cartera												as	typ         
,		Fecha_Proximo_Cupon											as	next_coup   
,		Derivado_Incrust_Opc										as	der_opt     
,		Nominal_Actual												as	nom_curr    
,		m.mncodbkb													as	adj_ccy     
,		left(Tipo_Tasa_Emision,7)									as	emi_rt_typ  
,		Tera														as	tera        
,		Valor_Par													as	par_val     
,		Tipo_Tasa_Compra											as	com_rt_typ  
,		Tasa_Compra													as	compra_rt   
,		Costo_Adquisicion											as	acq_cost    
,		Costo_Amortizado											as	amort_cost  
,		Tipo_Tasa_Valoriza											as	val_rt_typ  
,		Tasa_Valorizacion											as	valor_rt    
,		Tipo_valorizacion											as	valor_typ   
,		Precio_Instrumento											as	inst_price  
,		Duracion_Modificada											as	mod_dur     
,		Convexidad													as	convex      
,		Valor_Deterioro												as	valor_det   
,		Condicion_Instrumento										as	instr_cond  
,		Fecha_Inicio_Cond											as	ini_cond_d  
,		Fecha_Final_Cond											as	fin_cond_d  
,		Nemotecnico													as	nemo_instr  
FROM #tmp
inner join BacParamSuda..MONEDA m	with(nolock) On	m.mncodmon	= Moneda_Reajuste

--select * from #TABLA_P40_MX

INSERT INTO @ND15
SELECT 'CL'																	as	ctry												--		1	
,		convert(char(08),@Fecha_Interfaz,112)								as	intf_dt												--		2
,		'ND15'																as	src_id												--		4	
,		'001'																as	cem													--		5	
,		'MD01'	 + SPACE(12)												as	prod	--'BONOS'									as	prod												--		6	
,		convert(char(08),@Fecha_Interfaz,112)								as	book_dt												--		2
,		ltrim(rtrim(CAST(numero_Documento AS VARCHAR(8)) +  cast(Correlativo AS VARCHAR(4))+ CAST( Numero_Operacion AS VARCHAR(8))	))		as	con_no	 											--		7	
--,		Cliente														as	ident_cli   
,		right(replicate('0',12)+convert(varchar(10),Emisor),12) as	ident_cli
,		'1'															as	typ_reg     
,		Familia_Instrumento											as	instr_fmly  
,		'1'															as	typ         
,		Fecha_Proximo_Cupon											as	next_coup   
,		Derivado_Incrust_Opc										as	der_opt     
,		Nominal_Actual												as	nom_curr    
,		m.mncodbkb													as	adj_ccy     
,		left(Tipo_Tasa_Emision,7)									as	emi_rt_typ  
,		Tera														as	tera        
,		Valor_Par													as	par_val     
,		Tipo_Tasa_Compra											as	com_rt_typ  
,		Tasa_Compra													as	compra_rt   
,		Costo_Adquisicion											as	acq_cost    
,		Costo_Amortizado											as	amort_cost  
,		Tipo_Tasa_Valoriza											as	val_rt_typ  
,		Tasa_Valorizacion											as	valor_rt    
,		Tipo_valorizacion											as	valor_typ   
,		Precio_Instrumento											as	inst_price  
,		Duracion_Modificada											as	mod_dur     
,		Convexidad													as	convex      
,		Valor_Deterioro												as	valor_det   
,		Condicion_Instrumento										as	instr_cond  
,		Fecha_Inicio_Cond											as	ini_cond_d  
,		Fecha_Final_Cond											as	fin_cond_d  
,		Nemotecnico													as	nemo_instr  
FROM #TABLA_P40_MX
inner join BacParamSuda..MONEDA m	with(nolock) On	m.mncodmon	= Moneda_Reajuste
Declare @ND15_SALIDA Table ( REG_SALIDA  Varchar(1240))   
  
--freddy 2022-02-03    
DECLARE @sTipoSalida int  
set @sTipoSalida = 0
if    @sTipoSalida = 1  
begin
select 
		ctry		
	,	convert(char(8),intf_dt,112)    intf_dt 
	,	src_id      
	,	cem         
	,	prod        
	,	convert(char(8),book_dt,112)     book_dt
	,	con_no + replicate(char(160), 30 - len(con_no))	     con_no 
	,	ident_cli--left(ident_cli,12)   
	,	typ_reg     
	,	instr_fmly  
	,	typ         
	,	next_coup   
	,	der_opt   
	,  nom_curr-- right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(nom_curr)*10000))),18)  nom_curr
	,	adj_ccy     
	,	emi_rt_typ  
	,  tera-- right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(tera)*100000000))),16)  tera
	, par_val--  right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(par_val)*10000))),18)  par_val
	,	com_rt_typ  
	, compra_rt--  right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(compra_rt)*100000000))),16)  compra_rt
	, acq_cost--  right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(acq_cost)*10000))),18)  acq_cost
	, amort_cost--   right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(amort_cost)*10000))),18)  amort_cost
	,	val_rt_typ  
	, valor_rt--  right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(valor_rt)*100000000))),16)  valor_rt
	,	valor_typ   
	,  inst_price-- right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(inst_price)*100000000))),16)  inst_price
	, mod_dur--  right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(mod_dur)*100000000))),16)  mod_dur
	, convex--  right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(convex)*100000000))),16)  convex
	,  valor_det-- right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(valor_det)*10000))),18)  valor_det
	,	instr_cond  
	,	ini_cond_d  
	,	fin_cond_d  
	,	nemo_instr  
	FROM @ND15
END
ELSE
BEGIN
	insert into @ND15_SALIDA
	select 
		ctry		
	+	convert(char(8),intf_dt,112)     
	+	src_id      
	+	cem         
	+	prod        
	+	convert(char(8),book_dt,112)     
	+	left(con_no+space(20), 20)--con_no + replicate(char(160), 30 - len(con_no))	      
	+	ident_cli   
	+	typ_reg     
	+	instr_fmly  
	+	typ         
	+	next_coup   
	+	der_opt   
	+   right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(nom_curr)*10000))),18)  
	+	adj_ccy     
	+	emi_rt_typ  
	+   right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(tera)*100000000))),16)  
	+   right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(par_val)*10000))),18)  
	+	com_rt_typ  
	+   right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(compra_rt)*100000000))),16)  
	+   right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(acq_cost)*10000))),18)  
	+   right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(amort_cost)*10000))),18)  
	+	val_rt_typ  
	+   right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(valor_rt)*100000000))),16)  
	+	valor_typ   
	+   right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(inst_price)*100000000))),16)  
	+   right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(mod_dur)*100000000))),16)  
	+   right(replicate(0,16)+convert(varchar(16),convert(numeric(16),(abs(convex)*100000000))),16)  
	+   right(replicate(0,18)+convert(varchar(18),convert(numeric(18),(abs(valor_det)*10000))),18)  
	+	instr_cond  
	+	ini_cond_d  
	+	fin_cond_d  
	+	nemo_instr  
--	AS REG_SALIDA
	from @ND15
    ORDER BY con_no

	SELECT * FROM @ND15_SALIDA
END

drop table #tmp      
drop table #TABLA_P40_MX      
drop table #ValorDet  
    
END   
GO
