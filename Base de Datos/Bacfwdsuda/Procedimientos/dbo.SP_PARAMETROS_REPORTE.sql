USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARAMETROS_REPORTE]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PARAMETROS_REPORTE](
     @observado  NUMERIC(12,04) OUTPUT ,
     @uf   NUMERIC(12,04) OUTPUT ,
     @fecha_observado CHAR(10) OUTPUT ,
     @fecha_uf  CHAR(10) OUTPUT
     )
AS 
BEGIN
SET NOCOUNT ON
DECLARE @fecha_proxproceso DATETIME ,
 @Fecha_Proceso     CHAR(8) ,
        @PrimerDiaMes      CHAR(8) ,
        @UltimoDiaMes      CHAR(8) ,
 @fecha_uf1    CHAR(8) 
SELECT @fecha_Proceso        = CONVERT(CHAR(8),acfecproc,112),
 @fecha_uf1   = CONVERT(CHAR(8),acfecproc,112),
 @fecha_proxproceso = acfecprox 
FROM mfac
SELECT @PrimerDiaMes   = SUBSTRING( @fecha_Proceso , 1 , 6 ) + '01'
SELECT @UltimoDiaMes   = SUBSTRING(CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,35,@PrimerDiaMes)),112),1,6) + '01'
SELECT @UltimoDiaMes   = CONVERT(CHAR(8), CONVERT(DATETIME,DATEADD(day,-1,@UltimoDiaMes)),112)
SELECT @fecha_uf       = SUBSTRING( @fecha_Proceso , 7 , 2 ) + '/' + SUBSTRING( @fecha_Proceso , 5 , 2 ) + '/' + SUBSTRING( @fecha_Proceso , 1 , 4 ) 
SELECT @fecha_observado = SUBSTRING( @fecha_Proceso , 7 , 2 ) + '/' + SUBSTRING( @fecha_Proceso , 5 , 2 ) + '/' + SUBSTRING( @fecha_Proceso , 1 , 4 )
IF SUBSTRING( CONVERT( CHAR(8) ,  @fecha_Proceso , 112 ) , 5 , 2 ) <> SUBSTRING( CONVERT( CHAR(8) ,  @fecha_proxproceso , 112 ) , 5 , 2 )
 BEGIN
  SELECT @fecha_uf  = SUBSTRING( @UltimoDiaMes  , 7 , 2 ) + '/' + SUBSTRING( @UltimoDiaMes  , 5 , 2 ) + '/' + SUBSTRING( @UltimoDiaMes  , 1 , 4 ) --CONVERT( CHAR(10) , @UltimoDiaMes  , 103 )
  SELECT @fecha_uf1 = @UltimoDiaMes
 END
SELECT @observado = c.vmvalor ,
 @uf  = b.vmvalor
FROM mfac   a,
 view_valor_moneda b,
 view_valor_moneda c
WHERE (a.accodmonuf   = b.vmcodigo   AND
 @fecha_uf1  = b.vmfecha ) AND
 (a.accodmondolobs = c.vmcodigo   AND
 @fecha_Proceso = c.vmfecha ) 
SET NOCOUNT OFF
END
-- sp_parametros_reporte 0 ,0 , '' ,''
-- SELECT * FROM VIEW_VALOR_MONEDA WHERE VMFECHA = '20010830'

GO
