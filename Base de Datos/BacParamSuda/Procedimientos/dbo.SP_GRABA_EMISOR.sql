USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_EMISOR]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_EMISOR]( @xRut  NUMERIC(9) ,
     @xDv  	CHAR(1)  ,
     @xNombre 	CHAR(40) ,
     @xGeneric 	CHAR(10) ,
     @xDirecc 	CHAR(40) ,
     @xComuna 	NUMERIC(4) ,
     @xTipoE 	CHAR(3)  ,
     @xCodigo 	NUMERIC(5),
     @clasificacion1 char(40),
     @clasificacion2 char(40),
     @tipo_corto1 	char(30),
     @tipo_largo1 char(30),
     @tipo_corto2 char(30),
     @tipo_largo2 char(30)	)
AS
BEGIN
   SET NOCOUNT ON
  IF EXISTS(SELECT 1 FROM Emisor WHERE emrut = @xrut) 
       UPDATE EMISOR SET  emnombre  = @xNombre  ,
   	emgeneric	= @xGeneric  ,
   	emdirecc	= @xDirecc  ,
   	emcomuna	= @xComuna  ,
   	emtipo		= @xTipoE  ,
   	emcodigo	= @xCodigo ,
   	clasificacion1	= @clasificacion1,
   	clasificacion2	= @clasificacion2,
   	tipo_corto1	= @tipo_corto1,
   	tipo_largo1	= @tipo_largo1,
   	tipo_corto2	= @tipo_corto2,
   	tipo_largo2	= @tipo_largo2		
  
   WHERE emrut = @xRut
  ELSE
     INSERT INTO Emisor( emrut  ,
   	emdv  ,
	emnombre ,
	emgeneric ,
	emdirecc ,
	emcomuna ,
	emtipo  ,
	emcodigo,
	clasificacion1,
	clasificacion2,
	tipo_corto1,
	tipo_largo1,
	tipo_corto2,
	tipo_largo2) 
     VALUES(  @xRut  ,
		@xDv  ,
		@xNombre ,
		@xGeneric ,
		@xDirecc ,
		@xComuna ,
		@xTipoE ,
		@xCodigo ,
		@clasificacion1,
		@clasificacion2,
		@tipo_corto1,
		@tipo_largo1,
		@tipo_corto2,
		@tipo_largo2)

IF @@error <> 0  BEGIN
   SET NOCOUNT OFF
       SELECT 'NO'
       RETURN
END
SET NOCOUNT OFF
SELECT 'SI'
END
GO
