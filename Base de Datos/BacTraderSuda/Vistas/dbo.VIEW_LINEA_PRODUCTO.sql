USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_LINEA_PRODUCTO]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_LINEA_PRODUCTO]
AS 
SELECT rut_cliente ,
codigo_cliente  ,
id_sistema  ,
codigo_producto  ,
totalasignado  ,
totalocupado  ,
totaldisponible  ,
totalexceso  ,
totaltraspaso  ,
totalrecibido  ,
sinriesgoasignado ,
sinriesgoocupado ,
sinriesgodisponible ,
sinriesgoexceso  ,
conriesgoasignado ,
conriesgoocupado ,
conriesgodisponible ,
conriesgoexceso
FROM BACPARAMSUDA..LINEA_PRODUCTO
-- select * from VIEW_LINEA_GENERAL
-- select * from VIEW_LINEA_SISTEMA
-- select * from VIEW_LINEA_TRANSACCION
-- select * from VIEW_LINEA_POR_PLAZO
-- select * from 
-- select * from 
-- select * from 
-- select * from 
-- select * from 

GO
