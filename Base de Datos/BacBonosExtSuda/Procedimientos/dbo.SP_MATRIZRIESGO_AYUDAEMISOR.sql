USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MATRIZRIESGO_AYUDAEMISOR]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MATRIZRIESGO_AYUDAEMISOR]
as begin
set nocount on
select * from view_tabla_general_detalle where tbcateg = 210
set nocount off
end

GO
