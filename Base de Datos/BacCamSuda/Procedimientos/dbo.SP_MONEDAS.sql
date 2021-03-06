USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MONEDAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_MONEDAS] 
as
begin   
set nocount on
     select distinct a.mnnemo,
                     a.mnglosa,
                     a.mncodmon,
                     b.vmparidad,
               b.vmposini   
     from VIEW_VALOR_MONEDA b, VIEW_MONEDA a 
    where b.vmcodigo = a.mncodmon  
    order by mnglosa
set nocount off
end
GO
