USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEMO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE procedure [dbo].[SP_LEEMO]
            (@emnombre1 char (25))
as
begin   
         set nocount on
 if @emnombre1=''
    begin
         set nocount off
      select distinct
      mncodmon,
      mnglosa,
             mnnemo,
      b.vmposini,
             b.vmposic,
             b.vmparidad,
             b.vmtotco,
             b.vmtotve
     
      from VIEW_MONEDA  a,  VIEW_VALOR_MONEDA b where a.mncodmon = b.vmcodigo  
      order by mnglosa
    end
 else 
    begin
      declare @codmon numeric(10)
      select @codmon=mncodmon 
      from VIEW_MONEDA  
      where mnglosa=@emnombre1
      set nocount off 
      select a.mnnemo,
             a.mnglosa,
             a.mncodsuper,
             b.vmposini,
             b.vmparidad,
             a.mncodpais,
             b.vmposic,
             b.vmtotco,
             b.vmtotve  
      from VIEW_MONEDA  a, VIEW_VALOR_MONEDA b 
      where a.mncodmon = @codmon and b.vmcodigo = @codmon
      order by a.mnglosa
    end
end  


GO
