USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [bacuser].[Sp_Cartera_Cuenta]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [bacuser].[Sp_Cartera_Cuenta]
   (   @Fec     DATETIME
   ,   @Usuario VARCHAR(15)
   )  
AS 
BEGIN

 
    declare @ValorCLP float
     select  @ValorCLP = 0

     
     declare @fecFinEspe datetime

     set nocount ON

     -- Pendiente aplicar codigo fin de mes especial, ver interfaz NEOSOFT
     select  @fecFinEspe = case when @Fec = '20080530' then '20080531' 
                                when @Fec = '20080829' then '20080831' 
                                when @Fec = '20081128' then '20081130' 
                                else @Fec end 

     select CodProducto = tipo_swap,
       Producto = Prod.descripcion, 
       Pierna   = 'ACTIVA',
       MdaCod   = Compra_moneda , 
       Moneda   = Mda.MNGLOSA , 
       numero_operacion , 
       Capital_Vigente = compra_saldo + compra_amortiza , 
       Capital_Vigente_CLP = @ValorCLP,
       Cuenta_98 = '                  ',
       Cuenta_99 = '                  ',
       StrFiltro = '%'+ convert(char(1), tipo_swap ) + '%'
     into #CarteraContable
     from carteraRES , view_moneda Mda, view_producto Prod
     where 
         Mda.MNCODMON = compra_moneda 
     and Prod.codigo_producto = tipo_swap
     and estado_flujo = 1 and tipo_Flujo = 1 
     and estado <> 'C'
     and fecha_proceso = @fec

     insert into #CarteraContable
     select 
       CodProducto = tipo_swap,
       Producto = Prod.descripcion, 
       Pierna   = 'PASIVA', -- Relevante solo para los CCS.
       MdaCod   = Venta_moneda , 
       Moneda   = Mda.MNGLOSA , 
       numero_operacion , 
       Capital_Vigente =Venta_saldo + Venta_amortiza , 
       Capital_Vigente_CLP = @ValorCLP,
       Cuenta_98 = '                  ',
       Cuenta_99 = '                  ',
       StrFiltro = '%'+ convert(char(1), tipo_swap ) + '%'
     from carteraRES , view_moneda Mda, view_producto Prod
     where  
        Mda.MNCODMON = venta_moneda 
     and Prod.codigo_producto = tipo_swap
     and estado_flujo = 1 and tipo_Flujo = 2 and tipo_swap = 2
     and estado <> 'C'
     and fecha_proceso = @fec



     select vmcodigo = Codigo_Moneda, vmvalor = Tipo_Cambio 
     Into #Valor_moneda 
     from BacParamsuda..VALOR_MONEDA_CONTABLE where fecha = @fec

     insert into #Valor_moneda
     select vmcodigo , vmvalor from BacParamsuda..VALOR_MONEDA where vmfecha = @fecFinEspe and vmcodigo = 998


     --select 'debug', * from #Valor_moneda where  vmcodigo = 998

     delete #Valor_moneda where vmcodigo = 999 -- por si alguien ingresa el valor del CLP en CLP ¿?

     insert into #Valor_moneda
     select 999 , 1 


     update #CarteraContable
        set Capital_Vigente_CLP = Capital_Vigente * vmvalor
      from #Valor_moneda where vmcodigo = ( case when MdaCod = 13 then 994 else MdaCod end )


     update #CarteraContable
       set Cuenta_98 = isnull( ( select max(codigo_cuenta) from 
                   bacparamSuda..PerfiL_detalle_cnt As Det, bacparamSuda..PerfiL_cnt  As ENc 
                   where Det.Folio_Perfil = Enc.Folio_Perfil
                      and Det.tipo_movimiento_cuenta = 'D' 
                      and Enc.id_sistema = 'PCS' and Enc.tipo_movimiento = 'MOV' 
                      and convert( char(3), #CarteraContable.MdaCod ) = Enc.moneda_instrumento 
                      and (    tipo_operacion like strFiltro and CodProducto <> 2 
                            or tipo_Operacion = ( case when pierna = 'PASIVA' then '2V' else '2C' end ) and CodProducto = 2  )
                            )
                            , 'NO SE ENCONTRO' ) ,

      Cuenta_99 = isnull( ( select max(codigo_cuenta) from 
                   bacparamSuda..PerfiL_detalle_cnt As Det, bacparamSuda..PerfiL_cnt  As ENc 
                   where Det.Folio_Perfil = Enc.Folio_Perfil
                      and Det.tipo_movimiento_cuenta = 'H' 
                      and Enc.id_sistema = 'PCS' and Enc.tipo_movimiento = 'MOV' 
                      and convert( char(3), #CarteraContable.MdaCod ) = Enc.moneda_instrumento 
                      and (    tipo_operacion like strFiltro and CodProducto <> 2 
                            or tipo_Operacion = ( case when pierna = 'PASIVA' then '2V' else '2C' end ) and CodProducto = 2  )
                            )
                          , 'NO SE ENCONTRO' )

     select *, FechaCierre= @Fec from #CarteraContable

END
GO
