USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAP_XIII_ANEXO3]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CAP_XIII_ANEXO3]
( @Mes NUMERIC(2), @Ano NUMERIC(4) )
AS
BEGIN
SET NOCOUNT ON

DECLARE @FechaPeriodo      DATETIME
DECLARE @PeriodoInicial    DATETIME
DECLARE @InicioTrimestre   DATETIME
DECLARE @PeriodoAnterior   DATETIME
DECLARE @PosicionInicial   NUMERIC(19,4)  /* campo    8 */
DECLARE @Aumentos          NUMERIC(19,4)  /* campo  9.1 */
DECLARE @Disminuciones     NUMERIC(19,4)  /* campo  9.2 */
DECLARE @Ajuste_Mercado    NUMERIC(19,4)  /* campo   10 */
DECLARE @DividendosPercib  NUMERIC(19,4)  /* campo 12.1 */
DECLARE @InteresesPercib   NUMERIC(19,4)  /* campo 12.2 */
DECLARE @InteresesDeveng   NUMERIC(19,4)  /* campo 12.3 */
DECLARE @Utilidades        NUMERIC(19,4)  /* campo 12.4 */

SELECT @PosicionInicial   = 0
SELECT @Aumentos          = 0
SELECT @Disminuciones     = 0
SELECT @Ajuste_Mercado    = 0
SELECT @DividendosPercib  = 0
SELECT @InteresesPercib   = 0
SELECT @InteresesDeveng   = 0
SELECT @Utilidades        = 0

IF @Mes > 9
   SELECT @FechaPeriodo = DATEADD(MONTH,1,CONVERT(DATETIME,STR(@Ano,4)+STR(@Mes,2)+'01'))
ELSE
   SELECT @FechaPeriodo = DATEADD(MONTH,1,CONVERT(DATETIME,STR(@Ano,4)+'0'+STR(@Mes,1)+'01'))

SELECT @FechaPeriodo    = DATEADD(DAY,-1,@FechaPeriodo)

SELECT @PeriodoInicial  = DATEADD(YEAR,-1,STR(YEAR(@FechaPeriodo),4) + '1231')
SELECT @PeriodoInicial  = MAX(RsFecPro) FROM Text_Rsu WHERE RsFecPro <= @PeriodoInicial

SELECT @InicioTrimestre = DATEADD(DAY,1,DATEADD(MONTH,-3,@FechaPeriodo))

SELECT @PosicionInicial = SUM(RsVpPresen) / 1000.0
  FROM Text_Rsu, View_Cliente
 WHERE RsFecPro  = @PeriodoInicial 
   AND RstipOper = 'DEV'
   AND RsRutEmis = ClRut
   AND RsCodEmi  = ClCodigo
   AND ClPais   <> 6

SELECT @Aumentos = SUM(MovalComu) / 1000.0   /* COMPRAS */
  FROM Text_Mvt_Dri, View_Cliente
 WHERE MotipOper = 'CP'
--   AND MofecPro BETWEEN @InicioTrimestre AND @FechaPeriodo
   AND MofecPro BETWEEN @PeriodoInicial AND @FechaPeriodo
   AND MostatReg <> 'A'
   AND MoRutEmi  = ClRut
   AND Cod_Emi   = ClCodigo
   AND ClPais    <> 6
   AND MofecPro  = MofecPago

SELECT @Disminuciones = SUM(MovPresen) / 1000.0   /* VENTAS */
  FROM Text_Mvt_Dri, View_Cliente
 WHERE MotipOper = 'VP'
--   AND MofecPro  BETWEEN @InicioTrimestre AND @FechaPeriodo
   AND MofecPro BETWEEN @PeriodoInicial AND @FechaPeriodo
   AND MostatReg <> 'A'
   AND MoRutEmi  = ClRut
   AND Cod_Emi   = ClCodigo
   AND ClPais    <> 6
   AND MofecPro  = MofecPago

