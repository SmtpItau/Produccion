USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_LISTAS6]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_CARGA_LISTAS6]
as
begin
 select 0
  ,isnull(clcodban,0)
  ,clgeneric
  ,clnombre
 from BACPARAMsuda..TBINSTITUCIONESFINANCIERAS
end



GO
