USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALUTA_HABIL]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALUTA_HABIL]
			( @fecha       datetime ,
			  @dias        integer ,
			  @fecha2      datetime output) 

AS 

BEGIN
	declare @fechab datetime
	declare @i	  integer	select @i = 1


	while @i <= @dias
	begin
    		execute Sp_Busca_Fecha_Habil @fecha,1,@fecha output
    		select @i=@i+1
	end


 	select @fecha2 =@fecha

	return 0
END

GO
