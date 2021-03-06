USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_cnt_listainstrumentos]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_cnt_listainstrumentos]
   (    @paresid_sistemas	CHAR(03)   
   ,	@paresIdMovimiento	VARCHAR(10) = '' 
   )
as
begin

	set nocount on

	DECLARE @varorginstrumentos		CHAR(60)
	DECLARE @vardatainstrumentos	CHAR(60)
	DECLARE @cFiltroBtr				CHAR(160)

	-->	Se agrego para Garantias
	if @paresid_sistemas = 'btr' and @paresIdMovimiento = 'gar'
	begin
		select	inserie	= 'EFE   -',	inglosa	= 'EFECTIVO'	union
		select	inserie	= 'VAL   -',	inglosa	= 'VALORES'
		return
	end
	-->	Se agrego para Garantias


	IF @paresid_sistemas <> 'BTR'
	BEGIN
		IF EXISTS( SELECT * FROM PRODUCTO_CNT WHERE id_sistema = @paresid_sistemas )
		BEGIN
			SELECT	@varorginstrumentos		= origen_instrumentos
				,	@vardatainstrumentos	= datos_instrumentos
			FROM	PRODUCTO_CNT			with(nolock)
			WHERE	id_sistema				= @paresid_sistemas

			IF @varorginstrumentos <> '' OR @vardatainstrumentos <> ''
				EXECUTE ('SELECT ' + @vardatainstrumentos + ' FROM ' + @varorginstrumentos)
		END ELSE
			SELECT 'NO HAY DATOS'
	END ELSE
	BEGIN
		SELECT @cFiltroBtr = 'incodigo<>600 AND incodigo<>601 AND incodigo<>602 AND incodigo<>603 AND incodigo<>700 AND incodigo<>701 AND incodigo<>702 AND incodigo<>703'

		IF EXISTS(SELECT * FROM PRODUCTO_CNT WHERE id_sistema=@paresid_sistemas)
		BEGIN
			SELECT	@varorginstrumentos		= origen_instrumentos
				,	@vardatainstrumentos	= datos_instrumentos
			FROM	PRODUCTO_CNT			with(nolock)
			WHERE	id_sistema				= @paresid_sistemas

			IF @varorginstrumentos <>'' OR @vardatainstrumentos <>''
				EXECUTE ('SELECT ' + @vardatainstrumentos + ' FROM ' + @varorginstrumentos + ' WHERE ' + @cFiltroBtr)

		END ELSE
			SELECT 'NO HAY DATOS'
	END

end
GO
