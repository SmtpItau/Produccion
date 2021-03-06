USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_AJUSTA_RESTRICCIONES_BAC_EVAL]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AJUSTA_RESTRICCIONES_BAC_EVAL]
   (   @Id_sistema            VarChar(3),  
       @Operacion             NUMERIC(10)       
   )  
AS      
BEGIN   
    SET NOCOUNT ON    
    -- POR HACER: 
    -- Validar ajustar lo que se pueda para que
    -- quede con el desnormalizado formato BAC
    -- Select 'NO', 'Problemas'
    -- SP_AJUSTA_RESTRICCIONES_BAC 'PCS', 5337

    --***************************************************
    -- Actualización del Valor Tasa para las patas fijas
    -- en el flujo que tiene fecha inicio devengo igual
    -- a fecha fin devengo
    --***************************************************
    declare @ValorTasa float
    declare @TasaFija varchar(1)

    -- Tasa de la pata activa
    select  @TasaFija = 'N'
    select  @ValorTasa = 0
    SELECT  @TasaFija = case when Compra_codigo_tasa = 0 then 'S' else 'N' end 
          , @ValorTasa = Compra_valor_tasa
       from Cartera__EVAL 
       where numero_operacion = @Operacion 
         and tipo_flujo = 1 
         and fecha_inicio_flujo <> fecha_vence_Flujo
    if @TasaFija = 'S' 
    begin
        update Cartera__EVAL
		set Compra_Valor_tasa = @ValorTasa 
        where numero_operacion = @Operacion 
         and tipo_flujo = 1 
         and fecha_inicio_flujo = fecha_vence_Flujo
         IF @@ERROR <> 0   
         Begin         
            select 'NO' , 'No se puede actualizar Tasa de Pata Fija Activa'
            return
         end  
       end
    -- Tasa de la pata pasiva
    select  @TasaFija = 'N'
    select  @ValorTasa = 0
    SELECT  @TasaFija = case when Venta_codigo_tasa = 0 then 'S' else 'N' end 
          , @ValorTasa = Venta_valor_tasa
       from Cartera__EVAL 
       where numero_operacion = @Operacion 
         and tipo_flujo = 2 
         and fecha_inicio_flujo <> fecha_vence_Flujo
    if @TasaFija = 'S' 
    begin
        update Cartera__EVAL
		set Venta_Valor_tasa = @ValorTasa 
        where numero_operacion = @Operacion 
         and tipo_flujo = 2
         and fecha_inicio_flujo = fecha_vence_Flujo
         IF @@ERROR <> 0   
         Begin         
            select 'NO' , 'No se puede actualizar Tasa de Pata Fija Pasiva'
            return
         end  

    end 
    --***************************************************
    -- Actualización del Campo Compra_saldo y Venta_Saldo
    --***************************************************
    declare @Flujo              numeric(10)
    declare @CntFlujo           numeric(10)
    declare @NumeroOperacion    numeric(10)
    declare @Tipo_Flujo         numeric(10)
    declare @SaldoFlujoAnterior float
    declare @SaldoFlujo         float
    declare @Amortiza           float

    select @NumeroOperacion = @Operacion

    -- Procesando Flujo Activo
    select @Tipo_Flujo = 1
    select @Flujo      = 1
    select Numero_Flujo, Tipo_Flujo, Compra_Amortiza, Compra_Saldo, Venta_Amortiza, Venta_Saldo  
    into #Cartera
     from Cartera__EVAL 
    where numero_operacion = @NumeroOperacion 
      and tipo_Flujo = @Tipo_Flujo
    --union
    --select Numero_Flujo, Tipo_Flujo, Compra_Amortiza, Compra_Saldo, Venta_Amortiza, Venta_Saldo  
    --   from carterahis
    --where numero_operacion = @NumeroOperacion 
    --  and tipo_Flujo = @Tipo_Flujo

    select @CntFlujo = 0
    select @CntFlujo = max(numero_flujo) 
      from #Cartera 
  
    Set @SaldoFlujoAnterior = 0
    WHILE @Flujo <= @CntFlujo
    Begin
      Select  @Amortiza = Compra_Amortiza from #Cartera
      where numero_flujo = @Flujo
    
      Select  @SaldoFlujo =  @SaldoFlujoAnterior - @Amortiza
     
      update Cartera__EVAL 
         set Compra_Saldo = @SaldoFlujo
         where numero_operacion = @NumeroOperacion
           and Tipo_flujo = @Tipo_Flujo
           and numero_flujo = @flujo
      IF @@ERROR <> 0   
      Begin         
         select 'NO' , 'No se puede actualizar Compra_Saldo Cartera'
         return
      end  

    --update Carterahis 
    --     set Compra_Saldo = @SaldoFlujo
    --     where numero_operacion = @NumeroOperacion
    --       and Tipo_flujo = @Tipo_Flujo
    --       and numero_flujo = @flujo
      IF @@ERROR <> 0   
      Begin         
         select 'NO' , 'No se puede actualizar Compra_Saldo Cartera His'
         return
      end  

      select @SaldoFlujoAnterior = @SaldoFlujo
      select @Flujo = @Flujo + 1
    End
    -- Procesando Flujo Pasivo
    select @Tipo_Flujo = 2
    select @Flujo      = 1
    truncate table #Cartera
    insert into #Cartera
    select Numero_Flujo, Tipo_Flujo, Compra_Amortiza, Compra_Saldo, Venta_Amortiza, Venta_Saldo    
       from Cartera__EVAL 
    where numero_operacion = @NumeroOperacion 
      and tipo_Flujo = @Tipo_Flujo
    --union
    --select Numero_Flujo, Tipo_Flujo, Compra_Amortiza, Compra_Saldo, Venta_Amortiza, Venta_Saldo  
    --   from carterahis
    --where numero_operacion = @NumeroOperacion 
    --  and tipo_Flujo = @Tipo_Flujo

    select @CntFlujo = 0
    select @CntFlujo = max(numero_flujo) 
      from #Cartera 
  
    Set @SaldoFlujoAnterior = 0
    WHILE @Flujo <= @CntFlujo
    Begin

      Select  @Amortiza = Venta_Amortiza from #Cartera
      where numero_flujo = @Flujo

      Select  @SaldoFlujo =  @SaldoFlujoAnterior - @Amortiza
     
      update Cartera__EVAL 
         set Venta_Saldo = @SaldoFlujo
         where numero_operacion = @NumeroOperacion
           and Tipo_flujo = @Tipo_Flujo
           and numero_flujo = @flujo
      IF @@ERROR <> 0   
      Begin         
         select 'NO' , 'No se puede actualizar Venta_Saldo Cartera'
         return
      end  


      --update Carterahis 
      --   set Venta_Saldo = @SaldoFlujo
      --   where numero_operacion = @NumeroOperacion
      --     and Tipo_flujo = @Tipo_Flujo
      --     and numero_flujo = @flujo

      IF @@ERROR <> 0   
      Begin         
         select 'NO' , 'No se puede actualizar Venta_Saldo Cartera His'
         return
      end  
      select @SaldoFlujoAnterior = @SaldoFlujo
      select @Flujo = @Flujo + 1
    End
    drop table #Cartera
    --*******************************************************
    -- Fin Actualización del Campo Compra_saldo y Venta_Saldo
    --*******************************************************

    -- Si llega acá es proque está todo OK
    --select 'OK', ''
    return
END
-- SP_AJUSTA_RESTRICCIONES_BAC "PCS", 555
GO
