USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PERFIL_VARIABLE]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_PERFIL_VARIABLE](
       @Idsistema   CHAR(3)     ,
       @Usuario     CHAR(20)    ,
       @FILA        NUMERIC(10) ,
                                          @VALOR       CHAR(30)    ,
                                          @CUENTA      CHAR(30)    ,
                                          @DESCRIPCION CHAR(70)    ,
                                          @PERFIL      NUMERIC(10)
      )
AS
BEGIN
 SET NOCOUNT ON
 
 INSERT INTO PASO_CNT VALUES(@Idsistema,@Usuario,@FILA ,@VALOR ,@CUENTA ,@DESCRIPCION,@PERFIL)
 
 IF @@ERROR <> 0
 BEGIN
    PRINT 'FALLA AGREGANDO PASO_CNT.'
    SELECT 'ERR'
    SET NOCOUNT OFF  
 END
 
 SELECT 'OK'
 
 SET NOCOUNT OFF
END   /* FIN PROCEDIMIENTO */
GO
