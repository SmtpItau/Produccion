USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ADENDUM_CargaAdendumSwap]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--sp_helptext ADENDUM_GeneraDatosAdendumSWAP 2569, 'Modificada' , '2011-03-08', '00:00:00', 13842499, 13671071 

--ADENDUM_CargaAdendumSwap 2569, 'Modificada' , '2011-03-08', '00:00:00', 13842499, 13671071 

--ADENDUM_CargaAdendumSwap 6065, 'Modificada' , '16-04-2013', '00:00:00', 13842499, 13671071, 7106584, 7106584  

CREATE PROCEDURE [dbo].[ADENDUM_CargaAdendumSwap]
(
	  @nContrato  int  
	, @cEstado  varchar(25) = 'No Modificada'  
	, @dFecha   varchar(10)  
	, @cHora   char(8)   
	, @RutApoderado1 numeric(10)  
	, @RutApoderado2 numeric(10)   
	, @RUTAPODERADOCLI1 numeric(10)  
	, @RUTAPODERADOCLI2  numeric(10)  
)
as 
begin
	
	EXECUTE ADENDUM_GeneraDatosAdendumSWAP @nContrato, @cEstado, @dFecha, @cHora, @RutApoderado1, @RutApoderado2, @RUTAPODERADOCLI1, @RUTAPODERADOCLI2
	
	select * from dbo.ADENDUM_InformacionSWAP ORDER BY ID --WHERE NUMERO_OPERACION = @Num_Operacion
end
GO
