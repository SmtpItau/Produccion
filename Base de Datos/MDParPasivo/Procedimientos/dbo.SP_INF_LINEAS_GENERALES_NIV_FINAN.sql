USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_LINEAS_GENERALES_NIV_FINAN]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INF_LINEAS_GENERALES_NIV_FINAN](  @Nivel      CHAR(01) )
AS
BEGIN

      SET NOCOUNT ON
      SET DATEFORMAT dmy

      DECLARE @Hora         CHAR(08)
            , @Fecha_Proc        DATETIME
            , @Fecha             DATETIME
            , @Descripcion_Nivel CHAR(20)
            , @Contador          INTEGER
            , @Total_Registros   INTEGER
            , @fMonto_Conta_SR   FLOAT
            , @fMonto_Conta_CR   FLOAT
            , @fMonto_Pesos      FLOAT
            , @Rut_Cliente       NUMERIC(09)
            , @Codigo_Cliente    NUMERIC(09)

      SELECT @Fecha_Proc = Fecha_Proceso FROM DATOS_GENERALES

      SELECT @Hora = CONVERT(CHAR(08),GETDATE(),114)
      SELECT @Fecha = @Fecha_Proc
      SELECT @Descripcion_Nivel = CASE WHEN @Nivel = 'F' THEN 'NIVEL FINANCIERO' ELSE 'NIVEL CONTABLE' END

IF @Nivel = 'F' BEGIN

      SELECT 'Titulo Informe'='INFORME DE LINEAS DE CREDITO GENERALES AL ' + CONVERT(CHAR(10),@Fecha,103) + ' EN MM$',
             'Fecha Proceso'=CONVERT(CHAR(10),@Fecha_Proc,103),
             'Fecha Emision'=CONVERT(CHAR(10),@Fecha,103),
             'Nivel' = @Descripcion_Nivel               ,
             'Hora Proceso'=@Hora                       ,
             'Nombre Cliente'=C.clnombre                ,
             'Total Gen'=G.TotalAsignado/1000000        ,
             'Ocupa Gen'=G.TotalOcupado/1000000         ,
             'Dispo Gen'=CASE WHEN (G.TotalAsignado - G.TotalOcupado) < 0 THEN 0 ELSE (G.TotalAsignado - G.TotalOcupado)/1000000 END,
             'Exces Gen'=CASE WHEN (G.TotalAsignado - G.TotalOcupado) > 0 THEN 0 ELSE ABS((G.TotalAsignado - G.TotalOcupado))/1000000 END,
             
            --Renta Fija Lineas
             'Total RF'=SBTR.TotalAsignado/1000000        ,
             'Ocupa RF'=SBTR.TotalOcupado/1000000         ,
             'Dispo RF'=CASE WHEN (SBTR.TotalAsignado - SBTR.TotalOcupado) < 0 THEN 0 ELSE (SBTR.TotalAsignado - SBTR.TotalOcupado)/1000000 END,
             'Exces RF'=CASE WHEN (SBTR.TotalAsignado - SBTR.TotalOcupado) > 0 THEN 0 ELSE ABS((SBTR.TotalAsignado - SBTR.TotalOcupado))/1000000 END,

            --Renta Fija Laminas (Sin Riesgo)
             'Total SR'=SBTR.SinRiesgoAsignado/1000000        ,
             'Ocupa SR'=SBTR.SinRiesgoOcupado/1000000         ,
             'Dispo SR'=CASE WHEN (SBTR.SinRiesgoAsignado - SBTR.SinRiesgoOcupado) < 0 THEN 0 ELSE (SBTR.SinRiesgoAsignado - SBTR.SinRiesgoOcupado)/1000000 END,
             'Exces SR'=CASE WHEN (SBTR.SinRiesgoAsignado - SBTR.SinRiesgoOcupado) > 0 THEN 0 ELSE ABS((SBTR.SinRiesgoAsignado - SBTR.SinRiesgoOcupado))/1000000 END,
           
            --Renta Fija Certificados (Con Riesgo)
             'Total CR'=SBTR.ConRiesgoAsignado/1000000        ,
             'Ocupa CR'=SBTR.ConRiesgoOcupado/1000000         ,
             'Dispo CR'=CASE WHEN (SBTR.ConRiesgoAsignado - SBTR.ConRiesgoOcupado) < 0 THEN 0 ELSE (SBTR.ConRiesgoAsignado - SBTR.ConRiesgoOcupado)/1000000 END,
             'Exces CR'=CASE WHEN (SBTR.ConRiesgoAsignado - SBTR.ConRiesgoOcupado) > 0 THEN 0 ELSE ABS((SBTR.ConRiesgoAsignado - SBTR.ConRiesgoOcupado))/1000000 END,

            --Forward Lineas
             'Total FW'=SBFW.TotalAsignado/1000000        ,
             'Ocupa FW'=SBFW.TotalOcupado/1000000         ,
             'Dispo FW'=CASE WHEN (SBFW.TotalAsignado - SBFW.TotalOcupado) < 0 THEN 0 ELSE (SBFW.TotalAsignado - SBFW.TotalOcupado)/1000000 END,
             'Exces FW'=CASE WHEN (SBFW.TotalAsignado - SBFW.TotalOcupado) > 0 THEN 0 ELSE ABS((SBFW.TotalAsignado - SBFW.TotalOcupado))/1000000 END,

            --Spot Lineas
             'Total SP'=SBCC.TotalAsignado/1000000        ,
             'Ocupa SP'=SBCC.TotalOcupado/1000000         ,
             'Dispo SP'=CASE WHEN (SBCC.TotalAsignado - SBCC.TotalOcupado) < 0 THEN 0 ELSE (SBCC.TotalAsignado - SBCC.TotalOcupado)/1000000 END,
             'Exces SP'=CASE WHEN (SBCC.TotalAsignado - SBCC.TotalOcupado) > 0 THEN 0 ELSE ABS((SBCC.TotalAsignado - SBCC.TotalOcupado))/1000000 END,

            --Fecha Vencimiento de la Linea
             'Fecha Vencimiento'=CONVERT(CHAR(10),G.FechaVencimiento,103)


            FROM LINEA_GENERAL   G
               , LINEA_SISTEMA   SBTR
               , LINEA_SISTEMA   SBFW
               , LINEA_SISTEMA   SBCC
               , CLIENTE         C
            WHERE G.Rut_Cliente = C.clrut
            AND   G.Codigo_Cliente = C.clcodigo
            AND   G.Rut_Cliente = SBTR.Rut_Cliente
            AND   G.Codigo_Cliente = SBTR.Codigo_Cliente
            AND   G.Rut_Cliente = SBFW.Rut_Cliente
            AND   G.Codigo_Cliente = SBFW.Codigo_Cliente
            AND   G.Rut_Cliente = SBCC.Rut_Cliente
            AND   G.Codigo_Cliente = SBCC.Codigo_Cliente
