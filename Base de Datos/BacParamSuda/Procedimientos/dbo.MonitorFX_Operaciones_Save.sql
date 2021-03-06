USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[MonitorFX_Operaciones_Save]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MonitorFX_Operaciones_Save]
											   (
												@idArchivo  smallint
											   ,@Oper_dFecha  datetime
											   ,@Oper_Hora  varchar(20)
											   ,@Oper_sCodComprador varchar(3)
											   ,@Oper_sNemoComprador varchar(4)
											   ,@Oper_sCodVendedor varchar(3)
											   ,@Oper_sNemoVendedor varchar(4)
											   ,@Oper_fMontoOrigen float
											   ,@Oper_fPrecio float
											   ,@Oper_sOperacion varchar(1)
											   ,@Oper_sNula varchar(3)
											   ,@Oper_sEquivalencia varchar(20)
											   ,@Oper_sIdentificacion varchar(20)
											   ,@Oper_sCliente varchar(30)
											   ,@Oper_sUsuario varchar(30)
											   ,@Oper_sContraparte varchar(30)
											   ,@Oper_sMercado varchar(3)
											   )

AS 
BEGIN 
		INSERT INTO dbo.MonitorFX_TblOperaciones
				   (idArchivo
				   ,Oper_dFecha
				   ,Oper_Hora
				   ,Oper_sCodComprador
				   ,Oper_sNemoComprador
				   ,Oper_sCodVendedor
				   ,Oper_sNemoVendedor
				   ,Oper_fMontoOrigen
				   ,Oper_fPrecio
				   ,Oper_sOperacion
				   ,Oper_sNula
				   ,Oper_sEquivalencia
				   ,Oper_sIdentificacion
				   ,Oper_sCliente
				   ,Oper_sUsuario
				   ,Oper_sContraparte
				   ,Oper_sMercado)
			 VALUES
				   (
					@idArchivo
				   ,@Oper_dFecha
				   ,@Oper_Hora
				   ,@Oper_sCodComprador
				   ,@Oper_sNemoComprador
				   ,@Oper_sCodVendedor
				   ,@Oper_sNemoVendedor
				   ,@Oper_fMontoOrigen
				   ,@Oper_fPrecio
				   ,@Oper_sOperacion
				   ,@Oper_sNula
				   ,@Oper_sEquivalencia
				   ,@Oper_sIdentificacion
				   ,@Oper_sCliente
				   ,@Oper_sUsuario
				   ,@Oper_sContraparte
				   ,@Oper_sMercado
					)
END

GO
