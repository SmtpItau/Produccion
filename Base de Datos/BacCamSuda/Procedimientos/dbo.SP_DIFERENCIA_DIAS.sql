USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DIFERENCIA_DIAS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DIFERENCIA_DIAS] ( @aux_motipope char(1)
                                     ,@aux_moentre  numeric(2)
                                     ,@aux_morecib  numeric(2)
                                    )
AS
BEGIN
declare @aux_xfecctb datetime
declare @xcodigo     numeric(2)
declare @xfecpro     datetime
declare @xdia        numeric(3) 
/*=============================================================================================*/
Set @xfecpro = isnull(@xfecpro,(select acfecpro from meac))
If @aux_motipope = 'C' begin 
    set   @xcodigo = @aux_moentre  
  end else begin  
    set   @xcodigo = @aux_morecib
End
set @xdia = (select diasvalor from bacparamsuda..FORMA_DE_PAGO where codigo = @xcodigo and cc2756 = 'N')
set @xdia = isnull(@xdia,'0')  
if @xdia <> 0 begin 
   set @xfecpro = DATEADD(day, @xdia, @xfecpro)
  end ELSE begin 
   set @xfecpro = 0 
end
End

GO
