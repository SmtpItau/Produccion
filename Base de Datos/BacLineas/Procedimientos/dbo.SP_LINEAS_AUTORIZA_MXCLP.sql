USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_AUTORIZA_MXCLP]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LINEAS_AUTORIZA_MXCLP]
(
	@Sistema 	char(3),
	@operacion 	int
)
as
BEGIN
	if @Sistema = 'BFW'
	begin

		if EXISTS(select * from BacFwdSuda..mfca where canumoper = @operacion and cacodpos1 = 2 AND caestado = ' ' and var_moneda2 = canumoper )
		begin
			update BacFwdSuda..mfca 
			   set caestado = ' ' 
 			 where var_moneda2 = @operacion 
			   and caestado <> ' '
		end 

	end

END
GO
