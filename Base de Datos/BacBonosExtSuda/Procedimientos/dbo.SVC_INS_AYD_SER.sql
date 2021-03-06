USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_INS_AYD_SER]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_INS_AYD_SER] 
(    
    @COD_NEMO	CHAR 	(20)	,
    @FEC_VEN	DATETIME	
)

AS
BEGIN
	SELECT COD_FAMILIA		,--1
		COD_NEMO		,--2
		NOM_NEMO		,--3
		RUT_EMIS		,--4
		TIPO_TASA 		,--5
		INDICE_BASILEA 		,--6
		PER_CUPONES 		,--7
		NUM_CUPONES 		,--8
		FECHA_EMIS		,--9
		FECHA_VCTO        	,--10
		AFECTO_ENCAJE 		,--11
		TASA_EMIS		,--12                                             
		BASE_TASA_EMI 		,--13
		TASA_VIGENTE            ,--14                              
		FECHA_PRIMER_PAGO       ,--15    
		DIAS_REALES		,--16
		BASE_FLUJO		,--17
		TASA_FIJA		,--18
		'EMISOR' = (SELECT CLNOMBRE 
			    FROM VIEW_CLIENTE 
			    WHERE CLRUT = RUT_EMIS AND CLCODIGO = 1),
		MONTO_EMISION

		FROM	TEXT_SER 
		WHERE 	COD_NEMO = @COD_NEMO 
		AND	@FEC_VEN = FECHA_VCTO

END


GO
