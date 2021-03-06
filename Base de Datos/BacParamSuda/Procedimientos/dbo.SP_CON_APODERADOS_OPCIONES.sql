USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_APODERADOS_OPCIONES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_APODERADOS_OPCIONES]
 AS  
 BEGIN   
  
  SELECT DISTINCT   
    Estructura  = apb.estructura  
  ,  Glosa   = est.OpcEstDsc  
  ,  RutApoderado1 = ISNULL(RutA.Rut_Apoderado, 0)  
  ,  NomApoderado1 = ISNULL(RutA.NombreAp, '<< Apoderado No definido')  
  ,  RutApoderado2 = ISNULL(RutB.Rut_Apoderado, 0)  
  ,  NomApoderado2 = ISNULL(RutB.NombreAp, '<< Apoderado No definido')  
  FROM DBO.TBL_APODERADOS_BANCO apb  
    INNER  JOIN LnkOpc.CbMdbOpc.dbo.opcionestructura est ON est.OpcEstCod = apb.estructura    
  
    LEFT  JOIN ( SELECT DISTINCT estructura, Rut_Apoderado, NombreAp = nap.apnombre  
          FROM DBO.TBL_APODERADOS_BANCO  
         LEFT  JOIN BacParamSuda.dbo.cliente_apoderado nap ON nap.aprutapo= Rut_Apoderado   
         WHERE orden_apoderado = 1 AND aprutcli =97023000  
                   
       )  RutA ON RutA.estructura = apb.estructura   
  
    LEFT  JOIN ( SELECT DISTINCT estructura, Rut_Apoderado, NombreAp = nap.apnombre  
          FROM DBO.TBL_APODERADOS_BANCO  
         LEFT JOIN BacParamSuda.dbo.cliente_apoderado nap ON nap.aprutapo = Rut_Apoderado  
         WHERE orden_apoderado = 2 AND aprutcli =97023000  
       )  RutB ON RutB.estructura = apb.estructura  
  
  
 END  
GO
