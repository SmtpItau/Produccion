USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSFAMCLASREN]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONSFAMCLASREN]
as
begin
 select irdfamilia ,
  irdserie ,
  irdplres
 from MDIRD
 return
end
-- select * from MDIRD
-- sp_consfamclasren

GO
