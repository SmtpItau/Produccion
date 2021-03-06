USE [BacParamSuda]
GO
/****** Object:  View [dbo].[view_linea_producto]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create VIEW [dbo].[view_linea_producto]
as
select 
 Rut_Cliente
 ,Codigo_Cliente
 ,Id_Sistema
 ,Codigo_Producto 
 ,TotalAsignado   
 ,TotalOcupado    
 ,TotalDisponible 
 ,TotalExceso     
 ,TotalTraspaso   
 ,TotalRecibido   
 ,SinRiesgoAsignado 
 ,SinRiesgoOcupado  
 ,SinRiesgoDisponible
 ,SinRiesgoExceso    
 ,ConRiesgoAsignado  
 ,ConRiesgoOcupado   
 ,ConRiesgoDisponible
 ,ConRiesgoExceso    
from bacparamsuda..LINEA_PRODUCTO

GO
