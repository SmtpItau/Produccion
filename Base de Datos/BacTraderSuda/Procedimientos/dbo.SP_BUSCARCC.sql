USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCARCC]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCARCC]
                  
as
begin
set nocount on
   select tbglosa from VIEW_TABLA_GENERAL_DETALLE where tbcateg=180 and  tbglosa  like  '%CHILE%'    
   
end


GO
