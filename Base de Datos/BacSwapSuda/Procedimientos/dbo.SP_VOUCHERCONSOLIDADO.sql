USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VOUCHERCONSOLIDADO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_VOUCHERCONSOLIDADO] (
@cfecha as char(8))
AS
BEGIN

SET NOCOUNT ON

	IF EXISTS( SELECT *
		   FROM Centraliza_Voucher 
		   WHERE @cfecha=convert(char(08),FechaContable,112)  		   
		  )
		BEGIN

			SELECT 	Numero_Voucher,
				    Correlativo,
                    Cuenta,  
                    Glosa,  
				    Moneda_perfil,
				    Folio_Perfil,
                    Tipo_Monto,  
				    Monto,
				    Moneda,
				    Operacion,
				    --Nombre,
					Nombre = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),
				    Rut,
                    Digito,  
				    ObsDia,
				    UFDia,
                    Nombre_Cliente,  
                    Direccion_Cliente,  
				    Rut_Cliente,
                    Digito_Cliente,  
				    Fecha_Proceso,
                    Glosa_Cuenta,  
				    Codigo_producto,
                    Tipo_Mov,  
                    Fecha_Inicio,  
                    Fecha_Vcto,  
                    OP,  
                    T,  
				    MonSuper,
                    fechacontable,
				convert(char(8), GETDATE(),114)
				--'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales) 
			FROM 	Centraliza_Voucher 
			WHERE 	@cfecha=convert(char(08),FechaContable,112)  
			ORDER BY Folio_Perfil ,Numero_Voucher,correlativo 
		END

	ELSE
		BEGIN
			SELECT	Numero_Voucher 		= 0					,
				    Correlativo    		= 0 					,
                    Cuenta           = ''     ,  
                    Glosa   = ''     ,  
				    Moneda_perfil		= 0					,
				    Folio_Perfil 		= 0					,
                    Tipo_Monto   = ''     ,  
				    Monto			= 0					,
				    Moneda 			= 0					,
				    Operacion		= 0					,
				    Nombre = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),
				    Rut			= 0					,
                    Digito    = ''     ,  
				    ObsDia          	= 0					,
				    UFDia           	= 0					,
                    Nombre_Cliente  = ''     ,  
                    Direccion_Cliente = ''     ,  
				    Rut_Cliente		= 0					,
                    Digito_Cliente   = ''     ,  
				    Fecha_Proceso 		= CONVERT(CHAR(10), fechaproc,103)	,
                    Glosa_Cuenta  = ''     ,  
				    Codigo_producto 	= 0					,
                    Tipo_Mov   = ''     ,  
                    Fecha_Inicio   = ''     ,  
                    Fecha_Vcto   = ''     ,  
                    OP      = ''     ,  
                    T   = ''     ,  
				    MonSuper		= 0					,
                    fechacontable  = '',  
				    convert(char(8), GETDATE(),114)
	               -- 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
		       FROM swapgeneral
		END

SET NOCOUNT OFF

END
GO
