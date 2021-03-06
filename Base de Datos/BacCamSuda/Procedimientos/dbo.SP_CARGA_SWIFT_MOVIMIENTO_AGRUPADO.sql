USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_SWIFT_MOVIMIENTO_AGRUPADO]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARGA_SWIFT_MOVIMIENTO_AGRUPADO]
AS
BEGIN
SELECT  morutcli                                                                                              --Rut Cliente
       ,monomcli                                                                                              --Nombre Cliente
       ,'motipmer'  = (CASE motipmer WHEN 'PTAS' THEN 'PUNTAS'
         WHEN 'CUPO' THEN 'CUPONES'                                                 --Tipo Mercado
                                     WHEN 'EMPR' THEN 'EMPRESAS'
         WHEN '1446' THEN '1446'
         WHEN 'FUTU' THEN 'FUTUROS' 
         WHEN 'ARRI' THEN 'ARRIENDO'
                                     WHEN 'ARBI' THEN 'ARBITRAJES'
                                     WHEN 'TRAN' THEN 'TRANSFERENCIAS'
                                     WHEN 'CANJ' THEN 'CANJES'
                                     WHEN 'OVER' THEN 'OVERNIGHT'
                                     WHEN 'WEEK' THEN 'WEEKEND'
                                     WHEN 'CANJ' THEN 'CANJES' END )
      ,'motipope'  = (CASE motipope WHEN 'C' THEN 'COMPRAS'                                                   --Tipo de Opercacion
                                    WHEN 'V' THEN 'VENTAS'
        ELSE '--------' END )
      ,moestatus                                                                                              --Estado / estado swift
      ,'dolar'    =SUM( moussme )                                                                                         --Monto USD
      ,'ticam'    =AVG( moticam )                                                                                         --Tipo de Cambio
      ,'montoorig'=SUM( momonmo )                                                                                         --Monto Oroginal
      ,'Parid'  = AVG( moprecio )                                                                                        --Paridad
      ,mocodmon                                                                                               --Codigo Moneda
      ,id_sistema                                                                                             --Estado de la Operacion
      ,movaluta1                                                                                              --Fecha Vencimiento
      ,mofech                                                                                                 --Fecha Operacion
      ,mocodcli                                                                                               --Codigo Cliente
      ,'Codigo_Pais'                                                                                          --Codigo Pais 
      ,'Codigo_ Plaza'                                                                                        --Codigo Plaza
      ,'Codigo_Swift'                                                                                         --Codigo Swift
      ,moimpreso                                                                                              --Moimpreso
FROM   MEMO
WHERE  motipope    = (CASE motipmer WHEN 'PTAS'    THEN 'V'
                                    WHEN 'EMPR'    THEN 'V'
                                    WHEN 'TRAN'    THEN 'V' 
                                    ELSE  motipope  END )
GROUP BY 
       morutcli
      ,monomcli         
      ,mocodcli
      ,motipmer
      ,motipope
      ,mocodmon
      ,movaluta1
      ,mofech 
      ,id_sistema
      ,moestatus
      ,moimpreso      
END



GO
