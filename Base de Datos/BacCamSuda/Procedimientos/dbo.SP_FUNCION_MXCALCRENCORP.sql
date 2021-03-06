USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FUNCION_MXCALCRENCORP]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FUNCION_MXCALCRENCORP](
                                           @aux_motipope char(1)
                      ,@aux_mocodmon char(3)
       ,@aux_moticam  numeric(19,4)
       ,@aux_motctra  numeric(19,4)
                                          ,@aux_moparme  numeric(19,8)  
                                          ,@aux_mopartr  numeric(19,8)
                                          ,@aux_momonmo  numeric(19,4) 
       ,@aux_moussme  numeric(19,4)
                                          ,@aux_xUticoCP numeric(19,4) out
                                          ,@aux_xUtiveCP numeric(19,4) out
      )
AS
BEGIN
SET NOCOUNT ON
Declare @aux_mnnemo char(4)
declare @nParme    numeric(19,8)
declare @nParTr    numeric(19,8)
declare @nRentab  numeric(19,8)   
declare @aux_valor_moneda numeric(19,4)
declare @codigomoneda     numeric(5)
SET @codigomoneda  = isnull(@codigomoneda,(SELECT mncodmon  from VIEW_MONEDA  where mnnemo = @Aux_Mocodmon)) 
SET @aux_valor_moneda  = (SELECT vmvalor from VIEW_VALOR_MONEDA , meac WHERE vmcodigo = @codigomoneda  and ACFECPRO = vmfecha )
set @aux_xUtiveCP = 0
set @aux_xUticoCP = 0
If @aux_valor_moneda <> 0 and @aux_valor_moneda  < 0 Begin 
   select -1 'Error Grave Falta Moneda'
   
   set @nParme = @aux_moparme
   set @nParTr = @aux_mopartr
End Else Begin 
   set @nParme = Round((1 / @aux_moparme),4)
   set @nParTr = Round((1 / @aux_mopartr ),4)
End
If @aux_motipope ='C' Begin 
   set @nRentab  = ( @aux_motctra /  @aux_mopartr  )-( @aux_moticam / @nParme )
   set @aux_xUticoCP = @aux_xUticoCP + ( @nRentab - @aux_moussme ) 
  End Else Begin 
   set @nRentab  = ( @aux_moticam / @aux_moparme )-( @aux_motctra -  @nParTr  )
   set @aux_xUtiveCP = @aux_xUtiveCP + ( @nRentab * @aux_moussme )
End
End

GO
