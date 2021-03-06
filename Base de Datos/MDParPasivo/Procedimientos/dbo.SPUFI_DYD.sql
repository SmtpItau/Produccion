USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SPUFI_DYD]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE procedure [dbo].[SPUFI_DYD](@nom_spufi varchar(70), @tran_spufi varchar(1023),@tran_validacion varchar(1023),@reg_esp integer) as

declare @linmsg char(100)
declare @reg_mod integer

------INICIO DE LA TRANSACCION--------------------------
begin transaction
exec (@tran_spufi)
select @reg_mod = @@rowcount 
------FIN DE LA TRANSACCION-----------------------------

if @reg_mod=@reg_esp
    COMMIT TRANSACTION 
else 
    ROLLBACK TRANSACTION 

print "*************************************************************************"

if @reg_mod=@reg_esp
	print "* Resultado de SPUFI - EXITOSO -                                        *"
else 
	print "* Resultado de SPUFI - CON ERROR -                                      *"

select @linmsg ="* " + @nom_spufi + "*"                                                       
print @linmsg
select @linmsg = "* Fecha de ejecuci¢n : " + convert(char(20), getdate(), 113) + replicate(" ",29) + "*"
print @linmsg
print "*************************************************************************"
print " "
select @linmsg = "Lineas esperadas a ser alteradas : " + convert(char(10), @reg_esp)
print @linmsg
print "-------------------------------------------------------------------------"
select @linmsg = "lineas que cumplen el criterio   : " + convert(varchar,@reg_mod)
print @linmsg 
print "-------------------------------------------------------------------------"

if @reg_mod=@reg_esp
    select @linmsg = "lineas efectivamente modificadas : " + convert(varchar,@reg_mod)
else 
    select @linmsg = "lineas efectivamente modificadas : 0" 

print @linmsg 

print "-------------------------------------------------------------------------"
if @reg_mod<>@reg_esp
PRINT "************************* SALIDA DE VALIDACION  *************************" 

if @reg_mod<>@reg_esp
PRINT " "

if @reg_mod<>@reg_esp
PRINT @tran_validacion

if @reg_mod<>@reg_esp
EXEC (@tran_validacion)
GO