--            AND   SBTR.Id_Sistema = 'BTR'
--            AND   SBFW.Id_Sistema = 'BFW'
--            AND   SBCC.Id_Sistema = 'BCC'
            AND   (G.TotalAsignado > 0 OR G.TotalOcupado > 0)

            ORDER BY clnombre

END
ELSE BEGIN

      SELECT 'Titulo_Informe'='INFORME DE LINEAS DE CREDITO GENERALES AL ' + CONVERT(CHAR(10),@Fecha,103) + ' EN MM$',
             'Fecha_Proceso'=CONVERT(CHAR(10),@Fecha_Proc,103),
             'Fecha_Emision'=CONVERT(CHAR(10),@Fecha,103),
             'Nivel' = @Descripcion_Nivel               ,
             'Hora_Proceso'=@Hora                       ,
             'Nombre_Cliente'=C.clnombre                ,
             'Total_Gen'=G.TotalAsignado               ,         
             'Ocupa_Gen'=CONVERT(FLOAT,0)              ,
             'Dispo_Gen'=CONVERT(FLOAT,0)               ,
             'Exces_Gen'=CONVERT(FLOAT,0)               ,
             
            --Renta Fija Lineas
             'Total_RF'=SBTR.TotalAsignado                 ,
             'Ocupa_RF'=CONVERT(FLOAT,0)                 ,
             'Dispo_RF'=CONVERT(FLOAT,0)                   ,
             'Exces_RF'=CONVERT(FLOAT,0)                   ,

            --Renta Fija Laminas (Sin Riesgo)
             'Total_SR'=SBTR.SinRiesgoAsignado               ,
             'Ocupa_SR'=CONVERT(FLOAT,0)                    ,
             'Dispo_SR'=CONVERT(FLOAT,0)                     ,
             'Exces_SR'=CONVERT(FLOAT,0)                     ,
           
            --Renta Fija Certificados (Con Riesgo)
             'Total_CR'=SBTR.ConRiesgoAsignado               ,
             'Ocupa_CR'=CONVERT(FLOAT,0)                     ,
             'Dispo_CR'=CONVERT(FLOAT,0)                     ,
             'Exces_CR'=CONVERT(FLOAT,0)                     ,

            --Forward Lineas
             'Total_FW'=SBFW.TotalAsignado               ,
             'Ocupa_FW'=SBFW.TotalOcupado        ,
             'Dispo_FW'=CASE WHEN (SBFW.TotalAsignado - SBFW.TotalOcupado) < 0 THEN 0 ELSE (SBFW.TotalAsignado - SBFW.TotalOcupado) END,
             'Exces_FW'=CASE WHEN (SBFW.TotalAsignado - SBFW.TotalOcupado) > 0 THEN 0 ELSE ABS((SBFW.TotalAsignado - SBFW.TotalOcupado)) END,

            --Spot Lineas
             'Total_SP'=SBCC.TotalAsignado               ,
             'Ocupa_SP'=SBCC.TotalOcupado        ,
             'Dispo_SP'=CASE WHEN (SBCC.TotalAsignado - SBCC.TotalOcupado) < 0 THEN 0 ELSE (SBCC.TotalAsignado - SBCC.TotalOcupado) END,
             'Exces_SP'=CASE WHEN (SBCC.TotalAsignado - SBCC.TotalOcupado) > 0 THEN 0 ELSE ABS((SBCC.TotalAsignado - SBCC.TotalOcupado)) END,

            --Fecha Vencimiento de la Linea
             'Fecha_Vencimiento'=CONVERT(CHAR(10),G.FechaVencimiento,103),

             --Datos Clientes
              'Rut_Cliente'= G.Rut_Cliente                  ,
              'Codigo_Cliente'=G.Codigo_Cliente

            INTO #Temp_Lineas

            FROM LINEA_GENERAL   G
               , LINEA_SISTEMA   SBTR
               , LINEA_SISTEMA   SBFW
               , LINEA_SISTEMA   SBCC
  , CLIENTE         C
