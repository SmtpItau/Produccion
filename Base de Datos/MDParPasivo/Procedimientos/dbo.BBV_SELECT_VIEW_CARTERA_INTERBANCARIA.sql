USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VIEW_CARTERA_INTERBANCARIA]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VIEW_CARTERA_INTERBANCARIA]
AS
SELECT Rut_Cartera,Tipo_Cartera,Numero_Operacion,Numero_Documento,Correlativo_Operacion,Rut_Cliente,Codigo_Cliente,
       Serie,Mascara,Nominal,Valor_Compra,Valor_Compra_UM,Tir_Compra,Tasa_Estimada,Codigo,Fecha_Inicio_Pacto,
       Fecha_Vencimiento_Pacto,Valor_Inicial,Valor_Final,Tasa_Pacto,Base_Pacto,Moneda_Pacto,Valor_Presente_Tir_Compra,
       Capital_Compra,Interes_Compra,Reajuste_Compra,Interes_Mes,Reajuste_Mes,Capital_Pacto,Interes_Pacto,
       Reajuste_Pacto,Valor_Presente_Tir_Pacto,Nominal_Pesos,Forma_Pago_Inicio,Forma_Pago_Vencimiento,Dcv,
       Tipo_Cartera_Financiera,Mercado,Sucursal,Id_Sistema,Fecha_PagoMañana,Laminas,Tipo_Inversion,
       Cuenta_Corriente_Inicio,Cuenta_Corriente_Final,Sucursal_Inicio,Sucursal_Final,Estado_Operacion_Linea,
       Valor_Vencimiento,Codigo_Subproducto,Tipo_Operacion,keyid_desk_manager,libro_desk_manager,numero_pu
FROM VIEW_CARTERA_INTERBANCARIA
GO
