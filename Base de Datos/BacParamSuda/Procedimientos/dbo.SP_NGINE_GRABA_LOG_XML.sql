USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_GRABA_LOG_XML]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_NGINE_GRABA_LOG_XML] (@log_metodo	varchar(50)	
												,@log_xml		varchar(4000))
AS BEGIN
	SET NOCOUNT ON
		
		INSERT INTO NGINE_LOG_XML
		SELECT 
			CONVERT (varchar(10), GETDATE(), 120)
			,CONVERT(varchar(12), GETDATE(), 108)
			,ISNULL(@log_metodo,'') --> Almacena nombre del método en la clase VB llamada clsCC
			,ISNULL(@log_xml,'')	--> Xml generado
		
	SET NOCOUNT OFF
END
GO
