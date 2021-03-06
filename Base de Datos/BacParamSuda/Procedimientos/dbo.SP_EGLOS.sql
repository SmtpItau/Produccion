USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EGLOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Eglos    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_Eglos    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_EGLOS]
                    (@rut  numeric(9),
                                        @cod  numeric(9),
                          @codigo char(35)
     )
AS
BEGIN
set nocount on
 BEGIN TRANSACTION
  
        DELETE ABREVIATURA_CLIENTE WHERE claglosa = @codigo AND @rut=clarutcli
               AND  @cod=clacodigo
  IF @@ERROR<>0
  BEGIN
   ROLLBACK TRANSACTION
                        select  @@ERROR
   RETURN
  END
 COMMIT TRANSACTION
             select 'OK'
set nocount off
END
--select * from Abreviatura_Cliente 
--Sp_Eglos 1,2,'d' 
--seglos  97080000 ,1 ,'AMEX'
--Sp_Eglos  97080000 ,1 ,'AMEX'

GO
