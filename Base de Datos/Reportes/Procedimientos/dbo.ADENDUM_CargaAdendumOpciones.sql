USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[ADENDUM_CargaAdendumOpciones]    Script Date: 16-05-2022 10:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--ADENDUM_CargaAdendumOpciones 861, 'MODIFICADA', '13-02-2013', 1066, 13842499, 13671071, 7106584, 7106584
--sp_helptext ADENDUM_CargaAdendumOpciones 861, 'MODIFICADA', '13-02-2013', 1066, 13842499, 13671071


--ADENDUM_CargaAdendumOpciones 861, 'MODIFICADA', '13-02-2013', 1066, 13842499, 13671071
--ADENDUM_CargaAdendumOpciones 861, 'MODIFICADA', '2013-02-13', 1066, 13842499, 13671071

CREATE PROCEDURE [dbo].[ADENDUM_CargaAdendumOpciones]
(
		@nContrato  int  
	,	@cEstado  varchar(25) = 'No Modificada'  
	,	@dFecha   varchar(10)  
	,	@Folio   numeric(10)   
	,	@RutApoderado1 numeric(10)  
	,	@RutApoderado2 numeric(10)   
	,	@RUTAPODERADOCLI1 numeric(10)  
	,	@RUTAPODERADOCLI2  numeric(10)

)
as 
begin
	
	EXECUTE ADENDUM_GeneraDatosOpciones @nContrato, @cEstado, @dFecha, @Folio, @RutApoderado1, @RutApoderado2, @RUTAPODERADOCLI1, @RUTAPODERADOCLI2
	
	select * from ADENDUM_informacionopciones order by id--WHERE NUMERO_OPERACION = @Num_Operacion
end

GO
