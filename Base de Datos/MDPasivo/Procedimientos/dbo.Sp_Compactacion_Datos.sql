USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Compactacion_Datos]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Compactacion_Datos]
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   CREATE TABLE #COMPACTACION
               (   id_Sistema            CHAR( 3)
               ,   Tabla                 CHAR(25)
               ,   Nombre_Sistema        CHAR(15) 
               ,   Tipo                  CHAR(10)
               ,   Campo_Fecha           CHAR(20)
               )


   /* RENTA FIJA */

   INSERT INTO #COMPACTACION (   id_sistema ,   Tabla ,   Nombre_Sistema ,   Tipo ,   Campo_Fecha) VALUES ('BTR','CARTERA_HISTORICA_TRADER',' ','VIEW_','fecha_proceso')
   INSERT INTO #COMPACTACION (   id_sistema ,   Tabla ,   Nombre_Sistema ,   Tipo ,   Campo_Fecha) VALUES ('BTR','MOVIMIENTO_TRADER',' ','VIEW_','mofecpro')
   INSERT INTO #COMPACTACION (   id_sistema ,   Tabla ,   Nombre_Sistema ,   Tipo ,   Campo_Fecha) VALUES ('BTR','RESULTADO_DEVENGO',' ','VIEW_','rsfecha')


   /* FORWARD    */

   INSERT INTO #COMPACTACION (   id_sistema ,   Tabla ,   Nombre_Sistema ,   Tipo ,   Campo_Fecha) VALUES ('BFW','CARTERA_FORWARD_HISTORICA',' ','VIEW_','fecha_proceso')
   INSERT INTO #COMPACTACION (   id_sistema ,   Tabla ,   Nombre_Sistema ,   Tipo ,   Campo_Fecha) VALUES ('BFW','CARTERA_FORWARD_VENCIDA',' ','VIEW_','cafecproc')
   INSERT INTO #COMPACTACION (   id_sistema ,   Tabla ,   Nombre_Sistema ,   Tipo ,   Campo_Fecha) VALUES ('BFW','MOVIMIENTO_FORWARD',' ','VIEW_','mofecha')

   /* CAMBIO     */

   INSERT INTO #COMPACTACION (   id_sistema ,   Tabla ,   Nombre_Sistema ,   Tipo ,   Campo_Fecha) VALUES ('BCC','MOVIMIENTO_CAMBIO',' ','VIEW_','mofech')
   INSERT INTO #COMPACTACION (   id_sistema ,   Tabla ,   Nombre_Sistema ,   Tipo ,   Campo_Fecha) VALUES ('BCC','TRANSFERENCIA_PENDIENTE',' ','VIEW_','fecha_operacion')


   /* PARAMETROS */

   INSERT INTO #COMPACTACION (   id_sistema ,   Tabla ,   Nombre_Sistema ,   Tipo ,   Campo_Fecha) VALUES ('PCA','LOG_AUDITORIA',' ',' ','fechaProceso')

   UPDATE #COMPACTACION SET Nombre_Sistema = S.nombre_sistema
     FROM #COMPACTACION    C
        , SISTEMA S
    WHERE C.id_sistema = S.id_sistema
      

   SELECT c.* 
        , 'Primer_Dia_Mes' = ((Fecha_Proceso - DATEPART(DAY,Fecha_Proceso)) + 1) - 365
        , 'Ultimo_Dia_Mes' = (DATEADD(MONTH,1,Fecha_proceso)-DATEPART(DAY,Fecha_Proceso)) - 365
     FROM #COMPACTACION c
        , DATOS_GENERALES
   
END


GO
