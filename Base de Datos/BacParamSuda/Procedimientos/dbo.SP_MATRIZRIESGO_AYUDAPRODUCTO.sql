USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_AYUDAPRODUCTO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_AYUDAPRODUCTO]
as begin
set nocount on
select * from PRODUCTO where id_Sistema='BFW' order by codigo_producto 
set nocount off
end

GO
