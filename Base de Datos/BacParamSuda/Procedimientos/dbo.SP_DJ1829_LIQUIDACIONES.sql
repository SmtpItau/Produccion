USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DJ1829_LIQUIDACIONES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DJ1829_LIQUIDACIONES] 
  (   @annoMes numeric(6) 
    , @TipoDJ varchar(4) = '1829'
	, @EjecutaDesdePtoNet varchar(2) = 'NO'
	, @Cuadratura varchar(2) = 'SI' 
  )  

AS BEGIN
--/*
-- use bacparamsuda -- Comentado para ejecutar desde Punto Net
/* llamada para generar DJ mensual */
-- SP_DJ1829_LIQUIDACIONES '201405', '1820', 'NO'
-- @Cuadratura = 'SI'  and @TipoDJ = '1829' and @EjecutaDesdePtoNet = 'NO'
/* SP_DJ1829_LIQUIDACIONES '201404' */

-- GO*/

/* Ejecuta 26-06-2013
   Warning: Null value is eliminated by an aggregate or other SET operation.
   Criterios de aceptación
   - Generar con los pagos 2012 la 1829 2012 igual que la ya generada.
   - Generar las mensuales 2013 mejoradas, verificar que las nuevas no pierdan
     información ya enviada.

-- Sección para ajustar pagos de anticipos y otras operaciones Forward
	-- Modificación especifica de Montos pagados al anticipar SWAP
	-- Modificación especifica de Montos pagados al anticipar FORWARD
	-- Solamente para modifica Montos Anticipos Mx/CLP	
	-- Modificación especifica de Montos pagados  FORWARD (no seguros de cambio ni arbitraje)
	-- Casos extra raros
    -- REDIRECCIONAR CUENTAS
	-- REDIRECCIONAR CUENTAS PATA USD/CLP DE MX/CLP
	-- Eliminar eventos repetidos por cambio de cliente en SWAP
	-- AJUSTES INCREMENTALES DE PAGO EN OPCIONES


Timing: 10 min 12 seg.

*/

SET ANSI_WARNINGS OFF
SET ANSI_NULLS    OFF
-- genera con bacuser el siguiente error:
/*
Msg 7405, Level 16, State 1, Line 24186
Heterogeneous queries require the ANSI_NULLS and ANSI_WARNINGS options to be set for the connection. 
This ensures consistent query semantics. Enable these options and then reissue your query.

*/

--SET ANSI_WARNINGS ON 
-- SET ANSI_NULLS    ON
--GO
/* Esto no va en el TXT de Aplicacion PAngulo DESDE ACA */
--/* -- decomentar esta linea para ejecutar desde punto net
set nocount on
-- declare @annoMes            numeric(6)
declare @annoMesDesde       numeric(6)
declare @anno               numeric(4)
declare @EmpresaDeclarante  varchar(15)
declare @FechaProceso       datetime
declare @PrimerDiaAnno      datetime
/*********************************************************************
                                  Parámetros
*********************************************************************/
select  @annoMesDesde = substring( convert( varchar(6), @annoMes) , 1, 4 ) + '01'  -- Desde , se asumirá siempre inicio de año, se rá modificado
                                -- Por código posterior. Eliminar .net y de esta sección para
                                -- no generar problemas.

select  @annoMes      =  @annoMes  -- Corte, el principio siempre será inicio de año
                                   -- Cambiar el mes cuando haya cierre contable del mes

--*/ -- decomentar esta linea para ejecutar desde punto net

/* Esto no va en el TXT de Aplicacion PAngulo HASTA ACA */

/* Si se asigna
@TipoDJ = '1820', es relavante poner @EjecutaDesdePtoNet = 'SI' o 'NO' para sacar los resultados en Archivo o Consola respectivamente
@TipoDJ = '1829', es relavente poner @EjecutaDesdePtoNet = 'SI' o 'NO' para sacar los resultados en Archivo o Consola respectivamente 
*/

-- Cuando estos valores se pasen a 'SI'
-- se debe verificar que los valores estén para 
-- cierre mensual considerado
declare @AjustesProvisiones     varchar(2)
declare @AjustesPargua          varchar(2) 
declare @AjustesCobertura       varchar(2)
declare @AjustesPagosForwardAsiatico varchar(2)
declare @AjustesAVRForwardAsiatico   varchar(2)

/* declare @EjecutaDesdePtoNet          varchar(2) */


select  @AjustesProvisiones     = 'SI'
select  @AjustesPargua          = 'SI'
select  @AjustesCobertura       = 'SI' 

/* select  @EjecutaDesdePtoNet     = 'NO' */

select  @AjustesPagosForwardAsiatico = 'SI'
select  @AjustesAVRForwardAsiatico   = 'NO'

/*
declare @Cuadratura                  varchar(2)
select  @Cuadratura                  = 'SI' -- Activar con 'SI' para cuadrar Pagos, VR y AVR
*/
select @EmpresaDeclarante = 'CORPBANCA'

select  @anno = substring( convert( varchar(6), @annoMes) , 1, 4 )

 
-- Primer día del año comercial, mes cerrado
-- puede ser hábil o inhábil
-- Para evitar que queden cosas
-- afuera por los feriados
declare @annoAux numeric(4)
select  @annoAux  = convert( numeric(4) , substring( convert( varchar(6), @annoMes ), 1, 4 ) ) 
declare @FechaCorte datetime 
select  @FechaCorte = ( select min( acfecante ) + 1  from BacTraderSuda.dbo.Fechas_Proceso 
                                     where year(acfecproc) = @annoAux )
-- 2011-12-31, con AnoMes = 201206 


-- Ultimo día del año comercial, mes cerrado
-- siempre será habil, podría cambiar
-- así que se mantiene esta variable
-- Lo de los feriados se incluirá en el 
-- próximo cierre
declare @FechaCorteFinal datetime 
select  @FechaCorteFinal = ( select max( acfecproc )  from BacTraderSuda.dbo.Fechas_Proceso 
                                     where year(acfecproc)*100 + month(acfecproc) = @annoMes )  									   

-- Por mientras hasta que se pueda ejecutar día tras día sin problemas
-- IMPORTANTE
-- debe haber "Carteras Res" del día a procesar y al día siguiente.
-- Por ejemplo si se quiere procesar el día 25 de Octubre debe estar cerra
-- do este día y el siguiente: 28 de octubre cerrado.

declare @FechaCorteFinalReal datetime -- Fecha Corte Real Procesable para liquidaciones: 1 día hábil cerrados
select  @FechaCorteFinalReal =  (select  acfecante  from BacTraderSuda.dbo.mdac) 

-- Si la fecha real está en otro mes que es posterior
-- la fecha de corte será la fecha de fin de mes
if  @FechaCorteFinalReal >= @FechaCorteFinal
begin
   select @FechaCorteFinal = @FechaCorteFinal
end
else
begin   
    select @FechaCorteFinal = @FechaCorteFinalReal
end
-- select  @FechaCorteFinal = '20140429' -- Por mientras dejamos fijo hasta que se pueda ejecutar

-- Fecha rescate ajuste de AVR
declare @FechaUltimoDiaMes datetime 
select  @FechaUltimoDiaMes = ( select max( acfecproc )  from BacTraderSuda.dbo.Fechas_Proceso 
                                     where year(acfecproc)*100 + month(acfecproc) = @annoMes )  							   
declare @FechaRescateAVRExterno datetime
if @FechaUltimoDiaMes <> @FechaCorteFinal
      select  @FechaRescateAVRExterno = ( select max( acfecproc )  from BacTraderSuda.dbo.Fechas_Proceso 
                                     where   acfecproc < @FechaCorteFinal
										 and month( acfecproc ) <> month( @FechaCorteFinal )
									  )
else 
       select  @FechaRescateAVRExterno = @FechaCorteFinal



                                 
-- 2012-06-29, con AnoMes = 201206

 
-- Fecha de Cierre de DJ, puede ser cual-
-- quier mes cerrado. Siempre hábil
-- porque se usa para rescatar RES
declare @FechaCierreAnnoComercial datetime
select  @FechaCierreAnnoComercial = @FechaCorteFinal /*( select max(acfecProc) from BacTraderSuda.dbo.Fechas_Proceso 
                                      where year(acfecproc)*100 + month(acfecproc) = @annoMes )*/
-- 2012-06-29, con AnoMes = 201206


-- No debe cambiar mientras de mantenga
-- el año comercial. Siempre Hábil
declare @FechaCierreAnnoComercialAnt         datetime
select  @FechaCierreAnnoComercialAnt = ( select max(acfecProc) from BacTraderSuda.dbo.Fechas_Proceso
                                       where year(acfecproc) = ( @anno - 1 ) )
-- 2011-12-30, con AnoMes = 201206

-- Dia siguiente hábil al mes cerrado
-- se usa para checar vigencia. Siempre Hábil.
declare @Fecha1erDiaHabilAnnoComercialSigHab datetime
select  @Fecha1erDiaHabilAnnoComercialSigHab =  ( select acfecprox from BacTraderSuda.dbo.Fechas_Proceso 
                                        where acfecproc =  @FechaCierreAnnoComercial ) 
-- 2012-07-03, con AnoMes = 201206


-- Primera Día Habil del año
-- se usa para checar vigencia. Siempre Hábil.
declare @Fecha1erDiaHabilAnnoComercialHab datetime
select  @Fecha1erDiaHabilAnnoComercialHab =  ( select acfecprox from BacTraderSuda.dbo.Fechas_Proceso 
                                          where acfecproc = @FechaCierreAnnoComercialAnt  )  
-- 2012-01-02, con AnoMes = 201206 

select @PrimerDiaAnno = convert( varchar(4), @anno ) + '0101'

declare @FecContabilizaEFSAO datetime
select  @FecContabilizaEFSAO = '20140620' -- Al hacer ajustes esta fecha debería ser igual al inicio

-- **************************************************************
-- Creacion de Tablas nuevas
-- **************************************************************

-- Eventos
-- Eventos
CREATE TABLE #Evento
(
	  EveCod VarChar(15)	
	, EveFluCaj Varchar(1)   -- S o N o X (depende del producto)
	, SubEveCod VarChar(15)
	, EveOrd   Numeric(2)
)

insert into #Evento select 'Curse', 'N', 'No Aplica', 1
insert into #Evento select 'Modificacion', 'N', 'No Aplica', 2
insert into #Evento select 'Cesion', 'N', 'No Aplica', 3
insert into #Evento select 'Ejercicio', 'S', 'No Aplica', 4
insert into #Evento select 'Anticipo', 'S', 'PARCIAL',  4
insert into #Evento select 'Liquidacion', 'S', 'No Aplica', 5
insert into #Evento select 'Liq Hip', 'S', 'No Aplica',  6
insert into #Evento select 'Anticipo', 'S', 'TOTAL',  6
insert into #Evento select 'Vcto. Natural', 'S', 'No Aplica', 7


insert into #Evento select 'Provisiones', 'N' , 'No Aplica', 0	 	 
insert into #Evento select 'Complemento', 'N' , 'No Aplica', 0
insert into #Evento select 'Pargua', 'N' , 'No Aplica', 0

insert into #Evento select 'Cuadratura' , 'N' , 'Valor Razonable', 0
insert into #Evento select 'Cuadratura' , 'S' , 'Vcto. Nat.', 0
insert into #Evento select 'Cuadratura' , 'S' , 'Anticipo', 0


CREATE TABLE #TA_GNL_ACV_SYE
(
  COD_ACV_SYE  NUMERIC(2)                 NOT NULL,
  GLS_ACV_SYE  VARCHAR(100)               NOT NULL
)
CREATE TABLE #TA_GNL_COD_PRC
(
  COD_PRC  NUMERIC(2)                            NOT NULL,
  GLS_PRC  VARCHAR(100)                   NOT NULL
)
CREATE TABLE #TA_GNL_CTT_VNC_EJR
(
  COD_CVE  NUMERIC(2)                            NOT NULL,
  GLS_CVE  VARCHAR(100)                   NOT NULL
)
CREATE TABLE #TA_GNL_EST_CTT_CFM
(
  COD_ECC  NUMERIC(2)                            NOT NULL,
  GLS_ECC  VARCHAR(100)                   NOT NULL
)
CREATE TABLE #TA_GNL_EVT_IFD
(
  COD_EVT_IFD  NUMERIC(2)                        NOT NULL,
  GLS_EVT_IFD  VARCHAR(100)               NOT NULL
)
CREATE TABLE #TA_GNL_MLD_CTN
(
  COD_MLD_CTN  NUMERIC(2)                        NOT NULL,
  GLS_MLD_CTN  VARCHAR(400)               NOT NULL
)
CREATE TABLE #TA_GNL_MLD_CUM
(
  COD_MLD_CUM  NUMERIC(2)                        NOT NULL,
  GLS_MLD_CUM  VARCHAR(100)               NOT NULL
)
CREATE TABLE #TA_GNL_MLD_PAG
(
  COD_MLD_PAG  NUMERIC(2)                        NOT NULL,
  GLS_MLD_PAG  VARCHAR(100)               NOT NULL
)
CREATE TABLE #TA_GNL_MON_SII
(
  NRO_ANO_CMR  NUMERIC(4)                        NOT NULL,
  COD_MON      CHAR(3)                     NOT NULL,
  GLS_MON      VARCHAR(100)               NOT NULL,
  GLS_PAI      VARCHAR(100)               NOT NULL
)
CREATE TABLE #TA_GNL_PAI_SII
(
  NRO_ANO_CMR  NUMERIC(4)                        NOT NULL,
  COD_PAI      CHAR(2)                     NOT NULL,
  GLS_PAI      VARCHAR(100)               NOT NULL
)

-- Códigos de Paises utilizados por 
-- empresa informante
CREATE TABLE #TA_GNL_PAI_EMP
(
  NRO_ANO_CMR  NUMERIC(4)                  NOT NULL,  
  COD_PAI_SII  CHAR(2)                     NOT NULL,
  COD_EMP      CHAR(20)                     NOT NULL, 
  COD_PAI_EMP  NUMERIC(5)                  NOT NULL
)
CREATE TABLE #TA_GNL_PSC_DLN
(
  COD_PSC_DLN  NUMERIC(2)                        NOT NULL,
  GLS_PSC_DLN  VARCHAR(100)               NOT NULL
)
CREATE TABLE #TA_GNL_PTO_BSC
(
  COD_PTO_BSC  NUMERIC(2)                        NOT NULL,
  GLS_PTO_BSC  VARCHAR(100)               NOT NULL
)
CREATE TABLE #TA_GNL_TPO_ADO_MRC
(
  COD_TAM  NUMERIC(2)                            NOT NULL,
  GLS_TAM  VARCHAR(100)                   NOT NULL
)
CREATE TABLE #TA_GNL_TPO_REL_CTP
(
  COD_TRC  NUMERIC(2)                            NOT NULL,
  GLS_TRC  VARCHAR(100)                   NOT NULL
)
CREATE TABLE #TA_GNL_TSA_INT
(
  COD_TSA_INT  NUMERIC(2)                        NOT NULL,
  GLS_TSA_INT  VARCHAR(100)               NOT NULL
)
CREATE TABLE #TA_GNL_TSA_INT_VAR	
(	
  COD_TIV  NUMERIC(2)                            NOT NULL,	
  GLS_TIV  VARCHAR(100)                   NOT NULL,	
 COD_TIV_EMP numeric(5)               NOT NULL,	
  COD_MDA  NUMERIC(5)                  NOT NULL	
)	
CREATE TABLE #TA_GNL_UND_MNA_MID
(
  COD_UMM  NUMERIC(2)                            NOT NULL,
  GLS_UMM  VARCHAR(100)                   NOT NULL
)
-- Tipos de Contratos
-- No estaba incluido en lo enviado por Sr. Becerra
CREATE TABLE #TA_GNL_TPO_CTT
(
  COD_CTT  NUMERIC(2)                 NOT NULL,
  GLS_CTT  VARCHAR(400)               NOT NULL
)
  -- TAXID de registrado de clientes	
 -- de empresa informante	
 -- TAXID de registrado de clientes		
 -- de empresa informante		
CREATE TABLE #TA_GNL_CLI_TAXID		
(		
 COD_EMP CHAR(20)                                           NOT NULL,		
  ID_CLI_EMP   NUMERIC(13)                              NOT NULL,		
  ID_CLI_CODIGO_EMP   NUMERIC(5)              NOT NULL,		
 TAXID_CLI VARCHAR(15)                                    NOT NULL		
)	

-- Traducción de códigos de monedas 
-- a los códigos Sii	
CREATE TABLE #TA_GNL_UND_MNA_MID_EMP
(
  COD_EMP       CHAR(20)      NOT NULL,  
  COD_UMM       NUMERIC(5)    NOT NULL,
  COD_UMM_EMP   NUMERIC(5)    NOT NULL,
  COD_SII_Char  CHAR(3)       NOT NULL

 )
-- Clientes que modificaron su rut
CREATE TABLE #TA_GNL_RUT_MOD	
(	
  ID_CLI_RUT_ORIGINAL   NUMERIC(13)                              NOT NULL,	
  ID_CLI_COD_ORIGINAL   NUMERIC(13)                              NOT NULL,	
  ID_CLI_RUT_NUEVO NUMERIC(13)                        NOT NULL,	
  ID_CLI_COD_NUEVO   NUMERIC(13)                              NOT NULL	
)	

-- Contratos Marco (varios por cliente 
-- aplican según la fecha en que se firman
-- En el sistema BAC están grabando la
-- fecha del contrato marco nuevo 
-- en el campo de la fecha antigua
CREATE TABLE #Contratos_Marco
(
 COD_EMP CHAR(20)                                           NOT NULL,
  ID_CLI_EMP   NUMERIC(13)                              NOT NULL,
  ID_CLI_CODIGO_EMP   NUMERIC(5)              NOT NULL,
  Numero_CG                      Numeric(10) Not Null,
  Fecha_CG                        Datetime Not Null
)

-- Clientes Relacionados con el Banco
-- La información variará mes a mes
CREATE TABLE #Rut_relacionados
(
  ANNO_MES       NUMERIC(6)                            NOT NULL,
  COD_EMP CHAR(20)                                        NOT NULL,
  ID_CLI_EMP   NUMERIC(13)                             NOT NULL,
  ID_CLI_CODIGO_EMP   NUMERIC(5)              NOT NULL,
  Nombre                           Varchar(200) Not Null,
  Relacion_Sbif                   Varchar(5)  Not Null,
  Relacion_Sbif_Dsc            Varchar(200)  Not Null,
  Relacion_SII                      Numeric(2)   Not Null,
  OrigenInformacion                   Varchar(50) Not Null,
 Prioridad                            Numeric(5)  Not Null
)
CREATE INDEX  I#Rut_relacionados ON #Rut_relacionados
               ( ANNO_MES, COD_EMP, ID_CLI_EMP, ID_CLI_CODIGO_EMP )

-- Pueden haber varios tipos de relación e ir modificándose
-- Por ejemplo un cliente tiene las siguientes relaciones:
/*  
Rut	Nombre	                                        Cod Rel.Sii	Prioridad  Origen 
93604000	INVERSORA E INMOBILIARIA FORESTAL LTDA	          2	1          I02 
93604000	INVERSORA E INMOBILIARIA FORESTAL LTDA	          2	2          I03
93604000	INVERSORA E INMOBILIARIA FORESTAL LTDA	          2	3          CF

Al eliminar la relacion con prioridad 1 se deben actualizar las otras para
que hereden la prioridad de la anterior:

Rut	Nombre	                                        Cod Rel.Sii	Prioridad  Origen 
93604000	INVERSORA E INMOBILIARIA FORESTAL LTDA	          2	1          I03
93604000	INVERSORA E INMOBILIARIA FORESTAL LTDA	          2	2          CF
*/

-- **************************************************************
-- Llenado de Datos
-- **************************************************************
--CODIGO PAIS CONTRAPARTE (TABLA SII CODIGOS PAIS DE RESIDENCIA)
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AF',UPPER('Afganistan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AL',UPPER('Albania'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'DE',UPPER('Alemania'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'DE','CORPBANCA', 563)   


INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AD',UPPER('Andorra'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AO',UPPER('Angola'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AI',UPPER('Anguila'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AQ',UPPER('Antartida'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AG',UPPER('Antigua y Barbuda'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AN',UPPER('Antillas Holandesas'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SA',UPPER('Arabia Saudi'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'DZ',UPPER('Argelia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AR',UPPER('Argentina'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AM',UPPER('Armenia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AW',UPPER('Aruba'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AU',UPPER('Australia'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'AU','CORPBANCA', 406)    
    



INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AT',UPPER('Austria'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AZ',UPPER('Azerbaiyan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BS',UPPER('Bahamas'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BH',UPPER('Bahrein'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BD',UPPER('Bangladesh'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BB',UPPER('Barbados'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BE',UPPER('Belgica'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BZ',UPPER('Belice'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BJ',UPPER('Benin'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BM',UPPER('Bermudas'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BY',UPPER('Bielorusia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BO',UPPER('Bolivia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BA',UPPER('Bosnia-Herzegovina'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BW',UPPER('Botswana'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BR',UPPER('Brasil'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'BR','CORPBANCA', 220)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BN',UPPER('Brunei Darussalam'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BG',UPPER('Bulgaria'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BF',UPPER('Burkina Faso'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BI',UPPER('Burundi'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BT',UPPER('Butan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CV',UPPER('Cabo Verde'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KH',UPPER('Camboya'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CM',UPPER('Camerun'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CA',UPPER('Canada'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'CA','CORPBANCA', 226)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TD',UPPER('Chad'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CL',UPPER('Chile'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'CL','CORPBANCA', 6)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CN',UPPER('China'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CY',UPPER('Chipre'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'VA',UPPER('Ciudad del Vaticano'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CO',UPPER('Colombia'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'CO','CORPBANCA', 202)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KM',UPPER('Comores'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CG',UPPER('Congo'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KP',UPPER('Corea del Norte'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KR',UPPER('Corea del Sur'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CI',UPPER('Costa de Marfil'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CR',UPPER('Costa Rica'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'HR',UPPER('Croacia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CU',UPPER('Cuba'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CW',UPPER('Curazao'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'DK',UPPER('Dinamarca'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'DM',UPPER('Dominica'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'EC',UPPER('Ecuador'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'EG',UPPER('Egipto'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SV',UPPER('El Salvador'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AE',UPPER('Emiratos arabes Unidos'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ER',UPPER('Eritrea'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'EO',UPPER('Escocia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SI',UPPER('Eslovenia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ES',UPPER('España'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'US',UPPER('Estados Unidos de America'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'US','CORPBANCA', 225)  

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'EE',UPPER('Estonia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ET',UPPER('Etiopia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'RU',UPPER('Federacion Rusa (Rusia)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PH',UPPER('Filipinas'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'FI',UPPER('Finlandia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'FJ',UPPER('Fiyi'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'FR',UPPER('Francia'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'FR','CORPBANCA', 505)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GA',UPPER('Gabon'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GC',UPPER('Gales'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GM',UPPER('Gambia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GE',UPPER('Georgia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GH',UPPER('Ghana'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GI',UPPER('Gibraltar'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GD',UPPER('Granada'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GR',UPPER('Grecia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GL',UPPER('Groenlandia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GP',UPPER('Guadalupe (Francia)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GU',UPPER('Guam (EE.UU.)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GT',UPPER('Guatemala'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GY',UPPER('Guayana'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GF',UPPER('Guayana Francesa'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GZ',UPPER('Guernsey'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GN',UPPER('Guinea'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GW',UPPER('Guinea Bissau'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GQ',UPPER('Guinea Ecuatorial'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'HT',UPPER('Haiti'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NL',UPPER('Holanda'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'HN',UPPER('Honduras'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'HK',UPPER('Hong Kong'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'HU',UPPER('Hungria'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'IN',UPPER('India'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ID',UPPER('Indonesia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'IG',UPPER('Inglaterra'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'IG','CORPBANCA', 510)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'IQ',UPPER('Irak'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'IR',UPPER('Iran'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'IE',UPPER('Irlanda'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BV',UPPER('Isla Bouvet'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CX',UPPER('Isla Christmas'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'IM',UPPER('Isla de Man'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NF',UPPER('Isla Norfolk'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PN',UPPER('Isla Pitcairn'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'IS',UPPER('Islandia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KY',UPPER('Islas Caiman'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CC',UPPER('Islas Cocos (Keeling)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CK',UPPER('Islas Cook'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'FO',UPPER('Islas Faroe'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'HM',UPPER('Islas Heard y McDonald'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'FK',UPPER('Islas Malvinas'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MP',UPPER('Islas Marianas del Norte'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MH',UPPER('Islas Marshall'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'GS',UPPER('Islas S. Georgia y S. Sandwich'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SB',UPPER('Islas Salomon'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SJ',UPPER('Islas Svalbard y Jan Mayen'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TC',UPPER('Islas Turks y Caicos'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'VI',UPPER('Islas Virgenes (EE. UU.)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'VG',UPPER('Islas Virgenes (Reino Unido)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'WF',UPPER('Islas Wallis y Futuna'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'IL',UPPER('Israel'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'IT',UPPER('Italia'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'IT','CORPBANCA', 504)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'JM',UPPER('Jamaica'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'JP',UPPER('Japon'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'JP','CORPBANCA', 331)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'JE',UPPER('Jersey'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'JO',UPPER('Jordania'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KZ',UPPER('Kazastan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KE',UPPER('Kenia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KG',UPPER('Kirgistan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KI',UPPER('Kiribati'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KW',UPPER('Kuwait'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LA',UPPER('Laos'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LS',UPPER('Lesoto'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LV',UPPER('Letonia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LB',UPPER('Libano'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LR',UPPER('Liberia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LY',UPPER('Libia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LI',UPPER('Liechtenstein'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LT',UPPER('Lituania'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LU',UPPER('Luxemburgo'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MO',UPPER('Macao (std LE)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MK',UPPER('Macedonia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MG',UPPER('Madagascar'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MY',UPPER('Malasia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MW',UPPER('Malawi'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MV',UPPER('Maldivas'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ML',UPPER('Mali'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MT',UPPER('Malta'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MA',UPPER('Marruecos'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MQ',UPPER('Martinica (Francia)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MU',UPPER('Mauricio'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MR',UPPER('Mauritania'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'YT',UPPER('Mayotte'));

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MX',UPPER('Mejico'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'MX','CORPBANCA', 5)    -- Bac tiene creado dos códigos de pais 
    INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'MX','CORPBANCA', 216)  -- para mexico

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'FM',UPPER('Micronesia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'UM',UPPER('Minor Outlying Islands (EE.UU.)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MD',UPPER('Moldavia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MC',UPPER('Monaco'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MN',UPPER('Mongolia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MS',UPPER('Monserrat'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MZ',UPPER('Mozambique'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'MM',UPPER('Myanmar (Birmania)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NA',UPPER('Namibia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NR',UPPER('Nauru'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NP',UPPER('Nepal'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NI',UPPER('Nicaragua'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NE',UPPER('Niger'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NG',UPPER('Nigeria'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NU',UPPER('Niue'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NO',UPPER('Noruega'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NC',UPPER('Nueva Caledonia (Francia)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NZ',UPPER('Nueva Zelanda'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'OM',UPPER('Oman'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PK',UPPER('Pakistan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PW',UPPER('Palao'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PA',UPPER('Panama'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'PA','CORPBANCA', 210)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PG',UPPER('Papua Nueva Guinea'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PY',UPPER('Paraguay'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PE',UPPER('Peru'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'PE','CORPBANCA', 219)

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PF',UPPER('Polinesia (Francia)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PL',UPPER('Polonia (std LE)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PT',UPPER('Portugal'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PR',UPPER('Puerto Rico'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'QA',UPPER('Qatar'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CF',UPPER('Republica Centro Africana'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CZ',UPPER('Republica Checa'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CD',UPPER('Republica Democratica del Congo'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'DO',UPPER('Republica Dominicana'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SK',UPPER('Republica Eslovaca'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'RE',UPPER('Reunion (Francia)'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'RW',UPPER('Ruanda'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'RO',UPPER('Rumania'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'EH',UPPER('Sahara Occidental'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'KN',UPPER('Saint Kitts (San Cristobal) y Nevis Anguila'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LC',UPPER('Saint Lucia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'PM',UPPER('Saint Pierre y Miquelon'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ST',UPPER('Saint Tome y Principe'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'VC',UPPER('Saint Vincent y Grenadines'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'WS',UPPER('Samoa'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'AS',UPPER('Samoa Americana'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'BL',UPPER('San Bartolome'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SM',UPPER('San Marino'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SX',UPPER('San Martin'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SH',UPPER('Santa Elena'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SN',UPPER('Senegal'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'YU',UPPER('Serbia y Montenegro'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SC',UPPER('Seychelles'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SL',UPPER('Sierra Leona'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SG',UPPER('Singapur'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SY',UPPER('Siria'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SO',UPPER('Somalia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'LK',UPPER('Sri Lanka'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SZ',UPPER('Suazilandia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ZA',UPPER('Sudafrica'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SD',UPPER('Sudan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SS',UPPER('Sudan del Sur'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SE',UPPER('Suecia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'CH',UPPER('Suiza'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'CH','CORPBANCA', 508 )
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'SR',UPPER('Surinam'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TH',UPPER('Tailandia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TW',UPPER('Taiwan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TZ',UPPER('Tanzania'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TJ',UPPER('Tayiquistan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TP',UPPER('Timor Oriental'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TG',UPPER('Togo'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TK',UPPER('Tokelau'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TO',UPPER('Tonga'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TT',UPPER('Trinidad y Tobago'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TN',UPPER('Tunez'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TM',UPPER('Turquestan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TR',UPPER('Turquia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'TV',UPPER('Tuvalu'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'UA',UPPER('Ucrania'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'UG',UPPER('Uganda'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'UY',UPPER('Uruguay'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'UZ',UPPER('Uzbekistan'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'VU',UPPER('Vanuatu'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'VE',UPPER('Venezuela'));
	INSERT INTO #TA_GNL_PAI_EMP VALUES(2012,'VE','CORPBANCA', 201)
    

INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'VN',UPPER('Vietnam'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'YE',UPPER('Yemen'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'DJ',UPPER('Yibouti'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ZR',UPPER('Zaire'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ZM',UPPER('Zambia'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'ZW',UPPER('Zimbabwe'));
INSERT INTO #TA_GNL_PAI_SII VALUES(2012,'NT',UPPER('Zona neutral'));


--TIPO DE RELACION CON CONTRAPARTE
INSERT INTO #TA_GNL_TPO_REL_CTP VALUES(1,UPPER('RelaciOn de propiedad'));
INSERT INTO #TA_GNL_TPO_REL_CTP VALUES(2,UPPER('ParticipaciOn en la direcciOn o administraciOn'));
INSERT INTO #TA_GNL_TPO_REL_CTP VALUES(3,UPPER('Otros tipos de relaciOn'));
INSERT INTO #TA_GNL_TPO_REL_CTP VALUES(4,UPPER('Contraparte se encuentra constituida en un paIs o territorio considerado paraIso tributario'));
INSERT INTO #TA_GNL_TPO_REL_CTP VALUES(99,UPPER('No hay relaciOn'));


--MODALIDAD DE CONTRATACION
INSERT INTO #TA_GNL_MLD_CTN VALUES(1,UPPER('Derivado contratado en bolsa de valores nacional, reconocida por la Superintendencia de Valores y Seguros (SVS)'));
INSERT INTO #TA_GNL_MLD_CTN VALUES(2,UPPER('Derivado contratado en bolsa extranjera afiliada a la Organizacion Internacional de Comisiones de Valores (International Organization of Securities Commissions, IOSCO)'));
INSERT INTO #TA_GNL_MLD_CTN VALUES(3,UPPER('Derivado contratado con la intervencion de agentes o corredores autorizados en mercados organizados, siempre que se encuentren sujetos al control o supervigilancia de la SVS o de algun organismo de similar competencia a dicha superintendencia en su respectiva jurisdiccion, y que este organo, a su vez, constituya un miembro afiliado a IOSCO'));
INSERT INTO #TA_GNL_MLD_CTN VALUES(4,UPPER('Derivado contratado fuera de bolsas de valores en conformidad a modelos de contratos contenidos en acuerdos marco elaborados por asociaciones privadas o publicas extranjeras o internacionales, de caracter financiero o bancaria, y que se utilicen en forma habitual en operaciones financieras con derivados en los mercados internacionales'));
INSERT INTO #TA_GNL_MLD_CTN VALUES(5,UPPER('Derivado contratado fuera de bolsas de valores, mediante confirmaciones que hagan referencia a los modelos de contratos señalados en el codigo 4 anterior'));
INSERT INTO #TA_GNL_MLD_CTN VALUES(6,UPPER('Otra modalidad de contratacion, distinta a las señaladas en los numeros anteriores'));


--TIPO ACUERDO MARCO
INSERT INTO #TA_GNL_TPO_ADO_MRC VALUES(1,UPPER('Condiciones Generales de Contratos de Derivados en el Mercado Local'));
INSERT INTO #TA_GNL_TPO_ADO_MRC VALUES(2,UPPER('Contrato Marco de la International Swap and Derivatives Association (ISDA)'));
INSERT INTO #TA_GNL_TPO_ADO_MRC VALUES(3,UPPER('Otros contratos marco'));


--EVENTO INFORMADO
INSERT INTO #TA_GNL_EVT_IFD VALUES(1,UPPER('Suscrito'));
INSERT INTO #TA_GNL_EVT_IFD VALUES(2,UPPER('Modificado / Recouponing'));
INSERT INTO #TA_GNL_EVT_IFD VALUES(3,UPPER('Cedido'));
INSERT INTO #TA_GNL_EVT_IFD VALUES(4,UPPER('Liquidado'));
INSERT INTO #TA_GNL_EVT_IFD VALUES(5,UPPER('Vencido'));


--TIPO DE CONTRATO

INSERT INTO #TA_GNL_TPO_CTT VALUES(1,UPPER('Forward'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(2,UPPER('Futuro'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(3,UPPER('Swap'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(4,UPPER('Cross Currency Swap'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(5,UPPER('Credit Default Swap'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(6,UPPER('Opción Call Americana'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(7,UPPER('Opción Put Americana'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(8,UPPER('Opción Call Europea'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(9,UPPER('Opción Put Europea'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(10,UPPER('Opción Call Asiática'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(11,UPPER('Opción Put Asiática'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(12,UPPER('Otros derivados incluidos en el N° 2 del artículo 2°, de la Ley 20.544, de 2011'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(13,UPPER('Otros derivados incluidos en el N° 3 del artículo 2°, de la Ley 20.544, de 2011'));
INSERT INTO #TA_GNL_TPO_CTT VALUES(14,UPPER('Otros (indicar nombre del instrumento)'));


--MODALIDAD DE CUMPLIMIENTO
INSERT INTO #TA_GNL_MLD_CUM VALUES(1,UPPER('Compensacion'));
INSERT INTO #TA_GNL_MLD_CUM VALUES(2,UPPER('Entrega física'));


--POSICION DEL DECLARANTE
INSERT INTO #TA_GNL_PSC_DLN VALUES(1,UPPER('Venta'));
INSERT INTO #TA_GNL_PSC_DLN VALUES(2,UPPER('Compra'));


--TIPO ACTIVO SUBYACENTE
INSERT INTO #TA_GNL_ACV_SYE VALUES(1,UPPER('Moneda'));
INSERT INTO #TA_GNL_ACV_SYE VALUES(2,UPPER('Tasa de Interes'));
INSERT INTO #TA_GNL_ACV_SYE VALUES(3,UPPER('Producto Basico / Commodity'));
INSERT INTO #TA_GNL_ACV_SYE VALUES(4,UPPER('Unidad de Fomento'));
INSERT INTO #TA_GNL_ACV_SYE VALUES(5,UPPER('Acciones'));
INSERT INTO #TA_GNL_ACV_SYE VALUES(6,UPPER('Indice Bursatil'));
INSERT INTO #TA_GNL_ACV_SYE VALUES(7,UPPER('Otros (especificar)'));


--TIPO MONEDA (TABLA SII CODIGOS MONEDA)
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ZAR','RAND','AFRICA DEL SUR');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'DEM','MARCOS ALEMANES','ALEMANIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'DZD','DINARES','ALGERIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'SAR','SAUDITA RIYALS','ARABIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ARP','PESOS','ARGENTINA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'AUD','DOLARES','AUSTRALIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ATS','SCHILLINGS','AUSTRIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'BSD','DOLARES','BAHAMAS');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'BBD','DOLARES','BARBADOS');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'BEP','FRANCOS','BELGICA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'BZD','DOLARES','BELICE');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'BMD','DOLARES','BERMUDA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'BOB','PESO BOLIVIANO, SUCRE','BOLIVIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'BRL','REALES, CRUZEIRO','BRASIL');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'BGL','LEVA','BULGARIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'CAD','DOLARES','CANADA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'CLP','PESOS','CHILE');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'CNY','YUAN RENMINBI','CHINA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'CYP','LIBRAS','CHIPRE');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'COP','PESOS','COLOMBIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'KRW','WON','COREA DEL SUR');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'CRC','COLONES','COSTA RICA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'CUP','PESOS','CUBA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'CVE','ESCUDOS','CUBA VERDE');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ANG','FLORIN ANTILLANO','CURAZAO');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'DKK','CORONAS','DINAMARCA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'XCD','OCCIDE','DOLARES DEL CARIBE');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ECS','DOLARES','ECUADOR');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'EGP','LIBRAS, LIRA','EGIPTO');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'SKK','CORONAS','ESLOVAQUIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ESP','PESETAS','ESPAÑA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'USD','DOLARES','ESTADOS UNIDOS');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'EUR','EUROS',' ');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'PHP','PESOS','FILIPINAS');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'FIM','MORKKAA','FINLANDIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'FRF','FRANCOS','FRANCIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'GRD','DRACMAS','GRECIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'GTQ','QUETZALES','GUATEMALA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'GYD','DOLARES','GUAYANAS');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'HTG','GOURDES','HAITI');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'NLG','GUILDERES, FLORIN','HOLANDA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'HNL','LEMPIRAS','HONDURAS');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'HKD','DOLARES','HONG KONG');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'HUF','FORINT','HUNGRIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'INR','RUPIAS','INDIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'IDR','PUPIABS','INDONESIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ILE','LIBRA ESTERLINA','INGLATERRA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'IEP','LIBRAS','IRLANDA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ISK','CORONAS','ISLANDIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'FKP','LIBRAS','ISLAS FALKLAND');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ILS','NUEVOS SHEKELS','ISRAEL');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ITL','LIBRAS, LIRA','ITALIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'JMD','DOLARES','JAMAICA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'JPY','YENES','JAPON');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'JOD','DINARES','JORDANIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'LBP','LIBRAS','LIBANO');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'LUF','FRANCOS','LUXEMBURGO');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'MYR','RINGGITS','MALASIA');

-- Ojo con Pesos Mejicanos
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'MXP','PESOS','MEXICO');

INSERT INTO #TA_GNL_MON_SII VALUES(2012,'NIO','CORDOBAS DE ORO','NICARAGUA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'NOK','CORONA','NORUEGA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'NZD','DOLARES','NUEVA ZELANDA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'PKR','RUPIAS','PAKISTAN');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'PAB','BALBOAS','PANAMA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'PYG','GUARANIES','PARAGUAY');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'PEN','NUEVOS SOLES','PERU');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'PLZ','ZLOTYCH','POLONIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'PTE','ESCUDOS','PORTUGAL');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'GBP','LIBRAS','REINO UNIDO');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'CZK','KORUNY','REPUBLICA CHECA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'DOP','PESO','REPUBLICA DOMINICANA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ROL','LEI','RUMANIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'RUR','RUBLOS','RUSIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'SVS','COLONES','SALVADOR');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ANG','FLORIN ANTILLANO','SAN  MARTIN');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'SGD','DOLARES','SINGAPUR');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'SSP','LIBRA','SUDAN DEL SUR');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'SDD','DINARES','SUDAN');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'SEK','CORONAS','SUECIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'CHF','FRANCOS','SUIZA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'SRG','GUILDARES','SURINAM');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'THB','BAHT','TAILANDIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'TWD','NUEVOS DOLARES','TAIWAN');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'TTD','DOLARES','TRINIDAD Y TOBAGO');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'TRL','LIBRAS, LIRA','TURQUIA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'UYU','PESOS','URUGUAY');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'VEB','BOLIVARES','VENEZUELA');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'YUD','DINARS','YUGOSLAVO');
INSERT INTO #TA_GNL_MON_SII VALUES(2012,'ZMK','KWACHA','ZAMBIA');


--TASA DE INTERES
INSERT INTO #TA_GNL_TSA_INT VALUES(1,'FIJA');
INSERT INTO #TA_GNL_TSA_INT VALUES(2,'VARIABLE');


--TASA DE INTERES VARIABLE
Insert into #TA_GNL_TSA_INT_VAR select 8, 'LIBOR EURO 1 MES', 16, 142
Insert into #TA_GNL_TSA_INT_VAR select 9, 'LIBOR EURO 3 MESES', 17, 142
Insert into #TA_GNL_TSA_INT_VAR select 10, 'LIBOR EURO 6 MESES', 18, 142
Insert into #TA_GNL_TSA_INT_VAR select 11, 'LIBOR EURO 12 MESES', 19, 142
Insert into #TA_GNL_TSA_INT_VAR select 16, 'LIBOR USD 1 MES', 5, 13
Insert into #TA_GNL_TSA_INT_VAR select 18, 'LIBOR USD 3 MESES', 6, 13
Insert into #TA_GNL_TSA_INT_VAR select 20, 'LIBOR USD 6 MESES', 7, 13
Insert into #TA_GNL_TSA_INT_VAR select 21, 'LIBOR USD 12 MESES', 14, 13
Insert into #TA_GNL_TSA_INT_VAR select 33, 'TAB UF 3 MESES', 8, 998
Insert into #TA_GNL_TSA_INT_VAR select 34, 'TAB UF 6 MESES', 10, 998
Insert into #TA_GNL_TSA_INT_VAR select 35, 'TAB UF 12 MESES', 15, 998
Insert into #TA_GNL_TSA_INT_VAR select 36, 'TAB NOMINAL 1 MES', 9, 999
Insert into #TA_GNL_TSA_INT_VAR select 37, 'TAB NOMINAL 3 MESES', 8, 999
Insert into #TA_GNL_TSA_INT_VAR select 38, 'TAB NOMINAL 6 MESES', 10, 999
Insert into #TA_GNL_TSA_INT_VAR select 39, 'TAB NOMINAL 12 MESES', 15, 999
Insert into #TA_GNL_TSA_INT_VAR select 40, 'OTRAS', 0, 0



--PRODUCTO BASICO
INSERT INTO #TA_GNL_PTO_BSC  VALUES(1,UPPER('Cobre'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(2,UPPER('Oro'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(3,UPPER('Plata'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(4,UPPER('Zinc'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(5,UPPER('Plomo'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(6,UPPER('Aluminio'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(7,UPPER('Niquel'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(8,UPPER('Petroleo'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(9,UPPER('Gas Propano'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(10,UPPER('Jet Fuel 54'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(11,UPPER('Heating Oil'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(12,UPPER('Oil Wti'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(13,UPPER('Fuel Oil 3.5'));
INSERT INTO #TA_GNL_PTO_BSC  VALUES(14,UPPER('Otros (especificar)'));


--CODIGO DE PRECIO
INSERT INTO #TA_GNL_COD_PRC VALUES(1,UPPER('Valor Monetario'));
INSERT INTO #TA_GNL_COD_PRC VALUES(2,UPPER('Tasa (%)'));


--UNIDAD MONETARIA O MEDIDA
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(1,UPPER('Pesos Chilenos'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(2,UPPER('US Dolares'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(3,UPPER('Unidad de Fomento'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(4,UPPER('Libras esterlinas'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(5,UPPER('Euros'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(6,UPPER('Yenes'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(7,UPPER('Libras'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(8,UPPER('Toneladas'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(9,UPPER('Onzas'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(10,UPPER('Barriles'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(11,UPPER('Galon Americano'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(12,UPPER('Galon Ingles'));
INSERT INTO #TA_GNL_UND_MNA_MID VALUES(13,UPPER('Otros'));

-- Monedas Empresa Corpbanca
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 5, 'BRL'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 6, 'CAD'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 2, 13, 'USD'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 24, 'PEN'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 36, 'AUD'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 48, 'CNY'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 51, 'DKK'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 6, 72, 'JPY'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 82, 'CHF'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 96, 'NOK'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 4, 102, 'GBP'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 113, 'SEK'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 127, 'HKD'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 129, 'COP'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 132, 'MXP'   -- < Cambiar este codigo cuando aplique valdiación
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 5, 142, 'EUR'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 144, 'KRW'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 3, 998, 'CLF'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 1, 999, 'CLP'
 Insert into #TA_GNL_UND_MNA_MID_EMP select 'CORPBANCA' , 13, 0, ''




--CONTRATO VENCIDO EN EL EJERCICIO
INSERT INTO #TA_GNL_CTT_VNC_EJR VALUES(1,UPPER('Vencido en el periodo informado'));
INSERT INTO #TA_GNL_CTT_VNC_EJR VALUES(2,UPPER('Vigente al 31 de diciembre del año que se informa'));


--ESTADO DEL CONTRATO/CONFIRMACION
INSERT INTO #TA_GNL_EST_CTT_CFM VALUES(1,UPPER('Suscrito'));
INSERT INTO #TA_GNL_EST_CTT_CFM VALUES(2,UPPER('Modificado / Recouponing'));
INSERT INTO #TA_GNL_EST_CTT_CFM VALUES(3,UPPER('Contrato proveniente del ejercicio anterior'));
INSERT INTO #TA_GNL_EST_CTT_CFM VALUES(4,UPPER('Cedido'));


--MODALIDAD DE PAGO
INSERT INTO #TA_GNL_MLD_PAG VALUES(1,UPPER('En dinero (efectivo, vales vista u otros equivalentes)'));
INSERT INTO #TA_GNL_MLD_PAG VALUES(2,UPPER('En acciones'));
INSERT INTO #TA_GNL_MLD_PAG VALUES(3,UPPER('En derechos sociales'));
INSERT INTO #TA_GNL_MLD_PAG VALUES(4,UPPER('En otras especies'));

-- TAX-ID
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 200000191, 1, '94-1687665'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 407855136, 1, '100390095RC001'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 446410828, 1, '13-5160382'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 403770828, 1, '13-4942190'

INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 407655268, 1, 'FR 76662042449'

INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 411885828, 1, '13-5266470'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 452612276, 1, 'CI 452612276-9'

INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 412645828, 1, '97023000-9'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 415083828, 1, '36-2813095'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 413045828, 1, '98-0330001'


INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 415565828, 1, '13-2944988'

INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 463180828, 1, '133092284'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 200000178, 1, '20-1177241'

INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 200000190, 1, '13-4994650'

INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 200012995, 1, '20-8764829'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 470300136, 1, '13-5357855'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 465070276, 1, '834 98360 06707'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 450959172, 1, '890903937-0'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 472655828, 1, '94-1595409'



INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 480250200, 1, '98-186363'

INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 484315828, 1, '94-1347393'

INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 200504688, 1, '830122566-1'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 200015041, 1, '20301821388'
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 200505199, 1, '900161460-1'	

-- Agregado el 22 Nov 2013
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 413045200, 1, 'J 000.015.364'	
INSERT INTO #TA_GNL_CLI_TAXID select 'CORPBANCA' , 453183276, 1, '268 41660 23150'

-- Ruts que han cambiado su Rut durante el periodo
-- fenómineo similar a la sesión.
-- requiere que nunca se vuelvan a borrar clientes en BAC.
-- Se utiliza para informar operaciones de clientes
-- extranjeros que tienen Rut Chileno.
-- Por esta razón no hay seciones porque no se sabe 
-- cuando se realiza el cambio de Rut en la cartera 
-- del sistema Origen.
 Insert into #TA_GNL_RUT_MOD select 99512160 , 1, 99289000, 1
 Insert into #TA_GNL_RUT_MOD select 200000178 , 1, 47010500, 1
 Insert into #TA_GNL_RUT_MOD select 472655828 , 1, 47005194, 1
-- Se hicieron seciones de contratos
-- Insert into #TA_GNL_RUT_MOD select 76878120 , 1, 76937050, 1
-- Insert into #TA_GNL_RUT_MOD select 96529340 , 1, 96532830, 1 



-- Contratos Marco múltiples
-- a lo largo de la relación 
-- con el Banco
 Insert #Contratos_Marco select 'CORPBANCA', 643293, 1, 576, '20090430'
 Insert #Contratos_Marco select 'CORPBANCA', 2358505, 1, 463, '20081015'
 Insert #Contratos_Marco select 'CORPBANCA', 2358505, 1, 1216, '20101221'
 Insert #Contratos_Marco select 'CORPBANCA', 2765662, 1, 1247, '20110804'
 Insert #Contratos_Marco select 'CORPBANCA', 3050566, 1, 1349, '20111223'
 Insert #Contratos_Marco select 'CORPBANCA', 3468996, 1, 1476, '20120625'
 Insert #Contratos_Marco select 'CORPBANCA', 3563034, 1, 710, '20091221'
 Insert #Contratos_Marco select 'CORPBANCA', 3592979, 1, 424, '20080812'
 Insert #Contratos_Marco select 'CORPBANCA', 3719211, 1, 773, '20100401'
 Insert #Contratos_Marco select 'CORPBANCA', 3786450, 1, 1018, '20110222'
 Insert #Contratos_Marco select 'CORPBANCA', 4068808, 1, 1110, '20110503'
 Insert #Contratos_Marco select 'CORPBANCA', 4157399, 1, 922, '20101018'
 Insert #Contratos_Marco select 'CORPBANCA', 4213940, 1, 1059, '20110330'
 Insert #Contratos_Marco select 'CORPBANCA', 4229125, 1, 1293, '20111005'
 Insert #Contratos_Marco select 'CORPBANCA', 4516265, 1, 579, '20090525'
 Insert #Contratos_Marco select 'CORPBANCA', 4531443, 1, 487, '20081103'
 Insert #Contratos_Marco select 'CORPBANCA', 4590881, 1, 832, '20100707'
 Insert #Contratos_Marco select 'CORPBANCA', 4606080, 1, 277, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 4641068, 1, 1464, '20120620'
 Insert #Contratos_Marco select 'CORPBANCA', 4664730, 1, 1206, '20110926'
 Insert #Contratos_Marco select 'CORPBANCA', 4694801, 1, 875, '20100831'
 Insert #Contratos_Marco select 'CORPBANCA', 4702190, 1, 564, '20090409'
 Insert #Contratos_Marco select 'CORPBANCA', 4702190, 1, 1271, '20110929'
 Insert #Contratos_Marco select 'CORPBANCA', 4865943, 1, 201, '20050930'
 Insert #Contratos_Marco select 'CORPBANCA', 4942962, 1, 951, '20101125'
 Insert #Contratos_Marco select 'CORPBANCA', 4981255, 1, 590, '20090616'
 Insert #Contratos_Marco select 'CORPBANCA', 4981255, 1, 940, '20101115'
 Insert #Contratos_Marco select 'CORPBANCA', 5002932, 1, 586, '20090604'
 Insert #Contratos_Marco select 'CORPBANCA', 5028194, 1, 772, '20100426'
 Insert #Contratos_Marco select 'CORPBANCA', 5084186, 1, 171, '20040701'
 Insert #Contratos_Marco select 'CORPBANCA', 5118333, 1, 1418, '20120426'
 Insert #Contratos_Marco select 'CORPBANCA', 5138338, 1, 1303, '20111117'
 Insert #Contratos_Marco select 'CORPBANCA', 5141290, 1, 1007, '20110208'
 Insert #Contratos_Marco select 'CORPBANCA', 5145132, 1, 1399, '20120319'
 Insert #Contratos_Marco select 'CORPBANCA', 5171123, 1, 645, '20090930'
 Insert #Contratos_Marco select 'CORPBANCA', 5232435, 1, 1294, '20111012'
 Insert #Contratos_Marco select 'CORPBANCA', 5458230, 1, 685, '20090717'
 Insert #Contratos_Marco select 'CORPBANCA', 5458230, 1, 1012, '20101217'
 Insert #Contratos_Marco select 'CORPBANCA', 5587601, 1, 501, '20081125'
 Insert #Contratos_Marco select 'CORPBANCA', 5587601, 1, 1414, '20120417'
 Insert #Contratos_Marco select 'CORPBANCA', 5759672, 1, 715, '20091203'
 Insert #Contratos_Marco select 'CORPBANCA', 5823592, 1, 657, '20090929'
 Insert #Contratos_Marco select 'CORPBANCA', 5945709, 1, 1395, '20120313'
 Insert #Contratos_Marco select 'CORPBANCA', 5955057, 1, 1031, '20110224'
 Insert #Contratos_Marco select 'CORPBANCA', 6047435, 1, 628, '20090820'
 Insert #Contratos_Marco select 'CORPBANCA', 6120920, 1, 1176, '20110824'
 Insert #Contratos_Marco select 'CORPBANCA', 6321385, 1, 321, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 6375868, 1, 522, '20090122'
 Insert #Contratos_Marco select 'CORPBANCA', 6412060, 1, 821, '20100623'
 Insert #Contratos_Marco select 'CORPBANCA', 6420857, 1, 1227, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 6422827, 1, 1551, '20120727'
 Insert #Contratos_Marco select 'CORPBANCA', 6456741, 1, 1061, '20110330'
 Insert #Contratos_Marco select 'CORPBANCA', 6640637, 1, 763, '20100427'
 Insert #Contratos_Marco select 'CORPBANCA', 6671269, 1, 839, '20100712'
 Insert #Contratos_Marco select 'CORPBANCA', 6706868, 1, 636, '20090908'
 Insert #Contratos_Marco select 'CORPBANCA', 6785722, 1, 1185, '20110915'
 Insert #Contratos_Marco select 'CORPBANCA', 7010884, 1, 278, '20071112'
 Insert #Contratos_Marco select 'CORPBANCA', 7033119, 1, 437, '20080820'
 Insert #Contratos_Marco select 'CORPBANCA', 7035478, 1, 931, '20101025'
 Insert #Contratos_Marco select 'CORPBANCA', 7051391, 1, 1222, '20110928'
 Insert #Contratos_Marco select 'CORPBANCA', 7051658, 1, 801, '20100528'
 Insert #Contratos_Marco select 'CORPBANCA', 7060219, 1, 213, '20060119'
 Insert #Contratos_Marco select 'CORPBANCA', 7076909, 1, 848, '20100810'
 Insert #Contratos_Marco select 'CORPBANCA', 7125590, 1, 688, '20091124'
 Insert #Contratos_Marco select 'CORPBANCA', 7140273, 1, 840, '20100607'
 Insert #Contratos_Marco select 'CORPBANCA', 7140541, 1, 1122, '20110531'
 Insert #Contratos_Marco select 'CORPBANCA', 7515289, 1, 585, '20090519'
 Insert #Contratos_Marco select 'CORPBANCA', 7589512, 1, 1232, '20110929'
 Insert #Contratos_Marco select 'CORPBANCA', 7641682, 1, 843, '20100722'
 Insert #Contratos_Marco select 'CORPBANCA', 7652186, 1, 349, '20070803'
 Insert #Contratos_Marco select 'CORPBANCA', 7675080, 1, 665, '20090907'
 Insert #Contratos_Marco select 'CORPBANCA', 7721123, 1, 833, '20100712'
 Insert #Contratos_Marco select 'CORPBANCA', 7778689, 1, 327, '20080218'
 Insert #Contratos_Marco select 'CORPBANCA', 7803028, 1, 1495, '20120727'
 Insert #Contratos_Marco select 'CORPBANCA', 7819195, 1, 152, '20030721'
 Insert #Contratos_Marco select 'CORPBANCA', 7998534, 1, 1009, '20110211'
 Insert #Contratos_Marco select 'CORPBANCA', 8178884, 1, 572, '20090408'
 Insert #Contratos_Marco select 'CORPBANCA', 8266360, 1, 1219, '20110926'
 Insert #Contratos_Marco select 'CORPBANCA', 8321434, 1, 1365, '20120203'
 Insert #Contratos_Marco select 'CORPBANCA', 8529009, 1, 651, '20090928'
 Insert #Contratos_Marco select 'CORPBANCA', 8697721, 1, 741, '20100217'
 Insert #Contratos_Marco select 'CORPBANCA', 8722081, 1, 838, '20100622'
 Insert #Contratos_Marco select 'CORPBANCA', 8906439, 1, 1269, '20111018'
 Insert #Contratos_Marco select 'CORPBANCA', 9001155, 1, 1482, '20120713'
 Insert #Contratos_Marco select 'CORPBANCA', 9011450, 1, 650, '20090928'
 Insert #Contratos_Marco select 'CORPBANCA', 9426547, 1, 577, '20090514'
 Insert #Contratos_Marco select 'CORPBANCA', 9499418, 1, 260, '20071002'
 Insert #Contratos_Marco select 'CORPBANCA', 9821790, 1, 566, '20090427'
 Insert #Contratos_Marco select 'CORPBANCA', 9838700, 1, 631, '20090827'
 Insert #Contratos_Marco select 'CORPBANCA', 9838700, 1, 1060, '20110329'
 Insert #Contratos_Marco select 'CORPBANCA', 9938243, 1, 1106, '20110511'
 Insert #Contratos_Marco select 'CORPBANCA', 99522260, 1, 1530, '20120914'
 Insert #Contratos_Marco select 'CORPBANCA', 10314613, 1, 1201, '20110928'
 Insert #Contratos_Marco select 'CORPBANCA', 10651093, 1, 1145, '20110623'
 Insert #Contratos_Marco select 'CORPBANCA', 10667183, 1, 1238, '20111003'
 Insert #Contratos_Marco select 'CORPBANCA', 10757671, 1, 707, '20091216'
 Insert #Contratos_Marco select 'CORPBANCA', 10771795, 1, 398, '20080625'
 Insert #Contratos_Marco select 'CORPBANCA', 10807219, 1, 671, '20091027'
 Insert #Contratos_Marco select 'CORPBANCA', 10818329, 1, 599, '20090618'
 Insert #Contratos_Marco select 'CORPBANCA', 10866312, 1, 494, '20081110'
 Insert #Contratos_Marco select 'CORPBANCA', 10978034, 1, 1221, '20111003'
 Insert #Contratos_Marco select 'CORPBANCA', 11354610, 1, 887, '20100903'
 Insert #Contratos_Marco select 'CORPBANCA', 11839042, 1, 393, '20080620'
 Insert #Contratos_Marco select 'CORPBANCA', 12158749, 1, 1113, '20110517'
 Insert #Contratos_Marco select 'CORPBANCA', 13375199, 1, 1362, '20120131'
 Insert #Contratos_Marco select 'CORPBANCA', 14606841, 1, 1333, '20111121'
 Insert #Contratos_Marco select 'CORPBANCA', 14652055, 1, 820, '20100622'
 Insert #Contratos_Marco select 'CORPBANCA', 15032879, 1, 625, '20090820'
 Insert #Contratos_Marco select 'CORPBANCA', 22216083, 1, 992, '20101223'
 Insert #Contratos_Marco select 'CORPBANCA', 50143670, 1, 885, '20100902'
 Insert #Contratos_Marco select 'CORPBANCA', 52003596, 1, 884, '20100826'
 Insert #Contratos_Marco select 'CORPBANCA', 53125850, 1, 1523, '20120822'
 Insert #Contratos_Marco select 'CORPBANCA', 59005440, 1, 485, '20081027'
 Insert #Contratos_Marco select 'CORPBANCA', 59014840, 1, 4, '19970122'
 Insert #Contratos_Marco select 'CORPBANCA', 59071650, 1, 157, '20031119'
 Insert #Contratos_Marco select 'CORPBANCA', 59089370, 1, 803, '20100211'
 Insert #Contratos_Marco select 'CORPBANCA', 61105000, 1, 155, '20030910'
 Insert #Contratos_Marco select 'CORPBANCA', 61106000, 1, 1344, '20121228'
 Insert #Contratos_Marco select 'CORPBANCA', 61113000, 1, 600, '20090625'
 Insert #Contratos_Marco select 'CORPBANCA', 61113000, 1, 1317, '20111114'
 Insert #Contratos_Marco select 'CORPBANCA', 61214000, 1, 1099, '20110503'
 Insert #Contratos_Marco select 'CORPBANCA', 61219000, 1, 1417, '20120301'
 Insert #Contratos_Marco select 'CORPBANCA', 61704000, 1, 25, '19980115'
 Insert #Contratos_Marco select 'CORPBANCA', 65378030, 1, 699, '20091120'
 Insert #Contratos_Marco select 'CORPBANCA', 65855580, 1, 746, '20100315'
 Insert #Contratos_Marco select 'CORPBANCA', 70020030, 1, 910, '20100319'
 Insert #Contratos_Marco select 'CORPBANCA', 70500400, 1, 975, '20101216'
 Insert #Contratos_Marco select 'CORPBANCA', 70741700, 1, 568, '20090428'
 Insert #Contratos_Marco select 'CORPBANCA', 70821000, 1, 834, '20100708'
 Insert #Contratos_Marco select 'CORPBANCA', 71124000, 1, 905, '20101001'
 Insert #Contratos_Marco select 'CORPBANCA', 71458700, 1, 1426, '20120516'
 Insert #Contratos_Marco select 'CORPBANCA', 71540100, 1, 269, '19000101'
 Insert #Contratos_Marco select 'CORPBANCA', 71915800, 1, 630, '20090709'
 Insert #Contratos_Marco select 'CORPBANCA', 73868900, 1, 1014, '20110125'
 Insert #Contratos_Marco select 'CORPBANCA', 74822900, 1, 974, '20101223'
 Insert #Contratos_Marco select 'CORPBANCA', 76003557, 1, 1188, '20110916'
 Insert #Contratos_Marco select 'CORPBANCA', 76005008, 1, 817, '20100623'
 Insert #Contratos_Marco select 'CORPBANCA', 76005448, 1, 1330, '20111206'
 Insert #Contratos_Marco select 'CORPBANCA', 76005843, 1, 1442, '20120530'
 Insert #Contratos_Marco select 'CORPBANCA', 76006523, 1, 1180, '20110817'
 Insert #Contratos_Marco select 'CORPBANCA', 76006807, 1, 401, '20080708'
 Insert #Contratos_Marco select 'CORPBANCA', 76006807, 1, 1003, '20101126'
 Insert #Contratos_Marco select 'CORPBANCA', 76006854, 1, 716, '20091230'
 Insert #Contratos_Marco select 'CORPBANCA', 76006932, 1, 818, '20100623'
 Insert #Contratos_Marco select 'CORPBANCA', 76009776, 1, 1044, '20110314'
 Insert #Contratos_Marco select 'CORPBANCA', 76009926, 1, 395, '20080624'
 Insert #Contratos_Marco select 'CORPBANCA', 76014544, 1, 1261, '20111020'
 Insert #Contratos_Marco select 'CORPBANCA', 76014660, 1, 1539, '20120921'
 Insert #Contratos_Marco select 'CORPBANCA', 76015307, 1, 1191, '20110908'
 Insert #Contratos_Marco select 'CORPBANCA', 76015905, 1, 455, '20080911'
 Insert #Contratos_Marco select 'CORPBANCA', 76016565, 1, 765, '20100427'
 Insert #Contratos_Marco select 'CORPBANCA', 76017166, 1, 814, '20100428'
 Insert #Contratos_Marco select 'CORPBANCA', 76017406, 1, 737, '20100203'
 Insert #Contratos_Marco select 'CORPBANCA', 76018552, 1, 1274, '20111027'
 Insert #Contratos_Marco select 'CORPBANCA', 76019233, 1, 771, '20100510'
 Insert #Contratos_Marco select 'CORPBANCA', 76019875, 1, 1436, '20120313'
 Insert #Contratos_Marco select 'CORPBANCA', 76020064, 1, 808, '20100618'
 Insert #Contratos_Marco select 'CORPBANCA', 76021652, 1, 449, '20080922'
 Insert #Contratos_Marco select 'CORPBANCA', 76022024, 1, 1267, '20110829'
 Insert #Contratos_Marco select 'CORPBANCA', 76026378, 1, 703, '20091209'
 Insert #Contratos_Marco select 'CORPBANCA', 76028976, 1, 1406, '20120327'
 Insert #Contratos_Marco select 'CORPBANCA', 76029904, 1, 877, '20100825'
 Insert #Contratos_Marco select 'CORPBANCA', 76032263, 1, 853, '20100812'
 Insert #Contratos_Marco select 'CORPBANCA', 76032340, 1, 337, '20080222'
 Insert #Contratos_Marco select 'CORPBANCA', 76032882, 1, 1425, '20120202'
 Insert #Contratos_Marco select 'CORPBANCA', 76033031, 1, 1462, '20120320'
 Insert #Contratos_Marco select 'CORPBANCA', 76033830, 1, 1112, '20110517'
 Insert #Contratos_Marco select 'CORPBANCA', 76034605, 1, 894, '20100426'
 Insert #Contratos_Marco select 'CORPBANCA', 76035224, 1, 996, '20110113'
 Insert #Contratos_Marco select 'CORPBANCA', 76035878, 1, 1290, '20110913'
 Insert #Contratos_Marco select 'CORPBANCA', 76037422, 1, 675, '20091020'
 Insert #Contratos_Marco select 'CORPBANCA', 76038659, 1, 523, '20090126'
 Insert #Contratos_Marco select 'CORPBANCA', 76038873, 1, 1021, '20110217'
 Insert #Contratos_Marco select 'CORPBANCA', 76039338, 1, 1402, '20120320'
 Insert #Contratos_Marco select 'CORPBANCA', 76039791, 1, 1029, '20110303'
 Insert #Contratos_Marco select 'CORPBANCA', 76041000, 1, 460, '20081013'
 Insert #Contratos_Marco select 'CORPBANCA', 76041000, 1, 991, '20101230'
 Insert #Contratos_Marco select 'CORPBANCA', 76041516, 1, 937, '20101108'
 Insert #Contratos_Marco select 'CORPBANCA', 76043983, 1, 856, '20100811'
 Insert #Contratos_Marco select 'CORPBANCA', 76044380, 1, 1496, '20120502'
 Insert #Contratos_Marco select 'CORPBANCA', 76044565, 1, 1013, '20110216'
 Insert #Contratos_Marco select 'CORPBANCA', 76045645, 1, 1508, '20120810'
 Insert #Contratos_Marco select 'CORPBANCA', 76046889, 1, 1487, '20120417'
 Insert #Contratos_Marco select 'CORPBANCA', 76048496, 1, 690, '20091126'
 Insert #Contratos_Marco select 'CORPBANCA', 76049778, 1, 624, '20090610'
 Insert #Contratos_Marco select 'CORPBANCA', 76049778, 1, 1434, '20120416'
 Insert #Contratos_Marco select 'CORPBANCA', 76051306, 1, 1154, '20110727'
 Insert #Contratos_Marco select 'CORPBANCA', 76054764, 1, 1465, '20120627'
 Insert #Contratos_Marco select 'CORPBANCA', 76055311, 1, 872, '20100819'
 Insert #Contratos_Marco select 'CORPBANCA', 76056132, 1, 1028, '20110307'
 Insert #Contratos_Marco select 'CORPBANCA', 76059250, 1, 648, '20090916'
 Insert #Contratos_Marco select 'CORPBANCA', 76059568, 1, 909, '20101004'
 Insert #Contratos_Marco select 'CORPBANCA', 76061994, 1, 1301, '20111116'
 Insert #Contratos_Marco select 'CORPBANCA', 76061995, 1, 1287, '20111109'
 Insert #Contratos_Marco select 'CORPBANCA', 76062372, 1, 908, '20100513'
 Insert #Contratos_Marco select 'CORPBANCA', 76062693, 1, 682, '20091022'
 Insert #Contratos_Marco select 'CORPBANCA', 76062693, 1, 1083, '20110427'
 Insert #Contratos_Marco select 'CORPBANCA', 76066160, 1, 1375, '20120125'
 Insert #Contratos_Marco select 'CORPBANCA', 76067373, 1, 1537, '20120928'
 Insert #Contratos_Marco select 'CORPBANCA', 76069250, 1, 972, '20101209'
 Insert #Contratos_Marco select 'CORPBANCA', 76070147, 1, 1073, '20110407'
 Insert #Contratos_Marco select 'CORPBANCA', 76070442, 1, 667, '20091023'
 Insert #Contratos_Marco select 'CORPBANCA', 76070750, 1, 1141, '20110304'
 Insert #Contratos_Marco select 'CORPBANCA', 76071932, 1, 786, '20100519'
 Insert #Contratos_Marco select 'CORPBANCA', 76073260, 1, 1142, '20110629'
 Insert #Contratos_Marco select 'CORPBANCA', 76074938, 1, 1283, '20111026'
 Insert #Contratos_Marco select 'CORPBANCA', 76077073, 1, 967, '20101214'
 Insert #Contratos_Marco select 'CORPBANCA', 76078485, 1, 1320, '20111128'
 Insert #Contratos_Marco select 'CORPBANCA', 76080290, 1, 1133, '20110628'
 Insert #Contratos_Marco select 'CORPBANCA', 76081583, 1, 757, '20100323'
 Insert #Contratos_Marco select 'CORPBANCA', 76081733, 1, 1387, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 76082113, 1, 1092, '20110210'
 Insert #Contratos_Marco select 'CORPBANCA', 76084500, 1, 714, '20100106'
 Insert #Contratos_Marco select 'CORPBANCA', 76084500, 1, 981, '20100913'
 Insert #Contratos_Marco select 'CORPBANCA', 76086051, 1, 1277, '20111013'
 Insert #Contratos_Marco select 'CORPBANCA', 76089725, 1, 761, '20100428'
 Insert #Contratos_Marco select 'CORPBANCA', 76092970, 1, 1005, '20110207'
 Insert #Contratos_Marco select 'CORPBANCA', 76094530, 1, 534, '20090206'
 Insert #Contratos_Marco select 'CORPBANCA', 76095221, 1, 1186, '20110829'
 Insert #Contratos_Marco select 'CORPBANCA', 76095530, 1, 1335, '20110331'
 Insert #Contratos_Marco select 'CORPBANCA', 76096430, 1, 691, '20091201'
 Insert #Contratos_Marco select 'CORPBANCA', 76098444, 1, 819, '20100623'
 Insert #Contratos_Marco select 'CORPBANCA', 76099344, 1, 961, '20101210'
 Insert #Contratos_Marco select 'CORPBANCA', 76099978, 1, 966, '20101216'
 Insert #Contratos_Marco select 'CORPBANCA', 76100845, 1, 1030, '20110126'
 Insert #Contratos_Marco select 'CORPBANCA', 76101037, 1, 1334, '20111206'
 Insert #Contratos_Marco select 'CORPBANCA', 76101100, 1, 755, '20100318'
 Insert #Contratos_Marco select 'CORPBANCA', 76103472, 1, 1144, '20110610'
 Insert #Contratos_Marco select 'CORPBANCA', 76103595, 1, 1165, '20110712'
 Insert #Contratos_Marco select 'CORPBANCA', 76106658, 1, 1084, '20110428'
 Insert #Contratos_Marco select 'CORPBANCA', 76107649, 1, 855, '20100817'
 Insert #Contratos_Marco select 'CORPBANCA', 76109779, 1, 1125, '20110610'
 Insert #Contratos_Marco select 'CORPBANCA', 76109852, 1, 1213, '20110916'
 Insert #Contratos_Marco select 'CORPBANCA', 76110780, 1, 844, '20100723'
 Insert #Contratos_Marco select 'CORPBANCA', 76111055, 1, 1393, '20111125'
 Insert #Contratos_Marco select 'CORPBANCA', 76113247, 1, 1477, '20120627'
 Insert #Contratos_Marco select 'CORPBANCA', 76114191, 1, 1376, '20120118'
 Insert #Contratos_Marco select 'CORPBANCA', 76117596, 1, 987, '20101230'
 Insert #Contratos_Marco select 'CORPBANCA', 76122600, 1, 1291, '20110602'
 Insert #Contratos_Marco select 'CORPBANCA', 76122889, 1, 1279, '20110324'
 Insert #Contratos_Marco select 'CORPBANCA', 76123046, 1, 1050, '20110322'
 Insert #Contratos_Marco select 'CORPBANCA', 76123474, 1, 1357, '20111214'
 Insert #Contratos_Marco select 'CORPBANCA', 76123476, 1, 1355, '20111214'
 Insert #Contratos_Marco select 'CORPBANCA', 76123477, 1, 1358, '20111214'
 Insert #Contratos_Marco select 'CORPBANCA', 76123478, 1, 1356, '20111214'
 Insert #Contratos_Marco select 'CORPBANCA', 76123611, 1, 1505, '20120806'
 Insert #Contratos_Marco select 'CORPBANCA', 76127226, 1, 1309, '20111125'
 Insert #Contratos_Marco select 'CORPBANCA', 76133190, 1, 1491, '20120710'
 Insert #Contratos_Marco select 'CORPBANCA', 76133940, 1, 425, '20080813'
 Insert #Contratos_Marco select 'CORPBANCA', 76136200, 1, 499, '20081117'
 Insert #Contratos_Marco select 'CORPBANCA', 76137682, 1, 1172, '20110830'
 Insert #Contratos_Marco select 'CORPBANCA', 76142490, 1, 1310, '20111011'
 Insert #Contratos_Marco select 'CORPBANCA', 76144747, 1, 1284, '20111019'
 Insert #Contratos_Marco select 'CORPBANCA', 76147546, 1, 1341, '20111220'
 Insert #Contratos_Marco select 'CORPBANCA', 76159602, 1, 1532, '20120913'
 Insert #Contratos_Marco select 'CORPBANCA', 76161355, 1, 1548, '20121012'
 Insert #Contratos_Marco select 'CORPBANCA', 76165311, 1, 1273, '20111028'
 Insert #Contratos_Marco select 'CORPBANCA', 76171473, 1, 1557, '20121024'
 Insert #Contratos_Marco select 'CORPBANCA', 76175383, 1, 1420, '20120425'
 Insert #Contratos_Marco select 'CORPBANCA', 76181960, 1, 1559, '20121029'
 Insert #Contratos_Marco select 'CORPBANCA', 76183080, 1, 753, '20100415'
 Insert #Contratos_Marco select 'CORPBANCA', 76183140, 1, 1049, '20110318'
 Insert #Contratos_Marco select 'CORPBANCA', 76184610, 1, 993, '20110106'
 Insert #Contratos_Marco select 'CORPBANCA', 76186690, 1, 1209, '20110303'
 Insert #Contratos_Marco select 'CORPBANCA', 76203449, 1, 1430, '20120411'
 Insert #Contratos_Marco select 'CORPBANCA', 76208895, 1, 1502, '20120801'
 Insert #Contratos_Marco select 'CORPBANCA', 76230505, 1, 1560, '20121029'
 Insert #Contratos_Marco select 'CORPBANCA', 76253220, 1, 901, '20100927'
 Insert #Contratos_Marco select 'CORPBANCA', 76254920, 1, 1220, '20110929'
 Insert #Contratos_Marco select 'CORPBANCA', 76260550, 1, 983, '20101214'
 Insert #Contratos_Marco select 'CORPBANCA', 76267300, 1, 1515, '20120806'
 Insert #Contratos_Marco select 'CORPBANCA', 76267610, 1, 1152, '20101111'
 Insert #Contratos_Marco select 'CORPBANCA', 76277200, 1, 816, '20100623'
 Insert #Contratos_Marco select 'CORPBANCA', 76286530, 1, 1514, '20120810'
 Insert #Contratos_Marco select 'CORPBANCA', 76296120, 1, 1446, '20120604'
 Insert #Contratos_Marco select 'CORPBANCA', 76296650, 1, 891, '20100915'
 Insert #Contratos_Marco select 'CORPBANCA', 76298280, 1, 701, '20091103'
 Insert #Contratos_Marco select 'CORPBANCA', 76300350, 1, 1205, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 76315010, 1, 1525, '20120326'
 Insert #Contratos_Marco select 'CORPBANCA', 76328440, 1, 406, '20080707'
 Insert #Contratos_Marco select 'CORPBANCA', 76328440, 1, 914, '20101008'
 Insert #Contratos_Marco select 'CORPBANCA', 76329090, 1, 846, '20100727'
 Insert #Contratos_Marco select 'CORPBANCA', 76343170, 1, 1134, '20110621'
 Insert #Contratos_Marco select 'CORPBANCA', 76345310, 1, 1174, '20110530'
 Insert #Contratos_Marco select 'CORPBANCA', 76369480, 1, 436, '20080820'
 Insert #Contratos_Marco select 'CORPBANCA', 76375230, 1, 729, '20100209'
 Insert #Contratos_Marco select 'CORPBANCA', 76375230, 1, 893, '20100826'
 Insert #Contratos_Marco select 'CORPBANCA', 76384550, 1, 658, '20090924'
 Insert #Contratos_Marco select 'CORPBANCA', 76406120, 1, 472, '20081022'
 Insert #Contratos_Marco select 'CORPBANCA', 76406630, 1, 1337, '20111226'
 Insert #Contratos_Marco select 'CORPBANCA', 76407810, 1, 1463, '20120529'
 Insert #Contratos_Marco select 'CORPBANCA', 76409560, 1, 444, '20080910'
 Insert #Contratos_Marco select 'CORPBANCA', 76410610, 1, 342, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 76413010, 1, 420, '20080807'
 Insert #Contratos_Marco select 'CORPBANCA', 76413810, 1, 1336, '20110920'
 Insert #Contratos_Marco select 'CORPBANCA', 76415340, 1, 764, '20100422'
 Insert #Contratos_Marco select 'CORPBANCA', 76435570, 1, 367, '20080513'
 Insert #Contratos_Marco select 'CORPBANCA', 76450680, 1, 1041, '20110322'
 Insert #Contratos_Marco select 'CORPBANCA', 76451860, 1, 1299, '20111114'
 Insert #Contratos_Marco select 'CORPBANCA', 76464760, 1, 1137, '20110620'
 Insert #Contratos_Marco select 'CORPBANCA', 76468720, 1, 646, '20090930'
 Insert #Contratos_Marco select 'CORPBANCA', 76489940, 1, 1004, '20110127'
 Insert #Contratos_Marco select 'CORPBANCA', 76492080, 1, 1057, '20110328'
 Insert #Contratos_Marco select 'CORPBANCA', 76502210, 1, 1087, '20110415'
 Insert #Contratos_Marco select 'CORPBANCA', 76502800, 1, 1250, '20111005'
 Insert #Contratos_Marco select 'CORPBANCA', 76511040, 1, 353, '20060901'
 Insert #Contratos_Marco select 'CORPBANCA', 76511040, 1, 1062, '20110316'
 Insert #Contratos_Marco select 'CORPBANCA', 76512060, 1, 372, '20080529'
 Insert #Contratos_Marco select 'CORPBANCA', 76517510, 1, 1006, '20110204'
 Insert #Contratos_Marco select 'CORPBANCA', 76518340, 1, 1455, '20120606'
 Insert #Contratos_Marco select 'CORPBANCA', 76518910, 1, 926, '20101027'
 Insert #Contratos_Marco select 'CORPBANCA', 76528620, 1, 789, '20100427'
 Insert #Contratos_Marco select 'CORPBANCA', 76531110, 1, 471, '20081024'
 Insert #Contratos_Marco select 'CORPBANCA', 76531110, 1, 1239, '20110930'
 Insert #Contratos_Marco select 'CORPBANCA', 76540320, 1, 1091, '20110418'
 Insert #Contratos_Marco select 'CORPBANCA', 76541630, 1, 659, '20091014'
 Insert #Contratos_Marco select 'CORPBANCA', 76541630, 1, 1101, '20110503'
 Insert #Contratos_Marco select 'CORPBANCA', 76543990, 1, 1258, '20111011'
 Insert #Contratos_Marco select 'CORPBANCA', 76555400, 1, 595, '20090529'
 Insert #Contratos_Marco select 'CORPBANCA', 76556010, 1, 1521, '20120905'
 Insert #Contratos_Marco select 'CORPBANCA', 76572870, 1, 1542, '20120926'
 Insert #Contratos_Marco select 'CORPBANCA', 76575610, 1, 629, '20090826'
 Insert #Contratos_Marco select 'CORPBANCA', 76575610, 1, 780, '20100511'
 Insert #Contratos_Marco select 'CORPBANCA', 76580770, 1, 860, '20100818'
 Insert #Contratos_Marco select 'CORPBANCA', 76582820, 1, 1328, '20110726'
 Insert #Contratos_Marco select 'CORPBANCA', 76620230, 1, 793, '20100526'
 Insert #Contratos_Marco select 'CORPBANCA', 76622320, 1, 1218, '20110907'
 Insert #Contratos_Marco select 'CORPBANCA', 76622700, 1, 1517, '20120607'
 Insert #Contratos_Marco select 'CORPBANCA', 76624380, 1, 805, '20100616'
 Insert #Contratos_Marco select 'CORPBANCA', 76637140, 1, 1008, '20110210'
 Insert #Contratos_Marco select 'CORPBANCA', 76642780, 1, 1338, '20111121'
 Insert #Contratos_Marco select 'CORPBANCA', 76643630, 1, 588, '20090608'
 Insert #Contratos_Marco select 'CORPBANCA', 76645030, 1, 251, '20061201'
 Insert #Contratos_Marco select 'CORPBANCA', 76648060, 1, 954, '20101129'
 Insert #Contratos_Marco select 'CORPBANCA', 76649080, 1, 319, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 76649080, 1, 678, '20090821'
 Insert #Contratos_Marco select 'CORPBANCA', 76650600, 1, 1169, '20110816'
 Insert #Contratos_Marco select 'CORPBANCA', 76661640, 1, 672, '20091028'
 Insert #Contratos_Marco select 'CORPBANCA', 76669630, 1, 355, '20080416'
 Insert #Contratos_Marco select 'CORPBANCA', 76669630, 1, 1421, '20120503'
 Insert #Contratos_Marco select 'CORPBANCA', 76669820, 1, 1198, '20110902'
 Insert #Contratos_Marco select 'CORPBANCA', 76671940, 1, 1350, '20120119'
 Insert #Contratos_Marco select 'CORPBANCA', 76692840, 1, 339, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 76701910, 1, 906, '20101006'
 Insert #Contratos_Marco select 'CORPBANCA', 76720020, 1, 1010, '20110119'
 Insert #Contratos_Marco select 'CORPBANCA', 76733460, 1, 1561, '20121025'
 Insert #Contratos_Marco select 'CORPBANCA', 76738040, 1, 1020, '20110210'
 Insert #Contratos_Marco select 'CORPBANCA', 76750520, 1, 545, '20090304'
 Insert #Contratos_Marco select 'CORPBANCA', 76758790, 1, 858, '20100616'
 Insert #Contratos_Marco select 'CORPBANCA', 76762250, 1, 809, '20100630'
 Insert #Contratos_Marco select 'CORPBANCA', 76763620, 1, 829, '20100630'
 Insert #Contratos_Marco select 'CORPBANCA', 76764020, 1, 1368, '20120118'
 Insert #Contratos_Marco select 'CORPBANCA', 76765830, 1, 1195, '20110909'
 Insert #Contratos_Marco select 'CORPBANCA', 76772160, 1, 1096, '20110407'
 Insert #Contratos_Marco select 'CORPBANCA', 76800470, 1, 1071, '20110127'
 Insert #Contratos_Marco select 'CORPBANCA', 76804590, 1, 1555, '20120614'
 Insert #Contratos_Marco select 'CORPBANCA', 76806870, 1, 1392, '20120127'
 Insert #Contratos_Marco select 'CORPBANCA', 76811980, 1, 620, '20090812'
 Insert #Contratos_Marco select 'CORPBANCA', 76811980, 1, 1501, '20120330'
 Insert #Contratos_Marco select 'CORPBANCA', 76814110, 1, 639, '20090804'
 Insert #Contratos_Marco select 'CORPBANCA', 76814110, 1, 1240, '20111003'
 Insert #Contratos_Marco select 'CORPBANCA', 76839940, 1, 1077, '20110415'
 Insert #Contratos_Marco select 'CORPBANCA', 76840440, 1, 722, '20100119'
 Insert #Contratos_Marco select 'CORPBANCA', 76860310, 1, 723, '20100127'
 Insert #Contratos_Marco select 'CORPBANCA', 76860310, 1, 806, '20100610'
 Insert #Contratos_Marco select 'CORPBANCA', 76861930, 1, 474, '20081024'
 Insert #Contratos_Marco select 'CORPBANCA', 76861930, 1, 1229, '20110926'
 Insert #Contratos_Marco select 'CORPBANCA', 76864300, 1, 1234, '20110929'
 Insert #Contratos_Marco select 'CORPBANCA', 76900860, 1, 486, '20081027'
 Insert #Contratos_Marco select 'CORPBANCA', 76907640, 1, 1065, '20110324'
 Insert #Contratos_Marco select 'CORPBANCA', 76908230, 1, 1081, '20110418'
 Insert #Contratos_Marco select 'CORPBANCA', 76915320, 1, 976, '20101221'
 Insert #Contratos_Marco select 'CORPBANCA', 76924610, 1, 886, '20100902'
 Insert #Contratos_Marco select 'CORPBANCA', 76926660, 1, 1121, '20110530'
 Insert #Contratos_Marco select 'CORPBANCA', 76936670, 1, 1469, '20120627'
 Insert #Contratos_Marco select 'CORPBANCA', 76940970, 1, 698, '20091130'
 Insert #Contratos_Marco select 'CORPBANCA', 76940970, 1, 1432, '20120516'
 Insert #Contratos_Marco select 'CORPBANCA', 76942340, 1, 1398, '20120320'
 Insert #Contratos_Marco select 'CORPBANCA', 76943080, 1, 1400, '20120321'
 Insert #Contratos_Marco select 'CORPBANCA', 76960990, 1, 692, '20091119'
 Insert #Contratos_Marco select 'CORPBANCA', 76976580, 1, 371, '20080528'
 Insert #Contratos_Marco select 'CORPBANCA', 76979390, 1, 871, '20100820'
 Insert #Contratos_Marco select 'CORPBANCA', 76981330, 1, 605, '20090612'
 Insert #Contratos_Marco select 'CORPBANCA', 77003680, 1, 1556, '20121010'
 Insert #Contratos_Marco select 'CORPBANCA', 77025790, 1, 1494, '20120726'
 Insert #Contratos_Marco select 'CORPBANCA', 77038620, 1, 527, '20090120'
 Insert #Contratos_Marco select 'CORPBANCA', 77038620, 1, 1151, '20110726'
 Insert #Contratos_Marco select 'CORPBANCA', 77044200, 1, 413, '20080731'
 Insert #Contratos_Marco select 'CORPBANCA', 77044550, 1, 156, '20031104'
 Insert #Contratos_Marco select 'CORPBANCA', 77069310, 1, 647, '20090921'
 Insert #Contratos_Marco select 'CORPBANCA', 77069390, 1, 1139, '20110624'
 Insert #Contratos_Marco select 'CORPBANCA', 77073090, 1, 923, '20100924'
 Insert #Contratos_Marco select 'CORPBANCA', 77082030, 1, 422, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 77086090, 1, 933, '20101105'
 Insert #Contratos_Marco select 'CORPBANCA', 77089730, 1, 233, '20060714'
 Insert #Contratos_Marco select 'CORPBANCA', 77089730, 1, 1214, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 77105560, 1, 882, '20100820'
 Insert #Contratos_Marco select 'CORPBANCA', 77105560, 1, 1452, '20120607'
 Insert #Contratos_Marco select 'CORPBANCA', 77137860, 1, 606, '20090710'
 Insert #Contratos_Marco select 'CORPBANCA', 77137860, 1, 1105, '20110421'
 Insert #Contratos_Marco select 'CORPBANCA', 77144630, 1, 1526, '20120427'
 Insert #Contratos_Marco select 'CORPBANCA', 77148300, 1, 1466, '20120612'
 Insert #Contratos_Marco select 'CORPBANCA', 77157050, 1, 1562, '20121107'
 Insert #Contratos_Marco select 'CORPBANCA', 77187170, 1, 1372, '20120123'
 Insert #Contratos_Marco select 'CORPBANCA', 77187730, 1, 1363, '20120126'
 Insert #Contratos_Marco select 'CORPBANCA', 77188140, 1, 294, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 77210950, 1, 663, '20091008'
 Insert #Contratos_Marco select 'CORPBANCA', 77210950, 1, 1257, '20111012'
 Insert #Contratos_Marco select 'CORPBANCA', 77213440, 1, 702, '20091104'
 Insert #Contratos_Marco select 'CORPBANCA', 77214760, 1, 1315, '20111123'
 Insert #Contratos_Marco select 'CORPBANCA', 77221110, 1, 640, '20090908'
 Insert #Contratos_Marco select 'CORPBANCA', 77237660, 1, 438, '20080707'
 Insert #Contratos_Marco select 'CORPBANCA', 77237660, 1, 941, '20101117'
 Insert #Contratos_Marco select 'CORPBANCA', 77248660, 1, 1300, '20111116'
 Insert #Contratos_Marco select 'CORPBANCA', 77252090, 1, 784, '20100507'
 Insert #Contratos_Marco select 'CORPBANCA', 77253260, 1, 681, '20091106'
 Insert #Contratos_Marco select 'CORPBANCA', 77253260, 1, 1323, '20110427'
 Insert #Contratos_Marco select 'CORPBANCA', 77260210, 1, 889, '20100913'
 Insert #Contratos_Marco select 'CORPBANCA', 77261280, 1, 477, '20081028'
 Insert #Contratos_Marco select 'CORPBANCA', 77261280, 1, 925, '20100930'
 Insert #Contratos_Marco select 'CORPBANCA', 77273890, 1, 97, '20011010'
 Insert #Contratos_Marco select 'CORPBANCA', 77280690, 1, 264, '20071022'
 Insert #Contratos_Marco select 'CORPBANCA', 77280690, 1, 1015, '20101004'
 Insert #Contratos_Marco select 'CORPBANCA', 77285220, 1, 1265, '20111027'
 Insert #Contratos_Marco select 'CORPBANCA', 77287160, 1, 810, '20100616'
 Insert #Contratos_Marco select 'CORPBANCA', 77304990, 1, 518, '20090112'
 Insert #Contratos_Marco select 'CORPBANCA', 77304990, 1, 1051, '20110317'
 Insert #Contratos_Marco select 'CORPBANCA', 77307410, 1, 423, '20070926'
 Insert #Contratos_Marco select 'CORPBANCA', 77307790, 1, 1492, '20120724'
 Insert #Contratos_Marco select 'CORPBANCA', 77348300, 1, 662, '20090513'
 Insert #Contratos_Marco select 'CORPBANCA', 77364570, 1, 748, '20100324'
 Insert #Contratos_Marco select 'CORPBANCA', 77366510, 1, 1447, '20120426'
 Insert #Contratos_Marco select 'CORPBANCA', 77372340, 1, 1553, '20121024'
 Insert #Contratos_Marco select 'CORPBANCA', 77380060, 1, 536, '20090213'
 Insert #Contratos_Marco select 'CORPBANCA', 77383970, 1, 1522, '20120904'
 Insert #Contratos_Marco select 'CORPBANCA', 77385680, 1, 754, '20100408'
 Insert #Contratos_Marco select 'CORPBANCA', 77399590, 1, 1211, '20110921'
 Insert #Contratos_Marco select 'CORPBANCA', 77400890, 1, 935, '20101111'
 Insert #Contratos_Marco select 'CORPBANCA', 77413150, 1, 970, '20101217'
 Insert #Contratos_Marco select 'CORPBANCA', 77417700, 1, 828, '20100526'
 Insert #Contratos_Marco select 'CORPBANCA', 77418140, 1, 656, '20091008'
 Insert #Contratos_Marco select 'CORPBANCA', 77440310, 1, 739, '20091201'
 Insert #Contratos_Marco select 'CORPBANCA', 77443720, 1, 798, '20100527'
 Insert #Contratos_Marco select 'CORPBANCA', 77448270, 1, 186, '20050113'
 Insert #Contratos_Marco select 'CORPBANCA', 77448270, 1, 596, '20090701'
 Insert #Contratos_Marco select 'CORPBANCA', 77454060, 1, 898, '20100921'
 Insert #Contratos_Marco select 'CORPBANCA', 77456870, 1, 565, '20090422'
 Insert #Contratos_Marco select 'CORPBANCA', 77460880, 1, 1467, '20120627'
 Insert #Contratos_Marco select 'CORPBANCA', 77469270, 1, 154, '20030527'
 Insert #Contratos_Marco select 'CORPBANCA', 77484310, 1, 1246, '20111003'
 Insert #Contratos_Marco select 'CORPBANCA', 77504470, 1, 1136, '20110620'
 Insert #Contratos_Marco select 'CORPBANCA', 77516610, 1, 305, '20070906'
 Insert #Contratos_Marco select 'CORPBANCA', 77516610, 1, 1550, '20120528'
 Insert #Contratos_Marco select 'CORPBANCA', 77522330, 1, 1396, '20120216'
 Insert #Contratos_Marco select 'CORPBANCA', 77533490, 1, 1208, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 77534620, 1, 1069, '20110318'
 Insert #Contratos_Marco select 'CORPBANCA', 77565640, 1, 815, '20100622'
 Insert #Contratos_Marco select 'CORPBANCA', 77590080, 1, 1233, '20110929'
 Insert #Contratos_Marco select 'CORPBANCA', 77590210, 1, 745, '20100322'
 Insert #Contratos_Marco select 'CORPBANCA', 77591550, 1, 521, '20090121'
 Insert #Contratos_Marco select 'CORPBANCA', 77604560, 1, 558, '20090409'
 Insert #Contratos_Marco select 'CORPBANCA', 77607310, 1, 1038, '19000102'
 Insert #Contratos_Marco select 'CORPBANCA', 77607310, 1, 428, '20080819'
 Insert #Contratos_Marco select 'CORPBANCA', 77611340, 1, 880, '20100824'
 Insert #Contratos_Marco select 'CORPBANCA', 77611930, 1, 824, '20100615'
 Insert #Contratos_Marco select 'CORPBANCA', 77618380, 1, 453, '20080806'
 Insert #Contratos_Marco select 'CORPBANCA', 77618920, 1, 98, '20011017'
 Insert #Contratos_Marco select 'CORPBANCA', 77633630, 1, 1155, '20110808'
 Insert #Contratos_Marco select 'CORPBANCA', 77653550, 1, 726, '20100126'
 Insert #Contratos_Marco select 'CORPBANCA', 77656250, 1, 517, '20090108'
 Insert #Contratos_Marco select 'CORPBANCA', 77656250, 1, 1366, '20120202'
 Insert #Contratos_Marco select 'CORPBANCA', 77662330, 1, 1480, '20120709'
 Insert #Contratos_Marco select 'CORPBANCA', 77662350, 1, 1230, '20110927'
 Insert #Contratos_Marco select 'CORPBANCA', 77676280, 1, 142, '20030320'
 Insert #Contratos_Marco select 'CORPBANCA', 77676280, 1, 1331, '20111124'
 Insert #Contratos_Marco select 'CORPBANCA', 77685730, 1, 1236, '20110930'
 Insert #Contratos_Marco select 'CORPBANCA', 77685880, 1, 1032, '20110308'
 Insert #Contratos_Marco select 'CORPBANCA', 77687700, 1, 508, '20081217'
 Insert #Contratos_Marco select 'CORPBANCA', 77688410, 1, 358, '20080430'
 Insert #Contratos_Marco select 'CORPBANCA', 77703150, 1, 306, '20070906'
 Insert #Contratos_Marco select 'CORPBANCA', 77717900, 1, 879, '20100830'
 Insert #Contratos_Marco select 'CORPBANCA', 77725030, 1, 1307, '20111005'
 Insert #Contratos_Marco select 'CORPBANCA', 77741460, 1, 621, '20090812'
 Insert #Contratos_Marco select 'CORPBANCA', 77753930, 1, 250, '20061227'
 Insert #Contratos_Marco select 'CORPBANCA', 77758740, 1, 1095, '20110429'
 Insert #Contratos_Marco select 'CORPBANCA', 77768110, 1, 1270, '20110916'
 Insert #Contratos_Marco select 'CORPBANCA', 77768990, 1, 1339, '20111220'
 Insert #Contratos_Marco select 'CORPBANCA', 77771220, 1, 1276, '20111107'
 Insert #Contratos_Marco select 'CORPBANCA', 77771980, 1, 1244, '20110916'
 Insert #Contratos_Marco select 'CORPBANCA', 77781350, 1, 847, '20100727'
 Insert #Contratos_Marco select 'CORPBANCA', 77790420, 1, 813, '20100629'
 Insert #Contratos_Marco select 'CORPBANCA', 77805520, 1, 388, '20080516'
 Insert #Contratos_Marco select 'CORPBANCA', 77810380, 1, 749, '20100322'
 Insert #Contratos_Marco select 'CORPBANCA', 77824870, 1, 153, '20030903'
 Insert #Contratos_Marco select 'CORPBANCA', 77825040, 1, 286, '20071109'
 Insert #Contratos_Marco select 'CORPBANCA', 77825040, 1, 1017, '20110216'
 Insert #Contratos_Marco select 'CORPBANCA', 77829700, 1, 1342, '20120109'
 Insert #Contratos_Marco select 'CORPBANCA', 77845570, 1, 1520, '20120621'
 Insert #Contratos_Marco select 'CORPBANCA', 77859490, 1, 1347, '20120118'
 Insert #Contratos_Marco select 'CORPBANCA', 77881020, 1, 480, '20081028'
 Insert #Contratos_Marco select 'CORPBANCA', 77881020, 1, 1157, '20110810'
 Insert #Contratos_Marco select 'CORPBANCA', 77890850, 1, 442, '20080829'
 Insert #Contratos_Marco select 'CORPBANCA', 77890850, 1, 1147, '20101018'
 Insert #Contratos_Marco select 'CORPBANCA', 77894990, 1, 504, '20081104'
 Insert #Contratos_Marco select 'CORPBANCA', 77894990, 1, 994, '20101029'
 Insert #Contratos_Marco select 'CORPBANCA', 77896320, 1, 490, '20081106'
 Insert #Contratos_Marco select 'CORPBANCA', 77896320, 1, 1263, '20111014'
 Insert #Contratos_Marco select 'CORPBANCA', 77903180, 1, 811, '20100618'
 Insert #Contratos_Marco select 'CORPBANCA', 77907100, 1, 1088, '20110330'
 Insert #Contratos_Marco select 'CORPBANCA', 77925610, 1, 1000, '20100119'
 Insert #Contratos_Marco select 'CORPBANCA', 77941990, 1, 1385, '20120217'
 Insert #Contratos_Marco select 'CORPBANCA', 77965620, 1, 1509, '20120807'
 Insert #Contratos_Marco select 'CORPBANCA', 77994770, 1, 956, '20101124'
 Insert #Contratos_Marco select 'CORPBANCA', 77995560, 1, 1264, '20111025'
 Insert #Contratos_Marco select 'CORPBANCA', 77996450, 1, 733, '20100209'
 Insert #Contratos_Marco select 'CORPBANCA', 77996450, 1, 861, '20100817'
 Insert #Contratos_Marco select 'CORPBANCA', 78004470, 1, 602, '20090505'
 Insert #Contratos_Marco select 'CORPBANCA', 78004470, 1, 1324, '20111130'
 Insert #Contratos_Marco select 'CORPBANCA', 78011040, 1, 778, '20100505'
 Insert #Contratos_Marco select 'CORPBANCA', 78023030, 1, 448, '20080520'
 Insert #Contratos_Marco select 'CORPBANCA', 78029510, 1, 1179, '20110406'
 Insert #Contratos_Marco select 'CORPBANCA', 78030690, 1, 752, '20100412'
 Insert #Contratos_Marco select 'CORPBANCA', 78031260, 1, 644, '20090925'
 Insert #Contratos_Marco select 'CORPBANCA', 78032980, 1, 1079, '20110426'
 Insert #Contratos_Marco select 'CORPBANCA', 78034470, 1, 493, '20081107'
 Insert #Contratos_Marco select 'CORPBANCA', 78034470, 1, 1519, '20110110'
 Insert #Contratos_Marco select 'CORPBANCA', 78036610, 1, 1384, '20120216'
 Insert #Contratos_Marco select 'CORPBANCA', 78048910, 1, 1306, '20111123'
 Insert #Contratos_Marco select 'CORPBANCA', 78053410, 1, 1123, '20110606'
 Insert #Contratos_Marco select 'CORPBANCA', 78059370, 1, 969, '20101217'
 Insert #Contratos_Marco select 'CORPBANCA', 78060070, 1, 613, '20090710'
 Insert #Contratos_Marco select 'CORPBANCA', 78063430, 1, 799, '20100526'
 Insert #Contratos_Marco select 'CORPBANCA', 78077260, 1, 557, '20090327'
 Insert #Contratos_Marco select 'CORPBANCA', 78080440, 1, 529, '20090203'
 Insert #Contratos_Marco select 'CORPBANCA', 78080940, 1, 982, '20101228'
 Insert #Contratos_Marco select 'CORPBANCA', 78090210, 1, 56, '19991104'
 Insert #Contratos_Marco select 'CORPBANCA', 78091430, 1, 869, '20100827'
 Insert #Contratos_Marco select 'CORPBANCA', 78096450, 1, 410, '20080728'
 Insert #Contratos_Marco select 'CORPBANCA', 78101430, 1, 482, '20081030'
 Insert #Contratos_Marco select 'CORPBANCA', 78101430, 1, 932, '20101019'
 Insert #Contratos_Marco select 'CORPBANCA', 78103450, 1, 830, '20100701'
 Insert #Contratos_Marco select 'CORPBANCA', 78104050, 1, 541, '20090218'
 Insert #Contratos_Marco select 'CORPBANCA', 78109470, 1, 1199, '20110824'
 Insert #Contratos_Marco select 'CORPBANCA', 78113480, 1, 1166, '20110818'
 Insert #Contratos_Marco select 'CORPBANCA', 78127880, 1, 1187, '20110913'
 Insert #Contratos_Marco select 'CORPBANCA', 78133760, 1, 1546, '20121004'
 Insert #Contratos_Marco select 'CORPBANCA', 78137580, 1, 70, '20000828'
 Insert #Contratos_Marco select 'CORPBANCA', 78137580, 1, 71, '20000828'
 Insert #Contratos_Marco select 'CORPBANCA', 78143730, 1, 1493, '20120427'
 Insert #Contratos_Marco select 'CORPBANCA', 78150200, 1, 1353, '20120106'
 Insert #Contratos_Marco select 'CORPBANCA', 78151120, 1, 519, '20080910'
 Insert #Contratos_Marco select 'CORPBANCA', 78161860, 1, 649, '20090928'
 Insert #Contratos_Marco select 'CORPBANCA', 78180180, 1, 1210, '20110922'
 Insert #Contratos_Marco select 'CORPBANCA', 78180600, 1, 1451, '20120524'
 Insert #Contratos_Marco select 'CORPBANCA', 78184980, 1, 727, '20100129'
 Insert #Contratos_Marco select 'CORPBANCA', 78185710, 1, 1067, '20110406'
 Insert #Contratos_Marco select 'CORPBANCA', 78204700, 1, 934, '20101103'
 Insert #Contratos_Marco select 'CORPBANCA', 78210870, 1, 1094, '20110427'
 Insert #Contratos_Marco select 'CORPBANCA', 78237140, 1, 347, '20080331'
 Insert #Contratos_Marco select 'CORPBANCA', 78241450, 1, 6, '19970313'
 Insert #Contratos_Marco select 'CORPBANCA', 78266060, 1, 1439, '20120528'
 Insert #Contratos_Marco select 'CORPBANCA', 78278530, 1, 1536, '20120924'
 Insert #Contratos_Marco select 'CORPBANCA', 78279030, 1, 1149, '20110630'
 Insert #Contratos_Marco select 'CORPBANCA', 78282060, 1, 478, '20081104'
 Insert #Contratos_Marco select 'CORPBANCA', 78295070, 1, 735, '20100212'
 Insert #Contratos_Marco select 'CORPBANCA', 78304140, 1, 587, '20090604'
 Insert #Contratos_Marco select 'CORPBANCA', 78317440, 1, 1529, '20120904'
 Insert #Contratos_Marco select 'CORPBANCA', 78318290, 1, 738, '20100224'
 Insert #Contratos_Marco select 'CORPBANCA', 78319170, 1, 1407, '20120329'
 Insert #Contratos_Marco select 'CORPBANCA', 78334060, 1, 1408, '20120316'
 Insert #Contratos_Marco select 'CORPBANCA', 78343240, 1, 274, '20071011'
 Insert #Contratos_Marco select 'CORPBANCA', 78353000, 1, 418, '20080728'
 Insert #Contratos_Marco select 'CORPBANCA', 78358290, 1, 1135, '20110628'
 Insert #Contratos_Marco select 'CORPBANCA', 78367940, 1, 505, '20081205'
 Insert #Contratos_Marco select 'CORPBANCA', 78367940, 1, 1217, '20110822'
 Insert #Contratos_Marco select 'CORPBANCA', 78369910, 1, 50, '19990511'
 Insert #Contratos_Marco select 'CORPBANCA', 78369910, 1, 137, '20020813'
 Insert #Contratos_Marco select 'CORPBANCA', 78383620, 1, 284, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 78395470, 1, 744, '20100305'
 Insert #Contratos_Marco select 'CORPBANCA', 78395470, 1, 945, '20100825'
 Insert #Contratos_Marco select 'CORPBANCA', 78412670, 1, 271, '20070927'
 Insert #Contratos_Marco select 'CORPBANCA', 78413000, 1, 1541, '20120926'
 Insert #Contratos_Marco select 'CORPBANCA', 78413660, 1, 1281, '20110511'
 Insert #Contratos_Marco select 'CORPBANCA', 78415390, 1, 1388, '20120227'
 Insert #Contratos_Marco select 'CORPBANCA', 78423770, 1, 468, '20081021'
 Insert #Contratos_Marco select 'CORPBANCA', 78431150, 1, 475, '20081028'
 Insert #Contratos_Marco select 'CORPBANCA', 78431150, 1, 1019, '20110217'
 Insert #Contratos_Marco select 'CORPBANCA', 78433540, 1, 1316, '20111128'
 Insert #Contratos_Marco select 'CORPBANCA', 78445250, 1, 426, '20080813'
 Insert #Contratos_Marco select 'CORPBANCA', 78445250, 1, 1325, '20111202'
 Insert #Contratos_Marco select 'CORPBANCA', 78451170, 1, 1389, '20120228'
 Insert #Contratos_Marco select 'CORPBANCA', 78452650, 1, 60, '19991217'
 Insert #Contratos_Marco select 'CORPBANCA', 78452650, 1, 231, '20060628'
 Insert #Contratos_Marco select 'CORPBANCA', 78472260, 1, 593, '20090618'
 Insert #Contratos_Marco select 'CORPBANCA', 78474810, 1, 837, '20100707'
 Insert #Contratos_Marco select 'CORPBANCA', 78481500, 1, 774, '20100430'
 Insert #Contratos_Marco select 'CORPBANCA', 78485890, 1, 1170, '20110727'
 Insert #Contratos_Marco select 'CORPBANCA', 78489380, 1, 343, '20080324'
 Insert #Contratos_Marco select 'CORPBANCA', 78489380, 1, 1260, '20111011'
 Insert #Contratos_Marco select 'CORPBANCA', 78503400, 1, 1193, '20110628'
 Insert #Contratos_Marco select 'CORPBANCA', 78519120, 1, 299, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 78526430, 1, 1415, '20120313'
 Insert #Contratos_Marco select 'CORPBANCA', 78527210, 1, 730, '20100210'
 Insert #Contratos_Marco select 'CORPBANCA', 78531360, 1, 603, '20090709'
 Insert #Contratos_Marco select 'CORPBANCA', 78531360, 1, 1184, '20110906'
 Insert #Contratos_Marco select 'CORPBANCA', 78544420, 1, 912, '20100929'
 Insert #Contratos_Marco select 'CORPBANCA', 78554660, 1, 890, '20100730'
 Insert #Contratos_Marco select 'CORPBANCA', 78558990, 1, 1120, '20110524'
 Insert #Contratos_Marco select 'CORPBANCA', 78562090, 1, 1037, '20110315'
 Insert #Contratos_Marco select 'CORPBANCA', 78575020, 1, 1215, '20110915'
 Insert #Contratos_Marco select 'CORPBANCA', 78591370, 1, 1131, '20110615'
 Insert #Contratos_Marco select 'CORPBANCA', 78595410, 1, 84, '20010605'
 Insert #Contratos_Marco select 'CORPBANCA', 78600780, 1, 369, '20080520'
 Insert #Contratos_Marco select 'CORPBANCA', 78600780, 1, 1204, '20110606'
 Insert #Contratos_Marco select 'CORPBANCA', 78623410, 1, 539, '20081229'
 Insert #Contratos_Marco select 'CORPBANCA', 78623410, 1, 1427, '20120516'
 Insert #Contratos_Marco select 'CORPBANCA', 78630980, 1, 403, '20080708'
 Insert #Contratos_Marco select 'CORPBANCA', 78644960, 1, 724, '20100128'
 Insert #Contratos_Marco select 'CORPBANCA', 78646900, 1, 462, '20080923'
 Insert #Contratos_Marco select 'CORPBANCA', 78647530, 1, 285, '20071025'
 Insert #Contratos_Marco select 'CORPBANCA', 78710270, 1, 800, '20100601'
 Insert #Contratos_Marco select 'CORPBANCA', 78714200, 1, 1382, '20120207'
 Insert #Contratos_Marco select 'CORPBANCA', 78745150, 1, 543, '20090205'
 Insert #Contratos_Marco select 'CORPBANCA', 78759700, 1, 1386, '20120125'
 Insert #Contratos_Marco select 'CORPBANCA', 78789130, 1, 615, '20090717'
 Insert #Contratos_Marco select 'CORPBANCA', 78789130, 1, 868, '20100819'
 Insert #Contratos_Marco select 'CORPBANCA', 78794780, 1, 1497, '20120723'
 Insert #Contratos_Marco select 'CORPBANCA', 78795760, 1, 1082, '20110106'
 Insert #Contratos_Marco select 'CORPBANCA', 78802620, 1, 27, '19980318'
 Insert #Contratos_Marco select 'CORPBANCA', 78806090, 1, 857, '20100812'
 Insert #Contratos_Marco select 'CORPBANCA', 78809700, 1, 1243, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 78816930, 1, 1072, '20110406'
 Insert #Contratos_Marco select 'CORPBANCA', 78823000, 1, 443, '20080908'
 Insert #Contratos_Marco select 'CORPBANCA', 78841810, 1, 461, '20080811'
 Insert #Contratos_Marco select 'CORPBANCA', 78841810, 1, 913, '20100817'
 Insert #Contratos_Marco select 'CORPBANCA', 78848870, 1, 900, '20100910'
 Insert #Contratos_Marco select 'CORPBANCA', 78852480, 1, 1558, '20121025'
 Insert #Contratos_Marco select 'CORPBANCA', 78885200, 1, 1422, '20120321'
 Insert #Contratos_Marco select 'CORPBANCA', 78893770, 1, 1047, '20101124'
 Insert #Contratos_Marco select 'CORPBANCA', 78901250, 1, 335, '20080204'
 Insert #Contratos_Marco select 'CORPBANCA', 78901250, 1, 1472, '20110318'
 Insert #Contratos_Marco select 'CORPBANCA', 78913470, 1, 611, '20090709'
 Insert #Contratos_Marco select 'CORPBANCA', 78916260, 1, 515, '20081229'
 Insert #Contratos_Marco select 'CORPBANCA', 78916260, 1, 1040, '20101125'
 Insert #Contratos_Marco select 'CORPBANCA', 78919170, 1, 195, '20050704'
 Insert #Contratos_Marco select 'CORPBANCA', 78919170, 1, 664, '20090922'
 Insert #Contratos_Marco select 'CORPBANCA', 78919170, 1, 1510, '20120713'
 Insert #Contratos_Marco select 'CORPBANCA', 78924030, 1, 484, '20081029'
 Insert #Contratos_Marco select 'CORPBANCA', 78924030, 1, 1140, '20110606'
 Insert #Contratos_Marco select 'CORPBANCA', 78932000, 1, 677, '20090804'
 Insert #Contratos_Marco select 'CORPBANCA', 78951450, 1, 567, '20090428'
 Insert #Contratos_Marco select 'CORPBANCA', 78952330, 1, 610, '20090709'
 Insert #Contratos_Marco select 'CORPBANCA', 78956240, 1, 1391, '20120224'
 Insert #Contratos_Marco select 'CORPBANCA', 78966540, 1, 804, '20100119'
 Insert #Contratos_Marco select 'CORPBANCA', 78966540, 1, 1259, '20111020'
 Insert #Contratos_Marco select 'CORPBANCA', 78972790, 1, 433, '20080901'
 Insert #Contratos_Marco select 'CORPBANCA', 78980730, 1, 1554, '20121029'
 Insert #Contratos_Marco select 'CORPBANCA', 78996340, 1, 1109, '20110509'
 Insert #Contratos_Marco select 'CORPBANCA', 78997060, 1, 53, '19990930'
 Insert #Contratos_Marco select 'CORPBANCA', 79500360, 1, 938, '20101110'
 Insert #Contratos_Marco select 'CORPBANCA', 79501590, 1, 1022, '20110119'
 Insert #Contratos_Marco select 'CORPBANCA', 79507160, 1, 30, '19980615'
 Insert #Contratos_Marco select 'CORPBANCA', 79513550, 1, 469, '20081013'
 Insert #Contratos_Marco select 'CORPBANCA', 79517210, 1, 1534, '20120921'
 Insert #Contratos_Marco select 'CORPBANCA', 79529940, 1, 497, '20081106'
 Insert #Contratos_Marco select 'CORPBANCA', 79529940, 1, 873, '20100824'
 Insert #Contratos_Marco select 'CORPBANCA', 79531550, 1, 143, '20030325'
 Insert #Contratos_Marco select 'CORPBANCA', 79535410, 1, 694, '20091117'
 Insert #Contratos_Marco select 'CORPBANCA', 79552690, 1, 1098, '20110429'
 Insert #Contratos_Marco select 'CORPBANCA', 79552710, 1, 315, '20070906'
 Insert #Contratos_Marco select 'CORPBANCA', 79553100, 1, 1498, '20120727'
 Insert #Contratos_Marco select 'CORPBANCA', 79559220, 1, 74, '20000922'
 Insert #Contratos_Marco select 'CORPBANCA', 79569020, 1, 530, '20090126'
 Insert #Contratos_Marco select 'CORPBANCA', 79580800, 1, 312, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 79580800, 1, 944, '20101115'
 Insert #Contratos_Marco select 'CORPBANCA', 79582220, 1, 514, '20081120'
 Insert #Contratos_Marco select 'CORPBANCA', 79584340, 1, 105, '20020410'
 Insert #Contratos_Marco select 'CORPBANCA', 79592940, 1, 430, '20080728'
 Insert #Contratos_Marco select 'CORPBANCA', 79599130, 1, 1045, '20110321'
 Insert #Contratos_Marco select 'CORPBANCA', 79602650, 1, 670, '20091023'
 Insert #Contratos_Marco select 'CORPBANCA', 79606430, 1, 1285, '20111109'
 Insert #Contratos_Marco select 'CORPBANCA', 79613070, 1, 1085, '20110502'
 Insert #Contratos_Marco select 'CORPBANCA', 79619200, 1, 573, '20090330'
 Insert #Contratos_Marco select 'CORPBANCA', 79619200, 1, 1058, '20110301'
 Insert #Contratos_Marco select 'CORPBANCA', 79620090, 1, 320, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 79625830, 1, 973, '20101126'
 Insert #Contratos_Marco select 'CORPBANCA', 79634430, 1, 282, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 79634430, 1, 947, '20101119'
 Insert #Contratos_Marco select 'CORPBANCA', 79649140, 1, 526, '20090113'
 Insert #Contratos_Marco select 'CORPBANCA', 79650240, 1, 479, '20081028'
 Insert #Contratos_Marco select 'CORPBANCA', 79650240, 1, 989, '20110104'
 Insert #Contratos_Marco select 'CORPBANCA', 79650870, 1, 254, '20070402'
 Insert #Contratos_Marco select 'CORPBANCA', 79650870, 1, 874, '20100824'
 Insert #Contratos_Marco select 'CORPBANCA', 79651900, 1, 141, '20030311'
 Insert #Contratos_Marco select 'CORPBANCA', 79653710, 1, 1431, '20120515'
 Insert #Contratos_Marco select 'CORPBANCA', 79657820, 1, 196, '20050819'
 Insert #Contratos_Marco select 'CORPBANCA', 79660760, 1, 770, '20100419'
 Insert #Contratos_Marco select 'CORPBANCA', 79663940, 1, 965, '20101214'
 Insert #Contratos_Marco select 'CORPBANCA', 79675380, 1, 386, '20080617'
 Insert #Contratos_Marco select 'CORPBANCA', 79676760, 1, 742, '20100315'
 Insert #Contratos_Marco select 'CORPBANCA', 79689080, 1, 575, '20090512'
 Insert #Contratos_Marco select 'CORPBANCA', 79690510, 1, 1394, '20120110'
 Insert #Contratos_Marco select 'CORPBANCA', 79694980, 1, 161, '20040205'
 Insert #Contratos_Marco select 'CORPBANCA', 79696000, 1, 728, '20100118'
 Insert #Contratos_Marco select 'CORPBANCA', 79697670, 1, 378, '20080604'
 Insert #Contratos_Marco select 'CORPBANCA', 79697820, 1, 1321, '20110929'
 Insert #Contratos_Marco select 'CORPBANCA', 79698650, 1, 1002, '20101217'
 Insert #Contratos_Marco select 'CORPBANCA', 79700560, 1, 740, '20100223'
 Insert #Contratos_Marco select 'CORPBANCA', 79700660, 1, 252, '20070122'
 Insert #Contratos_Marco select 'CORPBANCA', 79700660, 1, 592, '20090623'
 Insert #Contratos_Marco select 'CORPBANCA', 79700660, 1, 1326, '20111212'
 Insert #Contratos_Marco select 'CORPBANCA', 79701620, 1, 253, '20070226'
 Insert #Contratos_Marco select 'CORPBANCA', 79703410, 1, 540, '20090217'
 Insert #Contratos_Marco select 'CORPBANCA', 79711520, 1, 1346, '20120113'
 Insert #Contratos_Marco select 'CORPBANCA', 79724060, 1, 1531, '20120911'
 Insert #Contratos_Marco select 'CORPBANCA', 79744960, 1, 1312, '20111125'
 Insert #Contratos_Marco select 'CORPBANCA', 79751060, 1, 123, '20021024'
 Insert #Contratos_Marco select 'CORPBANCA', 79751060, 1, 1064, '20110104'
 Insert #Contratos_Marco select 'CORPBANCA', 79753500, 1, 612, '20090709'
 Insert #Contratos_Marco select 'CORPBANCA', 79757840, 1, 23, '19980107'
 Insert #Contratos_Marco select 'CORPBANCA', 79768170, 1, 202, '20051004'
 Insert #Contratos_Marco select 'CORPBANCA', 79768410, 1, 210, '20051221'
 Insert #Contratos_Marco select 'CORPBANCA', 79786190, 1, 1089, '20110106'
 Insert #Contratos_Marco select 'CORPBANCA', 79794230, 1, 273, '20071011'
 Insert #Contratos_Marco select 'CORPBANCA', 79794230, 1, 958, '20101006'
 Insert #Contratos_Marco select 'CORPBANCA', 79802770, 1, 324, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 79802770, 1, 964, '20101206'
 Insert #Contratos_Marco select 'CORPBANCA', 79807230, 1, 1011, '20110214'
 Insert #Contratos_Marco select 'CORPBANCA', 79814740, 1, 329, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 79822680, 1, 990, '20110107'
 Insert #Contratos_Marco select 'CORPBANCA', 79827490, 1, 1178, '20110802'
 Insert #Contratos_Marco select 'CORPBANCA', 79831090, 1, 711, '20091218'
 Insert #Contratos_Marco select 'CORPBANCA', 79831090, 1, 1117, '20100824'
 Insert #Contratos_Marco select 'CORPBANCA', 79837470, 1, 960, '20101027'
 Insert #Contratos_Marco select 'CORPBANCA', 79848630, 1, 563, '20090205'
 Insert #Contratos_Marco select 'CORPBANCA', 79868770, 1, 1449, '20120502'
 Insert #Contratos_Marco select 'CORPBANCA', 79871330, 1, 1076, '20110404'
 Insert #Contratos_Marco select 'CORPBANCA', 79872420, 1, 1461, '20120430'
 Insert #Contratos_Marco select 'CORPBANCA', 79872770, 1, 234, '20060815'
 Insert #Contratos_Marco select 'CORPBANCA', 79879480, 1, 1457, '20120620'
 Insert #Contratos_Marco select 'CORPBANCA', 79880990, 1, 1231, '20110929'
 Insert #Contratos_Marco select 'CORPBANCA', 79883210, 1, 220, '20060131'
 Insert #Contratos_Marco select 'CORPBANCA', 79891160, 1, 365, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 79895330, 1, 653, '20091006'
 Insert #Contratos_Marco select 'CORPBANCA', 79910250, 1, 673, '20091028'
 Insert #Contratos_Marco select 'CORPBANCA', 79913540, 1, 1251, '20111005'
 Insert #Contratos_Marco select 'CORPBANCA', 79917690, 1, 500, '20081107'
 Insert #Contratos_Marco select 'CORPBANCA', 79917690, 1, 1252, '20111007'
 Insert #Contratos_Marco select 'CORPBANCA', 79933330, 1, 368, '20080520'
 Insert #Contratos_Marco select 'CORPBANCA', 79950630, 1, 15, '19970827'
 Insert #Contratos_Marco select 'CORPBANCA', 79961970, 1, 1102, '20110502'
 Insert #Contratos_Marco select 'CORPBANCA', 79962380, 1, 64, '20000114'
 Insert #Contratos_Marco select 'CORPBANCA', 79962720, 1, 1511, '20120324'
 Insert #Contratos_Marco select 'CORPBANCA', 79972700, 1, 1256, '20110928'
 Insert #Contratos_Marco select 'CORPBANCA', 79982490, 1, 1354, '20120103'
 Insert #Contratos_Marco select 'CORPBANCA', 79984240, 1, 241, '20060922'
 Insert #Contratos_Marco select 'CORPBANCA', 79988520, 1, 1042, '20110316'
 Insert #Contratos_Marco select 'CORPBANCA', 79991280, 1, 1329, '20111206'
 Insert #Contratos_Marco select 'CORPBANCA', 79991430, 1, 1535, '20120920'
 Insert #Contratos_Marco select 'CORPBANCA', 79994160, 1, 1377, '20120123'
 Insert #Contratos_Marco select 'CORPBANCA', 79994190, 1, 193, '20050525'
 Insert #Contratos_Marco select 'CORPBANCA', 80004800, 1, 888, '20100924'
 Insert #Contratos_Marco select 'CORPBANCA', 80186300, 1, 218, '20060210'
 Insert #Contratos_Marco select 'CORPBANCA', 80498800, 1, 63, '19991230'
 Insert #Contratos_Marco select 'CORPBANCA', 80537000, 1, 326, '20080212'
 Insert #Contratos_Marco select 'CORPBANCA', 80538300, 1, 1160, '20110803'
 Insert #Contratos_Marco select 'CORPBANCA', 80678000, 1, 560, '20090327'
 Insert #Contratos_Marco select 'CORPBANCA', 80706200, 1, 1448, '20120604'
 Insert #Contratos_Marco select 'CORPBANCA', 80830500, 1, 584, '20090513'
 Insert #Contratos_Marco select 'CORPBANCA', 80830500, 1, 968, '20101029'
 Insert #Contratos_Marco select 'CORPBANCA', 80860400, 1, 1433, '20120413'
 Insert #Contratos_Marco select 'CORPBANCA', 80893200, 1, 1405, '20120221'
 Insert #Contratos_Marco select 'CORPBANCA', 80909400, 1, 173, '20040830'
 Insert #Contratos_Marco select 'CORPBANCA', 80909400, 1, 930, '20101028'
 Insert #Contratos_Marco select 'CORPBANCA', 80909400, 1, 1173, '20110825'
 Insert #Contratos_Marco select 'CORPBANCA', 80932900, 1, 549, '20090312'
 Insert #Contratos_Marco select 'CORPBANCA', 80932900, 1, 892, '20100824'
 Insert #Contratos_Marco select 'CORPBANCA', 80955900, 1, 863, '20100811'
 Insert #Contratos_Marco select 'CORPBANCA', 80975200, 1, 281, '20070906'
 Insert #Contratos_Marco select 'CORPBANCA', 81018000, 1, 104, '20020117'
 Insert #Contratos_Marco select 'CORPBANCA', 81018000, 1, 928, '20101021'
 Insert #Contratos_Marco select 'CORPBANCA', 81062300, 1, 1397, '20120330'
 Insert #Contratos_Marco select 'CORPBANCA', 81105000, 1, 333, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 81140300, 1, 616, '20090714'
 Insert #Contratos_Marco select 'CORPBANCA', 81148200, 1, 318, '20080131'
 Insert #Contratos_Marco select 'CORPBANCA', 81161500, 1, 812, '20100617'
 Insert #Contratos_Marco select 'CORPBANCA', 81198400, 1, 550, '20090304'
 Insert #Contratos_Marco select 'CORPBANCA', 81201000, 1, 126, '20021107'
 Insert #Contratos_Marco select 'CORPBANCA', 81217800, 1, 491, '20081110'
 Insert #Contratos_Marco select 'CORPBANCA', 81290800, 1, 89, '20010709'
 Insert #Contratos_Marco select 'CORPBANCA', 81290800, 1, 391, '20080528'
 Insert #Contratos_Marco select 'CORPBANCA', 81290800, 1, 1403, '20120329'
 Insert #Contratos_Marco select 'CORPBANCA', 81338000, 1, 263, '20071018'
 Insert #Contratos_Marco select 'CORPBANCA', 81407200, 1, 224, '20060503'
 Insert #Contratos_Marco select 'CORPBANCA', 81407200, 1, 796, '20100319'
 Insert #Contratos_Marco select 'CORPBANCA', 81434300, 1, 1194, '20110819'
 Insert #Contratos_Marco select 'CORPBANCA', 81494400, 1, 845, '20100730'
 Insert #Contratos_Marco select 'CORPBANCA', 81529700, 1, 736, '20100217'
 Insert #Contratos_Marco select 'CORPBANCA', 81537600, 1, 574, '20090429'
 Insert #Contratos_Marco select 'CORPBANCA', 81537600, 1, 895, '20100921'
 Insert #Contratos_Marco select 'CORPBANCA', 81675600, 1, 164, '20040312'
 Insert #Contratos_Marco select 'CORPBANCA', 81719800, 1, 559, '20090316'
 Insert #Contratos_Marco select 'CORPBANCA', 81756100, 1, 113, '20011106'
 Insert #Contratos_Marco select 'CORPBANCA', 81776200, 1, 533, '20090212'
 Insert #Contratos_Marco select 'CORPBANCA', 81836000, 1, 1435, '20111019'
 Insert #Contratos_Marco select 'CORPBANCA', 81852700, 1, 42, '19981202'
 Insert #Contratos_Marco select 'CORPBANCA', 81988700, 1, 617, '20090728'
 Insert #Contratos_Marco select 'CORPBANCA', 81988700, 1, 916, '20101013'
 Insert #Contratos_Marco select 'CORPBANCA', 82136800, 1, 867, '20100819'
 Insert #Contratos_Marco select 'CORPBANCA', 82206800, 1, 859, '20100514'
 Insert #Contratos_Marco select 'CORPBANCA', 82225800, 1, 1200, '20110726'
 Insert #Contratos_Marco select 'CORPBANCA', 82300700, 1, 876, '20100827'
 Insert #Contratos_Marco select 'CORPBANCA', 82557000, 1, 785, '20100513'
 Insert #Contratos_Marco select 'CORPBANCA', 82838200, 1, 570, '20090505'
 Insert #Contratos_Marco select 'CORPBANCA', 82850700, 1, 125, '20021111'
 Insert #Contratos_Marco select 'CORPBANCA', 82888200, 1, 578, '20090515'
 Insert #Contratos_Marco select 'CORPBANCA', 82888200, 1, 1039, '20110314'
 Insert #Contratos_Marco select 'CORPBANCA', 82975400, 1, 1132, '20110624'
 Insert #Contratos_Marco select 'CORPBANCA', 82982300, 1, 456, '20080925'
 Insert #Contratos_Marco select 'CORPBANCA', 82982300, 1, 917, '20101015'
 Insert #Contratos_Marco select 'CORPBANCA', 83002400, 1, 51, '19990608'
 Insert #Contratos_Marco select 'CORPBANCA', 83024300, 1, 1228, '20110926'
 Insert #Contratos_Marco select 'CORPBANCA', 83033300, 1, 544, '20090212'
 Insert #Contratos_Marco select 'CORPBANCA', 83106200, 1, 467, '20081021'
 Insert #Contratos_Marco select 'CORPBANCA', 83150900, 1, 95, '20010830'
 Insert #Contratos_Marco select 'CORPBANCA', 83150900, 1, 1527, '20120910'
 Insert #Contratos_Marco select 'CORPBANCA', 83252500, 1, 106, '20020301'
 Insert #Contratos_Marco select 'CORPBANCA', 83260800, 1, 1540, '20121004'
 Insert #Contratos_Marco select 'CORPBANCA', 83382700, 1, 91, '20010718'
 Insert #Contratos_Marco select 'CORPBANCA', 83382700, 1, 598, '20090520'
 Insert #Contratos_Marco select 'CORPBANCA', 83382700, 1, 1474, '20120511'
 Insert #Contratos_Marco select 'CORPBANCA', 83472500, 1, 297, '20071026'
 Insert #Contratos_Marco select 'CORPBANCA', 83472500, 1, 1292, '20111118'
 Insert #Contratos_Marco select 'CORPBANCA', 83474400, 1, 392, '20080618'
 Insert #Contratos_Marco select 'CORPBANCA', 83474400, 1, 1161, '20110817'
 Insert #Contratos_Marco select 'CORPBANCA', 83483500, 1, 198, '20050823'
 Insert #Contratos_Marco select 'CORPBANCA', 83493700, 1, 13, '19970808'
 Insert #Contratos_Marco select 'CORPBANCA', 83498200, 1, 743, '20100308'
 Insert #Contratos_Marco select 'CORPBANCA', 83628100, 1, 902, '20101001'
 Insert #Contratos_Marco select 'CORPBANCA', 83947400, 1, 669, '20091027'
 Insert #Contratos_Marco select 'CORPBANCA', 84000000, 1, 1380, '20110315'
 Insert #Contratos_Marco select 'CORPBANCA', 84009400, 1, 151, '20030925'
 Insert #Contratos_Marco select 'CORPBANCA', 84009400, 1, 1416, '20120424'
 Insert #Contratos_Marco select 'CORPBANCA', 84144400, 1, 1275, '20111019'
 Insert #Contratos_Marco select 'CORPBANCA', 84177300, 1, 709, '20091224'
 Insert #Contratos_Marco select 'CORPBANCA', 84177300, 1, 1423, '20120514'
 Insert #Contratos_Marco select 'CORPBANCA', 84196300, 1, 340, '20070906'
 Insert #Contratos_Marco select 'CORPBANCA', 84226500, 1, 311, '20070906'
 Insert #Contratos_Marco select 'CORPBANCA', 84273400, 1, 507, '20081212'
 Insert #Contratos_Marco select 'CORPBANCA', 84348700, 1, 601, '20090701'
 Insert #Contratos_Marco select 'CORPBANCA', 84356800, 1, 1454, '20120510'
 Insert #Contratos_Marco select 'CORPBANCA', 84463900, 1, 1254, '20111011'
 Insert #Contratos_Marco select 'CORPBANCA', 84539000, 1, 708, '20091201'
 Insert #Contratos_Marco select 'CORPBANCA', 84650700, 1, 531, '20090206'
 Insert #Contratos_Marco select 'CORPBANCA', 84650700, 1, 1097, '20110420'
 Insert #Contratos_Marco select 'CORPBANCA', 84674200, 1, 542, '20081229'
 Insert #Contratos_Marco select 'CORPBANCA', 84674200, 1, 1428, '20120516'
 Insert #Contratos_Marco select 'CORPBANCA', 84751100, 1, 1313, '20111122'
 Insert #Contratos_Marco select 'CORPBANCA', 84768800, 1, 207, '20051205'
 Insert #Contratos_Marco select 'CORPBANCA', 84768800, 1, 1255, '20111012'
 Insert #Contratos_Marco select 'CORPBANCA', 84915900, 1, 429, '20080814'
 Insert #Contratos_Marco select 'CORPBANCA', 84915900, 1, 1108, '20101104'
 Insert #Contratos_Marco select 'CORPBANCA', 85110100, 1, 1524, '20120912'
 Insert #Contratos_Marco select 'CORPBANCA', 85146000, 1, 1023, '20110214'
 Insert #Contratos_Marco select 'CORPBANCA', 85149200, 1, 548, '20090305'
 Insert #Contratos_Marco select 'CORPBANCA', 85208700, 1, 396, '20080627'
 Insert #Contratos_Marco select 'CORPBANCA', 85238100, 1, 1411, '20120321'
 Insert #Contratos_Marco select 'CORPBANCA', 85257700, 1, 532, '20090211'
 Insert #Contratos_Marco select 'CORPBANCA', 85257700, 1, 1150, '20110721'
 Insert #Contratos_Marco select 'CORPBANCA', 85275700, 1, 984, '20100805'
 Insert #Contratos_Marco select 'CORPBANCA', 85279800, 1, 513, '20081226'
 Insert #Contratos_Marco select 'CORPBANCA', 85390800, 1, 1456, '20120216'
 Insert #Contratos_Marco select 'CORPBANCA', 85567100, 1, 571, '20090507'
 Insert #Contratos_Marco select 'CORPBANCA', 85567100, 1, 1025, '20101118'
 Insert #Contratos_Marco select 'CORPBANCA', 85644700, 1, 638, '20090819'
 Insert #Contratos_Marco select 'CORPBANCA', 85644700, 1, 1308, '20110322'
 Insert #Contratos_Marco select 'CORPBANCA', 85718000, 1, 380, '20080509'
 Insert #Contratos_Marco select 'CORPBANCA', 85787300, 1, 375, '20080604'
 Insert #Contratos_Marco select 'CORPBANCA', 85910900, 1, 1481, '20120625'
 Insert #Contratos_Marco select 'CORPBANCA', 85917400, 1, 14, '19970808'
 Insert #Contratos_Marco select 'CORPBANCA', 85980800, 1, 1282, '20111026'
 Insert #Contratos_Marco select 'CORPBANCA', 86090200, 1, 1486, '20120625'
 Insert #Contratos_Marco select 'CORPBANCA', 86099700, 1, 524, '20090109'
 Insert #Contratos_Marco select 'CORPBANCA', 86137300, 1, 94, '20011011'
 Insert #Contratos_Marco select 'CORPBANCA', 86293000, 1, 119, '20021008'
 Insert #Contratos_Marco select 'CORPBANCA', 86312900, 1, 1212, '20110922'
 Insert #Contratos_Marco select 'CORPBANCA', 86326300, 1, 215, '20060130'
 Insert #Contratos_Marco select 'CORPBANCA', 86379600, 1, 1490, '20120723'
 Insert #Contratos_Marco select 'CORPBANCA', 86381300, 1, 473, '20081029'
 Insert #Contratos_Marco select 'CORPBANCA', 86381300, 1, 1182, '20110829'
 Insert #Contratos_Marco select 'CORPBANCA', 86421400, 1, 1383, '20120209'
 Insert #Contratos_Marco select 'CORPBANCA', 86500000, 1, 1127, '20110602'
 Insert #Contratos_Marco select 'CORPBANCA', 86510400, 1, 432, '20080822'
 Insert #Contratos_Marco select 'CORPBANCA', 86521400, 1, 90, '20010712'
 Insert #Contratos_Marco select 'CORPBANCA', 86547900, 1, 1296, '20111116'
 Insert #Contratos_Marco select 'CORPBANCA', 86554900, 1, 1153, '20110729'
 Insert #Contratos_Marco select 'CORPBANCA', 86577500, 1, 464, '20081015'
 Insert #Contratos_Marco select 'CORPBANCA', 86685100, 1, 1483, '20120713'
 Insert #Contratos_Marco select 'CORPBANCA', 86708800, 1, 864, '20100819'
 Insert #Contratos_Marco select 'CORPBANCA', 86709900, 1, 377, '20080604'
 Insert #Contratos_Marco select 'CORPBANCA', 86727800, 1, 503, '20081124'
 Insert #Contratos_Marco select 'CORPBANCA', 86727800, 1, 1450, '20111205'
 Insert #Contratos_Marco select 'CORPBANCA', 86731200, 1, 1479, '20120710'
 Insert #Contratos_Marco select 'CORPBANCA', 86770900, 1, 1518, '20120827'
 Insert #Contratos_Marco select 'CORPBANCA', 86882500, 1, 554, '20090323'
 Insert #Contratos_Marco select 'CORPBANCA', 86882500, 1, 948, '20101029'
 Insert #Contratos_Marco select 'CORPBANCA', 86887200, 1, 1538, '20120712'
 Insert #Contratos_Marco select 'CORPBANCA', 86897200, 1, 47, '19990329'
 Insert #Contratos_Marco select 'CORPBANCA', 86963200, 1, 127, '20021119'
 Insert #Contratos_Marco select 'CORPBANCA', 87001500, 1, 41, '19981119'
 Insert #Contratos_Marco select 'CORPBANCA', 87001500, 1, 783, '20100504'
 Insert #Contratos_Marco select 'CORPBANCA', 87006000, 1, 346, '19000101'
 Insert #Contratos_Marco select 'CORPBANCA', 87107000, 1, 687, '20091030'
 Insert #Contratos_Marco select 'CORPBANCA', 87107000, 1, 980, '20101228'
 Insert #Contratos_Marco select 'CORPBANCA', 87644900, 1, 760, '20100423'
 Insert #Contratos_Marco select 'CORPBANCA', 87645000, 1, 1445, '20120604'
 Insert #Contratos_Marco select 'CORPBANCA', 87736700, 1, 831, '20100709'
 Insert #Contratos_Marco select 'CORPBANCA', 87806400, 1, 421, '20080723'
 Insert #Contratos_Marco select 'CORPBANCA', 87806400, 1, 769, '20100405'
 Insert #Contratos_Marco select 'CORPBANCA', 87845500, 1, 308, '20070827'
 Insert #Contratos_Marco select 'CORPBANCA', 87946800, 1, 272, '20071002'
 Insert #Contratos_Marco select 'CORPBANCA', 88128400, 1, 1549, '20121018'
 Insert #Contratos_Marco select 'CORPBANCA', 88325800, 1, 18, '19971028'
 Insert #Contratos_Marco select 'CORPBANCA', 88325800, 1, 136, '20021023'
 Insert #Contratos_Marco select 'CORPBANCA', 88400600, 1, 643, '20090929'
 Insert #Contratos_Marco select 'CORPBANCA', 88450000, 1, 797, '20100528'
 Insert #Contratos_Marco select 'CORPBANCA', 88452300, 1, 177, '20041005'
 Insert #Contratos_Marco select 'CORPBANCA', 88452300, 1, 1129, '20110603'
 Insert #Contratos_Marco select 'CORPBANCA', 88510000, 1, 782, '20100429'
 Insert #Contratos_Marco select 'CORPBANCA', 88579800, 1, 904, '20101004'
 Insert #Contratos_Marco select 'CORPBANCA', 88610100, 1, 189, '20050308'
 Insert #Contratos_Marco select 'CORPBANCA', 88680500, 1, 415, '20080721'
 Insert #Contratos_Marco select 'CORPBANCA', 88773700, 1, 802, '20100316'
 Insert #Contratos_Marco select 'CORPBANCA', 88855300, 1, 350, '20080410'
 Insert #Contratos_Marco select 'CORPBANCA', 88855300, 1, 1138, '20110329'
 Insert #Contratos_Marco select 'CORPBANCA', 88859600, 1, 237, '20060904'
 Insert #Contratos_Marco select 'CORPBANCA', 88859600, 1, 1318, '20111128'
 Insert #Contratos_Marco select 'CORPBANCA', 88886700, 1, 204, '20051107'
 Insert #Contratos_Marco select 'CORPBANCA', 88887900, 1, 546, '20090311'
 Insert #Contratos_Marco select 'CORPBANCA', 88926100, 1, 1444, '20120604'
 Insert #Contratos_Marco select 'CORPBANCA', 88975900, 1, 1374, '20120117'
 Insert #Contratos_Marco select 'CORPBANCA', 88976000, 1, 1513, '20120625'
 Insert #Contratos_Marco select 'CORPBANCA', 88983600, 1, 382, '20080604'
 Insert #Contratos_Marco select 'CORPBANCA', 89091900, 1, 446, '20080611'
 Insert #Contratos_Marco select 'CORPBANCA', 89091900, 1, 1332, '20110927'
 Insert #Contratos_Marco select 'CORPBANCA', 89131500, 1, 609, '20090709'
 Insert #Contratos_Marco select 'CORPBANCA', 89158100, 1, 684, '20091102'
 Insert #Contratos_Marco select 'CORPBANCA', 89164000, 1, 1340, '20111125'
 Insert #Contratos_Marco select 'CORPBANCA', 89257000, 1, 107, '20020313'
 Insert #Contratos_Marco select 'CORPBANCA', 89322100, 1, 1440, '20120529'
 Insert #Contratos_Marco select 'CORPBANCA', 89368200, 1, 1235, '20110926'
 Insert #Contratos_Marco select 'CORPBANCA', 89389400, 1, 447, '20080818'
 Insert #Contratos_Marco select 'CORPBANCA', 89444500, 1, 1471, '20120628'
 Insert #Contratos_Marco select 'CORPBANCA', 89458100, 1, 259, '20070914'
 Insert #Contratos_Marco select 'CORPBANCA', 89458100, 1, 1544, '20121002'
 Insert #Contratos_Marco select 'CORPBANCA', 89468900, 1, 553, '20090206'
 Insert #Contratos_Marco select 'CORPBANCA', 89470200, 1, 695, '20081203'
 Insert #Contratos_Marco select 'CORPBANCA', 89524100, 1, 791, '20100526'
 Insert #Contratos_Marco select 'CORPBANCA', 89573900, 1, 1118, '20110518'
 Insert #Contratos_Marco select 'CORPBANCA', 89626500, 1, 470, '20081024'
 Insert #Contratos_Marco select 'CORPBANCA', 89650200, 1, 174, '20040916'
 Insert #Contratos_Marco select 'CORPBANCA', 89650200, 1, 1437, '20120516'
 Insert #Contratos_Marco select 'CORPBANCA', 89694900, 1, 301, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 89694900, 1, 1360, '20120127'
 Insert #Contratos_Marco select 'CORPBANCA', 89713800, 1, 896, '20100927'
 Insert #Contratos_Marco select 'CORPBANCA', 89843100, 1, 697, '20091202'
 Insert #Contratos_Marco select 'CORPBANCA', 89844800, 1, 1035, '20110307'
 Insert #Contratos_Marco select 'CORPBANCA', 89853600, 1, 185, '20050125'
 Insert #Contratos_Marco select 'CORPBANCA', 89862200, 1, 354, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 89862200, 1, 552, '20090324'
 Insert #Contratos_Marco select 'CORPBANCA', 89876100, 1, 400, '20080702'
 Insert #Contratos_Marco select 'CORPBANCA', 89895100, 1, 454, '20081002'
 Insert #Contratos_Marco select 'CORPBANCA', 89912300, 1, 1027, '20100827'
 Insert #Contratos_Marco select 'CORPBANCA', 89917700, 1, 790, '20100511'
 Insert #Contratos_Marco select 'CORPBANCA', 89974000, 1, 120, '20020716'
 Insert #Contratos_Marco select 'CORPBANCA', 90060000, 1, 58, '19991110'
 Insert #Contratos_Marco select 'CORPBANCA', 90086000, 1, 655, '20091006'
 Insert #Contratos_Marco select 'CORPBANCA', 90209000, 1, 40, '19981103'
 Insert #Contratos_Marco select 'CORPBANCA', 90227000, 1, 216, '20060130'
 Insert #Contratos_Marco select 'CORPBANCA', 90266000, 1, 49, '19990422'
 Insert #Contratos_Marco select 'CORPBANCA', 90266000, 1, 172, '20040825'
 Insert #Contratos_Marco select 'CORPBANCA', 90266000, 1, 1080, '20110314'
 Insert #Contratos_Marco select 'CORPBANCA', 90269000, 1, 110, '20020702'
 Insert #Contratos_Marco select 'CORPBANCA', 90274000, 1, 205, '20051121'
 Insert #Contratos_Marco select 'CORPBANCA', 90274000, 1, 295, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 90310000, 1, 289, '20071004'
 Insert #Contratos_Marco select 'CORPBANCA', 90413000, 1, 46, '19990223'
 Insert #Contratos_Marco select 'CORPBANCA', 90413000, 1, 1158, '20110706'
 Insert #Contratos_Marco select 'CORPBANCA', 90635000, 1, 24, '19980112'
 Insert #Contratos_Marco select 'CORPBANCA', 90743000, 1, 303, '20071219'
 Insert #Contratos_Marco select 'CORPBANCA', 90749000, 1, 35, '19980915'
 Insert #Contratos_Marco select 'CORPBANCA', 90749000, 1, 476, '20081028'
 Insert #Contratos_Marco select 'CORPBANCA', 90749000, 1, 924, '20100930'
 Insert #Contratos_Marco select 'CORPBANCA', 90828000, 1, 31, '19980720'
 Insert #Contratos_Marco select 'CORPBANCA', 90844000, 1, 219, '20060217'
 Insert #Contratos_Marco select 'CORPBANCA', 90877000, 1, 713, '20090916'
 Insert #Contratos_Marco select 'CORPBANCA', 91021000, 1, 93, '20011009'
 Insert #Contratos_Marco select 'CORPBANCA', 91041000, 1, 1159, '20110706'
 Insert #Contratos_Marco select 'CORPBANCA', 91083000, 1, 268, '20061024'
 Insert #Contratos_Marco select 'CORPBANCA', 91083000, 1, 1066, '20110228'
 Insert #Contratos_Marco select 'CORPBANCA', 91123000, 1, 19, '19971107'
 Insert #Contratos_Marco select 'CORPBANCA', 91124000, 1, 1223, '20110928'
 Insert #Contratos_Marco select 'CORPBANCA', 91237000, 1, 296, '20071203'
 Insert #Contratos_Marco select 'CORPBANCA', 91297000, 1, 370, '20080519'
 Insert #Contratos_Marco select 'CORPBANCA', 91300000, 1, 498, '20081118'
 Insert #Contratos_Marco select 'CORPBANCA', 91335000, 1, 634, '20090904'
 Insert #Contratos_Marco select 'CORPBANCA', 91362000, 1, 86, '20010614'
 Insert #Contratos_Marco select 'CORPBANCA', 91408000, 1, 66, '20000210'
 Insert #Contratos_Marco select 'CORPBANCA', 91408000, 1, 693, '20091201'
 Insert #Contratos_Marco select 'CORPBANCA', 91438000, 1, 1177, '20110818'
 Insert #Contratos_Marco select 'CORPBANCA', 91448000, 1, 360, '20080506'
 Insert #Contratos_Marco select 'CORPBANCA', 91448000, 1, 1043, '20110322'
 Insert #Contratos_Marco select 'CORPBANCA', 91510000, 1, 323, '20080129'
 Insert #Contratos_Marco select 'CORPBANCA', 91550000, 1, 1130, '20110622'
 Insert #Contratos_Marco select 'CORPBANCA', 91643000, 1, 9, '19970421'
 Insert #Contratos_Marco select 'CORPBANCA', 91656000, 1, 390, '20080506'
 Insert #Contratos_Marco select 'CORPBANCA', 91666000, 1, 1327, '20111024'
 Insert #Contratos_Marco select 'CORPBANCA', 91755000, 1, 364, '20071004'
 Insert #Contratos_Marco select 'CORPBANCA', 91827000, 1, 334, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 91840000, 1, 26, '19971030'
 Insert #Contratos_Marco select 'CORPBANCA', 91915000, 1, 696, '20091130'
 Insert #Contratos_Marco select 'CORPBANCA', 91942000, 1, 276, '20071030'
 Insert #Contratos_Marco select 'CORPBANCA', 91942000, 1, 1351, '20111230'
 Insert #Contratos_Marco select 'CORPBANCA', 91944000, 1, 96, '20010907'
 Insert #Contratos_Marco select 'CORPBANCA', 92048000, 1, 417, '20080724'
 Insert #Contratos_Marco select 'CORPBANCA', 92091000, 1, 181, '20041112'
 Insert #Contratos_Marco select 'CORPBANCA', 92121000, 1, 222, '20060321'
 Insert #Contratos_Marco select 'CORPBANCA', 92121000, 1, 835, '20100713'
 Insert #Contratos_Marco select 'CORPBANCA', 92139000, 1, 510, '20081020'
 Insert #Contratos_Marco select 'CORPBANCA', 92139000, 1, 1262, '20110715'
 Insert #Contratos_Marco select 'CORPBANCA', 92147000, 1, 1168, '20110823'
 Insert #Contratos_Marco select 'CORPBANCA', 92156000, 1, 1001, '20110104'
 Insert #Contratos_Marco select 'CORPBANCA', 92172000, 1, 300, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 92172000, 1, 1075, '20110412'
 Insert #Contratos_Marco select 'CORPBANCA', 92176000, 1, 594, '20090626'
 Insert #Contratos_Marco select 'CORPBANCA', 92182000, 1, 537, '20090126'
 Insert #Contratos_Marco select 'CORPBANCA', 92236000, 1, 356, '20080411'
 Insert #Contratos_Marco select 'CORPBANCA', 92242000, 1, 190, '20050406'
 Insert #Contratos_Marco select 'CORPBANCA', 92242000, 1, 495, '20081113'
 Insert #Contratos_Marco select 'CORPBANCA', 92242000, 1, 921, '20101020'
 Insert #Contratos_Marco select 'CORPBANCA', 92279000, 1, 995, '20110107'
 Insert #Contratos_Marco select 'CORPBANCA', 92340000, 1, 67, '20000407'
 Insert #Contratos_Marco select 'CORPBANCA', 92387000, 1, 230, '20060628'
 Insert #Contratos_Marco select 'CORPBANCA', 92387000, 1, 1245, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 92449000, 1, 409, '20080718'
 Insert #Contratos_Marco select 'CORPBANCA', 92461000, 1, 248, '20061115'
 Insert #Contratos_Marco select 'CORPBANCA', 92461000, 1, 1475, '20120613'
 Insert #Contratos_Marco select 'CORPBANCA', 92476000, 1, 149, '20030908'
 Insert #Contratos_Marco select 'CORPBANCA', 92513000, 1, 1364, '20120131'
 Insert #Contratos_Marco select 'CORPBANCA', 92544000, 1, 33, '19980812'
 Insert #Contratos_Marco select 'CORPBANCA', 92580000, 1, 134, '20021014'
 Insert #Contratos_Marco select 'CORPBANCA', 92604000, 1, 986, '20101206'
 Insert #Contratos_Marco select 'CORPBANCA', 92692000, 1, 150, '20030714'
 Insert #Contratos_Marco select 'CORPBANCA', 92819000, 1, 1528, '20120315'
 Insert #Contratos_Marco select 'CORPBANCA', 92821000, 1, 535, '20090206'
 Insert #Contratos_Marco select 'CORPBANCA', 92821000, 1, 1054, '20110307'
 Insert #Contratos_Marco select 'CORPBANCA', 92975000, 1, 257, '20070523'
 Insert #Contratos_Marco select 'CORPBANCA', 92975000, 1, 878, '20100901'
 Insert #Contratos_Marco select 'CORPBANCA', 92987000, 1, 1500, '20120627'
 Insert #Contratos_Marco select 'CORPBANCA', 93007000, 1, 2, '19970103'
 Insert #Contratos_Marco select 'CORPBANCA', 93007000, 1, 1352, '20120106'
 Insert #Contratos_Marco select 'CORPBANCA', 93049000, 1, 1507, '20120614'
 Insert #Contratos_Marco select 'CORPBANCA', 93061000, 1, 249, '20061117'
 Insert #Contratos_Marco select 'CORPBANCA', 93065000, 1, 8, '19970404'
 Insert #Contratos_Marco select 'CORPBANCA', 93065000, 1, 822, '20100520'
 Insert #Contratos_Marco select 'CORPBANCA', 93097000, 1, 718, '20100113'
 Insert #Contratos_Marco select 'CORPBANCA', 93178000, 1, 332, '20080212'
 Insert #Contratos_Marco select 'CORPBANCA', 93178000, 1, 1378, '20120112'
 Insert #Contratos_Marco select 'CORPBANCA', 93217000, 1, 131, '20021202'
 Insert #Contratos_Marco select 'CORPBANCA', 93217000, 1, 1563, '20121109'
 Insert #Contratos_Marco select 'CORPBANCA', 93281000, 1, 1202, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 93297000, 1, 87, '20010622'
 Insert #Contratos_Marco select 'CORPBANCA', 93305000, 1, 387, '20080529'
 Insert #Contratos_Marco select 'CORPBANCA', 93305000, 1, 1319, '20111104'
 Insert #Contratos_Marco select 'CORPBANCA', 93322000, 1, 1119, '20110526'
 Insert #Contratos_Marco select 'CORPBANCA', 93333000, 1, 1460, '20100526'
 Insert #Contratos_Marco select 'CORPBANCA', 93352000, 1, 652, '20091006'
 Insert #Contratos_Marco select 'CORPBANCA', 93408000, 1, 502, '20081121'
 Insert #Contratos_Marco select 'CORPBANCA', 93435000, 1, 139, '20030127'
 Insert #Contratos_Marco select 'CORPBANCA', 93440000, 1, 725, '20100119'
 Insert #Contratos_Marco select 'CORPBANCA', 93456000, 1, 167, '20040618'
 Insert #Contratos_Marco select 'CORPBANCA', 93458000, 1, 962, '20101119'
 Insert #Contratos_Marco select 'CORPBANCA', 93526000, 1, 191, '20050422'
 Insert #Contratos_Marco select 'CORPBANCA', 93538000, 1, 179, '20041013'
 Insert #Contratos_Marco select 'CORPBANCA', 93550000, 1, 642, '20090922'
 Insert #Contratos_Marco select 'CORPBANCA', 93558000, 1, 61, '19991229'
 Insert #Contratos_Marco select 'CORPBANCA', 93628000, 1, 676, '20081203'
 Insert #Contratos_Marco select 'CORPBANCA', 93654000, 1, 394, '20080623'
 Insert #Contratos_Marco select 'CORPBANCA', 93682000, 1, 135, '20030103'
 Insert #Contratos_Marco select 'CORPBANCA', 93734000, 1, 88, '20010705'
 Insert #Contratos_Marco select 'CORPBANCA', 93734000, 1, 756, '20100420'
 Insert #Contratos_Marco select 'CORPBANCA', 93764000, 1, 43, '19981202'
 Insert #Contratos_Marco select 'CORPBANCA', 93767000, 1, 1226, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 93910000, 1, 345, '20080123'
 Insert #Contratos_Marco select 'CORPBANCA', 94139000, 1, 1359, '20120126'
 Insert #Contratos_Marco select 'CORPBANCA', 94141000, 1, 240, '20060911'
 Insert #Contratos_Marco select 'CORPBANCA', 94150000, 1, 807, '20100608'
 Insert #Contratos_Marco select 'CORPBANCA', 94272000, 1, 907, '20100907'
 Insert #Contratos_Marco select 'CORPBANCA', 94340000, 1, 69, '20000717'
 Insert #Contratos_Marco select 'CORPBANCA', 94486000, 1, 883, '20100902'
 Insert #Contratos_Marco select 'CORPBANCA', 94565000, 1, 1488, '20120703'
 Insert #Contratos_Marco select 'CORPBANCA', 94627000, 1, 79, '20010124'
 Insert #Contratos_Marco select 'CORPBANCA', 94684000, 1, 1314, '20110315'
 Insert #Contratos_Marco select 'CORPBANCA', 94686000, 1, 1024, '20110302'
 Insert #Contratos_Marco select 'CORPBANCA', 94762000, 1, 953, '20101201'
 Insert #Contratos_Marco select 'CORPBANCA', 94861000, 1, 133, '20021212'
 Insert #Contratos_Marco select 'CORPBANCA', 94952000, 1, 209, '20051220'
 Insert #Contratos_Marco select 'CORPBANCA', 94995000, 1, 373, '20060831'
 Insert #Contratos_Marco select 'CORPBANCA', 95164000, 1, 1453, '20120611'
 Insert #Contratos_Marco select 'CORPBANCA', 95260000, 1, 411, '20080724'
 Insert #Contratos_Marco select 'CORPBANCA', 95260000, 1, 1516, '20120828'
 Insert #Contratos_Marco select 'CORPBANCA', 95511530, 1, 232, '20060710'
 Insert #Contratos_Marco select 'CORPBANCA', 95594000, 1, 759, '20100407'
 Insert #Contratos_Marco select 'CORPBANCA', 95667000, 1, 439, '20080829'
 Insert #Contratos_Marco select 'CORPBANCA', 95667000, 1, 1379, '20120209'
 Insert #Contratos_Marco select 'CORPBANCA', 95891000, 1, 169, '20040728'
 Insert #Contratos_Marco select 'CORPBANCA', 95891000, 1, 686, '20090709'
 Insert #Contratos_Marco select 'CORPBANCA', 95891000, 1, 1412, '20110809'
 Insert #Contratos_Marco select 'CORPBANCA', 95896000, 1, 787, '20100504'
 Insert #Contratos_Marco select 'CORPBANCA', 96135000, 1, 28, '19980526'
 Insert #Contratos_Marco select 'CORPBANCA', 96233000, 1, 76, '20001110'
 Insert #Contratos_Marco select 'CORPBANCA', 96233000, 1, 1181, '20101112'
 Insert #Contratos_Marco select 'CORPBANCA', 96364000, 1, 132, '20021211'
 Insert #Contratos_Marco select 'CORPBANCA', 96364000, 1, 242, '20060929'
 Insert #Contratos_Marco select 'CORPBANCA', 96364000, 1, 766, '20100322'
 Insert #Contratos_Marco select 'CORPBANCA', 96439000, 1, 54, '19991018'
 Insert #Contratos_Marco select 'CORPBANCA', 96504550, 1, 328, '20070906'
 Insert #Contratos_Marco select 'CORPBANCA', 96505760, 1, 77, '20010103'
 Insert #Contratos_Marco select 'CORPBANCA', 96505760, 1, 632, '20090604'
 Insert #Contratos_Marco select 'CORPBANCA', 96506350, 1, 1484, '20120718'
 Insert #Contratos_Marco select 'CORPBANCA', 96509410, 1, 496, '20081113'
 Insert #Contratos_Marco select 'CORPBANCA', 96509660, 1, 255, '20070419'
 Insert #Contratos_Marco select 'CORPBANCA', 96509990, 1, 979, '20101220'
 Insert #Contratos_Marco select 'CORPBANCA', 96510380, 1, 700, '20091201'
 Insert #Contratos_Marco select 'CORPBANCA', 96510380, 1, 946, '20101118'
 Insert #Contratos_Marco select 'CORPBANCA', 96511170, 1, 998, '20100625'
 Insert #Contratos_Marco select 'CORPBANCA', 96511460, 1, 304, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96511460, 1, 918, '20100930'
 Insert #Contratos_Marco select 'CORPBANCA', 96511810, 1, 62, '19991230'
 Insert #Contratos_Marco select 'CORPBANCA', 96512230, 1, 223, '20060425'
 Insert #Contratos_Marco select 'CORPBANCA', 96512230, 1, 1063, '20101118'
 Insert #Contratos_Marco select 'CORPBANCA', 96513050, 1, 352, '20060614'
 Insert #Contratos_Marco select 'CORPBANCA', 96513630, 1, 1302, '20110901'
 Insert #Contratos_Marco select 'CORPBANCA', 96515580, 1, 317, '20080130'
 Insert #Contratos_Marco select 'CORPBANCA', 96516000, 1, 1126, '20110616'
 Insert #Contratos_Marco select 'CORPBANCA', 96516150, 1, 374, '20080522'
 Insert #Contratos_Marco select 'CORPBANCA', 96517990, 1, 668, '20091027'
 Insert #Contratos_Marco select 'CORPBANCA', 96518070, 1, 551, '20090302'
 Insert #Contratos_Marco select 'CORPBANCA', 96518070, 1, 1203, '20110928'
 Insert #Contratos_Marco select 'CORPBANCA', 96518090, 1, 293, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96518090, 1, 950, '20101117'
 Insert #Contratos_Marco select 'CORPBANCA', 96519500, 1, 115, '20020819'
 Insert #Contratos_Marco select 'CORPBANCA', 96520630, 1, 561, '20090319'
 Insert #Contratos_Marco select 'CORPBANCA', 96521440, 1, 238, '20060907'
 Insert #Contratos_Marco select 'CORPBANCA', 96526080, 1, 160, '20040206'
 Insert #Contratos_Marco select 'CORPBANCA', 96528520, 1, 1552, '20121025'
 Insert #Contratos_Marco select 'CORPBANCA', 96528990, 1, 314, '20080129'
 Insert #Contratos_Marco select 'CORPBANCA', 96529310, 1, 12, '19970619'
 Insert #Contratos_Marco select 'CORPBANCA', 96530740, 1, 283, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96530740, 1, 331, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96530900, 1, 1468, '20120420'
 Insert #Contratos_Marco select 'CORPBANCA', 96532830, 1, 591, '20090619'
 Insert #Contratos_Marco select 'CORPBANCA', 96532830, 1, 851, '20100805'
 Insert #Contratos_Marco select 'CORPBANCA', 96533620, 1, 1, '19961219'
 Insert #Contratos_Marco select 'CORPBANCA', 96534440, 1, 627, '20090820'
 Insert #Contratos_Marco select 'CORPBANCA', 96534440, 1, 865, '20100813'
 Insert #Contratos_Marco select 'CORPBANCA', 96535470, 1, 78, '20010104'
 Insert #Contratos_Marco select 'CORPBANCA', 96535470, 1, 228, '20060628'
 Insert #Contratos_Marco select 'CORPBANCA', 96535470, 1, 823, '20100520'
 Insert #Contratos_Marco select 'CORPBANCA', 96535920, 1, 227, '20060606'
 Insert #Contratos_Marco select 'CORPBANCA', 96538260, 1, 1248, '20111005'
 Insert #Contratos_Marco select 'CORPBANCA', 96540700, 1, 402, '20080627'
 Insert #Contratos_Marco select 'CORPBANCA', 96541340, 1, 379, '20080609'
 Insert #Contratos_Marco select 'CORPBANCA', 96541340, 1, 1438, '20120529'
 Insert #Contratos_Marco select 'CORPBANCA', 96542490, 1, 405, '20080715'
 Insert #Contratos_Marco select 'CORPBANCA', 96542490, 1, 911, '20101006'
 Insert #Contratos_Marco select 'CORPBANCA', 96542880, 1, 465, '20081016'
 Insert #Contratos_Marco select 'CORPBANCA', 96544240, 1, 626, '20090806'
 Insert #Contratos_Marco select 'CORPBANCA', 96545450, 1, 239, '20060911'
 Insert #Contratos_Marco select 'CORPBANCA', 96545600, 1, 1305, '20111116'
 Insert #Contratos_Marco select 'CORPBANCA', 96546520, 1, 357, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96547180, 1, 52, '19990909'
 Insert #Contratos_Marco select 'CORPBANCA', 96547180, 1, 434, '20080724'
 Insert #Contratos_Marco select 'CORPBANCA', 96547180, 1, 1093, '20110111'
 Insert #Contratos_Marco select 'CORPBANCA', 96555640, 1, 10, '19970610'
 Insert #Contratos_Marco select 'CORPBANCA', 96555640, 1, 776, '20100322'
 Insert #Contratos_Marco select 'CORPBANCA', 96556210, 1, 5, '19970204'
 Insert #Contratos_Marco select 'CORPBANCA', 96556310, 1, 1286, '20111109'
 Insert #Contratos_Marco select 'CORPBANCA', 96557330, 1, 73, '20000914'
 Insert #Contratos_Marco select 'CORPBANCA', 96561560, 1, 351, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96563630, 1, 920, '20100930'
 Insert #Contratos_Marco select 'CORPBANCA', 96564330, 1, 32, '19980722'
 Insert #Contratos_Marco select 'CORPBANCA', 96564330, 1, 1381, '20111221'
 Insert #Contratos_Marco select 'CORPBANCA', 96566940, 1, 92, '20010904'
 Insert #Contratos_Marco select 'CORPBANCA', 96566940, 1, 562, '20090422'
 Insert #Contratos_Marco select 'CORPBANCA', 96566940, 1, 767, '20100412'
 Insert #Contratos_Marco select 'CORPBANCA', 96568090, 1, 182, '20041112'
 Insert #Contratos_Marco select 'CORPBANCA', 96568740, 1, 538, '20081110'
 Insert #Contratos_Marco select 'CORPBANCA', 96568950, 1, 83, '20010510'
 Insert #Contratos_Marco select 'CORPBANCA', 96568970, 1, 129, '20021122'
 Insert #Contratos_Marco select 'CORPBANCA', 96568970, 1, 1162, '20110803'
 Insert #Contratos_Marco select 'CORPBANCA', 96569130, 1, 674, '20091028'
 Insert #Contratos_Marco select 'CORPBANCA', 96569690, 1, 854, '20100812'
 Insert #Contratos_Marco select 'CORPBANCA', 96571890, 1, 614, '20090302'
 Insert #Contratos_Marco select 'CORPBANCA', 96576540, 1, 1164, '20110802'
 Insert #Contratos_Marco select 'CORPBANCA', 96578160, 1, 65, '20000124'
 Insert #Contratos_Marco select 'CORPBANCA', 96579190, 1, 82, '20010504'
 Insert #Contratos_Marco select 'CORPBANCA', 96579330, 1, 1190, '20110914'
 Insert #Contratos_Marco select 'CORPBANCA', 96579920, 1, 1371, '20110517'
 Insert #Contratos_Marco select 'CORPBANCA', 96581380, 1, 214, '20060130'
 Insert #Contratos_Marco select 'CORPBANCA', 96581970, 1, 452, '20080929'
 Insert #Contratos_Marco select 'CORPBANCA', 96583540, 1, 144, '20030416'
 Insert #Contratos_Marco select 'CORPBANCA', 96583540, 1, 1373, '20120201'
 Insert #Contratos_Marco select 'CORPBANCA', 96585890, 1, 330, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96588770, 1, 168, '20040712'
 Insert #Contratos_Marco select 'CORPBANCA', 96590900, 1, 978, '20101220'
 Insert #Contratos_Marco select 'CORPBANCA', 96591040, 1, 441, '20080910'
 Insert #Contratos_Marco select 'CORPBANCA', 96591040, 1, 768, '20100319'
 Insert #Contratos_Marco select 'CORPBANCA', 96592810, 1, 176, '20040921'
 Insert #Contratos_Marco select 'CORPBANCA', 96592810, 1, 1297, '20110523'
 Insert #Contratos_Marco select 'CORPBANCA', 96594200, 1, 309, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96594200, 1, 1304, '20111116'
 Insert #Contratos_Marco select 'CORPBANCA', 96596220, 1, 841, '20100723'
 Insert #Contratos_Marco select 'CORPBANCA', 96596540, 1, 389, '20080506'
 Insert #Contratos_Marco select 'CORPBANCA', 96596540, 1, 866, '20100319'
 Insert #Contratos_Marco select 'CORPBANCA', 96599100, 1, 361, '20080429'
 Insert #Contratos_Marco select 'CORPBANCA', 96600850, 1, 795, '20100526'
 Insert #Contratos_Marco select 'CORPBANCA', 96602640, 1, 1280, '20111108'
 Insert #Contratos_Marco select 'CORPBANCA', 96604460, 1, 512, '20080301'
 Insert #Contratos_Marco select 'CORPBANCA', 96604460, 1, 942, '20101029'
 Insert #Contratos_Marco select 'CORPBANCA', 96604700, 1, 977, '20101223'
 Insert #Contratos_Marco select 'CORPBANCA', 96609940, 1, 457, '20081003'
 Insert #Contratos_Marco select 'CORPBANCA', 96610780, 1, 419, '20080728'
 Insert #Contratos_Marco select 'CORPBANCA', 96611670, 1, 3, '19970108'
 Insert #Contratos_Marco select 'CORPBANCA', 96615460, 1, 619, '20090806'
 Insert #Contratos_Marco select 'CORPBANCA', 96622320, 1, 111, '20020723'
 Insert #Contratos_Marco select 'CORPBANCA', 96622320, 1, 488, '20081103'
 Insert #Contratos_Marco select 'CORPBANCA', 96634110, 1, 849, '20100802'
 Insert #Contratos_Marco select 'CORPBANCA', 96635030, 1, 440, '20080822'
 Insert #Contratos_Marco select 'CORPBANCA', 96635030, 1, 1107, '20101215'
 Insert #Contratos_Marco select 'CORPBANCA', 96635340, 1, 21, '19971120'
 Insert #Contratos_Marco select 'CORPBANCA', 96635340, 1, 85, '20010605'
 Insert #Contratos_Marco select 'CORPBANCA', 96635340, 1, 870, '20100820'
 Insert #Contratos_Marco select 'CORPBANCA', 96635700, 1, 180, '20040830'
 Insert #Contratos_Marco select 'CORPBANCA', 96635700, 1, 458, '20071126'
 Insert #Contratos_Marco select 'CORPBANCA', 96635700, 1, 1401, '20120326'
 Insert #Contratos_Marco select 'CORPBANCA', 96636520, 1, 633, '20090819'
 Insert #Contratos_Marco select 'CORPBANCA', 96640940, 1, 641, '20090804'
 Insert #Contratos_Marco select 'CORPBANCA', 96640940, 1, 957, '20100924'
 Insert #Contratos_Marco select 'CORPBANCA', 96643070, 1, 1278, '20111028'
 Insert #Contratos_Marco select 'CORPBANCA', 96643170, 1, 16, '19970909'
 Insert #Contratos_Marco select 'CORPBANCA', 96649530, 1, 451, '20080911'
 Insert #Contratos_Marco select 'CORPBANCA', 96653630, 1, 1499, '20120727'
 Insert #Contratos_Marco select 'CORPBANCA', 96653770, 1, 344, '20080212'
 Insert #Contratos_Marco select 'CORPBANCA', 96655110, 1, 384, '20080612'
 Insert #Contratos_Marco select 'CORPBANCA', 96655110, 1, 1167, '20110810'
 Insert #Contratos_Marco select 'CORPBANCA', 96655860, 1, 683, '20091104'
 Insert #Contratos_Marco select 'CORPBANCA', 96656050, 1, 1163, '20110808'
 Insert #Contratos_Marco select 'CORPBANCA', 96656410, 1, 246, '20061010'
 Insert #Contratos_Marco select 'CORPBANCA', 96662020, 1, 712, '20091229'
 Insert #Contratos_Marco select 'CORPBANCA', 96662450, 1, 827, '20100623'
 Insert #Contratos_Marco select 'CORPBANCA', 96664310, 1, 721, '20100129'
 Insert #Contratos_Marco select 'CORPBANCA', 96664310, 1, 1034, '20110308'
 Insert #Contratos_Marco select 'CORPBANCA', 96664360, 1, 1272, '20110804'
 Insert #Contratos_Marco select 'CORPBANCA', 96665450, 1, 59, '19991122'
 Insert #Contratos_Marco select 'CORPBANCA', 96665450, 1, 489, '20081111'
 Insert #Contratos_Marco select 'CORPBANCA', 96665450, 1, 927, '20101028'
 Insert #Contratos_Marco select 'CORPBANCA', 96667410, 1, 1225, '20110915'
 Insert #Contratos_Marco select 'CORPBANCA', 96667520, 1, 516, '20090106'
 Insert #Contratos_Marco select 'CORPBANCA', 96667560, 1, 618, '20090728'
 Insert #Contratos_Marco select 'CORPBANCA', 96667560, 1, 929, '20101025'
 Insert #Contratos_Marco select 'CORPBANCA', 96670840, 1, 597, '20090625'
 Insert #Contratos_Marco select 'CORPBANCA', 96671580, 1, 39, '19981014'
 Insert #Contratos_Marco select 'CORPBANCA', 96671590, 1, 1311, '20111125'
 Insert #Contratos_Marco select 'CORPBANCA', 96676470, 1, 270, '20071003'
 Insert #Contratos_Marco select 'CORPBANCA', 96676670, 1, 11, '19970618'
 Insert #Contratos_Marco select 'CORPBANCA', 96676670, 1, 244, '20060929'
 Insert #Contratos_Marco select 'CORPBANCA', 96676670, 1, 775, '20100322'
 Insert #Contratos_Marco select 'CORPBANCA', 96677140, 1, 109, '20020724'
 Insert #Contratos_Marco select 'CORPBANCA', 96678790, 1, 407, '20080714'
 Insert #Contratos_Marco select 'CORPBANCA', 96682150, 1, 103, '20011203'
 Insert #Contratos_Marco select 'CORPBANCA', 96682800, 1, 29, '19980609'
 Insert #Contratos_Marco select 'CORPBANCA', 96685460, 1, 427, '20080801'
 Insert #Contratos_Marco select 'CORPBANCA', 96685680, 1, 290, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96686870, 1, 225, '20060524'
 Insert #Contratos_Marco select 'CORPBANCA', 96689260, 1, 17, '19971020'
 Insert #Contratos_Marco select 'CORPBANCA', 96690560, 1, 483, '20081027'
 Insert #Contratos_Marco select 'CORPBANCA', 96690560, 1, 1171, '20110628'
 Insert #Contratos_Marco select 'CORPBANCA', 96692040, 1, 1322, '20110616'
 Insert #Contratos_Marco select 'CORPBANCA', 96694060, 1, 1410, '20120326'
 Insert #Contratos_Marco select 'CORPBANCA', 96702420, 1, 1070, '20101111'
 Insert #Contratos_Marco select 'CORPBANCA', 96703690, 1, 229, '20060628'
 Insert #Contratos_Marco select 'CORPBANCA', 96703690, 1, 1103, '20110420'
 Insert #Contratos_Marco select 'CORPBANCA', 96704190, 1, 322, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96704190, 1, 1183, '20110817'
 Insert #Contratos_Marco select 'CORPBANCA', 96705940, 1, 397, '20080606'
 Insert #Contratos_Marco select 'CORPBANCA', 96705940, 1, 781, '20100414'
 Insert #Contratos_Marco select 'CORPBANCA', 96706060, 1, 262, '20070914'
 Insert #Contratos_Marco select 'CORPBANCA', 96711160, 1, 57, '19991104'
 Insert #Contratos_Marco select 'CORPBANCA', 96713680, 1, 1237, '20111003'
 Insert #Contratos_Marco select 'CORPBANCA', 96715730, 1, 1026, '20110301'
 Insert #Contratos_Marco select 'CORPBANCA', 96716620, 1, 1429, '20120319'
 Insert #Contratos_Marco select 'CORPBANCA', 96718120, 1, 985, '20110107'
 Insert #Contratos_Marco select 'CORPBANCA', 96719210, 1, 48, '19990420'
 Insert #Contratos_Marco select 'CORPBANCA', 96720830, 1, 689, '20091127'
 Insert #Contratos_Marco select 'CORPBANCA', 96721350, 1, 750, '20100323'
 Insert #Contratos_Marco select 'CORPBANCA', 96722460, 1, 1189, '20110912'
 Insert #Contratos_Marco select 'CORPBANCA', 96723760, 1, 1485, '20120710'
 Insert #Contratos_Marco select 'CORPBANCA', 96725160, 1, 163, '20040803'
 Insert #Contratos_Marco select 'CORPBANCA', 96728570, 1, 362, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96733780, 1, 408, '20080707'
 Insert #Contratos_Marco select 'CORPBANCA', 96749800, 1, 162, '20030904'
 Insert #Contratos_Marco select 'CORPBANCA', 96751950, 1, 825, '20100622'
 Insert #Contratos_Marco select 'CORPBANCA', 96756540, 1, 211, '20051229'
 Insert #Contratos_Marco select 'CORPBANCA', 96757290, 1, 1115, '20110518'
 Insert #Contratos_Marco select 'CORPBANCA', 96758830, 1, 762, '20100426'
 Insert #Contratos_Marco select 'CORPBANCA', 96759240, 1, 366, '20080424'
 Insert #Contratos_Marco select 'CORPBANCA', 96759240, 1, 1124, '20110607'
 Insert #Contratos_Marco select 'CORPBANCA', 96759330, 1, 939, '20101013'
 Insert #Contratos_Marco select 'CORPBANCA', 96772450, 1, 999, '20110106'
 Insert #Contratos_Marco select 'CORPBANCA', 96772490, 1, 1459, '20120502'
 Insert #Contratos_Marco select 'CORPBANCA', 96773120, 1, 1074, '20110413'
 Insert #Contratos_Marco select 'CORPBANCA', 96773130, 1, 1543, '20121002'
 Insert #Contratos_Marco select 'CORPBANCA', 96774690, 1, 607, '20090331'
 Insert #Contratos_Marco select 'CORPBANCA', 96776830, 1, 1547, '20121003'
 Insert #Contratos_Marco select 'CORPBANCA', 96777170, 1, 188, '20040823'
 Insert #Contratos_Marco select 'CORPBANCA', 96778920, 1, 1196, '20110906'
 Insert #Contratos_Marco select 'CORPBANCA', 96787270, 1, 1390, '20120127'
 Insert #Contratos_Marco select 'CORPBANCA', 96787750, 1, 80, '20010417'
 Insert #Contratos_Marco select 'CORPBANCA', 96787790, 1, 124, '20021111'
 Insert #Contratos_Marco select 'CORPBANCA', 96792430, 1, 1458, '20120507'
 Insert #Contratos_Marco select 'CORPBANCA', 96794750, 1, 826, '20100705'
 Insert #Contratos_Marco select 'CORPBANCA', 96794840, 1, 1143, '20110705'
 Insert #Contratos_Marco select 'CORPBANCA', 96795980, 1, 794, '20100517'
 Insert #Contratos_Marco select 'CORPBANCA', 96798550, 1, 385, '20080611'
 Insert #Contratos_Marco select 'CORPBANCA', 96798550, 1, 1078, '20110420'
 Insert #Contratos_Marco select 'CORPBANCA', 96802690, 1, 44, '19990211'
 Insert #Contratos_Marco select 'CORPBANCA', 96802690, 1, 1128, '20110614'
 Insert #Contratos_Marco select 'CORPBANCA', 96806130, 1, 751, '20100330'
 Insert #Contratos_Marco select 'CORPBANCA', 96806980, 1, 416, '20070608'
 Insert #Contratos_Marco select 'CORPBANCA', 96807990, 1, 525, '20090128'
 Insert #Contratos_Marco select 'CORPBANCA', 96812740, 1, 466, '20081016'
 Insert #Contratos_Marco select 'CORPBANCA', 96812840, 1, 146, '20030703'
 Insert #Contratos_Marco select 'CORPBANCA', 96812960, 1, 705, '20091216'
 Insert #Contratos_Marco select 'CORPBANCA', 96815280, 1, 720, '20100122'
 Insert #Contratos_Marco select 'CORPBANCA', 96815970, 1, 287, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96816640, 1, 1443, '20120604'
 Insert #Contratos_Marco select 'CORPBANCA', 96816800, 1, 72, '20000906'
 Insert #Contratos_Marco select 'CORPBANCA', 96821540, 1, 200, '20050926'
 Insert #Contratos_Marco select 'CORPBANCA', 96821540, 1, 1175, '20110822'
 Insert #Contratos_Marco select 'CORPBANCA', 96821790, 1, 792, '20100427'
 Insert #Contratos_Marco select 'CORPBANCA', 96821890, 1, 1295, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 96823020, 1, 903, '20101001'
 Insert #Contratos_Marco select 'CORPBANCA', 96824300, 1, 1470, '20110905'
 Insert #Contratos_Marco select 'CORPBANCA', 96827010, 1, 68, '20000427'
 Insert #Contratos_Marco select 'CORPBANCA', 96831560, 1, 528, '20080505'
 Insert #Contratos_Marco select 'CORPBANCA', 96831560, 1, 899, '20100910'
 Insert #Contratos_Marco select 'CORPBANCA', 96834910, 1, 842, '20100727'
 Insert #Contratos_Marco select 'CORPBANCA', 96847540, 1, 1111, '20110516'
 Insert #Contratos_Marco select 'CORPBANCA', 96849540, 1, 706, '20091130'
 Insert #Contratos_Marco select 'CORPBANCA', 96850510, 1, 1146, '20110706'
 Insert #Contratos_Marco select 'CORPBANCA', 96850960, 1, 1419, '20120504'
 Insert #Contratos_Marco select 'CORPBANCA', 96851680, 1, 1192, '20110915'
 Insert #Contratos_Marco select 'CORPBANCA', 96854480, 1, 717, '20091104'
 Insert #Contratos_Marco select 'CORPBANCA', 96854790, 1, 1489, '20120726'
 Insert #Contratos_Marco select 'CORPBANCA', 96856360, 1, 1148, '20110719'
 Insert #Contratos_Marco select 'CORPBANCA', 96858900, 1, 81, '20010425'
 Insert #Contratos_Marco select 'CORPBANCA', 96858900, 1, 637, '20090909'
 Insert #Contratos_Marco select 'CORPBANCA', 96862280, 1, 1241, '20110620'
 Insert #Contratos_Marco select 'CORPBANCA', 96863090, 1, 850, '20100811'
 Insert #Contratos_Marco select 'CORPBANCA', 96869030, 1, 404, '20080708'
 Insert #Contratos_Marco select 'CORPBANCA', 96870450, 1, 511, '20081217'
 Insert #Contratos_Marco select 'CORPBANCA', 96871970, 1, 1345, '20120112'
 Insert #Contratos_Marco select 'CORPBANCA', 96872220, 1, 99, '20011106'
 Insert #Contratos_Marco select 'CORPBANCA', 96874030, 1, 108, '20020429'
 Insert #Contratos_Marco select 'CORPBANCA', 96875220, 1, 1478, '20120710'
 Insert #Contratos_Marco select 'CORPBANCA', 96876690, 1, 719, '20100118'
 Insert #Contratos_Marco select 'CORPBANCA', 96876690, 1, 952, '20101123'
 Insert #Contratos_Marco select 'CORPBANCA', 96877150, 1, 206, '20051124'
 Insert #Contratos_Marco select 'CORPBANCA', 96877150, 1, 1090, '20101021'
 Insert #Contratos_Marco select 'CORPBANCA', 96877940, 1, 959, '20101126'
 Insert #Contratos_Marco select 'CORPBANCA', 96878900, 1, 55, '19991104'
 Insert #Contratos_Marco select 'CORPBANCA', 96883950, 1, 1048, '20110324'
 Insert #Contratos_Marco select 'CORPBANCA', 96884060, 1, 734, '20100210'
 Insert #Contratos_Marco select 'CORPBANCA', 96884560, 1, 492, '20081024'
 Insert #Contratos_Marco select 'CORPBANCA', 96884560, 1, 1441, '20120528'
 Insert #Contratos_Marco select 'CORPBANCA', 96885610, 1, 116, '20020905'
 Insert #Contratos_Marco select 'CORPBANCA', 96886110, 1, 203, '20051006'
 Insert #Contratos_Marco select 'CORPBANCA', 96889950, 1, 881, '20100830'
 Insert #Contratos_Marco select 'CORPBANCA', 96894180, 1, 936, '20101029'
 Insert #Contratos_Marco select 'CORPBANCA', 96896010, 1, 1033, '20110209'
 Insert #Contratos_Marco select 'CORPBANCA', 96900690, 1, 316, '20080118'
 Insert #Contratos_Marco select 'CORPBANCA', 96900690, 1, 949, '20101111'
 Insert #Contratos_Marco select 'CORPBANCA', 96900720, 1, 1052, '20110323'
 Insert #Contratos_Marco select 'CORPBANCA', 96902610, 1, 159, '20040126'
 Insert #Contratos_Marco select 'CORPBANCA', 96908870, 1, 75, '20001030'
 Insert #Contratos_Marco select 'CORPBANCA', 96908870, 1, 325, '20080118'
 Insert #Contratos_Marco select 'CORPBANCA', 96908930, 1, 556, '20090310'
 Insert #Contratos_Marco select 'CORPBANCA', 96908970, 1, 555, '20090310'
 Insert #Contratos_Marco select 'CORPBANCA', 96911210, 1, 338, '20080303'
 Insert #Contratos_Marco select 'CORPBANCA', 96912440, 1, 279, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96913600, 1, 547, '20090310'
 Insert #Contratos_Marco select 'CORPBANCA', 96915150, 1, 622, '20090615'
 Insert #Contratos_Marco select 'CORPBANCA', 96915150, 1, 943, '20101125'
 Insert #Contratos_Marco select 'CORPBANCA', 96915330, 1, 412, '20080723'
 Insert #Contratos_Marco select 'CORPBANCA', 96915330, 1, 1156, '20110808'
 Insert #Contratos_Marco select 'CORPBANCA', 96918600, 1, 381, '20080609'
 Insert #Contratos_Marco select 'CORPBANCA', 96919420, 1, 1266, '20110516'
 Insert #Contratos_Marco select 'CORPBANCA', 96924340, 1, 897, '20100923'
 Insert #Contratos_Marco select 'CORPBANCA', 96925710, 1, 666, '20091007'
 Insert #Contratos_Marco select 'CORPBANCA', 96925710, 1, 1056, '20110321'
 Insert #Contratos_Marco select 'CORPBANCA', 96928930, 1, 431, '20080828'
 Insert #Contratos_Marco select 'CORPBANCA', 96929050, 1, 100, '20011108'
 Insert #Contratos_Marco select 'CORPBANCA', 96929830, 1, 1506, '20120723'
 Insert #Contratos_Marco select 'CORPBANCA', 96929910, 1, 288, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96931150, 1, 280, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96934740, 1, 217, '20060202'
 Insert #Contratos_Marco select 'CORPBANCA', 96934740, 1, 963, '20101130'
 Insert #Contratos_Marco select 'CORPBANCA', 96935960, 1, 509, '20081218'
 Insert #Contratos_Marco select 'CORPBANCA', 96936470, 1, 582, '20090529'
 Insert #Contratos_Marco select 'CORPBANCA', 96938990, 1, 988, '20110104'
 Insert #Contratos_Marco select 'CORPBANCA', 96939100, 1, 1016, '20110224'
 Insert #Contratos_Marco select 'CORPBANCA', 96940680, 1, 589, '20090604'
 Insert #Contratos_Marco select 'CORPBANCA', 96942870, 1, 1369, '20120202'
 Insert #Contratos_Marco select 'CORPBANCA', 96943160, 1, 1504, '20120802'
 Insert #Contratos_Marco select 'CORPBANCA', 96943850, 1, 1036, '20110308'
 Insert #Contratos_Marco select 'CORPBANCA', 96945520, 1, 732, '20100212'
 Insert #Contratos_Marco select 'CORPBANCA', 96948490, 1, 680, '20091023'
 Insert #Contratos_Marco select 'CORPBANCA', 96948490, 1, 1046, '20110110'
 Insert #Contratos_Marco select 'CORPBANCA', 96959630, 1, 758, '20100311'
 Insert #Contratos_Marco select 'CORPBANCA', 96962540, 1, 313, '20080118'
 Insert #Contratos_Marco select 'CORPBANCA', 96962540, 1, 1361, '20120127'
 Insert #Contratos_Marco select 'CORPBANCA', 96963250, 1, 1055, '20110324'
 Insert #Contratos_Marco select 'CORPBANCA', 96963660, 1, 1224, '20110923'
 Insert #Contratos_Marco select 'CORPBANCA', 96966160, 1, 661, '20091015'
 Insert #Contratos_Marco select 'CORPBANCA', 96971300, 1, 836, '20100621'
 Insert #Contratos_Marco select 'CORPBANCA', 96972530, 1, 336, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 96972530, 1, 971, '20101126'
 Insert #Contratos_Marco select 'CORPBANCA', 96972870, 1, 747, '20100324'
 Insert #Contratos_Marco select 'CORPBANCA', 96973290, 1, 1512, '20120803'
 Insert #Contratos_Marco select 'CORPBANCA', 96973910, 1, 1343, '20120110'
 Insert #Contratos_Marco select 'CORPBANCA', 96975090, 1, 1288, '20111024'
 Insert #Contratos_Marco select 'CORPBANCA', 96976720, 1, 1116, '20110517'
 Insert #Contratos_Marco select 'CORPBANCA', 96984230, 1, 243, '20060929'
 Insert #Contratos_Marco select 'CORPBANCA', 96984230, 1, 777, '20100322'
 Insert #Contratos_Marco select 'CORPBANCA', 96985370, 1, 1086, '20110427'
 Insert #Contratos_Marco select 'CORPBANCA', 96986630, 1, 1370, '20120209'
 Insert #Contratos_Marco select 'CORPBANCA', 96988910, 1, 1197, '20110906'
 Insert #Contratos_Marco select 'CORPBANCA', 96990150, 1, 114, '20020813'
 Insert #Contratos_Marco select 'CORPBANCA', 96997470, 1, 623, '20090618'
 Insert #Contratos_Marco select 'CORPBANCA', 96998260, 1, 208, '20051212'
 Insert #Contratos_Marco select 'CORPBANCA', 96998260, 1, 580, '20090515'
 Insert #Contratos_Marco select 'CORPBANCA', 96998260, 1, 1533, '20120913'
 Insert #Contratos_Marco select 'CORPBANCA', 96998510, 1, 779, '20100407'
 Insert #Contratos_Marco select 'CORPBANCA', 96999710, 1, 166, '20040519'
 Insert #Contratos_Marco select 'CORPBANCA', 96999710, 1, 1253, '20111011'
 Insert #Contratos_Marco select 'CORPBANCA', 96999930, 1, 1053, '20110111'
 Insert #Contratos_Marco select 'CORPBANCA', 97003000, 1, 221, '20060321'
 Insert #Contratos_Marco select 'CORPBANCA', 97004000, 1, 101, '20011018'
 Insert #Contratos_Marco select 'CORPBANCA', 97004000, 1, 298, '20071206'
 Insert #Contratos_Marco select 'CORPBANCA', 97005000, 1, 128, '20021119'
 Insert #Contratos_Marco select 'CORPBANCA', 97006000, 1, 37, '19980929'
 Insert #Contratos_Marco select 'CORPBANCA', 97006000, 1, 38, '19980929'
 Insert #Contratos_Marco select 'CORPBANCA', 97006000, 1, 245, '20061010'
 Insert #Contratos_Marco select 'CORPBANCA', 97006000, 1, 275, '20071029'
 Insert #Contratos_Marco select 'CORPBANCA', 97006000, 1, 660, '20090430'
 Insert #Contratos_Marco select 'CORPBANCA', 97008000, 1, 45, '19990215'
 Insert #Contratos_Marco select 'CORPBANCA', 97008000, 1, 130, '20021128'
 Insert #Contratos_Marco select 'CORPBANCA', 97008000, 1, 261, '20070822'
 Insert #Contratos_Marco select 'CORPBANCA', 97011000, 1, 197, '20050728'
 Insert #Contratos_Marco select 'CORPBANCA', 97015000, 1, 112, '20011206'
 Insert #Contratos_Marco select 'CORPBANCA', 97018000, 1, 138, '20030106'
 Insert #Contratos_Marco select 'CORPBANCA', 97018000, 1, 247, '20061019'
 Insert #Contratos_Marco select 'CORPBANCA', 97030000, 1, 117, '20020820'
 Insert #Contratos_Marco select 'CORPBANCA', 97030000, 1, 307, '20071109'
 Insert #Contratos_Marco select 'CORPBANCA', 97032000, 1, 121, '20020924'
 Insert #Contratos_Marco select 'CORPBANCA', 97036000, 1, 36, '19980924'
 Insert #Contratos_Marco select 'CORPBANCA', 97036000, 1, 266, '20070606'
 Insert #Contratos_Marco select 'CORPBANCA', 97036000, 1, 348, '20070606'
 Insert #Contratos_Marco select 'CORPBANCA', 97041000, 1, 22, '19971202'
 Insert #Contratos_Marco select 'CORPBANCA', 97043000, 1, 7, '19970403'
 Insert #Contratos_Marco select 'CORPBANCA', 97043000, 1, 183, '20041117'
 Insert #Contratos_Marco select 'CORPBANCA', 97043000, 1, 265, '20070626'
 Insert #Contratos_Marco select 'CORPBANCA', 97050000, 1, 20, '19971118'
 Insert #Contratos_Marco select 'CORPBANCA', 97051000, 1, 122, '20020903'
 Insert #Contratos_Marco select 'CORPBANCA', 97051000, 1, 359, '20071109'
 Insert #Contratos_Marco select 'CORPBANCA', 97053000, 1, 212, '20060102'
 Insert #Contratos_Marco select 'CORPBANCA', 97053000, 1, 291, '20071126'
 Insert #Contratos_Marco select 'CORPBANCA', 97080000, 1, 118, '20020830'
 Insert #Contratos_Marco select 'CORPBANCA', 97080000, 1, 292, '20071203'
 Insert #Contratos_Marco select 'CORPBANCA', 97919000, 1, 175, '20040914'
 Insert #Contratos_Marco select 'CORPBANCA', 97919000, 1, 267, '20070705'
 Insert #Contratos_Marco select 'CORPBANCA', 97951000, 1, 147, '20030902'
 Insert #Contratos_Marco select 'CORPBANCA', 97952000, 1, 236, '20060829'
 Insert #Contratos_Marco select 'CORPBANCA', 98000000, 1, 192, '20050104'
 Insert #Contratos_Marco select 'CORPBANCA', 98000000, 1, 604, '20080612'
 Insert #Contratos_Marco select 'CORPBANCA', 98000100, 1, 165, '20040316'
 Insert #Contratos_Marco select 'CORPBANCA', 98000400, 1, 34, '20031006'
 Insert #Contratos_Marco select 'CORPBANCA', 98000600, 1, 184, '20040505'
 Insert #Contratos_Marco select 'CORPBANCA', 98000900, 1, 140, '20030115'
 Insert #Contratos_Marco select 'CORPBANCA', 98001000, 1, 145, '20030624'
 Insert #Contratos_Marco select 'CORPBANCA', 98001000, 1, 235, '20060822'
 Insert #Contratos_Marco select 'CORPBANCA', 98001200, 1, 148, '20030820'
 Insert #Contratos_Marco select 'CORPBANCA', 98001200, 1, 148, '20040316'
 Insert #Contratos_Marco select 'CORPBANCA', 98001200, 1, 704, '20091214'
 Insert #Contratos_Marco select 'CORPBANCA', 99012000, 1, 102, '20011218'
 Insert #Contratos_Marco select 'CORPBANCA', 99037000, 1, 1503, '20120705'
 Insert #Contratos_Marco select 'CORPBANCA', 99279000, 1, 170, '20040226'
 Insert #Contratos_Marco select 'CORPBANCA', 99301000, 1, 654, '20090903'
 Insert #Contratos_Marco select 'CORPBANCA', 99301000, 1, 1268, '20111012'
 Insert #Contratos_Marco select 'CORPBANCA', 99505030, 1, 1473, '20120625'
 Insert #Contratos_Marco select 'CORPBANCA', 99507430, 1, 520, '20090112'
 Insert #Contratos_Marco select 'CORPBANCA', 99508750, 1, 158, '20040107'
 Insert #Contratos_Marco select 'CORPBANCA', 99508830, 1, 1289, '20111006'
 Insert #Contratos_Marco select 'CORPBANCA', 99509340, 1, 341, '20071001'
 Insert #Contratos_Marco select 'CORPBANCA', 99510380, 1, 1348, '20111124'
 Insert #Contratos_Marco select 'CORPBANCA', 99511240, 1, 256, '20070504'
 Insert #Contratos_Marco select 'CORPBANCA', 99511240, 1, 414, '20080506'
 Insert #Contratos_Marco select 'CORPBANCA', 99289000, 1, 194, '20050502'
 Insert #Contratos_Marco select 'CORPBANCA', 99289000, 1, 1298, '20111028'
 Insert #Contratos_Marco select 'CORPBANCA', 99517580, 1, 445, '20080813'
 Insert #Contratos_Marco select 'CORPBANCA', 99522670, 1, 383, '20080611'
 Insert #Contratos_Marco select 'CORPBANCA', 99527980, 1, 435, '20080730'
 Insert #Contratos_Marco select 'CORPBANCA', 99529560, 1, 302, '20070906'
 Insert #Contratos_Marco select 'CORPBANCA', 99529970, 1, 459, '20080820'
 Insert #Contratos_Marco select 'CORPBANCA', 99530480, 1, 363, '20080512'
 Insert #Contratos_Marco select 'CORPBANCA', 99530480, 1, 1207, '20110922'
 Insert #Contratos_Marco select 'CORPBANCA', 99534380, 1, 310, '20080114'
 Insert #Contratos_Marco select 'CORPBANCA', 99534380, 1, 1068, '20110406'
 Insert #Contratos_Marco select 'CORPBANCA', 99537780, 1, 258, '20070914'
 Insert #Contratos_Marco select 'CORPBANCA', 99537780, 1, 1545, '20121002'
 Insert #Contratos_Marco select 'CORPBANCA', 99542450, 1, 178, '20041005'
 Insert #Contratos_Marco select 'CORPBANCA', 99544140, 1, 199, '20050906'
 Insert #Contratos_Marco select 'CORPBANCA', 99546550, 1, 731, '20100212'
 Insert #Contratos_Marco select 'CORPBANCA', 99547700, 1, 376, '20080604'
 Insert #Contratos_Marco select 'CORPBANCA', 99549220, 1, 1104, '20110420'
 Insert #Contratos_Marco select 'CORPBANCA', 99556090, 1, 1424, '20120410'
 Insert #Contratos_Marco select 'CORPBANCA', 99556170, 1, 1409, '20120405'
 Insert #Contratos_Marco select 'CORPBANCA', 99561010, 1, 226, '20060524'
 Insert #Contratos_Marco select 'CORPBANCA', 99561010, 1, 0, '20090225'
 Insert #Contratos_Marco select 'CORPBANCA', 99561030, 1, 0, '20090225'
 Insert #Contratos_Marco select 'CORPBANCA', 99561040, 1, 0, '20090225'
 Insert #Contratos_Marco select 'CORPBANCA', 99561050, 1, 583, '20090527'
 Insert #Contratos_Marco select 'CORPBANCA', 99564820, 1, 481, '20081027'
 Insert #Contratos_Marco select 'CORPBANCA', 99564820, 1, 1404, '20120307'
 Insert #Contratos_Marco select 'CORPBANCA', 99565090, 1, 997, '20110117'
 Insert #Contratos_Marco select 'CORPBANCA', 99566010, 1, 1114, '20110519'
 Insert #Contratos_Marco select 'CORPBANCA', 99572590, 1, 635, '20090909'
 Insert #Contratos_Marco select 'CORPBANCA', 99575520, 1, 1242, '20110810'
 Insert #Contratos_Marco select 'CORPBANCA', 99575940, 1, 187, '20050224'
 Insert #Contratos_Marco select 'CORPBANCA', 99575940, 1, 581, '20090430'
 Insert #Contratos_Marco select 'CORPBANCA', 99575940, 1, 915, '20100929'
 Insert #Contratos_Marco select 'CORPBANCA', 99576080, 1, 399, '20080704'
 Insert #Contratos_Marco select 'CORPBANCA', 99576080, 1, 1249, '20111012'
 Insert #Contratos_Marco select 'CORPBANCA', 99576130, 1, 569, '20090422'
 Insert #Contratos_Marco select 'CORPBANCA', 99576130, 1, 852, '20100719'
 Insert #Contratos_Marco select 'CORPBANCA', 99577480, 1, 506, '20081211'
 Insert #Contratos_Marco select 'CORPBANCA', 99579730, 1, 1413, '20120413'
 Insert #Contratos_Marco select 'CORPBANCA', 99580610, 1, 608, '20090331'
 Insert #Contratos_Marco select 'CORPBANCA', 99584590, 1, 919, '20100927'
 Insert #Contratos_Marco select 'CORPBANCA', 99587580, 1, 1367, '20120207'
 Insert #Contratos_Marco select 'CORPBANCA', 99589040, 1, 1100, '20110503'
 Insert #Contratos_Marco select 'CORPBANCA', 99593260, 1, 679, '20091104'
 Insert #Contratos_Marco select 'CORPBANCA', 99595990, 1, 450, '20080925'
 Insert #Contratos_Marco select 'CORPBANCA', 99595990, 1, 955, '20101112'
 Insert #Contratos_Marco select 'CORPBANCA', 99598300, 1, 862, '20100812'
 Insert #Contratos_Marco select 'CORPBANCA', 200015041, 1, 788, '20100517'
 Insert #Contratos_Marco select 'CORPBANCA', 47005194, 1, 0, '20070613'
 Insert #Contratos_Marco select 'CORPBANCA', 411885828, 1, 0, '20020130'
 Insert #Contratos_Marco select 'CORPBANCA', 413045828, 1, 0, '20060928'
 Insert #Contratos_Marco select 'CORPBANCA', 452612276, 1, 0, '20020130'
 Insert #Contratos_Marco select 'CORPBANCA', 472655828, 1, 0, '20070613'
 
  create index I#Contratos_Marco ON #Contratos_Marco
               ( COD_EMP, ID_CLI_EMP, ID_CLI_CODIGO_EMP, Fecha_CG )

-- Clientes Relacionados
 
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 076071932, 1, 'CORP REC S A', '00' , '', 2, 'I02', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 076123474, 1, 'FONDO DE INVERSION PRIVADO CCHCE', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 076123476, 1, 'FONDO DE INVERSION PRIVADO CCHCA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 076123477, 1, 'FONDO DE INVERSION PRIVADO RED SOCIAL', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 076123478, 1, 'FONDO DE INVERSION PRIVADO CCHCC', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 076645030, 1, 'BANCO ITAU POR CUENTA DE INVERSIONISTAS', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 077534620, 1, 'INMOBILIARIA E INVERSIONES QUEVEDO CALLEJAS LTDA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 079879480, 1, 'INMOB E INVERSIONES BOQUINENI LTDA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 080537000, 1, 'LARRAIN VIAL S A CORREDORA DE BOLSA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 081537600, 1, 'RENDIC HERMANOS S A', '00' , '', 2, 'I02', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 084177300, 1, 'CELFIN CAPITAL S A C DE B', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 086547900, 1, 'VINA SANTA RITA', '10' , 'Sociedad en que un director o apoderado general tiene participación > a 5%', 2, 'I03', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 090227000, 1, 'VINA CONCHA Y TORO SA', '00' , '', 2, 'I02', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096511460, 1, 'CONSTRUMART SA', '00' , '', 2, 'I02', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096515580, 1, 'VALORES SECURITY S A C DE B', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096530900, 1, 'FONDO MUTUO BCI ACCIONES PRESENCIA BURSATIL', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096541340, 1, 'HOTEL CORPORATION CHILE SA', '00' , '', 2, 'I02', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096579280, 1, 'CN LIFE COMPANIA DE SEGUROS DE VIDA SA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096628780, 1, 'CIADE SEGUROS DE VIDA CRUZ DEL SUR SA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096639280, 1, 'ADM GENERAL DE FONDOS SECURITY S A', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096656410, 1, 'BICE VIDA COMPANIA DE SEGUROS SA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 96665450, 1, 'CORPBANCA CORREDORES DE BOLSA S.A.', '00' , '', 1, 'Filiales Memoria 2011', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096767630, 1, 'BANCHILE ADM GENERAL DE FONDOS S A', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096772490, 1, 'CONSORCIO C DE B S A', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096858900, 1, 'CORP GROUP BANKING SA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 096963660, 1, 'HOSPITAL CLINICO VI A DEL MAR S A', '00' , '', 2, 'I02', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 097004000, 1, 'BANCO DE CHILE POR CUENTA DE TERCEROS NO RESIDENTE', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 097036000, 1, 'BANCO SANTANDER CHILE', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 098000000, 1, 'AFP CAPITAL S A', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 098000100, 1, 'AFP HABITAT SA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 098000400, 1, 'AFP PROVIDA S A', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 098001000, 1, 'AFP CUPRUM S A', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 098001200, 1, 'AFP PLANVITAL S A', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 099012000, 1, 'CIA DE SEGUROS DE VIDA CONSORCIO NACIONAL DE SEGUR', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 099279000, 1, 'EUROAMERICA SEGUROS DE VIDA SA', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 099289000, 1, 'METLIFE CHILE SEGUROS DE VIDA S A', '00' , '', 1, 'I01', 1
 Insert into #Rut_relacionados Select  201201, 'CORPBANCA', 099558780, 1, 'PENTA ADMINISTRADORA GENERAL DE FONDOS', '00' , '', 1, 'I01', 1

/**********************************************
  Pagos reales para SWAP y FORWARD
**********************************************/
Create table #Pagos ( Id_sistema Varchar(3), Numero_operacion numeric(10), Fecha Datetime , Monto_CLP numeric(20) )

CREATE INDEX #IPagos ON #Pagos ( Id_sistema, Numero_operacion, Fecha ) 

   SELECT vmfecha, vmcodigo, vmvalor  = convert( float, vmvalor )
   INTO #Valor_Moneda  
   FROM   BacParamSuda..VALOR_MONEDA  WITH(NOLOCK) WHERE DATEPART(year ,vmfecha)= year(@FechaCorteFinal)
  
   INSERT INTO #Valor_Moneda   
   SELECT vmfecha, 999, 1.0  
   FROM   #VALOR_MONEDA         
   WHERE  vmcodigo = 998  
  
   INSERT INTO #Valor_Moneda   
   SELECT vmfecha, 13, vmvalor   
   FROM   #VALOR_MONEDA  
   WHERE  vmcodigo = 994  
  
  
   DELETE #Valor_Moneda  
   WHERE vmcodigo = 13 and vmvalor = 0 

   SELECT *
   INTO #CarteraHis 
   FROM  BacSwapSuda..CarteraHis with(nolock)  
   WHERE DATEPART(year ,FechaLiquidacion) = year(@FechaCorteFinal)   
   and   estado <> 'C' -- Cotizaciones
   and   estado <> 'N' -- Anticipados

-- Ajustar/Corregir Inicio
   SELECT Id_Sisitema		    = 'PCS'
     , Fecha_Liquidacion        = a.FechaLiquidacion	     
     , Operacion				= a.numero_operacion 
     , Amortización_Recibimos	= a.compra_amortiza
     , IntercambioNoc_Recibimos = a.IntercPrinc
     , Interes_Recibimos        = a.compra_interes
     , Compra_Flujo_Adicional   = a.Compra_Flujo_Adicional
     , Amortización_Pagamos	    = CONVERT(FLOAT, 0.0)
     , IntercambioNoc_Pagamos   = a.IntercPrinc
     , Interes_Pagamos          = CONVERT(FLOAT, 0.0)
     , Venta_Flujo_Adicional    = CONVERT(FLOAT, 0.0)
     , Moneda_Activa            = a.compra_moneda
     , TCMMdaActiva             = ISNULL(vmv.vmvalor, 0.0)  
     , TCMMdaPagRecib           = ISNULL(vmvPago.vmvalor, 0.0)  
     , Moneda_Pasiva            = 0   
     , TCMMdaPasiva             = CONVERT(FLOAT, 0.0)
     , TCMMdaPagPagam           = CONVERT(FLOAT, 0.0)  
     , Modalidad				= a.modalidad_pago	
     , Monto_Flujo_Rec         = (CASE WHEN a.tipo_swap = 3   THEN a.Compra_interes / ( 1 + DATEDIFF(DAY,a.Fecha_Inicio_Flujo,a.Fecha_Vence_Flujo)/ 360.0 * a.compra_mercado_tasa / 100.0 )  
                                      WHEN a.Estado   = 'N' THEN a.Recibimos_Monto  
                                      ELSE a.Compra_Interes + a.Compra_Amortiza * a.intercprinc + a.Compra_Flujo_Adicional  
                                 END)   
  
                                 * (CASE WHEN estado <> 'N' THEN (CASE WHEN a.Recibimos_Moneda <> a.compra_moneda THEN ISNULL(vmv.vmvalor, 0.0)   
                                                                       ELSE 1.0   
                                                                  END)   
                                 / (CASE WHEN a.Recibimos_Moneda <> a.compra_moneda and  vmvPago.vmvalor <> 0 THEN ISNULL( vmvPago.vmvalor, 0.0 )   
                                         ELSE 1.0  
                 END)  
                             ELSE 1.0 END)  
     , Monto_Flujo_Pag         = CONVERT(FLOAT, 0.0)
     , Monto_Compensado        = CONVERT(FLOAT, 0.0)
     , MontoCLP				   = CONVERT(FLOAT, 0.0)
     , Tipo_Swap     
     , chi_Cartera_Normativa  
     , Recibimos_moneda        
     , Pagamos_Moneda = convert( numeric(5), 0.0 )
     , Modalidad_Pago  
    INTO #ACT
    FROM  #CarteraHis  a
          LEFT JOIN #Valor_Moneda    vmv ON vmv.vmcodigo = a.Compra_Moneda and vmv.vmfecha = a.fechaliquidacion   
          LEFT JOIN #Valor_Moneda    vmvPago ON vmvPago.vmcodigo = a.Recibimos_Moneda and vmvPago.vmfecha = a.fechaliquidacion   
    WHERE DATEPART(year ,a.FechaLiquidacion) = year(@FechaCorteFinal) 
    AND   a.tipo_flujo = 1

    SELECT Id_Sisitema			= 'PCS'     
     , Fecha_Liquidacion        = a.FechaLiquidacion
     , Operacion				= a.numero_operacion 
     , Amortización_Recibimos	= 0.0
     , IntercambioNoc_Recibimos = 0.0
     , Interes_Recibimos        = 0.0
     , Compra_Flujo_Adicional   = 0.0
     , Amortización_Pagamos	    = a.venta_amortiza
     , IntercambioNoc_Pagamos   = a.IntercPrinc
     , Interes_Pagamos          = a.venta_interes 
     , Venta_Flujo_Adicional    = a.venta_Flujo_Adicional
     , Moneda_Activa            = 0 
     , TCMMdaActiva             = 0.0
     , TCMMdaPagRecib           = 0.0
     , Moneda_Pasiva            = a.venta_moneda
     , TCMMdaPasiva             = ISNULL(vmv.vmvalor, 0.0)  
     , TCMMdaPagPagam           = ISNULL(vmvPago.vmValor, 0.0)  
     , Modalidad				= a.modalidad_pago	
     , Monto_Flujo_Rec         = 0.0
     , Monto_Flujo_Pag         = (CASE WHEN a.tipo_swap = 3   THEN a.Venta_interes / ( 1 + DATEDIFF(DAY,a.Fecha_Inicio_Flujo,a.Fecha_Vence_Flujo)/ 360.0 * a.Venta_mercado_tasa / 100.0 )   
                                      WHEN a.Estado   = 'N' THEN a.pagamos_monto --> 0.0   
                                      ELSE a.Venta_Interes + a.Venta_Amortiza * a.intercprinc + a.Venta_Flujo_Adicional            -- Flujo Adicional MAP 20090211  
                                 END) * (case when a.Pagamos_Moneda <> a.venta_moneda then ISNULL( vmv.vmvalor, 0.0 )   
                                              else 1.0 end )  
                                      / (case when a.Pagamos_Moneda <> a.venta_moneda and  vmvPago.vmvalor <> 0  
                                              then  isnull( vmvPago.vmvalor, 0.0 )   
                                              else 1.0 end )  
  
     , Monto_Compensado        = 0.0
     , MontoCLP				   = 0.0
     , Tipo_Swap    
     , chi_Cartera_Normativa   
     , Recibimos_moneda        = convert( numeric(5), 0.0 )
     , Pagamos_Moneda 
     , Modalidad_Pago  
    INTO #PAS
    FROM  #CarteraHis  a
			LEFT JOIN #Valor_Moneda  vmv ON vmv.vmcodigo = a.Venta_Moneda and vmv.vmfecha = a.fechaliquidacion   
			LEFT JOIN #Valor_Moneda  vmvPago ON vmvPago.vmcodigo = a.Pagamos_Moneda and vmvPago.vmfecha = a.fechaliquidacion   
    WHERE DATEPART(year ,a.FechaLiquidacion) = year(@FechaCorteFinal)  
    AND   a.tipo_flujo = 2

    SELECT  *  
    INTO #RESULT
    FROM #ACT

    UPDATE  #RESULT
    SET   Fecha_Liquidacion        = #PAS.Fecha_Liquidacion 
     , Amortización_Pagamos	    = #PAS.Amortización_Pagamos 
     , IntercambioNoc_Pagamos   = #PAS.IntercambioNoc_Pagamos
     , Interes_Pagamos          = #PAS.Interes_Pagamos 
     , Venta_Flujo_Adicional    = #PAS.Venta_Flujo_Adicional 
     , Moneda_Pasiva            = #PAS.Moneda_Pasiva 
     , TCMMdaPasiva				= #PAS.TCMMdaPasiva
     , TCMMdaPagPagam			= #PAS.TCMMdaPagPagam
	 , Monto_Flujo_Pag			= #PAS.Monto_Flujo_Pag
     , Pagamos_Moneda           = #PAS.Pagamos_Moneda
    FROM #PAS 
    WHERE #RESULT.Operacion = #PAS.Operacion
    and   #RESULT.Fecha_Liquidacion = #PAS.Fecha_Liquidacion

   Insert into #Result
   select * from #PAS
   where #PAS.Fecha_Liquidacion not in ( select Fecha_liquidacion 
                                       from #ACT where #ACT.Operacion = #PAS.Operacion 
                                                   and #ACT.Fecha_liquidacion = #PAS.Fecha_liquidacion )
   -- Calculo cuando ya están todos los flujos juntos
   update #RESULT 
   Set
       Monto_Compensado         = Monto_Flujo_Rec - Monto_Flujo_Pag  
     , MontoCLP                 = Round (Monto_Flujo_Rec * TCMMdaPagRecib - Monto_Flujo_Pag * TCMMdaPagPagam,0)

   -- Ajustes indicados por el usuario
   CREATE TABLE #PAGOS_AJUSTES_DERIVADOS ( Id_Sistema Varchar(3), Numero_operacion numeric(13), Fecha_liquidacion datetime, MontoCLP numeric(20,4), Modalidad Varchar(1) )

   ---- Año 2014 
   -- Mes: Enero
   -- Cuenta: Par 32-32
   -- Bac no recalculó el ICP por Vcto. flujo en feriado, Bac usa el valor UF de fecha liquidacion. Bco chile Cambio
   -- Fecha de vencimiento de flujo a la fecha habil.
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2272, '20140102', 233262434 - 233262434 + 234858708 , 'C'  
   -- Bac no recalculó el ICP por Vcto. flujo en feriado, Bac usa el valor UF de fecha liquidacion. Bco Santander.
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2323, '20140102', 202952193 - 202952193 + 209288856 , 'C'  
   
   -- Fecha inicio flujo y vence flujo distintas. Bco BBVA.
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2302, '20140102', 166092245 - 166092245 + 169857969 , 'C'  

   -- Bac no recalculó el ICP por Vcto. flujo en feriado, Bac usa el valor UF de fecha liquidacion. Bco Santander.
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2984, '20140102', 135337040 - 135337040 + 141682403 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2674, '20140102', 106976601 - 106976601 + 111416780 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2722, '20140102', 81657862 - 81657862 + 84828744 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2786, '20140102', 75828970 - 75828970 + 79000601 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2604, '20140102', 74080302 - 74080302 + 77252159 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2597, '20140102', 70000077 - 70000077 + 73172459, 'C' 
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2620, '20140102', 67668520 - 67668520 + 70841202, 'C' 
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2983, '20140102', 64171185 - 64171185 + 67344316, 'C' 

   -- Fecha inicio flujo y vence flujo distintas. Bco Chile.
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2643, '20140102', 97184061 - 97184061 + 98301455 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2624, '20140102', 67085631 - 67085631 + 67883768 , 'C'  

   -- No se pudo inferir la razón de la diferencia. Bco. BCI
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2684, '20140102', 76994748 - 76994748 + 76079277 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2717, '20140102', 76411859 - 76411859 + 75496463 , 'C'
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2647, '20140102', 69417188 - 69417188 + 68502692 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2822, '20140102', 44448180 - 44448180 + 43899123 , 'C'  

   -- Bac no recalculó el ICP por Vcto. flujo en feriado, Bac usa el valor UF de fecha liquidacion. Bco BCI.
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2598, '20140102', 70000077 - 70000077 + 69085506 , 'C'  
   ---- Aplica las correciones insertadas en la tabla temporal anterior

   -- Mes: Enero
   -- Cuenta: Par 28-28
   -- Cálculos de ICP y conversión UF.
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2142, '20140102', - 219286338 + 219286338 - 221519326 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 7067, '20140120', 197681250 - 197681250 + 193748250 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 7066, '20140120', 191126250 - 191126250 + 187193250 , 'C'  

   -- Mes: Enero
   -- Cuenta: Par 31-31
   -- Calculode ICP Nominal (TNA) con 4 decimales DEUTSCHE BANK AG.
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 7316, '20140130', 0 - 0 + -2557 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 7314, '20140130', 0 - 0 + -10222 , 'C'  

   -- Mes: Febrero
-- TRANF. TABLA   Insert Insert into #Pagos_Ajustes_Derivados Select 'PCS', 7955, '20140203', -36239703 + 36239703 + -37868500 , 'C'  

   -- Mes: Marzo
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 798, '20140319', -3250000 + 3250000 + -983333 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 3906, '20140324', -0 + 0 + -152660 , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 7506, '20140310', 30513835 - 30513835 - 63381997  , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2181, '20140324', -307401640 + 307401640 - 313582491  , 'C'  
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 2182, '20140324', 324379528 + - 324379528 + 330554914  , 'C'  

   -- Mes: Abril
   -- Bac no maneja los decimales necesarios
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 6497, '20140409', 129176958 - 129176958 + 132456777  , 'C'  

   -- Ajuste de fecha de liquidación por feriado.
   -- al parecer se tenía que ajustar la fecha del flujo.
   -- BANCO SANTANDER          
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 5156, '20140421', 81669997-1023721  , 'C'  

   -- Ajuste a investigar
-- TRANF. TABLA   Insert into #Pagos_Ajustes_Derivados Select 'PCS', 5155, '20140421', -82511608 + 1024392  , 'C'  

   -- #Pagos_Ajustes_Derivados
   update #RESULT 
   Set
       #RESULT.Monto_Compensado         = 0 -- Monto_Flujo_Rec - Monto_Flujo_Pag  para señalar que fue ajustado
     , #RESULT.MontoCLP                 = AjustePago.MontoCLP
   from #Pagos_Ajustes_Derivados AjustePago 
   where AjustePago.numero_operacion = #Result.operacion
    and  AjustePago.Fecha_liquidacion = #Result.fecha_liquidacion

   -- Ajustes indicados por el usuario para entregas fisicas
   -- se ven aparte por el enrdeo con las fechas de liquidación
   CREATE TABLE #MONTOS_COMPENSADOS_EF_BAC ( Numero_operacion numeric(13), Fecha_liquidacion datetime, MontoCLP_Compensado numeric (20) )

   -- Mes: Enero
   -- Cuenta: Par 28-28
   -- Sin pesquizar
-- TRANF. TABLA   INSERT INTO #MONTOS_COMPENSADOS_EF_BAC  SELECT 4782,'20140131', -6688422 - 222087

   update #RESULT 
   Set
       #RESULT.Monto_Compensado         = 0 -- Monto_Flujo_Rec - Monto_Flujo_Pag  para señalar que fue ajustado
     , #RESULT.MontoCLP                 = AjustePago.MontoCLP_Compensado
   from #MONTOS_COMPENSADOS_EF_BAC AjustePago 
   where AjustePago.numero_operacion = #Result.operacion
    and  AjustePago.Fecha_liquidacion = #Result.fecha_liquidacion

   Insert into #Pagos
   select Id_Sisitema, Operacion, Fecha_Liquidacion, MontoCLP
     from #result  where MontoCLP <> 0 

   drop table #Valor_moneda
   drop table #CarteraHis
   drop table #Act
   drop table #Pas
   drop table #Result
   drop table #PAGOS_AJUSTES_DERIVADOS
   drop table #MONTOS_COMPENSADOS_EF_BAC

   -- Pagos Forward 
   -- Inicio Corregir/Ajustar
   select H.CaFecha, H.CaCodPos1
    , CaNumoper = case when R.var_moneda2 <> 0 then R.var_moneda2 else H.CaNumoper End -- Se registra el pago en la operacion MX/USD
    , H.CaTipOper
    , H.CaCodMon1
    , H.CaMtoMon1
    , H.CaTipCam
    , CaPrecal = convert( float, R.CaPrecal )
    , Paridad = isnull( convert( float, case when H.CatipModa <> 'C' or H.CanumOper in ( 43749, 551490 ) then ( select vmptacmp from bacparamSuda.dbo.valor_moneda where vmcodigo = H.CaCodMon1 and vmfecha = H.CaFecVcto )  
                else H.CaPreCal
                end ) * Case when H.CaCodPos1 = 2 then 1.0 else 0.0 end , 0 )
                +
                isnull( convert( float,  ( select vmValor from bacparamSuda.dbo.valor_moneda where vmcodigo = 994 and  vmfecha = H.CaFecVcto ) ) 
                 * Case when H.CaCodPos1 = 1 then 1.0 else 0.0 end , 0 )
    , H.CaMtoMon2
    , H.CaTipModa  
    , Multiplica_Divide = mnrrda  -- Sirve para 2 y 1
    , H.CaMtoComp
    , H.Cafecvcto
    , Monto_USD = convert( float, 0 )
    , Valor_USDVcto =  convert( float, ( select vmvalor from BacParamsuda.dbo.Valor_moneda where vmcodigo= 994 and vmfecha = H.Cafecvcto ) )
    , Monto_CLP = convert( float, 0 )
    , R.var_moneda2
    , Precio_Mon1 = convert( float,  ( select Tipo_Cambio from BacParamsuda.dbo.Valor_moneda_Contable 
                      where Codigo_moneda = case when H.CaCodMon1 = 13 then 994 else H.CaCodMon1 end  and fecha = H.Cafecvcto ) )
    , Precio_Mon2 = convert( float,  ( select vmValor from BacParamsuda.dbo.Valor_moneda
                         where vmcodigo = 994 and vmfecha = H.Cafecvcto  ) )
    into #Vctos
    from BacFwdSuda..MFCAH H
        LEFT JOIN BacParamsuda..moneda ON mncodmon = CaCodMon1
        LEFT JOIN  BacFwdSuda..MFCARes R ON R.CaNumOper = H.CaNumOper and R.CaFechaProceso = H.CaFecVcto 
    where /* ( H.cacodPos1 in ( 2 ) or H.CaCodPos1 = 1 and R.var_moneda2 <> 0 ) */ -- Se agregan los seguros de cambio que son parte de arbitrajes MX/USD
      ( H.CaCodPos1 = 2   or H.CaCodPos1 = 1 and H.CaCodMon2 = 999 )
      and year(H.CaFecVcto) >= year(@FechaCorteFinal)
      and R.CaAntici <> 'A'
   
   update #Vctos
     set Monto_USD = ( case when CaTipModa = 'C' then -- Compensacion
                    ( ( Case when  Multiplica_Divide = 'M' then
                          CaMtoMon1 * Paridad   
                      else

                          CaMtoMon1 / Paridad  
                      end ) 
                      - CaMtoMon2 
                    )  
                  else  -- Calculo realizado por contabilidad Entrega Fisica
                        -- aún no está buena para los JPY
                    ( ( Case when  Multiplica_Divide = 'M' then
                          (Precio_Mon1 / Precio_Mon2  -      catipcam)  * camtomon1                            
                      else
                          (Precio_Mon1 / Precio_Mon2   - 1.0/ catipcam ) * camtomon1                           
                      end )                                            
                    )       
                  end ) 
                  * (case when catipOper = 'C' then 1.0 else -1.0 end )
                
   where CaCodPos1 = 2

   update #Vctos
     set Monto_USD = ( ( Case when  Multiplica_Divide = 'M' then
                          CaMtoMon1 * Paridad   
                      else
                          CaMtoMon1 / Paridad  
                      end ) 
                      - ( Case when CaNumOper in ( 547834 ) then  -- Operaciones con Monto2 mal calculado
                                                                  -- Hay otras pero la distorción es poca
                                                                  -- Igual está mal que el monto2 no esté 100%.
                            round( CaMtoMon1 * CaTipCam  , 0 ) 
                          else CaMtoMon2 end )
                    )
                  
                 * (case when catipOper = 'C' then 1.0 else -1.0 end )
   where   CaCodPos1 = 1
   
   update #Vctos
    set
     Monto_CLP = round(  Monto_USD * case when CaCodPos1 = 1 then 1.0 else Valor_USDVcto end , 0 )


   --- ACA SE HACEN LOS AJUSTES
   -- Par 39 2014
-- TRANF. TABLA   update #Vctos Set Monto_CLP = 2255000 + 15000 where canumoper = 574052 and CaCodPos1 = 1

   -- Par 35 2014
   /* Se van a colocar en una tabla de ajustes: BacParamSuda.dbo.DJAjustesContables
   update #Vctos Set Monto_CLP = 1146356 - 16406 where canumoper = 572507 and CaCodPos1 = 2

   update #Vctos Set Monto_CLP = 69154248 + 28 where canumoper = 574512 and CaCodPos1 = 2

   update #Vctos Set Monto_CLP = 18406487-140981 where canumoper = 574524 and CaCodPos1 = 2
   */

   -- Siempre se irán integrando todos los pagos ya sucedidos 
   -- aunque no calcen con el mes en que se está analizando 
   -- la DJ Mensual.
   
   Insert into #Pagos 
   select 'BFW', CaNumoper, Cafecvcto, Monto_CLP
   from #Vctos where CaCodPos1 = 2 or CaCodPos1 = 1 and var_moneda2 = 0  

   delete #Pagos where fecha > @FechaCorteFinal


-- Corregir Compensaciones Forward Asiático
----if @AjustesPagosForwardAsiatico = 'SI'
----Begin
----    -- Pendiente conseguir la verdadera liquidacion
----	Update #Pagos set Monto_CLP = -306969000 where Numero_operacion = 42736 and Id_sistema = 'BFW'
----End
-- Correccion Compensaciones Forward Asiático

/* INICIO */ 
/*************************************************************************
                             BACFORWARD
*************************************************************************/

/********************************************************
 - Anticipos serán informados como liquidacion
 - Compensacion periódica de Seguro Inflación Hipotecarios
*********************************************************/

select Contrato                        = convert( numeric(10), Car.numerocontratocliente ) 
     , Evento                          = convert( varchar(30) , 'Anticipo' )
     , SubEvento                       = convert( varchar(30) , case when Car.CaNumoper <> Car.numerocontratocliente then 'PARCIAL' else 'TOTAL  ' end )
     , FechaEvento                     = Car.cafecvcto                -- <= Filtrar por esta fecha
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 = convert( numeric(9), Car.CaCodigo )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99  
     , Modalidad_Contratacion          = convert( numeric(2), 0 )                  
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( Ori.MoFecha, '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), 4 )                           
     , Tipo_Contrato                   = convert( numeric(2), 1 )     -- Forward                                                                              
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( case when Saldo.var_moneda2 <> 0 
                                                                                       then CarDiaAnt.caprecal
                                                                                       else Ori.motipCam end , 2) ) 
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round(  Saldo.CaMtoMon1  , 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  
     , Fecha_Vencimiento                              = convert( datetime, Ori.moFecVcto /*Car.CaFecVcto*/ )

-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), case when Car.CaCodPos1 in ( 10, 11 ) then 2 /*Tasa*/ else 1 /*Valor Monetario*/ end )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( VarChar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829


     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), Car.CaCodigo )
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), Car.CaTipModa )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), Car.CaTipOper )            -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5), case when Saldo.var_Moneda2 <> 0 then 12 else Car.CaCodPos1 end )            -- Producto según empresa contratante    
     , Moneda_transada_Emp             = convert( numeric(5), Car.CaCodMon1 )            -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                         -- la moneda del instrumento.
     , moneda_compensacion_Emp         = Convert( numeric(5), Car.moneda_compensacion  )
     , Fecha_Curse_Contrato_Emp        = convert( datetime , isnull( Ori.MoFecha, '19000101') ) 
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), Car.caserie )
     , Unidad_Precio_Subyacente_Emp    = convert( numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), Car.cacalcmpdol )         -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), case when Saldo.var_Moneda2 <> 0 then 999 else Car.CaCodMon2 end )
     , Modulo                          = 'BacForward'

       -- Para DJ1829 Datos necesario para rescatar información
     , Precio_Fecha_Evento                   = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = CASE WHEN Anticipo.CaCodMon1 = 13 THEN 994 ELSE Anticipo.CaCodMon1 END
                                                            AND vmfecha  = Anticipo.cafecvcto )  , 0.0) )
     , Precio_Fecha_Cierre_Ejercicio         = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = CASE WHEN Anticipo.CaCodMon1 = 13 THEN 994 ELSE Anticipo.CaCodMon1 END
                                                            AND vmfecha  = @FechaCierreAnnoComercial )  , 0.0) ) -- @FechaCierreAnnoComercial

     -- Vcto      
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )
     , Moneda_Vcto_Compensado                = convert( numeric(15), 0 )

     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), Anticipo.caantmtomdacomp )
                                                     -- solo 2012 y hasta 05 Julio 2013
                                                  + ( Case when Anticipo.caTipOper = 'C' then Anticipo.CaValPre 
                                                                                       else 0 end ) 
                                                          / isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = CASE WHEN Anticipo.moneda_compensacion = 13 THEN 994 ELSE Anticipo.moneda_compensacion END
                                                            AND vmfecha  = Anticipo.cafecvcto )  , 1.0)

     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), Anticipo.caantmtomdacomp *
                                                         isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = CASE WHEN Anticipo.moneda_compensacion = 13 THEN 994 ELSE Anticipo.moneda_compensacion END
                                                            AND vmfecha  = Anticipo.cafecvcto )  , 1.0) 
                                                           )  + -- solo 2012 y hasta 05 Julio 2013                                                               
                                                                ( Case when Anticipo.caTipOper = 'C' or Car.cafecvcto > '20130705' then Anticipo.CaValPre  else 0 end)       
     , Moneda_Anticipar                      = convert( numeric(5) , Anticipo.Moneda_Compensacion ) 

     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
     , Moneda_Ejercer                        = convert( numeric(5) , 0 )

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15), isnull( Anticipo.fRes_Obtenido, 0  ) )
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( DiaCierreAnno.fRes_Obtenido, 0 ) )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( DiaCierreAnoAnt.fRes_Obtenido, 0 ) )

     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float, Anticipo.capremon1 ) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, isnull( DiaCierreAnno.CaPreMon1, 0 )  )
     , Prima_Total_MO                        = convert( float, 0.0)
     , Prima_Total_CLP                       = Convert( float, 0.0)
 
       -- Claves Contablidad
     , KeyCntId_sistema = 'BFW'
     , KeyCntProducto      = Convert( varchar(3), Car.CaCodPos1 )
     , KeyCntTipOper       = convert( varchar(1), Car.CaTipOper ) 
     , KeyCntCallPut       = convert( varchar(4), '' )
     , KeyCntMoneda2       = convert( varchar(5), Car.CaCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Car.CaCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Car.CatipModa ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.cacartera_normativa )
     , KeyCntSubCarNormativa = convert( varchar(1), Car.CaSubCartera_Normativa ) 
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     
     , CaNumEstructura        = 0   
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial
     , VR_Al_1er_Dia_Ano      =  PrimerDiaAno.fRes_Obtenido 
     , VR_AL_1er_Dia_Ano_Sig  =  PrimerDiaAnoSig.fRes_Obtenido 
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante    
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             

into #ContratosDerivados
from bacfwdsuda.dbo.mfcah Car
   LEFT JOIN BacParamSuda.dbo.Cliente Cli ON Car.CaCodigo = Cli.ClRut and Car.CaCodCli = Cli.ClCodigo  
   LEFT JOIN BacFwdSuda.dbo.mfmoh     Ori ON Ori.MoNumOper = Car.numerocontratocliente  
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   Saldo ON Saldo.CaFechaProceso = Car.cafecvcto and Saldo.CaNumOper = Car.numerocontratocliente 
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   Anticipo ON Car.CaNumoper = Anticipo.CaNumOper and Anticipo.CaFechaProceso = Car.cafecvcto
   LEFT JOIN BacFwdSuda.dbo.mfach     Fecha ON Fecha.acfecproc = Car.cafecvcto
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaAnt ON CarDiaAnt.CaFechaProceso = Fecha.acfecante and CarDiaAnt.CaNumOper = Car.numerocontratocliente 
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   DiaCierreAnno ON DiaCierreAnno.CaFechaProceso = @FechaCierreAnnoComercial and DiaCierreAnno.CaNumOper = Car.NumeroContratoCliente
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   DiaCierreAnoAnt ON DiaCierreAnoAnt.CaFechaProceso = @FechaCierreAnnoComercialAnt and DiaCierreAnoAnt.CaNumOper = Car.NumeroContratoCliente
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAnoSig ON PrimerDiaAnoSig.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialSigHab  and PrimerDiaAnoSig.CaNumOper = Car.NumeroContratoCliente
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAno    ON PrimerDiaAno.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialHab  and PrimerDiaAno.CaNumOper = Car.NumeroContratoCliente

   where Car.numerocontratocliente <> 0  -- Incluye los anticipos de Seguro Inflación Hipotecario
      and (    Saldo.var_moneda2 <> 0 and Car.CaCodPos1 = 2                    -- MX/CLP, contrato titular
            or Saldo.var_moneda2 = 0  )                                        -- No es MX/CLP   
      and Car.cafecvcto >= @FechaCorte                                          -- Cargar solo los anticipos del periodo 
      and Car.Cafecvcto <= @FechaCorteFinal   
CREATE INDEX #IContratosDerivados ON #ContratosDerivados ( Contrato, FechaEvento ) 

-- Aplicar el monto de los seguros de cambio asociados a los MX/CLP  
-- Moneda_Anticipar: moneda en que se hizo el anticipo de la operación MX/USD

/***************************************************
Liquidaciones de Seguros de Inflación Hipotecario
****************************************************/
	select CanumOper 
	   into #ContratoSegInfHip 
	 from BacFwdSuda.dbo.MfCah where caCodpos1 = 13 
	union 
	select CaNumoper
	 from BacFwdSuda.dbo.MfCa  where caCodpos1 = 13 

	select Base.* into #FlujosSeguroInflacionHipotecario
		from  
	   	    BacFwdSuda.dbo.TBL_CARTERA_FLUJOS_RES  Base -- select * from BacFwdSuda.dbo.TBL_CARTERA_FLUJOS_RES
            LEFT JOIN BacFwdSuda.dbo.TBL_CARTERA_FLUJOS_RES Anulados ON Base.Cfr_Numero_Operacion = Anulados.Cfr_Numero_Operacion 
                                                                        and Base.Cfr_Correlativo = Anulados.Cfr_Correlativo
                                                                        and Anulados.Cfr_estado like '%AV%'
	  where Base.Cfr_Estado = 'V' -- Solo flujos vencidos
		 and Base.Cfr_Numero_Operacion in ( select CaNumoper from #ContratoSegInfHip )
         and isnull( Anulados.Cfr_Numero_Operacion, 0 ) = 0


-- Liquidaciones de Seguros de Inflación Hipotecario 
insert into  #ContratosDerivados
select 
       Contrato                        = convert( numeric(10), isnull( Car.canumoper,  CarH.CaNumOper )  )
     , Evento                          = convert( varchar(30) , 'Liq Hip' )
     , SubEvento                       = convert( varchar(30) , 'No aplica' )
     , FechaEvento                     = isnull( F.Cfr_Fecha_Vencimiento, '19000101' )   -- <= Filtrar por esta fecha
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 = convert( numeric(9), isnull( Car.CaCodigo, CarH.CaCodigo ) ) 
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99  
     , Modalidad_Contratacion          = convert( numeric(2), 0 )                  
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( Ori.MoFecha, '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), 4 )     -- Liquidacion    

     , Tipo_Contrato                   = convert( numeric(2), 1 )     -- Forward                                                                              
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( F.Cfr_Precio_Contrato, 2) ) 
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( F.Cfr_Monto_Principal, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  
     , Fecha_Vencimiento                              = convert( datetime, isnull( Car.CaFecVcto, CarH.CaFecVcto ) )
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), case when isnull( Car.CaCodPos1, CarH.CaCodPos1)  in ( 10, 11 ) then 2 /*Tasa*/ else 1 /*Valor Monetario*/ end )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), isnull( Car.CaCodigo, CarH.CaCodigo ))
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), isnull( Car.CaTipModa, CarH.CaTipModa ))            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), isnull( Car.CaTipOper, CarH.CaTipOper ))            -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5), isnull( Car.CaCodPos1, CarH.CaCodPos1 ))            -- Producto según empresa contratante    
     , Moneda_transada_Emp             = convert( numeric(5), isnull( Car.CaCodMon1, CarH.CaCodMon1 ))            -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                         -- la moneda del instrumento.
     , moneda_compensacion_Emp         = Convert( numeric(5), isnull( Car.moneda_compensacion , CarH.Moneda_Compensacion ) )
     , Fecha_Curse_Contrato_Emp        = isnull( Car.CaFecha, isnull( CarH.CaFecha , '19000101' ) ) 
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), isnull( Car.caserie, CarH.CaSerie) )
     , Unidad_Precio_Subyacente_Emp    = convert( numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), 0 )         -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), isnull( Car.CaCodMon2, CarH.CaCodMon2 ) )
     , Modulo                          = 'BacForward'
       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = 998
                                                            AND vmfecha  =  F.Cfr_Fecha_Vencimiento )  , 0.0) )
     , Precio_Fecha_Cierre_Ejercicio         = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = 998
                                                            AND vmfecha  = @FechaCierreAnnoComercial )  , 0.0) )

     -- Vcto      
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), case when isnull( Car.CaTipOper, CarH.CaTipOper ) = 'C' then 1.0 else -1.0 end 
                                                                   * ( F.Cfr_Monto_Principal * isnull( ( SELECT vmvalor
                                                                                            FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                                                             WHERE vmcodigo = 998
                                                                                             AND vmfecha  =  F.Cfr_Fecha_Vencimiento )  , 0.0)
                                                                       - F.Cfr_Monto_Secundario ) )
                                                                      
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), case when isnull( Car.CaTipOper, CarH.CaTipOper ) = 'C' then 1.0 else -1.0 end 
                                                                   * ( F.Cfr_Monto_Principal * isnull( ( SELECT vmvalor
                                                                                            FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                                                             WHERE vmcodigo = 998
                                                                                             AND vmfecha  =  F.Cfr_Fecha_Vencimiento )  , 0.0)
                                                                       - F.Cfr_Monto_Secundario ) )
     , Moneda_Vcto_Compensado                = convert( numeric(15), 999 )

     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )       
     , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Ejercer            = convert( numeric(15), 0 )
     , Moneda_Ejercer                        = convert( numeric(5) , 0 )

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15), isnull( CarRes.fRes_Obtenido, 0 ) )
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( DiaCierreAnno.fRes_Obtenido, 0 ) )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( DiaCierreAnoAnt.fRes_Obtenido, 0 ) )

     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float, 0 ) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, 0 )
     , Prima_Total_MO                        = convert( float, 0.0)
     , Prima_Total_CLP                       = Convert( float, 0.0)
       -- Claves Contablidad
     , KeyCntId_sistema = 'BFW'
     , KeyCntProducto      = Convert( varchar(3), isnull( Car.CaCodPos1, CarH.CaCodPos1 ) )
     , KeyCntTipOper       = convert( varchar(1), isnull( Car.CaTipOper, CarH.CaTipOper ) ) 
     , KeyCntCallPut       = convert( varchar(4), '' )
     , KeyCntMoneda2       = convert( varchar(5), isnull( Car.CaCodMon2, CarH.CaCodMon2 ) )
     , KeyCntMoneda1       = convert( varchar(5), isnull( Car.CaCodMon1, CarH.CaCodMon1 ) )  
     , KeyCntModalidad     = convert( varchar(1), isnull( Car.CatipModa, CarH.CatipModa  ) ) 
     , KeyCntCarNormativa  = convert( varchar(1), isnull( Car.cacartera_normativa, CarH.cacartera_normativa ) )
     , KeyCntSubCarNormativa = convert( varchar(1), isnull( Car.CaSubCartera_Normativa, CarH.CaSubCartera_normativa) ) 
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     
     , CaNumEstructura        = 0           
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial
     , VR_Al_1er_Dia_Ano      =  PrimerDiaAno.fRes_Obtenido 
     , VR_AL_1er_Dia_Ano_Sig  =  PrimerDiaAnoSig.fRes_Obtenido 
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante                                                 
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             

from #FlujosSeguroInflacionHipotecario F
             left join bacfwdsuda.dbo.mfca Car   on Car.canumoper = F.Cfr_Numero_Operacion 
             left join bacfwdsuda.dbo.mfcah CarH on CarH.canumoper = F.Cfr_Numero_Operacion 
             left join BacFwdSuda.dbo.mfcaRes CarRes on CarRes.CaNumOper = F.Cfr_Numero_Operacion  and CarRes.CaFechaProceso = F.Cfr_Fecha_Vencimiento 
             LEFT JOIN BacFwdSuda.dbo.mfcaRes   DiaCierreAnno ON DiaCierreAnno.CaFechaProceso = @FechaCierreAnnoComercial and DiaCierreAnno.CaNumOper = F.Cfr_Numero_Operacion 
             LEFT JOIN BacFwdSuda.dbo.mfcaRes   DiaCierreAnoAnt ON DiaCierreAnoAnt.CaFechaProceso = @FechaCierreAnnoComercialAnt and DiaCierreAnoAnt.CaNumoper = F.Cfr_Numero_Operacion 
             LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAnoSig ON PrimerDiaAnoSig.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialSigHab  and PrimerDiaAnoSig.CaNumOper = F.Cfr_Numero_Operacion 
             LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAno    ON PrimerDiaAno.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialHab  and PrimerDiaAno.CaNumOper = F.Cfr_Numero_Operacion 
             LEFT JOIN BacParamSuda.dbo.Cliente Cli ON Car.CaCodigo = Cli.ClRut and Car.CaCodCli = Cli.ClCodigo  
             LEFT JOIN BacFwdSuda.dbo.mfmoh     Ori ON Ori.MoNumOper = F.Cfr_Numero_Operacion 
where F.Cfr_Fecha_Vencimiento <=  isnull( CarH.CaFecVcto, Car.CaFecVcto )  -- CarRes.CaFecVcto --Ori.MoFecvcto
   and F.Cfr_Fecha_Vencimiento >= @FechaCorte              -- Cargar solo lo del periodo
   and F.Cfr_Fecha_Vencimiento <= @FechaCorteFinal

-- Modificaciones de Contratos
-- Para MX/CLP no se puede rescatar modificaciones ya que en la Mfmoh no
-- queda individualizado el producto.
-- Si hay modificaciones de un contrato secundario MX/CLP estaremos 
-- en problemas.
insert into  #ContratosDerivados 
select  Contrato = Car.CaNumOper
      , Evento   = convert( varchar(30) , 'Modificacion' )
      , SubEvento = convert( varchar(30) , 'No Aplica' )
      , FechaEvento = Car.cafecmod                -- <= Filtrar por esta fecha
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 = convert( numeric(9), Car.CaCodigo )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99        
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( Ori.MoFecha, '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), 2 )          
     , Tipo_Contrato                   = convert( numeric(2), 1 )         -- POR HACER: Consultar a Contabilidad si se debe 
                                                                          -- informar como 'Forward' todos los productos de BacForward 
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( case when Res.var_moneda2 <> 0 then Res.CaPreCal else Car.CatipCam end, 2) ) 
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( Car.CaMtoMon1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  -- POR HACER: solicitar integrar 4 decimales
     , Fecha_Vencimiento                              = convert( datetime, Car.CaFecVcto )
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), case when Car.CaCodPos1 in ( 10, 11 ) then 2 /*Tasa*/ else 1 /*Valor Monetario*/ end )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( Varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), Car.CaCodigo )
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )

     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), Car.CaTipModa )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), Car.CaTipOper )            -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5),case when Res.var_moneda2 <> 0 then 12 else  Car.CaCodPos1 end )            -- Producto según empresa contratante    
     , Moneda_transada_Emp             = convert( numeric(5), Car.CaCodMon1 )            -- Moneda transada según empresa contrante, para BFT corresponde a                                                                  
                                                                                         -- la moneda del instrumento.
     , moneda_compensacion_Emp         = Convert( numeric(5), Case when Car.CaCodpos1 = 1 
                                                                          then
                                                                                    case when Car.cacalcmpdol = 0 then 999 
                                                                                    else Car.cacalcmpdol end  
                                                                           else Case when Car.CaCodPos1 = 2 then
                                                                                    case when Cli.ClPais = 6 then 999 else 13 end
                                                                                else
                                                                                   999
                                                                                end
                                                                           end    )          -- cacalcmpdol, solo para los seguros de cambio
                                                                  -- si este campo está en cero la moneda a compensar es CLP. 
                                                                  -- si es arbitraje depende del cliente externo o no
     , Fecha_Curse_Contrato_Emp        = isnull( Car.CaFecha, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), Car.caserie )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), Car.cacalcmpdol )         -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), case when Res.var_moneda2 <>0 then 999 else Car.CaCodMon2 end)
     , Modulo                          = 'BacForward'
       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = case when Car.CaCodMon1 = 13 then 994 else Car.CaCodMon1 end
                                                            AND vmfecha  =  Car.cafecmod )  , 0   ) )
     , Precio_Fecha_Cierre_Ejercicio         = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = case when Car.CaCodMon1 = 13 then 994 else Car.CaCodMon1 end
                                                            AND vmfecha  = @FechaCierreAnnoComercial )  , 0 ) )

     -- Vcto      
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )                                                                      
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )
     , Moneda_Vcto_Compensado                = convert( numeric(15), 0 )

     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )       
     , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
     , Moneda_Ejercer                        = convert( numeric(5) , 0 )

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15), isnull( Car.fRes_Obtenido, 0 ) ) 
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( DiaCierreAnno.fRes_Obtenido, 0 ) )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( DiaCierreAnoAnt.fRes_Obtenido, 0 ) ) 

     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float,case when Res.CaCodpos1 in (10,11) then  Res.capremon1 else 0 end ) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, isnull( case when DiaCierreAnno.CaCodPos1 in ( 11, 10 ) then DiaCierreAnno.caPremon1 else 0 end , 0 ) )
     , Prima_Total_MO                        = convert( float, 0.0)
     , Prima_Total_CLP                       = Convert( float, 0.0)

       -- Claves Contablidad
     , KeyCntId_sistema = 'BFW'
     , KeyCntProducto      = Convert( varchar(3), Car.CaCodPos1 )
     , KeyCntTipOper       = convert( varchar(1), Car.CaTipOper ) 
     , KeyCntCallPut       = convert( varchar(4), '' )
     , KeyCntMoneda2       = convert( varchar(5), Car.CaCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Car.CaCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Car.CatipModa ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.cacartera_normativa )
     , KeyCntSubCarNormativa = convert( varchar(1), Car.CaSubCartera_Normativa ) 
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     
     , CaNumEstructura        = 0           
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial
     , VR_Al_1er_Dia_Ano      =  PrimerDiaAno.fRes_Obtenido 
     , VR_AL_1er_Dia_Ano_Sig  =  PrimerDiaAnoSig.fRes_Obtenido 
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante                                                 
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             


 from        bacfwdsuda.dbo.mfca_log  Car  -- select numeroContratoCliente, Cafecha, * from bacfwdsuda.dbo.mfcaRES where numerocontratocliente = 556988 and cafechaProceso = '20130520'
   LEFT JOIN bacfwdsuda.dbo.MfCaRes   CarAntParcial  ON Car.CaNumOper = CarAntParcial.numerocontratocliente and CarAntParcial.CaFechaProceso = Car.cafecmod
   LEFT JOIN BacParamSuda.dbo.Cliente Cli      ON Cli.Clrut = Car.CaCodigo and Cli.ClCodigo = Car.CaCodCli
   LEFT JOIN BacFwdSuda.dbo.mfmoh     Ori ON Ori.MoNumOper = Car.CaNumOper 
   LEFT JOIN BacFwdSuda.dbo.MfcaRes   Res ON Res.CaNumOper = Car.CaNumOper and Res.CaFechaProceso = Car.cafecmod
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   DiaCierreAnno ON DiaCierreAnno.CaFechaProceso = @FechaCierreAnnoComercial and DiaCierreAnno.CaNumOper = Car.CaNumoper
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   DiaCierreAnoAnt ON DiaCierreAnoAnt.CaFechaProceso = @FechaCierreAnnoComercialAnt and DiaCierreAnoAnt.CaNumoper = Car.CaNumOper
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAnoSig ON PrimerDiaAnoSig.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialSigHab  and PrimerDiaAnoSig.CaNumOper = Car.CaNumOper
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAno    ON PrimerDiaAno.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialHab  and PrimerDiaAno.CaNumOper = Car.CaNumOper
   

  where Car.cafecha <> Car.CaFecMod   
           -- No es ( anticipo total o Parcial )
       and not(     Res.CaAntici = 'a'           and not isnull( Res.CaAntici, 'X' ) = 'X' 
                or  CarAntParcial.CaAntici = 'a' and  not isnull( CarAntParcial.CaAntici, 'X' ) = 'X'  )        
           -- No es seguro de cambio asociado a Mx/Clp 
       and not ( Res.Var_Moneda2 <> 0 and Res.CaCodPos1 = 1 )
       and Car.cafecmod >= @FechaCorte
       and Car.Cafecmod <= @FechaCorteFinal


-- Contrato cursados vencidos
select  Contrato = Car.CaNumOper
      , Evento   = convert( varchar(30) , 'Vcto. Natural' )
      , SubEvento = convert( varchar(30) , 'No Aplica' )
      , FechaEvento = Car.CaFecVcto -- CarDiaAnt.CaFecVcto                -- <= Filtrar por esta fecha, cachar porque el usé CarDiaAnt
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 = convert( numeric(9), Car.CaCodigo )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99        
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( Ori.MoFecha, '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), 5 )         
     , Tipo_Contrato                   = convert( numeric(2), 1 )         -- POR HACER: Consultar a Contabilidad si se debe 
                                                                          -- informar como 'Forward' todos los productos de BacForward 
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( case when CarDiaVcto.var_moneda2 <> 0 then CarDiaVcto.CaPreCal else  CarDiaVcto.CatipCam end, 2) ) 
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( CarDiaVcto.CaMtoMon1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  -- POR HACER: solicitar integrar 4 decimales
     , Fecha_Vencimiento                              = convert( datetime, CarDiaVcto.CaFecVcto )
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), case when Car.CaCodPos1 in ( 10, 11 ) then 2 /*Tasa*/ else 1 /*Valor Monetario*/ end )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( Varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), CarDiaVcto.CaCodigo )
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), CarDiaVcto.CaTipModa )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), CarDiaVcto.CaTipOper )            -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5), case when CarDiaVcto.var_moneda2 <> 0 then 12 else CarDiaVcto.CaCodPos1 end )            -- Producto según empresa contratante    
     , Moneda_transada_Emp             = convert( numeric(5), CarDiaVcto.CaCodMon1 )            -- Moneda transada según empresa contrante, para BFT corresponde a                                                                  
                                                                                              -- la moneda del instrumento.
     , moneda_compensacion_Emp         = Convert( numeric(5), case when CarDiaVcto.CaCodPos1 = 1 then
                                           case when CarDiaVcto.cacalcmpdol = 0 then 999 else CarDiaVcto.cacalcmpdol end                                         
                                         else 0 end  )             -- cacalcmpdol, solo para los seguros de cambio
                                                                  -- si este campo está en cero la moneda a compensar es CLP. 
                                                                  -- si es arbitraje depende del cliente externo o no
     , Fecha_Curse_Contrato_Emp        = isnull( CarDiaVcto.CaFecha, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), CarDiaVcto.caserie )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), CarDiaVcto.cacalcmpdol )         -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), case when CarDiaVcto.Var_Moneda2 <> 0 then 999 else CarDiaVcto.CaCodMon2 end )
     , Modulo                          = 'BacForward'
       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CarDiaVcto.CaCodMon1 = 13 then 994 else CarDiaVcto.CaCodMon1 end
                                                            AND vmfecha  =  CarDiaVcto.CaFecVcto  )  ,1) )
     , Precio_Fecha_Cierre_Ejercicio         = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CarDiaVcto.CaCodMon1 = 13 then 994 else CarDiaVcto.CaCodMon1 end
                                                            AND vmfecha  =  @FechaCierreAnnoComercial  )  ,1) ) -- Fecha Cierre año

     -- Vcto      
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), Car.CaMtoComp )                                                                      
                                             * Case when Car.CaTipModa = 'E' then 1.0 else 1.0 end  -- Igual se leerá el campo compensacion                                                                    
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )  -- Por lo complejo de la moneda se calculará después
     , Moneda_Vcto_Compensado                = convert( numeric(5), Case when Car.CaCodpos1 = 1 
                                                                          then
                                                                                    case when CarDiaVcto.cacalcmpdol = 0 then 999 
                                                                                    else CarDiaVcto.cacalcmpdol end  
                                                                           else Case when Car.CaCodPos1 = 2 then
                                                                                    case when ClPais = 6 then 999 else 13 end
                                                                                else
                                                                                   999
                                                                                end
                                                                           end  ) 
     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )       
     , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
     , Moneda_Ejercer                        = convert( numeric(5) , 0 )

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15), isnull( CarDiaVcto.fRes_Obtenido, 0 ) ) 
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( CarDiaCierre.fRes_Obtenido, 0 ) )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( CarDiaCierreAnoAnt.fRes_Obtenido, 0 ) ) 

     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float, case when CarDiaVcto.CaCodPos1 in ( 10, 11 ) then  CarDiaVcto.capremon1 else 0 end) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, isnull( case when CarDiaCierre.CaCodPos1 in ( 10, 11 ) then CarDiaVcto.capremon1 else 0 end , 0 ))
     , Prima_Total_MO                        = convert( float, 0.0)
     , Prima_Total_CLP                       = Convert( float, 0.0)

       -- Claves Contablidad
     , KeyCntId_sistema = 'BFW'
     , KeyCntProducto      = Convert( varchar(3), Car.CaCodPos1 )
     , KeyCntTipOper       = convert( varchar(1), Car.CaTipOper ) 
     , KeyCntCallPut       = convert( varchar(4), '' )
     , KeyCntMoneda2       = convert( varchar(5), Car.CaCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Car.CaCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Car.CatipModa ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.cacartera_normativa )
     , KeyCntSubCarNormativa = convert( varchar(1), Car.CaSubCartera_Normativa ) 
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     
     , CaNumEstructura        = 0           
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial
     , VR_Al_1er_Dia_Ano      =  PrimerDiaAno.fRes_Obtenido 
     , VR_AL_1er_Dia_Ano_Sig  =  PrimerDiaAnoSig.fRes_Obtenido 
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante    
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             
                                             
-- Generacion de tabla temporal solo para obtener el valor en CLP 
-- de los montos compensados
 into  #AuxContratosDerivados 
 from bacfwdsuda.dbo.mfcah Car
   LEFT JOIN BacParamSuda.dbo.Cliente Cli      ON Cli.Clrut = Car.CaCodigo and Cli.ClCodigo = Car.CaCodCli
   LEFT JOIN BacFwdSuda.dbo.mfmoh     Ori      ON Ori.MoNumOper = Car.CaNumOper
   LEFT JOIN BacFwdSuda.dbo.mfach     Fecha ON Fecha.acfecproc = Car.cafecvcto
   --LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaAnt ON CarDiaAnt.CaFechaProceso = Fecha.acfecante and CarDiaAnt.CaNumOper = Car.CaNumOper 
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaCierre ON CarDiaCierre.CaFechaProceso =  @FechaCierreAnnoComercial and CarDiaCierre.CaNumOper = Car.CaNumOper
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaCierreAnoAnt ON CarDiaCierreAnoAnt.CaFechaProceso = @FechaCierreAnnoComercialAnt and CarDiaCierreAnoAnt.CaNumoper = Car.CaNumOper
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaCierreVcto ON CarDiaCierreVcto.CaFechaProceso = Car.CaFecVcto
                                                      and CarDiaCierreVcto.CaNumoper      = Car.CaNumOper
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAnoSig ON PrimerDiaAnoSig.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialSigHab  and PrimerDiaAnoSig.CaNumOper = Car.CaNumOper
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAno    ON PrimerDiaAno.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialHab  and PrimerDiaAno.CaNumOper = Car.CaNumOper
   LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaVcto      ON CarDiaVcto.CaFechaProceso =  Car.CaFecVcto and CarDiaVcto.CaNumOper = Car.CaNumOper 
   where car.caantici <> 'a' and car.CaCodPos1 <> 13 
and (    CarDiaCierreVcto.var_moneda2 <> 0 and Car.CaCodPos1 = 2                     -- MX/CLP, contrato titular
            or CarDiaCierreVcto.var_moneda2 = 0  )                                   -- No es MX/CLP   
and  Car.CaFecVcto >= @FechaCorte
and  Car.CaFecVcto <= @FechaCorteFinal

			-- Cálculo Monto Compensado para los Vencimientos Naturales de Forward
			Update #AuxContratosDerivados
			  set Monto_Pagado_CLP_Al_Vcto_Compensado = Monto_Pagado_MO_Al_Vcto_Compensado * isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = case when Moneda_Vcto_Compensado = 13 then 994 else Moneda_Vcto_Compensado end
                                                            AND vmfecha  =  FechaEvento )  , 1)


insert into #ContratosDerivados
select * from #AuxContratosDerivados


-- Forward aún vigentes al ejecutar el Query 
-- Para MX/CLP es necesario navegar la tabla MfcaRES
-- porque justo el dia que vence se borra el precio CLP/MXdel campo CaPreCal
-- y es obligatorio ver el valor del día anterior.
insert into  #ContratosDerivados 
select  Contrato = Car.CaNumOper 
      , Evento   = convert( varchar(30) , 'Curse' )
      , SubEvento = convert( varchar(30) , 'No Aplica' )
      , FechaEvento = Ori.MoFecha --Car.cafecha                 -- <= Filtrar por esta fecha
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 =  convert( numeric(9), Car.CaCodigo )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99        
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( Ori.MoFecha, '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), 1 )         
     , Tipo_Contrato                   = convert( numeric(2), 1 )         -- POR HACER: Consultar a Contabilidad si se debe 
                                                                          -- informar como 'Forward' todos los productos de BacForward 
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( case when CarDia.Var_moneda2 <> 0 then Ori.moPreCal else Ori.motipCam end, 2) ) 
	                                                +   convert(numeric(15,2), round( case when CarDia.Var_moneda2 <> 0 then CarDia.CaPreCal else CarDia.CatipCam end, 2) ) 
													    * ( case when Ori.MoCodPos1 = 14 then 1 else 0 end )
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( Ori.MoMtoMon1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  -- POR HACER: solicitar integrar 4 decimales
     , Fecha_Vencimiento                              = convert( datetime, case when Ori.MoNumoper in ( 559737, 560868, 561307
	                                                                                                  , 569184, 569578, 569610
                                                                                                      , 569617, 569671, 573026 ) then '20140102' 
	                                                    else Ori.mofecVcto end ) -- convert( datetime, CarDia.CafecVcto )
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), case when CarDia.CaCodPos1 in ( 10, 11 ) then 2 /*Tasa*/ else 1 /*Valor Monetario*/ end )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), CarDia.CaCodigo )
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), case when CarDia.CaNumOper in ( 572310 ) then 'C' else  CarDia.CaTipModa end )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), CarDia.CaTipOper )            -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5), case when CarDia.Var_moneda2 <> 0 then 12 else CarDia.CaCodPos1 end)            -- Producto según empresa contratante    
     , Moneda_transada_Emp             = convert( numeric(5), CarDia.CaCodMon1 )            -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                         -- la moneda del instrumento.
     , moneda_compensacion_Emp         = Convert( numeric(5), case when CarDia.CaCodPos1 = 1 then
                                           case when CarDia.cacalcmpdol = 0 then 999 else CarDia.cacalcmpdol end                                         
                                         else 0 end  )            -- cacalcmpdol, solo para los seguros de cambio
                                                                  -- si este campo está en cero la moneda a compensar es CLP. 
                                                                  -- si es arbitraje depende del cliente externo o no

     , Fecha_Curse_Contrato_Emp        = isnull( CarDia.CaFecha, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), CarDia.caserie )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), CarDia.cacalcmpdol )         -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), case when CarDia.Var_moneda2 <> 0 then 999 else CarDia.CaCodMon2 end )
     , Modulo                          = 'BacForward'
       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CarDia.CaCodMon1 = 13 then 994 else CarDia.CaCodMon1 end
                                                            AND vmfecha  =  CarDia.cafecha  )  ,1) )
     , Precio_Fecha_Cierre_Ejercicio         = convert( float,isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CarDia.CaCodMon1 = 13 then 994 else CarDia.CaCodMon1 end
                                                            AND vmfecha  =  @FechaCierreAnnoComercial  )  ,1)  )

     -- Vcto      
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )                                                                                                                   
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )  
     , Moneda_Vcto_Compensado                = convert( numeric(15), Case when CarDia.CaCodpos1 = 1 
                                                                          then
                                                                                    case when CarDia.cacalcmpdol = 0 then 999 
                                                                                    else CarDia.cacalcmpdol end  
                                                                           else Case when CarDia.CaCodPos1 = 2 then
                                                                                    case when ClPais = 6 then 999 else 13 end
                                                                                else
                                                                                   999
                                                                                end
                                                                           end  ) 
     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )       
     , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
     , Moneda_Ejercer                        = convert( numeric(5) , 0 )

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15), isnull( CarDia.fRes_Obtenido, 0 ) ) 
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( CarDiaCierre.fRes_Obtenido, 0 ) )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( CarDiaCierreAnoAnt.fRes_Obtenido, 0 ) )

     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float, case when CarDia.CaCodPos1 in ( 10, 11 ) then  CarDia.capremon1 else 0 end) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, case when CarDiaCierre.CaCodPos1 in ( 10, 11 ) then  CarDiaCierre.capremon1 else 0 end) 
     , Prima_Total_MO                        = convert( float, 0.0)
     , Prima_Total_CLP                       = Convert( float, 0.0)

       -- Claves Contablidad
     , KeyCntId_sistema = 'BFW'
     , KeyCntProducto      = Convert( varchar(3), Car.CaCodPos1 )
     , KeyCntTipOper       = convert( varchar(1), Car.CaTipOper ) 
     , KeyCntCallPut       = convert( varchar(4), '' )
     , KeyCntMoneda2       = convert( varchar(5), Car.CaCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Car.CaCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Car.CatipModa ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.cacartera_normativa )
     , KeyCntSubCarNormativa = convert( varchar(1), Car.CaSubCartera_Normativa ) 
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     
     , CaNumEstructura        = 0           
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial
     , VR_Al_1er_Dia_Ano      =  PrimerDiaAno.fRes_Obtenido 
     , VR_AL_1er_Dia_Ano_Sig  =  PrimerDiaAnoSig.fRes_Obtenido 
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante                                                 
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             

 from bacfwdsuda.dbo.mfca Car
      LEFT JOIN BacParamSuda.dbo.Cliente Cli ON Car.CaCodigo = Cli.ClRut and Car.CaCodCli = Cli.ClCodigo
      LEFT JOIN BacFwdSuda.dbo.mfmoh     Ori ON Ori.MoNumOper = Car.CaNumOper      
                                                                           -- En algunos casos no hay RES el dia del curse 
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDia ON  CarDia.CaFechaProceso  = case when Car.CaNumoper in ( 547844, 547845, 547846, 547847, 547848, 547849  ) 
                                                                             then '20120319'   
                                                                             when car.CaNumOper in ( 559076, 559078, 559079, 559080, 559088 )
                                                                             then '20130117'
                                                                             else Car.CaFecha end
                                         and CarDia.CaNumOper = Car.CaNumOper 
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaCierre ON CarDiaCierre.CaFechaProceso = @FechaCierreAnnoComercial and CarDiaCierre.CaNumoper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaCierreAnoAnt ON CarDiaCierreAnoAnt.CaFechaProceso = @FechaCierreAnnoComercialAnt and CarDiaCierreAnoAnt.CaNumoper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAnoSig ON PrimerDiaAnoSig.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialSigHab  and PrimerDiaAnoSig.CaNumOper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAno    ON PrimerDiaAno.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialHab  and PrimerDiaAno.CaNumOper = Car.CaNumOper
   
 where (     Car.caantici <> 'a'  
        )  
and (    CarDia.var_moneda2 <> 0 and  Car.CaCodPos1 = 2   -- MX/CLP, contrato titular
            or CarDia.var_moneda2 = 0 or Car.CaNumOper = 550001 )           -- No es MX/CLP  o es MX/CLP con problemas 550038 y 550001
-- and CarDia.CafecVcto >= @FechaCorte
and Car.CafecVcto >= @FechaCorte    -- quedaban fuera algunas operaciones con la condición anterior

-- Cursados que justos fueron anticipados HOY y por tanto están en la 
-- tabla MFCA en estado anticipado.
insert into #ContratosDerivados
select  Contrato = Car.CaNumOper 
      , Evento   = convert( varchar(30) , 'Curse' )
      , SubEvento = convert( varchar(30) , 'No Aplica' )
      , FechaEvento = Ori.MoFecha --Car.cafecha                 -- <= Filtrar por esta fecha
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 =  convert( numeric(9), Car.CaCodigo )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99        
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( Ori.MoFecha, '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), 1 )         
     , Tipo_Contrato                   = convert( numeric(2), 1 )         -- POR HACER: Consultar a Contabilidad si se debe 
                                                                          -- informar como 'Forward' todos los productos de BacForward 
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( case when CarDia.Var_moneda2 <> 0 then Ori.MoPreCal else Ori.motipCam end, 2) ) 
	 	                                                +   convert(numeric(15,2), round( case when CarDia.Var_moneda2 <> 0 then CarDia.CaPreCal else CarDia.CatipCam end, 2) ) 
													    * ( case when Ori.MoCodPos1 = 14 then 1 else 0 end )
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( Ori.MoMtoMon1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  -- POR HACER: solicitar integrar 4 decimales
     , Fecha_Vencimiento                              = convert( datetime, case when Ori.MoNumoper in ( 559737, 560868, 561307
	                                                                                                  , 569184, 569578, 569610
                                                                                                      , 569617, 569671, 573026 ) then '20140102' 
	                                                    else Ori.mofecVcto end ) -- convert( datetime, CarDia.CafecVcto )
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), case when CarDia.CaCodPos1 in ( 10, 11 ) then 2 /*Tasa*/ else 1 /*Valor Monetario*/ end )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), CarDia.CaCodigo )
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), case when CarDia.CaNumOper in (572310) then 'C' else CarDia.CaTipModa end )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), CarDia.CaTipOper )            -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5), case when CarDia.Var_moneda2 <> 0 then 12 else CarDia.CaCodPos1 end)            -- Producto según empresa contratante    
     , Moneda_transada_Emp             = convert( numeric(5), CarDia.CaCodMon1 )            -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                         -- la moneda del instrumento.
     , moneda_compensacion_Emp         = Convert( numeric(5), case when CarDia.CaCodPos1 = 1 then
                                           case when CarDia.cacalcmpdol = 0 then 999 else CarDia.cacalcmpdol end                                         
                                         else 0 end  )            -- cacalcmpdol, solo para los seguros de cambio
                                                                  -- si este campo está en cero la moneda a compensar es CLP. 
                                                                  -- si es arbitraje depende del cliente externo o no

     , Fecha_Curse_Contrato_Emp        = isnull( CarDia.CaFecha, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), CarDia.caserie )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), CarDia.cacalcmpdol )         -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), case when CarDia.Var_moneda2 <> 0 then 999 else CarDia.CaCodMon2 end )
     , Modulo                          = 'BacForward'
       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CarDia.CaCodMon1 = 13 then 994 else CarDia.CaCodMon1 end
                                                            AND vmfecha  =  CarDia.cafecha  )  ,1) )
     , Precio_Fecha_Cierre_Ejercicio         = convert( float,isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CarDia.CaCodMon1 = 13 then 994 else CarDia.CaCodMon1 end
                                                            AND vmfecha  =  @FechaCierreAnnoComercial  )  ,1)  )

     -- Vcto      
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )                                                                                                                   
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )  
     , Moneda_Vcto_Compensado                = convert( numeric(15), Case when CarDia.CaCodpos1 = 1 
                                                                          then
                                                                                    case when CarDia.cacalcmpdol = 0 then 999 
                                                                                    else CarDia.cacalcmpdol end  
                                                                           else Case when CarDia.CaCodPos1 = 2 then
                                                                                    case when ClPais = 6 then 999 else 13 end
                                                                                else
                                                                                   999
                                                                                end
                                                                           end  ) 
     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )       
     , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
     , Moneda_Ejercer                        = convert( numeric(5) , 0 )

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15), isnull( CarDia.fRes_Obtenido, 0 ) ) 
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( CarDiaCierre.fRes_Obtenido, 0 ) )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( CarDiaCierreAnoAnt.fRes_Obtenido, 0 ) )

     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float, case when CarDia.CaCodPos1 in ( 10, 11 ) then  CarDia.capremon1 else 0 end) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, case when CarDiaCierre.CaCodPos1 in ( 10, 11 ) then  CarDiaCierre.capremon1 else 0 end) 
     , Prima_Total_MO                        = convert( float, 0.0)
     , Prima_Total_CLP                       = Convert( float, 0.0)

       -- Claves Contablidad
     , KeyCntId_sistema = 'BFW'
     , KeyCntProducto      = Convert( varchar(3), Car.CaCodPos1 )
     , KeyCntTipOper       = convert( varchar(1), Car.CaTipOper ) 
     , KeyCntCallPut       = convert( varchar(4), '' )
     , KeyCntMoneda2       = convert( varchar(5), Car.CaCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Car.CaCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Car.CatipModa ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.cacartera_normativa )
     , KeyCntSubCarNormativa = convert( varchar(1), Car.CaSubCartera_Normativa ) 
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     
     , CaNumEstructura        = 0           
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial
     , VR_Al_1er_Dia_Ano      =  PrimerDiaAno.fRes_Obtenido 
     , VR_AL_1er_Dia_Ano_Sig  =  PrimerDiaAnoSig.fRes_Obtenido 
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante                                                 
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             

 from bacfwdsuda.dbo.mfca Car
      LEFT JOIN BacParamSuda.dbo.Cliente Cli ON Car.CaCodigo = Cli.ClRut and Car.CaCodCli = Cli.ClCodigo
      LEFT JOIN BacFwdSuda.dbo.mfmoh     Ori ON Ori.MoNumOper = Car.CaNumOper      
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDia ON CarDia.CaFechaProceso = Ori.MoFecha 
                                                   and CarDia.CaNumOper = Ori.MoNumOper 
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaCierre ON CarDiaCierre.CaFechaProceso = @FechaCierreAnnoComercial and CarDiaCierre.CaNumoper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaCierreAnoAnt ON CarDiaCierreAnoAnt.CaFechaProceso = @FechaCierreAnnoComercialAnt and CarDiaCierreAnoAnt.CaNumoper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAnoSig ON PrimerDiaAnoSig.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialSigHab  and PrimerDiaAnoSig.CaNumOper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAno    ON PrimerDiaAno.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialHab  and PrimerDiaAno.CaNumOper = Car.CaNumOper
  
 where (     Car.caantici = 'A'                            -- Operacion Anticipada Hoy 
         and Car.numerocontratocliente = Car.CanumOper     -- Anticipo Total
        )
--     and CarDia.CafecVcto >= @FechaCorte
     and Car.CafecVcto >= @FechaCorte  -- quedaban fuera algunas operaciones con la condición anterior

-- Forward vencidos al ejecutar el Query  
-- Se deben agregar los contratos que aparecen
-- anticipados posterior al periodo de rescate
insert into  #ContratosDerivados 
select  Contrato = Car.CaNumOper 
      , Evento   = convert( varchar(30) , 'Curse' )
      , SubEvento = convert( varchar(30) , 'No Aplica' )
      , FechaEvento = isnull(  Ori.MoFecha , Car.CaFecha ) --Car.cafecha                 -- <= Filtrar por esta fecha
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 =  convert( numeric(9), Car.CaCodigo )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99        
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( Ori.MoFecha, '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), 1 )         
     , Tipo_Contrato                   = convert( numeric(2), 1 )         -- POR HACER: Consultar a Contabilidad si se debe 
                                                                          -- informar como 'Forward' todos los productos de BacForward 
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( case when CarDia.var_moneda2 <> 0 then Ori.MoPreCal else Ori.MotipCam end, 2) ) 
	 	                                                +   convert(numeric(15,2), round( case when CarDia.Var_moneda2 <> 0 then CarDia.CaPreCal else CarDia.CatipCam end, 2) ) 
													    * ( case when Ori.MoCodPos1 = 14 then 1 else 0 end )
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( Ori.MoMtoMon1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  -- POR HACER: solicitar integrar 4 decimales
     , Fecha_Vencimiento                              = convert( datetime, case when Ori.MoNumoper in ( 559737, 560868, 561307
	                                                                                                  , 569184, 569578, 569610
                                                                                                      , 569617, 569671, 573026 ) then '20140102' 
	                                                    else Ori.mofecVcto end ) -- convert( datetime, CarDia.CafecVcto )
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), case when Car.CaCodPos1 in ( 10, 11 ) then 2 /*Tasa*/ else 1 /*Valor Monetario*/ end )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), Car.CaCodigo )
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), case when CarDia.CaNumoper in (572310) then 'C' else CarDia.CaTipModa end )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), Car.CaTipOper )            -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5), case when CarDia.var_moneda2 <> 0 then 12 else Car.CaCodPos1 end )            -- Producto según empresa contratante    
     , Moneda_transada_Emp             = convert( numeric(5), Car.CaCodMon1 )            -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                         -- la moneda del instrumento.
     , moneda_compensacion_Emp         = Convert( numeric(5), case when Car.CaCodPos1 = 1 then
                                           case when Car.cacalcmpdol = 0 then 999 else Car.cacalcmpdol end                                         
                                         else 0 end  )            -- cacalcmpdol, solo para los seguros de cambio
                                                                  -- si este campo está en cero la moneda a compensar es CLP. 
                                                                  -- si es arbitraje depende del cliente externo o no

     , Fecha_Curse_Contrato_Emp        = isnull( Car.CaFecha, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), Car.caserie )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), Car.cacalcmpdol )         -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), case when CarDia.Var_moneda2 <> 0 then 999 else Car.CaCodMon2 end )
     , Modulo                          = 'BacForward'

       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CarDia.CaCodMon1 = 13 then 994 else CarDia.CaCodMon1 end
                                                            AND vmfecha  =  CarDia.cafecha  )  ,1) )
     , Precio_Fecha_Cierre_Ejercicio         = convert( float,isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CarDia.CaCodMon1 = 13 then 994 else CarDia.CaCodMon1 end
                                                            AND vmfecha  =  @FechaCierreAnnoComercial  )  ,1)  )

     -- Vcto      
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )                                                                                                                   
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )
     , Moneda_Vcto_Compensado                = convert( numeric(15), Case when CarDia.CaCodpos1 = 1 
                                                                          then
                                                                                    case when CarDia.cacalcmpdol = 0 then 999 
                                                                                    else CarDia.cacalcmpdol end  
                                                                           else Case when CarDia.CaCodPos1 = 2 then
                                                                                    case when ClPais = 6 then 999 else 13 end
                                                                                else
                                                                                   999
                                                                                end
                                                                           end  ) 
     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )
     , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
     , Moneda_Ejercer                        = convert( numeric(5) , 0 )

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15), isnull( CarDia.fRes_Obtenido, 0 ) ) 
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( CarDiaCierre.fRes_Obtenido, 0 ) )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( CarDiaCierreAnoAnt.fRes_Obtenido, 0 ) )

     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float, case when CarDia.CaCodPos1 in ( 10, 11 ) then  CarDia.capremon1 else 0 end) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, case when CarDiaCierre.CaCodPos1 in ( 10, 11 ) then  CarDiaCierre.capremon1 else 0 end) 
     , Prima_Total_MO                        = convert( float, 0.0)
     , Prima_Total_CLP                       = Convert( float, 0.0)


       -- Claves Contablidad
     , KeyCntId_sistema = 'BFW'
     , KeyCntProducto      = Convert( varchar(3), Car.CaCodPos1 )
     , KeyCntTipOper       = convert( varchar(1), Car.CaTipOper ) 
     , KeyCntCallPut       = convert( varchar(4), '' )
     , KeyCntMoneda2       = convert( varchar(5), Car.CaCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Car.CaCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Car.CatipModa ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.cacartera_normativa )
     , KeyCntSubCarNormativa = convert( varchar(1), Car.CaSubCartera_Normativa ) 
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     
     , CaNumEstructura        = 0           
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial
     , VR_Al_1er_Dia_Ano      =  PrimerDiaAno.fRes_Obtenido 
     , VR_AL_1er_Dia_Ano_Sig  =  PrimerDiaAnoSig.fRes_Obtenido 
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante                                                 
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             

 from bacfwdsuda.dbo.mfcah Car
      LEFT JOIN BacParamSuda.dbo.Cliente Cli ON Car.CaCodigo = Cli.ClRut and Car.CaCodCli = Cli.ClCodigo
      LEFT JOIN BacFwdSuda.dbo.mfmoh     Ori ON Ori.MoNumOper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDia ON CarDia.CaFechaProceso = case when Car.CaNumOper = 557034 then '20121116'
                                                                                when Car.CanumOper in ( 29773, 29798, 30079,
                                                                                                        30082, 30164, 30206,
                                                                                                        30664, 31424 )
                                                                                                            then '20100629'
                                                                                when Car.CaNumOper in ( 547844, 547845, 547846, 547847, 547848, 547849 ) 
                                                                                                            then '20120319'
                                                                                when Car.CaNumOper in ( 46517 ) then '20120131' 
                                                                                when Car.CaNumOper in ( 559076, 559078, 559079, 559080, 559088 ) then '20130117'
                                                                           else Car.CaFecha end -- No habia RES para el dia del curse
                                               and CarDia.CaNumOper = Car.CaNumOper 
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaCierre ON CarDiaCierre.CaFechaProceso = @FechaCierreAnnoComercial and CarDiaCierre.CaNumoper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   CarDiaCierreAnoAnt ON CarDiaCierreAnoAnt.CaFechaProceso = @FechaCierreAnnoComercialAnt and CarDiaCierreAnoAnt.CaNumoper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAnoSig ON PrimerDiaAnoSig.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialSigHab  and PrimerDiaAnoSig.CaNumOper = Car.CaNumOper
      LEFT JOIN BacFwdSuda.dbo.mfcaRes   PrimerDiaAno    ON PrimerDiaAno.CaFechaProceso = @Fecha1erDiaHabilAnnoComercialHab  and PrimerDiaAno.CaNumOper = Car.CaNumOper

 where ( Car.caantici <> 'a' 
      or Car.caantici = 'a' and Car.numerocontratocliente = Car.CanumOper )
    and (    CarDia.var_moneda2 <> 0 and  Car.CaCodPos1 = 2  -- MX/CLP, contrato titular
             or Car.CaCodPos1 in (13)                        -- Contratos 13 son viejos no tiene CarDia
             or CarDia.var_moneda2 = 0 or Car.CaNumOper = 550001 )
    and  Car.CafecVcto >= @FechaCorte
     
/*************************************************************************
                             FORWARD DESDE SAO
*************************************************************************/
Select * 
   into #Eventos_SAO1                                         -- Forward Americano y Forward Asiático 
  from CbMdbOpc.dbo.MoHisEncContrato MovHis 
  where MovHis.MoNumContrato not in ( Select MoNumContrato  from CbMdbOpc.dbo.MoHisEncContrato where MoTipoTransaccion = 'ANULA' )
-- select * from #Eventos_SAO1
-- insert into  #ContratosDerivados 
select   
        Contrato = convert( numeric(10), MoNumContrato ) --CaNumOper  
      , Evento   = convert( varchar(30) , case when MoTipoTransaccion = 'CREACION'  then 'Curse'
                                               when MoTIpoTransaccion = 'MODIFICA' then  'Modificacion'
                                               when MoTipoTransaccion = 'ANTICIPA' then  'Anticipo'
                                               else 'Ejercicio' end )
      , SubEvento = convert( varchar(30) , case when MoTipoTransaccion = 'CREACION'  then 'No Aplica'
                                               when MoTIpoTransaccion = 'MODIFICA' then  'No Aplica'
                                               when MoTipoTransaccion = 'ANTICIPA' then  'TOTAL' -- No se implementó parcial 
                                               else 'No Aplica' end  )                           -- No tengo como saber mirando solo el movimiento
      , FechaEvento = convert( datetime, convert( varchar(8), moFechaCreacionRegistro, 112 ) )    -- <= Filtrar por esta fecha
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 =  convert( numeric(9), Car.MoRutCliente )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99        
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( carRes.CaFechaContrato , '19000101') ) -- convert( datetime , isnull( car.MoFechaContrato , '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), case when MoTipoTransaccion = 'CREACION'  then 1
                                               when MoTIpoTransaccion = 'MODIFICA' then  2
                                               when MoTipoTransaccion = 'ANTICIPA' then  4
                                               else 4 end  )         
     , Tipo_Contrato                   = convert( numeric(2), 1 )         -- POR HACER: Consultar a Contabilidad si se debe 
                                                                          -- informar como 'Forward' todos los productos de BacForward y 
                                                                          -- los Forward ingresados desde SAO 
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )  
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( Det.MoStrike, 2) ) 
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( Det.MoMontoMon1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  -- POR HACER: solicitar integrar 4 decimales
     , Fecha_Vencimiento                              = convert( datetime, Det.MoFechaVcto )-- select * from CbMdbOpc.dbo.cadetcontrato
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1),  1 /*Valor Monetario*/  )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 ) 
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829
     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), Car.MoRutCliente )
     , Codigo_Cliente_Emp              = convert( numeric(8), 1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), Det.MoModalidad )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), Car.MoCVEstructura )         -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5),  Car.MoCodEstructura )       -- Producto según empresa contratante, estos forward 
                                                                                           -- Son tratados contablemente como seguros de cambio.    
     , Moneda_transada_Emp             = convert( numeric(5), Det.MoCodMon1 )              -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                           -- la moneda del instrumento.
     , moneda_compensacion_Emp         = Convert( numeric(5), case when Det.MoModalidad = 'C' then Det.MoMdaCompensacion  else Det.MoCodMon1 end )         

     , Fecha_Curse_Contrato_Emp        = isnull( Car.MoFechaContrato, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), space(15) )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), Det.MoMdaCompensacion )      -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), Det.MoCodMon2 )
     , Modulo                          = 'SAO       '

       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, 0 ) /* Se calcula en proxima sección de código */
     , Precio_Fecha_Cierre_Ejercicio         = convert( float, 0 ) /* Se calcula en proxima sección de código */
     -- Vcto
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 ) /* Se mantiene comentado para el uso posterior */
                                                      /*convert( numeric(15), isnull(  ( select CaCajMtoMon1
                                                          /* *  isnull( ( select VmValor from BacParamSuda.dbo.Valor_moneda Vm 
                                                                           where  VM.VmCodigo = case when Caj.CaCajMdaM1 = 13 then 994 else Caj.CaCajMdaM1 end 
                                                                              and Vm.VmFecha = Det.CaFechaVcto ) , 1 ) */ 
                                                          from CbMdbOpc.dbo.CaVenCaja Caj 
                                                          where Caj.CaNumCOntrato = Det.CaNumContrato 
                                                             and Caj.CaNumEstructura = Det.CaNumEstructura
                                                             and Caj.CaCajOrigen = 'PV' 
                                                             and Caj.CaCajModalidad = 'C' ), 0 ) ) */

     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 ) /* Se mantiene comentado para el uso posterior */
                                                       /* convert( numeric(15), isnull(  ( select CaCajMtoMon1
                                                          *  isnull( ( select VmValor from BacParamSuda.dbo.Valor_moneda Vm 
                                                                           where  VM.VmCodigo = case when Caj.CaCajMdaM1 = 13 then 994 else Caj.CaCajMdaM1 end 
                                                                              and Vm.VmFecha = Det.CaFechaVcto ) , 1 ) 
                                                          from CbMdbOpc.dbo.CaVenCaja Caj 
                                                          where Caj.CaNumCOntrato = Det.CaNumContrato 
                                                             and Caj.CaNumEstructura = Det.CaNumEstructura
                                                             and Caj.CaCajOrigen = 'PV' 
                                                             and Caj.CaCajModalidad = 'C' ), 0 ) ) */
     , Moneda_Vcto_Compensado                = convert( numeric(15), 0 ) 
                                                       /* Convert( numeric(5), case when Det.MoModalidad = 'C' then Det.MoMdaCompensacion  else Det.MoCodMon1 end ) */
                                                            


     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 ) /* Se calcula en proxima sección de código */
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 ) /* Se calcula en proxima sección de código */
     , Moneda_Anticipar                       = case when MoTipoTransaccion = 'ANTICIPA' Then MoUnwindMon else 0 end


     -- Ejercer      -- El monto se guarda en el MOvimiento !!!
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 ) 
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
     , Moneda_Ejercer                        = 999 

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15), sum( Det.MoVrDet ) )      
                                              /* * /*Codigo Moneda de VR: */ 
                                               convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when Car.MoMon_vr = 13 then 994 else Car.MoMon_vr end
                                                            AND vmfecha  =  convert( datetime , isnull( car.MoFechaContrato , '19000101') )  )  ,1) )
                                               */
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), sum( isnull( CarDiaCierre.CaVrDetML , 0 ) ) )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), sum( isnull( CarDiaCierreAnoAnt.CaVrDetML, 0 ) ) )
   


     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )  
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float, 0.0) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, 0.0) 
     , Prima_Total_MO                        = convert( float, 0.0 ) -- Los Forward de SAO no cobran prima
     , Prima_Total_CLP                       = Convert( float, 0.0)
     -- Para el rescate de pagos no va en la tabla temporal principal

       -- Claves Contablidad
     , KeyCntId_sistema = 'BFW'  -- Forward Americano y Asiáticos se contabilizan en SAO 
     , KeyCntProducto      = Convert( varchar(3), Est.OpcContabExternaProd )
     , KeyCntTipOper       = convert( varchar(1), Car.MoCVEstructura )   
     , KeyCntCallPut       = convert( varchar(4), '' )
     , KeyCntMoneda2       = convert( varchar(5), Det.MoCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Det.MoCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Det.MoModalidad ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.MoCarNormativa ) --- select * from CbMdbOpc.dbo.MoEncContrato
     , KeyCntSubCarNormativa = convert( varchar(1), Car.MoSubCarNormativa )      
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     


     , Car.MoMon_vr 
     , MoFechaContrato                       = convert( datetime , isnull( carRes.CaFechaContrato , '19000101') )  --isnull( car.MoFechaContrato , '19000101') 
     , Det.MoFechaVcto 
     , Det.MoCodMon1
     , Car.MoNumContrato
     , CaNumEstructura        = 0  
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial
     , VR_Al_1er_Dia_Ano      =  sum(  PrimerDiaAno.CaVrDetML )
     , VR_AL_1er_Dia_Ano_Sig  =  sum(  PrimerDiaAnoSig.CaVrDetML )
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante      
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             
                                           
-- Generacion de tabla temporal solo para obtener los pagos 

into #AuxContratosDerivados2     
 from CbMdbOpc.dbo.MoHisDetContrato Det  -- select * from CbMdbOpc.dbo.MoHisEncContrato
      LEFT JOIN CbMdbOpc.dbo.MoHisEncContrato Car ON Car.MoNumFolio = Det.MoNumFolio  
      LEFT JOIN CbMdbOpc.dbo.CaResEncContrato CarRes ON   CarRes.CaEncFechaRespaldo = convert( varchar(8), car.moFechaCreacionRegistro, 112 ) 
                                                      and CarRes.CaNumContrato      = Car.MoNumContrato 
      LEFT JOIN CbMdbOpc.dbo.OpcionEstructura Est ON Est.OpcEstCod = Car.MoCodEstructura 
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato CarDiaCierre ON CarDiaCierre.CaDetFechaRespaldo = @FechaCierreAnnoComercial 
                                                          and CarDiaCierre.CaNumContrato = Car.MoNumCOntrato 
                                                          and CarDiaCierre.CaNumEstructura = det.MoNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato CarDiaCierreAnoAnt ON CarDiaCierreAnoAnt.CaDetFechaRespaldo = @FechaCierreAnnoComercialAnt 
                                                          and CarDiaCierreAnoAnt.CaNumContrato = Car.MoNumCOntrato 
                                                          and CarDiaCierreAnoAnt.CaNumEstructura = det.MoNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato PrimerDiaAnoSig 
              ON PrimerDiaAnoSig.CaDetFechaRespaldo = @Fecha1erDiaHabilAnnoComercialSigHab 
               and PrimerDiaAnoSig.CaNumContrato = Car.MoNumCOntrato 
               and PrimerDiaAnoSig.CaNumEstructura = det.MoNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato PrimerDiaAno 
              ON PrimerDiaAno.CaDetFechaRespaldo = @Fecha1erDiaHabilAnnoComercialHab 
               and PrimerDiaAno.CaNumContrato = Car.MoNumCOntrato 
               and PrimerDiaAno.CaNumEstructura = det.MoNumEstructura   
        
  where Car.MoCodEstructura in ( 8, 6, 13, 14 ) and Car.MoEstado <> 'C'
     and Car.MoNumContrato in ( select MoNumContrato from #Eventos_SAO1 )   
     and Det.MoFechaVcto >= @FechaCorte

group by Car.MoNumContrato, Car.MoTipoTransaccion, Car.moFechaCreacionRegistro, Car.moFechaCreacionRegistro
         , car.MoFechaContrato
         , carRes.CaFechaContrato
         , Det.MoStrike , Det.MoMontoMon1, Det.MoFechaVcto
         , Car.MoRutCliente , Det.MoModalidad, Car.MoCVEstructura, Car.MoCodEstructura
         , Det.MoCodMon1 , Det.MoMdaCompensacion , Det.MoCodMon2 , MoUnwindMon, Car.MoMon_vr, Car.MoPrimaInicial, Car.MoParMdaPrima
         , Est.OpcContabExternaProd
         , Car.MoCarNormativa , Car.MoSubCarNormativa
      /*   , PrimerDiaAno.CaVrDetML
         , PrimerDiaAnoSig.CaVrDetML  Error, esto descuadra el VR */

 
update #AuxContratosDerivados2
set 
       Precio_Fecha_Evento                   = isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when MoCodMon1 = 13 then 994 else MoCodMon1 end
                                                            AND vmfecha  =  FechaEvento )  ,1 )

     , Precio_Fecha_Cierre_Ejercicio         = isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when MoCodMon1 = 13 then 994 else MoCodMon1 end
                                                            AND vmfecha  =  @FechaCierreAnnoComercial  )  ,1 )  

     , Monto_Pagado_MO_Al_Anticipar          = isnull(  ( select sum( CaCajMtoMon1 ) 
                                                                                       from CbMdbOpc.dbo.CaVenCaja Caj 
                                                                                      where Caj.CaNumCOntrato = MoNumContrato 
                                                                                      -- and Caj.CaNumEstructura = Det.MoNumEstructura -- x los Fw Asiaticos Sintéticos 
                                                                                      and Caj.CaCajOrigen = 'PA' 
                                                                                      and Caj.CaCajModalidad = 'C'
                                                                                      and Caj.CaCajFechaGen  = MoFechaContrato   )  ,0  ) 
                                                                     
     , Monto_Pagado_CLP_Al_Anticipar         = isnull(  ( select sum( CaCajMtoMon1 * isnull( VmValor, 1 )  ) 
                                                                                       from CbMdbOpc.dbo.CaVenCaja Caj 
                                                                                          Left join BacParamSuda.dbo.Valor_moneda VM on VM.VmCodigo = case when Caj.CaCajMdaM1 = 13 then 994 else Caj.CaCajMdaM1 end 
                                                                                                and Vm.VmFecha = MoFechaContrato
                                                                                      where Caj.CaNumCOntrato = MoNumContrato 
                                                                                      -- and Caj.CaNumEstructura = Det.MoNumEstructura -- x los Fw Asiaticos Sintéticos 
                                                                                      and Caj.CaCajOrigen = 'PA' 
                                                                                      and Caj.CaCajModalidad = 'C'
                                                                                      and Caj.CaCajFechaGen  = MoFechaContrato )    ,0  )  

     , Valor_Justo_Al_Evento                = Valor_Justo_Al_Evento * isnull( ( select vmvalor from BacParamSuda.dbo.Valor_Moneda VM 
                                                                                                 where VM.VmFecha = MoFechaContrato
                                                                                                   and VM.VmCodigo = ( case when MoMon_vr = 13 then 994 else MoMon_vr end ) ), 1 )                                                                       
update #AuxContratosDerivados2
       set  Monto_Pagado_MO_Al_Ejercer  = case when evento = 'Ejercicio' then 
                                            ( Precio_Fecha_Evento - Precio_Futuro_Contratado ) 
                                            * Monto_Cantidad_Contratado_o_Nocional 
                                            * ( case when Posicion_Declarante_Emp = 'C' then 1.0 else -1.0 end )
                                           else 0.0 end
          , Monto_Pagado_CLP_Al_Ejercer = case when evento = 'Ejercicio' then 
                                            ( Precio_Fecha_Evento - Precio_Futuro_Contratado ) 
                                            * Monto_Cantidad_Contratado_o_Nocional 
                                            * ( case when Posicion_Declarante_Emp = 'C' then 1.0 else -1.0 end )
                                           else 0.0 end

    -- Este Select es para el Insert
    insert into  #ContratosDerivados
	select 	Contrato
	,	Evento
	,	SubEvento
	,	FechaEvento
	,	Rut_Contraparte
	,	DV_Rut_COntraparte
	,	Tax_ID_Contraparte
	,	Codigo_Pais_Contraparte
	,	Tipo_Relacion_con_Contraparte
	,	Modalidad_Contratacion
	,	Tipo_Acuerdo_Marco
	,	Numero_Acuerdo_Marco
	,	Fecha_Suscripcion_Acuerdo_Marco
	,	Numero_Contrato
	,	Fecha_Suscripcion_Contrato
	,	Contrato_Vencido_En_El_Ejercicio
	,	Estado_Contrato
    ,   Evento_Informado
	,	Tipo_Contrato
	,	Nombre_Instrumento
	,	Modalidad_Cumplimiento
	,	Posicion_Declarante
	,	Tipo_Activo_Subyacente
	,	Codigo_Activo_Subyacente
	,	Otro_Activo_Subyacente_Especificacion
	,	Tasa_Fija_o_Spread_Activo_Subyacente
	,	Tipo_Segundo_Activo_Subyacente
	,	Codigo_Segundo_Activo_Subyacente
	,	Otro_Segundo_Activo_Subyacente_Especificacion
	,	Tasa_Fija_o_Spread_Segundo_Activo_Subyacente
	,	Codigo_Precio_Futuro_Contratado
	,	Precio_Futuro_Contratado
	,	Moneda_Precio_Futuro_Contratado
	,	Unidad
	,	Monto_Cantidad_Contratado_o_Nocional
	,	Segunda_Unidad
	,	Segundo_Monto_Nocional
	,	Fecha_Vencimiento
	,	Fecha_Liquidacion_Ejercicio_de_Opcion
	,	Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion
	,	Precio_Mercado_Al_CIerre_o_Liquidacion
	,	Valor_Justo_Contrato
	,	Resultado_Ejercicio
	,	Cuenta_Contable_Resultado_Ejercicio
	,	Efecto_En_Patrimonio
	,	Cuenta_Contable_Registro_Patrimonio
	,	Comision_Pactada
	,	Cuenta_Contable_Registro_Comision_Pactada
	,	Prima_Total
	,	Cuenta_Contable_Registro_Prima_Total
	,	Inversion_Inicial
	,	Cuenta_Contable_Registro_Inversion_Inicial
	,	Otros_Gastos_Asociados_Al_Contrato
	,	Cuenta_Contable_Otros_Gastos
	,	Otros_Ingresos_Asociados_Al_Contrato
	,	Cuenta_Contable_Otros_Ingresos
	,	Montos_Pagos_Al_Exterior_Efectuados
	,	Modalidad_Pago_Al_Exterior_Efectuados
	,	Saldo_Garantias_Al_Cierre
	,	Rut_Cliente_Emp
	,	Codigo_Cliente_Emp
	,	Modalidad_Cumplimiento_Emp
	,	Posicion_Declarante_Emp
	,	Producto_Emp
	,	Moneda_transada_Emp
	,	moneda_compensacion_Emp
	,	Fecha_Curse_Contrato_Emp
	,	Estado_Cliente
	,	Subyacente_Papeles_de_RentaFija
	,	Unidad_Precio_Subyacente_Emp
	,	Pais_Recidencia_Contraparte_Emp
	,	cacalcmpdol_Emp
	,	Moneda_Multiplica_Divide_Emp
	,	Moneda_Conversion_Emp
	,	Modulo
	,	Precio_Fecha_Evento
	,	Precio_Fecha_Cierre_Ejercicio
	,	Monto_Pagado_MO_Al_Vcto_Compensado
	,	Monto_Pagado_CLP_Al_Vcto_Compensado
	,	Moneda_Vcto_Compensado
	,	Monto_Pagado_MO_Al_Anticipar
	,	Monto_Pagado_CLP_Al_Anticipar
	,	Moneda_Anticipar
	,	Monto_Pagado_MO_Al_Ejercer
	,	Monto_Pagado_CLP_Al_Ejercer
	,	Moneda_Ejercer
	,	Valor_Justo_Al_Evento
	,	Valor_Justo_Al_Cierre
    ,   Valor_Justo_Al_CierreAnoAnt
	,	CVOpcion
	,	CallPut
	,	Tasa_Mercado_Al_Evento
	,	Tasa_Mercado_Al_Cierre
    ,   Prima_Total_MO
    ,   Prima_Total_CLP                                              
       -- Claves Contablidad
     , KeyCntId_sistema 
     , KeyCntProducto      
     , KeyCntTipOper       
     , KeyCntCallPut       
     , KeyCntMoneda2       
     , KeyCntMoneda1       
     , KeyCntModalidad     
     , KeyCntCarNormativa  
     , KeyCntSubCarNormativa 
     , CntPagoEvento       
     , CntCtaResultadoPos     
     , CntCtaVRPos            
     , CntCtaResultadoNeg     
     , CntCtaVRNeg            
     , CaNumEstructura 
     , VR_Al_1er_Dia_Ano      
     , VR_AL_1er_Dia_Ano_Sig  
     , Vigente_CierreAnoAnt   
     , Vigente_CierreAno      
     , CntCtaCarVRPos                                                     
     , CntCtaCarVRNeg            
    
	 from #AuxContratosDerivados2

-- select * from #AuxContratosDerivados2
-- Solo vencimientos Forward de SAO
select  
        Contrato = convert( numeric(10), Det.CaNumContrato ) --CaNumOper  
      , Evento   = convert( varchar(30) , 'Vcto. Natural' )
      , SubEvento = convert( varchar(30) , 'No Aplica'   )                           -- No tengo como saber mirando solo el movimiento
      , FechaEvento = Det.CaFechaVcto  
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 =  convert( numeric(9), Car.CaRutCliente )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99        
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( car.CaFechaContrato , '19000101') ) 


     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), 5  )         
     , Tipo_Contrato                   = convert( numeric(2), 1 )         -- POR HACER: Consultar a Contabilidad si se debe 
                                                                          -- informar como 'Forward' todos los productos de BacForward y 
                                                                          -- los Forward ingresados desde SAO 
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( Det.CaStrike, 2) ) 
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( Det.CaMontoMon1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  -- POR HACER: solicitar integrar 4 decimales
     , Fecha_Vencimiento                              = convert( datetime, Det.CaFechaVcto )-- select * from CbMdbOpc.dbo.cadetcontrato
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), 1 /*Valor Monetario*/  )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), Car.CaRutCliente )
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), Det.CaModalidad )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), Car.CaCVEstructura )         -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5),  Car.CaCodEstructura )       -- Producto según empresa contratante, estos forward 
                                                                                           -- Son tratados contablemente como seguros de cambio.    
     , Moneda_transada_Emp             = convert( numeric(5), Det.CaCodMon1 )              -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                           -- la moneda del instrumento.
     , moneda_compensacion_Emp         = Convert( numeric(5), case when Det.CaModalidad = 'C' then Det.CaMdaCompensacion  else 0 end )         
     , Fecha_Curse_Contrato_Emp        = isnull( Car.CaFechaContrato, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), space(15) )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), Det.CaMdaCompensacion )      -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), Det.CaCodMon2 )
     , Modulo                          = 'SAO       '
       -- Para DJ1829
       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, 0 )
     , Precio_Fecha_Cierre_Ejercicio         = convert( float, 0 )

     -- Vcto
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 ) 
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 ) 
     , Moneda_Vcto_Compensado                = convert( numeric(5),  case when Det.CaModalidad = 'C' then Det.CaMdaCompensacion  else 0 end ) 
                                                            

     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 ) 
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 ) 
     , Moneda_Anticipar                      = convert( numeric(5), 0 )


     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0)                                                   
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 ) 
     , Moneda_Ejercer                        = convert( numeric(5) , 0 ) 

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15), sum( isnull( Det.CaVrDetML, 0 ) ) )      
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), sum( isnull( CarDiaCierre.CaVrDetML, 0 ) ) )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), sum( isnull( CarDiaCierreAnoAnt.CaVrDetML, 0 ) ) )

     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )  
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float, 0.0) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, 0.0) 
     , Prima_Total_MO                        = convert( float, 0.0 ) -- Los Forward de SAO no cobran prima
     , Prima_Total_CLP                       = Convert( float, 0.0)

       -- Claves Contablidad
     , KeyCntId_sistema = 'BFW'  -- Forward Americano y Asiáticos se contabilizan en SAO 
     , KeyCntProducto      = Convert( varchar(3), Est.OpcContabExternaProd )
     , KeyCntTipOper       = convert( varchar(1), Car.CaCVEstructura )   
     , KeyCntCallPut       = convert( varchar(4), '' )
     , KeyCntMoneda2       = convert( varchar(5), Det.CaCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Det.CaCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Det.CaModalidad ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.CaCarNormativa ) --- select * from CbMdbOpc.dbo.MoEncContrato
     , KeyCntSubCarNormativa = convert( varchar(1), Car.CaSubCarNormativa )      
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     

     , CaMon_vr                              = 0 -- Ya no es necesario convertir
     , MoFechaContrato                       = isnull( car.CaFechaContrato , '19000101') 
     , Det.CaFechaVcto 
     , Det.CaCodMon1
     , Car.CaNumContrato
     , CorrigeCompensacion                   = 'S'
     , CaNumEstructura = 0
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial, no usar isnull porque
     -- es información para verificar la vigencia del contrato
     , VR_Al_1er_Dia_Ano      =  sum( PrimerDiaAno.CaVrDetML  )
     , VR_AL_1er_Dia_Ano_Sig  =  sum( PrimerDiaAnoSig.CaVrDetML ) 
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante                                                 
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             

 into #AuxContratosDerivados3    
 from CbMdbOpc.dbo.CaVenDetContrato Det
 	  INNER JOIN CbMdbOpc.dbo.CaResDetContrato DetResVcto ON DetResVcto.CaDetFechaRespaldo = Det.CaFechaVcto 
	                                                     and DetResVcto.CaNumContrato = Det.CaNumContrato 
	                                                     and DetResVcto.CaNumEstructura = Det.CaNumEstructura	  
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato CarDiaCierre ON CarDiaCierre.CaDetFechaRespaldo = @FechaCierreAnnoComercial 
                                                          and CarDiaCierre.CaNumContrato = Det.CaNumCOntrato 
                                                          and CarDiaCierre.CaNumEstructura = det.CaNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato CarDiaCierreAnoAnt ON CarDiaCierreAnoAnt.CaDetFechaRespaldo = @FechaCierreAnnoComercialAnt 
                                                          and CarDiaCierreAnoAnt.CaNumContrato = Det.CaNumCOntrato 
                                                          and CarDiaCierreAnoAnt.CaNumEstructura = det.CaNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato PrimerDiaAnoSig 
              ON PrimerDiaAnoSig.CaDetFechaRespaldo = @Fecha1erDiaHabilAnnoComercialSigHab 
               and PrimerDiaAnoSig.CaNumContrato = Det.CaNumCOntrato 
               and PrimerDiaAnoSig.CaNumEstructura = det.CaNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato PrimerDiaAno 
              ON PrimerDiaAno.CaDetFechaRespaldo = @Fecha1erDiaHabilAnnoComercialHab 
               and PrimerDiaAno.CaNumContrato = Det.CaNumCOntrato 
               and PrimerDiaAno.CaNumEstructura = det.CaNumEstructura   

      LEFT JOIN CbMdbOpc.dbo.CaVenEncContrato Car ON Car.CaNumContrato = Det.CaNumContrato
      LEFT JOIN CbMdbOpc.dbo.OpcionEstructura Est ON Est.OpCEstCod = Car.CaCodEstructura

														  
  where Car.CaCodEstructura in ( 8, 6 , 13, 14) and Car.CaEstado <> 'C'
     and Car.CaNumContrato in ( select moNumContrato from #Eventos_SAO1 )    
     -- Si en la fecha hay un movimiento no es vencimiento natural 
     and Car.CaNumContrato not in ( select moNumContrato from #Eventos_SAO1 Ev where convert( varchar(8), Ev.MoFechaCreacionRegistro, 112 ) = Det.CaFechaVcto )
     and Det.CaFechaVcto >= @FechaCorte
     and Det.CaFechaVcto <= @FechaCorteFinal
group by
  Det.CaNumContrato, Det.CaFechaVcto, Car.CaRutCliente, Car.CaFechaContrato, Det.CaStrike, Det.CaMontoMon1
, Car.CaRutCliente, Det.CaModalidad, Car.CaCVEstructura, Car.CaCodEstructura, Det.CaCodMon1, Det.CaMdaCompensacion
, Det.CaCodMon1, Det.CaCodMon2, Car.CaNumContrato, Est.OpcContabExternaProd, Car.CaCarNormativa,  Car.CaSubCarNormativa
      --   , PrimerDiaAno.CaVrDetML
      --   , PrimerDiaAnoSig.CaVrDetML

update #AuxContratosDerivados3
  set      
       Precio_Fecha_Evento                   = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CaCodMon1 = 13 then 994 else CaCodMon1 end
                                                            AND vmfecha  =  case when Contrato = 709 then '20130401' -- Operacion vencida en Feriado
                                                                                                                     -- se toma USD OBS del sig.
                                                                                                                     -- día hábil. 
                                                                            else CaFechaVcto end )  ,1) )


    ,  Precio_Fecha_Cierre_Ejercicio         = convert( float,isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CaCodMon1 = 13 then 994 else CaCodMon1 end
                                                            AND vmfecha  =  @FechaCierreAnnoComercial  )  ,1)  )


-- select * from CbMdbOpc.dbo.CaVenCaja


    ,  Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), isnull(  ( select sum(CaCajMtoMon1)                                                          
                                                                                from CbMdbOpc.dbo.CaVenCaja Caj 
                                                                                where Caj.CaNumCOntrato = #AuxContratosDerivados3.Contrato                                                              
                                                             and Caj.CaCajOrigen = 'PV' 
                                                             -- and Caj.CaCajModalidad = 'C'
                                                             and Caj.CaCajFechaGen  = CaFechaVcto ), 0 ) )  

     -- Se modifica Código Para que los Forward de SAo soporten 
	 -- concepto de Entrega Fisica
     --, Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), isnull(  ( select sum( CaCajMtoMon1 * isnull( VmValor, 1 )  ) 
     --                                                                                  from CbMdbOpc.dbo.CaVenCaja Caj 
     --                                                                                     Left join BacParamSuda.dbo.Valor_moneda VM on VM.VmCodigo = case when Caj.CaCajMdaM1 = 13 then 994 else Caj.CaCajMdaM1 end 
     --                                                                                           and Vm.VmFecha = CaFechaVcto
     --                                                                                 where Caj.CaNumCOntrato = #AuxContratosDerivados3.Contrato 
     --                                                                                 -- and Caj.CaNumEstructura = Det.MoNumEstructura -- x los Fw Asiaticos Sintéticos 
     --                                                                                 and Caj.CaCajOrigen = 'PV' 
     --                                                                                 and Caj.CaCajModalidad = 'C'
     --                                                                                 and Caj.CaCajFechaGen  = CaFechaVcto )    ,0  )  )
	 , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), isnull(  ( select sum( CaMtmImplicito * isnull( 1.0, 1.0 ) ) 
                                                                                       from CbMdbOpc.dbo.CaVenCaja Caj 
																					   -- Sirve para Compensado CLP y Entregas Fisicas, EF siempre calcula monto en CLP																					   
																					   Left join BacParamSuda.dbo.Valor_moneda VM on VM.VmCodigo = case when Caj.CaCajModalidad = 'E' then 999
																					                                                                    else
																					                                                                         case when Caj.CaCajMdaM1 = 13 then 994 else Caj.CaCajMdaM1 end 
																																					    end
                                                                                                and Vm.VmFecha = CaFechaVcto
                                                                                      where Caj.CaNumCOntrato = #AuxContratosDerivados3.Contrato 
                                                                                      -- and Caj.CaNumEstructura = Det.MoNumEstructura -- x los Fw Asiaticos Sintéticos 
                                                                                      and Caj.CaCajOrigen = 'PV' 
                                                                                      -- and Caj.CaCajModalidad = 'C'
                                                                                      and Caj.CaCajFechaGen  = CaFechaVcto )    ,0  )  )
                                               * ( case when #AuxContratosDerivados3.Contrato in ( 912, 924,
                                                                                                   913, 919, 
                                                                                                   914, 920,
                                                                                                   1399,
                                                                                                   915, 921,
                                                                                                   1322
                                                                                                  ) then 0 else 1 end ) -- Anulación de registro del sistema
                                               -- Monto calculado correctamente
                                               -- Problema se da por no redondear el precio ponderado de entrada
                                               -- en decimales antes de hacer el cálculo compensado.
                                              +  ( Case when #AuxContratosDerivados3.Contrato  = 912 then -165165000 
                                                        when #AuxContratosDerivados3.Contrato  = 924 then -164890000 
                                                        when #AuxContratosDerivados3.Contrato  = 913 then -102508000
                                                        when #AuxContratosDerivados3.Contrato  = 919 then -102753000
                                                        when #AuxContratosDerivados3.Contrato  = 914 then -126624000
                                                        when #AuxContratosDerivados3.Contrato  = 920 then -126384000
                                                        when #AuxContratosDerivados3.Contrato  = 1399 then 780900000
                                                        when #AuxContratosDerivados3.Contrato  = 915 then -69100000
                                                        when #AuxContratosDerivados3.Contrato  = 921 then -68850000
                                                        when #AuxContratosDerivados3.Contrato  = 1322 then -1189400000
                                  
                                                        else 0 end )


-- Calculo compensaciones de Forward Americano
select  Contrato = CaNumContrato
      , Monto_Cantidad_Contratado_o_Nocional
      , Precio_Futuro_Contratado
      , Posicion_Declarante_Emp
      , Precio_Fecha_Evento
      , Moneda_Vcto_Compensado
      , Valor_Moneda_Vcto_Compensado = isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when Moneda_Vcto_Compensado = 13 then 994 else Moneda_Vcto_Compensado end
                                                            AND vmfecha  =  CaFechaVcto )  ,1)
      , CompensacionCLP    = convert( numeric(15) , Monto_Cantidad_Contratado_o_Nocional 
                         * ( Precio_fecha_evento  
                             - Precio_Futuro_Contratado )                   
                         * ( Case when Posicion_Declarante_Emp = 'C' then 1.0 else -1.0 end )
                        )
      , Compensacion = convert( numeric(15,2), 0 )
      , Fecha = CaFechaVcto
into #CompensacionAmericano 
from #AuxContratosDerivados3
where Producto_Emp = 8 -- and Modalidad_Cumplimiento_Emp = 'C'

-- select Precio_fecha_evento, CompensacionCLP, Monto_Cantidad_Contratado_o_Nocional, Precio_Futuro_Contratado, Valor_Moneda_Vcto_Compensado from #CompensacionAmericano where contrato = 709
-- drop table #CompensacionAmericano 

update #CompensacionAmericano                                         
   set Compensacion = CompensacionCLP / Valor_Moneda_Vcto_Compensado

/* Probando este caodigo decomentar al final */
-- Corregir compensaciones de Forward Americano
update #AuxContratosDerivados3

  Set   Monto_Pagado_MO_Al_Vcto_Compensado = Monto_Pagado_MO_Al_Vcto_Compensado
                                            *  case when Producto_Emp = 8 then 0.0 else 1.0 end -- Anula rescate para Americanos  
                                            + Convert( numeric(15,2), isnull( ( select sum( Compensacion ) 
                                                                        from  #CompensacionAmericano where Contrato = CaNumContrato and Fecha = CaFechaVcto  ), 0 )  )                                            
                                      
     ,  Monto_Pagado_CLP_Al_Vcto_Compensado = Monto_Pagado_CLP_Al_Vcto_Compensado
                                            *  case when Producto_Emp = 8 then 0.0 else 1.0 end -- Anula rescate para Americanos  
                                            + Convert( numeric(15,2), isnull( ( select sum( CompensacionCLP ) 
                                                                        from  #CompensacionAmericano where Contrato = CaNumContrato and Fecha = CaFechaVcto  ), 0 )  )                                            
    
     , CorrigeCompensacion = isnull( (select 'S' from #CompensacionAmericano where Contrato = CaNumContrato and Fecha = CaFechaVcto), 'N' )


insert into  #ContratosDerivados
	select 	Contrato
	,	Evento
	,	SubEvento
	,	FechaEvento
	,	Rut_Contraparte
	,	DV_Rut_COntraparte
	,	Tax_ID_Contraparte
	,	Codigo_Pais_Contraparte
	,	Tipo_Relacion_con_Contraparte
	,	Modalidad_Contratacion
	,	Tipo_Acuerdo_Marco
	,	Numero_Acuerdo_Marco
	,	Fecha_Suscripcion_Acuerdo_Marco
	,	Numero_Contrato
	,	Fecha_Suscripcion_Contrato
	,	Contrato_Vencido_En_El_Ejercicio
	,	Estado_Contrato
    ,   Evento_Informado
	,	Tipo_Contrato
	,	Nombre_Instrumento
	,	Modalidad_Cumplimiento
	,	Posicion_Declarante
	,	Tipo_Activo_Subyacente
	,	Codigo_Activo_Subyacente
	,	Otro_Activo_Subyacente_Especificacion
	,	Tasa_Fija_o_Spread_Activo_Subyacente
	,	Tipo_Segundo_Activo_Subyacente
	,	Codigo_Segundo_Activo_Subyacente
	,	Otro_Segundo_Activo_Subyacente_Especificacion
	,	Tasa_Fija_o_Spread_Segundo_Activo_Subyacente
	,	Codigo_Precio_Futuro_Contratado
	,	Precio_Futuro_Contratado
	,	Moneda_Precio_Futuro_Contratado
	,	Unidad
	,	Monto_Cantidad_Contratado_o_Nocional
	,	Segunda_Unidad
	,	Segundo_Monto_Nocional
	,	Fecha_Vencimiento
	,	Fecha_Liquidacion_Ejercicio_de_Opcion
	,	Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion
	,	Precio_Mercado_Al_CIerre_o_Liquidacion
	,	Valor_Justo_Contrato
	,	Resultado_Ejercicio
	,	Cuenta_Contable_Resultado_Ejercicio
	,	Efecto_En_Patrimonio
	,	Cuenta_Contable_Registro_Patrimonio
	,	Comision_Pactada
	,	Cuenta_Contable_Registro_Comision_Pactada
	,	Prima_Total
	,	Cuenta_Contable_Registro_Prima_Total
	,	Inversion_Inicial
	,	Cuenta_Contable_Registro_Inversion_Inicial
	,	Otros_Gastos_Asociados_Al_Contrato
	,	Cuenta_Contable_Otros_Gastos
	,	Otros_Ingresos_Asociados_Al_Contrato
	,	Cuenta_Contable_Otros_Ingresos
	,	Montos_Pagos_Al_Exterior_Efectuados
	,	Modalidad_Pago_Al_Exterior_Efectuados
	,	Saldo_Garantias_Al_Cierre
	,	Rut_Cliente_Emp
	,	Codigo_Cliente_Emp
	,	Modalidad_Cumplimiento_Emp
	,	Posicion_Declarante_Emp
	,	Producto_Emp
	,	Moneda_transada_Emp
	,	moneda_compensacion_Emp
	,	Fecha_Curse_Contrato_Emp
	,	Estado_Cliente
	,	Subyacente_Papeles_de_RentaFija
	,	Unidad_Precio_Subyacente_Emp
	,	Pais_Recidencia_Contraparte_Emp
	,	cacalcmpdol_Emp
	,	Moneda_Multiplica_Divide_Emp
	,	Moneda_Conversion_Emp
	,	Modulo
	,	Precio_Fecha_Evento
	,	Precio_Fecha_Cierre_Ejercicio
	,	Monto_Pagado_MO_Al_Vcto_Compensado
	,	Monto_Pagado_CLP_Al_Vcto_Compensado
	,	Moneda_Vcto_Compensado
	,	Monto_Pagado_MO_Al_Anticipar
	,	Monto_Pagado_CLP_Al_Anticipar
	,	Moneda_Anticipar
	,	Monto_Pagado_MO_Al_Ejercer
	,	Monto_Pagado_CLP_Al_Ejercer
	,	Moneda_Ejercer
	,	Valor_Justo_Al_Evento
	,	Valor_Justo_Al_Cierre
    ,   Valor_Justo_Al_CierreAnoAnt
	,	CVOpcion
	,	CallPut
	,	Tasa_Mercado_Al_Evento
	,	Tasa_Mercado_Al_Cierre
    ,   Prima_Total_MO
    ,   Prima_Total_CLP                              
       -- Claves Contablidad
     , KeyCntId_sistema 
     , KeyCntProducto      
     , KeyCntTipOper       
     , KeyCntCallPut       
     , KeyCntMoneda2       
     , KeyCntMoneda1       
     , KeyCntModalidad     
     , KeyCntCarNormativa  
     , KeyCntSubCarNormativa       
     , CntPagoEvento       
     , CntCtaResultadoPos     
     , CntCtaVRPos            
     , CntCtaResultadoNeg     
     , CntCtaVRNeg            
     , CaNumEstructura
     , VR_Al_1er_Dia_Ano      
     , VR_AL_1er_Dia_Ano_Sig  
     , Vigente_CierreAnoAnt   
     , Vigente_CierreAno   
     , CntCtaCarVRPos                                                      
     , CntCtaCarVRNeg          
              
	 from  #AuxContratosDerivados3

/*************************************************************************
                             RESTO DE ESTRUCTURA SAO
*************************************************************************/
/* Movimientos */
select   
        Contrato = convert( numeric(10), MoNumContrato * 10 + MoNumEstructura ) --CaNumOper  
      , Evento   = convert( varchar(30) , case when MoTipoTransaccion = 'CREACION'  then 'Curse'
                                               when MoTIpoTransaccion = 'MODIFICA' then  'Modificacion'
                                               when MoTipoTransaccion = 'ANTICIPA' then  'Anticipo'
                                               else 'Ejercicio' end )
      , SubEvento = convert( varchar(30) , case when MoTipoTransaccion = 'CREACION'  then 'No Aplica'
                                               when MoTIpoTransaccion = 'MODIFICA' then  'No Aplica'
                                               when MoTipoTransaccion = 'ANTICIPA' then  'TOTAL' -- No se implementó parcial 
                                               else 'No Aplica' end  )                           -- No tengo como saber mirando solo el movimiento
      , FechaEvento = convert( datetime, convert( varchar(8), moFechaCreacionRegistro, 112 ) )   -- <= Filtrar por esta fecha
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 =  convert( numeric(9), Car.MoRutCliente )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99        
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime, isnull( carRes.CaFechaContrato , '19000101') ) -- convert( datetime , isnull( car.MoFechaContrato , '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829

     , Evento_Informado                = convert( numeric(1), case when Car.MoTipoTransaccion = 'CREACION'  then 1
                                               when Car.MoTIpoTransaccion = 'MODIFICA' then  2
                                               when Car.MoTipoTransaccion = 'ANTICIPA' then  4
                                               else 4 end  )         
     , Tipo_Contrato                   = convert( numeric(2), Case when Det.MoCallPut = 'Call' and Det.MoTipoPayOff = '01' then 8
                                                                   when Det.MoCallPut = 'Put'  and Det.MoTipoPayOff = '01' then 9 
                                                                   when Det.MoCallPut = 'Call' and Det.MoTipoPayOff = '02' then 10
                                                                   when Det.MoCallPut = 'Put'  and Det.MoTipoPayOff = '02' then 11
                                                                   else 0 end )         
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )  
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( Det.MoStrike, 2) ) 
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( Det.MoMontoMon1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  -- POR HACER: solicitar integrar 4 decimales
     , Fecha_Vencimiento                              = convert( datetime, Det.MoFechaVcto )-- select * from CbMdbOpc.dbo.cadetcontrato
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, Det.MoFechaVcto )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1),  1 /*Valor Monetario*/  )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 ) 
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), Car.MoRutCliente )
     , Codigo_Cliente_Emp              = convert( numeric(8), 1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), Det.MoModalidad )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), Det.MoCVOpc )         -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5), Car.MoCodEstructura )                          -- Producto según empresa contratante
                                                                                           
     , Moneda_transada_Emp             = convert( numeric(5), Det.MoCodMon1 )              
                                                                                           
     , moneda_compensacion_Emp         = Convert( numeric(5), case when Det.MoModalidad = 'C' then Det.MoMdaCompensacion  else Det.MoCodMon1 end )         

     , Fecha_Curse_Contrato_Emp        = isnull( Car.MoFechaContrato, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), space(15) )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), Det.MoMdaCompensacion )      -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), Det.MoCodMon2 )
     , Modulo                          = 'SAO       '
       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, 0 ) /* Se calcula en proxima sección de código */
     , Precio_Fecha_Cierre_Ejercicio         = convert( float, 0 ) /* Se calcula en proxima sección de código */
     -- Vcto
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 ) 
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 ) 
     , Moneda_Vcto_Compensado                = convert( numeric(15), 0 ) 
     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 ) /* Se calcula en proxima sección de código */
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 ) /* Se calcula en proxima sección de código */
     , Moneda_Anticipar                       = case when MoTipoTransaccion = 'ANTICIPA' Then MoUnwindMon else 0 end


     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0) /* Se calcula en proxima sección de código */
                                                  
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 ) /* Se calcula en proxima sección de código */
     , Moneda_Ejercer                        = convert( numeric(5) , case when Det.MoModalidad = 'E' then 0 else Det.MoCodMon2 end )
                                               * case when MoTipoTransaccion = 'EJERCE' then 1.0 else 0 end 

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15),  isnull( Det.MoVrDet, 0 )  )      
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( CarDiaCierre.CaVrDetML /*- - CarDiaCierre.CaPrimaInicialDetML */, 0 )
                                                                                                                                                  
                                                       )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( CarDiaCierreAnoAnt.CaVrDetML /*- - CarDiaCierreAnoAnt.CaPrimaInicialDetML*/, 0 )
                                                                              
                                                       )

     -- Opciones
     , CVOpcion                              = convert( varchar(1), Det.MoCVOpc )  
     , CallPut                               = convert( varchar(4), Det.MoCallPut )
     , Tasa_Mercado_Al_Evento                = Convert( float, 0.0) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, 0.0) 
     , Prima_Total_MO                        = convert( float, isnull( CarDiaEvento.CaPrimaInicialDet, 0 ) ) 
     , Prima_Total_CLP                       = convert( float, isnull( CarDiaEvento.CaPrimaInicialDetML, 0 ) )  

       -- Claves Contablidad
     , KeyCntId_sistema = 'OPT'  
     , KeyCntProducto      = Convert( varchar(3), 'OPT' )
     , KeyCntTipOper       = convert( varchar(1), Det.MoCVOpc )   
     , KeyCntCallPut       = convert( varchar(4), Det.MoCallPut )
     , KeyCntMoneda2       = convert( varchar(5), Det.MoCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Det.MoCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Det.MoModalidad ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.MoCarNormativa ) --- select * from cbmdbopc.dbo.MoEncContrato
     , KeyCntSubCarNormativa = convert( varchar(1), Car.MoSubCarNormativa )      
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     



     -- Para el rescate de pagos no va en la tabla temporal principal
     , Car.MoMon_vr 
     , MoFechaContrato                       = isnull( carRes.CaFechaContrato , '19000101') -- isnull( car.MoFechaContrato , '19000101') 
     , Det.MoFechaVcto 
     , Det.MoCodMon1
     , Car.MoNumContrato
     , Det.MoNumEstructura
     -- Para ver si el contrato está vigente al cierre año comercial anterior 
     -- Para ver si el contrato está vigente al cierre año comercial
     , VR_Al_1er_Dia_Ano      =  PrimerDiaAno.CaVrDetML 
     , VR_AL_1er_Dia_Ano_Sig  =  PrimerDiaAnoSig.CaVrDetML 
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante   
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             
                                              
-- Generacion de tabla temporal solo para obtener los pagos   
into #AuxContratosDerivados4
     
 from CbMdbOpc.dbo.MoHisDetContrato Det  -- select * from CbMdbOpc.dbo.CaResDetContrato
      LEFT JOIN CbMdbOpc.dbo.MoHisEncContrato Car ON Car.MoNumFolio = Det.MoNumFolio  
      LEFT JOIN CbMdbOpc.dbo.CaResEncContrato CarRes ON   CarRes.CaEncFechaRespaldo = convert( varchar(8), car.moFechaCreacionRegistro, 112 ) 
                                                      and CarRes.CaNumContrato      = Car.MoNumContrato 
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato CarDiaCierre ON CarDiaCierre.CaDetFechaRespaldo = @FechaCierreAnnoComercial 
                                                          and CarDiaCierre.CaNumContrato = Car.MoNumCOntrato 
                                                          and CarDiaCierre.CaNumEstructura = det.MoNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato CarDiaCierreAnoAnt ON CarDiaCierreAnoAnt.CaDetFechaRespaldo = @FechaCierreAnnoComercialAnt 
                                                          and CarDiaCierreAnoAnt.CaNumContrato = Car.MoNumCOntrato 
                                                          and CarDiaCierreAnoAnt.CaNumEstructura = det.MoNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato CarDiaEvento ON CarDiaEvento.CaDetFechaRespaldo = car.MoFechaContrato 
                                                          and CarDiaEvento.CaNumContrato = Car.MoNumCOntrato 
                                                          and CarDiaEvento.CaNumEstructura = det.MoNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato PrimerDiaAnoSig 
              ON PrimerDiaAnoSig.CaDetFechaRespaldo = @Fecha1erDiaHabilAnnoComercialSigHab 
               and PrimerDiaAnoSig.CaNumContrato = Car.MoNumCOntrato 
               and PrimerDiaAnoSig.CaNumEstructura = det.MoNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato PrimerDiaAno 
              ON PrimerDiaAno.CaDetFechaRespaldo = @Fecha1erDiaHabilAnnoComercialHab 
               and PrimerDiaAno.CaNumContrato =  Car.MoNumCOntrato 
               and PrimerDiaAno.CaNumEstructura = det.MoNumEstructura   

        
  where Car.MoCodEstructura not in ( 8, 6, 13, 14 ) and Car.MoEstado <> 'C'
     and Car.MoNumContrato in ( select MoNumContrato from #Eventos_SAO1 )   
     and Det.MoFechaVcto >= @FechaCorte 

    -- Contratos con Movimiento que no fueron aplicados en Cartera
	delete from #AuxContratosDerivados4
	where contrato in (   11461
						, 11471
                        , 11481
                        , 11491
                        , 11501
                        , 11511 ) and modulo = 'SAO'



 -- select * from #AuxContratosDerivados4 where evento = 'antipo' and fechaefe
update #AuxContratosDerivados4
set 
       Precio_Fecha_Evento                   = isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when MoCodMon1 = 13 then 994 else MoCodMon1 end
                                                            AND vmfecha  =  MoFechaContrato )  ,1 )

     , Precio_Fecha_Cierre_Ejercicio         = isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when MoCodMon1 = 13 then 994 else MoCodMon1 end
                                                            AND vmfecha  =  @FechaCierreAnnoComercial  )  ,1 )  

     , Monto_Pagado_MO_Al_Anticipar          = ( isnull(  ( select sum( CaCajMtoMon1 ) 
                                                                                       from CbMdbOpc.dbo.CaVenCaja Caj 
                                                                                      where Caj.CaNumCOntrato = MoNumContrato 
                                                                                      and Caj.CaNumEstructura = MoNumEstructura 
                                                                                      and Caj.CaCajOrigen = 'PA' 
                                                                                      and Caj.CaCajModalidad = 'C'
                                                                                      and Caj.CaCajFechaGen  =  FechaEvento  ), 0 )
                                                  + CASE WHEN evento = 'Anticipo' then Prima_Total_MO else 0.0 end
												) * Case when evento = 'Anticipo' then 1.0 else 0.0 end
                                                                     
     , Monto_Pagado_CLP_Al_Anticipar         = ( isnull(  ( select sum( CaCajMtoMon1 * isnull( Tipo_Cambio, 1 )  ) -- select * from BacParamSuda..valor_moneda_contable
                                                                                       from CbMdbOpc.dbo.CaVenCaja Caj 
                                                                                          Left join BacParamSuda.dbo.Valor_moneda_Contable VMC on VMC.Codigo_Moneda = case when Caj.CaCajMdaM1 = 13 then 994 else Caj.CaCajMdaM1 end 
                                                                                                and VmC.Fecha = FechaEvento
                                                                                      where Caj.CaNumCOntrato = MoNumContrato 
                                                                                      and Caj.CaNumEstructura = MoNumEstructura 
                                                                                      and Caj.CaCajOrigen = 'PA' 
                                                                                      and Caj.CaCajModalidad = 'C'
                                                                                      and Caj.CaCajFechaGen  =  FechaEvento ),0  )  
                                                + CASE WHEN evento = 'Anticipo' then Prima_Total_CLP else 0.0 end
												) * Case when evento = 'Anticipo' then 1.0 else 0.0 end

     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 ) 
                                                                          
                                                                   
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 ) 
    -- Este Select es para el Insert 
    -- select * from #AuxContratosDerivados4 where month(fechaevento ) = 12 and evento = 'Anticipo'


    insert into  #ContratosDerivados -- Por mientas se ejecuta prueba producto: Movi SAO no Forward
	select 	Contrato
	,	Evento
	,	SubEvento
	,	FechaEvento
	,	Rut_Contraparte
	,	DV_Rut_COntraparte
	,	Tax_ID_Contraparte
	,	Codigo_Pais_Contraparte
	,	Tipo_Relacion_con_Contraparte
	,	Modalidad_Contratacion
	,	Tipo_Acuerdo_Marco
	,	Numero_Acuerdo_Marco
	,	Fecha_Suscripcion_Acuerdo_Marco
	,	Numero_Contrato
	,	Fecha_Suscripcion_Contrato
	,	Contrato_Vencido_En_El_Ejercicio
	,	Estado_Contrato
    ,   Evento_Informado
	,	Tipo_Contrato
	,	Nombre_Instrumento
	,	Modalidad_Cumplimiento
	,	Posicion_Declarante
	,	Tipo_Activo_Subyacente
	,	Codigo_Activo_Subyacente
	,	Otro_Activo_Subyacente_Especificacion
	,	Tasa_Fija_o_Spread_Activo_Subyacente
	,	Tipo_Segundo_Activo_Subyacente
	,	Codigo_Segundo_Activo_Subyacente
	,	Otro_Segundo_Activo_Subyacente_Especificacion
	,	Tasa_Fija_o_Spread_Segundo_Activo_Subyacente
	,	Codigo_Precio_Futuro_Contratado
	,	Precio_Futuro_Contratado
	,	Moneda_Precio_Futuro_Contratado
	,	Unidad
	,	Monto_Cantidad_Contratado_o_Nocional
	,	Segunda_Unidad
	,	Segundo_Monto_Nocional
	,	Fecha_Vencimiento
	,	Fecha_Liquidacion_Ejercicio_de_Opcion
	,	Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion
	,	Precio_Mercado_Al_CIerre_o_Liquidacion
	,	Valor_Justo_Contrato
	,	Resultado_Ejercicio
	,	Cuenta_Contable_Resultado_Ejercicio
	,	Efecto_En_Patrimonio
	,	Cuenta_Contable_Registro_Patrimonio
	,	Comision_Pactada
	,	Cuenta_Contable_Registro_Comision_Pactada
	,	Prima_Total
	,	Cuenta_Contable_Registro_Prima_Total
	,	Inversion_Inicial
	,	Cuenta_Contable_Registro_Inversion_Inicial
	,	Otros_Gastos_Asociados_Al_Contrato
	,	Cuenta_Contable_Otros_Gastos
	,	Otros_Ingresos_Asociados_Al_Contrato
	,	Cuenta_Contable_Otros_Ingresos
	,	Montos_Pagos_Al_Exterior_Efectuados
	,	Modalidad_Pago_Al_Exterior_Efectuados
	,	Saldo_Garantias_Al_Cierre
	,	Rut_Cliente_Emp
	,	Codigo_Cliente_Emp
	,	Modalidad_Cumplimiento_Emp
	,	Posicion_Declarante_Emp
	,	Producto_Emp
	,	Moneda_transada_Emp
	,	moneda_compensacion_Emp
	,	Fecha_Curse_Contrato_Emp
	,	Estado_Cliente
	,	Subyacente_Papeles_de_RentaFija
	,	Unidad_Precio_Subyacente_Emp
	,	Pais_Recidencia_Contraparte_Emp
	,	cacalcmpdol_Emp
	,	Moneda_Multiplica_Divide_Emp
	,	Moneda_Conversion_Emp
	,	Modulo
	,	Precio_Fecha_Evento
	,	Precio_Fecha_Cierre_Ejercicio
	,	Monto_Pagado_MO_Al_Vcto_Compensado
	,	Monto_Pagado_CLP_Al_Vcto_Compensado
	,	Moneda_Vcto_Compensado
	,	Monto_Pagado_MO_Al_Anticipar
	,	Monto_Pagado_CLP_Al_Anticipar
	,	Moneda_Anticipar
	,	Monto_Pagado_MO_Al_Ejercer
	,	Monto_Pagado_CLP_Al_Ejercer
	,	Moneda_Ejercer
	,	Valor_Justo_Al_Evento
	,	Valor_Justo_Al_Cierre
    ,   Valor_Justo_Al_CierreAnoAnt
	,	CVOpcion
	,	CallPut
	,	Tasa_Mercado_Al_Evento
	,	Tasa_Mercado_Al_Cierre
    ,   Prima_Total_MO                        
    ,   Prima_Total_CLP
     , KeyCntId_sistema 
     , KeyCntProducto      
     , KeyCntTipOper       
     , KeyCntCallPut       
     , KeyCntMoneda2       
     , KeyCntMoneda1       
     , KeyCntModalidad     
     , KeyCntCarNormativa  
     , KeyCntSubCarNormativa 
     , CntPagoEvento       
     , CntCtaResultadoPos     
     , CntCtaVRPos            
     , CntCtaResultadoNeg     
     , CntCtaVRNeg            
     , CaNumEstructura = MoNumEstructura 
     , VR_Al_1er_Dia_Ano      
     , VR_AL_1er_Dia_Ano_Sig  
     , Vigente_CierreAnoAnt   
     , Vigente_CierreAno   
     , CntCtaCarVRPos                                                         
     , CntCtaCarVRNeg                                                         

	 from #AuxContratosDerivados4



/*************************************************************************
                             RESTO DE ESTRUCTURA SAO
*************************************************************************/
/* Vencimiento Naturales */
select  Contrato = convert( numeric(10), Det.CaNumContrato * 10 + Det.CaNumEstructura ) --CaNumOper  
      , Evento   = convert( varchar(30) , 'Vcto. Natural' )
      , SubEvento = convert( varchar(30) , 'No Aplica'  )                           -- No tengo como saber mirando solo el movimiento
      , FechaEvento = Det.CaFechaVcto  
     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 =  convert( numeric(9), Car.CaRutCliente )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99        
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( car.CaFechaContrato , '19000101') ) 
     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), 5  )         
     , Tipo_Contrato                   = convert( numeric(2), Case when Det.CaCallPut = 'Call' and Det.CaTipoPayOff = '01' then 8
                                                                   when Det.CaCallPut = 'Put'  and Det.CaTipoPayOff = '01' then 9 
                                                                   when Det.CaCallPut = 'Call' and Det.CaTipoPayOff = '02' then 10
                                                                   when Det.CaCallPut = 'Put'  and Det.CaTipoPayOff = '02' then 11
                                                                   else 0 end )         
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
     , Posicion_Declarante                    = convert(numeric(1), 0 )
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
     , Codigo_Activo_Subyacente               = space(3)
     , Otro_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
     , Codigo_Segundo_Activo_Subyacente       = space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), round( Det.CaStrike, 2) ) 
     , Moneda_Precio_Futuro_Contratado                = space(3)
     , Unidad                                         = convert(numeric(2), 0 )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( Det.CaMontoMon1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), 0 )   
     , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  -- POR HACER: solicitar integrar 4 decimales
     , Fecha_Vencimiento                              = convert( datetime, Det.CaFechaVcto )-- select * from CbMdbOpc.dbo.cadetcontrato
-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, Det.CaFechaVcto )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), 1 /*Valor Monetario*/  )
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), Car.CaRutCliente )
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), Det.CaModalidad )            -- Modalidad de cumplimiento según la empresa   
     , Posicion_Declarante_Emp         = convert( varchar(1), Det.CaCVOpc )         -- Tipo de operacion según empresa contratante
     , Producto_Emp                    = convert( varchar(5), Car.CaCodEstructura )                          -- Producto según empresa contratante
                                                                                           
     , Moneda_transada_Emp             = convert( numeric(5), Det.CaCodMon1 )              
                                                                                           
     , moneda_compensacion_Emp         = Convert( numeric(5), case when Det.CaModalidad = 'C' then Det.CaMdaCompensacion else 0  end )         
     , Fecha_Curse_Contrato_Emp        = isnull( Car.CaFechaContrato, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), space(15) )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), Det.CaMdaCompensacion )      -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), Det.CaCodMon2 )
     , Modulo                          = 'SAO       '
       -- Para DJ1829
     , Precio_Fecha_Evento                   = convert( float, 0 )
     , Precio_Fecha_Cierre_Ejercicio   = convert( float, 0 )

     -- Vcto
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 ) 
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )
     , Moneda_Vcto_Compensado                = convert( numeric(5),  case when Det.CaModalidad = 'C' then Det.CaMdaCompensacion  else 0 end ) 
                                                            

     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 ) 
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )
     , Moneda_Anticipar                      = convert( numeric(5), 0 )
     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0)                                                   
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 ) 
     , Moneda_Ejercer                        = convert( numeric(5) , 0 ) 

     -- Valor Justo
     , Valor_Justo_Al_Evento                 = convert( numeric(15),  isnull( Det.CaVrDetML, 0  )  )      
     , Valor_Justo_Al_Cierre                 = convert( numeric(15),  isnull( CarDiaCierre.CaVrDetML /* - - CarDiaCierre.CaPrimaInicialDetML */, 0 )  )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15),  isnull( CarDiaCierreAnoAnt.CaVrDetML /*- - CarDiaCierreAnoAnt.CaPrimaInicialDetML */, 0 ) )

     -- Opciones
     , CVOpcion                              = convert( varchar(1), Det.CaCVOpc )   
     , CallPut                               = convert( varchar(4), Det.CaCallPut )
     , Tasa_Mercado_Al_Evento                = Convert( float, 0.0) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, 0.0) 
     , Prima_Total_MO                        = convert( float, Det.CaPrimaInicialDet ) 
     , Prima_Total_CLP                       = Convert( float, Det.CaPrimaInicialDetML)

     , KeyCntId_sistema = 'OPT'  
     , KeyCntProducto      = Convert( varchar(3), 'OPT' )
     , KeyCntTipOper       = convert( varchar(1), Det.CaCVOpc )   
     , KeyCntCallPut       = convert( varchar(4), Det.CaCallPut )
     , KeyCntMoneda2       = convert( varchar(5), Det.CaCodMon2 )  
     , KeyCntMoneda1       = convert( varchar(5), Det.CaCodMon1 )  
     , KeyCntModalidad     = convert( varchar(1), Det.CaModalidad ) 
     , KeyCntCarNormativa  = convert( varchar(1), Car.CaCarNormativa ) --- select * from cbmdbopc.dbo.MoEncContrato
     , KeyCntSubCarNormativa = convert( varchar(1), Car.CaSubCarNormativa )      
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     



     , CaMon_vr                              = 0 -- Ya no es necesario convertir
     , MoFechaContrato                       = isnull( car.CaFechaContrato , '19000101') 
     , Det.CaFechaVcto 
     , Det.CaCodMon1
     , Car.CaNumContrato
     , CorrigeCompensacion                   = 'N'
     , Det.CaNumEstructura    
     , VR_Al_1er_Dia_Ano      =  PrimerDiaAno.CaVrDetML
     , VR_AL_1er_Dia_Ano_Sig  =  PrimerDiaAnoSig.CaVrDetML
     , Vigente_CierreAnoAnt   = 'N'   -- llenar más adelante 
     , Vigente_CierreAno      = 'N'   -- llenar más adelante                                                 
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             
               
 into #AuxContratosDerivados5    
 from CbMdbOpc.dbo.CaVenDetContrato Det
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato CarDiaCierre ON CarDiaCierre.CaDetFechaRespaldo = @FechaCierreAnnoComercial 
                                                          and CarDiaCierre.CaNumContrato = Det.CaNumCOntrato 
                                                          and CarDiaCierre.CaNumEstructura = det.CaNumEstructura
      LEFT JOIN CbMdbOpc.dbo.CaResDetContrato CarDiaCierreAnoAnt ON CarDiaCierreAnoAnt.CaDetFechaRespaldo = @FechaCierreAnnoComercialAnt 
                                                          and CarDiaCierreAnoAnt.CaNumContrato = Det.CaNumCOntrato 
                                                          and CarDiaCierreAnoAnt.CaNumEstructura = det.CaNumEstructura
     LEFT JOIN CbMdbOpc.dbo.CaResDetContrato PrimerDiaAnoSig 
              ON PrimerDiaAnoSig.CaDetFechaRespaldo = @Fecha1erDiaHabilAnnoComercialSigHab 
               and PrimerDiaAnoSig.CaNumContrato = det.CaNumCOntrato 
               and PrimerDiaAnoSig.CaNumEstructura = det.CaNumEstructura
     LEFT JOIN CbMdbOpc.dbo.CaResDetContrato PrimerDiaAno 
              ON PrimerDiaAno.CaDetFechaRespaldo = @Fecha1erDiaHabilAnnoComercialHab 
               and PrimerDiaAno.CaNumContrato = det.CaNumCOntrato 
               and PrimerDiaAno.CaNumEstructura = det.CaNumEstructura   

      LEFT JOIN CbMdbOpc.dbo.CaVenEncContrato Car ON Car.CaNumContrato = Det.CaNumContrato
  where Car.CaCodEstructura not in ( 8, 6 , 13, 14) and Car.CaEstado <> 'C'
     and Car.CaNumContrato in ( select moNumContrato from #Eventos_SAO1 )   
     -- Si en la fecha hay un movimiento no es vencimiento natural 
     and Car.CaNumContrato not in ( select moNumContrato from #Eventos_SAO1 Ev where Ev.MoTipoTransaccion = 'ANTICIPA' )
     and  Det.CaFechaVcto >= @FechaCorte
     and  Det.CaFechaVcto <= @FechaCorteFinal

update #AuxContratosDerivados5
  set      
       Precio_Fecha_Evento                   = convert( float, isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CaCodMon1 = 13 then 994 else CaCodMon1 end
                                                            AND vmfecha  =  CaFechaVcto )  ,1) )


    ,  Precio_Fecha_Cierre_Ejercicio         = convert( float,isnull( ( SELECT vmvalor
                                                           FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                          WHERE vmcodigo = Case when CaCodMon1 = 13 then 994 else CaCodMon1 end
                                                            AND vmfecha  =  @FechaCierreAnnoComercial  )  ,1)  )




    ,  Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), isnull(  ( select sum(CaCajMtoMon1)                                                          
                                                                                from CbMdbOpc.dbo.CaVenCaja Caj 
                                                                                where Caj.CaNumCOntrato = #AuxContratosDerivados5.CaNumContrato                                                              
                                                             and Caj.CaNumEstructura = #AuxContratosDerivados5.CaNumEstructura
                                                             and Caj.CaCajOrigen = 'PV' 
                                                             and Caj.CaCajModalidad = 'C'
                                                             and Caj.CaCajFechaGen  = CaFechaVcto ), 0 ) ) 
                                              -- AJUSTES INCREMENTALES DE PAGO EN OPCIONES
                                              + case when #AuxContratosDerivados5.CaNumContrato = 1881 
											          and #AuxContratosDerivados5.CaNumEstructura = 1 then 197871 else 0 end 
                                              + Prima_Total_MO  
											  + convert( numeric(15), isnull(  ( select sum(CaMTMImplicito  / isnull(VM.vmvalor,1)   )                                                       
                                                                                from CbMdbOpc.dbo.CaVenCaja Caj 
																				      left join BacParamSuda.dbo.Valor_moneda VM ON vmcodigo = case when Caj.CaCajMdaM1 = 13 then 994 else Caj.CaCajMdaM1 end  and vmfecha = CaFechaVcto 
                                                                                where Caj.CaNumCOntrato = #AuxContratosDerivados5.CaNumContrato                                                              
                                                             and Caj.CaNumEstructura = #AuxContratosDerivados5.CaNumEstructura
                                                             and Caj.CaCajOrigen = 'PV' 
                                                             and Caj.CaCajModalidad = 'E'
                                                             and Caj.CaCajFechaGen  = CaFechaVcto ), 0 ) ) 
															 -- Activa concepto desde cierta fecha
															 * ( case when CaFechaVcto >= @FecContabilizaEFSAO then 1.0 else 0 end )  
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), isnull(  ( select sum( CaCajMtoMon1 * isnull( Tipo_Cambio, 1.0 )  ) 
                                                                                       from CbMdbOpc.dbo.CaVenCaja Caj 
                                                                                          Left join BacParamSuda.dbo.Valor_moneda_Contable VMC on VMC.Codigo_Moneda = case when Caj.CaCajMdaM1 = 13 then 994 else Caj.CaCajMdaM1 end 
                                                                                                and VmC.Fecha = CaFechaVcto
                                                                                      where Caj.CaNumCOntrato = #AuxContratosDerivados5.CaNumContrato 
                                                                                      and Caj.CaNumEstructura = #AuxContratosDerivados5.CaNumEstructura -- x los Fw Asiaticos Sintéticos 
                                                                                      and Caj.CaCajOrigen = 'PV' 
                                                                                      and Caj.CaCajModalidad = 'C'
                                                                                      and Caj.CaCajFechaGen  = CaFechaVcto )    ,0  )  )
                                              -- AJUSTES INCREMENTALES DE PAGO EN OPCIONES
                                              + case when #AuxContratosDerivados5.CaNumContrato = 1881 
											          and #AuxContratosDerivados5.CaNumEstructura = 1 then 197871 else 0 end 
                                              + Prima_Total_CLP
                                              + convert( numeric(15), isnull(  ( select sum(CaMTMImplicito)                                                           
                                                                                from CbMdbOpc.dbo.CaVenCaja Caj 																				      
                                                                                where Caj.CaNumCOntrato = #AuxContratosDerivados5.CaNumContrato                                                              
                                                             and Caj.CaNumEstructura = #AuxContratosDerivados5.CaNumEstructura
                                                             and Caj.CaCajOrigen = 'PV' 
                                                             and Caj.CaCajModalidad = 'E'
                                                             and Caj.CaCajFechaGen  = CaFechaVcto ), 0 ) ) 
                                                			 -- Activa concepto desde cierta fecha
															 * ( case when CaFechaVcto >= @FecContabilizaEFSAO then 1.0 else 0 end )  



insert into  #ContratosDerivados
	select 	Contrato
	,	Evento
	,	SubEvento
	,	FechaEvento
	,	Rut_Contraparte
	,	DV_Rut_COntraparte
	,	Tax_ID_Contraparte
	,	Codigo_Pais_Contraparte
	,	Tipo_Relacion_con_Contraparte
	,	Modalidad_Contratacion
	,	Tipo_Acuerdo_Marco
	,	Numero_Acuerdo_Marco
	,	Fecha_Suscripcion_Acuerdo_Marco
	,	Numero_Contrato
	,	Fecha_Suscripcion_Contrato
	,	Contrato_Vencido_En_El_Ejercicio
	,	Estado_Contrato
    ,   Evento_Informado
	,	Tipo_Contrato
	,	Nombre_Instrumento
	,	Modalidad_Cumplimiento
	,	Posicion_Declarante
	,	Tipo_Activo_Subyacente
	,	Codigo_Activo_Subyacente
	,	Otro_Activo_Subyacente_Especificacion
	,	Tasa_Fija_o_Spread_Activo_Subyacente
	,	Tipo_Segundo_Activo_Subyacente
	,	Codigo_Segundo_Activo_Subyacente
	,	Otro_Segundo_Activo_Subyacente_Especificacion
	,	Tasa_Fija_o_Spread_Segundo_Activo_Subyacente
	,	Codigo_Precio_Futuro_Contratado
	,	Precio_Futuro_Contratado
	,	Moneda_Precio_Futuro_Contratado
	,	Unidad
	,	Monto_Cantidad_Contratado_o_Nocional
	,	Segunda_Unidad
	,	Segundo_Monto_Nocional
	,	Fecha_Vencimiento
	,	Fecha_Liquidacion_Ejercicio_de_Opcion
	,	Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion
	,	Precio_Mercado_Al_CIerre_o_Liquidacion
	,	Valor_Justo_Contrato
	,	Resultado_Ejercicio
	,	Cuenta_Contable_Resultado_Ejercicio
	,	Efecto_En_Patrimonio
	,	Cuenta_Contable_Registro_Patrimonio
	,	Comision_Pactada
	,	Cuenta_Contable_Registro_Comision_Pactada
	,	Prima_Total
	,	Cuenta_Contable_Registro_Prima_Total
	,	Inversion_Inicial
	,	Cuenta_Contable_Registro_Inversion_Inicial
	,	Otros_Gastos_Asociados_Al_Contrato
	,	Cuenta_Contable_Otros_Gastos
	,	Otros_Ingresos_Asociados_Al_Contrato
	,	Cuenta_Contable_Otros_Ingresos
	,	Montos_Pagos_Al_Exterior_Efectuados
	,	Modalidad_Pago_Al_Exterior_Efectuados
	,	Saldo_Garantias_Al_Cierre
	,	Rut_Cliente_Emp
	,	Codigo_Cliente_Emp
	,	Modalidad_Cumplimiento_Emp
	,	Posicion_Declarante_Emp
	,	Producto_Emp
	,	Moneda_transada_Emp
	,	moneda_compensacion_Emp
	,	Fecha_Curse_Contrato_Emp
	,	Estado_Cliente
	,	Subyacente_Papeles_de_RentaFija
	,	Unidad_Precio_Subyacente_Emp
	,	Pais_Recidencia_Contraparte_Emp
	,	cacalcmpdol_Emp
	,	Moneda_Multiplica_Divide_Emp
	,	Moneda_Conversion_Emp
	,	Modulo
	,	Precio_Fecha_Evento
	,	Precio_Fecha_Cierre_Ejercicio
	,	Monto_Pagado_MO_Al_Vcto_Compensado
	,	Monto_Pagado_CLP_Al_Vcto_Compensado
	,	Moneda_Vcto_Compensado
	,	Monto_Pagado_MO_Al_Anticipar
	,	Monto_Pagado_CLP_Al_Anticipar
	,	Moneda_Anticipar
	,	Monto_Pagado_MO_Al_Ejercer
	,	Monto_Pagado_CLP_Al_Ejercer
	,	Moneda_Ejercer
	,	Valor_Justo_Al_Evento
	,	Valor_Justo_Al_Cierre
    ,   Valor_Justo_Al_CierreAnoAnt
	,	CVOpcion
	,	CallPut
	,	Tasa_Mercado_Al_Evento
	,	Tasa_Mercado_Al_Cierre
    ,   Prima_Total_MO
    ,   Prima_Total_CLP     
     , KeyCntId_sistema 
     , KeyCntProducto      
     , KeyCntTipOper       
     , KeyCntCallPut       
     , KeyCntMoneda2       
     , KeyCntMoneda1       
     , KeyCntModalidad     
     , KeyCntCarNormativa  
     , KeyCntSubCarNormativa    
     , CntPagoEvento       
     , CntCtaResultadoPos     
     , CntCtaVRPos            
     , CntCtaResultadoNeg     
     , CntCtaVRNeg            
     , CaNumEstructura 
     , VR_Al_1er_Dia_Ano      
     , VR_AL_1er_Dia_Ano_Sig  
     , Vigente_CierreAnoAnt   
     , Vigente_CierreAno  
     , CntCtaCarVRPos                                                         
     , CntCtaCarVRNeg                                                         

	 from  #AuxContratosDerivados5

-- ********** COMENTAR POR MIENTRAS **/


/*************************************************************************
                             BACSWAP
*************************************************************************/

select fecha_cierre
     , Numero_operacion
     , tipo_flujo
     , numero_flujo
     , fechaliquidacion 
     , estado 
     , Origen = 'VIG', Fecha_Termino, Fecha_Inicio_Flujo, IntercPrinc, Fecha_vence_Flujo 
       -- Para Operaciones muy antiguas no hay RES !!!     
     , Rut_Cliente
     , Codigo_Cliente
     , Modalidad_Pago
     , Tipo_Swap = case when numero_operacion = 5285 then 4 
                        when numero_operacion = 5510 then 2
                        else tipo_Swap end
	into #SwapPrimerBarrido   
from BacSwapSuda.dbo.cartera  where estado <> 'C'  -- and ( fecha_inicio_Flujo <> Fecha_vence_flujo or ( tipo_Swap = 2  and IntercPrinc = 1 ) )
union
select fecha_Cierre
     , Numero_operacion
     , tipo_flujo
     , numero_flujo
     , fechaliquidacion 
     , estado 
     , Origen = 'VEN', Fecha_Termino, Fecha_Inicio_Flujo, IntercPrinc, Fecha_vence_Flujo
       -- Para Operaciones muy antiguas no hay RES !!!     
     , Rut_Cliente
     , Codigo_Cliente
     , Modalidad_Pago
     , Tipo_Swap
from BacSwapSuda.dbo.carterahis where estado <> 'C'  --and ( fecha_inicio_Flujo <> Fecha_vence_flujo or ( tipo_Swap = 2  and IntercPrinc = 1 ))


select Distinct CarHis.Numero_Operacion
              , CarUnw.FechaAnticipo
              , Fechas.fechaProx
              , Total_Parcial = space(7)              
 into #Anticipos_Swap
 from BacSwapSuda.dbo.CarteraHis CarHis
     -- Se usa right para que no aparezcan anticipos 
     -- en formato antiguo que ya no aplican en DJ
     right join BacSwapSuda.dbo.CARTERA_UNWIND CarUnw ON CarUnw.numero_operacion = CarHis.Numero_operacion
     left join  bacswapsuda.dbo.swapgeneralhis Fechas ON Fechas.fechaProc = CarUnw.FechaAnticipo
where CarHis.Estado = 'N'  -- Solo Anticipos
union 
 select Distinct CarHis.Numero_Operacion
              , FechaAnticipo = fechaLiquidacion
              , Fechas.fechaProx
              , Total_Parcial = space(7)               
 from BacSwapSuda.dbo.CarteraHis CarHis
     -- Se usa right para que no aparezcan anticipos 
     -- en formato antiguo que ya no aplican en DJ     
     left join  bacswapsuda.dbo.swapgeneralhis Fechas ON Fechas.fechaProc = CarHis.fechaLiquidacion
where CarHis.Estado = 'N'  -- Solo Anticipos
-- select * from #Anticipos_Swap where numero_operacion = 8455

update #Anticipos_Swap
    set  Total_Parcial =    isnull( ( select max('PARCIAL') from bacSwapSuda.dbo.CarteraRES Res 
                                          where Res.Fecha_Proceso = #Anticipos_Swap.fechaProx and 
                                                Res.Numero_operacion = #Anticipos_Swap.Numero_Operacion ), 'TOTAL' )



-- select * from #SwapSegundoBarrido where numero_operacion = 5285
-- Swap Cursados en el año (año mes cuando estemos en una DJ-1820
select distinct car.Numero_operacion, Fecha_Evento = car.Fecha_Cierre, Evento = 'Curse'  
      -- Para Operaciones muy antiguas no hay RES !!!
     , Estado         = isnull( MovHis.Estado, Car.Estado )
     , Rut_Cliente    = isnull( MovHis.Rut_Cliente, Car.Rut_Cliente )
     , Codigo_Cliente = isnull( MovHis.Codigo_Cliente, Car.Codigo_Cliente ) 
     , Modalidad_Pago = isnull( MovHis.Modalidad_Pago, Car.Modalidad_Pago ) 
     , Fecha_Cierre   = isnull( MovHis.Fecha_Cierre, Car.Fecha_Cierre ) 
     , Fecha_termino  = isnull( MovHis.Fecha_Termino, Car.Fecha_termino )
     , Tipo_Swap      = isnull( MovHis.Tipo_Swap, Car.Tipo_Swap ) 
	 , SubEvento      = 'No Aplica'
   into #SwapSegundoBarrido  
from #SwapPrimerBarrido car
      left join #Anticipos_Swap ant ON car.numero_operacion = ant.Numero_operacion  and car.fechaLiquidacion = ant.FechaAnticipo
      left join BacSwapSuda..MovHistorico MovHis ON MovHis.Numero_Operacion = Car.numero_operacion 
	  -- En las modificaciones updatean el rut
	  -- No es viable navegar  CarteraRES.
       where  car.fecha_termino  > @FechaCierreAnnoComercialAnt -- MAP 20130211  Lo que vence en el @anno o posterior        
             and (        isnull( ant.FechaAnticipo, '19000101' ) = '19000101'  -- Sin Anticipo              
                      or  ant.FechaAnticipo  >= @FechaCorte  )  -- Anticipo en el año comercial
             and Car.Estado <> 'C'


UNION
-- Swap que liquidan en el año
select distinct SwapBar.Numero_operacion, 
                Fecha_Evento = case when SwapBar.numero_operacion = 906 
                                      and SwapBar.fechaLiquidacion = '20120918' -- Caso especial por mala grabación
                                    then '20120920'
                               else   
                                    SwapBar.fechaLiquidacion
                               end,
--                Evento = case when Fecha_Termino = Fecha_vence_Flujo then 'Vcto. Natural' else 'Liquidacion'  end
                Evento = case when SwapBar.Fecha_Termino = SwapBar.FechaLiquidacion then 'Vcto. Natural' else 'Liquidacion'  end
      -- Para Operaciones muy antiguas no hay RES !!!
     , Estado         = isnull( MovHis.Estado, SwapBar.Estado )
     , Rut_Cliente    = isnull( MovHis.Rut_Cliente, SwapBar.Rut_Cliente )
     , Codigo_Cliente = isnull( MovHis.Codigo_Cliente, SwapBar.Codigo_Cliente )
     , Modalidad_Pago = isnull( MovHis.Modalidad_Pago, SwapBar.Modalidad_Pago )
     , Fecha_Cierre   = isnull( MovHis.Fecha_Cierre, SwapBar.Fecha_Cierre )
     , Fecha_Termino  = isnull( MovHis.fecha_termino, SwapBar.fecha_termino )
     , Tipo_Swap      = isnull( MovHis.Tipo_Swap, SwapBar.Tipo_Swap )
	 , SubEvento      = 'No Aplica'
from #SwapPrimerBarrido SwapBar
      left join BacSwapSuda..MovHistorico MovHis ON MovHis.Numero_Operacion = SwapBar.numero_operacion
     where SwapBar.fechaLiquidacion >= @FechaCorte  /* MAP 20130211 */ and SwapBar.estado = ' '  
     and SwapBar.numero_operacion not in ( select numero_operacion from #Anticipos_Swap 
                                       where #Anticipos_Swap.numero_operacion = SwapBar.numero_operacion 
                                             and Total_Parcial = 'TOTAL' and SwapBar.fechaLiquidacion > fechaAnticipo  )

     and ( SwapBar.fecha_inicio_Flujo <> SwapBar.Fecha_vence_flujo or ( SwapBar.tipo_Swap = 2  and SwapBar.IntercPrinc = 1 ))

UNION
-- Swap Anticipados en el año
select distinct Ant.Numero_operacion, Fecha_Evento = Ant.fechaLiquidacion, Evento = 'Anticipo'  
      -- Para Operaciones muy antiguas no hay RES !!!
     , Ant.Estado
     , Ant.Rut_Cliente
     , Ant.Codigo_Cliente
     , Ant.Modalidad_Pago
     , Ant.Fecha_Cierre
     , Fecha_Termino = isnull(( select max(Fecha_Termino) from BacSwapSuda.dbo.CarteraHis His 
                          where His.Numero_operacion = Ant.numero_operacion
                             and His.Estado = ' ' ), 
                                  ( select max(Fecha_Termino) from BacSwapSuda.dbo.MovHistorico MovHis 
                          where MovHis.Numero_operacion = Ant.numero_operacion
                             and MovHis.Estado = ' ' ) ) 
                                 
     , Ant.Tipo_Swap
	 , SubEvento      = isnull( Ant2.Total_Parcial, 'No Aplica' )
from #SwapPrimerBarrido Ant     -- select * from #SwapPrimerBarrido where numero_operacion = 6579 -- select * from #Anticipos_Swap
         Left join  #Anticipos_Swap Ant2 ON Ant.numero_operacion = Ant2.numero_operacion and Ant.fechaLiquidacion = Ant2.FechaAnticipo  
   where  Ant.estado = 'N' and Ant.fechaLiquidacion  >= @FechaCorte  /* MAP 20130211 */      
UNION
-- Swap Modificados en el año
select distinct Numero_operacon = FolioContrato, Fecha_evento = FechaModificacion, Evento = 'Cesion' 
      -- Para Operaciones muy antiguas no hay RES !!!
     , Estado = CarRes.estado
     , Rut_Cliente = case when FolioContrato in (997,1043,1238,1340,1341,1441,1516,1524,1525,1534) 
	                    then 413045200 -- Novación 11 de septiembre 2013
	                    else CarRes.Rut_Cliente end
     , Codigo_Cliente = CarRes.Codigo_Cliente 
     , Modalidad_Pago = CarRes.Modalidad_pago
     , Fecha_Cierre   = CarRes.Fecha_Cierre 
     , Fecha_termino  = CarRes.Fecha_termino
     , Tipo_Swap      = CarRes.Tipo_Swap 
	 , SubEvento      = 'No Aplica'
from BacLineas..TBL_MODIFICACIAONES -- 
	  left join BacSwapSuda..carteraRES CarRes ON CarRes.Numero_Operacion = FolioCOntrato and fecha_proceso = FechaModificacion  
	  -- Viable y obligatoria navegación en la RES debido a que el volumen de sesiones es poco.
where modulo = 'PCS' and  fechaModificacion  >= @FechaCorte /* MAP 20130211 */
  and CarRes.Estado  <> 'N'   
  and DatosOriginales <> DatosNuevos and items = 'RUT'
union  
  select distinct Numero_operacon = FolioContrato, Fecha_evento = FechaModificacion, Evento = 'Modificacion' 
      -- Para Operaciones muy antiguas no hay RES !!!
     , Estado = CarRes.Estado 
     , Rut_Cliente = case when FolioContrato in (997,1043,1238,1340,1341,1441,1516,1524,1525,1534) 
	                    then 413045200 -- Novación 11 de septiembre 2013
	                    else CarRes.Rut_Cliente end
     , Codigo_Cliente = CarRes.Codigo_Cliente
     , Modalidad_Pago = CarRes.Modalidad_Pago 
     , Fecha_Cierre   = CarRes.Fecha_Cierre 
     , Fecha_termino  = CarRes.Fecha_termino  
     , Tipo_Swap      = CarRes.Tipo_Swap  
	 , SubEvento      = 'No Aplica'

from BacLineas..TBL_MODIFICACIAONES 
      Left Join BacSwapSuda..CarteraRes CarRes ON CarRes.Numero_operacion = FolioContrato  and CarRes.Fecha_Proceso = FechaModificacion  
	  -- Viable la navegación por el volumne bajo de información   
where modulo = 'PCS' and  fechaModificacion  >= @FechaCorte /* MAP 20130211 */
  and isnull( CarRes.Estado , CarRes.Estado ) <> 'N' 
  and DatosOriginales = DatosNuevos and items = 'RUT'  -- No se modificó el Rut
  

-- Corregir con lo que haya de la RES al día del evento
Update #SwapSegundoBarrido
    Set Tipo_Swap = isnull( CRes.Tipo_Swap , #SwapSegundoBarrido.Tipo_Swap )
      , Fecha_Termino = isnull( CRes.Fecha_Termino , #SwapSegundoBarrido.Fecha_Termino )
      , Modalidad_Pago = isnull( CRes.Modalidad_Pago , #SwapSegundoBarrido.Modalidad_Pago )
	  , Rut_Cliente = isnull(CRes.Rut_Cliente, #SwapSegundoBarrido.Rut_Cliente )
	  , Codigo_Cliente = isnull( CRes.Codigo_Cliente, #SwapSegundoBarrido.Codigo_Cliente )
from  BacSwapSuda..CarteraRES CRes where #SwapSegundoBarrido.numero_operacion = CRes.Numero_Operacion
                                      and #SwapSegundoBarrido.Fecha_Evento    = CRes.Fecha_Proceso
                                      -- and #SwapSegundoBarrido.Evento <> 'Curse'  
									  and  #SwapSegundoBarrido.Evento <> 'Modificacion' 
									  and  #SwapSegundoBarrido.Evento <> 'Cesion' 

-- select 'Debug  #SwapSegundoBarrido', * from #SwapSegundoBarrido where numero_operacion = 8455 order by fecha_Evento


-- Eliminar los eventos que no han sucedido
-- en el periodo
delete #SwapSegundoBarrido where Fecha_Evento > @FechaCorteFinal 


-- Eliminar eventos repetidos por cambio de cliente en SWAP
/* Comentar por mientras porque ya no debería generarse repetición 
delete #SwapSegundoBarrido where Rut_Cliente = 97043000 and NUmero_operacion = 6862 and Evento = 'Modificacion' 
delete #SwapSegundoBarrido where Rut_Cliente = 97043000 and NUmero_operacion = 5798 and Evento = 'Modificacion' 
delete #SwapSegundoBarrido where Rut_Cliente = 97043000 and NUmero_operacion = 5817 and Evento = 'Modificacion' 
*/

-- Eliminar Contrato que fue ingresado como real pero no lo era
/*
De: Tania Moncada Maulen 
Enviado el: lunes, 21 de abril de 2014 9:40
Para: María Paz Navarro Genta
Asunto: Reversa Utilidad 760701028

Maria Paz,

La operación 8.773 de swap fue ingresada por error por tanto no correspondía la contabilidad que generó el día 15/04 por tanto se reversa con fecha 17/04 por la utilidad $ 280.759.182.-


*/
delete #SwapSegundoBarrido where numero_operacion = 8773


/* Corrige los Rut informando todo contra el Rut indicado
   al cierre del año comercias */
/*
update #SwapSegundoBarrido   -- select * from #SwapSegundoBarrido where numero_operacion in ( 5798, 5817, 6862 )
   Set  Rut_Cliente    = CarCierreAno.Rut_Cliente
      , Codigo_Cliente =  CarCierreAno.Codigo_Cliente
from 	BacSwapSuda.dbo.CarteraRES CarCierreAno
     where  CarCierreAno.fecha_Proceso =  @FechaCierreAnnoComercial and #SwapSegundoBarrido.numero_Operacion = CarCierreAno.numero_Operacion
	 Ya no debería ser necesario esto !!!*/

select Distinct 
       SB.Numero_Operacion
    ,  SB.Estado         -- CRes.Estado
    ,  SB.Rut_Cliente    -- CRes.Rut_Cliente
    ,  SB.Codigo_Cliente -- CRes.Codigo_Cliente
    ,  SB.Modalidad_Pago -- CRes.Modalidad_Pago 
    ,  Moneda_Pago = convert( numeric(5), 0 ) /*CRes.recibimos_Moneda +  CRes.pagamos_moneda */ /*Case when CRes.Modalidad_Pago = 'C' then CRes.pagamos_moneda + CRes.recibimos_Moneda else 0 end )*/
    ,  SB.Fecha_Cierre   -- CRes.Fecha_Cierre
    ,  SB.Fecha_Termino  -- CRes.Fecha_Termino

 --   ,  CRes.fecha_Vence_flujo
    ,  SB.Tipo_Swap      -- CRes.Tipo_Swap 
    ,  cre_cartera_normativa = isnull( CRes.cre_cartera_normativa, 'F' )
    ,  cre_SubCartera_normativa =  isnull( CRes.cre_SubCartera_normativa , 'F' )
    ,  Moneda_1     = convert( numeric(5), 0 ) 
    ,  Nominal_1    = Convert( numeric(15,2), 0 )
    ,  Tasa_Tipo_1  = Convert( numeric(5),  0 )
    ,  Tasa_Valor_1 = Convert( numeric(7,4), 0 )
    ,  Spread_1     = Convert( numeric(7,4), 0 )
    ,  Flujo_Adic_1 = Convert( numeric(15,2), 0 )
    ,  Moneda_2     = convert( numeric(5), 0 ) 
    ,  Nominal_2    = Convert( numeric(15,2), 0 )
    ,  Tasa_Tipo_2  = Convert( numeric(5),  0 )
    ,  Tasa_Valor_2 = Convert( numeric(7,4), 0 )
    ,  Spread_2     = Convert( numeric(7,4), 0 )
    ,  Flujo_Adic_2 = Convert( numeric(15,2), 0 )
    ,  SB.Fecha_Evento
    ,  SB.Evento
    ,  Hay_Flujo1    = 0
    ,  Hay_Flujo2    = 0
    ,  recibimos_monto_clpAnticipo = Convert( numeric(15,2), 0 )
    ,  pagamos_monto_clpAnticipo = Convert( numeric(15,2), 0 )
    ,  VR_Al_Evento              = Convert( numeric(15,2), isnull( CRes.Valor_RazonableCLP, 0 ) ) -- select * from bacSwapsuda..cartera
    ,  VR_Al_Cierre              = Convert( numeric(15,2), 0 ) 
    ,  VR_Al_CierreAnoAnt        = Convert( numeric(15,2), 0 )
    ,  Actualiza_Data            = 'N'
     , VR_Al_1er_Dia_Ano      =  convert( float, null )
     , VR_AL_1er_Dia_Ano_Sig  =  convert( float, null )
	 , SB.SubEvento

into #SwapContratos 
from #SwapSegundoBarrido SB
     LEFT JOIN BacSwapSuda.dbo.CarteraRES  CRes ON CRes.fecha_Proceso = SB.Fecha_evento 
                                and CRes.Numero_Operacion = SB.Numero_operacion and CRes.Tipo_Flujo = 1
  
update #SwapContratos
      set    VR_Al_Cierre              = Convert( numeric(15,2), isnull( CRes.Valor_RazonableCLP, 0 ) ) 
                                           -- Ajuste de AVR de Pargua
                                           -- son varias operaciones pero se informa
                                           -- en operacion 2411, primera operacion vigente 
                                           -- al cierre 2012.
                                    /*     + case when #SwapContratos.Numero_Operacion = 2411 and @AjustesPargua = 'SI' then 66603429 else 0 end */
               
           , cre_cartera_normativa     =  CRes.cre_cartera_normativa   -- Por los cambios de cartera y que debe cuadrar AVR al fin de año
           , cre_SubCartera_normativa =   CRes.cre_Subcartera_normativa
           , Tipo_Swap = CRes.Tipo_Swap                             
from BacSwapSuda.dbo.CarteraRES CRes  
   where
          CRes.fecha_Proceso = @FechaCierreAnnoComercial 
      and CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.Estado_Flujo in ( 1, 2 ) -- Flujo que indica el Saldo de la operacion, ahora es para que no haga tanto update

-- IMPORTANTE:
-- Puede ser que los campos cre_cartera_normativa, cre_SubCartera_normativa y Tipo_Swap esté nulo, por no haber RES al cierre
-- debido a que el contrato fue anticipado o venció a tal fecha. Si queda nulo se recuperará de el primer registro de la tabla 
-- CarteraRES del año
-- MAP ACA 
 -- select 'debug', estado, estado_flujo, * from BacSwapSuda.dbo.carteraRES where  numero_operacion = 6048 and fecha_proceso = '20130128' -- 25012013'
 --select 'debug', '@Fecha1erDiaHabilAnnoComercialHab', @Fecha1erDiaHabilAnnoComercialHab
update #SwapContratos
      set     cre_cartera_normativa     =  CRes.cre_cartera_normativa   -- Por los cambios de cartera y que debe cuadrar AVR al fin de año
           , cre_SubCartera_normativa =   CRes.cre_Subcartera_normativa           
from BacSwapSuda.dbo.CarteraRES CRes  
   where
          CRes.fecha_Proceso =  @Fecha1erDiaHabilAnnoComercialHab 
      and CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.Estado_Flujo in ( 1, 2 ) -- Flujo que indica el Saldo de la operacion, ahora es para que no haga tanto update
	  and  ( #SwapContratos.cre_cartera_normativa = 'F' or  #SwapContratos.cre_Subcartera_normativa = 'F' )
 

update #SwapContratos
      set    VR_Al_CierreAnoAnt        = Convert( numeric(15,2), isnull( CRes.Valor_RazonableCLP, 0 ) )
                                           -- Ajuste de AVR de Pargua
                                           -- son varias operaciones pero se informa
                                           -- en operacion 2411, primera operacion vigente 
                                           -- al cierre 2012.
                                        -- + case when #SwapContratos.Numero_Operacion = 2411 and @AjustesPargua = 'SI' then 139692440 else 0 end
from BacSwapSuda.dbo.CarteraRES CRes  
   where
          CRes.fecha_Proceso = @FechaCierreAnnoComercialAnt 
      and CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.Estado_Flujo in ( 1, 2 ) -- Flujo que indica el Saldo de la operacion, ahora es para que no haga tanto update

-- Modificando
update #SwapContratos
      set    VR_Al_1er_Dia_Ano        = Convert( numeric(15,2), isnull( CRes.Valor_RazonableCLP, 0 ) )
from BacSwapSuda.dbo.CarteraRES CRes  
   where
          CRes.fecha_Proceso = @Fecha1erDiaHabilAnnoComercialHab
      and CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.Estado_Flujo in ( 1, 2 ) -- Flujo que indica el Saldo de la operacion, ahora es para que no haga tanto update

update #SwapContratos
      set    VR_Al_1er_Dia_Ano_Sig    = Convert( numeric(15,2), isnull( CRes.Valor_RazonableCLP, 0 ) )
from BacSwapSuda.dbo.CarteraRES CRes  
   where
          CRes.fecha_Proceso = @Fecha1erDiaHabilAnnoComercialSigHab
      and CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.Estado_Flujo in ( 1, 2 ) -- Flujo que indica el Saldo de la operacion, ahora es para que no haga tanto update



-- Los datos d epago deben salir de la HIS usando como base la RES.
update #SwapContratos 
    set  Moneda_1    = CRes.Compra_Moneda
       , Nominal_1   = case when CRes.numero_flujo = 1 then CRes.Compra_capital else CRes.Compra_Saldo + CRes.Compra_Amortiza + CRes.Compra_flujo_adicional end
       , Tasa_Tipo_1 = CRes.Compra_Codigo_Tasa
       , Tasa_Valor_1 = case when  CRes.Compra_Codigo_tasa = 0 then CRes.Compra_Valor_tasa else 0 end
       , Spread_1     = CRes.Compra_spread 
       , Flujo_Adic_1 = CRes.Compra_Flujo_Adicional
       , Hay_Flujo1   = case when  (   Chis.Compra_flujo_Adicional 
                                     + Chis.Compra_Interes 
                                     + CHis.Compra_Amortiza * CHis.IntercPrinc ) <> 0
                                 then 1 else 0 end
       , Moneda_Pago = CRes.recibimos_moneda 
       , Actualiza_Data            = 'S'
-- select  evento, * from #SwapContratos where numero_operacion = 764
 
from  BacSwapSuda.dbo.CarteraRES Cres   
   LEFT JOIN BacSwapSuda.dbo.CarteraHIS Chis ON CHis.Numero_operacion = CRes.Numero_operacion    
                                             AND CHis.Numero_Flujo = CRes.Numero_Flujo    
                                             AND CHis.Tipo_Flujo = 1      
   where
          CRes.fecha_Proceso = #SwapContratos.Fecha_evento           
      and CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.tipo_Flujo = 1           -- Flujos activos en que los campos Compra
                                        -- tienen valor significativo.
      and (    Cres.Estado_Flujo = 2  and ( #SwapContratos.Evento = 'Liquidacion'  or #SwapContratos.Evento = 'Anticipo' or #SwapContratos.Evento = 'Vcto. Natural' )/* MOLEB 12 Junio 2013 */ 
          ) /* MOLEB 12 Junio 2013 */	

/* Se corrige por observación MOLEB, montos extraños MOLEB 12 Junio 2014  */
update #SwapContratos 
    set  Moneda_1    = CRes.Compra_Moneda
       , Nominal_1   = case when CRes.numero_flujo = 1 then CRes.Compra_capital else CRes.Compra_Saldo + CRes.Compra_Amortiza + CRes.Compra_flujo_adicional end
       , Tasa_Tipo_1 = CRes.Compra_Codigo_Tasa
       , Tasa_Valor_1 = case when  CRes.Compra_Codigo_tasa = 0 then CRes.Compra_Valor_tasa else 0 end
       , Spread_1     = CRes.Compra_spread 
       , Flujo_Adic_1 = CRes.Compra_Flujo_Adicional
       , Hay_Flujo1   = case when  (   Chis.Compra_flujo_Adicional 
                                     + Chis.Compra_Interes 
                                     + CHis.Compra_Amortiza * CHis.IntercPrinc ) <> 0
                                 then 1 else 0 end
       , Moneda_Pago = CRes.recibimos_moneda 
       , Actualiza_Data            = 'S'
-- select  evento, * from #SwapContratos where numero_operacion = 7343
 
from  BacSwapSuda.dbo.CarteraRES Cres   
   LEFT JOIN BacSwapSuda.dbo.CarteraHIS Chis ON CHis.Numero_operacion = CRes.Numero_operacion    
                                             AND CHis.Numero_Flujo = CRes.Numero_Flujo    
                                             AND CHis.Tipo_Flujo = 1      
   where
          CRes.fecha_Proceso = #SwapContratos.Fecha_evento           
      and CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.tipo_Flujo = 1           -- Flujos activos en que los campos Compra
                                        -- tienen valor significativo.
      and Cres.Estado_Flujo in ( 1 )    -- Flujo que indica el Saldo de la operacion
	  and Actualiza_Data = 'N'
/* Se corrige por observación MOLEB, montos extraños MOLEB 12 Junio 2014 */

-- Casos en que no se puede usar como Base la RES.
update #SwapContratos 
    set  Moneda_1    = CRes.Compra_Moneda
       , Nominal_1   = case when CRes.numero_flujo = 1 then CRes.Compra_capital else CRes.Compra_Saldo + CRes.Compra_Amortiza + CRes.Compra_flujo_adicional end
       , Tasa_Tipo_1 = CRes.Compra_Codigo_Tasa
       , Tasa_Valor_1 = case when  CRes.Compra_Codigo_tasa = 0 then CRes.Compra_Valor_tasa else 0 end
       , Spread_1     = CRes.Compra_spread 
       , Flujo_Adic_1 = CRes.Compra_Flujo_Adicional
       , Hay_Flujo1   = case when  (   Cres.Compra_flujo_Adicional 
                                     + Cres.Compra_Interes 
                                     + Cres.Compra_Amortiza * Cres.IntercPrinc ) <> 0
                                 then 1 else 0 end                        
       , Moneda_Pago =   Cres.recibimos_Moneda 
       , Actualiza_Data            = 'S'
 
from  BacSwapSuda.dbo.CarteraHis Cres   
   
   where
          CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.tipo_Flujo = 1           -- Flujos activos en que los campos Compra
                                        -- tienen valor significativo.
      and Cres.estado = ' '
      and Actualiza_Data            = 'N'

-- Actualización de campos Compra Ahora
update #SwapContratos 
    set Actualiza_data = 'N'

update #SwapContratos 
    set  Moneda_2    = CRes.Venta_Moneda
       , Nominal_2   = case when CRes.numero_flujo = 1 then CRes.Venta_capital else CRes.Venta_Saldo + CRes.Venta_Amortiza  + CRes.Venta_Flujo_Adicional end
       , Tasa_Tipo_2 = CRes.Venta_Codigo_Tasa
       , Tasa_Valor_2 = case when  CRes.Venta_Codigo_tasa = 0 then CRes.Venta_Valor_tasa else 0 end
       , Spread_2     = CRes.Venta_spread 
       , Flujo_Adic_2 = CRes.Venta_Flujo_Adicional
       , Hay_Flujo2   = case when  (   CHis.Venta_flujo_Adicional 
                                     + CHis.Venta_Interes 
                                     + CHis.Venta_Amortiza * CHis.IntercPrinc ) <> 0
                                    then 1 else 0 end
       , Moneda_Pago =  case when Moneda_Pago = 0 then  Cres.pagamos_Moneda else Moneda_Pago end
       , Actualiza_Data            = 'S'
from  BacSwapSuda.dbo.CarteraRES Cres  -- BacSwapSuda.dbo.CarteraRES Cres 
   LEFT JOIN BacSwapSuda.dbo.CarteraHIS Chis ON CHis.Numero_operacion = CRes.Numero_operacion    
                                             AND CHis.Numero_Flujo = CRes.Numero_Flujo    
                                             AND CHis.Tipo_Flujo = 2      

   where    
          CRes.fecha_Proceso = #SwapContratos.Fecha_evento 
      and CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.tipo_Flujo = 2           -- Flujos pasivos en que los campos Venta
                                        -- tienen valor significativo.
   and (    Cres.Estado_Flujo = 2  and ( #SwapContratos.Evento = 'Liquidacion'  or #SwapContratos.Evento = 'Anticipo' or #SwapContratos.Evento = 'Vcto. Natural' )/* MOLEB 12 Junio 2013 */ 
        ) /* MOLEB 12 Junio 2013 */	

/* Se corrige por observación MOLEB, montos extraños MOLEB 12 Junio 2014 */
update #SwapContratos 
    set  Moneda_2    = CRes.Venta_Moneda
       , Nominal_2   = case when CRes.numero_flujo = 1 then CRes.Venta_capital else CRes.Venta_Saldo + CRes.Venta_Amortiza  + CRes.Venta_Flujo_Adicional end
       , Tasa_Tipo_2 = CRes.Venta_Codigo_Tasa
       , Tasa_Valor_2 = case when  CRes.Venta_Codigo_tasa = 0 then CRes.Venta_Valor_tasa else 0 end
       , Spread_2     = CRes.Venta_spread 
       , Flujo_Adic_2 = CRes.Venta_Flujo_Adicional
       , Hay_Flujo2   = case when  (   CHis.Venta_flujo_Adicional 
                                     + CHis.Venta_Interes 
                                     + CHis.Venta_Amortiza * CHis.IntercPrinc ) <> 0
                                    then 1 else 0 end
       , Moneda_Pago =  case when Moneda_Pago = 0 then  Cres.pagamos_Moneda else Moneda_Pago end
       , Actualiza_Data            = 'S'
from  BacSwapSuda.dbo.CarteraRES Cres   
   LEFT JOIN BacSwapSuda.dbo.CarteraHIS Chis ON CHis.Numero_operacion = CRes.Numero_operacion    
                                             AND CHis.Numero_Flujo = CRes.Numero_Flujo    
                                             AND CHis.Tipo_Flujo = 2      

   where    
          CRes.fecha_Proceso = #SwapContratos.Fecha_evento 
      and CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.tipo_Flujo = 2           -- Flujos pasivos en que los campos Venta
                                        -- tienen valor significativo.
      and Cres.Estado_Flujo in ( 1 ) -- Flujo 1 indica flujo vigente /* MOLEB 12 Junio 2013 */
	  and Actualiza_Data            = 'N'


/* Se corrige por observación MOLEB, montos extraños MOLEB 12 Junio 2014 */
-- Caso en que no se puede usar la RES como tabla base
update #SwapContratos 
    set  Moneda_2    = CRes.Venta_Moneda
       , Nominal_2   = case when CRes.numero_flujo = 1 then CRes.Venta_capital else CRes.Venta_Saldo + CRes.Venta_Amortiza  + CRes.Venta_Flujo_Adicional end
       , Tasa_Tipo_2 = CRes.Venta_Codigo_Tasa
       , Tasa_Valor_2 = case when  CRes.Venta_Codigo_tasa = 0 then CRes.Venta_Valor_tasa else 0 end
       , Spread_2     = CRes.Venta_spread 
       , Flujo_Adic_2 = CRes.Venta_Flujo_Adicional
       , Hay_Flujo2   = case when  (   CRes.Venta_flujo_Adicional 
                                     + CRes.Venta_Interes 
                                     + CRes.Venta_Amortiza * CRes.IntercPrinc ) <> 0
                                    then 1 else 0 end
       , Moneda_Pago =  case when Moneda_Pago = 0 then  Cres.pagamos_Moneda else Moneda_Pago end
       , Actualiza_Data            = 'S'
from  BacSwapSuda.dbo.CarteraHIS CRes 
   where    
          CRes.Numero_Operacion = #SwapContratos.Numero_operacion  
      and Cres.tipo_Flujo = 2           -- Flujos pasivos en que los campos Venta
                                        -- tienen valor significativo.
      and Cres.estado = ' '
      and Actualiza_Data            = 'N'



update #SwapContratos set modalidad_pago = case when modalidad_pago = 'E' and tipo_Swap = 1 then 'C' else  modalidad_pago end

-- select * from #ContratosDerivados where contrato = 8455

insert into #ContratosDerivados
select   Contrato = convert( numeric(10), RescateDat.Numero_Operacion )            

      , Evento   = convert( varchar(30) , RescateDat.Evento )

      , SubEvento = convert( varchar(30) , case when RescateDat.Evento = 'Curse'  then 'No Aplica'
                                               when RescateDat.Evento  = 'Modificacion' then  'No Aplica'
                                               when RescateDat.Evento  = 'Anticipo' then  RescateDat.SubEvento -- 'TOTAL' -- POR HACER: Checar cuando el anticipo es total o parcial 
                                               else 'No Aplica' end  )   
                            
      , FechaEvento = RescateDat.Fecha_Evento 

     -- Info solicitada por MOLEB:
     -- Datos del cliente quedan para llenar 
     -- Datos de contrato solo los que no requieren traducción
     , Rut_Contraparte                 =  convert( numeric(9), Rut_Cliente  )
     , DV_Rut_COntraparte              = '0'
     , Tax_ID_Contraparte              = space(15)  
     , Codigo_Pais_Contraparte         = '??'
     , Tipo_Relacion_con_Contraparte   = 99    
    
     , Modalidad_Contratacion          = convert( numeric(2), 6 )                  -- POR HACER: 6 -> Otra... confirmar con Contabilidad
     , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
     , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
     , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
     , Numero_Contrato                 = convert( varchar(10), 0 )
     , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( RescateDat.Fecha_Cierre , '19000101') ) 

     -- DJ1829 presenta de manera acumulada los contratos
     -- esto significa que por ejemplo estamos cargando un anticipo 
     -- parcial y luego la operación es anticipada total en otro
     -- evento. En fin, este campo no se puede evaluar viendo 
     -- aisladamente el evento.
     , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
     , Estado_Contrato                  = 0                                                -- DJ 1829
     , Evento_Informado                = convert( numeric(1), case when RescateDat.Evento = 'Curse'  then 1
                                               when RescateDat.Evento = 'Modificacion' then  2  
											   when RescateDat.Evento = 'Cesion' then 3                                             
                                               when RescateDat.Evento = 'Anticipo' then  4
                                               when RescateDat.Evento = 'Vcto. Natural' then 5 
                                               else 4 end  )         

     , Tipo_Contrato                   = convert( numeric(2), Case when RescateDat.Tipo_Swap = 2 then 4 else 3 end ) -- Cross y resto
     , Nombre_Instrumento                     = space(20)
     , Modalidad_Cumplimiento                 = convert(numeric(1), case when RescateDat.Modalidad_Pago = 'C' then 1 else 2 end )
     , Posicion_Declarante                    = convert(numeric(1), 0 )    -- Notar que no está resuelto para MX-MX no USD
     , Tipo_Activo_Subyacente                 = convert(numeric(1), 2 )    -- Tasa de Interes              
     , Codigo_Activo_Subyacente               = case when RescateDat.Tasa_Tipo_1 = 0 then '1  ' else '2  '  end       -- space(3)  

     , Otro_Activo_Subyacente_Especificacion  = isnull( (select substring( convert( varchar(15), COD_TIV) , 1, 15)  
                                                      from #TA_GNL_TSA_INT_VAR 
                                                      where COD_TIV_EMP = Tasa_Tipo_1 and COD_MDA = Moneda_1) , '40' + space(13) )
                                                      -- space(15)

     , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), Tasa_Valor_1 + Spread_1 )
     , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 2 )                  -- Tasa de Interés 
     , Codigo_Segundo_Activo_Subyacente       = case when RescateDat.Tasa_Tipo_2 = 0 then '1  ' else '2  '  end -- space(3)
     , Otro_Segundo_Activo_Subyacente_Especificacion  = isnull( ( select substring( convert( varchar(15), COD_TIV), 1, 15)  
                                                      from #TA_GNL_TSA_INT_VAR 
                                                      where COD_TIV_EMP = Tasa_Tipo_2 and COD_MDA = Moneda_2) , '40' + space(13) )

     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), Tasa_Valor_2 + Spread_2 )     

     , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )          -- No aplica Swap          
     , Precio_Futuro_Contratado                       = convert(numeric(15,2), 0 )       -- No aplica Swap
     , Moneda_Precio_Futuro_Contratado                = space(3)                         -- No aplica Swap


     , Unidad                                         = convert(numeric(2), isnull( (select max( COD_UMM ) 
                                                                      from #TA_GNL_UND_MNA_MID_EMP 
                                                                      where COD_UMM_EMP =
                                                                                  case when Modalidad_Pago = 'C' 
                                                                                       then Moneda_Pago else moneda_1 end) , 13) 
                                                                )   
     , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round( Nominal_1, 2) )  
     , Segunda_Unidad                                 = convert(numeric(2), isnull( (select max( COD_UMM ) 
                                                                      from #TA_GNL_UND_MNA_MID_EMP 
                                                                      where COD_UMM_EMP = case when Modalidad_Pago = 'C' 
                                                                                       then Moneda_Pago else moneda_2 end ), 13) 
                                                                )      

     , Segundo_Monto_Nocional                         = convert(numeric(15,2), round( Nominal_2, 2) )  
     , Fecha_Vencimiento                              = convert( datetime, Fecha_Termino )-- select * from CbMdbOpc.dbo.cadetcontrato

-- DJ1829
     , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, RescateDat.Fecha_Evento )            
     , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), 2 ) /* 2 Tasa*/ 
     , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )      /* no hay tasa de mercado para los Swap */
     , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
     , Resultado_Ejercicio                            = convert( numeric(15), 0 )
     , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
     , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
     , Comision_Pactada                               = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
     , Prima_Total                                    = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Prima_Total           = convert( varchar(15), '' )
     , Inversion_Inicial                              = convert( numeric(15), 0 )
     , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
     , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
     , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
     , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
     , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
     , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 1 )        -- 1. Pago en dinero
     , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
-- DJ1829

     -- Datos necesarios para rescatar información
     , Rut_Cliente_Emp                 = convert( numeric(13), Rut_Cliente )
     , Codigo_Cliente_Emp              = convert( numeric(8),1 )
     , Modalidad_Cumplimiento_Emp      = convert( varchar(1), Modalidad_Pago )            -- Modalidad de cumplimiento según la empresa   

                                       -- Ojo que es Varchar(1)
     , Posicion_Declarante_Emp         = convert( varchar(10),  'X'  )     
     , Producto_Emp                    = convert( varchar(5), Tipo_Swap )                   -- Tipo de operacion según empresa contratante         
                                                                                           
     , Moneda_transada_Emp             = convert( numeric(5), 0 )              
                                                                                           
     , moneda_compensacion_Emp         = Convert( numeric(5), Moneda_Pago  )         

     , Fecha_Curse_Contrato_Emp        = isnull( Fecha_Cierre, '19000101' )
     , Estado_Cliente                  = 'CLIENTE NO ESTA EN BD DEL DECLARANTE    '
     , Subyacente_Papeles_de_RentaFija = convert( varchar(15), space(15) )
     , Unidad_Precio_Subyacente_Emp    = convert(numeric(5),0)
     , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
     , cacalcmpdol_Emp                 = convert( numeric(5), 0 )      -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
     , Moneda_Conversion_Emp           = convert( numeric(5), 0 )
     , Modulo                          = 'BacSwap   '
       -- Para DJ1829 Datos necesario para rescatar información
     , Precio_Fecha_Evento                   = convert( float,  0.0) 
     , Precio_Fecha_Cierre_Ejercicio         = convert( float, 0.0 ) -- @FechaCierreAnnoComercial

     -- Vcto      
     , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )
     , Moneda_Vcto_Compensado                = convert( numeric(15), 0 )

     -- Anticipo
     , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), isnull( 
													( select distinct recibimos_monto 
													   from BacSwapsuda.dbo.CARTERA_UNWIND  -- select * from Bacswapsuda..CARTERA_UNWIND
													  where numero_operacion = RescateDat.Numero_Operacion  
													  and fechaAnticipo = RescateDat.Fecha_Evento  and 
													   tipo_flujo = 1 )
													- 
													( select distinct pagamos_monto 
													   from BacSwapsuda.dbo.CARTERA_UNWIND 
													  where numero_operacion = RescateDat.Numero_Operacion  
													   and fechaAnticipo = RescateDat.Fecha_Evento  
													   and tipo_flujo = 2 )
                                                     , 0 ) )
     , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 ) -- calcular en base al monto origen y convertir al observado
                                                                  
     , Moneda_Anticipar                      = convert( numeric(5) , isnull( 
                                                    ( select distinct recibimos_moneda 
													   from BacSwapsuda.dbo.CARTERA_UNWIND  -- select * from Bacswapsuda..CARTERA_UNWIND
													  where numero_operacion = RescateDat.Numero_Operacion  
													  and fechaAnticipo = RescateDat.Fecha_Evento  and 
													   tipo_flujo = 1 ) -- Se graba en ambos tipos de flujo !!!

                                              , 0 ) )
     -- Ejercer
     , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
     , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
     , Moneda_Ejercer                        = convert( numeric(5) , 0 )

     -- Valor Justo 

     , Valor_Justo_Al_Evento                 = convert( numeric(15), VR_Al_Evento  )
     , Valor_Justo_Al_Cierre                 = convert( numeric(15), VR_Al_Cierre )
     , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), VR_Al_CierreAnoAnt )

     -- Opciones
     , CVOpcion                              = convert( varchar(1), '' )
     , CallPut                               = convert( varchar(4), '' )
     , Tasa_Mercado_Al_Evento                = Convert( float, 0 ) 
     , Tasa_Mercado_Al_Cierre                = Convert( float, 0 )  
     , Prima_Total_MO                        = convert( float, 0.0)
     , Prima_Total_CLP                       = Convert( float, 0.0)
 
       -- Claves Contablidad
     , KeyCntId_sistema = 'PCS'
     , KeyCntProducto      = Convert( varchar(3), RescateDat.Tipo_Swap )
     , KeyCntTipOper       = convert( varchar(1), '' )  /* no Aplcia para Swap */
     , KeyCntCallPut       = convert( varchar(4), '' )  /* no aplica para Swap */

     , KeyCntMoneda2       = convert( varchar(5), RescateDat.Moneda_1   ) 

     , KeyCntMoneda1       = convert( varchar(5), RescateDat.Moneda_Pago )  
     , KeyCntModalidad     = convert( varchar(1), RescateDat.Modalidad_pago ) 
     , KeyCntCarNormativa  = convert( varchar(1), RescateDat.cre_cartera_normativa)
     , KeyCntSubCarNormativa = convert( varchar(1), RescateDat.Cre_SubCartera_Normativa )   -- select * from BacSwapSuda.dbo.carteraRES   
     , CntPagoEvento       = convert( numeric(15), 0 )
     , CntCtaResultadoPos     = convert( varchar(9), 0 )
     , CntCtaVRPos            = convert( varchar(9), 0 )
     , CntCtaResultadoNeg     = convert( varchar(9), 0 )
     , CntCtaVRNeg            = convert( varchar(9), 0 )     
     , CaNumEstructura = 0
     , VR_Al_1er_Dia_Ano      
     , VR_AL_1er_Dia_Ano_Sig  
     , Vigente_CierreAnoAnt   = 'N' 
     , Vigente_CierreAno      = 'N'
     , CntCtaCarVRPos            = convert( varchar(9), 0 )                                             
     , CntCtaCarVRNeg            = convert( varchar(9), 0 )                                             
   
 from #SwapContratos RescateDat 
 
 -- AnticipoEl monto en CLP se calcula en base al MO Origen convertido al valor observado.
 update #ContratosDerivados
    set Monto_Pagado_CLP_Al_Anticipar = round(  Monto_Pagado_MO_Al_Anticipar 
                                * isnull( ( select vmvalor from BacParamSuda..Valor_moneda 
                                              where vmcodigo = case when Moneda_Anticipar = 13 then 994 else Moneda_Anticipar end
                                                and vmfecha = FechaEvento ), 1 ), 0 )
    where KeyCntId_Sistema = 'PCS' and Monto_Pagado_MO_Al_Anticipar <> 0

-- Modificación especifica de Montos pagados al anticipar SWAP

-- Afecta Cuenta 760701030 560701030 May
update #ContratosDerivados
   set Monto_Pagado_CLP_Al_Anticipar = 500632942
  where KeyCntId_Sistema = 'PCS' and contrato = 1740 and fechaevento = '20130524' and evento = 'Anticipo'

-- Afecta Cuenta 760701030 560701030 Sep
update #ContratosDerivados
   set Monto_Pagado_CLP_Al_Anticipar = 13160216 - 40780
  where KeyCntId_Sistema = 'PCS' and contrato = 7477 and fechaevento = '20130903' and evento = 'Anticipo'

-- Modificación especifica de Montos pagados al anticipar FORWARD
-- 2014
-- Operación requiere ajuste por pago adicional al cliente.
-- 
/* TRANF. A TABLA
update #ContratosDerivados  set Monto_Pagado_CLP_Al_Anticipar = -10064462 - 97461 
where KeyCntId_Sistema = 'BFW' and contrato = 572417 and fechaevento = '20140120' and evento = 'Anticipo'

update #ContratosDerivados  set Monto_Pagado_CLP_Al_Anticipar = -16734528 + 40680 
where KeyCntId_Sistema = 'BFW' and contrato = 574253 and fechaevento = '20140211' and evento = 'Anticipo'

update #ContratosDerivados  set Monto_Pagado_CLP_Al_Anticipar = -17787389 + 116957
where KeyCntId_Sistema = 'BFW' and contrato = 575575 and fechaevento = '20140325' and evento = 'Anticipo'

update #ContratosDerivados  set Monto_Pagado_CLP_Al_Anticipar = -12650546 + 33454
where KeyCntId_Sistema = 'BFW' and contrato = 575266 and fechaevento = '20140404' and evento = 'Anticipo'

-- Digitan anticipo , anulan , vuelven hacer... al final no se digitó el monto correctamente.
update #ContratosDerivados  set Monto_Pagado_CLP_Al_Anticipar = -3938812 + -1495757
where KeyCntId_Sistema = 'BFW' and contrato = 574767 and fechaevento = '20140430' and evento = 'Anticipo'

update #ContratosDerivados  set Monto_Pagado_CLP_Al_Anticipar = -15775591 + 84693
where KeyCntId_Sistema = 'BFW' and contrato = 577030 and fechaevento = '20140513' and evento = 'Anticipo'
*/

-- Modificación especifica de Montos pagados  FORWARD (no seguros de cambio ni arbitraje)
/* TRANF. a TABLA
update #ContratosDerivados
   set Monto_Pagado_CLP_Al_Vcto_Compensado = 4666477000 - 4666477000 + 2523000
  where KeyCntId_Sistema = 'BFW' and contrato = 568068 and fechaevento = '20140109' and evento = 'Vcto. Natural'

update #ContratosDerivados
   set Monto_Pagado_CLP_Al_Vcto_Compensado = 23317458000 - 23317458000 -23042000
  where KeyCntId_Sistema = 'BFW' and contrato = 561789 and fechaevento = '20140307' and evento = 'Vcto. Natural'

update #ContratosDerivados
   set Monto_Pagado_CLP_Al_Vcto_Compensado = 6503107775 - 6503107775 + 1563000
  where KeyCntId_Sistema = 'BFW' and contrato = 573708  and fechaevento = '20140307' and evento = 'Vcto. Natural'
update #ContratosDerivados
   set Monto_Pagado_CLP_Al_Vcto_Compensado = -11820472975 + 11820472975 + 118090000
  where KeyCntId_Sistema = 'BFW' and contrato = 563214  and fechaevento = '20140409' and evento = 'Vcto. Natural'
update #ContratosDerivados
   set Monto_Pagado_CLP_Al_Vcto_Compensado = 96093000 - 1500000
  where KeyCntId_Sistema = 'BFW' and contrato = 563298   and fechaevento = '20140509' and evento = 'Vcto. Natural'
update #ContratosDerivados
   set Monto_Pagado_CLP_Al_Vcto_Compensado = 35209 - 35209
  where KeyCntId_Sistema = 'BFW' and contrato = 547845  and fechaevento = '20140210' and evento = 'Liq Hip'
update #ContratosDerivados
   set Monto_Pagado_CLP_Al_Vcto_Compensado = 14821 + 165
  where KeyCntId_Sistema = 'BFW' and contrato = 547848  and fechaevento = '20140210' and evento = 'Liq Hip'
*/


-- Distribución de ajuste de 40,161 en Seguros de Inflación Hipotecario
/* TRANF. a TABLA
update #ContratosDerivados  set Monto_Pagado_CLP_Al_Vcto_Compensado = 40230 - 15425  where KeyCntId_Sistema = 'BFW' and contrato = 547845 and fechaevento = '20140110' and evento = 'Liq Hip'

update #ContratosDerivados  set Monto_Pagado_CLP_Al_Vcto_Compensado = 25865 - 9917   where KeyCntId_Sistema = 'BFW' and contrato = 547849 and fechaevento = '20140110' and evento = 'Liq Hip'
update #ContratosDerivados  set Monto_Pagado_CLP_Al_Vcto_Compensado = 16935 - 6495   where KeyCntId_Sistema = 'BFW' and contrato = 547848 and fechaevento = '20140110' and evento = 'Liq Hip'
update #ContratosDerivados  set Monto_Pagado_CLP_Al_Vcto_Compensado = 14236 - 5458   where KeyCntId_Sistema = 'BFW' and contrato = 547847 and fechaevento = '20140110' and evento = 'Liq Hip'
update #ContratosDerivados  set Monto_Pagado_CLP_Al_Vcto_Compensado = 7472 - 2866   where KeyCntId_Sistema = 'BFW' and contrato = 547846 and fechaevento = '20140110' and evento = 'Liq Hip'
*/ 


update #ContratosDerivados 
      set  Contrato_Vencido_En_el_Ejercicio = Case when VR_AL_1er_Dia_Ano_Sig = VR_AL_1er_Dia_Ano_Sig
                                              -- Si el valor es NULL (no existe) la expresion es falsa
                                              -- Null significa que no habia "RES" el primer dia
                                              -- del año comercial siguiente, por lo tanto 
                                              -- no está vigente al año comercial
                                              then 2 else 1 end
         , Vigente_CierreAnoAnt             = Case when VR_AL_1er_Dia_Ano = VR_AL_1er_Dia_Ano
                                                and Fecha_Suscripcion_Contrato < @Fecha1erDiaHabilAnnoComercialHab
                                                    -- Seg. Inf. Hipotecarios en verificacion 
                                                    -- Mnadé e-mail el 25-07-2013 a Tania Mondaca
                                                 or ( contrato in ( 547844, 547845, 547846, 547847, 547848, 547849 ) and Modulo = 'BacForward' )												 
                                                then 'S'
                                              else 'N' end
         , Vigente_CierreAno                =  Case when VR_AL_1er_Dia_Ano_Sig = VR_AL_1er_Dia_Ano_Sig		                                            
                                              then 
											       'S'
                                              else case  -- Al vcto el campo Valor Razonable de los Seguros Ifl. Hip. quedan 
											             -- con valor nulo haciendo pebre el criterio de vigencia.
											             when contrato in ( 547845 , 547846,	547847,	547848,	547849 ) and modulo = 'BacForward'
											                 and Fecha_Vencimiento > @FechaCorteFinal
											             then 'S'
												   else 
											       'N' 
												   end
										      end 

--update #ContratosDerivados  set Valor_Justo_Al_Cierre	= 0 where Vigente_CierreAno = 'N'
--
--update #ContratosDerivados  set Valor_Justo_Al_CierreAnoAnt = 0 where Vigente_CierreAnoAnt = 'N'

-- Gestionar grabacion definitiva
-- Generados con Planilla INSERT_GeneracionFolios.xls, hoja "Folios Consumidos 2012" (copiar sentencias
-- en color amarillo.
CREATE TABLE #GeneraFolioSII ( Modulo VarChar(10), ContratoBAC Numeric(10), Estructura Numeric(5), UltimoFolioUtilizado numeric(10), FechaActRegistro datetime, Evento Varchar(30), SubEvento Varchar(30) )
CREATE INDEX  I#GeneraFolioSII ON #GeneraFolioSII
               ( Modulo, ContratoBAC  )

/* Solo genera insert para el año 2013  */
/* Se debe renovar cada año             */
/* con los contratos que queda vig.     */
--/* Comentar solo cuando se esté procesando el primer año DJ 
Insert #GeneraFolioSII Select 'BacForward', 547845, 13, 24, '20130820', 'Liq Hip', 'No aplica'
Insert #GeneraFolioSII Select 'BacForward', 547846, 13, 24, '20130820', 'Liq Hip', 'No aplica'
Insert #GeneraFolioSII Select 'BacForward', 547847, 13, 24, '20130820', 'Liq Hip', 'No aplica'
Insert #GeneraFolioSII Select 'BacForward', 547848, 13, 24, '20130820', 'Liq Hip', 'No aplica'
Insert #GeneraFolioSII Select 'BacForward', 547849, 13, 24, '20130820', 'Liq Hip', 'No aplica'
Insert #GeneraFolioSII Select 'BacSwap', 81, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 427, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 470, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 471, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 489, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 491, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 527, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 531, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 532, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 534, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 535, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 543, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 561, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 562, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 579, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 580, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 583, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 584, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 601, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 602, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 644, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 673, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 675, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 681, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 684, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 712, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 719, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 725, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 745, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 746, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 747, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 756, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 759, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 760, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 761, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 762, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 764, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 773, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 791, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 792, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 794, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 796, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 798, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 801, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 855, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 875, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 876, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 877, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 881, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 888, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 898, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 903, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 911, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 917, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 918, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 932, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 936, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 938, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 939, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 950, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 955, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 957, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 958, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 959, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 962, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 978, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 991, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 997, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1014, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1019, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1030, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1031, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1037, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1038, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1039, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1043, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1045, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1048, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1050, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1053, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1056, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1058, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1060, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1065, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1066, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1069, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1071, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1072, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1073, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1076, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1082, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1085, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1087, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1093, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1100, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1105, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1106, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1107, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1108, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1109, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1111, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1118, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1120, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1121, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1122, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1131, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1134, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1143, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1144, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1146, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1148, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1149, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1150, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1152, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1156, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1161, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1165, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1169, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1170, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1174, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1175, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1177, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1179, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1180, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1181, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1187, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1190, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1200, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1201, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1205, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1206, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1211, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1221, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1223, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1224, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1228, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1233, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1234, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1237, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1238, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1239, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1248, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1252, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1262, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1268, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1269, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1284, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1288, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1289, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1295, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1296, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1300, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1303, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1305, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1306, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1307, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1311, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1314, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1315, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1318, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1321, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1322, 1, 9, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1326, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1330, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1332, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1334, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1335, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1340, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1341, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1345, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1346, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1351, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1353, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1354, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1355, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1356, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1360, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1364, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1373, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1374, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1375, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1376, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1383, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1400, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1405, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1413, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1423, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1425, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1426, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1428, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1430, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1441, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1444, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1445, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1446, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1454, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1455, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1457, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1458, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1459, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1460, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1461, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1465, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1466, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1467, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1472, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1473, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1475, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1481, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1483, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1486, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1488, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1490, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1491, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1492, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1493, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1494, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1495, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1496, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1497, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1501, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1504, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1509, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1514, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1515, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1516, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1524, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1525, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1532, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1533, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1534, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1535, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1536, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1537, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1540, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1544, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1545, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1556, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1557, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1559, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1560, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1569, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1574, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1576, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1579, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1585, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1588, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1590, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1592, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1593, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1594, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1595, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1596, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1597, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1600, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1601, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1602, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1603, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1604, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1605, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1606, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1607, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1608, 2, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1609, 2, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1610, 2, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1611, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1612, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1615, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1616, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1617, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1621, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1626, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1627, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1628, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1630, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1635, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1639, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1640, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1641, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1642, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1645, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1647, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1649, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1653, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1659, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1662, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1674, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1675, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1678, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1679, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1687, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1692, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1693, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1707, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1711, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1715, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1717, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1718, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1719, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1721, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1726, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1741, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1742, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1746, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1752, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1763, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1766, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1776, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1782, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1790, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1796, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1798, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1800, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1802, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1806, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1808, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1809, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1810, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1811, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1812, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1813, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1815, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1823, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1829, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1839, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1840, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1844, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1848, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1856, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1873, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1875, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1882, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1890, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1892, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1898, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1900, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1903, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1904, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1906, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1907, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1919, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1931, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1933, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1937, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1965, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1966, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1971, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1972, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1973, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1974, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1976, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1981, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1986, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1988, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1989, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1990, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1992, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1993, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1994, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 1995, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2002, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2005, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2012, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2015, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2016, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2019, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2024, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2025, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2026, 1, 9, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2035, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2036, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2043, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2044, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2045, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2046, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2050, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2069, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2071, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2074, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2085, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2090, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2091, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2097, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2105, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2121, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2142, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2145, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2146, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2153, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2169, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2181, 4, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2182, 4, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2189, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2191, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2192, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2193, 1, 25, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2196, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2204, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2207, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2211, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2224, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2225, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2226, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2236, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2238, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2251, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2252, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2260, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2263, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2264, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2271, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2272, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2286, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2287, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2288, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2291, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2299, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2302, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2304, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2305, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2306, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2307, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2309, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2310, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2311, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2312, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2316, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2321, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2323, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2333, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2339, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2340, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2343, 1, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2347, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2357, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2358, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2372, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2380, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2383, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2384, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2385, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2386, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2388, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2393, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2403, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2410, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2411, 4, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2412, 2, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2417, 4, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2439, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2440, 2, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2457, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2458, 2, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2459, 2, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2460, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2461, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2463, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2469, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2470, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2503, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2504, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2505, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2509, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2512, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2526, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2539, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2542, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2546, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2549, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2569, 1, 25, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2570, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2571, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2586, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2597, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2598, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2601, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2604, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2605, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2611, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2612, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2614, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2616, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2620, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2624, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2643, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2647, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2652, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2664, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2672, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2674, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2675, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2682, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2684, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2686, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2688, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2689, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2691, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2692, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2699, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2702, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2717, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2718, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2720, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2721, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2722, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2723, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2725, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2727, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2729, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2734, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2737, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2743, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2751, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2756, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2760, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2766, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2777, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2778, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2779, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2780, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2782, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2785, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2786, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2787, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2789, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2790, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2792, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2799, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2801, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2805, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2806, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2809, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2811, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2812, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2813, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2815, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2816, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2817, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2819, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2822, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2967, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2972, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2980, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2981, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2982, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2983, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2984, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2985, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2988, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2989, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2990, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3024, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3037, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3038, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3050, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3064, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3065, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3066, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3068, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3089, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3090, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3096, 2, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3100, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3101, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3102, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3106, 1, 16, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3107, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3110, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3111, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3117, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3118, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3121, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3124, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3125, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3127, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3130, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3132, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3134, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3135, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3142, 1, 9, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3143, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3147, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3154, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3166, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3170, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3172, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3173, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3175, 2, 25, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3178, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3181, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3183, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3184, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3185, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3193, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3194, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3203, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3222, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3224, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3242, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3243, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3245, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3246, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3248, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3249, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3250, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3252, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3254, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3260, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3261, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3263, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3264, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3265, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3266, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3268, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3274, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3275, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3284, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3293, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3294, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3295, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3296, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3297, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3298, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3301, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3304, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3305, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3306, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3307, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3312, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3313, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3314, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3321, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3322, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3325, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3334, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3335, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3336, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3338, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3356, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3359, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3361, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3363, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3368, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3370, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3374, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3375, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3376, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3377, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3382, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3384, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3387, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3395, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3401, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3402, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3405, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3409, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3411, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3412, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3416, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3420, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3422, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3434, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3438, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3439, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3440, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3441, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3442, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3443, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3447, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3451, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3452, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3453, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3455, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3457, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3458, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3459, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3463, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3465, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3467, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3470, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3471, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3473, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3474, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3475, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3476, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3477, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3487, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3488, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3492, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3495, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3499, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3500, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3506, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3507, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3508, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3509, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3510, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3514, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3515, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3516, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3548, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3550, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3552, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3558, 4, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3563, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3564, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3569, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3573, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3575, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3576, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3577, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3578, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3585, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3591, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3598, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3600, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3602, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3603, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3608, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3609, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3610, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3611, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3627, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3629, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3631, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3634, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3639, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3642, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3643, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3644, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3651, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3654, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3658, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3659, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3660, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3661, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3662, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3663, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3664, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3665, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3666, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3668, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3670, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3671, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3672, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3673, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3676, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3678, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3682, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3691, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3692, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3697, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3702, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3706, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3715, 2, 16, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3724, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3725, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3727, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3738, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3739, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3745, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3747, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3748, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3749, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3754, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3769, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3783, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3786, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3787, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3788, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3790, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3798, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3799, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3801, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3802, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3803, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3804, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3805, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3806, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3813, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3814, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3815, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3816, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3817, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3830, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3831, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3832, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3834, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3835, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3836, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3838, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3839, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3841, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3842, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3843, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3844, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3845, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3846, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3847, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3850, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3851, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3856, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3859, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3860, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3861, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3862, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3865, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3872, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3873, 4, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3875, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3876, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3878, 4, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3879, 4, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3880, 4, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3882, 4, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3883, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3884, 4, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3887, 4, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3888, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3889, 4, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3890, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3891, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3893, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3894, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3895, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3899, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3900, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3901, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3902, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3906, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3910, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3933, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3934, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3936, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3937, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3938, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3939, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3941, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3942, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3943, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3944, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3956, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3958, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3962, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3963, 1, 9, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3964, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3967, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3970, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3971, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3976, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3977, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3978, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3980, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3987, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3992, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3994, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3995, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3996, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3998, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 3999, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4005, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4009, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4011, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4013, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4014, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4015, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4016, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4019, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4020, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4022, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4024, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4028, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4032, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4033, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4034, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4060, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4061, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4064, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4069, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4071, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4072, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4073, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4077, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4078, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4083, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4086, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4087, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4088, 4, 5, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4091, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4095, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4113, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4114, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4115, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4116, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4117, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4119, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4120, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4121, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4123, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4124, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4125, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4126, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4133, 1, 25, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4142, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4143, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4146, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4148, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4149, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4160, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4167, 2, 20, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4168, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4169, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4170, 1, 9, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4171, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4172, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4173, 1, 9, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4179, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4180, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4181, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4182, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4186, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4187, 4, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4189, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4195, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4196, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4197, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4202, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4203, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4210, 2, 21, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4213, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4225, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4230, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4231, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4232, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4234, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4237, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4240, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4247, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4248, 4, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4250, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4256, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4257, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4261, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4262, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4265, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4267, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4268, 1, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4279, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4282, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4285, 1, 9, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4287, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4288, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4289, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4290, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4294, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4301, 2, 23, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4310, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4314, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4315, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4316, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4317, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4321, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4322, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4323, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4324, 2, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4325, 2, 25, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4333, 2, 24, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4337, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4338, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4340, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4347, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4348, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4350, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4359, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4361, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4362, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4365, 2, 23, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4367, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4368, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4380, 2, 16, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4386, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4387, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4391, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4395, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4399, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4400, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4404, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4405, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4408, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4409, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4411, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4412, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4434, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4435, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4455, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4458, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4459, 2, 22, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4460, 1, 9, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4461, 1, 9, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4464, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4466, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4467, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4468, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4472, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4474, 2, 23, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4477, 2, 23, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4485, 2, 22, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4486, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4491, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4492, 2, 22, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4493, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4494, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4495, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4499, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4504, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4505, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4506, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4507, 4, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4510, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4511, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4517, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4520, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4521, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4522, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4523, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4525, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4528, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4529, 2, 22, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4530, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4532, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4533, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4536, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4539, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4540, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4543, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4544, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4558, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4559, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4561, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4563, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4565, 1, 9, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4567, 2, 21, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4568, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4569, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4571, 2, 20, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4572, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4573, 1, 8, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4575, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4576, 2, 21, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4577, 1, 8, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4578, 2, 21, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4579, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4580, 1, 8, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4581, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4582, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4586, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4593, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4594, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4595, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4596, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4597, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4598, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4601, 1, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4604, 2, 21, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4606, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4607, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4608, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4609, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4610, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4614, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4615, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4616, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4617, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4619, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4622, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4623, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4624, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4626, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4627, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4631, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4632, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4633, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4634, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4635, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4636, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4637, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4639, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4642, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4646, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4647, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4649, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4652, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4653, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4654, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4655, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4658, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4664, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4669, 2, 21, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4670, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4672, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4674, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4675, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4677, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4678, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4682, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4686, 2, 21, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4690, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4691, 2, 21, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4694, 1, 21, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4696, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4698, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4700, 2, 20, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4703, 2, 20, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4704, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4705, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4707, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4708, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4709, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4710, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4711, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4712, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4713, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4714, 2, 20, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4716, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4717, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4719, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4721, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4722, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4724, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4725, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4729, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4732, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4734, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4738, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4739, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4740, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4744, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4745, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4758, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4759, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4760, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4761, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4762, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4763, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4768, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4774, 4, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4775, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4778, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4779, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4782, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4791, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4792, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4793, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4794, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4800, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4801, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4802, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4803, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4804, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4809, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4811, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4812, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4813, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4814, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4815, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4817, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4818, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4820, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4821, 2, 15, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4824, 2, 20, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4825, 2, 20, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4826, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4827, 2, 20, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4831, 2, 19, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4832, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4833, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4834, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4835, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4837, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4839, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4840, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4841, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4849, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4850, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4852, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4853, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4854, 2, 8, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4855, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4856, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4863, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4864, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4867, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4868, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4876, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4880, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4882, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4883, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4884, 2, 19, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4885, 2, 19, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4886, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4889, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4890, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4891, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4893, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4894, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4896, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4897, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4899, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4900, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4907, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4908, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4910, 2, 19, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4913, 2, 19, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4916, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4919, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4922, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4923, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4924, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4926, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4931, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4933, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4934, 1, 19, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4935, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4936, 2, 19, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4939, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4940, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4955, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4956, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4958, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4959, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4960, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4961, 2, 19, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4965, 1, 18, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4966, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4969, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4972, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4974, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4975, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4981, 1, 6, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4985, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4986, 1, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4996, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4998, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4999, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5000, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5001, 1, 19, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5002, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5003, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5007, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5009, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5011, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5015, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5016, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5017, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5018, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5020, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5021, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5022, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5029, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5030, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5031, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5032, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5033, 2, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5036, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5037, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5038, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5039, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5040, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5041, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5051, 2, 18, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5055, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5057, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5060, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5061, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5062, 2, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5063, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5066, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5069, 2, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5071, 2, 18, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5074, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5079, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5095, 1, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5115, 1, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5117, 1, 2, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5125, 2, 4, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5129, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5136, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5146, 2, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5148, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5149, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5158, 2, 4, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5163, 2, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5171, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5172, 2, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5176, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5188, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5197, 1, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5202, 2, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5213, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5216, 1, 16, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5217, 1, 17, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5223, 4, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5233, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5235, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5238, 2, 16, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5262, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5272, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5281, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5290, 2, 16, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5291, 2, 16, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5307, 1, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5313, 1, 16, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5323, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5328, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5329, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5338, 2, 16, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5341, 1, 18, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5346, 2, 15, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5350, 2, 15, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5351, 1, 15, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5355, 2, 15, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5357, 2, 15, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5358, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5359, 2, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5418, 2, 14, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5424, 2, 14, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5429, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5433, 1, 5, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5439, 2, 14, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5484, 2, 15, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5490, 1, 1, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5491, 1, 1, '20130820', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5499, 1, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5500, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5501, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5502, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5503, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5504, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5505, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5506, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5507, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5508, 1, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5522, 1, 7, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5535, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5536, 2, 15, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5543, 2, 14, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5554, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5565, 2, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5569, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5570, 2, 14, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5574, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5576, 1, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5582, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5607, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5619, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5633, 2, 4, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5647, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5651, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5688, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5767, 4, 3, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5782, 2, 13, '20130820', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 558831, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 566393, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 568238, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 568991, 1, 1, '20140103', 'Anticipo', 'PARCIAL'
Insert #GeneraFolioSII Select 'BacForward', 569800, 12, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 569980, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 569981, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 570903, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 570912, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571334, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571336, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571342, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571348, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571351, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571353, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571354, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571355, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571356, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571357, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571358, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571495, 3, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 571497, 1, 4, '20140103', 'Anticipo', 'PARCIAL'
Insert #GeneraFolioSII Select 'BacForward', 571954, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 572260, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 572395, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacForward', 573007, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2413, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2414, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2415, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2416, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2419, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2420, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2421, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2422, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2681, 2, 6, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2886, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2888, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2947, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2948, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2960, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 2963, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4082, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4242, 2, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4328, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4402, 2, 12, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4538, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4644, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4683, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4736, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4823, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4898, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4964, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4989, 1, 8, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 4991, 1, 8, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5034, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5047, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5049, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5070, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5072, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5083, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5084, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5092, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5093, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5094, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5096, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5097, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5099, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5100, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5101, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5102, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5104, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5105, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5107, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5109, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5110, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5111, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5113, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5116, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5118, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5120, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5121, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5122, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5126, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5127, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5128, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5130, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5132, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5134, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5135, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5140, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5141, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5142, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5143, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5155, 4, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5156, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5157, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5159, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5160, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5165, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5166, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5174, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5175, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5177, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5178, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5182, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5184, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5186, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5187, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5191, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5192, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5193, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5194, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5195, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5199, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5200, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5201, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5203, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5204, 4, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5205, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5206, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5207, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5208, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5209, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5211, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5215, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5218, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5219, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5222, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5226, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5227, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5229, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5231, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5234, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5237, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5239, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5240, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5243, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5244, 1, 11, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5245, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5248, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5249, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5250, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5252, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5253, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5255, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5258, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5259, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5260, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5261, 2, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5263, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5264, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5265, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5266, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5267, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5268, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5269, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5270, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5273, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5276, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5280, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5283, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5284, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5285, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5289, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5293, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5294, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5298, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5299, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5302, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5303, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5304, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5305, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5306, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5309, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5311, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5315, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5317, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5319, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5320, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5322, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5326, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5332, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5337, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5339, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5340, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5342, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5349, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5356, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5364, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5366, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5368, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5369, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5370, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5372, 2, 3, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5375, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5376, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5378, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5379, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5380, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5382, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5383, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5384, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5391, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5399, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5400, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5402, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5403, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5405, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5409, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5412, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5413, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5416, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5417, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5420, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5421, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5422, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5423, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5425, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5426, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5427, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5428, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5434, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5435, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5436, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5437, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5438, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5446, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5447, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5449, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5450, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5451, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5454, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5456, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5457, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5462, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5463, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5464, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5465, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5466, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5467, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5468, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5469, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5470, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5471, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5472, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5473, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5474, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5476, 4, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5481, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5482, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5483, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5512, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5513, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5518, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5520, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5521, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5532, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5537, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5538, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5539, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5540, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5541, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5542, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5545, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5546, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5547, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5548, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5549, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5555, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5556, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5560, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5561, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5568, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5575, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5578, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5584, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5586, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5589, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5592, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5594, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5596, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5597, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5598, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5599, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5601, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5602, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5603, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5604, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5605, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5608, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5609, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5610, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5611, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5612, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5614, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5618, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5620, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5621, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5622, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5623, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5627, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5636, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5643, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5646, 4, 3, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5650, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5653, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5654, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5655, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5658, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5660, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5664, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5665, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5674, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5675, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5676, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5679, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5680, 4, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5681, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5682, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5687, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5690, 2, 12, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5693, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5694, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5695, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5696, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5697, 4, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5698, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5699, 4, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5700, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5703, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5706, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5707, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5711, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5716, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5719, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5721, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5724, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5725, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5726, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5729, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5731, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5732, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5734, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5735, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5737, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5742, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5745, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5746, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5749, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5752, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5753, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5755, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5756, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5758, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5760, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5761, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5762, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5764, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5765, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5766, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5768, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5769, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5770, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5771, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5773, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5775, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5776, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5780, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5781, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5783, 2, 12, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5784, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5786, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5787, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5788, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5789, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5790, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5791, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5795, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5796, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5798, 4, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5801, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5804, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5805, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5810, 2, 11, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5811, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5812, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5813, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5814, 1, 12, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5815, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5816, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5817, 4, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5818, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5819, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5821, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5822, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5828, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5829, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5835, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5836, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5838, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5839, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5840, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5845, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5846, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5848, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5849, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5851, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5852, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5853, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5860, 2, 12, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5862, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5863, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5867, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5868, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5871, 1, 5, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5872, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5873, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5874, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5876, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5880, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5881, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5882, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5883, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5884, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5885, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5886, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5887, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5888, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5889, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5891, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5892, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5893, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5894, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5914, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5915, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5916, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5917, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5918, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5919, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5920, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5921, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5923, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5924, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5927, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5928, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5931, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5934, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5935, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5936, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5937, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5938, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5939, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5941, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5942, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5943, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5944, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5945, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5946, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5947, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5953, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5984, 2, 8, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5985, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 5986, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6016, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6027, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6032, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6033, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6034, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6035, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6036, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6038, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6039, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6040, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6045, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6047, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6049, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6050, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6055, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6057, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6063, 2, 11, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6064, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6065, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6069, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6070, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6076, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6077, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6078, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6080, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6081, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6083, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6085, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6086, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6087, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6088, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6090, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6092, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6094, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6095, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6096, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6097, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6099, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6103, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6104, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6105, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6106, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6107, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6109, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6110, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6112, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6113, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6114, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6115, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6116, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6117, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6118, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6121, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6122, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6123, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6124, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6125, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6127, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6128, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6129, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6130, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6131, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6132, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6133, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6134, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6135, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6136, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6137, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6140, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6141, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6143, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6147, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6148, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6155, 2, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6158, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6162, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6168, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6169, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6170, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6173, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6184, 2, 10, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6185, 2, 10, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6186, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6187, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6188, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6190, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6191, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6192, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6193, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6197, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6198, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6199, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6200, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6202, 2, 9, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6203, 2, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6204, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6205, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6207, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6210, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6211, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6212, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6213, 2, 11, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6215, 1, 10, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6216, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6217, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6218, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6220, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6221, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6222, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6223, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6224, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6225, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6227, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6228, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6229, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6231, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6232, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6233, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6234, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6235, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6236, 2, 9, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6237, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6238, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6239, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6240, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6242, 2, 9, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6243, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6247, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6248, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6249, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6250, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6251, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6253, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6254, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6255, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6256, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6258, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6259, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6260, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6267, 2, 9, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6268, 2, 9, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6269, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6270, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6271, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6272, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6275, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6277, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6279, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6281, 2, 9, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6286, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6287, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6288, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6289, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6290, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6291, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6296, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6297, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6298, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6299, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6300, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6301, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6306, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6307, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6311, 2, 8, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6313, 2, 9, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6314, 2, 9, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6319, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6320, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6321, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6326, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6327, 4, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6328, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6329, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6331, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6332, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6334, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6336, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6338, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6339, 4, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6340, 4, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6341, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6342, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6343, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6344, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6347, 4, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6350, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6351, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6354, 4, 3, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6355, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6359, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6361, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6362, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6364, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6365, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6366, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6368, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6369, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6370, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6373, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6374, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6375, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6376, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6377, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6378, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6379, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6382, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6383, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6386, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6387, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6388, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6390, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6393, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6399, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6401, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6402, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6405, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6406, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6408, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6409, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6410, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6411, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6412, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6413, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6414, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6415, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6416, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6418, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6419, 1, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6420, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6441, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6443, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6444, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6445, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6446, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6451, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6455, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6461, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6462, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6464, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6482, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6483, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6485, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6487, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6488, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6490, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6491, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6493, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6496, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6497, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6498, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6499, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6501, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6503, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6508, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6509, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6512, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6514, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6521, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6522, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6523, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6524, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6525, 2, 8, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6535, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6536, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6539, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6540, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6541, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6546, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6547, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6549, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6560, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6563, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6564, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6565, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6567, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6568, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6572, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6573, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6578, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6579, 2, 1, '20140103', 'Anticipo', 'PARCIAL'
Insert #GeneraFolioSII Select 'BacSwap', 6582, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6587, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6588, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6589, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6590, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6594, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6595, 2, 7, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6598, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6599, 2, 8, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6601, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6602, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6603, 1, 8, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6604, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6606, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6607, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6608, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6610, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6612, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6613, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6616, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6619, 2, 5, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6622, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6625, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6626, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6627, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6628, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6629, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6631, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6632, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6633, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6636, 2, 3, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6637, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6640, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6641, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6642, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6644, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6646, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6647, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6652, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6653, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6654, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6655, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6656, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6659, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6660, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6664, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6665, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6667, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6668, 2, 7, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6669, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6671, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6676, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6679, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6681, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6682, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6685, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6691, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6692, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6693, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6695, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6700, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6701, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6705, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6706, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6707, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6709, 2, 7, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6711, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6712, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6713, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6714, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6716, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6719, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6724, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6725, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6726, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6728, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6729, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6734, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6735, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6736, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6737, 2, 7, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6738, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6742, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6743, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6745, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6746, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6747, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6748, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6749, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6750, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6752, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6754, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6755, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6756, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6757, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6758, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6759, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6760, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6761, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6762, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6763, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6764, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6765, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6766, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6767, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6768, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6769, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6770, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6771, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6772, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6773, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6774, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6775, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6776, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6777, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6778, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6779, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6780, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6781, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6782, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6783, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6784, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6785, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6799, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6800, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6802, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6809, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6810, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6811, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6812, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6814, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6815, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6816, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6818, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6819, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6820, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6821, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6822, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6826, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6843, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6844, 2, 6, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6845, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6847, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6848, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6849, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6850, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6856, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6857, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6858, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6862, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6864, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6865, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6866, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6869, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6870, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6871, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6872, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6873, 2, 6, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6874, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6875, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6876, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6880, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6884, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6885, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6886, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6888, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6890, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6891, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6898, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6909, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6911, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6916, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6917, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6918, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6919, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6923, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6925, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6926, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6927, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6928, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6929, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6930, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6933, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6934, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6935, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6936, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6937, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6938, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6940, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6942, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6943, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6944, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6945, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6946, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6947, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6948, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6949, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6950, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6951, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6953, 2, 3, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6956, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6957, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6959, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6960, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6964, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6965, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6966, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6967, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6969, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6970, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6971, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6973, 2, 6, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6974, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6975, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6976, 2, 6, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6977, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6979, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6981, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6984, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6985, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6986, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6987, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6988, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6989, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6991, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6992, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6993, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6995, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 6998, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7001, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7002, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7006, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7007, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7009, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7010, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7011, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7013, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7015, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7017, 4, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7025, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7027, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7030, 2, 6, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7032, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7036, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7037, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7038, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7043, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7048, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7050, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7052, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7053, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7054, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7055, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7058, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7060, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7061, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7062, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7064, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7065, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7066, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7067, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7068, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7069, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7070, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7071, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7072, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7073, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7075, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7076, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7078, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7082, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7083, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7088, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7090, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7091, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7092, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7094, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7095, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7096, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7097, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7098, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7099, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7100, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7114, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7115, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7118, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7121, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7125, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7129, 2, 6, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7134, 4, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7138, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7141, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7143, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7144, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7150, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7156, 2, 5, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7163, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7175, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7188, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7192, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7207, 1, 5, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7211, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7212, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7221, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7232, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7244, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7245, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7250, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7251, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7254, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7256, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7257, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7268, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7288, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7294, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7297, 1, 5, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7298, 2, 5, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7305, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7306, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7308, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7311, 2, 5, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7312, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7328, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7343, 2, 5, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7344, 2, 5, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7368, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7379, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7381, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7392, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7416, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7444, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7445, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7446, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7448, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7472, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7474, 2, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7476, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7480, 1, 4, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7497, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7501, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7502, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7504, 4, 2, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7505, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7506, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7508, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7515, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7534, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7547, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7553, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7554, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7555, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7557, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7563, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7564, 1, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7565, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7574, 1, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7582, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7606, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7607, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7614, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7616, 2, 3, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7625, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7648, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7667, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7669, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7692, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7702, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7710, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7714, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7723, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7752, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7766, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7785, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7789, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7790, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7791, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7844, 2, 2, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7860, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7861, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7866, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7875, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7911, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7923, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7925, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7945, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7955, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7956, 2, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7975, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 7981, 1, 1, '20140103', 'Liquidacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 8055, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 8056, 4, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 8072, 1, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'BacSwap', 8074, 2, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 16821, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 16822, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 16823, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 16881, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 16882, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 16883, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 17201, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 17202, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 17203, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 17211, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 17212, 5, 1, '20140103', 'Modificacion', 'No Aplica'
Insert #GeneraFolioSII Select 'SAO', 17213, 5, 1, '20140103', 'Modificacion', 'No Aplica'

-- ( Modulo VarChar(10), ContratoBAC Numeric(10), Estructura Numeric(5), UltimoFolioUtilizado numeric(10), FechaActRegistro datetime, Evento Varchar(30), SubEvento Varchar(30) )
-- Fuerza avance de Folio, si se rectifica desde febrero hay que eliminar
Insert #GeneraFolioSII Select 'BacSwap'
                             , 8455         
							 , 2            -- Tipo de Swap
							 , 1            -- ultimo folio utilizado
							 , '20140228'   -- fecha de consumo 
							 , 'Modificacion' -- Evento
							 , 'No Aplica'    -- Subevento

select CD.*
      ,  FolioEvento = 1000 * 0
      ,  CorrelativoGeneral = identity(INT, 0, 1)
into #ContratosDerivadosOrdenados 
--- select CorrelativoGeneral, * from #ContratosDerivadosOrdenados D where D.contrato = 8455 order by D.Modulo, D.contrato, D.fechaEvento, D.correlativogeneral
      from #ContratosDerivados  CD
	    Left join #Evento E on E.EveCod = Evento and E.SubEveCod = Subevento
  where FechaEvento >= @FechaCorte    and fechaevento <= @FechaCorteFinal     -- DJ 1820 Solo se cargará lo que hay que procesar XX
      or ( Evento = 'Curse' /*and Fecha_Vencimiento >= @FechaCorte and */ and Vigente_CierreAnoAnt = 'S' )
  -- order by Modulo, Contrato, FechaEvento, Producto_Emp, Evento
  order by Modulo, Contrato, FechaEvento, E.EveOrd,  Producto_Emp 
  /* Evento ordenados alfabeticamente
     Anticipo
	 Curse
	 Liquidacion
	 Provisiones
	 Vcto. Natural
	 Complemento
	 Cuadratura
	 Ejercicio
	 Liq Hip
	 Modificacion
	 Pargua
	 Provisiones

  */ 

declare @CntRegistros numeric(10)
declare @Contrato     numeric(10)
declare @ContratoAnt  numeric(10)
declare @FolioEvento  numeric(10)
declare @Contador     numeric(10)
declare @Evento       varchar(15)
declare @EventoAnt    varchar(15)
declare @SubEvento    varchar(30)
declare @Modulo       varchar(10)
declare @ModuloAnt    varchar(10)

-- Para el manejo de Folios
declare @Estructura      numeric(5)

select  @CntRegistros = count(1) from #ContratosDerivadosOrdenados
select  @Contrato = 0 
select  @Contador = 0
select  @FolioEvento = 0
select  @ContratoAnt = 0
select  @EventoAnt = ''

select  @Modulo = ''
select  @ModuloAnt = ''

-- Para el manejo de Folios
Select @Estructura      = 0 

declare @Existe numeric(1)
declare @fechaEventoAux datetime


/* 
select Contrato, evento, SubEvento,  Evento_Informado, Producto_Emp, *   from #ContratosDerivadosOrdenados where contrato = 552803
       order by CorrelativoGeneral
 */
CREATE INDEX #IContratosDerivadosOrdenados ON #ContratosDerivadosOrdenados ( CorrelativoGeneral ) 

while   @Contador < @CntRegistros
Begin
   select @fechaEventoAux = '19000101'
   select   @Contrato = Contrato  , @Evento = Evento  , @SubEvento = SubEvento , @Modulo = Modulo    
          , @Estructura = Producto_Emp, @fechaEventoAux = fechaEvento
         from #ContratosDerivadosOrdenados where CorrelativoGeneral = @Contador

-- select 'debug', modulo, Producto_Emp, * from #ContratosDerivadosOrdenados where contrato = 561540
-- select * from #GeneraFolioSII where contratoBAC = 561540 and modulo = 'BacForward' and estructura = 12

   if @ContratoAnt = @Contrato and @ModuloAnt = @Modulo 
   begin
      if @EventoAnt = 'Curse'
      begin
		  Select @Existe = 0
          Select @FolioEvento = 0
		  select @FolioEvento = UltimoFolioUtilizado  
			   , @Existe  = 1
				from #GeneraFolioSII  where Modulo = @Modulo and ContratoBAC = @Contrato 
		  if @Existe = 0
		  begin
				Insert  #GeneraFolioSII Select @Modulo, @Contrato, @Estructura, @FolioEvento + 1, GetDate(), @Evento, @SubEvento
		  end         
      end
      select @FolioEvento = @FolioEvento + 1
      update #ContratosDerivadosOrdenados 
        set FolioEvento = @FolioEvento           
          where CorrelativoGeneral = @Contador         
      Update #GeneraFolioSII 
          Set UltimoFolioUtilizado = @FolioEvento  
            , Evento = @Evento, SubEvento = @SubEvento
          where Modulo = @Modulo and ContratoBAC = @Contrato 
   end
   else
   begin
      Select @FolioEvento = 0 -- Si no existe toma este valor
      if @Evento <> 'Curse'
      begin
		  Select @Existe = 0
		  select @FolioEvento = UltimoFolioUtilizado + 1 
			   , @Existe  = 1
				from #GeneraFolioSII  where Modulo = @Modulo and ContratoBAC = @Contrato 
		  if @Existe = 0
		  begin
				Insert  #GeneraFolioSII Select @Modulo, @Contrato, @Estructura, @FolioEvento + 1 , GetDate(), @Evento, @SubEvento
		  end
		  Update #GeneraFolioSII 
			  Set UltimoFolioUtilizado = case when @Evento <> 'Curse' then @FolioEvento else UltimoFolioUtilizado end 
				, Evento = @Evento, SubEvento = @SubEvento
			 where Modulo = @Modulo and ContratoBAC = @Contrato 
		  update #ContratosDerivadosOrdenados set FolioEvento = @FolioEvento where CorrelativoGeneral = @Contador  
      end
   end   
   select @ContratoAnt = @Contrato , @ModuloAnt = @Modulo , @EventoAnt = @Evento 
   select @Contador = @Contador + 1
End
-- select  * from #GeneraFolioSII where ContratoBAc = 31271
-- select * from #ContratosDerivadosOrdenados where contrato = 31271



select * 
   , Rut_Chileno = convert( numeric(13), 0 ) 
   , Vigente_Corte_Inicial = 'N'      
   , Monto_Util_PERD_CLP    = convert( float, 0 )  -- Para registrar todo lo de Dif. de Precio
into #ContratosDerivadosMes   -- 
      from #ContratosDerivadosOrdenados 
where fechaevento <= @FechaCorteFinal

CREATE INDEX #IContratosDerivadosMes ON #ContratosDerivadosMes ( KeyCntId_sistema ) 


/************************************* 
   Actualización de Rut Vigentes
   para los Rut que fueron modificados   
*************************************/

Update #ContratosDerivadosMes 
	Set
       Rut_Contraparte    =  ID_CLI_RUT_NUEVO
     , Rut_Cliente_Emp    =  ID_CLI_RUT_NUEVO
     , Codigo_Cliente_Emp =  ID_CLI_COD_NUEVO
     , Rut_Chileno        =  ID_CLI_RUT_NUEVO
  from #TA_GNL_RUT_MOD
   where Rut_CLiente_Emp =   ID_CLI_RUT_ORIGINAL
      and  Codigo_Cliente_Emp = ID_CLI_COD_ORIGINAL

 -- Si el cliente ya operó con el rut chino también lo 
 -- deja instanciado como rut chileno:  
Update #ContratosDerivadosMes 
	Set
       Rut_Chileno        =  ID_CLI_RUT_NUEVO
  from #TA_GNL_RUT_MOD
   where Rut_CLiente_Emp =   ID_CLI_RUT_NUEVO
      and  Codigo_Cliente_Emp = ID_CLI_COD_NUEVO



/************************************
     Actualiza información que 
     proviene del cliente

xxx = xxxx quiere decir que no se 
se modifica es para tener a la 
vista todos los campos siempre
para inferir rápidamente qué sección
de código la modifica.
*************************************/




update #ContratosDerivadosMes
	set
       Contrato  = Contrato             
     , Evento    = Evento  
     , SubEvento = SubEvento
     , FechaEvento = FechaEvento

     , Rut_Contraparte                 = case when Cli.ClPais = 6 or Rut_Chileno <> 0 
                                                   then Rut_Contraparte else 0  end  
     , DV_Rut_COntraparte              = isnull( case when Cli.ClPais = 6 or Rut_Chileno <> 0 then Cli.ClDv  else '0'  end, '0' )
--     , Tax_ID_Contraparte              = isnull( CliTxI.TAXID_CLI, Case when cli.ClPais <> 6 then 'Falta!!!' else '' end )  

     , Tax_ID_Contraparte              = isnull( CliTxI.TAXID_CLI, Case when cli.ClPais = 6 or Rut_Chileno <> 0 then ''  else 'Falta!!!' end )  

     , Codigo_Pais_Contraparte         = isnull( PaiSII.COD_PAI, '??' )

       /* Codigos de relación de BAC para establecer que la contraparte es...
				5     	AGENTE BCO.EXTRANJER                              
				8     	CONYUGE DIR.O APOD                                
				3     	DIRECTOR                                          
				4     	DIRECTOR SUPLENTE                                 
				6     	GERENTE GENERAL                                   
				7     	OTRO APODERADO GENER                              
				0     	SIN RELACION                                      
				10    	SOC. CON PART. > 5%                               
				2     	VICEPRESIDENTE DIREC                              
           Por hacer detectar las filiales
           Detectar las empresas de Saieh
        */                                                                               -- POR HACER: Confirmar relacion
                                                                                         -- con Alburquenque
     , Tipo_Relacion_con_Contraparte   = Case when Cli.RelBco in (5,3,4,6,7,2)   then 2  -- Participacion en direccion        
                                              when Cli.relBco in (10)            then 1  -- Participacion de propiedad
                                              else 99  end                               -- Sin Relacion                          

     , Modalidad_Contratacion = Case when Cli.ClPais = 6 then 6 else 4 end               -- Gestionando Alan solicitado x email: viernes, 16 de noviembre de 2012 17:35

     , Tipo_Acuerdo_Marco              = case when Cli.Clpais = 6 then 1                 -- Cond. Gen. Locales
                                                                  else 2 end             -- Cond. Gen. Extranjeros (ISDA)   
                                                                                         -- Manual Derivados: Cliente extranjero 
                                                                                         -- firma ISDA y si no no opera   

	/*
	De: María Paz Navarro Genta 
	Enviado el: viernes, 16 de noviembre de 2012 17:28
	Para: Patricio Orlando Alburquenque Hernandez
	CC: Patricio Mariano Angulo San Martin; Alan Shomaly Van Gindertaelen
	Asunto: Consulta sobre Números de Contratos Marco

	Estimado:

	¿Me puedes indicar a quién pedir los números de contratos marco?

	*/
        
     , Numero_Acuerdo_Marco            = case when ClPais <> 6 then '0' else '-1'   end -- Banco Extranjero no tiene # Contrato
     , Fecha_Suscripcion_Acuerdo_Marco = case when     clFechaFirma_cond     <> '19000101' 
                                                   and Fecha_Firma_Nuevo_CCG <> '19000101'  
                                                   then
                                                       -- tiene de las dos fechas
                                                       -- se pone la que acomoda al 
                                                       -- contrato                                                        
                                                       case when Fecha_Suscripcion_Contrato < Fecha_Firma_Nuevo_CCG
                                                       -- Fecha del contrato es anterior a la Firma nueva
                                                                  then clFechaFirma_cond
                                                       else
                                                            Fecha_Firma_Nuevo_CCG
                                                       end 
                                              when     Fecha_Firma_Nuevo_CCG <> '19000101' 
                                                   and Fecha_Suscripcion_Contrato > Fecha_Firma_Nuevo_CCG
                                                       then FECHA_FIRMA_NUEVO_CCG
                                              when     clFechaFirma_cond <> '19000101' 
                                                   and Fecha_Suscripcion_Contrato > clFechaFirma_cond
                                                       then clFechaFirma_cond
                                              else 
                                                   
                                                  case when clFechaFirma_cond <> '19000101' 
                                                       then clFechaFirma_cond 
                                                       when FECHA_FIRMA_NUEVO_CCG <> '19000101'
                                                       then FECHA_FIRMA_NUEVO_CCG
                                                  else 
                                                       clFechaFirma_cond  
                                                  end
                                                    
                                              end       
                                           
     , Numero_Contrato             = Numero_Contrato 
     , Fecha_Suscripcion_Contrato  = Fecha_Suscripcion_Contrato
    -- , Evento_Informado            = Evento_Informado  ERROR Encontrado en prueba parcial
     , Tipo_Contrato               = Tipo_Contrato
     , Nombre_Instrumento          = Nombre_Instrumento
     , Modalidad_Cumplimiento      = Modalidad_Cumplimiento
     , Posicion_declarante         = Posicion_declarante
     , Tipo_Activo_Subyacente      = Tipo_Activo_Subyacente
     , Codigo_Activo_Subyacente    = Codigo_Activo_Subyacente
     , Otro_Activo_Subyacente_Especificacion = Otro_Activo_Subyacente_Especificacion        
     , Tasa_Fija_o_Spread_Activo_Subyacente   = Tasa_Fija_o_Spread_Activo_Subyacente
     , Tipo_Segundo_Activo_Subyacente         = Tipo_Segundo_Activo_Subyacente
     , Codigo_Segundo_Activo_Subyacente       = Codigo_Segundo_Activo_Subyacente
     , Otro_Segundo_Activo_Subyacente_Especificacion  = Otro_Segundo_Activo_Subyacente_Especificacion
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = Tasa_Fija_o_Spread_Segundo_Activo_Subyacente    
     , Codigo_Precio_Futuro_Contratado                = Codigo_Precio_Futuro_Contratado   
     , Precio_Futuro_Contratado                       = Precio_Futuro_Contratado
     , Moneda_Precio_Futuro_Contratado                = Moneda_Precio_Futuro_Contratado
     , Unidad                                         = Unidad   
     , Monto_Cantidad_Contratado_o_Nocional           = Monto_Cantidad_Contratado_o_Nocional  
     , Segunda_Unidad                                 = Segunda_Unidad   
     , Segundo_Monto_Nocional                         = Segundo_Monto_Nocional  
     , Fecha_Vencimiento                              = Fecha_Vencimiento
     , Rut_Cliente_Emp                 = Rut_Cliente_Emp
     , Codigo_Cliente_Emp              = Codigo_Cliente_Emp
     , Modalidad_Cumplimiento_Emp      = Modalidad_Cumplimiento_Emp            
     , Posicion_Declarante_Emp         = Posicion_Declarante_Emp            
     , Producto_Emp                    = Producto_Emp                           
     , Moneda_transada_Emp             = Moneda_transada_Emp                
                                                                            
     , moneda_compensacion_Emp         = case when Modulo = 'BacForward' and Producto_Emp = 2 
                                              then 
                                                   case when Cli.ClPais <> 6 then 13
                                                   else 999 end
                                              else   moneda_compensacion_Emp  end
     , Fecha_Curse_Contrato_Emp        = Fecha_Curse_Contrato_Emp 

     , Estado_Cliente                  = substring( ClNombre, 1, 40 )

     , Subyacente_Papeles_de_RentaFija = Subyacente_Papeles_de_RentaFija
     , Unidad_Precio_Subyacente_Emp    = Unidad_Precio_Subyacente_Emp
     , Pais_Recidencia_Contraparte_Emp = Cli.ClPais
     , cacalcmpdol_Emp                 = cacalcmpdol_Emp          -- Campo Moneda Compensacion para Seguros de Cambio
     , Moneda_Multiplica_Divide_Emp    = Moneda_Multiplica_Divide_Emp
     , Moneda_Conversion_Emp           = Moneda_Conversion_Emp           
from BacParamSuda.dbo.Cliente Cli
     LEFT JOIN #TA_GNL_CLI_TAXID CliTxI ON CliTxI.COD_EMP = @EmpresaDeclarante 
                                       and CliTxI.ID_CLI_EMP = Cli.ClRut 
                                       and CliTxI.ID_CLI_CODIGO_EMP = Cli.ClCodigo
     LEFT JOIN #TA_GNL_PAI_EMP   PaiEmp ON PaiEmp.NRO_ANO_CMR = 2012 and PaiEmp.COD_EMP = @EmpresaDeclarante and PaiEmp.COD_PAI_EMP = Cli.ClPais
     LEFT JOIN #TA_GNL_PAI_SII    PaiSII ON PaiSII.NRO_ANO_CMR = PaiEmp.NRO_ANO_CMR  and PaiSII.COD_PAI = PaiEmp.COD_PAI_SII
     where Cli.ClRut = #ContratosDerivadosMes.Rut_Cliente_Emp and Cli.ClCodigo = #ContratosDerivadosMes.Codigo_Cliente_Emp


/************************************
     Actualiza información que 
     proviene del contrato
*************************************/
Update #ContratosDerivadosMes
     Set 

       Contrato  = Contrato             
 -- Activo para DJ Mensual , puede haber problemas de cuadratura entre mensual y Anual
 --    , Evento    = case when FechaEvento = Fecha_Vencimiento then 'Vcto. Natural' else Evento  end  
     , SubEvento = SubEvento
     , FechaEvento = FechaEvento

     , Rut_Contraparte                 = Rut_Contraparte
     , DV_Rut_COntraparte              = DV_Rut_COntraparte
     , Tax_ID_Contraparte              = Tax_ID_Contraparte  
     , Codigo_Pais_Contraparte         = Codigo_Pais_Contraparte
     , Modalidad_Contratacion          = Modalidad_Contratacion
     , Tipo_Acuerdo_Marco              = Tipo_Acuerdo_Marco  
     , Numero_Acuerdo_Marco            = Numero_Acuerdo_Marco
     , Fecha_Suscripcion_Acuerdo_Marco = Fecha_Suscripcion_Acuerdo_Marco

     , Numero_Contrato                 = ltrim( convert( varchar(10), contrato ) ) + case when FolioEvento = 0 then '' else '-' + ltrim( convert( varchar(5), FolioEvento) ) end

     , Fecha_Suscripcion_Contrato      = case when Fecha_Suscripcion_Contrato = '19000101' then Fecha_Curse_Contrato_Emp else Fecha_Suscripcion_Contrato end
  --   , Evento_Informado                = case when FechaEvento = Fecha_Vencimiento then convert( numeric(1), 5 ) else Evento_Informado end  ERROR PRUEBA PARCIAL
     , Tipo_Contrato                   = Tipo_Contrato
     , Nombre_Instrumento              = Nombre_Instrumento

     , Modalidad_Cumplimiento          = case when Modalidad_Cumplimiento_Emp = 'C' then 1 else 2 end 
     , Posicion_Declarante             = case when Posicion_Declarante_Emp = 'C' then 2 
                                              when Posicion_Declarante_Emp = 'V' then 1
                                              else 0 end 
     , Tipo_Activo_Subyacente          = Case when Modulo = 'BacForward' then
                                                 case when Producto_Emp in ( 1, 2, 7, 14, 12 ) then 1 -- Moneda
                                                    when Producto_Emp in ( 3, 13 )       then 4 -- UF
                                                    when Producto_Emp in ( 10, 11 )      then 7 -- Otros: son papeles de RF
                                                 end                    
                                              when Modulo = 'SAO' then 1 -- Moneda
                                              when Modulo = 'BacSwap' then Tipo_Activo_Subyacente
                                         end                                       
     , Codigo_Activo_Subyacente        = case when Modulo in ( 'BacForward', 'SAO' ) then 
                                                   isnull( (select max( COD_SII_Char ) from #TA_GNL_UND_MNA_MID_EMP where COD_UMM_EMP = Moneda_transada_Emp ), space(3) )
                                              else Codigo_Activo_Subyacente 
                                         end

     , Otro_Activo_Subyacente_Especificacion  = case when Producto_Emp in ( 10,11) and Modulo = 'BacForward'
                                                     then Subyacente_Papeles_de_RentaFija 
                                                     else  Otro_Activo_Subyacente_Especificacion 
                                                end 
     , Tasa_Fija_o_Spread_Activo_Subyacente   = case when Producto_Emp in ( 10, 11 ) and Modulo = 'BacForward'
                                                     then Precio_Futuro_Contratado 
                                                     else Tasa_Fija_o_Spread_Activo_Subyacente 
                                                end
     , Tipo_Segundo_Activo_Subyacente         = Tipo_Segundo_Activo_Subyacente
     , Codigo_Segundo_Activo_Subyacente       = Codigo_Segundo_Activo_Subyacente
     , Otro_Segundo_Activo_Subyacente_Especificacion  = Otro_Segundo_Activo_Subyacente_Especificacion
     , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = Tasa_Fija_o_Spread_Segundo_Activo_Subyacente    

     , Codigo_Precio_Futuro_Contratado        = case when Modulo in ( 'BacForward' , 'SAO' ) then
                                                  Case when Producto_Emp in ( 10, 11 ) then 2 /* Valor %Tasa */ else 1 /* valor Monetario */ end
                                                else Codigo_Precio_Futuro_Contratado end

     , Precio_Futuro_Contratado                       = Precio_Futuro_Contratado
     , Moneda_Precio_Futuro_Contratado                = Moneda_Precio_Futuro_Contratado
     , Unidad                                         = Unidad   
     , Monto_Cantidad_Contratado_o_Nocional           = Monto_Cantidad_Contratado_o_Nocional  
     , Segunda_Unidad                                 = Segunda_Unidad   
     , Segundo_Monto_Nocional                         = Segundo_Monto_Nocional  
     , Fecha_Vencimiento                              = Fecha_Vencimiento
     , Rut_Cliente_Emp                 = Rut_Cliente_Emp
     , Codigo_Cliente_Emp              = Codigo_Cliente_Emp
     , Modalidad_Cumplimiento_Emp      = Modalidad_Cumplimiento_Emp            
     , Posicion_Declarante_Emp         = Posicion_Declarante_Emp            
     , Producto_Emp                    = Producto_Emp                           
     , Moneda_transada_Emp             = Moneda_transada_Emp                
                                                                            
     , moneda_compensacion_Emp         = case when moneda_compensacion_Emp = 0 then 999 else moneda_compensacion_Emp end
     , Fecha_Curse_Contrato_Emp        = Fecha_Curse_Contrato_Emp 

     , Estado_Cliente                  = Estado_Cliente

     , Subyacente_Papeles_de_RentaFija = Subyacente_Papeles_de_RentaFija
     , Unidad_Precio_Subyacente_Emp    = Unidad_Precio_Subyacente_Emp
     , Pais_Recidencia_Contraparte_Emp = Pais_Recidencia_Contraparte_Emp
     , cacalcmpdol_Emp                 = cacalcmpdol_Emp
     , Moneda_Multiplica_Divide_Emp    = isnull( ( select mnrrda from BacParamsuda.dbo.moneda where MnCodMon = Moneda_transada_Emp  ), 'M' )
     , Moneda_Conversion_Emp           = Moneda_Conversion_Emp 
          
/* Updates mas Específicos */

update #ContratosDerivadosMes
	set  Codigo_Precio_Futuro_Contratado = 2   -- Tasa (%)
       , Precio_Futuro_Contratado        = 0   -- Informar en cero el precio
where Producto_Emp in ( 10, 11 ) and modulo = 'BacForward'

update #ContratosDerivadosMes
    set Moneda_Precio_Futuro_Contratado = Case when Modulo = 'BacForward' then
												   case when Producto_Emp in ( 1, 14 ) then 
														  case when Moneda_Conversion_Emp = 999 then 'CLP' else 'CLF' end
													   when Producto_Emp in (12) then 'CLP'
													   when Producto_Emp in ( 3 , 13 ) then 'CLP'
													   when Producto_Emp in ( 10, 11 ) then '   '
													   else -- Producto_Emp = 2
														  case when Moneda_Multiplica_Divide_Emp = 'D' then 
																isnull( (select max( COD_Sii_Char ) from #TA_GNL_UND_MNA_MID_EMP 
																			 where COD_UMM_EMP = Moneda_transada_Emp), '   ' )
															   else 
																isnull( (select max( COD_Sii_Char ) from #TA_GNL_UND_MNA_MID_EMP
																		 where COD_UMM_EMP = Moneda_Conversion_Emp), '   ' )
														  end 
													end
                                                when Modulo = 'SAO' then 'CLP'
                                           else  
                                              '   '       
                                           end
      , Unidad = case when Modulo <> 'BacSwap' then isnull( (select max( COD_UMM ) from #TA_GNL_UND_MNA_MID_EMP where COD_UMM_EMP = moneda_compensacion_Emp ), 13 )   
                                            else Unidad end                            
      , Codigo_Activo_Subyacente = case when Tipo_activo_subyacente = 7 then '   ' else Codigo_Activo_Subyacente end
 where Modulo in ( 'BacForward' , 'SAO' )


-- Caso específico para clientes con
-- Seguro de Inflación Hipotecario
update #ContratosDerivadosMes
	set Fecha_Suscripcion_Acuerdo_Marco = ( select min(  Fecha_Curse_Contrato_Emp ) 
                                           from #ContratosDerivados CD where CD.Rut_Cliente_Emp = #ContratosDerivadosMes.Rut_Cliente_Emp )
       , Numero_Acuerdo_Marco           = '0' -- No aplica
where Producto_Emp in ( 13 ) and modulo = 'BacForward'

-- Unidad de Liquidacion de Swap Entrega Fisica con UF
update #ContratosDerivadosMes
   Set unidad = case when unidad = 3 -- UF debe ser CLP
                     then 1
                     else Unidad
                 end
     , Segunda_unidad = case when Segunda_unidad = 3 -- UF debe ser CLP
                     then 1
                     else Segunda_Unidad
                 end
 where modulo = 'BacSwap' and Modalidad_Cumplimiento_Emp = 'E'

-- Correcion de Fechas de Contratos Marco
-- Asiganción del número de contrato 
-- que corresponde

-- Rescata la mayor fecha de Cond. Generales realizadas por el cliente
-- firmada anterior al contrato
update #ContratosDerivadosMes
    set Fecha_Suscripcion_Acuerdo_Marco = isnull( ( select max(Fecha_CG)  from #Contratos_Marco CM 
	                                                  where CM.COD_EMP = @EmpresaDeclarante
													   and  CM.ID_CLI_EMP = Rut_Cliente_Emp
													   and  CM.ID_CLI_CODIGO_EMP = Codigo_Cliente_Emp 
													   and Fecha_Suscripcion_Contrato >= CM.Fecha_CG), Fecha_Suscripcion_Acuerdo_Marco )

-- Rescata el número asociado, si existe
update #ContratosDerivadosMes
    set Numero_Acuerdo_Marco            = isnull( ( select min(Numero_CG) from #Contratos_Marco CM
	                                                        where CM.COD_EMP = @EmpresaDeclarante
													   and  CM.ID_CLI_EMP = Rut_Cliente_Emp
													   and  CM.ID_CLI_CODIGO_EMP = Codigo_Cliente_Emp
													   and Fecha_Suscripcion_Acuerdo_Marco = CM.Fecha_CG), Numero_Acuerdo_Marco )
    
-- select max(fecha_CG) from #Contratos_Marco where ID_CLI_EMP = 96635700 and '20071126' >=Fecha_CG 
-- Eliminación de la información
-- no consistente
Update #ContratosDerivadosMes
	Set Fecha_Suscripcion_Acuerdo_Marco = '19000101' 
      , Numero_Acuerdo_Marco            = 0
where Numero_Acuerdo_Marco = -1 or Fecha_Suscripcion_Acuerdo_Marco > Fecha_Suscripcion_Contrato



-- Aplicación de Relacion Banco
update #ContratosDerivadosMes
    set Tipo_Relacion_Con_Contraparte = Relacion_SII
from #Rut_relacionados RR
where RR.COD_EMP = @EmpresaDeclarante
  and RR.ANNO_MES = '201201' 
  and RR.ID_CLI_EMP = Rut_Cliente_Emp
  and RR.ID_CLI_CODIGO_EMP = Codigo_Cliente_Emp
  and RR.Prioridad = 1 


-- Precio de Cierre de Contrato XXX
update #ContratosDerivadosMes 
    Set Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = 0
      , Precio_Mercado_Al_CIerre_o_Liquidacion         = 0
where Modulo = 'BacSwap' -- Para Swap no hay precio mercado
update #ContratosDerivadosMes 
    Set Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = 1 -- Valor Monetario
      , Precio_Mercado_Al_CIerre_o_Liquidacion         = case when Contrato_Vencido_En_El_Ejercicio = 1 then 
                                                          Precio_Fecha_Evento	
                                                         else Precio_Fecha_Cierre_Ejercicio end
where Modulo <> 'BacSwap' 
  and ( Modulo = 'BacForward' and Producto_Emp not in ( 10,11)
      or 
        Modulo = 'SAO'
      ) 
update #ContratosDerivadosMes 
    Set Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = 2 -- Valor Monetario
      , Precio_Mercado_Al_CIerre_o_Liquidacion         = Tasa_mercado_Al_Evento
where  Modulo = 'BacForward' and Producto_Emp in ( 10,11)

-- Pagos de los Seguros de Cambio Asociados a los MX/CLP

Create table #PagosSegCambio ( Id_sistema Varchar(3), Numero_operacion numeric(10), Fecha Datetime , Monto_CLP numeric(20) )
insert into #PagosSegCambio 
select 'BFW', CaNumoper, CaFecvcto, Monto_CLP
from #Vctos where CaCodPos1 = 1 and var_moneda2 <> 0
-- select * from #PagosSegCambio

delete #PagosSegCambio where fecha > @FechaCorteFinal
drop table #Vctos
-- Esquemas contables
select distinct Tipo_Cta = convert( varchar(5), 'PAG' )
              , enc.folio_Perfil
              , Enc.Id_Sistema
              , Enc.tipo_movimiento
              , Enc.tipo_operacion
              , Cta = isnull( VarDet.Codigo_Cuenta, Det.Codigo_Cuenta )
              , CtaNeg = case when substring( isnull( VarDet.Codigo_Cuenta, Det.Codigo_Cuenta ), 1, 3 ) = '760' then 'Pos'
                            else 'Neg' end

                /* Ojo que esto puede cambiar según el evento */
              , Producto = CASE 
                             WHEN Id_sistema = 'BFW'  THEN
								 case when tipo_Operacion like '10%' then '10'
									  when tipo_Operacion like '%11%' then '11'
									  when tipo_Operacion like '%12%' then '12'
									  when tipo_Operacion like '%13%' then '13'               
									  when tipo_Operacion like '%14%' then '14'
									  when tipo_Operacion like '%15%' then '15'
									  when tipo_Operacion like '%17%' then '17'
									  when tipo_Operacion like '%1%'  then '1'
									  when tipo_Operacion like '%2%'  then '2'
									  when tipo_Operacion like '%3%'  then '3'
								 else 'Indefinido' end
                              WHEN Id_sistema = 'PCS' THEN 
								 case when tipo_Operacion like '%1%' then '1'
									  when tipo_Operacion like '%2%' then '2'
									  when tipo_Operacion like '%4%' then '4'
								 else 'Indefinido' end
                              WHEN Id_Sistema = 'OPT' THEN
								 'OPT'
                            END
               , Compra_Venta = CASE 
                             WHEN Id_sistema = 'BFW'  THEN  /* Corregir */
								 substring( tipo_operacion, len( rtrim(ltrim(tipo_operacion))) , 1 )
                              WHEN Id_sistema = 'PCS' THEN -- No es relevante la compra-venta
								 'CV_NoApp'								 
                              WHEN Id_Sistema = 'OPT' THEN
								 case when tipo_operacion in ( 'FXCC', 'FXCP' ) then 'C'
                                 else 'V' end                            
                            END
                 , Call_Put = CASE 
                                WHEN Id_sistema = 'BFW'  THEN ''								 
                                WHEN Id_sistema = 'PCS' THEN ''
                                WHEN Id_Sistema = 'OPT' THEN
								   case when tipo_operacion in ( 'FXCC', 'FXVC' ) then 'Call'
                                   else 'Put' end                            
                              END           
                 , Codigo_InstrumentoTabDin = convert( varchar(10), case when codigo_instrumento = '' then 'N/A' else codigo_instrumento end ) -- Update posterior
                 , Moneda_InstrumentoTabDin = convert( varchar(10), case when moneda_instrumento = '' then 'N/A' else moneda_instrumento end ) -- Update posterior
                 , Codigo_Instrumento = convert( varchar(10), codigo_instrumento  ) -- Update posterior
                 , Moneda_Instrumento = convert( varchar(10), moneda_instrumento  ) -- Update posterior
                 , Det.codigo_campo_variable                  
                 , VarDet.valor_dato_campo 
                 , Tipo_Cartera_NormativaTabDin = case when valor_dato_campo in ( '1002', '1003', '1004', '1005', '1006', '1007' ) then 'Cob' else 'NoCob ' end 
                 , Tipo_Cartera_Normativa = case when valor_dato_campo in ( '1002', '1003', '1004', '1005', '1006', '1007' ) then 'C' else '' end 
                 , ModalidadTabDin = case when Det.codigo_campo in (609, 905, 906 ) then 'EF' else 'COMP' end -- select distinct codigo_campo from bacparamsuda..campo_cnt where descripcion_campo like '%E.%F.%'
                 , Modalidad = case when Det.codigo_campo in (609, 905, 906 ) then 'E' else 'C' end -- select distinct codigo_campo from bacparamsuda..campo_cnt where descripcion_campo like '%E.%F.%'
into #CondicionesCtasLIQ       
from bacparamsuda..perfil_cnt Enc
    left join bacparamsuda..perfil_detalle_cnt det on Enc.Folio_Perfil = Det.Folio_Perfil
    left join bacparamsuda..perfil_variable_cnt varDet on Enc.Folio_Perfil = VarDet.Folio_Perfil and det.correlativo_perfil = vardet.correlativo_perfil
where id_Sistema in ( 'BFW', 'PCS', 'OPT' )
and ( Enc.folio_perfil in ( select Folio_Perfil from bacparamsuda..perfil_detalle_cnt where codigo_Cuenta like '560%' or  codigo_Cuenta like '760%' )
         or 
      Enc.folio_perfil in ( select Folio_Perfil from bacparamsuda..perfil_variable_cnt where codigo_Cuenta like '560%' or codigo_Cuenta like '760%' )
    )
and ( Det.Codigo_Cuenta like '560%' or Det.Codigo_Cuenta like '760%'
      or  VarDet.Codigo_Cuenta like '560%' or VarDet.Codigo_Cuenta like '760%' )
and Tipo_Movimiento not in ('DEV', 'AVR', 'ANT') 

select distinct Tipo_Cta = convert( varchar(5), 'VR' )
              , enc.folio_Perfil
              , Enc.Id_Sistema
              , Enc.tipo_movimiento
              , Enc.tipo_operacion
              , Cta = isnull( VarDet.Codigo_Cuenta, Det.Codigo_Cuenta )
              , CtaNeg = case when substring( isnull( VarDet.Codigo_Cuenta, Det.Codigo_Cuenta ), 1, 3 ) = '760' then 'Pos'
                            else 'Neg' end


              , Producto = CASE 
                             WHEN Id_sistema = 'BFW'  THEN
								 case when tipo_Operacion like '10%' then '10'
									  when tipo_Operacion like '%11%' then '11'
									  when tipo_Operacion like '%12%' then '12'
									  when tipo_Operacion like '%13%' then '13'               
									  when tipo_Operacion like '%14%' then '14'
									  when tipo_Operacion like '%15%' then '15'
									  when tipo_Operacion like '%17%' then '17'
									  when tipo_Operacion like '%1%'  then '1'
									  when tipo_Operacion like '%2%'  then '2'
									  when tipo_Operacion like '%3%'  then '3'
								 else 'Indefinido' end
                              WHEN Id_sistema = 'PCS' THEN 
								 case when tipo_Operacion like '%1%' then '1'
									  when tipo_Operacion like '%2%' then '2'
									  when tipo_Operacion like '%4%' then '4'
								 else 'Indefinido' end
                              WHEN Id_Sistema = 'OPT' THEN
								 'OPT'
                            END
               , Compra_Venta = CASE 
                             WHEN Id_sistema = 'BFW'  THEN  /* Corregir */
								 substring( tipo_operacion, len( rtrim(ltrim(tipo_operacion))) , 1 )
                              WHEN Id_sistema = 'PCS' THEN -- No es relevante la compra-venta
								 ''								 
                              WHEN Id_Sistema = 'OPT' THEN
								 case when tipo_operacion in ( 'FXCC', 'FXCP' ) then 'C'
                                 else 'V' end                            
                            END
                 , Call_Put = CASE 
                                WHEN Id_sistema = 'BFW'  THEN ''								 
                                WHEN Id_sistema = 'PCS' THEN ''
                                WHEN Id_Sistema = 'OPT' THEN
								   case when tipo_operacion in ( 'FXCC', 'FXVC' ) then 'Call'
                                   else 'Put' end                            
                              END           
                 , Codigo_Instrumento = convert( varchar(10), codigo_instrumento) -- Update posterior
                 , Moneda_Instrumento = convert( varchar(10), moneda_instrumento) -- Update posterior
                 , codigo_campo_variable = case when perfil_fijo = 'S' then 0 else codigo_Campo_variable end                 
                 , valor_dato_campo 
                 , Tipo_Cartera_Normativa = case when valor_dato_campo in ( '1002', '1003', '1004', '1005', '1006', '1007' ) then 'C' else ' ' end 
into #CondicionesCtasVR                                

from bacparamsuda..perfil_cnt Enc
    left join bacparamsuda..perfil_detalle_cnt det on Enc.Folio_Perfil = Det.Folio_Perfil
    left join bacparamsuda..perfil_variable_cnt varDet on Enc.Folio_Perfil = VarDet.Folio_Perfil and det.correlativo_perfil = vardet.correlativo_perfil
where id_Sistema in ( 'BFW', 'PCS', 'OPT' )
and ( Enc.folio_perfil in ( select Folio_Perfil from bacparamsuda..perfil_detalle_cnt where codigo_Cuenta like '560%' or  codigo_Cuenta like '760%' )
         or 
      Enc.folio_perfil in ( select Folio_Perfil from bacparamsuda..perfil_variable_cnt where codigo_Cuenta like '560%' or codigo_Cuenta like '760%' )
    )
and ( Det.Codigo_Cuenta like '560%' or Det.Codigo_Cuenta like '760%'
      or  VarDet.Codigo_Cuenta like '560%' or VarDet.Codigo_Cuenta like '760%' )
and Tipo_Movimiento in ('DEV', 'AVR') -- Ojo los anticipos usan otras cuentas y deben usar la misma!! 

-- select * from #CondicionesCtasVR where id_Sistema = 'PCS' order by folio_perfil

select distinct Tipo_Cta, Id_Sistema , Cta, CtaNeg, Producto, Compra_Venta, Call_Put, Codigo_Instrumento, Moneda_Instrumento, Tipo_Cartera_Normativa, Modalidad = '', valor_dato_campo
into #CondicionesCtas
 from #CondicionesCtasVR
union
select distinct Tipo_Cta, Id_Sistema , Cta, CtaNeg, Producto, Compra_Venta, Call_Put, Codigo_Instrumento, Moneda_Instrumento, Tipo_Cartera_Normativa, Modalidad, valor_dato_campo
 from #CondicionesCtasLIQ -- select * from #CondicionesCtasLIQ where moneda_instrumento = 5

-- Abregar Cuentas para cartera
select distinct Tipo_Cta = Convert( varchar(5), 'CarVR' )
              , enc.folio_Perfil
              , Enc.Id_Sistema
              , Enc.tipo_movimiento
              , Enc.tipo_operacion
              , Cta = isnull( VarDet.Codigo_Cuenta, Det.Codigo_Cuenta )
              , CtaNeg = case when substring( isnull( VarDet.Codigo_Cuenta, Det.Codigo_Cuenta ), 1, 3 ) = '212' then 'Pos'
                            else 'Neg' end


              , Producto = CASE 
                             WHEN Id_sistema = 'BFW'  THEN
								 case when tipo_Operacion like '10%' then '10'
									  when tipo_Operacion like '%11%' then '11'
									  when tipo_Operacion like '%12%' then '12'
									  when tipo_Operacion like '%13%' then '13'               
									  when tipo_Operacion like '%14%' then '14'
									  when tipo_Operacion like '%15%' then '15'
									  when tipo_Operacion like '%17%' then '17'
									  when tipo_Operacion like '%1%'  then '1'
									  when tipo_Operacion like '%2%'  then '2'
									  when tipo_Operacion like '%3%'  then '3'
								 else 'Indefinido' end
                              WHEN Id_sistema = 'PCS' THEN 
								 case when tipo_Operacion like '%1%' then '1'
									  when tipo_Operacion like '%2%' then '2'
									  when tipo_Operacion like '%4%' then '4'
								 else 'Indefinido' end
                              WHEN Id_Sistema = 'OPT' THEN
								 'OPT'
                            END
               , Compra_Venta = CASE 
                             WHEN Id_sistema = 'BFW'  THEN  /* Corregir */
								 substring( tipo_operacion, len( rtrim(ltrim(tipo_operacion))) , 1 )
                              WHEN Id_sistema = 'PCS' THEN -- No es relevante la compra-venta
								 ''								 
                              WHEN Id_Sistema = 'OPT' THEN
								 case when tipo_operacion in ( 'FXCC', 'FXCP' ) then 'C'
                                 else 'V' end                            
                            END
                 , Call_Put = CASE 
                                WHEN Id_sistema = 'BFW'  THEN ''								 
                                WHEN Id_sistema = 'PCS' THEN ''
                                WHEN Id_Sistema = 'OPT' THEN
								   case when tipo_operacion in ( 'FXCC', 'FXVC' ) then 'Call'
                                   else 'Put' end                            
                              END           
                 , Codigo_Instrumento = convert( varchar(10), codigo_instrumento) -- Update posterior
                 , Moneda_Instrumento = convert( varchar(10), moneda_instrumento) -- Update posterior
                 , codigo_campo_variable = case when perfil_fijo = 'S' then 0 else codigo_Campo_variable end                 
                 , valor_dato_campo 
                 , Tipo_Cartera_Normativa = case when valor_dato_campo in ( '1002', '1003', '1004', '1005', '1006', '1007' ) then 'C' else ' ' end 
into #CondicionesCtasCARVR                                

from bacparamsuda..perfil_cnt Enc
    left join bacparamsuda..perfil_detalle_cnt det on Enc.Folio_Perfil = Det.Folio_Perfil
    left join bacparamsuda..perfil_variable_cnt varDet on Enc.Folio_Perfil = VarDet.Folio_Perfil and det.correlativo_perfil = vardet.correlativo_perfil
where id_Sistema in ( 'BFW', 'PCS', 'OPT' )
and ( Enc.folio_perfil in ( select Folio_Perfil from bacparamsuda..perfil_detalle_cnt where codigo_Cuenta like '4128%' or  codigo_Cuenta like '2128%' )
         or 
      Enc.folio_perfil in ( select Folio_Perfil from bacparamsuda..perfil_variable_cnt where codigo_Cuenta like '4128%' or codigo_Cuenta like '2128%' )
    )
and ( Det.Codigo_Cuenta like '4128%' or Det.Codigo_Cuenta like '2128%'
      or  VarDet.Codigo_Cuenta like '4128%' or VarDet.Codigo_Cuenta like '2128%' )
and Tipo_Movimiento in ('DEV', 'AVR')

insert  #CondicionesCtas
select distinct Tipo_Cta, Id_Sistema , Cta, CtaNeg, Producto, Compra_Venta, Call_Put, Codigo_Instrumento, Moneda_Instrumento, Tipo_Cartera_Normativa, Modalidad = '', valor_dato_campo
 from #CondicionesCtasCARVR

-- Filtros de condiciones contables para rescatar las cuentas
-- Usar planilla CondicionesCuentasResultadoLiquidacionYVR.xlsx
CREATE TABLE #FILTROCONTABLE ( COND_Id_sistema varchar(3) , COND_Producto Varchar(5), COND_Filtros Varchar(500) , Evento varchar(3) )

Insert into #FILTROCONTABLE select 'BFW' , '1', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1   and KeyCntMoneda2 = Codigo_instrumento and 1 = 1   and KeyCntModalidad = Modalidad and KeyCntCarNormativa = Tipo_Cartera_Normativa', 'PAG'
Insert into #FILTROCONTABLE select 'BFW' , '2', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento and KeyCntMoneda1  = Moneda_instrumento and KeyCntModalidad = Modalidad  and 1 = 1 ', 'PAG'
Insert into #FILTROCONTABLE select 'BFW' , '3', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1   and 1 = 1  and KeyCntCarNormativa = Tipo_Cartera_Normativa', 'PAG'
Insert into #FILTROCONTABLE select 'BFW' , '10', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda1= Codigo_instrumento  and 1 = 1   and 1 = 1   and 1 = 1 ', 'PAG'
Insert into #FILTROCONTABLE select 'BFW' , '13', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1   and 1 = 1   and 1 = 1 ', 'PAG'
Insert into #FILTROCONTABLE select 'BFW' , '14', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1  and KeyCntModalidad = Modalidad  and 1 = 1 ', 'PAG'
Insert into #FILTROCONTABLE select 'BFW' , '15', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1  and KeyCntModalidad = Modalidad  and 1 = 1 ', 'PAG'
Insert into #FILTROCONTABLE select 'BFW' , '17', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1  and KeyCntModalidad = Modalidad  and 1 = 1 ', 'PAG'
Insert into #FILTROCONTABLE select 'OPT' , 'OPT', ' 1 = 1 and  KeyCntTipOper = Compra_venta  and KeyCntCallPut = Call_Put and KeyCntMoneda2 = Codigo_instrumento and KeyCntMoneda1  = Moneda_instrumento  and 1 = 1   and 1 = 1 ', 'PAG'
Insert into #FILTROCONTABLE select 'PCS' , '2', 'KeyCntProducto = Producto  and 1 = 1   and 1 = 1   and 1 = 1  and KeyCntMoneda1  = Moneda_instrumento  and 1 = 1  and KeyCntCarNormativa = Tipo_Cartera_Normativa', 'PAG'
Insert into #FILTROCONTABLE select 'PCS' , '1', 'KeyCntProducto = Producto  and 1 = 1   and 1 = 1   and 1 = 1  and KeyCntMoneda1  = Moneda_instrumento  and 1 = 1  and KeyCntCarNormativa = Tipo_Cartera_Normativa', 'PAG'
Insert into #FILTROCONTABLE select 'PCS' , '4', 'KeyCntProducto = Producto  and 1 = 1   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento and KeyCntMoneda1  = Moneda_instrumento  and 1 = 1  and KeyCntCarNormativa = Tipo_Cartera_Normativa', 'PAG'
Insert into #FILTROCONTABLE select 'BFW' , '1', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1   and 1 = 1  and KeyCntCarNormativa = Tipo_Cartera_Normativa', 'VR'
Insert into #FILTROCONTABLE select 'BFW' , '2', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento and KeyCntMoneda1  = Moneda_instrumento  and 1 = 1   and 1 = 1 ', 'VR'
Insert into #FILTROCONTABLE select 'BFW' , '3', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1   and 1 = 1  and KeyCntCarNormativa = Tipo_Cartera_Normativa', 'VR'
Insert into #FILTROCONTABLE select 'BFW' , '10', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda1 = Codigo_instrumento  and 1 = 1   and 1 = 1   and 1 = 1 ', 'VR'
Insert into #FILTROCONTABLE select 'BFW' , '13', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1   and 1 = 1   and 1 = 1 ', 'VR'
Insert into #FILTROCONTABLE select 'BFW' , '14', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1   and 1 = 1   and 1 = 1 ', 'VR'
Insert into #FILTROCONTABLE select 'BFW' , '15', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1   and 1 = 1   and 1 = 1 ', 'VR'
Insert into #FILTROCONTABLE select 'BFW' , '17', 'KeyCntProducto = Producto and  KeyCntTipOper = Compra_venta   and 1 = 1  and KeyCntMoneda2 = Codigo_instrumento  and 1 = 1   and 1 = 1   and 1 = 1 ', 'VR'
Insert into #FILTROCONTABLE select 'OPT' , 'OPT', ' 1 = 1 and  KeyCntTipOper = Compra_venta  and KeyCntCallPut = Call_Put and KeyCntMoneda2 = Codigo_instrumento and KeyCntMoneda1  = Moneda_instrumento  and 1 = 1   and 1 = 1 ', 'VR'
-- Insert into #FILTROCONTABLE select 'PCS' , '1', 'KeyCntProducto = Producto  and 1 = 1   and 1 = 1   and 1 = 1  and KeyCntMoneda2  = Moneda_instrumento  and 1 = 1   and (KeyCntCarNormativa = Tipo_Cartera_Normativa and Moneda_Instrumento = 13 or Moneda_Instrumento <> 13 )', 'VR'
Insert into #FILTROCONTABLE select 'PCS' , '1', 'KeyCntProducto = Producto  and 1 = 1   and 1 = 1   and 1 = 1  and KeyCntMoneda2  = Moneda_instrumento  and 1 = 1   and (KeyCntCarNormativa = Tipo_Cartera_Normativa )', 'VR'
Insert into #FILTROCONTABLE select 'PCS' , '2', 'KeyCntProducto = Producto  and 1 = 1   and 1 = 1   and 1 = 1  and 999  = Moneda_instrumento  and 1 = 1  and KeyCntCarNormativa = Tipo_Cartera_Normativa', 'VR'
Insert into #FILTROCONTABLE select 'PCS' , '4', 'KeyCntProducto = Producto  and 1 = 1   and 1 = 1   and 1 = 1  and KeyCntMoneda2  = Moneda_instrumento  and 1 = 1  and KeyCntCarNormativa = Tipo_Cartera_Normativa', 'VR'


/**************************************************
  rescata Cuenta CtaVRPos BFW
***************************************************/
declare @QueryActualizaCuentas varchar(8000)

update #ContratosDerivadosMes
   set KeyCntCarNormativa = case when KeyCntCarNormativa = 'C' then 'C' else '' end 
     , KeyCntSubCarNormativa = case when  KeyCntCarNormativa = 'T' then 4 else  KeyCntSubCarNormativa end
     , KeyCntMoneda2 = case when KeyCntId_sistema = 'PCS' and Contrato = 4267 then 998 else KeyCntMoneda2 end

	 /* Error de ejecución
	 Msg 245, Level 16, State 1, Line 28845
     Conversion failed when converting the varchar value 'F' to data type int.
	 select * from #ContratosDerivadosMes where KeyCntSubCarNormativa = 'F'
	 select * from bacSwapSuda.dbo.Carterahis  where chi_SubCartera_Normativa = 'F'
	  */



/* IMPORTANTE
   Hubo varias actualizaciones de cartera directo a la base de datos, estas al no tener movimiento
   hace imposible buscar el valor que puede tener al cargar el evento de curse en que
   generalmente no hay RES debido a lo antiguo de la fecha.
   Por otro lado hay actualizaciones que pasaron de 'C'(Cobertura) a 'T'(Trading) pero resulta
   que se cambió solamente la cartera y no la subcartera, por lo tanto hay operaciones
   con subcartera inconsistente en trading. Esto no afecta los sistemas porque la subcartera
   en caso de cartera normativa 'TRADING' no lee las subcarteras para asignar contabilidad.
   DJ hará lo mismo colocando blanco en caso de TRADING y asignando 4 como subcartera para
   poder usar este campo en los casos que se deba rescatar una cuenta con el criterio
   de subcartera.
*/


-- Parche válido hasta que se
-- utilicen las subcarteras
delete #CondicionesCtas where Id_sistema = 'PCS' and tipo_Cta = 'CarVR'  and Cta = '412801008' and tipo_Cartera_Normativa = 'C'

select Id_sistema
     , codigo_producto = case when Id_sistema = 'PCS' then
                                              Case when Codigo_producto = 'SM' then '2' 
                                                   when Codigo_producto = 'SP' then '4' 
                                                   when Codigo_producto = 'ST' then '1'
                                                   else '3'
                                              end                                          
                                       else codigo_producto end
     , Correlativo = identity(INT, 1, 1)  
into #CursorProductos                                     
from bacParamSuda..producto where id_sistema in ( 'PCS', 'BFW', 'OPT' ) 

insert into #CursorProductos select 'BFW', 15
insert into #CursorProductos select 'BFW', 17
 

declare @CorrProductoAux numeric(10)
declare @MaxProductoAux  numeric(10)
select  @MaxProductoAux =  count(1) from #CursorProductos
select @CorrProductoAux = 1
declare @Id_SistemaAux varchar(3)
declare @ProductoAux   varchar(5)
while ( @CorrProductoAux <= @MaxProductoAux )
begin
    select @Id_SistemaAux = Id_sistema
        ,  @ProductoAux = codigo_producto from #CursorProductos where Correlativo = @CorrProductoAux        

	/**************************************************
	  rescata Cuenta CtaVRPos
	***************************************************/
	set @QueryActualizaCuentas = ''
	select  @QueryActualizaCuentas = @QueryActualizaCuentas + 
	 'Update #ContratosDerivadosMes
		set
		   CntCtaVRPos         = Cta     
	from  #CondicionesCtas CondCta 
		where  ' + COND_Filtros +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = CondCta.Id_Sistema ' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = CondCta.Producto ' +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = ' + '''' + ltrim(rtrim(@Id_SistemaAux)) + '''' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = ' + '''' + ltrim(rtrim(@ProductoAux)) + + '''' + 
	  ' And CondCta.CtaNeg = ''Pos'' '  + 
	  ' And CondCta.Tipo_Cta = ''VR'' ;' + char(13)  
	from  #FILTROCONTABLE
		where COND_Id_sistema = @Id_SistemaAux  
			and COND_Producto = @ProductoAux
            and Evento = 'VR'
	exec( @QueryActualizaCuentas ) 
    --select @Id_SistemaAux, @ProductoAux, @QueryActualizaCuentas
    -- select * from #FILTROCONTABLE
    -- select * from #CondicionesCtas  where producto = 1 and id_sistema = 'PCS'  and cta = '412801008'
	/**************************************************
	  rescata Cuenta CtaVRNeg
	***************************************************/
	set @QueryActualizaCuentas = ''
	select  @QueryActualizaCuentas = @QueryActualizaCuentas + 
	 'Update #ContratosDerivadosMes
		set
		   CntCtaVRNeg         = Cta     
	from  #CondicionesCtas CondCta
		where  ' + COND_Filtros +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = CondCta.Id_Sistema ' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = CondCta.Producto ' +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = ' + '''' + ltrim(rtrim(@Id_SistemaAux)) + '''' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = ' + '''' + ltrim(rtrim(@ProductoAux)) + + '''' + 
	  ' And CondCta.CtaNeg = ''Neg'' '  + 
	  ' And CondCta.Tipo_Cta = ''VR'' ;' + char(13)  
	from  #FILTROCONTABLE
		where COND_Id_sistema = @Id_SistemaAux   -- Para que el comando no salga tan largo
			and  COND_Producto = @ProductoAux     -- Para activar las condiciones de este producto solamente     
            and  Evento = 'VR'
	exec( @QueryActualizaCuentas ) 
    --select @Id_SistemaAux, @ProductoAux, @QueryActualizaCuentas
	/**************************************************
	  rescata Cuenta CtaResultadoPos (Liquidacion)
	***************************************************/
	set @QueryActualizaCuentas = ''
	select  @QueryActualizaCuentas = @QueryActualizaCuentas + 
	 'Update #ContratosDerivadosMes
		set
		   CntCtaResultadoPos         = Cta     
	from  #CondicionesCtas CondCta
		where  ' + COND_Filtros +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = CondCta.Id_Sistema ' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = CondCta.Producto ' +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = ' + '''' + ltrim(rtrim(@Id_SistemaAux)) + '''' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = ' + '''' + ltrim(rtrim(@ProductoAux)) + + '''' + 
	  ' And CondCta.CtaNeg = ''Pos'' '  + 
	  ' And CondCta.Tipo_Cta = ''PAG'' ;' + char(13)  
	from  #FILTROCONTABLE
		where COND_Id_sistema = @Id_SistemaAux   -- Para que el comando no salga tan largo
			and  COND_Producto = @ProductoAux     -- Para activar las condiciones de este producto solamente     
            and Evento = 'PAG'
	exec( @QueryActualizaCuentas ) 
    --select @Id_SistemaAux, @ProductoAux, @QueryActualizaCuentas
	/**************************************************
	  rescata Cuenta CtaResultadoNeg (Liquidacion)
	***************************************************/
	set @QueryActualizaCuentas = ''
	select  @QueryActualizaCuentas = @QueryActualizaCuentas + 
	 'Update #ContratosDerivadosMes
		set
		   CntCtaResultadoNeg         = Cta     
	from  #CondicionesCtas CondCta
		where  ' + COND_Filtros +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = CondCta.Id_Sistema ' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = CondCta.Producto ' +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = ' + '''' + ltrim(rtrim(@Id_SistemaAux)) + '''' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = ' + '''' + ltrim(rtrim(@ProductoAux)) + + '''' + 
	  ' And CondCta.CtaNeg = ''Neg'' '  + 
	  ' And CondCta.Tipo_Cta = ''PAG'' ;' + char(13)  
	from  #FILTROCONTABLE
		where COND_Id_sistema = @Id_SistemaAux   -- Para que el comando no salga tan largo
			and  COND_Producto = @ProductoAux     -- Para activar las condiciones de este producto solamente     
            and Evento = 'PAG'
	exec( @QueryActualizaCuentas ) 
    --select @Id_SistemaAux, @ProductoAux, @QueryActualizaCuentas

	/**************************************************
	  rescata Cuenta CtaCarVRPos
	***************************************************/
	set @QueryActualizaCuentas = ''
	select  @QueryActualizaCuentas = @QueryActualizaCuentas + 
	 'Update #ContratosDerivadosMes
		set
		   CntCtaCarVRPos         = Cta     
	from  #CondicionesCtas CondCta
		where  ' + COND_Filtros +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = CondCta.Id_Sistema ' +  char(13) + 
	  ' And #ContratosDerivadosMes.KeyCntProducto = CondCta.Producto ' +  char(13)  +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = ' + '''' + ltrim(rtrim(@Id_SistemaAux)) + '''' +  char(13)  +
	  ' And #ContratosDerivadosMes.KeyCntProducto = ' + '''' + ltrim(rtrim(@ProductoAux)) + + '''' +   char(13)  +
	  ' And CondCta.CtaNeg = ''Pos'' '  +  char(13)  +
	  ' And CondCta.Tipo_Cta = ''CarVR'' ;' + char(13)  
	from  #FILTROCONTABLE
		where COND_Id_sistema = @Id_SistemaAux  
			and COND_Producto = @ProductoAux
            and Evento = 'VR'
	exec( @QueryActualizaCuentas ) 
    -- select 'debug', @Id_SistemaAux, @ProductoAux, '*'+ @QueryActualizaCuentas + '*'

	/**************************************************
	  rescata Cuenta CtaCarVRNeg
	***************************************************/
	set @QueryActualizaCuentas = ''
	select  @QueryActualizaCuentas = @QueryActualizaCuentas + 
	 'Update #ContratosDerivadosMes
		set
		   CntCtaCarVRNeg         = Cta     
	from  #CondicionesCtas CondCta
		where  ' + COND_Filtros +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = CondCta.Id_Sistema ' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = CondCta.Producto ' +
	  ' And #ContratosDerivadosMes.KeyCntId_sistema = ' + '''' + ltrim(rtrim(@Id_SistemaAux)) + '''' +
	  ' And #ContratosDerivadosMes.KeyCntProducto = ' + '''' + ltrim(rtrim(@ProductoAux)) + + '''' + 
	  ' And CondCta.CtaNeg = ''Neg'' '  + 
	  ' And CondCta.Tipo_Cta = ''CarVR'' ;' + char(13)  
	from  #FILTROCONTABLE
		where COND_Id_sistema = @Id_SistemaAux   -- Para que el comando no salga tan largo
			and  COND_Producto = @ProductoAux     -- Para activar las condiciones de este producto solamente     
            and  Evento = 'VR'
	exec( @QueryActualizaCuentas ) 
/*
select 'debug', * from #CondicionesCtas where CtaNeg = 'Neg' and Tipo_cta = 'CarVR' and Id_Sistema = 'PCS' and producto = 1
select 'debug', * from #CondicionesCtas where CtaNeg = 'Pos' and Tipo_cta = 'CarVR' and Id_Sistema = 'PCS' and producto = 1
*/

    select @CorrProductoAux = @CorrProductoAux + 1
end
-- select * from #FILTROCONTABLE where evento = 'VR' and COND_Id_sistema = 'PCS'
-- Limpiar los eventos que no liquidan 
-- de cuentas de pago:
update #ContratosDerivadosMes
   set CntCtaResultadoPos = '' , CntCtaResultadoNeg = '' where evento in ( 'Curse', 'Modificacion' )

update #ContratosDerivadosMes
   set CntCtaResultadoPos = '' , CntCtaResultadoNeg = '' where evento in ( 'Cuadratura' ) and subevento = 'Valor Razonable'


-- select distinct evento from #ContratosDerivadosMes


-- REDIRECCIONAR CUENTAS
-- Correción de cuentas por variación de perfil
-- a lo largo del tiempo 554627
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' 
where KeyCntId_sistema = 'BFW' and contrato = 555921 and FechaEvento = '20130115' 
and ( Evento = 'Anticipo'
and   SubEvento = 'TOTAL' )

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
where KeyCntId_sistema = 'BFW' and contrato = 551494 and FechaEvento = '20130110' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
where KeyCntId_sistema = 'BFW' and contrato = 556073 and FechaEvento = '20130121' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' 
where KeyCntId_sistema = 'BFW' and contrato in ( 559323, 559324, 559325)  and FechaEvento = '20130225' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
where KeyCntId_sistema = 'BFW' and contrato in ( 560562, 560563, 560572)  and FechaEvento = '20130225' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' 
where KeyCntId_sistema = 'BFW' and contrato in ( 557644 )  and FechaEvento = '20130307' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' 
where KeyCntId_sistema = 'BFW' and contrato in ( 559305, 559307, 559310 )  and FechaEvento = '20130326' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' 
where KeyCntId_sistema = 'BFW' and contrato in ( 559686 )  and FechaEvento = '20130318' 
and Evento = 'Anticipo'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' 
where KeyCntId_sistema = 'BFW' and contrato in ( 560650 )  and FechaEvento = '20130326' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
where KeyCntId_sistema = 'BFW' and contrato in ( 560798, 560800, 560804,560806 )  and FechaEvento = '20130307' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
where KeyCntId_sistema = 'BFW' and contrato in ( 561687, 561688, 561690, 561691 )  and FechaEvento = '20130326' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' 
where KeyCntId_sistema = 'BFW' and contrato in ( 562810, 562811  )  and FechaEvento = '20130424' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
where KeyCntId_sistema = 'BFW' and contrato in ( 558522  )  and FechaEvento = '20130403' 
and Evento = 'Vcto. Natural'

-- Habria que ajustar el módulo contable para que sea
-- capaz de llegar a esta cuenta.
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701040', CntCtaResultadoNeg = '560701040' 
where KeyCntId_sistema = 'BFW' and contrato in ( 556687  )  and FechaEvento = '20130508' 
and Evento = 'Vcto. Natural'

--update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
--where KeyCntId_sistema = 'BFW' and contrato in ( 564282  )  and FechaEvento = '20130528' 
--and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
where KeyCntId_sistema = 'BFW' and contrato in ( 564286 )  and FechaEvento = '20130528' 
and Evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
where KeyCntId_sistema = 'BFW' and contrato in ( 564300 )  and FechaEvento = '20130529' 
and Evento = 'Vcto. Natural'

---El monto partió en la 35, se llevó a la 39 y luego a la 211001168 ¿?
-- email consulta por esta situación, por mientras no cambiaremos la cuenta
----update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
----where KeyCntId_sistema = 'BFW' and contrato = 568831 and FechaEvento = '20131017' 
----and ( Evento = 'Anticipo'
----and   SubEvento = 'TOTAL' )

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701039', CntCtaResultadoNeg = '560701039' 
where KeyCntId_sistema = 'BFW' and contrato in ( 555770 )  and FechaEvento = '20130115' 
and Evento = 'Vcto. Natural'





update #ContratosDerivadosMes set CntCtaResultadoPos = '760701057', CntCtaResultadoNeg = '560701056' 
where KeyCntId_sistema = 'PCS' and contrato in ( 3879, 3884, 3887, 3889 )  and FechaEvento = '20130617' 
and Evento = 'Liquidacion'

-- Rompimientos de  coberturas
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701030', CntCtaResultadoNeg = '560701030' 
where KeyCntId_sistema = 'PCS' and contrato 
in ( 7039
,7193
,7194
,7404
,7410
 )  and Evento = 'Anticipo' and SubEvento = 'TOTAL'


--- Al parecer regularizaron los pagos de las operacones
--- que pasaron de cobertura a Trading
-- en algún momento los comenté
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701082', CntCtaResultadoNeg = '560701080' 
where KeyCntId_sistema = 'PCS' and contrato in ( 5261 )  and FechaEvento = '20130325' 
and Evento = 'Liquidacion'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701082', CntCtaResultadoNeg = '560701080' 
where KeyCntId_sistema = 'PCS' and contrato in ( 6619 )  and FechaEvento = '20130509' 
and Evento = 'Liquidacion'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701082', CntCtaResultadoNeg = '560701080' 
where KeyCntId_sistema = 'PCS' and contrato in ( 5125 )  and FechaEvento = '20130531' 
and Evento = 'Liquidacion'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701082', CntCtaResultadoNeg = '560701080' 
where KeyCntId_sistema = 'PCS' and contrato in ( 5213 )  and FechaEvento = '20130628' 
and Evento = 'Liquidacion'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701082', CntCtaResultadoNeg = '560701080' 
where KeyCntId_sistema = 'PCS' and contrato in ( 5158 )  and FechaEvento = '20130523' 
and Evento = 'Liquidacion'


update #ContratosDerivadosMes set CntCtaResultadoPos = '760701029', CntCtaResultadoNeg = '560701029' 
where KeyCntId_sistema = 'PCS' and contrato in ( 5341 )  and FechaEvento = '20130821' 
and Evento = 'Anticipo'

-- Cambio de clasificación de cartera
update #ContratosDerivadosMes Set CntCtaResultadoPos = '760701042', CntCtaResultadoNeg = '560701042'
where KeyCntId_sistema = 'PCS' and contrato in ( 5155 )  and FechaEvento = '20130418' 
and Evento = 'Liquidacion'

-- Cambio de clasificación de cartera
update #ContratosDerivadosMes Set CntCtaResultadoPos = '760701057', CntCtaResultadoNeg = '560701056'
where KeyCntId_sistema = 'PCS' and contrato in ( 3879, 3884, 3887, 3889 ) 
and FechaEvento in ( '20130115', '20130215' ,  '20130315', '20130415', '20130515' )
and Evento = 'Liquidacion'



-- Mayo 2012
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701082', CntCtaResultadoNeg = '560701080' where KeyCntId_sistema = 'PCS' and contrato = 3294 and FechaEvento = '20120515' and evento = 'Liquidacion'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701082', CntCtaResultadoNeg = '560701080' where KeyCntId_sistema = 'PCS' and contrato = 3296 and FechaEvento = '20120515' and evento = 'Liquidacion'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701082', CntCtaResultadoNeg = '560701080' where KeyCntId_sistema = 'PCS' and contrato = 3457 and FechaEvento = '20120515' and evento = 'Liquidacion'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701082', CntCtaResultadoNeg = '560701080' where KeyCntId_sistema = 'PCS' and contrato = 4408 and FechaEvento = '20120515' and evento = 'Liquidacion'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701040', CntCtaResultadoNeg = '560701040' where KeyCntId_sistema = 'BFW' and contrato = 39196 and FechaEvento = '20120509' and evento = 'Vcto. Natural'

update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 547975 and FechaEvento = '20120529' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 548309 and FechaEvento = '20120502' and evento = 'Vcto. Natural'

-- Junio 2012
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 548338 and FechaEvento = '20120611' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 549194 and FechaEvento = '20120605' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 549661 and FechaEvento = '20120628' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 550147 and FechaEvento = '20120625' and evento = 'Vcto. Natural'

-- Julio
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 549724 and FechaEvento = '20120710' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 551996 and FechaEvento = '20120725' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 549662 and FechaEvento = '20120725' and evento = 'Vcto. Natural'
-- Agosto
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 551305 and FechaEvento = '20120808' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 551366 and FechaEvento = '20120829' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 551669 and FechaEvento = '20120829' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701035', CntCtaResultadoNeg = '560701035' where KeyCntId_sistema = 'BFW' and contrato = 551899 and FechaEvento = '20120803' and evento = 'Vcto. Natural'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701038', CntCtaResultadoNeg = '560701038' where KeyCntId_sistema = 'BFW' and contrato = 550806 and FechaEvento = '20120831' and evento = 'Anticipo'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701038', CntCtaResultadoNeg = '560701038' where KeyCntId_sistema = 'BFW' and contrato = 551748 and FechaEvento = '20120831' and evento = 'Anticipo'

-- Ingresado el 23 de Julio 2013
-- Analisis Ene-12 Hoja 2
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701057', CntCtaResultadoNeg = '560701056' where KeyCntId_sistema = 'PCS' and contrato = 2260 and FechaEvento = '20120109' and evento = 'Liquidacion'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701057', CntCtaResultadoNeg = '560701056' where KeyCntId_sistema = 'PCS' and contrato = 2263 and FechaEvento = '20120109' and evento = 'Liquidacion'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701057', CntCtaResultadoNeg = '560701056' where KeyCntId_sistema = 'PCS' and contrato = 3066 and FechaEvento = '20120110' and evento = 'Liquidacion'
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701057', CntCtaResultadoNeg = '560701056' where KeyCntId_sistema = 'PCS' and contrato = 3987 and FechaEvento = '20120109' and evento = 'Liquidacion'
-- Analisis Feb-12 Hoja 1
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701030', CntCtaResultadoNeg = '560701030' where KeyCntId_sistema = 'PCS' and contrato = 2343 and FechaEvento = '20120202' and evento = 'Liquidacion'
-- Analisis Feb-12 Hoja 3
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701032', CntCtaResultadoNeg = '560701032' where KeyCntId_sistema = 'PCS' and contrato = 4506 and FechaEvento = '20120228' and evento = 'Liquidacion'
-- Analisis May-12 V.2. Hoja 1
update #ContratosDerivadosMes set CntCtaResultadoPos = '760701029', CntCtaResultadoNeg = '560701029' 
where KeyCntId_sistema = 'PCS' and contrato in ( 1731, 1733, 1735, 1736, 1737, 1738, 1739, 1740 )
  and FechaEvento = '20120507' and evento = 'Liquidacion'





-- Para Cuadratura de Valor Razonable
update #ContratosDerivadosMes Set CntCtaVRPos = '760701006' , CntCtaVRNeg = '560701006' where Contrato = 2645 and KeyCntId_sistema = 'PCS'
update #ContratosDerivadosMes Set CntCtaVRPos = '760701011' , CntCtaVRNeg = '560701011' where Contrato = 3351 and KeyCntId_sistema = 'PCS'
update #ContratosDerivadosMes Set CntCtaVRPos = '760701010' , CntCtaVRNeg = '560701010' where Contrato = 4267 and KeyCntId_sistema = 'PCS'
update #ContratosDerivadosMes Set CntCtaVRPos = '760701068' , CntCtaVRNeg = '560701066' where Contrato = 1591 and KeyCntId_sistema = 'OPT'
update #ContratosDerivadosMes Set CntCtaVRPos = '760701069' , CntCtaVRNeg = '560701067' where Contrato = 1592 and KeyCntId_sistema = 'OPT'

-- CuadraturaAVR Hoja "1"
update #ContratosDerivadosMes Set CntCtaVRPos = '760701081' , CntCtaVRNeg = '560701079' where Contrato = 3294 and KeyCntId_sistema = 'PCS'
update #ContratosDerivadosMes Set CntCtaVRPos = '760701081' , CntCtaVRNeg = '560701079' where Contrato = 3296 and KeyCntId_sistema = 'PCS'
update #ContratosDerivadosMes Set CntCtaVRPos = '760701081' , CntCtaVRNeg = '560701079' where Contrato = 3457 and KeyCntId_sistema = 'PCS'

update #ContratosDerivadosMes Set CntCtaVRPos = '760701010' , CntCtaVRNeg = '560701010' where Contrato = 3370 and KeyCntId_sistema = 'PCS'

-- Perfiles de Cuentas Externas a Bac
-- Dada una cuenta de activo-Pasivo- Patrimonio se 
-- obtiene la cuenta de resultado -- select * from #Cta_Resultado where concepto = 'Complementarias' order by cta
create table #Cta_Resultado
(   Cta     Varchar(50)
  , Cta_Util Varchar(50)
  , Cta_Perd Varchar(50)  
  , Concepto Varchar(50)    
) 
-- Cuentas de ajustes de AVR externas a BAC
insert into  #Cta_Resultado select '212801048', '760701097', '560701078', 'Pargua' -- Set Pargua
insert into  #Cta_Resultado select '412801054', ''         , '560701111', 'Provisiones' -- Forward Negociacion
insert into  #Cta_Resultado select '412801055', ''         , '560701111', 'Provisiones' -- Swap Negociacion
insert into  #Cta_Resultado select '412801056', ''         , '560701111', 'Provisiones' -- Opciones Negociación
insert into  #Cta_Resultado select '412801057', ''         , '560701112', 'Provisiones' -- Forward Cobertura
insert into  #Cta_Resultado select '412801058', ''         , '560701112', 'Provisiones' -- Swap Cobertura
-- Cuentas de complementarias de externas a BAC
insert into #Cta_resultado select '411501031', '760701096', '560701094' , 'Complementarias' -- ok Comp. Covertura VR Bonos 
insert into #Cta_resultado select '411501030', '760701096', '560701094' , 'Complementarias' -- ok Comp. Covertura VR Bonos 
insert into #Cta_resultado select '411501026', '760701106', '560701094' , 'Complementarias' -- ok Comp. Covertura VR Bonos 
insert into #Cta_resultado select '411501033', '760701115', '560701114' , 'Complementarias' -- ok Comp. Bonos Usd
insert into #Cta_resultado select '435001007', '760701105', '560701102' , 'Complementarias' -- ok Comp. Cobertura Flujo Caja Pool Pasivos
insert into #Cta_resultado select '411501029', '760701111', '560701108' , 'Complementarias' -- ok Comp. Cobertura Valor Raz. Cart. Inversiones
insert into #Cta_resultado select '411501027', '760701111', '560701108' , 'Complementarias' -- ok Comp. Cobertura Valor Raz. Cart. Inversiones
-- insert into #Cta_resultado select '411501030', '760701109', '560701106' , 'Complementarias' -- Comp. Cobertura Flujo Caja Inflac. problemas en modelo .. pensar
insert into #Cta_resultado select '435001011', '760701109', '560701106' , 'Complementarias' -- ok Comp. Cobertura Flujo Caja Inflac.
insert into #Cta_resultado select '435001012', '760701118', '560701117' , 'Complementarias' -- ok Comp. Cobertura Flujo de Caja Lineas USD
insert into #Cta_resultado select '435001014', '760701121', '560701120' , 'Complementarias' -- ok Comp. Cobertura Flujo de Caja AFS
insert into #Cta_resultado select '435001008', '760701121', ''          , 'Complementarias' -- ok Comp. Cobertura Flujo de Caja Colombia


/* Ajuste solicitado Por JPFreire */
--- AJUSTE DE AVR
-- Pargua
-- Provisiones
-- Ajuste Patrimonio
CREATE TABLE #Temp_Ajuste_AVR_Operacion
 ( Modulo Varchar(10), Numero_operacion numeric(13), numeroComponente Numeric(8)
   , MontoCLP numeric(20,4)
   , EsSCMxCLP varchar(1)
   , Cta_Cartera varchar(100)
   , CtaUti varchar(100)
   , CtaPer varchar(100)
   , Concepto VarChar(20)
   , Fecha_Al Datetime
   , KeyCntId_sistema varchar(3)
   , Rut numeric(13)
   , Codigo numeric(5) )


if @AjustesProvisiones = 'SI'
Begin

	--  /* Para ver las diferencias **************************************************************
	-- Provisiones

    select Distinct
       Origen = case when Modulo = 'BacForward' then 'BFW'
                     when Modulo = 'BacSwap'    then 'PCS'
					 when Modulo = 'SAO'        then 'OPT'
                end
    , Contrato = case when KeyCntId_sistema = 'OPT' then SUBSTRING( rtrim( Contrato) , 1, len( rtrim(Contrato) ) - 1 )
	             else Contrato end
	, Vigente_CierreAnoAnt
	, Vigente_CierreAno
	, KeyCntId_sistema
	, Rut_Contraparte
	, DV_Rut_COntraparte
	, Tax_ID_Contraparte
	, Codigo_Pais_Contraparte
	, Rut_Cliente_Emp
	, codigo_Cliente_Emp	 
    into #DJ1829_Detalle
    from #ContratosDerivadosMes  where evento = 'Curse'

	 

     
     INSERT INTO #Temp_Ajuste_AVR_Operacion 
	    select Modulo = Case when Aju.Origen = 'BFW' then 'BacForward'
		                     when Aju.Origen = 'PCS' then 'BacSwap'
		                     when Aju.Origen = 'OPT' then 'SAO' 
							 else 'Error' end
			 , Numero_operacion  = Aju.Contrato -- Caso SAO no incluye el número de estructura al final
			 , numeroComponente = 1             -- Se asume el monto para el primer componente
			 , MontoCLP         = sum(Monto)
			 , EsSCMxCLP        = 'X'   -- Se Dajará de usar el campo
			 , Cta_Cartera      = Aju.Cuenta
			 , CtaUti = CtaResultad.Cta_Util
			 , CtaPer = CtaResultad.Cta_Perd
			 , Concepto = CtaResultad.Concepto
			 , Fecha_Al = @FechaCierreAnnoComercialAnt
			 , KeyCntId_sistema
			 , Rut      = Cheq.Rut_Cliente_Emp
			 , Codigo   = Cheq.Codigo_Cliente_Emp
	    from bacParamsuda.dbo.TBL_TRIBUTARIOS_AJUSTES  Aju   
	       left join #Cta_resultado CtaResultad on Aju.Cuenta = CtaResultad.Cta
		   -- Para evitar que entren op. vencidas al cierre del año anterior
		   right join #DJ1829_Detalle Cheq  -- select * from #DJ1829_Detalle where contrato = 2512
		      on Aju.Origen = Cheq.Origen and Aju.Contrato = Cheq.Contrato 

          where Aju.fecha = @FechaCierreAnnoComercialAnt
		   group by Aju.Origen
		          , Aju.Contrato
				  , Aju.Cuenta
				  , CtaResultad.Cta_Util
				  , CtaResultad.Cta_Perd
				  , CtaResultad.Concepto
				  , Cheq.KeyCntId_sistema
				  , Cheq.Rut_Cliente_Emp
				  , Cheq.Codigo_Cliente_Emp


        INSERT INTO #Temp_Ajuste_AVR_Operacion  -- select * from #Temp_Ajuste_AVR_Operacion
	    select Modulo = Case when Aju.Origen = 'BFW' then 'BacForward'
		                     when Aju.Origen = 'PCS' then 'BacSwap'
		                     when Aju.Origen = 'OPT' then 'SAO' 
							 else 'Error' end
			 , Numero_operacion  = Aju.Contrato -- Caso SAO no incluye el número de estructura al final, ningún tipo de contrato
			 , numeroComponente = 0
			 , MontoCLP         = sum(Monto)
			 , EsSCMxCLP        = 'X'   -- Se Dajará de usar el campo
			 , Cta_Cartera      = Aju.Cuenta
			 , CtaUti = CtaResultad.Cta_Util
			 , CtaPer = CtaResultad.Cta_Perd
			 , Concepto = CtaResultad.Concepto
			 , Fecha_Al = @FechaCierreAnnoComercial
			 , KeyCntId_sistema
			 , Rut      = Cheq.Rut_Cliente_Emp
			 , Codigo   = Cheq.Codigo_Cliente_Emp
	    from bacParamsuda.dbo.TBL_TRIBUTARIOS_AJUSTES  Aju   
	       left join #Cta_resultado CtaResultad on Aju.Cuenta = CtaResultad.Cta
           -- Para evitar que entren op. vencidas al cierre del año anterior
		   right join #DJ1829_Detalle Cheq   -- select * from #DJ1829_Detalle
		      on Aju.Origen = Cheq.Origen and Aju.Contrato = Cheq.Contrato 

          where Aju.fecha = @FechaRescateAVRExterno -- @FechaCierreAnnoComercial
		    and Cheq.Vigente_CierreAno <> 'N'
		   group by Aju.Origen
		          , Aju.Contrato
				  , Aju.Cuenta
				  , CtaResultad.Cta_Util
				  , CtaResultad.Cta_Perd
				  , CtaResultad.Concepto
				  , Cheq.KeyCntId_sistema
                  , Cheq.Rut_Cliente_Emp
				  , Cheq.Codigo_Cliente_Emp


	-- Solicitado por JPFreire
	--  ********************************************************************************************/
End


   -- Optimizacion: Crear Indice antes de usar tabla: #Temp_Ajuste_AVR_Operacion
CREATE INDEX  I#Temp_Ajuste_AVR_Operacion ON #Temp_Ajuste_AVR_Operacion
            ( Modulo, Numero_operacion, NumeroComponente )

    -- Limpiar antes de aplicar las provisiones
    update #ContratosDerivadosMes    set Valor_Justo_Al_Cierre	= 0 where Vigente_CierreAno = 'N'
    update #ContratosDerivadosMes    set Valor_Justo_Al_CierreAnoAnt = 0 where Vigente_CierreAnoAnt = 'N'

if @AjustesProvisiones = 'SI'
Begin
    -- Agregar Evento = 'Provisiones' y 'Pargua'	
	select Contrato                        = convert( numeric(10),  Case when car.KeyCntId_sistema <> 'OPT' then Numero_operacion else
	                                                                Numero_operacion * 10 + 1 end )  -- La provisión se informará siempre en el 
																	                                 -- primer componente
		 , Evento                          = convert( varchar(30) , Concepto )
		 , SubEvento                       = convert( varchar(30) , 'No Aplica' )
		 , FechaEvento                     = Fecha_Al 
		 -- Info solicitada por MOLEB:
		 -- Datos del cliente quedan para llenar 
		 -- Datos de contrato solo los que no requieren traducción
		 , Rut_Contraparte                 = convert( numeric(9), 0 )
		 , DV_Rut_COntraparte              = '0'
		 , Tax_ID_Contraparte              = space(15)  
		 , Codigo_Pais_Contraparte         = '??'
		 , Tipo_Relacion_con_Contraparte   = 99  
		 , Modalidad_Contratacion          = convert( numeric(2), 0 )                  
		 , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
		 , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
		 , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
		 , Numero_Contrato                 = convert( varchar(10), 0 )
		 , Fecha_Suscripcion_Contrato      = convert( datetime , '19000101' ) 
		 -- DJ1829 presenta de manera acumulada los contratos
		 -- esto significa que por ejemplo estamos cargando un anticipo 
		 -- parcial y luego la operación es anticipada total en otro
		 -- evento. En fin, este campo no se puede evaluar viendo 
		 -- aisladamente el evento.
		 , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
		 , Estado_Contrato                  = 0                                                -- DJ 1829
		 , Evento_Informado                = convert( numeric(1), 2 )                       -- DJ 1820 -- Modificacion    
		 , Tipo_Contrato                   = convert( numeric(2), 1 )     -- Forward                                                                              
		 , Nombre_Instrumento                     = space(20)
		 , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
		 , Posicion_Declarante                    = convert(numeric(1), 0 )
		 , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
		 , Codigo_Activo_Subyacente               = space(3)
		 , Otro_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
		 , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
		 , Codigo_Segundo_Activo_Subyacente       = space(3)
		 , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
		 , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
		 , Precio_Futuro_Contratado                       = convert(numeric(15,2), 0 ) 
		 , Moneda_Precio_Futuro_Contratado                = space(3)
		 , Unidad                                         = convert(numeric(2), 0 )   
		 , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round(  0  , 2) )  
		 , Segunda_Unidad                                 = convert(numeric(2), 0 )   
		 , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  
		 , Fecha_Vencimiento                              = convert( datetime, '19000101' )
  	     -- DJ1829
         , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
		 , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), 0 )
		 , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
		 , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
		 , Resultado_Ejercicio                            = convert( numeric(15), 0 )
		 , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
		 , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
		 , Comision_Pactada                               = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
		 , Prima_Total                                    = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Prima_Total           = convert( VarChar(15), '' )
		 , Inversion_Inicial                              = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
		 , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
		 , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
		 , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
		 , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
		 , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
		 , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 0 )        -- 1. Pago en dinero
		 , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
		-- DJ1829
		 -- Datos necesarios para rescatar información
		 , Rut_Cliente_Emp                 = convert( numeric(13), Rut )
		 , Codigo_Cliente_Emp              = convert( numeric(8), Codigo )
		 , Modalidad_Cumplimiento_Emp      = convert( varchar(1), 0 )            -- Modalidad de cumplimiento según la empresa   
		 , Posicion_Declarante_Emp         = convert( varchar(1), 0 )            -- Tipo de operacion según empresa contratante
		 , Producto_Emp                    = convert( varchar(5), 1 )            -- Producto según empresa contratante    
		 , Moneda_transada_Emp             = convert( numeric(5), 13 )           -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                 -- la moneda del instrumento.
		 , moneda_compensacion_Emp         = Convert( numeric(5), 0  )
		 , Fecha_Curse_Contrato_Emp        = '19000101' 
		 , Estado_Cliente                  = ''
		 , Subyacente_Papeles_de_RentaFija = convert( varchar(15), '' )
		 , Unidad_Precio_Subyacente_Emp    = convert( numeric(5), 0)
		 , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
		 , cacalcmpdol_Emp                 = convert( numeric(5), 0 )         -- Campo Moneda Compensacion para Seguros de Cambio
		 , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
		 , Moneda_Conversion_Emp           = convert( numeric(5), 0 )
		 , Modulo                          = Modulo

		   -- Para DJ1829 Datos necesario para rescatar información
		 , Precio_Fecha_Evento                   = convert( float, 0.0 )
		 , Precio_Fecha_Cierre_Ejercicio         = convert( float, 0.0 ) -- @FechaCierreAnnoComercial

		 -- Vcto      
		 , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )
		 , Moneda_Vcto_Compensado                = convert( numeric(15), 0 )

		 -- Anticipo
		 , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 )

		 , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )    
		 , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

		 -- Ejercer
		 , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
		 , Moneda_Ejercer                        = convert( numeric(5) , 0 )

		 -- Valor Justo
		 , Valor_Justo_Al_Evento                 = convert( numeric(15), 0 )
		 , Valor_Justo_Al_Cierre                 = convert( numeric(15), case when Fecha_al = @FechaCierreAnnoComercial then MontoCLP else 0 end )
		 , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), case when Fecha_al = @FechaCierreAnnoComercialAnt then MontoCLP else 0 end )

		 -- Opciones
		 , CVOpcion                              = convert( varchar(1), '' )
		 , CallPut                               = convert( varchar(4), '' )
		 , Tasa_Mercado_Al_Evento                = Convert( float, 0 ) 
		 , Tasa_Mercado_Al_Cierre                = Convert( float, 0 )
		 , Prima_Total_MO                        = convert( float, 0.0)
		 , Prima_Total_CLP                       = Convert( float, 0.0)
	 
		   -- Claves Contablidad
		 , KeyCntId_sistema = 'EXT'  -- Proviene de contabilidad Externa
		 , KeyCntProducto      = Convert( varchar(3), 1 )
		 , KeyCntTipOper       = convert( varchar(1), '' ) 
		 , KeyCntCallPut       = convert( varchar(4), '' )
		 , KeyCntMoneda2       = convert( varchar(5), '999' )  
		 , KeyCntMoneda1       = convert( varchar(5), '13' )  
		 , KeyCntModalidad     = convert( varchar(1), '' ) 
		 , KeyCntCarNormativa  = convert( varchar(1), '' )
         , KeyCntSubCarNormativa = convert( varchar(1), '' )        
		 , CntPagoEvento       = convert( numeric(15), 0 )
		 , CntCtaResultadoPos     = convert( varchar(100), ''  )
		 , CntCtaVRPos            = convert( varchar(100), CtaUti ) 
		 , CntCtaResultadoNeg     = convert( varchar(100), '' )
		 , CntCtaVRNeg            = convert( varchar(100), CtaPer )     
		 , CaNumEstructura        = 1   
         , VR_Al_1er_Dia_Ano      = 0
         , VR_AL_1er_Dia_Ano_Sig  = 0
         , Vigente_CierreAnoAnt   = case when Fecha_Al = @FechaCierreAnnoComercialAnt then 'S' else 'N' end
         , Vigente_CierreAno      = case when Fecha_Al = @FechaCierreAnnoComercial    then 'S' else 'N' end
         , CntCtaCarVRPos            = convert( varchar(100), Cta_Cartera )                                             
         , CntCtaCarVRNeg            = convert( varchar(100), Cta_Cartera )   
         ,  FolioEvento = 1000 * 0
         ,  CorrelativoGeneral = 0
         , Rut_Chileno = convert( numeric(13), 0 ) 
         , Vigente_Corte_Inicial = 'N'      
         , Monto_Util_PERD_CLP    = convert( float, 0 )  -- Para registrar los pagos por USD-CLP
         INTO #ContratosDerivadosMesAjuAVR -- Ajustes de AVR  
      from #Temp_Ajuste_AVR_Operacion Car  
	  
	  -- Actualizar Rut en el caso de haber sesiones
	  -- PENDIENTE: implementar varias seciones en el año
	  update #ContratosDerivadosMesAjuAVR
	  set
	       Rut_Cliente_Emp = DV.Rut_Cliente_Emp
		 , codigo_Cliente_Emp = DV.Codigo_Cliente_Emp
		 from #ContratosDerivadosMes DV  
		 where DV.evento = 'Cesion' 
		   and DV.Modulo = #ContratosDerivadosMesAjuAVR.Modulo 
		   and DV.Contrato = #ContratosDerivadosMesAjuAVR.Contrato 


	  -- Movimientos de Patrimonio
	  -- Movimientos contra otras cuentas de activo/Pasivo
	  -- PENDIENTE: Falta colocar el concepto de Sistema Contable
	  -- para no perder movimientos de Forward generados en SAO
      insert into #ContratosDerivadosMesAjuAVR -- select * from #ContratosDerivadosMesAjuAVR where evento = 'Complemento'
      select Contrato                        = convert( numeric(10),  Case when Pat.Origen <> 'OPT' then Contrato 
	                                           else Contrato * 10 + 1 end )
		 , Evento                          = convert( varchar(30) , 'Complemento' )
		 , SubEvento                       = convert( varchar(30) , 'No Aplica' )
		 , FechaEvento                     = Fecha 
		 -- Info solicitada por MOLEB:
		 -- Datos del cliente quedan para llenar 
		 -- Datos de contrato solo los que no requieren traducción
		 , Rut_Contraparte                 = convert( numeric(9), 0 )
		 , DV_Rut_COntraparte              = '0'
		 , Tax_ID_Contraparte              = space(15)  
		 , Codigo_Pais_Contraparte         = '??'
		 , Tipo_Relacion_con_Contraparte   = 99  
		 , Modalidad_Contratacion          = convert( numeric(2), 0 )                  
		 , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
		 , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
		 , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
		 , Numero_Contrato                 = convert( varchar(10), 0 )
		 , Fecha_Suscripcion_Contrato      = convert( datetime , '19000101' ) 
		 -- DJ1829 presenta de manera acumulada los contratos
		 -- esto significa que por ejemplo estamos cargando un anticipo 
		 -- parcial y luego la operación es anticipada total en otro
		 -- evento. En fin, este campo no se puede evaluar viendo 
		 -- aisladamente el evento.
		 , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
		 , Estado_Contrato                  = 0                                                -- DJ 1829
		 , Evento_Informado                = convert( numeric(1), 2 )                       -- DJ 1820 -- Modificacion    
		 , Tipo_Contrato                   = convert( numeric(2), 1 )     -- Forward                                                                              
		 , Nombre_Instrumento                     = space(20)
		 , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
		 , Posicion_Declarante                    = convert(numeric(1), 0 )
		 , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
		 , Codigo_Activo_Subyacente               = space(3)
		 , Otro_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
		 , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
		 , Codigo_Segundo_Activo_Subyacente       = space(3)
		 , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
		 , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
		 , Precio_Futuro_Contratado                       = convert(numeric(15,2), 0 ) 
		 , Moneda_Precio_Futuro_Contratado                = space(3)
		 , Unidad                                         = convert(numeric(2), 0 )   
		 , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round(  0  , 2) )  
		 , Segunda_Unidad                                 = convert(numeric(2), 0 )   
		 , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  
		 , Fecha_Vencimiento                              = convert( datetime, '19000101' )
  	     -- DJ1829
         , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
		 , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), 0 )
		 , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
		 , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
		 , Resultado_Ejercicio                            = convert( numeric(15), 0 )
		 , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
		 , Efecto_En_Patrimonio                           = convert( numeric(15), case when substring( Cuenta, 1, 5 ) = '43500' and Cuenta <> '435001008' then Pat.Ajuste else 0 end )
		 , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), case when substring( Cuenta, 1, 5 ) = '43500' and Cuenta <> '435001008' then 
		                                                                                       case when  Pat.Ajuste > 0 then   CtaResultad.Cta_Util 
																							                              else   CtaResultad.Cta_Perd end 
																				  else 0 end ) 
		 , Comision_Pactada                               = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
		 , Prima_Total                                    = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Prima_Total           = convert( VarChar(15), '' )
		 , Inversion_Inicial                              = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
		 , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), case when substring( Cuenta, 1, 5 ) = '41150' or Cuenta = '435001008' then -Pat.Ajuste else 0 end  ) 
		                                                      * (  case when Pat.Ajuste < 0 then 1 else 0 end )
		 , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), case when substring( Cuenta, 1, 5 ) = '41150' or Cuenta = '435001008' then CtaResultad.Cta_Perd else 0 end )
		                                                      * (  case when Pat.Ajuste < 0 then 1 else 0 end )
		 , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), convert( numeric(15), case when substring( Cuenta, 1, 5 ) = '41150' or Cuenta = '435001008'  then Pat.Ajuste else 0 end  ) ) 
		                                                      * (  case when Pat.Ajuste > 0 then 1 else 0 end ) 
		 , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), convert( numeric(15), case when substring( Cuenta, 1, 5 ) = '41150' or Cuenta = '435001008'  then CtaResultad.Cta_Util else 0 end ) )
		                                                      * (  case when Pat.Ajuste > 0 then 1 else 0 end ) 
		 , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
		 , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 0 )        -- 1. Pago en dinero
		 , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
		-- DJ1829
		 -- Datos necesarios para rescatar información
		 , Rut_Cliente_Emp                 = convert( numeric(13), 0 )
		 , Codigo_Cliente_Emp              = convert( numeric(8), 0 )
		 , Modalidad_Cumplimiento_Emp      = convert( varchar(1), 0 )            -- Modalidad de cumplimiento según la empresa   
		 , Posicion_Declarante_Emp         = convert( varchar(1), 0 )            -- Tipo de operacion según empresa contratante
		 , Producto_Emp                    = convert( varchar(5), 1 )            -- Producto según empresa contratante    
		 , Moneda_transada_Emp             = convert( numeric(5), 13 )           -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                 -- la moneda del instrumento.
		 , moneda_compensacion_Emp         = Convert( numeric(5), 0  )
		 , Fecha_Curse_Contrato_Emp        = '19000101' 
		 , Estado_Cliente                  = ''
		 , Subyacente_Papeles_de_RentaFija = convert( varchar(15), '' )
		 , Unidad_Precio_Subyacente_Emp    = convert( numeric(5), 0)
		 , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
		 , cacalcmpdol_Emp                 = convert( numeric(5), 0 )         -- Campo Moneda Compensacion para Seguros de Cambio
		 , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
		 , Moneda_Conversion_Emp           = convert( numeric(5), 0 )
		 , Modulo                          =  Case when Origen = 'BFW' then 'BacForward' 
		                                           when Origen = 'PCS' then 'BacSwap'
												   when Origen = 'OPT' then 'SAO' End 

		   -- Para DJ1829 Datos necesario para rescatar información
		 , Precio_Fecha_Evento                   = convert( float, 0.0 )
		 , Precio_Fecha_Cierre_Ejercicio         = convert( float, 0.0 ) -- @FechaCierreAnnoComercial

		 -- Vcto      
		 , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )
		 , Moneda_Vcto_Compensado                = convert( numeric(15), 0 )

		 -- Anticipo
		 , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 )

		 , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )    
		 , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

		 -- Ejercer
		 , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
		 , Moneda_Ejercer                        = convert( numeric(5) , 0 )

		 -- Valor Justo
		 , Valor_Justo_Al_Evento                 = convert( numeric(15), 0 )
		 , Valor_Justo_Al_Cierre                 = convert( numeric(15), 0 )
		 , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), 0 )

		 -- Opciones
		 , CVOpcion                              = convert( varchar(1), '' )
		 , CallPut                               = convert( varchar(4), '' )
		 , Tasa_Mercado_Al_Evento                = Convert( float, 0 ) 
		 , Tasa_Mercado_Al_Cierre                = Convert( float, 0 )
		 , Prima_Total_MO                        = convert( float, 0.0)
		 , Prima_Total_CLP                       = Convert( float, 0.0)
	 
		   -- Claves Contablidad
		 , KeyCntId_sistema = 'EXT'  -- Proviene de contabilidad Externa
		 , KeyCntProducto      = Convert( varchar(3), 1 )
		 , KeyCntTipOper       = convert( varchar(1), '' ) 
		 , KeyCntCallPut       = convert( varchar(4), '' )
		 , KeyCntMoneda2       = convert( varchar(5), '999' )  
		 , KeyCntMoneda1       = convert( varchar(5), '13' )  
		 , KeyCntModalidad     = convert( varchar(1), '' ) 
		 , KeyCntCarNormativa  = convert( varchar(1), '' )
         , KeyCntSubCarNormativa = convert( varchar(1), '' )        
		 , CntPagoEvento       = convert( numeric(15), 0 )
		 , CntCtaResultadoPos     = convert( varchar(9), '' )
		 , CntCtaVRPos            = convert( varchar(9), '' ) 
		 , CntCtaResultadoNeg     = convert( varchar(9), '' )
		 , CntCtaVRNeg            = convert( varchar(9), '' )
		 , CaNumEstructura        = 0   
         , VR_Al_1er_Dia_Ano      = 0
         , VR_AL_1er_Dia_Ano_Sig  = 0
         , Vigente_CierreAnoAnt   = case when Fecha = @FechaCierreAnnoComercialAnt then 'S' else 'N' end
         , Vigente_CierreAno      = case when Fecha = @FechaCierreAnnoComercial    then 'S' else 'N' end
         , CntCtaCarVRPos            = convert( varchar(9),  '' )                                             
         , CntCtaCarVRNeg            = convert( varchar(9),  case when substring( CtaResultad.Cta, 1, 5 ) = '41150' then CtaResultad.Cta else 0 end )   -- Solo hay cta de pasivo
         ,  FolioEvento = 1000 * 0
         ,  CorrelativoGeneral = 0
         , Rut_Chileno = convert( numeric(13), 0 ) 
         , Vigente_Corte_Inicial = 'N'      
         , Monto_Util_PERD_CLP    = convert( float, 0 )   
	    from BacParamSuda.dbo.TBL_PATRIMONIO Pat	     -- select * from BacParamSuda.dbo.TBL_PATRIMONIO
		  left join #Cta_resultado CtaResultad on Pat.Cuenta = CtaResultad.Cta  		  
		  where fecha >  @FechaCierreAnnoComercialAnt and  fecha <= @FechaCierreAnnoComercial 

end

if @AjustesAVRForwardAsiatico = 'SI'
Begin
   -- Corregir el AVR de los Forward Asiático
   -- Saldo al 28 de Dic 2012 en Cta 412801053
	update #ContratosDerivadosMes set Valor_Justo_Al_CierreAnoAnt = -6719412 where Contrato = 42736 and Modulo = 'BacForward'


   -- Corregir el AVR de los Forward Asiático
end

	-- Se aplican los pagos si existen para corregir 
    -- registro del sistema
	update #ContratosDerivadosMes
	   set #ContratosDerivadosMes.Monto_Pagado_CLP_al_vcto_compensado = isnull( ( select sum( Monto_CLP ) 
														 from #Pagos Pag where Pag.Id_sistema = #ContratosDerivadosMes.KeyCntId_Sistema 
																		   and Pag.Numero_operacion = #ContratosDerivadosMes.Contrato 
																		   and Pag.Fecha = #ContratosDerivadosMes.FechaEvento), Monto_Pagado_CLP_al_vcto_compensado )

	where  #ContratosDerivadosMes.Evento in ( 'Liq Hip',  'Liquidacion', 'Vcto. Natural' )


   -- Mx/CLP **************************************************************************************
   -- #PagosSegCambio
   -- Id_sistema Varchar(3), Numero_operacion numeric(10), Fecha Datetime , Monto_CLP numeric(20) )
   -- Drop Table #ContratosDerivadosMesSC 
   -- El case sobr el campo contrato se debe a una operacion Mx/Clp que fue anticipada
   -- pero su Usd/Clp asociado no. Se debe poner el Usd/Clp del Mx/Clp N° 562806
	select Contrato                        = convert( numeric(10), case when Car.Numero_Operacion = 562812 then 562806 else Car.Numero_Operacion end ) 
		 , Evento                          = convert( varchar(30) , 'Cuadratura' )
		 , SubEvento                       = convert( varchar(30) , 'Vcto. Nat.' )
		 , FechaEvento                     = Car.Fecha 
		 -- Info solicitada por MOLEB:
		 -- Datos del cliente quedan para llenar 
		 -- Datos de contrato solo los que no requieren traducción
		 , Rut_Contraparte                 = convert( numeric(9), 0 )
		 , DV_Rut_COntraparte              = '0'
		 , Tax_ID_Contraparte              = space(15)  
		 , Codigo_Pais_Contraparte         = '??'
		 , Tipo_Relacion_con_Contraparte   = 99  
		 , Modalidad_Contratacion          = convert( numeric(2), 0 )                  
		 , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
		 , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
		 , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
		 , Numero_Contrato                 = convert( varchar(10), 0 )
		 , Fecha_Suscripcion_Contrato      = convert( datetime , isnull( ( select min( mofecha ) from bacFwdSuda.dbo.Mfmoh where MoNroOpeMxClp =  Car.Numero_Operacion  ), 
		                                                           ( select min( mofecha ) from bacFwdSuda.dbo.Mfmoh where MoNUmoper = Car.Numero_Operacion )  )		
		                                                         )  
		 -- DJ1829 presenta de manera acumulada los contratos
		 -- esto significa que por ejemplo estamos cargando un anticipo 
		 -- parcial y luego la operación es anticipada total en otro
		 -- evento. En fin, este campo no se puede evaluar viendo 
		 -- aisladamente el evento.
		 , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
		 , Estado_Contrato                  = 0                                                -- DJ 1829
		 , Evento_Informado                = convert( numeric(1), 2 )                       -- DJ 1820 -- Modificacion    
		 , Tipo_Contrato                   = convert( numeric(2), 1 )     -- Forward                                                                              
		 , Nombre_Instrumento                     = space(20)
		 , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
		 , Posicion_Declarante                    = convert(numeric(1), 0 )
		 , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
		 , Codigo_Activo_Subyacente               = space(3)
		 , Otro_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
		 , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
		 , Codigo_Segundo_Activo_Subyacente       = space(3)
		 , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
		 , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
		 , Precio_Futuro_Contratado                       = convert(numeric(15,2), 0 ) 
		 , Moneda_Precio_Futuro_Contratado                = space(3)
		 , Unidad                                         = convert(numeric(2), 0 )   
		 , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round(  0  , 2) )  
		 , Segunda_Unidad                                 = convert(numeric(2), 0 )   
		 , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  
		 , Fecha_Vencimiento                              = convert( datetime, car.fecha )
  	     -- DJ1829
         , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
		 , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), 0 )
		 , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
		 , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
		 , Resultado_Ejercicio                            = convert( numeric(15), 0 )
		 , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
		 , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
		 , Comision_Pactada                               = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
		 , Prima_Total                                    = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Prima_Total           = convert( VarChar(15), '' )
		 , Inversion_Inicial                              = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
		 , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
		 , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
		 , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
		 , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
		 , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
		 , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 0 )        -- 1. Pago en dinero
		 , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
		-- DJ1829
		 -- Datos necesarios para rescatar información
		 , Rut_Cliente_Emp                 = convert( numeric(13), CarRes.CaCodigo )
		 , Codigo_Cliente_Emp              = convert( numeric(8), CarRes.CaCodCli )
		 , Modalidad_Cumplimiento_Emp      = convert( varchar(1), 0 )            -- Modalidad de cumplimiento según la empresa   
		 , Posicion_Declarante_Emp         = convert( varchar(1), 0 )            -- Tipo de operacion según empresa contratante
		 , Producto_Emp                    = convert( varchar(5), 1 )            -- Producto según empresa contratante    
		 , Moneda_transada_Emp             = convert( numeric(5), 13 )           -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                 -- la moneda del instrumento.
		 , moneda_compensacion_Emp         = Convert( numeric(5), 0  )
		 , Fecha_Curse_Contrato_Emp        = '19000101' 
		 , Estado_Cliente                  = 'VER Operacion MX/USD N° ' + convert( Varchar(10), Car.Numero_Operacion ) 
		 , Subyacente_Papeles_de_RentaFija = convert( varchar(15), '' )
		 , Unidad_Precio_Subyacente_Emp    = convert( numeric(5), 0)
		 , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
		 , cacalcmpdol_Emp                 = convert( numeric(5), 0 )         -- Campo Moneda Compensacion para Seguros de Cambio
		 , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
		 , Moneda_Conversion_Emp           = convert( numeric(5), 0 )
		 , Modulo                          = 'BacForward'

		   -- Para DJ1829 Datos necesario para rescatar información
		 , Precio_Fecha_Evento                   = convert( float, 0.0 )
		 , Precio_Fecha_Cierre_Ejercicio         = convert( float, 0.0 ) -- @FechaCierreAnnoComercial

		 -- Vcto      
		 , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), Monto_CLP )
		 , Moneda_Vcto_Compensado                = convert( numeric(15), 0 )

		 -- Anticipo
		 , Monto_Pagado_MO_Al_Anticipar          = convert( numeric(15), 0 )

		 , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(15), 0 )    
		 , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

		 -- Ejercer
		 , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
		 , Moneda_Ejercer                        = convert( numeric(5) , 0 )

		 -- Valor Justo
		 , Valor_Justo_Al_Evento                 = convert( numeric(15), 0 )
		 , Valor_Justo_Al_Cierre                 = convert( numeric(15), 0 )
		 , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), 0 )

		 -- Opciones
		 , CVOpcion                              = convert( varchar(1), '' )
		 , CallPut                               = convert( varchar(4), '' )
		 , Tasa_Mercado_Al_Evento                = Convert( float, 0 ) 
		 , Tasa_Mercado_Al_Cierre                = Convert( float, 0 )
		 , Prima_Total_MO                        = convert( float, 0.0)
		 , Prima_Total_CLP                       = Convert( float, 0.0)
	 
		   -- Claves Contablidad
		 , KeyCntId_sistema = 'BFW'
		 , KeyCntProducto      = Convert( varchar(3), 1 )
		 , KeyCntTipOper       = convert( varchar(1), '' ) 
		 , KeyCntCallPut       = convert( varchar(4), '' )
		 , KeyCntMoneda2       = convert( varchar(5), '999' )  
		 , KeyCntMoneda1       = convert( varchar(5), '13' )  
		 , KeyCntModalidad     = convert( varchar(1), '' ) 
		 , KeyCntCarNormativa  = convert( varchar(1), '' )
         , KeyCntSubCarNormativa = convert( varchar(1), '' )        
		 , CntPagoEvento       = convert( numeric(15), 0 )
		 , CntCtaResultadoPos     = convert( varchar(9), 760701039 )
		 , CntCtaVRPos            = convert( varchar(9), 760701017 )
		 , CntCtaResultadoNeg     = convert( varchar(9), 560701039 )
		 , CntCtaVRNeg            = convert( varchar(9), 560701017 )     
		 , CaNumEstructura        = 0   
         , VR_Al_1er_Dia_Ano      = 0
         , VR_AL_1er_Dia_Ano_Sig  = 0
         , Vigente_CierreAnoAnt   = 'X'
         , Vigente_CierreAno      = 'X'
         , CntCtaCarVRPos            = convert( varchar(9), '' )                                             
         , CntCtaCarVRNeg            = convert( varchar(9), '' )   
         ,  FolioEvento = 1000 * 0
         ,  CorrelativoGeneral = 0
         , Rut_Chileno = convert( numeric(13), 0 ) 
         , Vigente_Corte_Inicial = 'N'      
         , Monto_Util_PERD_CLP    = convert( float, 0 )    
         INTO #ContratosDerivadosMesSC  
      from #PagosSegCambio Car
	     left Join BacFwdSuda.dbo.MFCARes CarRes on Car.Fecha = CarRes.CaFechaProceso and (case when Car.Numero_Operacion = 562812 then 562806 else Car.Numero_Operacion end) = CarRes.CaNumOper
 
 
      -- Agregar Anticipos
      Insert into #ContratosDerivadosMesSC
	  select Contrato                        = convert( numeric(10), Car.Contrato ) 
		 , Evento                          = convert( varchar(30) , 'Cuadratura' )
		 , SubEvento                       = convert( varchar(30) , 'Anticipo' )
		 , FechaEvento                     = Car.FechaEvento 
		 -- Info solicitada por MOLEB:
		 -- Datos del cliente quedan para llenar 
		 -- Datos de contrato solo los que no requieren traducción
		 , Rut_Contraparte                 = convert( numeric(9), 0 )
		 , DV_Rut_COntraparte              = '0'
		 , Tax_ID_Contraparte              = space(15)  
		 , Codigo_Pais_Contraparte         = '??'
		 , Tipo_Relacion_con_Contraparte   = 99  
		 , Modalidad_Contratacion          = convert( numeric(2), 0 )                  
		 , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
		 , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
		 , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
		 , Numero_Contrato                 = convert( varchar(10), 0 )
		 , Fecha_Suscripcion_Contrato      = convert( datetime , car.Fecha_Suscripcion_Contrato )		                                                         
		 -- DJ1829 presenta de manera acumulada los contratos
		 -- esto significa que por ejemplo estamos cargando un anticipo 
		 -- parcial y luego la operación es anticipada total en otro
		 -- evento. En fin, este campo no se puede evaluar viendo 
		 -- aisladamente el evento.
		 , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
		 , Estado_Contrato                  = 0                                                -- DJ 1829
		 , Evento_Informado                = convert( numeric(1), 2 )                       -- DJ 1820 -- Modificacion    
		 , Tipo_Contrato                   = convert( numeric(2), 1 )     -- Forward                                                                              
		 , Nombre_Instrumento                     = space(20)
		 , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
		 , Posicion_Declarante                    = convert(numeric(1), 0 )
		 , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
		 , Codigo_Activo_Subyacente               = space(3)
		 , Otro_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
		 , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
		 , Codigo_Segundo_Activo_Subyacente       = space(3)
		 , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
		 , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
		 , Precio_Futuro_Contratado                       = convert(numeric(15,2), 0 ) 
		 , Moneda_Precio_Futuro_Contratado                = space(3)
		 , Unidad                                         = convert(numeric(2), 0 )   
		 , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round(  0  , 2) )  
		 , Segunda_Unidad                                 = convert(numeric(2), 0 )   
		 , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  
		 , Fecha_Vencimiento                              = convert( datetime, car.fechaEvento )
  	     -- DJ1829
         , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
		 , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), 0 )
		 , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
		 , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
		 , Resultado_Ejercicio                            = convert( numeric(15), 0 )
		 , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
		 , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
		 , Comision_Pactada                               = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
		 , Prima_Total                                    = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Prima_Total           = convert( VarChar(15), '' )
		 , Inversion_Inicial                              = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
		 , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
		 , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
		 , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
		 , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
		 , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
		 , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 0 )        -- 1. Pago en dinero
		 , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
		-- DJ1829
		 -- Datos necesarios para rescatar información
		 , Rut_Cliente_Emp                 = convert( numeric(13), Rut_Cliente_Emp )
		 , Codigo_Cliente_Emp              = convert( numeric(8), Codigo_Cliente_Emp )
		 , Modalidad_Cumplimiento_Emp      = convert( varchar(1), 0 )            -- Modalidad de cumplimiento según la empresa   
		 , Posicion_Declarante_Emp         = convert( varchar(1), 0 )            -- Tipo de operacion según empresa contratante
		 , Producto_Emp                    = convert( varchar(5), 1 )            -- Producto según empresa contratante    
		 , Moneda_transada_Emp             = convert( numeric(5), 13 )           -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                 -- la moneda del instrumento.
		 , moneda_compensacion_Emp         = Convert( numeric(5), 0  )
		 , Fecha_Curse_Contrato_Emp        = '19000101' 
		 , Estado_Cliente                  = 'VER Operacion MX/USD N° ' + convert( Varchar(10), Car.Contrato ) 
		 , Subyacente_Papeles_de_RentaFija = convert( varchar(15), '' )
		 , Unidad_Precio_Subyacente_Emp    = convert( numeric(5), 0)
		 , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
		 , cacalcmpdol_Emp                 = convert( numeric(5), 0 )         -- Campo Moneda Compensacion para Seguros de Cambio
		 , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
		 , Moneda_Conversion_Emp           = convert( numeric(5), 0 )
		 , Modulo                          = 'BacForward'

		   -- Para DJ1829 Datos necesario para rescatar información
		 , Precio_Fecha_Evento                   = convert( float, 0.0 )
		 , Precio_Fecha_Cierre_Ejercicio         = convert( float, 0.0 ) -- @FechaCierreAnnoComercial

		 -- Vcto      
		 , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )
		 , Moneda_Vcto_Compensado                = convert( numeric(15), 0 )

		 -- Anticipo
		 , Monto_Pagado_MO_Al_Anticipar          = 0.0

		 , Monto_Pagado_CLP_Al_Anticipar         = convert( numeric(20), ROUND( Anticipo.caantmtomdacomp *
                                                                                             isnull( ( SELECT vmvalor
                                                                                                         FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) 
                                                                                                         WHERE vmcodigo = CASE WHEN Anticipo.moneda_compensacion = 13 THEN 994 ELSE Anticipo.moneda_compensacion END
                                                                                                               AND vmfecha  = Anticipo.cafecvcto 
                                                                                                       )  
                                                                                                      , 1.0
                                                                                                      ) 
                                                                                                , 0 )
                                                            )  + case when  Car.Contrato = 562812 then 1865588 else 0 end  -- Pago real por operacion Mx/Clp fue de 13,024,303                                         
                                                   
		 , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

		 -- Ejercer
		 , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
		 , Moneda_Ejercer                        = convert( numeric(5) , 0 )

		 -- Valor Justo
		 , Valor_Justo_Al_Evento                 = convert( numeric(15), 0 )
		 , Valor_Justo_Al_Cierre                 = convert( numeric(15), 0 ) /**/
		 , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), 0 ) /**/

		 -- Opciones
		 , CVOpcion                              = convert( varchar(1), '' )
		 , CallPut                               = convert( varchar(4), '' )
		 , Tasa_Mercado_Al_Evento                = Convert( float, 0 ) 
		 , Tasa_Mercado_Al_Cierre                = Convert( float, 0 )
		 , Prima_Total_MO                        = convert( float, 0.0)
		 , Prima_Total_CLP                       = Convert( float, 0.0)
	 
		   -- Claves Contablidad
		 , KeyCntId_sistema = 'BFW'
		 , KeyCntProducto      = Convert( varchar(3), 1 )
		 , KeyCntTipOper       = convert( varchar(1), '' ) 
		 , KeyCntCallPut       = convert( varchar(4), '' )
		 , KeyCntMoneda2       = convert( varchar(5), '999' )  
		 , KeyCntMoneda1       = convert( varchar(5), '13' )  
		 , KeyCntModalidad     = convert( varchar(1), '' ) 
		 , KeyCntCarNormativa  = convert( varchar(1), '' )
         , KeyCntSubCarNormativa = convert( varchar(1), '' ) 
         , CntPagoEvento       = convert( numeric(15), 0 )
		 , CntCtaResultadoPos     = convert( varchar(9), 760701039 )
		 , CntCtaVRPos            = convert( varchar(9), 760701017 )
		 , CntCtaResultadoNeg     = convert( varchar(9), 560701039 )
		 , CntCtaVRNeg            = convert( varchar(9), 560701017 )     
		 , CaNumEstructura        = 0   
         , VR_Al_1er_Dia_Ano      = 0
         , VR_AL_1er_Dia_Ano_Sig  = 0
         , Vigente_CierreAnoAnt   = 'X' 
         , Vigente_CierreAno      = 'X'  
         , CntCtaCarVRPos            = convert( varchar(9), '' )                                             
         , CntCtaCarVRNeg            = convert( varchar(9), '' )                                           
         ,  FolioEvento = 1000 * 0
         ,  CorrelativoGeneral = 0
         , Rut_Chileno = convert( numeric(13), 0 ) 
         , Vigente_Corte_Inicial = 'N'      
         , Monto_Util_PERD_CLP    = convert( numeric(15), 0 )
      from   #ContratosDerivadosMes   Car
          LEFT JOIN  BacFwdSuda.dbo.mfcaRes   Anticipo on  Anticipo.CaFechaProceso   = Car.fechaEvento
		                                               -- 562812 Mx/Clp fue anticipado pero su Usd/Clp no fue anticipado
													   -- se anticipo el Usd/Clp 562806
                                                       and Anticipo.var_moneda2  = case when Car.Contrato = 562812 then 562806 else Car.Contrato end 
                                                       and Anticipo.CaCodPos1 = 1
                                                       and Anticipo.CaAntici = 'A'          
      where Car.Modulo = 'BacForward' 
        and Car.Producto_Emp = 12 -- Pagos de MX/CLP generados por USD/CLP asociado
        and Car.evento = 'Anticipo'                    


      -- Agregar Montos de Valor Razonable 
      -- al inicio y fin del periodo
      Insert into #ContratosDerivadosMesSC  
	  select distinct 
           Contrato                        = convert( numeric(10), ArbMxUSD.Contrato ) 
		 , Evento                          = convert( varchar(30) , 'Cuadratura' )
		 , SubEvento                       = convert( varchar(30) , 'Valor Razonable' )
		 , FechaEvento                     = ArbMxUSD.Fecha_Suscripcion_Contrato 
		 -- Info solicitada por MOLEB:
		 -- Datos del cliente quedan para llenar 
		 -- Datos de contrato solo los que no requieren traducción
		 , Rut_Contraparte                 = convert( numeric(9), 0 )
		 , DV_Rut_COntraparte              = '0'
		 , Tax_ID_Contraparte              = space(15)  
		 , Codigo_Pais_Contraparte         = '??'
		 , Tipo_Relacion_con_Contraparte   = 99  
		 , Modalidad_Contratacion          = convert( numeric(2), 0 )                  
		 , Tipo_Acuerdo_Marco              = convert( numeric(1), 0 )             
		 , Numero_Acuerdo_Marco            = convert( varchar(200), 0 )
		 , Fecha_Suscripcion_Acuerdo_Marco = convert( datetime, '19000101' )
		 , Numero_Contrato                 = convert( varchar(10), 0 )
		 , Fecha_Suscripcion_Contrato      = ArbMxUSD.Fecha_Suscripcion_Contrato 
		 -- DJ1829 presenta de manera acumulada los contratos
		 -- esto significa que por ejemplo estamos cargando un anticipo 
		 -- parcial y luego la operación es anticipada total en otro
		 -- evento. En fin, este campo no se puede evaluar viendo 
		 -- aisladamente el evento.
		 , Contrato_Vencido_En_El_Ejercicio = 0                                                -- DJ 1829                       
		 , Estado_Contrato                  = 0                                                -- DJ 1829
		 , Evento_Informado                = convert( numeric(1), 2 )                       -- DJ 1820 -- Modificado    
		 , Tipo_Contrato                   = convert( numeric(2), 1 )     -- Forward                                                                              
		 , Nombre_Instrumento                     = space(20)
		 , Modalidad_Cumplimiento                 = convert(numeric(1), 0 )
		 , Posicion_Declarante                    = convert(numeric(1), 0 )
		 , Tipo_Activo_Subyacente                 = convert(numeric(1), 0 )                                                            
		 , Codigo_Activo_Subyacente               = space(3)
		 , Otro_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Activo_Subyacente   = convert( numeric(7,4), 0 )
		 , Tipo_Segundo_Activo_Subyacente         = convert(numeric(1), 0 )
		 , Codigo_Segundo_Activo_Subyacente       = space(3)
		 , Otro_Segundo_Activo_Subyacente_Especificacion  = space(15)
		 , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente   = convert( numeric(7,4), 0 )     
		 , Codigo_Precio_Futuro_Contratado                = convert(numeric(1), 0 )   
		 , Precio_Futuro_Contratado                       = convert(numeric(15,2), 0 ) 
		 , Moneda_Precio_Futuro_Contratado                = space(3)
		 , Unidad                                         = convert(numeric(2), 0 )   
		 , Monto_Cantidad_Contratado_o_Nocional           = convert(numeric(15,2), round(  0  , 2) )  
		 , Segunda_Unidad                                 = convert(numeric(2), 0 )   
		 , Segundo_Monto_Nocional                         = convert(numeric(15,2), 0 )  
		 , Fecha_Vencimiento                              = convert( datetime, ArbMxUSD.Fecha_Vencimiento )
  	     -- DJ1829
         , Fecha_Liquidacion_Ejercicio_de_Opcion          = convert( datetime, '19000101' )            
		 , Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  = convert( numeric(1), 0 )
		 , Precio_Mercado_Al_CIerre_o_Liquidacion         = convert( float, 0 )
		 , Valor_Justo_Contrato                           = convert( numeric(15), 0 )
		 , Resultado_Ejercicio                            = convert( numeric(15), 0 )
		 , Cuenta_Contable_Resultado_Ejercicio            = convert( Varchar(15), '' )
		 , Efecto_En_Patrimonio                           = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Patrimonio            = convert( Varchar(15), '' )
		 , Comision_Pactada                               = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Comision_Pactada      = convert( Varchar(15), '' )
		 , Prima_Total                                    = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Prima_Total           = convert( VarChar(15), '' )
		 , Inversion_Inicial                              = convert( numeric(15), 0 )
		 , Cuenta_Contable_Registro_Inversion_Inicial     = convert( numeric(15), 0 )
		 , Otros_Gastos_Asociados_Al_Contrato             = convert( numeric(15), 0 )
		 , Cuenta_Contable_Otros_Gastos                   = convert( numeric(15), 0 )
		 , Otros_Ingresos_Asociados_Al_Contrato           = convert( numeric(15), 0 )
		 , Cuenta_Contable_Otros_Ingresos                 = convert( numeric(15), 0 )
		 , Montos_Pagos_Al_Exterior_Efectuados            = convert( numeric(15), 0 )
		 , Modalidad_Pago_Al_Exterior_Efectuados          = convert( numeric(1), 0 )        -- 1. Pago en dinero
		 , Saldo_Garantias_Al_Cierre                      = convert( numeric(15), 0 )
		-- DJ1829
		 -- Datos necesarios para rescatar información
		 , Rut_Cliente_Emp                 = convert( numeric(13), Rut_Cliente_Emp )
		 , Codigo_Cliente_Emp              = convert( numeric(8), Codigo_Cliente_Emp )
		 , Modalidad_Cumplimiento_Emp      = convert( varchar(1), 0 )            -- Modalidad de cumplimiento según la empresa   
		 , Posicion_Declarante_Emp         = convert( varchar(1), 0 )            -- Tipo de operacion según empresa contratante
		 , Producto_Emp                    = convert( varchar(5), 1 )            -- Producto según empresa contratante    
		 , Moneda_transada_Emp             = convert( numeric(5), 13 )           -- Moneda transada según empresa contrante, para BFT corresponde a
                                                                                 -- la moneda del instrumento.
		 , moneda_compensacion_Emp         = Convert( numeric(5), 0  )
		 , Fecha_Curse_Contrato_Emp        = '19000101' 
		 , Estado_Cliente                  = 'VER Operacion MX/USD N° ' + convert( Varchar(10), ArbMxUSD.Contrato ) 
		 , Subyacente_Papeles_de_RentaFija = convert( varchar(15), '' )
		 , Unidad_Precio_Subyacente_Emp    = convert( numeric(5), 0)
		 , Pais_Recidencia_Contraparte_Emp = convert( numeric(5), 0 )
		 , cacalcmpdol_Emp                 = convert( numeric(5), 0 )         -- Campo Moneda Compensacion para Seguros de Cambio
		 , Moneda_Multiplica_Divide_Emp    = Convert( varchar(1), ' ' )
		 , Moneda_Conversion_Emp           = convert( numeric(5), 0 )
		 , Modulo                          = 'BacForward'

		   -- Para DJ1829 Datos necesario para rescatar información
		 , Precio_Fecha_Evento                   = convert( float, 0.0 )
		 , Precio_Fecha_Cierre_Ejercicio         = convert( float, 0.0 ) -- @FechaCierreAnnoComercial

		 -- Vcto      
		 , Monto_Pagado_MO_Al_Vcto_Compensado    = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Vcto_Compensado   = convert( numeric(15), 0 )
		 , Moneda_Vcto_Compensado                = convert( numeric(15), 0 )

		 -- Anticipo
		 , Monto_Pagado_MO_Al_Anticipar          = 0.0

		 , Monto_Pagado_CLP_Al_Anticipar         = 0.0
                                                   
		 , Moneda_Anticipar                      = convert( numeric(5) , 0 ) 

		 -- Ejercer
		 , Monto_Pagado_MO_Al_Ejercer            = convert( numeric(15), 0 )
		 , Monto_Pagado_CLP_Al_Ejercer           = convert( numeric(15), 0 )
		 , Moneda_Ejercer                        = convert( numeric(5) , 0 )

		 -- Valor Justo
		 , Valor_Justo_Al_Evento                 = convert( numeric(15), 0 )
		 , Valor_Justo_Al_Cierre                 = convert( numeric(15), 0 )  /**/
		 , Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), 0 )  /**/

		 -- Opciones
		 , CVOpcion                              = convert( varchar(1), '' )
		 , CallPut                               = convert( varchar(4), '' )
		 , Tasa_Mercado_Al_Evento                = Convert( float, 0 ) 
		 , Tasa_Mercado_Al_Cierre                = Convert( float, 0 )
		 , Prima_Total_MO                        = convert( float, 0.0)
		 , Prima_Total_CLP                       = Convert( float, 0.0)
	 
		   -- Claves Contablidad
		 , KeyCntId_sistema = 'BFW'
		 , KeyCntProducto      = Convert( varchar(3), 1 )
		 , KeyCntTipOper       = convert( varchar(1), '' ) 
		 , KeyCntCallPut       = convert( varchar(4), '' )
		 , KeyCntMoneda2       = convert( varchar(5), '999' )  
		 , KeyCntMoneda1       = convert( varchar(5), '13' )  
		 , KeyCntModalidad     = convert( varchar(1), '' ) 
		 , KeyCntCarNormativa  = convert( varchar(1), '' )
         , KeyCntSubCarNormativa = convert( varchar(1), '' ) 
		 , CntPagoEvento       = convert( numeric(15), 0 )
		 , CntCtaResultadoPos     = convert( varchar(9), 760701039 )
		 , CntCtaVRPos            = convert( varchar(9), 760701017 )
		 , CntCtaResultadoNeg     = convert( varchar(9), 560701039 )
		 , CntCtaVRNeg            = convert( varchar(9), 560701017 )     
		 , CaNumEstructura        = 0   
         , VR_Al_1er_Dia_Ano      = 0
         , VR_AL_1er_Dia_Ano_Sig  = 0
         , Vigente_CierreAnoAnt   = 'X'
         , Vigente_CierreAno      = 'X'  
         , CntCtaCarVRPos            = convert( varchar(9), '212801017' )                                             
         , CntCtaCarVRNeg            = convert( varchar(9), '412801017' )                                             
         ,  FolioEvento = 1000 * 0
         ,  CorrelativoGeneral = 0
         , Rut_Chileno = convert( numeric(13), 0 ) 
         , Vigente_Corte_Inicial = 'N'      
         , Monto_Util_PERD_CLP    = convert( numeric(15), 0 )
      from   #ContratosDerivadosMes   ArbMxUSD
      where ArbMxUSD.Modulo = 'BacForward' and ArbMxUSD.Producto_Emp = 12 -- VR de MX/CLP generados por USD/CLP asociado
            and ArbMxUSD.evento = 'Curse' 

      -- Cargar el Valor Razonable igual
      update #ContratosDerivadosMesSC
          set   #ContratosDerivadosMesSC.Vigente_CierreAnoAnt = ArbMxUSD.Vigente_CierreAnoAnt
              , #ContratosDerivadosMesSC.Vigente_CierreAno    = ArbMxUSD.Vigente_CierreAno
              , #ContratosDerivadosMesSC.Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( DiaCierreAnno.fRes_Obtenido, 0 ) )
              , #ContratosDerivadosMesSC.Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( DiaCierreAnnoAnt.fRes_Obtenido, 0 ) )
        from #ContratosDerivadosMes ArbMxUSD
          LEFT JOIN  BacFwdSuda.dbo.MFCARES DiaCierreAnno on DiaCierreAnno.CaFechaProceso = @FechaCierreAnnoComercial
                                                         and DiaCierreAnno.CaCodPos1      = 1
                                                         and DiaCierreAnno.var_moneda2    = ArbMxUSD.Contrato
          LEFT JOIN  BacFwdSuda.dbo.MFCARES DiaCierreAnnoAnt on DiaCierreAnnoAnt.CaFechaProceso = @FechaCierreAnnoComercialAnt
                                                         and DiaCierreAnnoAnt.CaCodPos1      = 1
                                                         and DiaCierreAnnoAnt.var_moneda2    = ArbMxUSD.Contrato

           where  ArbMxUSD.Modulo = 'BacForward'
              and ArbMxUSD.Producto_Emp = 12               
              and ArbMxUSD.Contrato = #ContratosDerivadosMesSC.Contrato



/************** Actualizar solamente el contrato titular 550.001  */
/************** Operacion 550001 **********************************
               El titular es 550001 y su campo var_Moneda2 no apunta a sí mismo apunta a 550037
			   El seguro de cambio tiene el numero 550038 y apunta a 550037  como titular
			   
*/

    -- Solo debe quedar el VR de las provisiones    
    update #ContratosDerivadosMesSC  set Valor_Justo_Al_Cierre	= 0 where Vigente_CierreAno = 'N'
    update #ContratosDerivadosMesSC  set Valor_Justo_Al_CierreAnoAnt = 0 where Vigente_CierreAnoAnt = 'N'

      update #ContratosDerivadosMesSC
          set   #ContratosDerivadosMesSC.Vigente_CierreAnoAnt = ArbMxUSD.Vigente_CierreAnoAnt
              , #ContratosDerivadosMesSC.Vigente_CierreAno    = ArbMxUSD.Vigente_CierreAno
              , #ContratosDerivadosMesSC.Valor_Justo_Al_Cierre                 = convert( numeric(15), isnull( DiaCierreAnno.fRes_Obtenido, 0 ) )
              , #ContratosDerivadosMesSC.Valor_Justo_Al_CierreAnoAnt           = convert( numeric(15), isnull( DiaCierreAnnoAnt.fRes_Obtenido, 0 ) )
			  , #ContratosDerivadosMesSC.Fecha_Suscripcion_Contrato            = convert( datetime, '20120522' )
        from #ContratosDerivadosMes ArbMxUSD
          LEFT JOIN  BacFwdSuda.dbo.MFCARES DiaCierreAnno on DiaCierreAnno.CaFechaProceso = @FechaCierreAnnoComercial
                                                         and DiaCierreAnno.CaCodPos1      = 1
                                                         and DiaCierreAnno.CaNumoper     = 550038                                                       
          LEFT JOIN  BacFwdSuda.dbo.MFCARES DiaCierreAnnoAnt on DiaCierreAnnoAnt.CaFechaProceso = @FechaCierreAnnoComercialAnt
                                                         and DiaCierreAnnoAnt.CaCodPos1  = 1
                                                         and DiaCierreAnnoAnt.CaNumoper  = 550038
                                                         

           where  #ContratosDerivadosMesSC.Contrato = 550001 
              and ArbMxUSD.Modulo = 'BacForward'
              and ArbMxUSD.Producto_Emp = 12                             
              and ArbMxUSD.Contrato = #ContratosDerivadosMesSC.Contrato

----if @AjustesProvisiones = 'SI'
----Begin
----      update #ContratosDerivadosMesSC
----      set Valor_Justo_Al_Cierre = Valor_Justo_Al_Cierre - MontoCLP 
----      from #Temp_Ajuste_AVR_Operacion Ajustes where Ajustes.Id_Sistema =  #ContratosDerivadosMesSC.KeyCntId_sistema
----                                                and Ajustes.Numero_operacion = #ContratosDerivadosMesSC.Contrato
----                                                and Ajustes.numeroComponente = #ContratosDerivadosMesSC.CaNumEstructura
----                                                and Ajustes.EsSCMxCLP = 'S'
----End
----      update #ContratosDerivadosMesSC  set Valor_Justo_Al_Cierre	= 0 where Vigente_CierreAno = 'N'
----
----      update #ContratosDerivadosMesSC  set Valor_Justo_Al_CierreAnoAnt = 0 where Vigente_CierreAnoAnt = 'N'
-- select sum(MontoCLP) from #Temp_Ajuste_AVR_Operacion  where EsSCMxCLP = 'S'

      -- REDIRECCIONAR CUENTAS PATA USD/CLP DE MX/CLP
      -- select * from #ContratosDerivadosMesSC    order by   KeyCntId_sistema,  Contrato,  CaNumEstructura
      -- 2013
      update #ContratosDerivadosMesSC Set CntCtaResultadoPos = '760701035' , CntCtaResultadoNeg = '560701035' 
        where Contrato in  ( 557832 ) 
 
      update #ContratosDerivadosMesSC Set CntCtaResultadoPos = '760701088' , CntCtaResultadoNeg = '560701086' 
        where Contrato in  ( 556951, 556953,556956 ) 
      
      update #ContratosDerivadosMesSC Set CntCtaResultadoPos = '760701035' , CntCtaResultadoNeg = '560701035' 
        where Contrato in  ( 561661 ) 

      update #ContratosDerivadosMesSC Set CntCtaResultadoPos = '760701088' , CntCtaResultadoNeg = '560701086' 
        where Contrato in (558701, 558863, 558924, 560121)

     update #ContratosDerivadosMesSC Set CntCtaResultadoPos = '760701088' , CntCtaResultadoNeg = '560701086' 
        where Contrato in ( 559938, 560478 )

    -- Agosto 2013
    update  #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701077', CntCtaResultadoNeg = '560701076'
        where Contrato in ( 563749 ) and fechaEvento = '20130807'
	
    -- Septiembbre 2013
	update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 566072 )  and FechaEvento = '20130917' 
	
	update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 566329 )  and FechaEvento = '20130926' 

	update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 559753 )  and FechaEvento = '20130430' 

	update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 563640 )  and FechaEvento = '20130731' 
    
	update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 563620 )  and FechaEvento = '20130730' 
	
	update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 563618 )  and FechaEvento = '20130805' 

	update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 562320 )  and FechaEvento = '20130704'
	
   update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 568737 )  and FechaEvento = '20131128'

   update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 568720 )  and FechaEvento = '20131127'

   update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 568718 )  and FechaEvento = '20131126'

-- 562058
   update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701088', CntCtaResultadoNeg = '560701086' 
	where KeyCntId_sistema = 'BFW' and contrato in ( 562058 )  and FechaEvento = '20130618'



    -- Solamente para modifica Montos Anticipos Mx/CLP	
/* No se transfiere

	update #ContratosDerivadosMesSC set Monto_Pagado_CLP_Al_Anticipar = -6971739 - 2921037
	where contrato = 557053 and evento = 'Cuadratura' and subevento = 'Anticipo' -- Año 2013

		update #ContratosDerivadosMesSC set Monto_Pagado_CLP_Al_Anticipar = -2492749 + 2947227
	where contrato = 559349 and evento = 'Cuadratura' and subevento = 'Anticipo' -- Año 2013

	update #ContratosDerivadosMesSC  Set Monto_Pagado_CLP_Al_Anticipar = 2539868 + 11761 
	where contrato = 565786 and evento = 'Cuadratura' and subevento = 'Anticipo'  -- Año 2013

	update #ContratosDerivadosMesSC  Set Monto_Pagado_CLP_Al_Anticipar =  878466 + 3445 -- 801103 confundí con otra operación
	where Contrato = 567340 and evento = 'Cuadratura' and subevento = 'Anticipo'   -- Año 2013

    update #ContratosDerivadosMesSC  Set Monto_Pagado_CLP_Al_Anticipar = -2586709 +   19351  
	  where Contrato = 556414 and evento = 'Cuadratura' and subevento = 'Anticipo'  -- Año 2013
    update #ContratosDerivadosMesSC  Set Monto_Pagado_CLP_Al_Anticipar = -2494185  +  26176
	  where Contrato = 555921 and evento = 'Cuadratura' and subevento = 'Anticipo'  -- Año 2013

   update #ContratosDerivadosMesSC  Set Monto_Pagado_CLP_Al_Anticipar = -7692320+7715
	  where Contrato = 559483 and evento = 'Cuadratura' and subevento = 'Anticipo'  -- Año 2013 
*/



---- Dejar comentado hasta que se ejecute el traslado de cuenta en IBS.
----    update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701071', CntCtaResultadoNeg = '560701069' 
----	where KeyCntId_sistema = 'BFW' and contrato in ( 567093 )  and FechaEvento = '20130827'  
----
----    update #ContratosDerivadosMesSC set CntCtaResultadoPos = '760701071', CntCtaResultadoNeg = '560701069' 
----	where KeyCntId_sistema = 'BFW' and contrato in ( 567095 )  and FechaEvento = '20130827'  

-- Casos extra raros
-- Operacion Mx/Clp se anticipó anticipando la Mx/Usd y un Usd/Clp que no correspondía.
-- Operacion Mx/Clp se deja vencer naturalmente pero su Usd/Clp fue anticipado. 
-- select * from #ContratosDerivadosMesSc where contrato = 562806
/* No se transfiere
      update #ContratosDerivadosMesSc set Monto_Pagado_CLP_Al_Vcto_Compensado = 14773726 -1838700 -139778 
	  where contrato = 562806 and evento = 'Cuadratura' and subEvento = 'Vcto. Nat.' --Año Pasado
*/
     /* regularizacion de Rut */
    Update #ContratosDerivadosMesAjuAVR
	    set   Rut_Contraparte = Rut_Cliente_Emp
		    , DV_Rut_Contraparte = ClDv
		  from BacParamSuda.dbo.Cliente 
		  where ClRut = Rut_CLiente_Emp and ClCodigo = Codigo_Cliente_Emp
    update #ContratosDerivadosMesSC
	    set   Rut_Contraparte = Rut_Cliente_Emp
		    , DV_Rut_Contraparte = ClDv
		  from BacParamSuda.dbo.Cliente 
		  where ClRut = Rut_CLiente_Emp and ClCodigo = Codigo_Cliente_Emp
     /* regularizacion de Rut a nivel de detalle */		  

	 /*
	   select * from #ContratosDerivadosMes where 1 = 2
	   select * from #ContratosDerivadosMesSC where 1 = 2
	   select * from #ContratosDerivadosMesAjuAVR where 1 = 2
	 */
	select *  into #ContratosDerivadosMesDJ  -- drop table #ContratosDerivadosMesDJ
        from #ContratosDerivadosMes    
    union
	select * from #ContratosDerivadosMesSC
	union
	select * from #ContratosDerivadosMesAjuAVR  -- Ajustes de AVR: provisiones Pargua y Complemento (Patrimonio, Desarmes)

	-- ***************************************************************
	-- APLICACION DE AJUSTES CONTABLES                         *******
	-- ***************************************************************
	update #ContratosDerivadosMesDJ
	    set  Monto_Pagado_CLP_Al_Vcto_Compensado = Monto_Pagado_CLP_Al_Vcto_Compensado + 
		
			 isnull( ( select  sum( MontoMdaLocal )
		          from BacParamSuda.dbo.DJAjustesContables DJ
		           where #ContratosDerivadosMesDJ.Evento = DJ.Evento and #ContratosDerivadosMesDJ.SubEvento = DJ.SubEvento 
		                      and -- Eventos de Pago por Venctos naturales
		                     (    DJ.Evento = 'Vcto. Natural' and DJ.subevento = 'No Aplica'
							   or DJ.Evento = 'Cuadratura' and DJ.subevento = 'Vcto. Natural' 
                               or DJ.evento = 'Liq Hip'    and DJ.SubEvento = 'No aplica' 
							   or DJ.Evento = 'Liquidacion' and DJ.SubEvento = 'No Aplica'
							  )
                  and DJ.Contrato = #ContratosDerivadosMesDJ.Contrato
			      and DJ.Modulo = #ContratosDerivadosMesDJ.Modulo
				  and DJ.FechaEvento = #ContratosDerivadosMesDJ.FechaEvento
              ), 0 )
	
	update #ContratosDerivadosMesDJ
	    set  Monto_pagado_CLP_Al_Anticipar = Monto_pagado_CLP_Al_Anticipar + 
		     isnull( ( select sum( MontoMdaLocal )
		                 from BacParamSuda.dbo.DJAjustesContables DJ
		                where #ContratosDerivadosMesDJ.Evento = DJ.Evento and #ContratosDerivadosMesDJ.SubEvento = DJ.SubEvento 
		                       and  -- Eventos de pago por anticipos  
		                     (    DJ.Evento = 'Anticipo' and DJ.subevento = 'TOTAL'
							   or DJ.Evento = 'Anticipo' and DJ.subevento = 'PARCIAL' 
							  )
                        and DJ.Contrato = #ContratosDerivadosMesDJ.Contrato
			            and DJ.Modulo = #ContratosDerivadosMesDJ.Modulo
						and DJ.FechaEvento = #ContratosDerivadosMesDJ.FechaEvento
                     ), 0 )

	update #ContratosDerivadosMesDJ
	    set  Monto_pagado_CLP_Al_Anticipar = Monto_pagado_CLP_Al_Anticipar + 
		      isnull( ( select sum( MontoMdaLocal )
		                from BacParamSuda.dbo.DJAjustesContables DJ
		                 where #ContratosDerivadosMesDJ.Evento = DJ.Evento and #ContratosDerivadosMesDJ.SubEvento = DJ.SubEvento 
		                       and  -- Eventos de pago por ejercicios  
		                     (    DJ.Evento = 'Ejercicio' and DJ.subevento = 'No Aplica'							   
							  )
                         and DJ.Contrato = #ContratosDerivadosMesDJ.Contrato
			             and DJ.Modulo = #ContratosDerivadosMesDJ.Modulo
						 and DJ.FechaEvento = #ContratosDerivadosMesDJ.FechaEvento
                        ), 0 )
    -- ***************************************************************
    -- ****     Query cuadrable con la contabilidad del Banco  *******
	-- ****     El contenido de este query se reorganiza y     *******
    -- ****     genera la anual.                               *******
    -- ***************************************************************
	-- select * from  #ContratosDerivadosMesDJ


	/* Resumen de información Anual */
	 select   Modulo -- KeyCntId_sistema puede haber coincidencia en los Forward
			, Contrato = Contrato
		--	, fecha_Ultimo_Evento = max(Eventos.FechaEvento)   Está incorrecto !!!
            , Ultimo_FolioEvento  = max(Eventos.FolioEvento)      
			  -- MOLEB                  
	into #NominaContratosResumenAnual   
	 from #ContratosDerivadosMes Eventos    -- <=== Ojo que es la tabla #ContratosDerivadosMes!!!!
         group by modulo, Contrato

-- select * from #NominaContratosResumenAnual where Contrato = 552803


/* 
select  * from #NominaContratosResumenAnual where contrato = 552803
select modulo, folioEvento, * from #ContratosDerivadosMes where contrato = 552803
*/
	 select Mes.* 
	   into #ResumenAnual
	   from  #ContratosDerivadosMes  Mes               
		  , #NominaContratosResumenAnual Nomina 
			  where    Mes.Modulo = Nomina.Modulo 
				   and Mes.Contrato = Nomina.Contrato 
				  /* and Mes.FechaEvento = Nomina.fecha_Ultimo_Evento */
                   and Mes.FolioEvento = Nomina.Ultimo_FolioEvento

    
    -- Corregir el AVR de los Mx/Clp
    update #ResumenAnual
          Set Valor_Justo_Al_Cierre = #ResumenAnual.Valor_Justo_Al_Cierre + SegCambio.Valor_Justo_Al_Cierre
            , Valor_Justo_Al_CierreAnoAnt = #ResumenAnual.Valor_Justo_Al_CierreAnoAnt + SegCambio.Valor_Justo_Al_CierreAnoAnt
       from #ContratosDerivadosMesSC SegCambio
             where  SegCambio.SubEvento = 'Valor Razonable'
                and SegCambio.Contrato  = #ResumenAnual.Contrato
                and #ResumenAnual.Producto_Emp = 12

 -- /************************** Por mientras se desactiva  
   -- Agregar el AVR de las Provisiones y Pargua
    update #ResumenAnual
          Set Valor_Justo_Al_Cierre = #ResumenAnual.Valor_Justo_Al_Cierre + isnull(
		                                                                     ( select sum( ProvPargua.Valor_Justo_Al_Cierre )            
                                                                             from #ContratosDerivadosMesAjuAVR ProvPargua                  
                                                                             where ProvPargua.Modulo = #ResumenAnual.Modulo
			                                                                 and ProvPargua.Contrato = #ResumenAnual.Contrato
			                                                                 and ProvPargua.Evento in ( 'Provisiones', 'Pargua' ) -- 5622
			                                                                 and ProvPargua.Valor_Justo_Al_Cierre <> 0  ) , 0 )

			   
    update #ResumenAnual
          Set  Valor_Justo_Al_CierreAnoAnt = #ResumenAnual.Valor_Justo_Al_CierreAnoAnt + isnull( 
		                                                                               ( select  sum(  ProvPargua.Valor_Justo_Al_CierreAnoAnt )
                                                                                                from #ContratosDerivadosMesAjuAVR ProvPargua                  
                                                                                        where ProvPargua.Modulo = #ResumenAnual.Modulo
			                                                                              and ProvPargua.Contrato = #ResumenAnual.Contrato
			                                                                              and ProvPargua.Evento in ( 'Provisiones', 'Pargua' ) -- 5622
			                                                                              and ProvPargua.Valor_Justo_Al_CierreAnoAnt <> 0 ), 0 )
/*
select sum(Valor_Justo_Al_Cierre)
 from #ContratosDerivadosMesAjuAVR where modulo = 'SAO' and evento = 'Provisiones' and contrato = 19031
 */


    -- Agregar los movimiento Cuentas Complemetarias (Coberturas y Desarmes de Cobertura )
    update #ResumenAnual
          Set Efecto_En_Patrimonio =  isnull( (select sum( Complemento.Efecto_En_Patrimonio )
																						from #ContratosDerivadosMesAjuAVR Complemento                  
																									 where Complemento.Modulo = #ResumenAnual.Modulo
																									   and Complemento.Contrato = #ResumenAnual.Contrato
																									   and Complemento.Evento = 'Complemento' 
																									   and Complemento.Efecto_En_Patrimonio <> 0 ), 0 )
            , Cuenta_Contable_Registro_Patrimonio = isnull( (select max( Complemento.Cuenta_Contable_Registro_Patrimonio )
																									from #ContratosDerivadosMesAjuAVR Complemento                  
																									 where Complemento.Modulo = #ResumenAnual.Modulo
																									   and Complemento.Contrato = #ResumenAnual.Contrato
																									   and Complemento.Evento = 'Complemento' 
																									   and Complemento.Efecto_En_Patrimonio <> 0 ), 0 ) 
       

    update #ResumenAnual
          Set Otros_Gastos_Asociados_Al_Contrato = isnull( (select sum( Complemento.Otros_Gastos_Asociados_Al_Contrato)
																			 from #ContratosDerivadosMesAjuAVR Complemento                  
																		 where Complemento.Modulo = #ResumenAnual.Modulo
																		   and Complemento.Contrato = #ResumenAnual.Contrato
																		   and Complemento.Evento = 'Complemento' 
																		   and Complemento.Otros_Gastos_Asociados_Al_Contrato <> 0), 0 )

            , Cuenta_Contable_Otros_Gastos = isnull( (select max(Complemento.Cuenta_Contable_Otros_Gastos) 
																			 from #ContratosDerivadosMesAjuAVR Complemento                  
																		 where Complemento.Modulo = #ResumenAnual.Modulo
																		   and Complemento.Contrato = #ResumenAnual.Contrato
																		   and Complemento.Evento = 'Complemento' 
																		   and Complemento.Otros_Gastos_Asociados_Al_Contrato <> 0), 0 )
           , Otros_Ingresos_Asociados_Al_Contrato = isnull( (select sum(Complemento.Otros_Ingresos_Asociados_Al_Contrato)
																			 from #ContratosDerivadosMesAjuAVR Complemento                  
																						 where Complemento.Modulo = #ResumenAnual.Modulo
																						   and Complemento.Contrato = #ResumenAnual.Contrato
																						   and Complemento.Evento = 'Complemento' 
																						   and Complemento.Otros_Ingresos_Asociados_Al_Contrato <> 0), 0 )
          , Cuenta_Contable_Otros_Ingresos        = isnull( (select max(Complemento.Cuenta_Contable_Otros_Ingresos)
																			 from #ContratosDerivadosMesAjuAVR Complemento                  
																						 where Complemento.Modulo = #ResumenAnual.Modulo
																						   and Complemento.Contrato = #ResumenAnual.Contrato
																						   and Complemento.Evento = 'Complemento' 
																						   and Complemento.Otros_Ingresos_Asociados_Al_Contrato <> 0), 0 )

   
--**************************** por mienstras se desactiva ****/

	-- En principio se registra como utilidad/perdida del ejercicio el 
    -- valor razonable, el valor de estos campos es igual en todos los
    -- registros.    
	update #ResumenAnual
	   set    Resultado_Ejercicio =     Valor_Justo_Al_Cierre + Prima_Total_CLP * case when Vigente_CierreAno = 'S' then 1.0 else 0.0 end 
	                                - ( Valor_Justo_Al_CierreAnoAnt + Prima_Total_CLP * case when Vigente_CierreAnoAnt = 'S' then 1.0 else 0.0 end )

    -- Por si se modifica el signo
    update #ResumenAnual
        set Cuenta_Contable_Resultado_Ejercicio = Case when Resultado_Ejercicio > 0 then CntCtaVRPos else CntCtaVRNeg end
          
     

------ Monitorear que lo que se comenta ya no sucede más.
------/* Las siguientes operaciones se modificaron y liquidaron el mismo dia:
------	2232
------	2927
------	2934
------	5117
------	5499  
------	Se privilegia y se informa el evento de liquidación
------	*/
------	         
------	-- Caso especial 01:
------	-- Dos eventos desarrollaods el mismo dia: modificacion y liquidación.
------	-- se asume que se modificar para liquidar, por lo tanto el verdadero
------	-- ultimo evento es el de Liquidación.    
------	delete #ResumenAnual 
------	where Contrato        
------	in ( 2232
------		,2927
------		,2934
------		,5117
------		, 5499 ) and Evento = 'Modificacion' and KeyCntId_Sistema = 'PCS'


	-- Caso especial 02:
	-- Ajuste por caso que vencia el 31 de Diciembre 2012
	-- La operacion se modificó después del cierre de año
	-- por tanto se asume que el último día hubo una
	-- modificación.
	-- Ojo que este hecho no fue informado en la DJ mensaul
	-- de diciembre.
	-- Estoy pidiendo confirmación por e-mail.
	update #ResumenAnual
	   set Evento = 'Modificacion'
		 , FechaEvento = '20121228'
		 , Fecha_Vencimiento = '20130102'
	where #ResumenAnual.Modulo = 'BacForward'
	  and #ResumenAnual.Contrato = 558411

	update #ResumenAnual
		set Fecha_Vencimiento = '20130102'
	 where  #ResumenAnual.Fecha_Vencimiento between '20121229' and '20121231'


    -- Se cargan los montos relacionados a eventos
    -- que implican pagos
	-- 
	update #ResumenAnual
	   set #ResumenAnual.Monto_pagado_CLP_Al_Anticipar = isnull( ( select sum( Mes.Monto_pagado_CLP_Al_Anticipar ) 
														 from #ContratosDerivadosMesDJ Mes   -- Si, tabla #ContratosDerivadosMesDJ
														 where  Mes.Modulo = #ResumenAnual.Modulo
															and Mes.Contrato = #ResumenAnual.Contrato 
                                                                  ) , 0 )
		 , #ResumenAnual.Monto_Pagado_CLP_al_vcto_compensado = isnull( ( select sum( Monto_Pagado_CLP_al_vcto_compensado )
																		  from #ContratosDerivadosMesDJ Mes 
																			where  Mes.Modulo = #ResumenAnual.Modulo
																			   and Mes.Contrato = #ResumenAnual.Contrato 
                                                                         ) , 0  )
		 , #ResumenAnual.Monto_Pagado_CLP_Al_Ejercer = isnull(  (select sum( Monto_Pagado_CLP_Al_Ejercer )
																		  from #ContratosDerivadosMesDJ Mes 
																			where  Mes.Modulo = #ResumenAnual.Modulo
																			   and Mes.Contrato = #ResumenAnual.Contrato 																			   
												                 )  , 0 )

		 , #ResumenAnual.Fecha_Liquidacion_Ejercicio_de_Opcion = case when Fecha_Vencimiento <= @FechaCierreAnnoComercial
																   then Fecha_Vencimiento
																	  when Evento = 'Anticipo' and SubEvento = 'TOTAL'
																			  then FechaEvento
																   else '19000101' end
		 , #ResumenAnual.Estado_Contrato = case when Vigente_CierreAno = 'N' then 0    -- Contrato vencido se informa "nada" 
                                                when Vigente_CierreAnoAnt = 'S' then 3 -- Contrato proviene ejercicio anterior
                                                when Fecha_suscripcion_Contrato >= @Fecha1erDiaHabilAnnoComercialHab then 1 --Suscrito en el periodo
                                           else 0 end   
		 , #ResumenAnual.Prima_Total     = case when KeyCntId_sistema = 'OPT' then 
														  isnull( ( select sum( Mes.Prima_Total_CLP ) from #ContratosDerivadosMes Mes 
														 where  Mes.Modulo = #ResumenAnual.Modulo
															and Mes.Contrato = #ResumenAnual.Contrato
                                                            and Mes.Evento = 'Curse'
                                                             ) , 0 )
										   else 0 end
     
     -- Informa si hubo modificación en el periodo
     update #ResumenAnual 
            Set #ResumenAnual.Estado_Contrato = isnull( (select 2 from #ContratosDerivadosMes Mes 
                                                           where  Mes.Modulo = #ResumenAnual.Modulo
													  	     and Mes.Contrato = #ResumenAnual.Contrato and Mes.Evento = 'Modifica'), #ResumenAnual.Estado_Contrato ) 
         where  Vigente_CierreAno = 'S' and  Fecha_suscripcion_Contrato >= @Fecha1erDiaHabilAnnoComercialHab  



	update #ResumenAnual
	   set    Valor_Justo_Contrato = Valor_Justo_Al_Cierre + Prima_Total_CLP * case when Vigente_CierreAno = 'S' then 1.0 else 0.0 end 
									 

			  -- Primero se aplican los pagos del año
			, Resultado_Ejercicio  = Resultado_Ejercicio   /* Lineas de código anterior informan VR del periodo */
                                   + Monto_pagado_CLP_Al_Anticipar 
								   + Monto_Pagado_CLP_al_vcto_compensado
								   + Monto_Pagado_CLP_Al_Ejercer                                
                                                           
			, Cuenta_Contable_Resultado_Ejercicio = case when   Monto_pagado_CLP_Al_Anticipar 
								                              + Monto_Pagado_CLP_al_vcto_compensado
								                              + Monto_Pagado_CLP_Al_Ejercer  <> 0
                                                              then /* Si hay pagos se informa la cuenta de pago */
                                                                case when
                                                                    Resultado_Ejercicio
                                                                  + Monto_pagado_CLP_Al_Anticipar 
															      + Monto_Pagado_CLP_al_vcto_compensado
															      + Monto_Pagado_CLP_Al_Ejercer  
															      > 0 then 
																		CntCtaResultadoPos 
																  else  
                                                                        CntCtaResultadoNeg 
                                                                  end 
                                                               else
                                                                  Cuenta_Contable_Resultado_Ejercicio 
                                                               end
                                                          

----			, Cuenta_Contable_Registro_Prima_Total = case when KeyCntId_sistema = 'OPT' then 
----														 case when Prima_Total < 0 then CntCtaVRPos else CntCtaVRNeg end -- NOta: Se habia puesto al revés
----													 else '' end  
                  -- Por hacer: sacar esto de los perfiles AVR para no dejar las cuentas literales.
	            , Cuenta_Contable_Registro_Prima_Total = Case when KeyCntId_sistema = 'OPT' then
                                                             case when CVOpcion = 'C' and CallPut = 'Call' then '212801034'
                                                                  when CVOpcion = 'C' and CallPut = 'Put'  then '212801035'
                                                                  when CVOpcion = 'V' and CallPut = 'Call' then '412801035'
                                                                  when CVOpcion = 'V' and CallPut = 'Put'  then '412801036'  
                                                                  else  'Error' end                                                                   
                                                         else '' end
		        , Monto_Util_PERD_CLP = Monto_pagado_CLP_Al_Anticipar 
															      + Monto_Pagado_CLP_al_vcto_compensado
															      + Monto_Pagado_CLP_Al_Ejercer 


-- Fecha Mes Inicial
-- Toma los Dias feriados entre el cierre de mes anterior 
-- y el inicio del mes        
declare @MesAnterior numeric(2)
declare @AnoAnterior numeric(4)
declare @AnoMesAnterior numeric(6) 
declare @FechaCorte1820 datetime
select  @AnoAnterior = convert( numeric(4), substring( convert( varchar(6), @annoMes ) , 1, 4) )        
select  @MesAnterior = convert( numeric(2), substring( convert( varchar(6), @annoMes ) , 5, 2) )
select  @AnoAnterior = case when @MesAnterior = 1  then @AnoAnterior - 1 else  @AnoAnterior end 
select  @MesAnterior = case when @MesAnterior = 1 then 12 else @MesAnterior - 1 end
select  @AnoMesAnterior = @AnoAnterior * 100 + @MesAnterior        
select  @FechaCorte1820 = max(acfecproc)+ 1 from BacTraderSuda.dbo.fechas_Proceso 
   where year(acfecproc)*100 + month(acfecproc) = @AnoMesAnterior

   --     select '@FechaCorte1820', @FechaCorte1820, '@FechaCorteFinal', @FechaCorteFinal
-- ***************************************************************************************************************
-- Para ejecutar desde aplicacion .net GeneraInterfaz	
-- Nombre de Interfaz DJ1820
-- ***************************************************************************************************************

-- Se entregó 1829 en que no se marcaron contratos con Estado = 3 para los que provienen de ejercicio anterior

If @tipoDJ = '1820' 
Begin

	-- Observación MOLEB, presentación 12-Junio-2014
	 Update  #ContratosDerivadosMes
		  set Fecha_Suscripcion_Contrato = case when Evento_Informado in ( 2, 3) -- 2: Modificacion 3:Cesión
		                                    then fechaEvento 
										   else Fecha_Suscripcion_Contrato end
End




if  @TipoDJ = '1820' and @EjecutaDesdePtoNet = 'SI'
Begin
		SELECT	'Contrato'= Contrato                           -- Para generar archivo plano
		,		'Evento'= Evento
		,		'SubEvento'= SubEvento
		,		'FechaEvento'= convert( varchar(8),FechaEvento, 112)
		,		'Rut_Contraparte'= convert( Varchar(8) , Rut_Contraparte)
		,		'DV_Rut_COntraparte'= convert( Varchar(1) , DV_Rut_Contraparte)
		,		'Tax_ID_Contraparte'=convert( Varchar(15) , Tax_ID_Contraparte)
		,		'Codigo_Pais_Contraparte'= convert( Varchar(2) , Codigo_Pais_Contraparte)
		,		'Tipo_Relacion_con_Contraparte'= convert( Varchar(2) , Tipo_Relacion_con_Contraparte)
		,		'Modalidad_Contratacion'= convert( Varchar(1) , Modalidad_Contratacion)
		,		'Tipo_Acuerdo_Marco'= convert( Varchar(1) , Tipo_Acuerdo_Marco)
		,		'Numero_Acuerdo_Marco'= convert( Varchar(10) , Numero_Acuerdo_Marco)
		,		'Fecha_Suscripcion_Acuerdo_Marco'= convert( varchar(8),Fecha_Suscripcion_Acuerdo_Marco, 112)
		,		'Numero_Contrato'= convert( Varchar(10) , Numero_Contrato)
		,		'Fecha_Suscripcion_Contrato'= convert( varchar(8),Fecha_Suscripcion_Contrato, 112)
		,		'Evento_Informado'= convert( Varchar(1) , Evento_Informado)
		,		'Tipo_Contrato'= convert( Varchar(2) , Tipo_Contrato)
		,		'Nombre_Instrumento'= convert( Varchar(20) , Nombre_Instrumento)
		,		'Modalidad_Cumplimiento'= convert( Varchar(1) , Modalidad_Cumplimiento)
		,		'Posicion_Declarante'= convert( Varchar(1) , Posicion_Declarante)
		,		'Tipo_Activo_Subyacente'= convert( Varchar(1) , Tipo_Activo_Subyacente)
		,		'Codigo_Activo_Subyacente'= convert( Varchar(3) , Codigo_Activo_Subyacente)
		,		'Otro_Activo_Subyacente_Especificacion'= convert( Varchar(15) , Otro_Activo_Subyacente_Especificacion)
		,		'Tasa_Fija_o_Spread_Activo_Subyacente'= convert( Varchar(7) , Tasa_Fija_o_Spread_Activo_Subyacente)
		,		'Tipo_Segundo_Activo_Subyacente'= convert( Varchar(1) , Tipo_Segundo_Activo_Subyacente)
		,		'Codigo_Segundo_Activo_Subyacente'= convert( Varchar(3) , Codigo_Segundo_Activo_Subyacente)
		,		'Otro_Segundo_Activo_Subyacente_Especificacion'= convert( Varchar(15) , Otro_Segundo_Activo_Subyacente_Especificacion)
		,		'Tasa_Fija_o_Spread_Segundo_Activo_Subyacente'= convert( Varchar(7) , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente)
		,		'Codigo_Precio_Futuro_Contratado'= convert( Varchar(1) , Codigo_Precio_Futuro_Contratado)
		,		'Precio_Futuro_Contratado'= convert( Varchar(15) , Precio_Futuro_Contratado)
		,		'Moneda_Precio_Futuro_Contratado'= convert( Varchar(3) , Moneda_Precio_Futuro_Contratado)
		,		'Unidad'= convert( Varchar(2) , Unidad)
		,		'Monto_Cantidad_Contratado_o_Nocional'= convert( Varchar(15) , Monto_Cantidad_Contratado_o_Nocional)
		,		'Segunda_Unidad'= convert( Varchar(2) , Segunda_Unidad)
		,		'Segundo_Monto_Nocional'= convert( Varchar(15) , Segundo_Monto_Nocional)
		,		'Fecha_Vencimiento'= convert( varchar(8),Fecha_Vencimiento, 112)
		,		'Rut_Cliente_Emp'= Rut_Cliente_Emp
		,		'Codigo_Cliente_Emp'= Codigo_Cliente_Emp
		,		'Modalidad_Cumplimiento_Emp'= Modalidad_Cumplimiento_Emp
		,		'Posicion_Declarante_Emp'= Posicion_Declarante_Emp
		,		'Producto_Emp'= Producto_Emp
		,		'Moneda_transada_Emp'= Moneda_transada_Emp
		,		'moneda_compensacion_Emp'= moneda_compensacion_Emp
		,		'Fecha_Curse_Contrato_Emp'= Fecha_Curse_Contrato_Emp
		,		'Estado_Cliente'= Estado_Cliente
		,		'Subyacente_Papeles_de_RentaFija'= Subyacente_Papeles_de_RentaFija
		,		'Unidad_Precio_Subyacente_Emp'= Unidad_Precio_Subyacente_Emp
		,		'Pais_Recidencia_Contraparte_Emp'= Pais_Recidencia_Contraparte_Emp
		,		'cacalcmpdol_Emp'= cacalcmpdol_Emp
		,		'Moneda_Multiplica_Divide_Emp'= Moneda_Multiplica_Divide_Emp
		,		'Moneda_Conversion_Emp'= Moneda_Conversion_Emp
		,		'Modulo'= Modulo
		,		'FolioEvento'= FolioEvento
		,		'CorrelativoGeneral'= CorrelativoGeneral
		-- ,       'Rut_Chileno' = Rut_Chileno
		FROM	#ContratosDerivadosMes  where 
                   FechaEvento >= @FechaCorte1820
               and FechaEvento <= @FechaCorteFinal
end
-- ***************************************************************************************************************
-- Para ejecutar desde consola	
-- Para generar un Excel
-- ***************************************************************************************************************
if  @TipoDJ = '1820' and @EjecutaDesdePtoNet = 'NO' 
Begin
		SELECT	'Contrato'= Contrato
		,		'Evento'= Evento
		,		'SubEvento'= SubEvento
		,		'FechaEvento'= convert( varchar(8),FechaEvento, 112)
		,		'Rut_Contraparte'= convert( Varchar(8) , Rut_Contraparte)
		,		'DV_Rut_COntraparte'= convert( Varchar(1) , DV_Rut_Contraparte)
		,		'Tax_ID_Contraparte'=convert( Varchar(15) , Tax_ID_Contraparte)
		,		'Codigo_Pais_Contraparte'= convert( Varchar(2) , Codigo_Pais_Contraparte)
		,		'Tipo_Relacion_con_Contraparte'= convert( Varchar(2) , Tipo_Relacion_con_Contraparte)
		,		'Modalidad_Contratacion'= convert( Varchar(1) , Modalidad_Contratacion)
		,		'Tipo_Acuerdo_Marco'= convert( Varchar(1) , Tipo_Acuerdo_Marco)
		,		'Numero_Acuerdo_Marco'= convert( Varchar(10) , Numero_Acuerdo_Marco)
		,		'Fecha_Suscripcion_Acuerdo_Marco'= convert( varchar(8),Fecha_Suscripcion_Acuerdo_Marco, 112)
		,		'Numero_Contrato'= convert( Varchar(10) , Numero_Contrato)
		,		'Fecha_Suscripcion_Contrato'= convert( varchar(8),Fecha_Suscripcion_Contrato, 112)
		,		'Evento_Informado'= convert( Varchar(1) , Evento_Informado)
		,		'Tipo_Contrato'= convert( Varchar(2) , Tipo_Contrato)
		,		'Nombre_Instrumento'= convert( Varchar(20) , Nombre_Instrumento)
		,		'Modalidad_Cumplimiento'= convert( Varchar(1) , Modalidad_Cumplimiento)
		,		'Posicion_Declarante'= convert( Varchar(1) , Posicion_Declarante)
		,		'Tipo_Activo_Subyacente'= convert( Varchar(1) , Tipo_Activo_Subyacente)
		,		'Codigo_Activo_Subyacente'= convert( Varchar(3) , Codigo_Activo_Subyacente)
		,		'Otro_Activo_Subyacente_Especificacion'= convert( Varchar(15) , Otro_Activo_Subyacente_Especificacion)
		,		'Tasa_Fija_o_Spread_Activo_Subyacente'= convert( Varchar(7) , Tasa_Fija_o_Spread_Activo_Subyacente)
		,		'Tipo_Segundo_Activo_Subyacente'= convert( Varchar(1) , Tipo_Segundo_Activo_Subyacente)
		,		'Codigo_Segundo_Activo_Subyacente'= convert( Varchar(3) , Codigo_Segundo_Activo_Subyacente)
		,		'Otro_Segundo_Activo_Subyacente_Especificacion'= convert( Varchar(15) , Otro_Segundo_Activo_Subyacente_Especificacion)
		,		'Tasa_Fija_o_Spread_Segundo_Activo_Subyacente'= convert( Varchar(7) , Tasa_Fija_o_Spread_Segundo_Activo_Subyacente)
		,		'Codigo_Precio_Futuro_Contratado'= convert( Varchar(1) , Codigo_Precio_Futuro_Contratado)
		,		'Precio_Futuro_Contratado'= convert( Varchar(15) , Precio_Futuro_Contratado)
		,		'Moneda_Precio_Futuro_Contratado'= convert( Varchar(3) , Moneda_Precio_Futuro_Contratado)
		,		'Unidad'= convert( Varchar(2) , Unidad)
		,		'Monto_Cantidad_Contratado_o_Nocional'= convert( Varchar(15) , Monto_Cantidad_Contratado_o_Nocional)
		,		'Segunda_Unidad'= convert( Varchar(2) , Segunda_Unidad)
		,		'Segundo_Monto_Nocional'= convert( Varchar(15) , Segundo_Monto_Nocional)
		,		'Fecha_Vencimiento'= convert( varchar(8),Fecha_Vencimiento, 112)
		,		'Rut_Cliente_Emp'= Rut_Cliente_Emp
		,		'Codigo_Cliente_Emp'= Codigo_Cliente_Emp
		,		'Modalidad_Cumplimiento_Emp'= Modalidad_Cumplimiento_Emp
		,		'Posicion_Declarante_Emp'= Posicion_Declarante_Emp
		,		'Producto_Emp'= Producto_Emp
		,		'Moneda_transada_Emp'= Moneda_transada_Emp
		,		'moneda_compensacion_Emp'= moneda_compensacion_Emp
		,		'Fecha_Curse_Contrato_Emp'= Fecha_Curse_Contrato_Emp
		,		'Estado_Cliente'= Estado_Cliente
		,		'Subyacente_Papeles_de_RentaFija'= Subyacente_Papeles_de_RentaFija
		,		'Unidad_Precio_Subyacente_Emp'= Unidad_Precio_Subyacente_Emp
		,		'Pais_Recidencia_Contraparte_Emp'= Pais_Recidencia_Contraparte_Emp
		,		'cacalcmpdol_Emp'= cacalcmpdol_Emp
		,		'Moneda_Multiplica_Divide_Emp'= Moneda_Multiplica_Divide_Emp
		,		'Moneda_Conversion_Emp'= Moneda_Conversion_Emp
		,		'Modulo'= Modulo
		,		'FolioEvento'= FolioEvento
		,		'CorrelativoGeneral'= CorrelativoGeneral
		,       'Rut_Chileno' = Rut_Chileno
		,	Rut_Cliente_Emp
		,	Codigo_Cliente_Emp
		,	Modalidad_Cumplimiento_Emp
		,	Posicion_Declarante_Emp
		,	Producto_Emp
		,	Moneda_transada_Emp
		,	moneda_compensacion_Emp
		,	Fecha_Curse_Contrato_Emp
		,	Estado_Cliente
		,	Subyacente_Papeles_de_RentaFija
		,	Unidad_Precio_Subyacente_Emp
		,	Pais_Recidencia_Contraparte_Emp
		,	cacalcmpdol_Emp
		,	Moneda_Multiplica_Divide_Emp
		,	Moneda_Conversion_Emp
		,	Modulo
		,	Precio_Fecha_Evento
		,	Precio_Fecha_Cierre_Ejercicio
		,	Monto_Pagado_MO_Al_Vcto_Compensado
		,	Monto_Pagado_CLP_Al_Vcto_Compensado
		,	Moneda_Vcto_Compensado
		,	Monto_Pagado_MO_Al_Anticipar
		,	Monto_Pagado_CLP_Al_Anticipar
		,	Moneda_Anticipar
		,	Monto_Pagado_MO_Al_Ejercer
		,	Monto_Pagado_CLP_Al_Ejercer
		,	Moneda_Ejercer
		,	Valor_Justo_Al_Evento
		,	Valor_Justo_Al_Cierre
		,	Valor_Justo_Al_CierreAnoAnt
		,	CVOpcion
		,	CallPut
		,	Tasa_Mercado_Al_Evento
		,	Tasa_Mercado_Al_Cierre
		,	Prima_Total_MO
		,	Prima_Total_CLP
		,	KeyCntId_sistema
		,	KeyCntProducto
		,	KeyCntTipOper
		,	KeyCntCallPut
		,	KeyCntMoneda2
		,	KeyCntMoneda1
		,	KeyCntModalidad
		,	KeyCntCarNormativa
        ,   KeyCntSubCarNormativa 
		,	CntPagoEvento
		,	CntCtaResultadoPos
		,	CntCtaVRPos
		,	CntCtaResultadoNeg
		,	CntCtaVRNeg
		,	CaNumEstructura
		,	VR_Al_1er_Dia_Ano
		,	VR_AL_1er_Dia_Ano_Sig
		,	Vigente_CierreAnoAnt
		,	Vigente_CierreAno
        ,   CntCtaCarVRPos                                                         
        ,   CntCtaCarVRNeg                                                         
		,	FolioEvento
		,	CorrelativoGeneral
		,	Rut_Chileno
		,	Vigente_Corte_Inicial
		,	Monto_Util_PERD_CLP

		FROM	#ContratosDerivadosMes  where 
                   FechaEvento >= @FechaCorte1820
               and FechaEvento <= @FechaCorteFinal
end

delete #GeneraFolioSII 
where rtrim(Modulo) + rtrim(convert( varchar(10),contratoBAC )) in ( select rtrim(Modulo) + rtrim(convert( varchar(10), Contrato )) 
  from #ResumenAnual where Vigente_CierreAno = 'N' )


-- Cuando sea cierre de año
-- Genera los insert para el proximo año con los registros
-- remantentes de esta tabla

	/*
	drop table #FlujosSeguroInflacionHipotecario
	drop table #ContratoSegInfHip
	drop table #ContratosDerivadosMes 
	drop table #ContratosDerivadosMesSC 
	drop table #ContratosDerivadosOrdenados  
	drop table #ContratosDerivados 
	drop table #SwapPrimerBarrido           -- select Estado, * from #SwapPrimerBarrido where numero_operacion = 5158
	drop table #SwapSegundoBarrido
	drop table #SwapContratos               -- select * from #SwapContratos where numero_operacion = 803
	drop table #Anticipos_Swap
	drop table #ResumenAnual
	drop table #NominaContratosResumenAnual
	drop table #Pagos

	drop table #TA_GNL_TPO_CTT
	drop table #TA_GNL_UND_MNA_MID
	drop table #TA_GNL_TSA_INT_VAR
	drop table #TA_GNL_TSA_INT
	drop table #TA_GNL_TPO_REL_CTP
	drop table #TA_GNL_TPO_ADO_MRC
	drop table #TA_GNL_PTO_BSC
	drop table #TA_GNL_PSC_DLN
	drop table #TA_GNL_PAI_EMP
	drop table #TA_GNL_PAI_SII
	drop table #TA_GNL_MON_SII 
	drop table #TA_GNL_MLD_PAG
	drop table #TA_GNL_MLD_CUM
	drop table #TA_GNL_MLD_CTN 
	drop table #TA_GNL_EVT_IFD
	drop table #TA_GNL_EST_CTT_CFM
	drop table #TA_GNL_CTT_VNC_EJR
	drop table #TA_GNL_COD_PRC
	drop table #TA_GNL_ACV_SYE
	drop table #TA_GNL_CLI_TAXID
	drop table #TA_GNL_UND_MNA_MID_EMP
	drop table #TA_GNL_RUT_MOD
	drop table #Eventos_SAO1  
	drop table #Contratos_Marco
	drop table #Rut_relacionados


	drop table #AuxContratosDerivados
	drop table #AuxContratosDerivados2
	drop table #AuxContratosDerivados3
	drop table #CompensacionAmericano
	drop table #AuxContratosDerivados4
	drop table #AuxContratosDerivados5
	drop table #CondicionesCtasLIQ
	drop table #CondicionesCtasVR
	drop table #CursorProductos
	drop table #CondicionesCtas
	drop table #FILTROCONTABLE 
	drop table #PagosSegCambio
	drop table #Temp_Ajuste_AVR_Operacion	
    drop table #ContratosDerivadosMesDJ
    drop table #GeneraFolioSII
    drop table #CondicionesCtasCARVR
	drop table #ContratosDerivadosMesAjuAVR
	drop table #Cta_Resultado
	drop table #DJ1829_Detalle
	drop table #Evento
	-- drop table #Vctos
	*/

	set nocount off

	-- ***************************************************************************************************************
	-- Cuadratura de  Pagos
	-- Cuadratura de  VR Valor Razoanable o Valor de la cartera activa-pasiva
	-- Caudaratura de AVR Ajuste Valor Razonable reconocido como resultado	
	-- ***************************************************************************************************************
    if @Cuadratura = 'SI'  and @TipoDJ = '1829' and @EjecutaDesdePtoNet = 'NO'
	Begin
	   /* PENDIENTE Condicionar insert físico al cierre de mes 
	   -- GRANT INSERT  ON DBO.DJ1829_Detalle to [CORPORATIVO\GRPDESFINMER] 
	   -- GRANT DELETE  ON DBO.DJ1829_Detalle to [CORPORATIVO\GRPDESFINMER] 
	   */
	    -- Para traspasar al Excel
		--select 'Despliegue'
		select Fecha_Analisis = @FechaCorteFinal
			  , *
			  , ParCuentaVR    = ltrim(rtrim(CntCtaVRPos)) + ' '+ ltrim(rtrim(CntCtaVRNeg)) 
			  , AVR_Cierre     = case when Vigente_CierreAno = 'S' then Valor_Justo_Al_Cierre - - Prima_Total_CLP else 0 end  
			  , AVR_Cierre_Ant = case when Vigente_CierreAnoAnt = 'S' then Valor_Justo_Al_CierreAnoAnt - - Prima_Total_CLP else 0 end 
			  , ParCuentaLiq   = ltrim(rtrim(CntCtaResultadoPos)) + ' ' + ltrim(rtrim(CntCtaResultadoNeg))
			  , Total_Pagos_Acum = Monto_pagado_CLP_Al_Anticipar + Monto_Pagado_CLP_al_vcto_compensado + Monto_Pagado_CLP_Al_Ejercer
			  , Total_Pagos_Mes  = case when  FechaEvento >= @FechaCorte1820 and FechaEvento <= @FechaCorteFinal then
									  Monto_pagado_CLP_Al_Anticipar + Monto_Pagado_CLP_al_vcto_compensado + Monto_Pagado_CLP_Al_Ejercer
								   else 0 end
			  , ParCuentaCarVR = ltrim(rtrim(CntCtaCARVRPos)) + ' '+ ltrim(rtrim(CntCtaCARVRNeg)) 
			  , Valida_VR      = Case when ( evento = 'Curse' or
											 evento = 'Cuadratura' and SubEvento = 'Valor Razonable' or 
													evento = 'Provisiones' or
													evento = 'Pargua' )                                       										 
										   and Valor_Justo_Al_Cierre <> 0
										   and Vigente_CierreAno = 'S'
								 then 'Cuadra VR' else 'No Cuadra VR' end
			  , Cta_Car_VR     = case when Valor_Justo_Al_Cierre > 0 then CntCtaCARVRPos else CntCtaCARVRNeg End
			  , Debe_VR        = case when Valor_Justo_Al_Cierre > 0 then Valor_Justo_Al_Cierre else 0 end
			  , Haber_VR       = case when Valor_Justo_Al_Cierre > 0 then 0 else abs(Valor_Justo_Al_Cierre) end 
			  , Valida_Resultado_VR  = case when  ( evento = 'Curse' or
													evento = 'Cuadratura' and SubEvento = 'Valor Razonable' or
													evento = 'Provisiones' or
													evento = 'Pargua' )                                       
										   and ( Vigente_CierreAno = 'S' or Vigente_CierreAnoAnt = 'S' )
								 then 'Cuadra VR' else 'No Cuadra VR' end  
			  , Cta_VR_Inicial = case when Valor_Justo_Al_CierreAnoAnt > 0 then CntCtaCARVRPos else CntCtaCARVRNeg end	
			  , Debe_VR_Inicial  = case when Valor_Justo_Al_CierreAnoAnt > 0 then Valor_Justo_Al_CierreAnoAnt else 0 end	
			  , Haber_VR_Inicial = case when Valor_Justo_Al_CierreAnoAnt > 0 then 0 else abs(Valor_Justo_Al_CierreAnoAnt) end

	         --  into BacParamSuda.dbo.DJ1829_Detalle        -- Para generar tabla  							   
	   from #ContratosDerivadosMesDJ WHERE fechaevento <=  @FechaCorteFinal
	   order by contrato, modulo, fechaEvento
	   if @FechaUltimoDiaMes = @FechaCorteFinal
	   begin

	       -- select 'Grabacion'
	       -- Grabar para tributario	       
	       delete  BacParamSuda.dbo.DJ1829_Detalle where Fecha_Analisis = @FechaCorteFinal
	       insert into BacParamSuda.dbo.DJ1829_Detalle	   
		   select Fecha_Analisis = @FechaCorteFinal
			  , *
			  , ParCuentaVR    = ltrim(rtrim(CntCtaVRPos)) + ' '+ ltrim(rtrim(CntCtaVRNeg)) 
			  , AVR_Cierre     = case when Vigente_CierreAno = 'S' then Valor_Justo_Al_Cierre - - Prima_Total_CLP else 0 end  
			  , AVR_Cierre_Ant = case when Vigente_CierreAnoAnt = 'S' then Valor_Justo_Al_CierreAnoAnt - - Prima_Total_CLP else 0 end 
			  , ParCuentaLiq   = ltrim(rtrim(CntCtaResultadoPos)) + ' ' + ltrim(rtrim(CntCtaResultadoNeg))
			  , Total_Pagos_Acum = Monto_pagado_CLP_Al_Anticipar + Monto_Pagado_CLP_al_vcto_compensado + Monto_Pagado_CLP_Al_Ejercer
			  , Total_Pagos_Mes  = case when  FechaEvento >= @FechaCorte1820 and FechaEvento <= @FechaCorteFinal then
									  Monto_pagado_CLP_Al_Anticipar + Monto_Pagado_CLP_al_vcto_compensado + Monto_Pagado_CLP_Al_Ejercer
								   else 0 end
			  , ParCuentaCarVR = ltrim(rtrim(CntCtaCARVRPos)) + ' '+ ltrim(rtrim(CntCtaCARVRNeg)) 
			  , Valida_VR      = Case when ( evento = 'Curse' or
											 evento = 'Cuadratura' and SubEvento = 'Valor Razonable' or 
													evento = 'Provisiones' or
													evento = 'Pargua' )                                       										 
										   and Valor_Justo_Al_Cierre <> 0
										   and Vigente_CierreAno = 'S'
								 then 'Cuadra VR' else 'No Cuadra VR' end
			  , Cta_Car_VR     = case when Valor_Justo_Al_Cierre > 0 then CntCtaCARVRPos else CntCtaCARVRNeg End
			  , Debe_VR        = case when Valor_Justo_Al_Cierre > 0 then Valor_Justo_Al_Cierre else 0 end
			  , Haber_VR       = case when Valor_Justo_Al_Cierre > 0 then 0 else abs(Valor_Justo_Al_Cierre) end 
			  , Valida_Resultado_VR  = case when  ( evento = 'Curse' or
													evento = 'Cuadratura' and SubEvento = 'Valor Razonable' or
													evento = 'Provisiones' or
													evento = 'Pargua' )                                       
										   and ( Vigente_CierreAno = 'S' or Vigente_CierreAnoAnt = 'S' )
								 then 'Cuadra VR' else 'No Cuadra VR' end  
			  , Cta_VR_Inicial = case when Valor_Justo_Al_CierreAnoAnt > 0 then CntCtaCARVRPos else CntCtaCARVRNeg end	
			  , Debe_VR_Inicial  = case when Valor_Justo_Al_CierreAnoAnt > 0 then Valor_Justo_Al_CierreAnoAnt else 0 end	
			  , Haber_VR_Inicial = case when Valor_Justo_Al_CierreAnoAnt > 0 then 0 else abs(Valor_Justo_Al_CierreAnoAnt) end

	         --  into BacParamSuda.dbo.DJ1829_Detalle        -- Para generar tabla  							   
			  from #ContratosDerivadosMesDJ WHERE fechaevento <=  @FechaCorteFinal
			  order by contrato, modulo, fechaEvento
			/*        Por mientras !!! para generar indice
					  CREATE NONCLUSTERED INDEX IX_DJ1829
					  ON BacParamSuda.dbo.DJ1829_Detalle  (Fecha_Analisis, Modulo, fechaEvento, Contrato);
			*/
           

		end
	End

	-- select Monto_Pagado_CLP_Al_Vcto_Compensado, * from #ContratosDerivadosMesDJ where contrato = 543
	-- ***************************************************************************************************************
	-- Para obtener la DJ1829 en consola y llevar a una Excel si es necesario
	-- ***************************************************************************************************************
--	/* Por mientas se ejecuta DEBUG 
    if @Cuadratura = 'NO'  and @TipoDJ = '1829' and @EjecutaDesdePtoNet = 'NO'
	begin
	   delete bacParamsuda.dbo.DJ1829_Resumen where fecha_Analisis = @FechaCorteFinal
	   insert into bacParamsuda.dbo.DJ1829_Resumen
	   Select Fecha_Analisis = @FechaCorteFinal, * 
--	      INTO bacParamsuda.dbo.DJ1829_Resumen
	    FROM #ResumenAnual order by contrato, modulo
--		Por mientras se ejecuta debug 
    end
	-- ***************************************************************************************************************
	-- Para ejecutar desde aplicacion .net GeneraInterfaz	
    -- Nombre de Interfaz DJ1829
	-- ***************************************************************************************************************
   if  @TipoDJ = '1829' and @EjecutaDesdePtoNet = 'SI' 
	Begin
		SELECT	Contrato                                
			,	Evento                         
			,	SubEvento                      
			,	FechaEvento = convert( varchar(8),FechaEvento, 112)            
			,	Rut_Contraparte                         
			,	DV_Rut_COntraparte 
			,	Tax_ID_Contraparte 
			,	Codigo_Pais_Contraparte 
			,	Tipo_Relacion_con_Contraparte 
			,	Modalidad_Contratacion                  
			,	Tipo_Acuerdo_Marco                      
			,	Numero_Acuerdo_Marco                                                                                                                                                                                     
			,	Fecha_Suscripcion_Acuerdo_Marco = convert( varchar(8),Fecha_Suscripcion_Acuerdo_Marco, 112)  
			,	Numero_Contrato 
			,	Fecha_Suscripcion_Contrato = convert( varchar(8),Fecha_Suscripcion_Contrato, 112)  
			,	Contrato_Vencido_En_El_Ejercicio 
			,	Estado_Contrato 
			,	Tipo_Contrato                           
			,	Nombre_Instrumento   
			,	Modalidad_Cumplimiento                  
			,	Posicion_Declarante                     
			,	Tipo_Activo_Subyacente                  
			,	Codigo_Activo_Subyacente 
			,	Otro_Activo_Subyacente_Especificacion 
			,	Tasa_Fija_o_Spread_Activo_Subyacente    
			,	Tipo_Segundo_Activo_Subyacente          
			,	Codigo_Segundo_Activo_Subyacente 
			,	Otro_Segundo_Activo_Subyacente_Especificacion 
			,	Tasa_Fija_o_Spread_Segundo_Activo_Subyacente 
			,	Codigo_Precio_Futuro_Contratado         
			,	Precio_Futuro_Contratado               
			,	Moneda_Precio_Futuro_Contratado 
			,	Unidad                                  
			,	Monto_Cantidad_Contratado_o_Nocional    
			,	Segunda_Unidad                          
			,	Segundo_Monto_Nocional                  
			,	Fecha_Vencimiento = convert( varchar(8),Fecha_Vencimiento, 112)        
			,	Fecha_Liquidacion_Ejercicio_de_Opcion = convert( varchar(8),Fecha_Liquidacion_Ejercicio_de_Opcion, 112) 
			,	Codigo_Precio_Mercado_Al_Cierre_o_Liquidacion  
			,	Precio_Mercado_Al_CIerre_o_Liquidacion 
			,	Valor_Justo_Contrato                    
			,	Resultado_Ejercicio                     
			,	Cuenta_Contable_Resultado_Ejercicio 
			,	Efecto_En_Patrimonio                    
			,	Cuenta_Contable_Registro_Patrimonio 
			,	Comision_Pactada                        
			,	Cuenta_Contable_Registro_Comision_Pactada 
			,	Prima_Total                             
			,	Cuenta_Contable_Registro_Prima_Total    
			,	Inversion_Inicial                       
			,	Cuenta_Contable_Registro_Inversion_Inicial 
			,	Otros_Gastos_Asociados_Al_Contrato      
			,	Cuenta_Contable_Otros_Gastos            
			,	Otros_Ingresos_Asociados_Al_Contrato    
			,	Cuenta_Contable_Otros_Ingresos          
			,	Montos_Pagos_Al_Exterior_Efectuados     
			,	Modalidad_Pago_Al_Exterior_Efectuados   
			,	Saldo_Garantias_Al_Cierre               
			,	Rut_Cliente_Emp                         
			,	Codigo_Cliente_Emp                      
			,	Modalidad_Cumplimiento_Emp 
			,	Posicion_Declarante_Emp 
			,	Producto_Emp 
			,	Moneda_transada_Emp                     
			,	moneda_compensacion_Emp                 
			,	Fecha_Curse_Contrato_Emp = convert( varchar(8),Fecha_Curse_Contrato_Emp, 112) 
			,	Estado_Cliente                            
			,	Subyacente_Papeles_de_RentaFija 
			,	Unidad_Precio_Subyacente_Emp            
			,	Pais_Recidencia_Contraparte_Emp         
			,	cacalcmpdol_Emp                         
			,	Moneda_Multiplica_Divide_Emp 
			,	Moneda_Conversion_Emp                   
			,	Modulo     
			,	Precio_Fecha_Evento    
			,	Precio_Fecha_Cierre_Ejercicio 
			,	Monto_Pagado_MO_Al_Vcto_Compensado      
			,	Monto_Pagado_CLP_Al_Vcto_Compensado     
			,	Moneda_Vcto_Compensado                  
			,	Monto_Pagado_MO_Al_Anticipar            
			,	Monto_Pagado_CLP_Al_Anticipar           
			,	Moneda_Anticipar                        
			,	Monto_Pagado_MO_Al_Ejercer              
			,	Monto_Pagado_CLP_Al_Ejercer             
			,	Moneda_Ejercer                          
			,	Valor_Justo_Al_Evento                   
			,	Valor_Justo_Al_Cierre                   
			,	CVOpcion 
			,	CallPut 
			,	Tasa_Mercado_Al_Evento 
			,	Tasa_Mercado_Al_Cierre 
			,	Prima_Total_MO         
			,	Prima_Total_CLP
		----    ,   Valor_Justo_Al_CierreAnoAnt    
		----    ,   Vigente_CierreAnoAnt	
		----    ,   Vigente_CierreAno
			FROM #ResumenAnual order by contrato, modulo
	End
END
GO
