USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOG_AUDITORIA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LOG_AUDITORIA] 
               (  @Entidad		CHAR(2)
               ,  @FechaProceso		CHAR(8)
               ,  @Terminal		CHAR(15)
               ,  @Usuario		CHAR(15)
               ,  @Id_Sistema		CHAR(3)
               ,  @CodigoMenu		VARCHAR(12)
               ,  @Codigo_Evento	VARCHAR(2)
               ,  @DetalleTransac	VARCHAR(90)
               ,  @TablaInvolucrada	VARCHAR(50)
               ,  @ValorAntiguo		NTEXT
               ,  @ValorNuevo		NTEXT
	        )
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @menu   	VARCHAR(30)
	,       @evento  	VARCHAR(30)
	,       @detalle_final  VARCHAR(250)
	,       @sistema        VARCHAR(30)

	  SELECT @evento = descripcion
	    FROM VIEW_LOG_EVENTO
	   WHERE @Codigo_Evento = codigo_evento

	 SELECT @menu   = ISNULL(nombre_opcion,'NO DEFINIDO')
	   FROM VIEW_GEN_MENU
	  WHERE @CodigoMenu = nombre_objeto
            AND @id_sistema = entidad
  
	 SELECT @sistema = nombre_sistema 
	   FROM VIEW_SISTEMA_CNT
	  WHERE @id_sistema= id_sistema

	SELECT @evento 	= ISNULL( @evento 	, 'EVENTO NO DEFINIDO' )
	,      @menu   	= ISNULL( @menu 	, 'MENU NO DEFINIDO' )
	,      @sistema = ISNULL( @sistema  	, 'SISTEMA NO DEFINIDO' )

	SELECT 	@detalle_final = UPPER(RTRIM(@sistema)) + ' ' + UPPER(RTRIM(@menu)) + ' ' + UPPER(RTRIM(@evento)) + ' ' + UPPER(RTRIM(@DetalleTransac))

        DECLARE @dFechaProceso   DATETIME
            SET @dFechaProceso   = (SELECT acfecproc FROM BacTraderSuda.dbo.MDAC)

	INSERT INTO VIEW_LOG_AUDITORIA
                  ( 	Entidad
                  ,     FechaProceso	
                  ,     FechaSistema	
                  ,     HoraProceso	
                  ,     Terminal	
                  ,     Usuario		
                  ,     Id_Sistema	
                  ,     CodigoMenu	
                  ,     Codigo_Evento	
                  ,     DetalleTransac
                  ,     TablaInvolucrada
                  ,     ValorAntiguo
                  ,     ValorNuevo 
		  )
	VALUES (ISNULL (@Entidad,' ')  		,
		ISNULL (@dFechaProceso,' ') 	,
		CONVERT(CHAR(8),getdate(),112) 	,
		CONVERT(CHAR(8),getdate(),108) 	,
		ISNULL (@Terminal,' ')  	,
		ISNULL (@Usuario,' ')  		,
		ISNULL (@id_Sistema,' ') 	,
		ISNULL (@CodigoMenu,' ') 	,
		ISNULL (@Codigo_Evento,' ') 	,
		ISNULL (@detalle_final,' ') 	,
		ISNULL (@TablaInvolucrada,' ') 	,
		ISNULL (@ValorAntiguo,' ') 	,
		ISNULL (@ValorNuevo,' ')
		)

	SELECT 'OK'

	SET NOCOUNT OFF 

END
GO
