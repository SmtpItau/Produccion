USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_VCTOS_FLUJOS_SPOT]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_INFORME_VCTOS_FLUJOS_SPOT] 
   (   @dFecha DATETIME   
   )
AS
BEGIN

   SET NOCOUNT ON


   DECLARE @dFechaHoy     DATETIME
   ,       @dFecProceso   CHAR(10)
   ,       @dFecEmision   CHAR(10)
   ,       @dHorEmision   CHAR(10)

   SELECT  @dFechaHoy     = fechaproc
   ,       @dFecProceso   = CONVERT(CHAR(10),fechaproc,103)
   ,       @dFecEmision   = CONVERT(CHAR(10),GETDATE(),103)
   ,       @dHorEmision   = CONVERT(CHAR(10),GETDATE(),108)
   FROM    SWAPGENERAL


    SELECT  
    FechaProceso
,   NumeroOperacion
,   TipOper   = CASE WHEN TipoOperacion = 'C' THEN  'COMPRA' ELSE 'VEMTA' END
,   TipProd   = CASE WHEN TipoSwap = 1 THEN 'TASA   '
                            WHEN TipoSwap = 2 THEN 'MONEDA '
                            WHEN TipoSwap = 3 THEN 'FRA    '
                            WHEN TipoSwap = 4 THEN 'PROMEDIO   ' 
                       END
,   RutCliente
,   CodCliente
,   Nombrecli = ISNULL(clnombre,'*Conflicto con Nombre*') 
,   Moneda
,   MdaNemo    = Mda.mnnemo
,   Monto
,   MonedaCNV
,   MdaCNVNemo  = MdaCnv.mnnemo
,   MontoCNV
,   TipoCambio
,   Paridad
,   ForPagEnt = Entre.glosa 
,   ForPagRec = Recib.glosa 
,   FechaInicio
,   FechaVcto
,   FechaLiq
,   FechaValuta1
,   FechaValuta2
,   Operador
,   Estado
,   EstadoEnvio
,   NumOperSpot
INTO #FLUJOS_A_SPOT
   FROM BacSwapSuda.dbo.FLUJOS_VCTOS_SPOT
         LEFT JOIN BACPARAMSUDA..CLIENTE ON clcodigo = CodCliente AND clrut = RutCliente
		 LEFT JOIN BACPARAMSUDA..MONEDA Mda     ON Mda.mncodmon    = Moneda
		 LEFT JOIN BACPARAMSUDA..MONEDA MdaCnv  ON MdaCnv.mncodmon = MonedaCNV
         LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO Entre  ON Entre.codigo = ForPagEntre
         LEFT JOIN BACPARAMSUDA..FORMA_DE_PAGO Recib  ON Recib.codigo = ForPagRecib
   WHERE  FechaProceso = @dFecha 

 
   SELECT * FROM #FLUJOS_A_SPOT


END

GO
