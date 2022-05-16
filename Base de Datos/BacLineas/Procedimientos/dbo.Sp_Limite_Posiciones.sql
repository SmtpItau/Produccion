USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Limite_Posiciones]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






create proc [dbo].[Sp_Limite_Posiciones]
as
begin
select ACMININTRADAY, ACMAXINTRADAY, ACMINOVERNIGHT, ACMAXOVERNIGHT,VMPOSINI,VMPOSIC  
from view_meac, POSICION_SPT where convert(char(8),vmfecha,112) = acfecpro and vmcodigo = "USD"
end






GO
