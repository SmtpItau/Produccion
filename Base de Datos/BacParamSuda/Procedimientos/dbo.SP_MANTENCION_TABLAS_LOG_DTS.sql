USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MANTENCION_TABLAS_LOG_DTS]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_MANTENCION_TABLAS_LOG_DTS]  
  
AS  
BEGIN  
DECLARE @FECHA_MANTENCION CHAR(10)  
--DECLARE @MANTENCION_LOG INT  
  
 --SET @MANTENCION_LOG  = (SELECT Plazo FROM Detalle_Categoria WHERE idcategoria = 1)  
 SET @FECHA_MANTENCION   = (SELECT CONVERT(CHAR(10),DATEADD(DAY,-30,GETDATE()),23))  
    SET NOCOUNT ON  
  
     DELETE FROM Log_Ejecucion_DTS  
           WHERE convert(char(10),StartDateTime,23) < convert(char(10),@FECHA_MANTENCION,23)  
  DELETE FROM Log_Error_DTS  
           WHERE convert(char(10),LogDateTime,23) < convert(char(10),@FECHA_MANTENCION,23)  
          
END  
GO
