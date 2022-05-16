USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FORMASDEPAGO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FORMASDEPAGO]
as
begin
declare @xvalevista  numeric(10),
 @xvalecamara  numeric(10)
select @xvalevista = folio from GEN_FOLIOS where codigo = 'VISTA'
select @xvalecamara= folio from GEN_FOLIOS where codigo = 'CAMARA'
select @xvalevista,@xvalecamara
end
--insert into GEN_FOLIOS values('vista',2)
--insert into GEN_FOLIOS values('camara',3)

GO
