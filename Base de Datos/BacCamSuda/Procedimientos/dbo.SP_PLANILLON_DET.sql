USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLANILLON_DET]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_PLANILLON_DET]( @dFecha_rpt VARCHAR(10) = 'yyyymmdd' )
AS 
BEGIN
     SET NOCOUNT     ON
     SET ARITHABORT  OFF
     SET ARITHIGNORE ON
     DECLARE @dFecha_ant DATETIME    ,
             @dFecha_pro DATETIME
     ------------------------------------------------------------------------------------------------------
     --- SE RECUPERAN LAS FECHAS DE EMISION DEL REPORTE
     ------------------------------------------------------------------------------------------------------
     IF @dFecha_rpt = 'yyyymmdd'
        SELECT @dFecha_rpt = CONVERT(CHAR(8),acfecpro,112) FROM meac     
     SELECT  @dFecha_ant = CONVERT(DATETIME,@dFecha_rpt) ,
             @dFecha_pro = CONVERT(DATETIME,@dFecha_rpt)
     ------------------------------------------------------------------------------------------------------
     --- INICIALIZA TABLA DE RESUMEN PARA LAS POSICIONES DE HOY Y AYER
     ------------------------------------------------------------------------------------------------------
     
     DELETE FROM rptPosicion
     ------------------------------------------------------------------------------------------------------
     --- CARGA TODAS LAS MONEDAS EXTRANJERAS QUE PUEDE TENER POSICION
     ------------------------------------------------------------------------------------------------------
     INSERT INTO rptPosicion
             SELECT  CONVERT(CHAR(10),@dFecha_pro,103),
                     mncodmon                ,
                     mnnemo                  ,
                     mnrrda                  ,
                     ''                      ,
                     0                       ,
                     0                       ,
                     1.0                     ,
                     ''                      ,
                     0                       ,
                     0                       ,
                     1.0
             FROM    view_monedas
             WHERE   mnmx = 'C'
     ------------------------------------------------------------------------------------------------------
     --- ACTUALIZA LA POSICION MANTENIDA AL DIA DE AYER
     ------------------------------------------------------------------------------------------------------
     UPDATE  rptPosicion
             SET
                     posicion_origen_ayer    = vmposini ,
                     paridad_finmes_ayer     = ( CASE
                                                 WHEN vmparmes = 0 THEN 1.0
                                                 ELSE vmparmes
                                                 END ) ,
                     debe_haber_ayer         = ( CASE
                                                 WHEN vmposini > 0 THEN 'H'
                                                 WHEN vmposini < 0 THEN 'D'
                                                 ELSE ' '
                                                 END )
             FROM
                     view_posicion_spt
             WHERE
                     vmcodigo = nemotecnico_moneda AND
                     vmfecha  = @dFecha_pro
     ------------------------------------------------------------------------------------------------------
     --- ACTUALIZA LA POSICION MANTENIDA AL DIA DE PROCESO
     ------------------------------------------------------------------------------------------------------
     UPDATE  rptPosicion
             SET
                     posicion_origen_hoy     = vmposic ,
                     paridad_finmes_hoy      = ( CASE
                                                 WHEN vmparmes = 0 THEN 1.0
                                                 ELSE vmparmes
                                                 END ) ,
                     debe_haber_hoy          = ( CASE
                                                 WHEN vmposic > 0 THEN 'H'
WHEN vmposic < 0 THEN 'D'
ELSE ' '
                                                 END )
             FROM
                     view_posicion_spt
             WHERE
                     vmcodigo = nemotecnico_moneda AND
                     vmfecha  = @dFecha_pro
     ------------------------------------------------------------------------------------------------------
     --- CALCULA EL EQUIVALENTE EN 'USD' SEGUN PARIDAD BCCH
     ------------------------------------------------------------------------------------------------------
     UPDATE rptPosicion
     SET
             posicion_dolares_ayer = posicion_origen_ayer / paridad_finmes_ayer ,
             posicion_dolares_hoy  = posicion_origen_hoy  / paridad_finmes_hoy
     EXECUTE sp_Planillon_Pie @dFecha_rpt
     SET NOCOUNT     OFF
     SET ARITHIGNORE OFF
     SET ARITHABORT  ON
END
-- sp_Planillon_Det '20010628'



GO
