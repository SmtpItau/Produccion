USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGA_LISTAS5]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_CARGA_LISTAS5]
as
begin
 select   comercio
  ,concepto
  ,glosa
 from BACPARAMsuda..CODIGO_COMERCIO
end



GO
