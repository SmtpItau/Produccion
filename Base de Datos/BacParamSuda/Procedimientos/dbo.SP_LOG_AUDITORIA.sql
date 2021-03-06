USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOG_AUDITORIA]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LOG_AUDITORIA] (@Entidad  CHAR(2) 
     ,@FechaProceso  CHAR(8)
     ,@Terminal  CHAR(15)
     ,@Usuario  CHAR(15)
     ,@Id_Sistema  CHAR(3)
     ,@CodigoMenu  VARCHAR(50) --+++jcamposd 20170619 se cambia de 12 a 50 para poder parear información contra tabla gen_menu
     ,@Codigo_Evento  VARCHAR(2) 
     ,@DetalleTransac  VARCHAR(90)
     ,@TablaInvolucrada VARCHAR(50)
     ,@ValorAntiguo  NTEXT
     ,@ValorNuevo  NTEXT 
     )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @menu    VARCHAR(30)
 DECLARE @evento   VARCHAR(30)
 DECLARE @detalle_final  VARCHAR(250)
 DECLARE @sistema        VARCHAR(30)
 
	SELECT  @evento = descripcion
	FROM  log_evento (NOLOCK)
	WHERE  @Codigo_Evento = codigo_evento
 
	SELECT  @menu   = ISNULL(nombre_opcion,'NO DEFINIDO')
	FROM  gen_menu (NOLOCK)  
	WHERE nombre_objeto =  @CodigoMenu
		AND entidad = @id_sistema
  
	SELECT  @sistema = nombre_sistema 
	FROM  sistema_cnt (NOLOCK) 
	WHERE  id_sistema = @id_sistema
 
	SELECT  @evento  = ISNULL( @evento  , 'EVENTO NO DEFINIDO' )
	SELECT  @menu    = ISNULL( @menu  , 'MENU NO DEFINIDO' )
	SELECT  @sistema = ISNULL( @sistema   , 'SISTEMA NO DEFINIDO' )
 
	-- SELECT  UPPER(RTRIM(@sistema)) , UPPER(RTRIM(@MENU)), UPPER(RTRIM(@EVENTO)) ,UPPER(RTRIM(@DetalleTransac))
	SELECT  @detalle_final = UPPER(RTRIM(@sistema)) + ' ' + UPPER(RTRIM(@menu)) + ' ' + UPPER(RTRIM(@evento)) + ' ' + UPPER(RTRIM(@DetalleTransac))
	-- SELECT @DETALLE_FINAL
	INSERT INTO log_auditoria(  Entidad   ,  
		FechaProceso  ,
		FechaSistema  ,
		HoraProceso  ,
		Terminal  ,
		Usuario   ,
		Id_Sistema  ,
		CodigoMenu  ,
		Codigo_Evento  ,
		DetalleTransac  ,
		TablaInvolucrada ,
		ValorAntiguo  ,
		ValorNuevo 
		)
	VALUES (ISNULL (@Entidad,' ')    ,
		ISNULL (@FechaProceso,' ')  ,
		CONVERT(CHAR(8),getdate(),112)  ,
		CONVERT(CHAR(8),getdate(),108)  ,
		ISNULL (@Terminal,' ')   ,
		ISNULL (@Usuario,' ')    ,
		ISNULL (@id_Sistema,' ')  ,
		ISNULL (SUBSTRING(@CodigoMenu,1,12),' ')  , --+++jcamposd  20170619 por definicion de tabla solo graga 12 caracteres no cumple norma para los codigos actuales
		ISNULL (@Codigo_Evento,' ')  ,
		ISNULL (@detalle_final,' ')  ,
		ISNULL (@TablaInvolucrada,' ')  ,
		ISNULL (@ValorAntiguo,' ')  ,
		ISNULL (@ValorNuevo,' ')
	)
 SELECT 'OK'
 SET NOCOUNT OFF 
END

GO
