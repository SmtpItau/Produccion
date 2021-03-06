USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_DATOS_GENERALES]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_DATOS_GENERALES]
AS
SELECT Rut_Entidad,Digito_Entidad,Nombre_Entidad,Codigo_Entidad,Direccion_Entidad,Comuna_Entidad,Ciudad_Entidad,
       Fono_Entidad,Fax_Entidad,Fecha_Proceso,Fecha_Anterior,Fecha_Proxima,Numero_Operacion_Btr,Numero_Operacion_Swp,
       Numero_Operacion_Inv,Numero_Operacion_Fwd,Numero_Operacion_Spt,Numero_Operacion_Spt_Planilla,
       Numero_Operacion_Spt_Swift,Numero_Operacion_Pas,Max_Papeletas,Clave_DCV,Plazo_UF,Plazo_DO,Plazo_$$,
       Dias_Renovacion,Canasta_Credito_Hoy,Canasta_Credito_Yes,Computable_Debito_Hoy,Computable_Debito_Yes,
       Computable_Credito_Hoy,Computable_Credito_Yes,Tiempo_Otc,Rut_Bcch,Codigo_Pais,Codigo_Plaza,Capital_Reserva,
       Capital_Basico,Moneda_Control,Valor_Moneda,Numero_Traspaso,Porcen_Con_Riesgo,Porcen_Sin_Riesgo,Porcen_Invext,Monto_Con_Riesgo,Monto_Sin_Riesgo,Invext_Total,Invext_Ocupado,Invext_Disponible,Invext_Exceso,Primer_Tramo,Segundo_Tramo,Tercer_Tramo,Margen_Institucion,Total_Cartera_Lchr,Total_Por_Folio,Caja_Pesos,Caja_Bcch,Total_Inversiones,Dias_Pactado_Papel_No_Central,Codigo_Area,Limite_Inversion_Cartera_Asignado,Limite_Inversion_Cartera_Ocupado,Estado_Reajuste,total_cartera_lchr_ocupado
FROM DATOS_GENERALES
GO
