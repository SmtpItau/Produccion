USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_DISPONIBLE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_DISPONIBLE]
as
begin
select distinct
       monumoper, 
--       mocorrela, 
       clnombre , 
       motipoper
      from MDDI,MDMO,VIEW_CLIENTE 
      where dinumdocu = monumdocu 
        and morutcli  = clrut
        and mocodcli  = clcodigo
      and (motipoper = 'CP' or motipoper = 'CI')   
end
--SP_BUSCA_DISPONIBLE


GO
