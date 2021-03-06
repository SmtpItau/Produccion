USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_CORTES_CAPTACION]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE 
[dbo].[SP_GRABA_CORTES_CAPTACION](
  @ctipo_operacion  char(03) ,
  @nnumero_operacion  numeric(10,0) ,
  @ncortes      numeric(5,0) ,
  @nmonto_corte  float  ,
  @nmonto_inicio          float  ,   
  @nmonto_inicio_pesos    float  ,   
  @nmonto_final           float    )
as
begin
 begin transaction
 insert into 
 GEN_CORTES_CAPTACION
  (
  tipo_operacion   ,
  numero_operacion  ,
  cortes      ,
  monto_corte             ,
  monto_inicio  ,
  monto_inicio_pesos ,
  monto_final
  )
 values
  (
  @ctipo_operacion  ,
  @nnumero_operacion  ,
  @ncortes      ,
  @nmonto_corte           ,   
  @nmonto_inicio          ,   
  @nmonto_inicio_pesos    ,   
  @nmonto_final               
  )
 if @@error<> 0 
 begin
  rollback transaction  
  SELECT 'NO', 'PROBLEMAS EN GRABACI¢N DE OPERACI¢N DE CAPTACI¢N'
  return
 end
 commit transaction 
 SELECT 'SI', 'OPERACI¢N GRABADA SATISFACTORIAMENTE'
end
/*
 sp_help gen_captacion
 tipo_operacion,numero_operacion,cortes,monto_corte,monto_inicio,monto_inicio_pesos,monto_final
*/

GO
