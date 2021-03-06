USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_PERFIL_VARIABLE]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_BORRA_PERFIL_VARIABLE]
  ( @Idsistema   CHAR(3),
    @Usuario     CHAR(20), 
    @FILA        NUMERIC(10) )
AS
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON

 IF @FILA = -1
  BEGIN
   DELETE  PASO_CNT
   WHERE   ID_Sistema  = @Idsistema AND
    Usuario     = @Usuario
  END
 ELSE
  BEGIN
   DELETE PASO_CNT 
   WHERE FILA   = @FILA
     AND ID_SISTEMA = @Idsistema   
     AND USUARIO    =  @Usuario     
  END
 IF @@ERROR <> 0
  BEGIN
   PRINT "FALLA BORRANDO BAC_CNT_PASO."
   SET NOCOUNT OFF
   select "OK"
  END
 
 SELECT "OK"
 SET NOCOUNT OFF
END   /* FIN PROCEDIMIENTO */
-- sp_helptext SP_BORRA_PERFIL_VARIABLE


GO
