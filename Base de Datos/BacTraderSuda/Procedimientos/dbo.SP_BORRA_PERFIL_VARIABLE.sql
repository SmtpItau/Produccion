USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRA_PERFIL_VARIABLE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BORRA_PERFIL_VARIABLE]
               ( @FILA NUMERIC(10) )
AS
BEGIN
   set nocount on
DELETE VIEW_PASO_CNT WHERE fila = @FILA
IF @@ERROR <> 0
BEGIN
   PRINT 'FALLA BORRANDO PASO_CNT.'
   set nocount off
   select 'OK'
   RETURN 1
END
   set nocount off
   RETURN 0
   select 'OK'
END   /* FIN PROCEDIMIENTO */
--SELECT * FROM BAC_CNT_PASO


GO