WHERE G.Rut_Cliente = C.clrut
            AND   G.Codigo_Cliente = C.clcodigo
            AND   G.Rut_Cliente = SBTR.Rut_Cliente
            AND   G.Codigo_Cliente = SBTR.Codigo_Cliente
            AND   G.Rut_Cliente = SBFW.Rut_Cliente
            AND   G.Codigo_Cliente = SBFW.Codigo_Cliente
            AND   G.Rut_Cliente = SBCC.Rut_Cliente
            AND   G.Codigo_Cliente = SBCC.Codigo_Cliente
--            AND   SBTR.Id_Sistema = 'BTR'
--            AND   SBFW.Id_Sistema = 'BFW'
--            AND   SBCC.Id_Sistema = 'BCC'
            AND   (G.TotalAsignado > 0 OR G.TotalOcupado > 0)

            ORDER BY clnombre

      SELECT @Contador = 1
      SELECT @Total_Registros = COUNT(*) FROM #Temp_Lineas
   
      WHILE @Contador <= @Total_Registros
      BEGIN
            SET ROWCOUNT @Contador
            
                  SELECT @Rut_Cliente = Rut_Cliente
                     ,   @Codigo_Cliente = Codigo_Cliente
                         FROM #Temp_Lineas

            SET ROWCOUNT 0
            SELECT @Contador = @Contador + 1

            SELECT @fMonto_Conta_SR = 0.0
               ,   @fMonto_Conta_CR = 0.0
	       ,   @fMonto_Pesos    = 0.0
         
            EXECUTE SP_BUSCA_LIN_CONTABLE   @Rut_Cliente
                                       ,    @Codigo_Cliente
                                       ,    @fMonto_Conta_SR   OUTPUT
                                       ,    @fMonto_Conta_CR   OUTPUT
                                       ,    @fMonto_Pesos      OUTPUT

            IF @@ERROR <> 0 BEGIN
                     SELECT 'Error al buscar monto contable'
                     RETURN
            END


               UPDATE #Temp_Lineas
                      SET Ocupa_SR = @fMonto_Conta_SR
                      ,   Ocupa_CR = @fMonto_Conta_CR
                      ,   Ocupa_RF = @fMonto_Pesos
                      WHERE Rut_Cliente = @Rut_Cliente
                        AND Codigo_Cliente = @Codigo_Cliente

      END

      UPDATE #Temp_Lineas
         SET  Dispo_SR = CASE WHEN (Total_SR - Ocupa_SR) < 0 THEN 0 ELSE (Total_SR - Ocupa_SR) END
         ,    Dispo_CR = CASE WHEN (Total_CR - Ocupa_CR) < 0 THEN 0 ELSE (Total_CR - Ocupa_CR) END
         ,    Exces_SR = CASE WHEN (Total_SR - Ocupa_SR) < 0 THEN ABS((Total_SR - Ocupa_SR)) ELSE 0 END
         ,    Exces_CR = CASE WHEN (Total_CR - Ocupa_CR) < 0 THEN ABS((Total_CR - Ocupa_CR)) ELSE 0 END
         ,    Dispo_RF = CASE WHEN (Total_RF - (Ocupa_CR + Ocupa_SR)) < 0 THEN 0 ELSE (Total_RF - (Ocupa_CR + Ocupa_SR)) END
         ,    Exces_RF = CASE WHEN (Total_RF - (Ocupa_CR + Ocupa_SR)) < 0 THEN ABS((Total_RF - (Ocupa_CR + Ocupa_SR))) ELSE 0 END
         ,    Ocupa_RF = (Ocupa_RF + Ocupa_CR + Ocupa_SR)

      UPDATE #Temp_Lineas
         SET  Dispo_Gen = CASE WHEN (Total_Gen - (Ocupa_RF + Ocupa_SP + Ocupa_FW)) < 0 THEN 0 ELSE (Total_Gen - (Ocupa_RF + Ocupa_SP + Ocupa_FW)) END
         ,    Ocupa_Gen = (Ocupa_RF + Ocupa_SP + Ocupa_FW)
         ,    Exces_Gen = CASE WHEN (Total_Gen - (Ocupa_RF + Ocupa_SP + Ocupa_FW)) < 0 THEN ABS((Total_Gen - (Ocupa_RF + Ocupa_SP + Ocupa_FW))) ELSE 0 END


      SELECT 'Titulo Informe'=Titulo_Informe,
             'Fecha Proceso'=CONVERT(CHAR(10),Fecha_Proceso,103),
             'Fecha Emision'=Fecha_Emision,
             'Nivel'=Nivel,
             'Hora Proceso'=Hora_Proceso,
             'Nombre Cliente'=Nombre_Cliente,
             'Total Gen'=Total_Gen/1000000,
             'Ocupa Gen'=Ocupa_Gen/1000000,
             'Dispo Gen'=Dispo_Gen/1000000,
             'Exces Gen'=Exces_Gen/1000000,
             
            --Renta Fija Lineas
             'Total RF'=Total_RF/1000000,
             'Ocupa RF'=Ocupa_RF/1000000,
             'Dispo RF'=Dispo_RF/1000000,
             'Exces RF'=Exces_RF/1000000,

            --Renta Fija Laminas (Sin Riesgo)
             'Total SR'=Total_SR/1000000,
             'Ocupa SR'=Ocupa_SR/1000000,
             'Dispo SR'=Dispo_SR/1000000,
             'Exces SR'=Exces_SR/1000000,
           
            --Renta Fija Certificados (Con Riesgo)
             'Total CR'=Total_CR/1000000,
             'Ocupa CR'=Ocupa_CR/1000000,
             'Dispo CR'=Dispo_CR/1000000,
             'Exces CR'=Exces_CR/1000000,

            --Forward Lineas
             'Total FW'=Total_FW/1000000,
             'Ocupa FW'=Ocupa_FW/1000000,
             'Dispo FW'=Dispo_FW/1000000,
             'Exces FW'=Exces_FW/1000000,

            --Spot Lineas
             'Total SP'=Total_SP/1000000,
             'Ocupa SP'=Ocupa_SP/1000000,
             'Dispo RF'=Dispo_SP/1000000,
             'Exces RF'=Exces_SP/1000000,

            --Fecha Vencimiento de la Linea
             'Fecha Vencimiento'=CONVERT(CHAR(10),Fecha_Vencimiento,103)
  
             FROM #Temp_Lineas

END

      SET NOCOUNT OFF

END









GO
