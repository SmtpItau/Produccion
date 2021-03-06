USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CUMPLE_RESTRICCIONES_BAC]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_CUMPLE_RESTRICCIONES_BAC]
   (   @Id_sistema            VarChar(3),  
       @Operacion             NUMERIC(10)       
   )  
AS      
BEGIN   
    SET NOCOUNT ON    
    declare @Msg varchar(200)
    -- POR HACER: 
    -- Validar ajustar lo que se pueda para que
    -- quede con el desnormalizado formato BAC
    -- Select 'NO', 'Problemas'

    -- Validar @Operacion, no puede ser cero
    set @Msg = ''
    if @Operacion = 0 
    begin
       set @Msg = 'Numero Contrato no puede ser cero'
       goto RetornaConError
    end

    -- Campo Tipo_Flujo, prueba interna OK
    declare @Tipo_Flujo varchar(2)
    set  @Tipo_Flujo = 'OK'
    set  @Msg = ''
    select  @Tipo_Flujo = 'NO' , @Msg = 'Tipo Flujo Inválido: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Tipo Flujo:' + convert( varchar(10), Tipo_Flujo ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_flujo <> 1 and tipo_flujo <> 2
    if @Tipo_Flujo = 'NO' 
    begin
       goto RetornaConError
    end

    -- Campo Tipo _Swap, prueba interna OK
    declare @Tipo_Swap varchar(2)
    set  @Tipo_Swap = 'OK'
    set  @Msg = ''
    select  @Tipo_Swap = 'NO' , @Msg = 'Tipo Swap Inválido: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Tipo Swap:' + convert( varchar(10), Tipo_Swap ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_swap not in ( 1,2,4)
    if @Tipo_Swap = 'NO' 
    begin
       goto RetornaConError
    end

    -- Cartera Inversión, prueba interna OK
    declare @Cartera_Inversion varchar(2)
    set  @Cartera_Inversion = 'OK'
    set  @Msg = ''
    select  @Cartera_Inversion = 'NO' , @Msg = 'Cartera Inversion Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Cartera Inversion:' + convert( varchar(10), Cartera_Inversion ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and convert( varchar(1), Cartera_Inversion ) not in ( select tbcodigo1 from bacparamsuda..tabla_general_detalle where tbcateg = 204 )
    if @Cartera_Inversion = 'NO' 
    begin
       goto RetornaConError
    end


    -- Tipo Operacion, prueba interna OK
    declare @Tipo_Operacion varchar(2)
    set  @Tipo_Operacion = 'OK'
    set  @Msg = ''
    select  @Tipo_Operacion = 'NO' , @Msg = 'Tipo Operación Inválido: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Cartera Inversion:' + convert( varchar(10), Tipo_Operacion ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and Tipo_Operacion not in ( 'C', 'V' )
    if @Tipo_Operacion = 'NO' 
    begin
       goto RetornaConError
    end

    -- Compra_Moneda , prueba interna OK
    declare @Moneda varchar(2)
    set @Moneda = 'OK'
    Set @Msg = ''
    select @Moneda = 'NO' , @Msg = 'Moneda Capital Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Compra_Moneda:' + convert( varchar(10), Compra_Moneda ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and Tipo_Flujo = 1 and Compra_Moneda not in ( select mnCodMon from BacParamSuda..moneda )
    if @Moneda = 'NO'
    begin
       goto RetornaConError
    end
    -- Venta_Moneda , prueba interna OK
    set @Moneda = 'OK'
    Set @Msg = ''
    select @Moneda = 'NO' , @Msg = 'Moneda Capital Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Venta_Moneda:' + convert( varchar(10), Venta_Moneda ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and Tipo_Flujo = 2 and Venta_Moneda not in ( select mnCodMon from BacParamSuda..moneda )
    if @Moneda = 'NO'
    begin
       goto RetornaConError
    end
    -- Recibimos_Moneda, prueba interna OK
    set @Moneda = 'OK'
    Set @Msg = ''
    select @Moneda = 'NO' , @Msg = 'Moneda recibimos Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Recibimos_Moneda:' + convert( varchar(10), Recibimos_Moneda ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and Tipo_Flujo = 1 and Recibimos_Moneda not in ( select mnCodMon from BacParamSuda..moneda )
    if @Moneda = 'NO'
    begin
       goto RetornaConError
    end
    -- Pagamos_Moneda, prueba interna OK
    set @Moneda = 'OK'
    Set @Msg = ''
    select @Moneda = 'NO' , @Msg = 'Moneda pagamos Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Pagamos_Moneda:' + convert( varchar(10), Pagamos_Moneda ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and Tipo_Flujo = 2 and Pagamos_Moneda not in ( select mnCodMon from BacParamSuda..moneda )
    if @Moneda = 'NO'
    begin
       goto RetornaConError
    end




    -- Verificaciones amarradas al cliente +++++++++++++++++
    -- Rut en cero, prueba interna OK
    declare @Rut         numeric(13)
    declare @Codigo      numeric(5)
    declare @Metodologia numeric(5)
    select  @Rut = 0, @Codigo = 0    
    select  @Rut = Rut_Cliente, @Codigo = Codigo_Cliente from 
       BacSwapSuda..Cartera where numero_operacion = @Operacion
    if  @Rut = 0 or  @Codigo = 0
    begin
       Set @Msg =   case when @Rut = 0 then     'Rut en cero Cont #:' + convert( varchar(10), @Operacion ) else '' end
                  + case when @Codigo = 0 then  'Codigo en cero Cont #:' + convert( varchar(10), @Operacion ) else '' end 
       goto RetornaConError
    end  
    -- Verificar que exista en BAC, prueba interna OK
    declare @Existe varchar(2)
    Set     @Existe = 'NO'
    select  @Existe = 'SI' from 
       bacParamSuda..Cliente where ClRut = @Rut and ClCodigo = @Codigo
    if  @Existe = 'NO'
    begin
       Set @Msg =  'Cliente no existe Rut:' + convert(varchar(13),@Rut) + ' Cod.:' + convert(varchar(13),@Codigo)  
       goto RetornaConError
    end  
    -- Cliente Tipo FFMM no puede operar Netting, revisión interna OK
    SELECT  @Metodologia =	 ISNULL(Baclineas.dbo.FN_RIEFIN_METODO_LCR( @Rut, @Codigo, @Rut, @Codigo ),1)  
	declare @TipoFFMM varchar(2)
    set     @TipoFFMM = 'N'
    select @TipoFFMM = 'S' from baclineas..cliente_relacionado 
     where (    ClRut_Padre = @Rut and ClCodigo_Padre = @Codigo 
             or ClRut_Hijo = @Rut and ClCodigo_Hijo = @Codigo   )
        and Afecta_Lineas_hijo = 1 -- Tipo FFMM 
    if @TipoFFMM = 'S'  and @Metodologia in ( 2,3,5) 
    begin
       Set @Msg =  'Cliente no puede tener metodologia Netting y ser tipo FFMM Rut:' + convert(varchar(13),@Rut) + ' Cod.:' + convert(varchar(13),@Codigo) 
       goto RetornaConError
    end
    -- Verificaciones amarradas al cliente +++++++++++++++++



    -- Compra_Codigo_Tasa, revisión interna OK
    declare @Codigo_Tasa varchar(2)
    set  @Codigo_Tasa = 'OK'
    set  @Msg = ''
    select  @Codigo_Tasa = 'NO' , @Msg = 'Codigo_Tasa Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Compra Codigo_Tasa:' + convert( varchar(10), Compra_Codigo_Tasa ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 1 
                                   and rtrim( ltrim(convert( varchar(2), Compra_Codigo_Tasa )))  not in ( select rtrim(ltrim(tbcodigo1)) from bacparamsuda..tabla_general_detalle where tbcateg = 1042 )
    if @Codigo_Tasa = 'NO' 
    begin
       goto RetornaConError
    end

    -- Venta_Codigo_Tasa, revisión interna OK    
    set  @Codigo_Tasa = 'OK'
    set  @Msg = ''
    select  @Codigo_Tasa = 'NO' , @Msg = 'Codigo_Tasa Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Venta Codigo_Tasa:' + convert( varchar(10), Venta_Codigo_Tasa ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 2 
                                   and rtrim( ltrim(convert( varchar(2), Venta_Codigo_Tasa )))  not in ( select rtrim(ltrim(tbcodigo1)) from bacparamsuda..tabla_general_detalle where tbcateg = 1042 )
    if @Codigo_Tasa = 'NO' 
    begin
       goto RetornaConError
    end



    -- Compra_Base, revisión interna OK
    declare @Base varchar(2)
    set  @Base = 'OK'
    set  @Msg = ''
    select  @Base = 'NO' , @Msg = 'Base Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Compra Base:' + convert( varchar(10), Compra_Base ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 1 
                                   and convert( numeric(5), Compra_Base )  not in ( select convert(numeric(5), codigo) from BacSwapSuda..Base  )
    if @Base = 'NO' 
    begin
       goto RetornaConError
    end
    -- Venta_Base, revisión interna OK   
    set  @Base = 'OK'
    set  @Msg = ''
    select  @Base = 'NO' , @Msg = 'Base Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Venta Base:' + convert( varchar(10), Venta_Base ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 2 
                                   and convert( numeric(5), Venta_Base )  not in ( select convert(numeric(5), codigo) from BacSwapSuda..Base )
    if @Base = 'NO' 
    begin
       goto RetornaConError
    end


    -- Recibimos_documento, revisión interna OK
    declare @Documento varchar(2)
    set  @Documento = 'OK'
    set  @Msg = ''
    select  @Documento = 'NO' , @Msg = 'Forma de Pago Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Forma de Pago recibimos:' + convert( varchar(10), Recibimos_Documento ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 1 
                                   and convert( Numeric(5), recibimos_documento )  not in ( select convert( numeric(5),codigo) from bacParamSuda..forma_de_pago )
    if @dOCUMENTO = 'NO' 
    begin
       goto RetornaConError
    end
    -- Pagamos_documento, revisión interna OK
    set  @Documento = 'OK'
    set  @Msg = ''
    select  @Documento = 'NO' , @Msg = 'Forma de Pago Inválida: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Forma de Pago Pagamos:' + convert( varchar(10), pagamos_Documento ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 2 
                                   and convert( Numeric(5), pagamos_documento )  not in ( select convert( numeric(5),codigo) from bacParamSuda..forma_de_pago )
    if @dOCUMENTO = 'NO' 
    begin
       goto RetornaConError
    end
 
    -- Codigo de frecuencia de pago de interes compra, revisión interna OK
    declare @codamo_interes varchar(2)
    set @codamo_interes = 'OK'
    select @codamo_interes = 'NO', @msg = 'Codigo Compra frec. pago intereses inválido: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Codigo :' + convert( varchar(10), Compra_codamo_interes )  
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 1 
                                   and convert( Numeric(5), Compra_CodAmo_Interes )  not in ( select convert( numeric(5),codigo) from bacParamSuda..PERIODO_AMORTIZACION where tabla = 1044 )
    if @codamo_interes = 'NO'
    begin
       goto RetornaConError
    end   
    -- Codigo de frecuencia de pago de interes Venta, revisión interna OK
    set @codamo_interes = 'OK'
    select @codamo_interes = 'NO', @msg = 'Codigo Venta frec. pago intereses inválido: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Codigo :' + convert( varchar(10), Venta_codamo_interes )  
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 2 
                                   and convert( Numeric(5), Venta_CodAmo_Interes )  not in ( select convert( numeric(5),codigo) from bacParamSuda..PERIODO_AMORTIZACION where tabla = 1044 )
    if @codamo_interes = 'NO'
    begin
       goto RetornaConError
    end   

    -- Codigo de frecuencia de pago de amortizaciones compra,
    declare @codamo_capital varchar(2)
    set @codamo_capital = 'OK'
    select @codamo_capital = 'NO', @msg = 'Codigo Compra frec. pago amortizacion inválido: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Codigo :' + convert( varchar(10), Compra_codamo_capital )  
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 1 
                                   and convert( Numeric(5), Compra_CodAmo_Capital )  not in ( select convert( numeric(5),codigo) from bacParamSuda..PERIODO_AMORTIZACION where tabla = 1043 )
    if @codamo_capital = 'NO'
    begin
       goto RetornaConError
    end   
    -- Codigo de frecuencia de pago de amortizaciones Venta,
    set @codamo_capital = 'OK'
    select @codamo_capital = 'NO', @msg = 'Codigo Venta frec. pago amortizacion inválido: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Codigo :' + convert( varchar(10), Venta_codamo_Capital )  
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and tipo_Flujo = 2 
                                   and convert( Numeric(5), Venta_CodAmo_Capital )  not in ( select convert( numeric(5),codigo) from bacParamSuda..PERIODO_AMORTIZACION where tabla = 1043 )
    if @codamo_capital = 'NO'
    begin
       goto RetornaConError
    end   

    -- Modalidad de Pago, prueba interna OK
    declare @modalidad_pago varchar(2)
    set  @modalidad_pago = 'OK'
    set  @Msg = ''
    select  @modalidad_pago = 'NO' , @Msg = 'Modalidad Pago Inválido: Cont #:' + convert( varchar(10), Numero_operacion ) + ' Modalidad:' + convert( varchar(10), modalidad_pago ) 
      from BacSwapSuda..Cartera where numero_operacion = @Operacion and modalidad_pago not in ( 'C', 'E' )
    if @modalidad_pago = 'NO' 
    begin
       goto RetornaConError
    end

    -- Fecha de Cierre, 
    declare @fecha_Cierre varchar(2)
    set  @fecha_Cierre = 'OK'
    set  @Msg = ''
    select  @fecha_Cierre = 'NO' , @Msg = 'Fecha Renta Fija: ' + convert( varchar(15), fechaproc, 104 ) + ' Fecha Turing:' + convert( varchar(15), fecha_Cierre, 104 ) 
      from BacSwapSuda..Cartera C
         ,  bacSwapSuda..swapgeneral where C.numero_operacion = @Operacion and fecha_Cierre <> fechaproc
    if @fecha_Cierre = 'NO' 
    begin
       goto RetornaConError
    end
-- select * from bacSwapSuda..swapgeneral



RetornaOK:
    select 'OK', ''
    return
RetornaConError:
    select 'NO', @Msg    
END
-- Revisiones internas
-- select max(numero_operacion) from BacSwapSuda..cartera -- 5349
-- SP_CUMPLE_RESTRICCIONES_BAC 'PCS', 5349
-- select Compra_codamo_capital, venta_codamo_capital, * from cartera where numero_operacion = 5349 
-- Generando errores:
-- Update cartera set Tipo_flujo = 1 where numero_operacion = 5349 and numero_Flujo = 1 and tipo_Flujo <> 2
-- Update cartera set Tipo_Swap = 1 /* 8 */ where numero_operacion = 5349 
-- Update cartera set Cartera_inversion = 1 /* 0 */ where numero_operacion = 5349 
-- Update cartera set tipo_Operacion = 'C' /* X */ where numero_operacion = 5349  
-- Update cartera set compra_moneda = 13 /* 13 */ where numero_operacion = 5349 and tipo_Flujo = 1
-- Update cartera set Venta_moneda = 13 /* 150 */ where numero_operacion = 5349 and tipo_Flujo = 2
-- update cartera set Rut_cliente = 99501480 /* 99501480 */, codigo_Cliente = 1 /*0*/ where numero_operacion = 5349
-- Update bacparamsuda..cliente set ClRecMtdCod = 0 /* 2 */ where clrut = 77750920 and clCodigo = 1
-- update cartera set Rut_cliente = 77750920 /* 99501480 */, codigo_Cliente = 1 /*1*/ where numero_operacion = 5349
-- update cartera set Rut_cliente = 99501480 /* 888887777 */, codigo_Cliente = 1 /*1*/ where numero_operacion = 5349
-- update cartera set compra_codigo_tasa = 6 /* 21 */ where tipo_flujo = 1 and numero_operacion = 5349
-- update cartera set venta_codigo_tasa = 5 /* 21 */ where tipo_flujo = 2 and numero_operacion = 5349
-- update cartera set compra_Base = 2 /* 9 */ where tipo_flujo = 1 and numero_operacion = 5349
-- update cartera set Venta_Base = 2 /* 9 */ where tipo_flujo = 2 and numero_operacion = 5349
-- update cartera set recibimos_moneda = 999 /* 150 */ where tipo_Flujo = 1 and numero_operacion = 5349
-- update cartera set pagamos_moneda = 999 /* 150 */ where tipo_Flujo = 2 and numero_operacion = 5349
-- update cartera set recibimos_documento = 103 /* 888 */ where tipo_Flujo = 1 and numero_operacion = 5349
-- update cartera set pagamos_documento = 103 /* 888 */ where tipo_Flujo = 2 and numero_operacion = 5349
-- update cartera set compra_codamo_interes = 2 /* 0*/ where Tipo_flujo = 1 and numero_operacion = 5349
-- update cartera set Venta_codamo_interes = 2 /* 0*/ where Tipo_flujo = 2 and numero_operacion = 5349
-- update cartera set compra_codamo_capital = 6 /* 0*/ where Tipo_flujo = 1 and numero_operacion = 5349
-- update cartera set Venta_codamo_capital = 6 /* 0*/ where Tipo_flujo = 2 and numero_operacion = 5349
-- update cartera set modalidad_pago = 'E' /* F */    where numero_operacion = 5349

GO
