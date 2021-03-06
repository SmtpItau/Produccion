USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_CAMPO_PERFIL]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_CAMPO_PERFIL]
                                      ( @codigo_campo     NUMERIC(3),
                                        @sistema          CHAR(3)   ,
                                        @tipo_movimiento  CHAR(3)   ,
                                        @tipo_operacion   CHAR(5)   )
AS 
BEGIN
 SELECT descripcion_campo 
   FROM VIEW_CAMPO_CNT
         WHERE codigo_campo   = @codigo_campo    
    AND id_sistema     = @sistema         
    AND tipo_movimiento = @tipo_movimiento 
    AND tipo_operacion  = @tipo_operacion
END


GO
