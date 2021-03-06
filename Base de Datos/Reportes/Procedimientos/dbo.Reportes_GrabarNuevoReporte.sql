USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_GrabarNuevoReporte]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reportes_GrabarNuevoReporte]



(
@id int,
@descripcion nvarchar(50),

@nombre nvarchar(50),

--@ruta nvarchar(255),

@archivo nvarchar(50),

@id_grupo int,

@id_subgrupo int,

@id_conexion int,

@mail int,

@asunto nvarchar(200),

@body nvarchar(500))



AS

Insert	into REPORTES

				(Id_Reporte,

				descripcion,

				Nombre,

				--Ruta,

				Nombre_Archivo,

				Id_Grupo,

				Id_SubGrupo,

				Id_Conexion,

				Metodo,

				Visible,

				PermiteMail,

				Mail_asunto,

				Mail_Body) 

		values	(@id, @descripcion, @nombre, @archivo, @id_grupo, @id_subgrupo, @id_conexion, null, 1, @mail, @asunto, @body)
GO
