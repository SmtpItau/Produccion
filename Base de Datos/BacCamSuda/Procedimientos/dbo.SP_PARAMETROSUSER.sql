USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PARAMETROSUSER]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_PARAMETROSUSER](@Usuario CHAR(15))
AS
BEGIN
  SELECT Punta
        ,Empresa
        ,Moneda
        ,Posicion
        ,Vb21446
        ,Cierre_Mesa
        ,Costo_Fondo 
        ,Supervisor 
        ,Intraday_Minimo 
        ,Intraday_Maximo 
        ,Overnigth_Minimo 
        ,Overnigth_Maximo 
        ,Usuario  
    FROM PARAMETROS_OPERADORES_SPT 
   WHERE @Usuario = usuario   
END



GO