SELECT @Utilidades = SUM(MoUtilidad) / 1000.0
  FROM Text_Mvt_Dri, View_Cliente
 WHERE MotipOper = 'VP'
   AND MofecPro BETWEEN @PeriodoInicial AND @FechaPeriodo
   AND MostatReg <> 'A'
   AND MoRutEmi  = ClRut
   AND Cod_Emi   = ClCodigo
   AND ClPais    <> 6
   AND MofecPro  = MofecPago
   AND MoUtilidad > 0

SELECT @PeriodoAnterior = MAX(RsfecPro) FROM Text_Rsu WHERE RsfecPro < @InicioTrimestre

SELECT @InteresesPercib = SUM(RsInteres_Acum) / 1000.0
  FROM Text_Rsu, View_Cliente
 WHERE RsfecPro   = @PeriodoAnterior
   AND RstipOper <> 'VCP'
   AND RsRutEmis  = ClRut
   AND RsCodEmi   = ClCodigo
   AND ClPais    <> 6

SELECT @DividendosPercib = SUM(RsValVenc) / 1000.0
  FROM Text_Rsu, View_Cliente
 WHERE RsfecPro BETWEEN @PeriodoInicial AND @FechaPeriodo
   AND RstipOper = 'VCP'
   AND RsRutEmis = ClRut
   AND RsCodEmi  = ClCodigo
   AND ClPais   <> 6

SELECT @InteresesDeveng  = SUM(RsInteres_Acum) / 1000.0,
       @Ajuste_Mercado   = (SUM(RsValMerc) - SUM(RsVpPresenX)) / 1000.0
  FROM Text_Rsu, View_Cliente
 WHERE RsfecPro  = @FechaPeriodo
   AND RstipOper = 'DEV'
   AND RsRutEmis = ClRut
   AND RsCodEmi  = ClCodigo
   AND ClPais   <> 6

SELECT @DividendosPercib = @DividendosPercib - @InteresesPercib

--> Para los tipos de archivo del anexo 3
SELECT 'NumFila' = 0,
       'Titulo'  = SPACE(90) 
 INTO #Titulos
    
DELETE #Titulos

INSERT INTO #Titulos VALUES (1,'a. Acciones y otras participaciones de capital')
INSERT INTO #Titulos VALUES (2,'b. Bonos y Pagarés (l/p)')
INSERT INTO #Titulos VALUES (3,'c. Instrumentos de Renta Fija de Corto Plazo')
INSERT INTO #Titulos VALUES (4,'d. Créditos otorgados al exterior')
INSERT INTO #Titulos VALUES (5,'e. Depósitos constituidos en el exterior')
INSERT INTO #Titulos VALUES (6,'f. Otros Activos Financieros')
       
SELECT 'Tipo_Activo'     = titulo
      ,'Posicion'        = ISNULL(@PosicionInicial, 0)
      ,'Aumentos'        = ISNULL(@Aumentos, 0)
      ,'Disminuciones'   = ISNULL(@Disminuciones, 0)
      ,'Variaciones'     = ISNULL(@Ajuste_Mercado, 0)
      ,'Posicion_Final'  = ISNULL((@PosicionInicial + @Aumentos + @Ajuste_Mercado) - @Disminuciones, 0)
      ,'Divid_Percib'    = ISNULL(@DividendosPercib, 0)
      ,'Inter_Percib'    = ISNULL(@InteresesPercib, 0)
      ,'Int_dev_periodo' = ISNULL(@InteresesDeveng, 0)
      ,'Otras_Utilidads' = ISNULL(@Utilidades, 0)
      ,'Comis_Gastos'    = 0
 INTO #Temp
 FROM Text_Arc_Ctl_Dri, #Titulos
WHERE NumFila = 2

SELECT Tipo_Activo,
       Posicion,
       Aumentos,
       Disminuciones,
       Variaciones,
       Posicion_Final,
       Divid_Percib,
       Inter_Percib,
       Int_dev_periodo,
       Otras_Utilidads,
       Comis_Gastos
  FROM #Temp 
    
SET NOCOUNT OFF

END
--Sp_Cap_XIII_Anexo3 11, 2004

GO
