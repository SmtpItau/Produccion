USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITE_POSICIONES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LIMITE_POSICIONES]
as
begin
select ACMININTRADAY, ACMAXINTRADAY, ACMINOVERNIGHT, ACMAXOVERNIGHT,VMPOSINI,VMPOSIC  
from view_meac, POSICION_SPT where convert(char(8),vmfecha,112) = acfecpro and vmcodigo = 'USD'
end

GO
