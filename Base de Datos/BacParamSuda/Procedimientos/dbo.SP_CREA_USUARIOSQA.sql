USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREA_USUARIOSQA]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CREA_USUARIOSQA]
									   ( @usuario		CHAR(15),
    									 @usuario2		CHAR(15)
									   )
as
begin
	SET NOCOUNT OFF

   /*Asignación Id para Turing (restaca de la tabla usuario)*/
	DECLARE @IDTURING INT
	SELECT	@IDTURING = DBO.FNOBTIENEIDTURING()
	SET     @USUARIO  = UPPER(RTRIM(LTRIM(@USUARIO)))
	SET     @USUARIO2 = UPPER(RTRIM(LTRIM(@USUARIO2)))

	begin
			-->    Asigna los privilegios por tipo, como privilegio por usuario, creando un 'Valor por Defecto'
			IF NOT EXISTS(SELECT 1 FROM GEN_PRIVILEGIOS WHERE usuario = @usuario) 
			BEGIN
					INSERT INTO BacParamSuda.dbo.GEN_PRIVILEGIOS
					SELECT	tipo_privilegio = 'U'
					,		usuario         = @usuario
					,		entidad         = entidad
					,		opcion          = opcion
					,		habilitado      = habilitado
					FROM	BacParamSuda.dbo.GEN_PRIVILEGIOS
					WHERE	usuario         = @USUARIO2
					-- and tipo_privilegio = 'T' 
							

            END

			IF NOT EXISTS(SELECT 1 FROM USUARIO  WHERE usuario = @usuario) 
			BEGIN
					INSERT INTO USUARIO
					SELECT  
							 @usuario				as Usuario
							,b.clave				as clave
							,b.nombre				as nombre
							,b.tipo_usuario			as tipo_usuario
							,b.fecha_expira			as fecha_expira 
							,b.cambio_clave			as cambio_clave
							,b.bloqueado			as bloqueado
							,b.clase				as clase
							,b.clave_anterior1		as clave_anterior1 
							,b.clave_anterior2		as clave_anterior2
							,b.clave_anterior3		as clave_anterior3
							,b.Largo_Clave			as Largo_Clave
							,b.Tipo_Clave			as Tipo_Clave
							,b.Dias_Expiracion		as Dias_Expiracion
							,b.reset_psw			as reset_psw
							,b.Trader				as Trader
							,b.RutUsuario			as RutUsuario
							,b.Clave_Anterior4		as Clave_Anterior4
							,b.Clave_Anterior5		as Clave_Anterior5
							,b.codigomesa			as codigomesa
							,b.email				as email
							,b.IdTuring				as IdTuring
							,b.usuario_original		as usuario_original
					FROM USUARIO B
					WHERE B.USUARIO = @USUARIO2 
	
			END

			IF NOT EXISTS(SELECT 1 FROM CONTROL_USUARIO WHERE usuario = @usuario )---AND id_sistema = @sistema ) 
			begin 
						insert into CONTROL_USUARIO
						select  @Usuario				as Usuario
						,		b.id_sistema			as id_sistema
						,		b.nombre				as nombre
						,		b.terminal				as terminal
						,		b.bloqueado				as bloqueado
						from   CONTROL_USUARIO b
						where  b.Usuario = @Usuario2
			END

			---> ini.GRABAR MATRIZ DE ATRIBUCIONES
			IF NOT EXISTS (SELECT 1 FROM MATRIZ_ATRIBUCION WHERE Usuario= @usuario)
			BEGIN
						--delete from BACPARAMSUDA.DBO.MATRIZ_ATRIBUCION where usuario	= @usuario	--AND codigo_producto	= @codigo_producto
						insert into BACPARAMSUDA.DBO.MATRIZ_ATRIBUCION
						select  @Usuario					as Usuario
						,		b.Codigo_Producto			as Codigo_Producto
						,		b.Plazo_Desde				as Plazo_Desde
						,		b.Plazo_Hasta				as Plazo_Hasta
						,		b.MontoInicio				as MontoInicio
						,		b.MontoFinal				as MontoFinal
						from   BACPARAMSUDA.DBO.MATRIZ_ATRIBUCION b
						where  b.Usuario = @Usuario2
			end

			IF NOT EXISTS (SELECT 1 FROM BACLINEAS.DBO.MATRIZ_ATRIBUCION_INSTRUMENTO WHERE USUARIO IN (SELECT a.Usuario FROM BACLINEAS.DBO.MATRIZ_ATRIBUCION_INSTRUMENTO a where Usuario= @usuario))
			BEGIN
						insert into BACLINEAS.DBO.MATRIZ_ATRIBUCION_INSTRUMENTO
						select 
								@Usuario					AS USUARIO,
								b.Id_Sistema				AS Id_Sistema,
								b.Codigo_Producto			AS Codigo_Producto,
								b.Plazo_Desde				AS Plazo_Desde,
								b.Plazo_Hasta				AS Plazo_Hasta,
								b.Monto_Maximo_Operacion	AS Monto_Maximo_Operacion,
								b.Monto_Maximo_Acumulado	AS Monto_Maximo_Acumulado,
								b.Acumulado_Diario			AS Acumulado_Diario
						from baclineas.dbo.MATRIZ_ATRIBUCION_INSTRUMENTO b 
						where usuario = @usuario2 --'Rnavarrete'
			END

			IF NOT EXISTS (SELECT 1 FROM BACLINEAS.DBO.MATRIZ_ATRIBUCION WHERE USUARIO IN (SELECT a.Usuario FROM BACLINEAS.DBO.MATRIZ_ATRIBUCION a where Usuario= @usuario))
			BEGIN
						insert into BACLINEAS.DBO.MATRIZ_ATRIBUCION
						select 
								 @Usuario					 as USUARIO
								,b.MONTO                     AS MONTO
								,b.APRUEBA_LINEA			 as APRUEBA_LINEA
								,b.APRUEBA_LIMITE			 as APRUEBA_LIMITE
								,b.APRUEBA_TASA				 as APRUEBA_TASA
								,b.APRUEBA_GLB				 as APRUEBA_GLB
								,b.APRUEBA_LIMPRECIO		 as APRUEBA_LIMPRECIO
								,b.APRUEBA_BLOQCLT			 as APRUEBA_BLOQCLT
						from   BACLINEAS.DBO.MATRIZ_ATRIBUCION b
						where  b.Usuario = @Usuario2
					---> fin.GRABAR MATRIZ DE ATRIBUCIONES
			END


			IF NOT EXISTS (SELECT 1 FROM BACLINEAS.dbo.PERFIL_USUARIO_LINEAS WHERE USUARIO IN (SELECT a.Usuario FROM BACLINEAS.dbo.PERFIL_USUARIO_LINEAS a where Usuario= @Usuario))
			begin
						insert into BACLINEAS.dbo.PERFIL_USUARIO_LINEAS
						select  @Usuario					as Usuario 
						,		b.Sistema					as Sistema
						,		b.Lin_Inst_Financiera		as Lin_Inst_Financiera 
						,		b.Lin_Otra_Instirucion		as Lin_Otra_Instirucion
						,		b.Impresion_Papelteas		as Impresion_Papelteas
						,		b.Monitor_Operaciones		as Monitor_Operaciones
						,		b.Liberacion_Operaciones	as Liberacion_Operaciones
						,		b.Producto					as Producto
						,		b.Tipo_Cliente				as Tipo_Cliente
						,		b.Activado					as Activado  
						from   BACLINEAS.dbo.PERFIL_USUARIO_LINEAS b
						where  b.Usuario = @Usuario2
						-- and   (b.Sistema = 'BTR' or 'BTR' = '')---@Sistema or @Sistema = '')
						order by b.Usuario, b.Sistema, b.Producto, b.Tipo_Cliente
			END

			IF @@ERROR <> 0
				BEGIN
					PRINT 'ERROR_PROCEDIMIENTO FALLA AGREGANDO USUARIO-QA.'
					return 1
				END
			END

RETURN 0
end
GO
