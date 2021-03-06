USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_LOG_AUDITORIA]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_FILTRO_LOG_AUDITORIA]( 
     @OPCION   CHAR(10), 
     @SISTEMA  CHAR(10)
        )
AS BEGIN
SET NOCOUNT ON
 IF @OPCION='USUARIO' 
  SELECT USUARIO FROM USUARIO
 IF @OPCION='TERMINAL'
  SELECT DISTINCT TERMINAL FROM LOG_AUDITORIA
 IF @OPCION='MODULO'
  SELECT id_sistema,nombre_sistema FROM SISTEMA_CNT
 IF @OPCION='ENTIDAD'
  SELECT rccodcar,rcnombre FROM ENTIDAD
   IF @OPCION='MENU'
  SELECT nombre_objeto,nombre_opcion FROM gen_menu WHERE @SISTEMA = entidad
 IF @OPCION='EVENTO'
  SELECT * FROM log_evento
SET NOCOUNT OFF  
END
-- sp_filtro_log_auditoria menu,bcc
-- SELECT * FROM GEN_MENU
-- SELECT * FROM ENTIDAD
-- SELECT * FROM LOG_AUDITORIA WHERE ID_SISTEMA='ADM' order by fechasistema,terminal
-- sp_help log_auditoria
GO
