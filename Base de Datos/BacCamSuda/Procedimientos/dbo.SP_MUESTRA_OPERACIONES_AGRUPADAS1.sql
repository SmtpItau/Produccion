USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MUESTRA_OPERACIONES_AGRUPADAS1]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MUESTRA_OPERACIONES_AGRUPADAS1]
AS                            
BEGIN
   SET NOCOUNT ON
            SELECT morutcli
                  ,monomcli
                  ,'motipmer'  = (CASE motipmer WHEN 'PTAS' THEN 'PUNTAS'
                                                WHEN 'EMPR' THEN 'EMPRESAS'
                                                WHEN 'ARBI' THEN 'ARBITRAJES'
                                                WHEN 'TRAN' THEN 'TRANSFERENCIAS'
                                                WHEN 'CANJ' THEN 'CANJES'
                                                WHEN 'OVER' THEN 'OVERNIGHT'
                                                WHEN 'WEEK' THEN 'WEEKEND'
                                                WHEN 'CANJ' THEN 'CANJES' END )
  
                  ,'motipope'  = (CASE motipope WHEN 'C' THEN 'COMPRAS'
                                                WHEN 'V' THEN 'VENTAS' END )
                  ,moestatus   
              FROM MEMO
             WHERE motipope    = (CASE motipmer WHEN 'PTAS'    THEN 'V'
                                                WHEN 'EMPR'    THEN 'V'
                                                ELSE  motipope  END )
          GROUP BY monomcli
                  ,morutcli
                  ,motipmer
                  ,motipope
                  ,moestatus
   SET NOCOUNT OFF
END

GO
