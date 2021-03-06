USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENTABILIDAD]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[SP_RENTABILIDAD]
        ( @negocio numeric(2) = 0 )  -- segun meneg , 0=consolidado
as
begin
set nocount on
     select distinct
            b.vmcodigo,
            b.vmposini,
            b.vmposic,
            b.vmpmeco,
            b.vmpmeve,
            b.vmtotco,
            b.vmtotve,
            round(b.vmutili,0),
            b.vmprecierre,
            b.vmpreini,
            b.vmparidad
       FROM MEAC   ,
            VIEW_POSICION_SPT  B
      where convert(char(8),b.vmfecha,112) = convert(char(8),acfecpro,112)
        and b.vmnegocio = @negocio
      order by b.vmcodigo
set nocount off
end



GO
