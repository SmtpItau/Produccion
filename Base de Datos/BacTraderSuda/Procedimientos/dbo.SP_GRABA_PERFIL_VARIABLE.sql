USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_PERFIL_VARIABLE]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GRABA_PERFIL_VARIABLE](@fila        numeric(10) ,
                                          @valor       char(30)    ,
                                          @cuenta      char(30)    ,
                                          @descripcion char(70)    ,
                                          @perfil      numeric(10) )
as
begin
         set nocount on
insert into VIEW_PASO_CNT values(@fila ,@valor ,@cuenta ,@descripcion,@perfil)
if @@error <> 0
begin
   PRINT 'FALLA AGREGANDO PASO_CNT.'
   set nocount off
   SELECT 'ERR'
   return 1
end
set nocount off
SELECT 'OK'
return 0
end   /* fin procedimiento */
/*
 delete bac_cnt_paso
 select * from sysobjects where name like 'bac%'
 select * from bac_cnt_paso
 sp_graba_perfil_variable 3,'ch','11.01.20.050','banco de a. edwards'
 sp_graba_perfil_variable 3,'ch','11.01.20.050','banco de a. edwards'
*/
--sp_graba_perfil_variable 1,'8','10212115202','divisas adquiridas pend. de transf 48 hrs',303

GO
